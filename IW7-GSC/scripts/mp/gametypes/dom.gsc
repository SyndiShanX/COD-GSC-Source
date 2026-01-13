/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dom.gsc
****************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registertimelimitdvar(level.gametype, 30);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 200);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 2);
    scripts\mp\utility::registerroundswitchdvar("dom", 1, 0, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 0);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onspawnplayer = ::onspawnplayer;
  level.lastcaptime = gettime();
  level.onobjectivecomplete = ::onflagcapture;
  level.alliescapturing = [];
  level.axiscapturing = [];
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "domination";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
  thread onplayerconnect();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_dom_flagCaptureTime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_dom_flagsRequiredToScore", getmatchrulesdata("domData", "flagsRequiredToScore"));
  setdynamicdvar("scr_dom_pointsPerFlag", getmatchrulesdata("domData", "pointsPerFlag"));
  setdynamicdvar("scr_dom_flagNeutralization", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("scr_dom_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("dom", 0);
  setdynamicdvar("scr_dom_promode", 0);
}

seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

onstartgametype() {
  seticonnames();
  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_DOM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_DOM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_DOM_HINT");
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  initspawns();
  var_0[0] = "dom";
  scripts\mp\gameobjects::main(var_0);
  thread domflags();
  thread updatedomscores();
  thread removedompoint();
  thread placedompoint();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.flagcapturetime = scripts\mp\utility::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  level.var_6E7B = scripts\mp\utility::dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.var_D649 = scripts\mp\utility::dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility::dvarintvalue("flagNeutralization", 0, 0, 1);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Domination");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility::getotherteam(var_0);
  if(level.usestartspawns) {
    if(game["switchedsides"]) {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_1 + "_start");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
    } else {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_2 + "_start");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_3);
    }
  } else {
    var_4 = getteamdompoints(var_2);
    var_5 = scripts\mp\utility::getotherteam(var_0);
    var_6 = getteamdompoints(var_5);
    var_7 = getpreferreddompoints(var_4, var_6);
    var_2 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_8 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_0);
    var_9 = [];
    var_9["preferredDomPoints"] = var_7;
    var_3 = scripts\mp\spawnscoring::getspawnpoint(var_2, var_8, var_9);
  }

  return var_3;
}

