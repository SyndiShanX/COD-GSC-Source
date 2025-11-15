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
  scripts\mp\utility::setobjectivetext("allies", & "OBJECTIVES_DOM");
  scripts\mp\utility::setobjectivetext("axis", & "OBJECTIVES_DOM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_DOM");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_DOM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_DOM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_DOM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", & "OBJECTIVES_DOM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", & "OBJECTIVES_DOM_HINT");
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  initspawns();
  var_00[0] = "dom";
  scripts\mp\gameobjects::main(var_00);
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
  var_00 = self.pers["team"];
  var_01 = scripts\mp\utility::getotherteam(var_00);
  if(level.usestartspawns) {
    if(game["switchedsides"]) {
      var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_01 + "_start");
      var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_02);
    } else {
      var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_02 + "_start");
      var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_03);
    }
  } else {
    var_04 = getteamdompoints(var_02);
    var_05 = scripts\mp\utility::getotherteam(var_00);
    var_06 = getteamdompoints(var_05);
    var_07 = getpreferreddompoints(var_04, var_06);
    var_02 = scripts\mp\spawnlogic::getteamspawnpoints(var_00);
    var_08 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_00);
    var_09 = [];
    var_09["preferredDomPoints"] = var_07;
    var_03 = scripts\mp\spawnscoring::getspawnpoint(var_02, var_08, var_09);
  }

  return var_03;
}