getteamdompoints(var_0) {
  var_1 = [];
  foreach(var_3 in level.domflags) {
    if(var_3.ownerteam == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getpreferreddompoints(var_0, var_1) {
  var_2 = [];
  var_2[0] = 0;
  var_2[1] = 0;
  var_2[2] = 0;
  var_3 = self.pers["team"];
  if(var_0.size == level.domflags.size) {
    var_4 = var_3;
    var_5 = level.bestspawnflag[var_3];
    var_2[var_5.useobj.dompointnumber] = 1;
    return var_2;
  }

  if(var_2.size == 1 && var_3.size == 2 && !scripts\mp\utility::isanymlgmatch()) {
    var_6 = scripts\mp\utility::getotherteam(self.team);
    var_7 = scripts\mp\gamescore::_getteamscore(var_6) - scripts\mp\gamescore::_getteamscore(self.team);
    if(var_7 > 15) {
      var_8 = gettimesincedompointcapture(var_2[0]);
      var_9 = gettimesincedompointcapture(var_3[0]);
      var_0A = gettimesincedompointcapture(var_3[1]);
      if(var_8 > -25536 && var_9 > -25536 && var_0A > -25536) {
        return var_4;
      }
    }
  }

  if(var_2.size > 0) {
    foreach(var_0C in var_2) {
      var_4[var_0C.dompointnumber] = 1;
    }

    return var_4;
  }

  if(var_5.size == 0) {
    var_4 = var_0D;
    var_5 = level.bestspawnflag[var_0D];
    if(var_4.size > 0 && var_4.size < level.domflags.size) {
      var_0D = _meth_81EF(var_0C);
      level.bestspawnflag[var_0C] = var_0D;
    }

    var_5[var_0D.useobj.dompointnumber] = 1;
    return var_5;
  }

  return var_0C;
}

gettimesincedompointcapture(var_0) {
  return gettime() - var_0.capturetime;
}

domflags() {
  scripts\mp\utility::func_98D3();
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_secondary", "targetname");
  if(var_0.size + var_1.size < 2) {
    return;
  }

  level.magicbullet = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    level.magicbullet[level.magicbullet.size] = var_0[var_2];
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level.magicbullet[level.magicbullet.size] = var_1[var_2];
  }

  level.domflags = [];
  level.objectives = level.magicbullet;
  if(level.mapname == "mp_afghan") {
    for(var_2 = 0; var_2 < level.objectives.size; var_2++) {
      if(level.objectives[var_2].script_label == "_c") {
        level.objectives[var_2].script_label = "_b";
        continue;
      }

      if(level.objectives[var_2].script_label == "_b") {
        level.objectives[var_2].script_label = "_c";
      }
    }
  }

  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    var_3 = scripts\mp\gametypes\obj_dom::func_591D(var_2);
    level.magicbullet[var_2].useobj = var_3;
    var_3.levelflag = level.magicbullet[var_2];
    level.domflags[level.domflags.size] = var_3;
  }

  var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var_5 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.areanynavvolumesloaded["allies"] = var_5[0].origin;
  level.areanynavvolumesloaded["axis"] = var_4[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _meth_81EF("allies", undefined);
  level.bestspawnflag["axis"] = _meth_81EF("axis", level.bestspawnflag["allies"]);
  flagsetup();
  thread modifieddefendradiussetup();
}

_meth_81EF(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  for(var_4 = 0; var_4 < level.magicbullet.size; var_4++) {
    var_5 = level.magicbullet[var_4];
    if(var_5 getflagteam() != "neutral") {
      continue;
    }

    var_6 = distancesquared(var_5.origin, level.areanynavvolumesloaded[var_0]);
    if((!isDefined(var_1) || var_5 != var_1) && !isDefined(var_2) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  return var_2;
}

updatedomscores() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  while(!level.gameended) {
    var_2 = getowneddomflags();
    if(!isDefined(level.var_EC50)) {
      level.var_EC50 = [];
    }

    level.var_EC50["allies"] = 0;
    level.var_EC50["axis"] = 0;
    if(var_2.size) {
      for(var_3 = 1; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];
        var_5 = gettime() - var_4.capturetime;
        for(var_6 = var_3 - 1; var_6 >= 0 && var_5 > gettime() - var_2[var_6].capturetime; var_6--) {
          var_2[var_6 + 1] = var_2[var_6];
        }

        var_2[var_6 + 1] = var_4;
      }

      foreach(var_4 in var_2) {
        var_8 = var_4 scripts\mp\gameobjects::getownerteam();
        var_9 = scripts\mp\utility::getotherteam(var_8);
        var_0 = getteamscore(var_8);
        var_1 = getteamscore(var_9);
        var_0A = getteamflagcount(var_8);
        if(var_0A >= level.var_6E7B) {
          level.var_EC50[var_8] = level.var_EC50[var_8] + level.var_D649;
        }
      }
    }

    updatescores();
    checkendgame(var_2.size);
    wait(5);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

updatescores() {
  var_0 = level.roundscorelimit;
  var_1 = game["teamScores"]["allies"] + level.var_EC50["allies"];
  var_2 = game["teamScores"]["axis"] + level.var_EC50["axis"];
  var_3 = var_1 >= var_0;
  var_4 = var_2 >= var_0;
  if(var_3 && !var_4) {
    level.var_EC50["allies"] = var_0 - game["teamScores"]["allies"];
  } else if(var_4 && !var_3) {
    level.var_EC50["axis"] = var_0 - game["teamScores"]["axis"];
  }

  if(level.var_EC50["allies"] > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective("allies", level.var_EC50["allies"], 1);
  }

  if(level.var_EC50["axis"] > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective("axis", level.var_EC50["axis"], 1);
  }
}

checkendgame(var_0) {
  var_1 = gettime() - level.lastcaptime;
  if(scripts\mp\utility::matchmakinggame() && var_0 < 2 && var_1 > 120000) {
    level.var_72B3 = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["time_limit_reached"]);
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isplayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(isDefined(var_4) && scripts\mp\utility::iskillstreakweapon(var_4)) {
    return;
  }

  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = self;
  var_0E = var_0D.team;
  var_0F = var_0D.origin;
  var_10 = var_1.team;
  var_11 = var_1.origin;
  var_12 = 0;
  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  foreach(var_14 in var_1.touchtriggers) {
    if(var_14 != level.magicbullet[0] && var_14 != level.magicbullet[1] && var_14 != level.magicbullet[2]) {
      continue;
    }

    var_15 = var_14.useobj.ownerteam;
    if(var_10 != var_15) {
      if(!var_0A) {
        var_0A = 1;
      }

      continue;
    }
  }

  foreach(var_14 in level.magicbullet) {
    var_15 = var_14.useobj.ownerteam;
    if(var_15 == "neutral") {
      var_18 = var_1 istouching(var_14);
      var_19 = var_0D istouching(var_14);
      if(var_18 || var_19) {
        if(var_14.useobj.claimteam == var_0E) {
          if(!var_0B) {
            if(var_0A) {
              var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0B = 1;
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            thread scripts\mp\matchdata::loginitialstats(var_9, "assaulting");
            continue;
          }
        } else if(var_14.useobj.claimteam == var_10) {
          if(!var_0C) {
            if(var_0A) {
              var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0C = 1;
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            var_1 scripts\mp\utility::incperstat("defends", 1);
            var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
            var_1 scripts\mp\utility::setextrascore1(var_1.pers["defends"]);
            thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(var_15 != var_10) {
      if(!var_0B) {
        var_1A = distsquaredcheck(var_14, var_11, var_0F);
        if(var_1A) {
          if(var_0A) {
            var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
          }

          var_0B = 1;
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          thread scripts\mp\matchdata::loginitialstats(var_9, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var_0C) {
      var_1B = distsquaredcheck(var_14, var_11, var_0F);
      if(var_1B) {
        if(var_0A) {
          var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
        }

        var_0C = 1;
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var_1 scripts\mp\utility::incperstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        var_1 scripts\mp\utility::setextrascore1(var_1.pers["defends"]);
        thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
        continue;
      }
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);
  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck)) {
      return 1;
    }

    if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    }

    return 0;
  }

  return 0;
}

getowneddomflags() {
  var_0 = [];
  foreach(var_2 in level.domflags) {
    if(var_2 scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(var_2.capturetime)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

getteamflagcount(var_0) {
  var_1 = 0;
  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    if(level.domflags[var_2] scripts\mp\gameobjects::getownerteam() == var_0) {
      var_1++;
    }
  }

  return var_1;
}

getflagteam() {
  return self.useobj scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(var_1 in level.domflags) {
    switch (var_1.label) {
      case "_a":
        var_1.dompointnumber = 0;
        break;

      case "_b":
        var_1.dompointnumber = 1;
        break;

      case "_c":
        var_1.dompointnumber = 2;
        break;
    }
  }

  var_3 = level.spawnpoints;
  foreach(var_5 in var_3) {
    var_5.dompointa = 0;
    var_5.dompointb = 0;
    var_5.dompointc = 0;
    var_5.nearflagpoint = getnearestflagpoint(var_5);
    switch (var_5.nearflagpoint.useobj.dompointnumber) {
      case 0:
        var_5.dompointa = 1;
        break;

      case 1:
        var_5.dompointb = 1;
        break;

      case 2:
        var_5.dompointc = 1;
        break;
    }
  }
}

getnearestflagpoint(var_0) {
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;
  foreach(var_5 in level.domflags) {
    var_6 = undefined;
    if(var_1) {
      var_6 = getpathdist(var_0.origin, var_5.levelflag.origin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5.levelflag.origin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2.levelflag;
}

modifieddefendradiussetup() {
  if(level.mapname == "mp_frontier") {
    foreach(var_1 in level.magicbullet) {
      if(var_1.script_label == "_b") {
        var_1.modifieddefendcheck = 1;
      }
    }
  }
}

onspawnplayer() {}

giveflagcapturexp(var_0) {
  level endon("game_ended");
  var_1 = scripts\mp\gameobjects::getearliestclaimplayer();
  if(isDefined(var_1.triggerportableradarping)) {
    var_1 = var_1.triggerportableradarping;
  }

  level.lastcaptime = gettime();
  if(isplayer(var_1)) {
    level thread scripts\mp\utility::teamplayercardsplash("callout_securedposition" + self.label, var_1);
    var_1 thread scripts\mp\matchdata::loggameevent("capture", var_1.origin);
  }

  if(self.firstcapture == 1) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  var_3 = getarraykeys(var_0);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_0[var_3[var_4]].player;
    if(isDefined(var_5.triggerportableradarping)) {
      var_5 = var_5.triggerportableradarping;
    }

    if(!isplayer(var_5)) {
      continue;
    }

    var_5 thread updatecpm();
    var_5 scripts\mp\utility::incperstat("captures", 1);
    var_5 scripts\mp\persistence::statsetchild("round", "captures", var_5.pers["captures"]);
    var_5 scripts\mp\missions::processchallenge("ch_domcap");
    var_5 scripts\mp\utility::setextrascore0(var_5.pers["captures"]);
    if(var_2) {
      if(self.label == "_b") {
        var_5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_b");
      } else {
        var_5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_neutral");
      }
    } else if(level.flagneutralization) {
      var_5 thread scripts\mp\awards::givemidmatchaward("mode_dom_neutralized_cap");
    } else {
      var_5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure");
    }

    var_5 scripts\mp\gametypes\obj_dom::setcrankedtimerdomflag(var_5);
    wait(0.05);
  }
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;
  if(scripts\mp\utility::getminutespassed() < 1) {
    return;
  }

  self.cpm = self.numcaps / scripts\mp\utility::getminutespassed();
}

getcapxpscale() {
  if(self.cpm < 4) {
    return 1;
  }

  return 0.25;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.ui_dom_securing = undefined;
    var_0.ui_dom_stalemate = undefined;
    var_0 thread onplayerspawned();
  }
}

onplayerspawned(var_0) {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned");
    scripts\mp\utility::setextrascore0(0);
    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility::setextrascore0(self.pers["captures"]);
    }

    scripts\mp\utility::setextrascore1(0);
    if(isDefined(self.pers["defends"])) {
      scripts\mp\utility::setextrascore1(self.pers["defends"]);
    }
  }
}

onflagcapture(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.usestartspawns = 0;
  var_6 = scripts\mp\utility::getotherteam(var_3);
  thread scripts\mp\utility::printandsoundoneveryone(var_3, var_6, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_2);
  if(getteamflagcount(var_3) < level.magicbullet.size) {
    scripts\mp\utility::statusdialog("secured" + self.label, var_3, 1);
    scripts\mp\utility::statusdialog("enemy_has" + self.label, var_6, 1);
  } else {
    scripts\mp\utility::statusdialog("secure_all", var_3);
    scripts\mp\utility::statusdialog("lost_all", var_6);
    foreach(var_8 in level.players) {
      if(var_8.team == var_3) {
        var_8 scripts\mp\missions::processchallenge("ch_domdom");
      }
    }
  }

  if(var_5.touchlist[var_3].size == 0) {
    var_5.touchlist = var_5.var_C405;
  }

  var_5 thread giveflagcapturexp(var_5.touchlist[var_3]);
}

removedompoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getdvar("scr_devRemoveDomFlag", "");
      foreach(var_2 in level.domflags) {
        if(isDefined(var_2.label) && var_2.label == var_0) {
          var_2 scripts\mp\gameobjects::allowuse("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2.visibleteam = "none";
          var_2 scripts\mp\gameobjects::setzonestatusicons(undefined);
          var_3 = [];
          for(var_4 = 0; var_4 < level.magicbullet.size; var_4++) {
            if(level.magicbullet[var_4].script_label != var_0) {
              var_3[var_3.size] = level.magicbullet[var_4];
            }
          }

          level.magicbullet = var_3;
          level.objectives = level.magicbullet;
          var_3 = [];
          for(var_4 = 0; var_4 < level.domflags.size; var_4++) {
            if(level.domflags[var_4].label != var_0) {
              var_3[var_3.size] = level.domflags[var_4];
            }
          }

          level.domflags = var_3;
          break;
        }
      }

      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait(1);
  }
}

placedompoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getdvar("scr_devPlaceDomFlag", "");
      var_1 = spawnStruct();
      var_1.origin = level.players[0].origin;
      var_1.angles = level.players[0].angles;
      var_2 = spawn("trigger_radius", var_1.origin, 0, 120, 128);
      var_1.trigger = var_2;
      var_1.trigger.script_label = var_0;
      var_1.ownerteam = "neutral";
      var_3 = var_1.origin + (0, 0, 32);
      var_4 = var_1.origin + (0, 0, -32);
      var_5 = bulletTrace(var_3, var_4, 0, undefined);
      var_1.origin = var_5["position"];
      var_1.upangles = vectortoangles(var_5["normal"]);
      var_1.missionfailed = anglesToForward(var_1.upangles);
      var_1.setdebugorigin = anglestoright(var_1.upangles);
      var_1.visuals[0] = spawn("script_model", var_1.origin);
      var_1.visuals[0].angles = var_1.angles;
      level.magicbullet[level.magicbullet.size] = var_1;
      level.objectives = level.magicbullet;
      var_6 = scripts\mp\gameobjects::createuseobject("neutral", var_1.trigger, var_1.visuals, (0, 0, 100));
      var_6 scripts\mp\gameobjects::allowuse("enemy");
      var_6 scripts\mp\gameobjects::setusetime(10);
      var_6 scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
      var_7 = var_0;
      var_6.label = var_7;
      var_6 scripts\mp\gameobjects::setzonestatusicons(level.icondefend + var_7, level.iconneutral + var_7);
      var_6 scripts\mp\gameobjects::setvisibleteam("any");
      var_6.onuse = ::scripts\mp\gametypes\obj_dom::dompoint_onuse;
      var_6.onbeginuse = ::scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
      var_6.onuseupdate = ::scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
      var_6.onenduse = ::scripts\mp\gametypes\obj_dom::dompoint_onuseend;
      var_6.nousebar = 1;
      var_6.id = "domFlag";
      var_6.firstcapture = 1;
      var_6.claimgracetime = 10000;
      var_6.decayrate = 50;
      var_3 = var_1.visuals[0].origin + (0, 0, 32);
      var_4 = var_1.visuals[0].origin + (0, 0, -32);
      var_8 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_5 = scripts\common\trace::ray_trace(var_3, var_4, var_9, var_8);
      var_6.baseeffectpos = var_5["position"];
      var_0A = vectortoangles(var_5["normal"]);
      var_6.baseeffectforward = anglesToForward(var_0A);
      var_6 scripts\mp\gametypes\obj_dom::initializematchrecording();
      var_6 thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
      for(var_0B = 0; var_0B < level.magicbullet.size; var_0B++) {
        level.magicbullet[var_0B].useobj = var_6;
        var_6.levelflag = level.magicbullet[var_0B];
      }

      level.domflags[level.domflags.size] = var_6;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}