getteamdompoints(param_00) {
  var_01 = [];
  foreach(var_03 in level.domflags) {
    if(var_03.ownerteam == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

getpreferreddompoints(param_00, param_01) {
  var_02 = [];
  var_02[0] = 0;
  var_02[1] = 0;
  var_02[2] = 0;
  var_03 = self.pers["team"];
  if(param_00.size == level.domflags.size) {
    var_04 = var_03;
    var_05 = level.bestspawnflag[var_03];
    var_02[var_05.useobj.dompointnumber] = 1;
    return var_02;
  }

  if(var_02.size == 1 && var_03.size == 2 && !scripts\mp\utility::isanymlgmatch()) {
    var_06 = scripts\mp\utility::getotherteam(self.team);
    var_07 = scripts\mp\gamescore::_getteamscore(var_06) - scripts\mp\gamescore::_getteamscore(self.team);
    if(var_07 > 15) {
      var_08 = gettimesincedompointcapture(var_02[0]);
      var_09 = gettimesincedompointcapture(var_03[0]);
      var_0A = gettimesincedompointcapture(var_03[1]);
      if(var_08 > -25536 && var_09 > -25536 && var_0A > -25536) {
        return var_04;
      }
    }
  }

  if(var_02.size > 0) {
    foreach(var_0C in var_02) {
      var_04[var_0C.dompointnumber] = 1;
    }

    return var_04;
  }

  if(var_05.size == 0) {
    var_04 = var_0D;
    var_05 = level.bestspawnflag[var_0D];
    if(var_04.size > 0 && var_04.size < level.domflags.size) {
      var_0D = _meth_81EF(var_0C);
      level.bestspawnflag[var_0C] = var_0D;
    }

    var_05[var_0D.useobj.dompointnumber] = 1;
    return var_05;
  }

  return var_0C;
}

gettimesincedompointcapture(param_00) {
  return gettime() - param_00.capturetime;
}

domflags() {
  scripts\mp\utility::func_98D3();
  var_00 = getEntArray("flag_primary", "targetname");
  var_01 = getEntArray("flag_secondary", "targetname");
  if(var_00.size + var_01.size < 2) {
    return;
  }

  level.magicbullet = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    level.magicbullet[level.magicbullet.size] = var_00[var_02];
  }

  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    level.magicbullet[level.magicbullet.size] = var_01[var_02];
  }

  level.domflags = [];
  level.objectives = level.magicbullet;
  if(level.mapname == "mp_afghan") {
    for(var_02 = 0; var_02 < level.objectives.size; var_02++) {
      if(level.objectives[var_02].script_label == "_c") {
        level.objectives[var_02].script_label = "_b";
        continue;
      }

      if(level.objectives[var_02].script_label == "_b") {
        level.objectives[var_02].script_label = "_c";
      }
    }
  }

  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    var_03 = scripts\mp\gametypes\obj_dom::func_591D(var_02);
    level.magicbullet[var_02].useobj = var_03;
    var_03.levelflag = level.magicbullet[var_02];
    level.domflags[level.domflags.size] = var_03;
  }

  var_04 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var_05 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.areanynavvolumesloaded["allies"] = var_05[0].origin;
  level.areanynavvolumesloaded["axis"] = var_04[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _meth_81EF("allies", undefined);
  level.bestspawnflag["axis"] = _meth_81EF("axis", level.bestspawnflag["allies"]);
  flagsetup();
  thread modifieddefendradiussetup();
}

_meth_81EF(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  for(var_04 = 0; var_04 < level.magicbullet.size; var_04++) {
    var_05 = level.magicbullet[var_04];
    if(var_05 getflagteam() != "neutral") {
      continue;
    }

    var_06 = distancesquared(var_05.origin, level.areanynavvolumesloaded[param_00]);
    if((!isDefined(param_01) || var_05 != param_01) && !isDefined(var_02) || var_06 < var_03) {
      var_03 = var_06;
      var_02 = var_05;
    }
  }

  return var_02;
}

updatedomscores() {
  level endon("game_ended");
  var_00 = undefined;
  var_01 = undefined;
  while(!level.gameended) {
    var_02 = getowneddomflags();
    if(!isDefined(level.var_EC50)) {
      level.var_EC50 = [];
    }

    level.var_EC50["allies"] = 0;
    level.var_EC50["axis"] = 0;
    if(var_02.size) {
      for(var_03 = 1; var_03 < var_02.size; var_03++) {
        var_04 = var_02[var_03];
        var_05 = gettime() - var_04.capturetime;
        for(var_06 = var_03 - 1; var_06 >= 0 && var_05 > gettime() - var_02[var_06].capturetime; var_06--) {
          var_02[var_06 + 1] = var_02[var_06];
        }

        var_02[var_06 + 1] = var_04;
      }

      foreach(var_04 in var_02) {
        var_08 = var_04 scripts\mp\gameobjects::getownerteam();
        var_09 = scripts\mp\utility::getotherteam(var_08);
        var_00 = getteamscore(var_08);
        var_01 = getteamscore(var_09);
        var_0A = getteamflagcount(var_08);
        if(var_0A >= level.var_6E7B) {
          level.var_EC50[var_08] = level.var_EC50[var_08] + level.var_D649;
        }
      }
    }

    updatescores();
    checkendgame(var_02.size);
    wait(5);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

updatescores() {
  var_00 = level.roundscorelimit;
  var_01 = game["teamScores"]["allies"] + level.var_EC50["allies"];
  var_02 = game["teamScores"]["axis"] + level.var_EC50["axis"];
  var_03 = var_01 >= var_00;
  var_04 = var_02 >= var_00;
  if(var_03 && !var_04) {
    level.var_EC50["allies"] = var_00 - game["teamScores"]["allies"];
  } else if(var_04 && !var_03) {
    level.var_EC50["axis"] = var_00 - game["teamScores"]["axis"];
  }

  if(level.var_EC50["allies"] > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective("allies", level.var_EC50["allies"], 1);
  }

  if(level.var_EC50["axis"] > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective("axis", level.var_EC50["axis"], 1);
  }
}

checkendgame(param_00) {
  var_01 = gettime() - level.lastcaptime;
  if(scripts\mp\utility::matchmakinggame() && param_00 < 2 && var_01 > 120000) {
    level.var_72B3 = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["time_limit_reached"]);
  }
}

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isplayer(param_01) || param_01.team == self.team) {
    return;
  }

  if(isDefined(param_04) && scripts\mp\utility::iskillstreakweapon(param_04)) {
    return;
  }

  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = self;
  var_0E = var_0D.team;
  var_0F = var_0D.origin;
  var_10 = param_01.team;
  var_11 = param_01.origin;
  var_12 = 0;
  if(isDefined(param_00)) {
    var_11 = param_00.origin;
    var_12 = param_00 == param_01;
  }

  foreach(var_14 in param_01.touchtriggers) {
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
      var_18 = param_01 istouching(var_14);
      var_19 = var_0D istouching(var_14);
      if(var_18 || var_19) {
        if(var_14.useobj.claimteam == var_0E) {
          if(!var_0B) {
            if(var_0A) {
              param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0B = 1;
            param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            thread scripts\mp\matchdata::loginitialstats(param_09, "assaulting");
            continue;
          }
        } else if(var_14.useobj.claimteam == var_10) {
          if(!var_0C) {
            if(var_0A) {
              param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0C = 1;
            param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            param_01 scripts\mp\utility::incperstat("defends", 1);
            param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
            param_01 scripts\mp\utility::setextrascore1(param_01.pers["defends"]);
            thread scripts\mp\matchdata::loginitialstats(param_09, "defending");
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
            param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
          }

          var_0B = 1;
          param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          thread scripts\mp\matchdata::loginitialstats(param_09, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var_0C) {
      var_1B = distsquaredcheck(var_14, var_11, var_0F);
      if(var_1B) {
        if(var_0A) {
          param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
        }

        var_0C = 1;
        param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        param_01 scripts\mp\utility::incperstat("defends", 1);
        param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
        param_01 scripts\mp\utility::setextrascore1(param_01.pers["defends"]);
        thread scripts\mp\matchdata::loginitialstats(param_09, "defending");
        continue;
      }
    }
  }
}

distsquaredcheck(param_00, param_01, param_02) {
  var_03 = distancesquared(param_00.origin, param_01);
  var_04 = distancesquared(param_00.origin, param_02);
  if(var_03 < 105625 || var_04 < 105625) {
    if(!isDefined(param_00.modifieddefendcheck)) {
      return 1;
    }

    if(param_01[2] - param_00.origin[2] < 100 || param_02[2] - param_00.origin[2] < 100) {
      return 1;
    }

    return 0;
  }

  return 0;
}

getowneddomflags() {
  var_00 = [];
  foreach(var_02 in level.domflags) {
    if(var_02 scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(var_02.capturetime)) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

getteamflagcount(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    if(level.domflags[var_02] scripts\mp\gameobjects::getownerteam() == param_00) {
      var_01++;
    }
  }

  return var_01;
}

getflagteam() {
  return self.useobj scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(var_01 in level.domflags) {
    switch (var_01.label) {
      case "_a":
        var_01.dompointnumber = 0;
        break;

      case "_b":
        var_01.dompointnumber = 1;
        break;

      case "_c":
        var_01.dompointnumber = 2;
        break;
    }
  }

  var_03 = level.spawnpoints;
  foreach(var_05 in var_03) {
    var_05.dompointa = 0;
    var_05.dompointb = 0;
    var_05.dompointc = 0;
    var_05.nearflagpoint = getnearestflagpoint(var_05);
    switch (var_05.nearflagpoint.useobj.dompointnumber) {
      case 0:
        var_05.dompointa = 1;
        break;

      case 1:
        var_05.dompointb = 1;
        break;

      case 2:
        var_05.dompointc = 1;
        break;
    }
  }
}

getnearestflagpoint(param_00) {
  var_01 = scripts\mp\spawnlogic::ispathdataavailable();
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.domflags) {
    var_06 = undefined;
    if(var_01) {
      var_06 = getpathdist(param_00.origin, var_05.levelflag.origin, 999999);
    }

    if(!isDefined(var_06) || var_06 == -1) {
      var_06 = distancesquared(var_05.levelflag.origin, param_00.origin);
    }

    if(!isDefined(var_02) || var_06 < var_03) {
      var_02 = var_05;
      var_03 = var_06;
    }
  }

  return var_02.levelflag;
}

modifieddefendradiussetup() {
  if(level.mapname == "mp_frontier") {
    foreach(var_01 in level.magicbullet) {
      if(var_01.script_label == "_b") {
        var_01.modifieddefendcheck = 1;
      }
    }
  }
}

onspawnplayer() {}

giveflagcapturexp(param_00) {
  level endon("game_ended");
  var_01 = scripts\mp\gameobjects::getearliestclaimplayer();
  if(isDefined(var_01.triggerportableradarping)) {
    var_01 = var_01.triggerportableradarping;
  }

  level.lastcaptime = gettime();
  if(isplayer(var_01)) {
    level thread scripts\mp\utility::teamplayercardsplash("callout_securedposition" + self.label, var_01);
    var_01 thread scripts\mp\matchdata::loggameevent("capture", var_01.origin);
  }

  if(self.firstcapture == 1) {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  var_03 = getarraykeys(param_00);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_05 = param_00[var_03[var_04]].player;
    if(isDefined(var_05.triggerportableradarping)) {
      var_05 = var_05.triggerportableradarping;
    }

    if(!isplayer(var_05)) {
      continue;
    }

    var_05 thread updatecpm();
    var_05 scripts\mp\utility::incperstat("captures", 1);
    var_05 scripts\mp\persistence::statsetchild("round", "captures", var_05.pers["captures"]);
    var_05 scripts\mp\missions::processchallenge("ch_domcap");
    var_05 scripts\mp\utility::setextrascore0(var_05.pers["captures"]);
    if(var_02) {
      if(self.label == "_b") {
        var_05 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_b");
      } else {
        var_05 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_neutral");
      }
    } else if(level.flagneutralization) {
      var_05 thread scripts\mp\awards::givemidmatchaward("mode_dom_neutralized_cap");
    } else {
      var_05 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure");
    }

    var_05 scripts\mp\gametypes\obj_dom::setcrankedtimerdomflag(var_05);
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
    level waittill("connected", var_00);
    var_00.ui_dom_securing = undefined;
    var_00.ui_dom_stalemate = undefined;
    var_00 thread onplayerspawned();
  }
}

onplayerspawned(param_00) {
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

onflagcapture(param_00, param_01, param_02, param_03, param_04, param_05) {
  level.usestartspawns = 0;
  var_06 = scripts\mp\utility::getotherteam(param_03);
  thread scripts\mp\utility::printandsoundoneveryone(param_03, var_06, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", param_02);
  if(getteamflagcount(param_03) < level.magicbullet.size) {
    scripts\mp\utility::statusdialog("secured" + self.label, param_03, 1);
    scripts\mp\utility::statusdialog("enemy_has" + self.label, var_06, 1);
  } else {
    scripts\mp\utility::statusdialog("secure_all", param_03);
    scripts\mp\utility::statusdialog("lost_all", var_06);
    foreach(var_08 in level.players) {
      if(var_08.team == param_03) {
        var_08 scripts\mp\missions::processchallenge("ch_domdom");
      }
    }
  }

  if(param_05.touchlist[param_03].size == 0) {
    param_05.touchlist = param_05.var_C405;
  }

  param_05 thread giveflagcapturexp(param_05.touchlist[param_03]);
}

removedompoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_00 = getdvar("scr_devRemoveDomFlag", "");
      foreach(var_02 in level.domflags) {
        if(isDefined(var_02.label) && var_02.label == var_00) {
          var_02 scripts\mp\gameobjects::allowuse("none");
          var_02.trigger = undefined;
          var_02 notify("deleted");
          var_02.visibleteam = "none";
          var_02 scripts\mp\gameobjects::setzonestatusicons(undefined);
          var_03 = [];
          for(var_04 = 0; var_04 < level.magicbullet.size; var_04++) {
            if(level.magicbullet[var_04].script_label != var_00) {
              var_03[var_03.size] = level.magicbullet[var_04];
            }
          }

          level.magicbullet = var_03;
          level.objectives = level.magicbullet;
          var_03 = [];
          for(var_04 = 0; var_04 < level.domflags.size; var_04++) {
            if(level.domflags[var_04].label != var_00) {
              var_03[var_03.size] = level.domflags[var_04];
            }
          }

          level.domflags = var_03;
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
      var_00 = getdvar("scr_devPlaceDomFlag", "");
      var_01 = spawnStruct();
      var_01.origin = level.players[0].origin;
      var_01.angles = level.players[0].angles;
      var_02 = spawn("trigger_radius", var_01.origin, 0, 120, 128);
      var_01.trigger = var_02;
      var_01.trigger.script_label = var_00;
      var_01.ownerteam = "neutral";
      var_03 = var_01.origin + (0, 0, 32);
      var_04 = var_01.origin + (0, 0, -32);
      var_05 = bulletTrace(var_03, var_04, 0, undefined);
      var_01.origin = var_05["position"];
      var_01.upangles = vectortoangles(var_05["normal"]);
      var_01.missionfailed = anglesToForward(var_01.upangles);
      var_01.setdebugorigin = anglestoright(var_01.upangles);
      var_01.visuals[0] = spawn("script_model", var_01.origin);
      var_01.visuals[0].angles = var_01.angles;
      level.magicbullet[level.magicbullet.size] = var_01;
      level.objectives = level.magicbullet;
      var_06 = scripts\mp\gameobjects::createuseobject("neutral", var_01.trigger, var_01.visuals, (0, 0, 100));
      var_06 scripts\mp\gameobjects::allowuse("enemy");
      var_06 scripts\mp\gameobjects::setusetime(10);
      var_06 scripts\mp\gameobjects::setusetext( & "MP_SECURING_POSITION");
      var_07 = var_00;
      var_06.label = var_07;
      var_06 scripts\mp\gameobjects::setzonestatusicons(level.icondefend + var_07, level.iconneutral + var_07);
      var_06 scripts\mp\gameobjects::setvisibleteam("any");
      var_06.onuse = ::scripts\mp\gametypes\obj_dom::dompoint_onuse;
      var_06.onbeginuse = ::scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
      var_06.onuseupdate = ::scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
      var_06.onenduse = ::scripts\mp\gametypes\obj_dom::dompoint_onuseend;
      var_06.nousebar = 1;
      var_06.id = "domFlag";
      var_06.firstcapture = 1;
      var_06.claimgracetime = 10000;
      var_06.decayrate = 50;
      var_03 = var_01.visuals[0].origin + (0, 0, 32);
      var_04 = var_01.visuals[0].origin + (0, 0, -32);
      var_08 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_09 = [];
      var_05 = scripts\common\trace::ray_trace(var_03, var_04, var_09, var_08);
      var_06.baseeffectpos = var_05["position"];
      var_0A = vectortoangles(var_05["normal"]);
      var_06.baseeffectforward = anglesToForward(var_0A);
      var_06 scripts\mp\gametypes\obj_dom::initializematchrecording();
      var_06 thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
      for(var_0B = 0; var_0B < level.magicbullet.size; var_0B++) {
        level.magicbullet[var_0B].useobj = var_06;
        var_06.levelflag = level.magicbullet[var_0B];
      }

      level.domflags[level.domflags.size] = var_06;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}