/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dom.gsc
**************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 30);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 300);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.teambased = 1;
  level.allowneutral = 0;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onspawnplayer = ::onspawnplayer;
  level.domroundstarttime = gettime();
  level.allowboostingabovetriggerradius = 1;
  level.domcapturetime = maps\mp\_utility::getfloatproperty("scr_dom_capture_time", 10);
  level.threecaptime["axis"]["time"] = 0;
  level.threecaptime["axis"]["awarded"] = 0;
  level.threecaptime["allies"]["time"] = 0;
  level.threecaptime["allies"]["awarded"] = 0;
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.dom = spawnStruct();

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "dom_intro";

  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";

  if(maps\mp\_utility::isgrapplinghookgamemode()) {
    game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
  }
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_dom_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("dom", 1);
  setdynamicdvar("scr_dom_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("dom", 1);
  setdynamicdvar("scr_dom_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("dom", 1);
  setdynamicdvar("scr_dom_capture_time", getmatchrulesdata("domData", "captureTime"));
  setdynamicdvar("scr_dom_allowNeutral", getmatchrulesdata("domData", "allowNeutral"));
  setdynamicdvar("scr_dom_halftimeswitchsides", getmatchrulesdata("domData", "halfTimeSwitchSides"));
}

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(game["status"] == "halftime") {
    setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    setomnvar("ui_current_round", 4);
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DOM");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DOM_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DOM_HINT");
  setclientnamemode("auto_change");
  initspawns();
  precacheflags();
  var_2[0] = "dom";
  maps\mp\gametypes\_gameobjects::main(var_2);
  setomnvar("ui_mlg_game_mode_status_1", 0);
  setomnvar("ui_mlg_game_mode_status_2", 0);
  setomnvar("ui_mlg_game_mode_status_3", 0);
  level thread domflags();
  level thread updatedomscores();
  level thread updatemlgobjectives();
  level thread updatescoreboarddom();
  level.halftime_switch_sides = maps\mp\_utility::dvarintvalue("halftimeswitchsides", 1, 0, 1);
  level.allowneutral = maps\mp\_utility::dvarintvalue("allowNeutral", 0, 0, 1);
}

updatescoreboarddom() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread updatecaptues();
    var_0 thread updatedefends();
  }
}

updatecaptues() {
  waittillframeend;
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

updatedefends() {
  waittillframeend;
  maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

updatemlgobjectives() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      var_1.objective = 0;

      foreach(var_3 in level.domflags) {
        if(var_1 istouching(var_3.levelflag)) {
          if(var_3.numtouching["axis"] * var_3.numtouching["allies"] > 0) {
            var_1.objective = 1;
          } else if(var_3.ownerteam == "neutral") {
            if(var_1.team == "allies") {
              var_1.objective = 2;
            } else {
              var_1.objective = 3;
            }
          } else if(var_3.ownerteam == "allies") {
            if(var_1.team == "allies") {
              var_1.objective = 4;
            } else {
              var_1.objective = 5;
            }
          } else if(var_3.ownerteam == "axis") {
            if(var_1.team == "axis") {
              var_1.objective = 6;
            } else {
              var_1.objective = 7;
            }
          }

          if(var_1.objective > 0) {
            if(var_3.label == "_b") {
              var_1.objective = var_1.objective + 7;
              continue;
            }

            if(var_3.label == "_c") {
              var_1.objective = var_1.objective + 14;
            }
          }
        }
      }
    }

    wait 0.05;
  }
}

precacheflags() {
  game["neutral"] = "neutral";
  level.flagbasemodel = "flag_holo_base_ground";
  level.flagfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_sentinel_friendly");
  level.flagfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_sentinel_enemy");
  level.flagfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_atlas_friendly");
  level.flagfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_atlas_enemy");
  level.flagfxid["neutral"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_neutral");
  level.flagfxid["neutral"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_neutral");
  level.boarderfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level.boarderfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level.boarderfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level.boarderfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level.boarderfxid["neutral"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom_white");
  level.boarderfxid["neutral"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_white");
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  level.spawn_name = "mp_dom_spawn";
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", level.spawn_name);
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", level.spawn_name);
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(level.usestartspawns && level.ingraceperiod) {
    if(game["switchedsides"]) {
      var_0 = maps\mp\_utility::getotherteam(var_0);
    }

    var_1 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_0 + "_start");
    var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_3 = getteamdompoints(var_0);
    var_4 = maps\mp\_utility::getotherteam(var_0);
    var_5 = getteamdompoints(var_4);
    var_6 = getprefereddompoints(var_3, var_5);
    var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_domination(var_1, var_6);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_2);
  return var_2;
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

getprefereddompoints(var_0, var_1) {
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

  if(var_0.size == 1 && var_1.size == 2) {
    var_6 = maps\mp\_utility::getotherteam(self.team);
    var_7 = maps\mp\gametypes\_gamescore::_getteamscore(var_6) - maps\mp\gametypes\_gamescore::_getteamscore(self.team);

    if(var_7 > 25) {
      var_8 = gettimesincedompointcapture(var_0[0]);
      var_9 = gettimesincedompointcapture(var_1[0]);
      var_10 = gettimesincedompointcapture(var_1[1]);

      if(var_8 > 80000 && var_9 > 80000 && var_10 > 80000) {
        return var_2;
      }
    }
  }

  if(var_0.size > 0) {
    foreach(var_12 in var_0) {
      var_2[var_12.dompointnumber] = 1;
    }

    return var_2;
  } else {
    var_4 = var_3;
    var_6 = maps\mp\_utility::getotherteam(var_4);
    var_5 = level.bestspawnflag[var_4];

    if(var_1.size > 0 && var_1.size < level.domflags.size) {
      var_5 = getunownedflagneareststart(var_4, undefined, 0);
      level.bestspawnflag[var_4] = var_5;
    }

    if(var_5 == level.bestspawnflag[var_6]) {
      var_5 = getunownedflagneareststart(var_4, level.bestspawnflag[var_6], 1);
      level.bestspawnflag[var_4] = var_5;
    }

    var_2[var_5.useobj.dompointnumber] = 1;
    return var_2;
  }

  return var_2;
}

gettimesincedompointcapture(var_0) {
  return gettime() - var_0.capturetime;
}

domflags() {
  level.laststatus["allies"] = 0;
  level.laststatus["axis"] = 0;
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_primary_augmented", "targetname");

  if(var_0.size < 2) {
    return;
  }
  if(maps\mp\_utility::isaugmentedgamemode()) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2].script_label;

      for(var_4 = 0; var_4 < var_0.size; var_4++) {
        if(var_0[var_4].script_label == var_3) {
          var_0[var_4] delete();
          break;
        }
      }
    }
  } else {
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_1[var_5] delete();
    }
  }

  level.flags = [];
  level.flags = common_scripts\utility::array_combine(var_0, var_1);
  level.domflags = [];

  for(var_5 = 0; var_5 < level.flags.size; var_5++) {
    var_6 = level.flags[var_5];

    if(isDefined(var_6.target)) {
      var_7[0] = getent(var_6.target, "targetname");
    } else {
      var_7[0] = spawn("script_model", var_6.origin);
      var_7[0].angles = var_6.angles;
    }

    var_7[0] setModel(level.flagbasemodel);
    var_8 = maps\mp\gametypes\_gameobjects::createuseobject("neutral", var_6, var_7, (0, 0, 100));
    var_8 maps\mp\gametypes\_gameobjects::allowuse("enemy");
    var_8 maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime);
    var_8 maps\mp\gametypes\_gameobjects::setusetext(&"MP_SECURING_POSITION");
    var_9 = var_8 maps\mp\gametypes\_gameobjects::getlabel();
    var_8.label = var_9;
    var_8 maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_captureneutral" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_white" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_white" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    var_8.onuse = ::onuse;
    var_8.onbeginuse = ::onbeginuse;
    var_8.onuseupdate = ::onuseupdate;
    var_8.onenduse = ::onenduse;
    var_8.nousebar = 1;
    var_8.id = "domFlag";
    var_8.has_been_captured = 0;
    var_8.firstcapture = 1;
    var_10 = var_7[0].origin + (0, 0, 32);
    var_11 = var_7[0].origin + (0, 0, -32);
    var_12 = bulletTrace(var_10, var_11, 0, var_7[0]);
    var_13 = vectortoangles(var_12["normal"]);
    var_8.baseeffectforward = anglesToForward(var_13);
    var_8.baseeffectright = anglestoright(var_13);
    var_8.baseeffectpos = var_12["position"];
    var_7[0].origin = var_12["position"];
    var_8 thread updatevisuals(1);
    level.flags[var_5].useobj = var_8;
    var_8.levelflag = level.flags[var_5];
    level.domflags[level.domflags.size] = var_8;
  }

  var_14 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var_15 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = var_15[0].origin;
  level.startpos["axis"] = var_14[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = getunownedflagneareststart("allies", undefined, 0);
  level.bestspawnflag["axis"] = getunownedflagneareststart("axis", level.bestspawnflag["allies"], 0);
  flagsetup();
}

getunownedflagneareststart(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  for(var_5 = 0; var_5 < level.flags.size; var_5++) {
    var_6 = level.flags[var_5];

    if(!var_2 && var_6 getflagteam() != "neutral") {
      continue;
    }
    var_7 = distancesquared(var_6.origin, level.startpos[var_0]);

    if((!isDefined(var_1) || var_6 != var_1) && (!isDefined(var_3) || var_7 < var_4)) {
      var_4 = var_7;
      var_3 = var_6;
    }
  }

  return var_3;
}

onbeginuse(var_0) {
  var_1 = maps\mp\gametypes\_gameobjects::getownerteam();
  self.didstatusnotify = 0;
  maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime);

  if(var_1 == "neutral") {
    statusdialog("securing" + self.label, var_0.team);

    if(self.firstcapture || self.curprogress == 0) {
      maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime / 2);
    }
  } else {
    if(var_1 == "allies") {
      level.alliescapturing[level.alliescapturing.size] = self.label;
      var_2 = "axis";
      return;
    }

    level.axiscapturing[level.axiscapturing.size] = self.label;
    var_2 = "allies";
  }
}

onuseupdate(var_0, var_1, var_2) {
  var_3 = maps\mp\gametypes\_gameobjects::getownerteam();

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_3 == "neutral") {
      statusdialog("securing" + self.label, var_0);
      self.prevownerteam = maps\mp\_utility::getotherteam(var_0);

      if(var_0 == "allies") {
        maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_blue_taking" + self.label);
        maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_blue_taking" + self.label);
      } else {
        maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_red_taking" + self.label);
        maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_red_taking" + self.label);
      }
    } else {
      statusdialog("losing" + self.label, var_3, 1);
      statusdialog("securing" + self.label, var_0);

      if(var_3 == "allies") {
        maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_blue_losing" + self.label);
        maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_blue_losing" + self.label);
      } else {
        maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_red_losing" + self.label);
        maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_red_losing" + self.label);
      }
    }

    maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_taking" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_taking" + self.label);
    maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_losing" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_losing" + self.label);
    self.didstatusnotify = 1;
  } else if(level.allowneutral && var_1 > 0.49 && var_2 && self.didstatusnotify && var_3 != "neutral") {
    maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    updatevisuals();
    statusdialog("lost" + self.label, var_3, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_0);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_3);
    updateuiflagomnvars(self.label, "neutral");
    thread giveflagneutralizexp(self.touchlist[var_0]);
  }
}

statusdialog(var_0, var_1, var_2) {
  var_3 = gettime();

  if(gettime() < level.laststatus[var_1] + 5000 && (!isDefined(var_2) || !var_2)) {
    return;
  }
  thread delayedleaderdialog(var_0, var_1);
  level.laststatus[var_1] = gettime();
}

onenduse(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_capture_icon", 0);
  }

  var_3 = maps\mp\gametypes\_gameobjects::getownerteam();

  if(var_3 != "neutral") {
    maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_capture" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_capture" + self.label);
    maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + self.label);

    if(var_3 == "allies") {
      maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_blue" + self.label);
      maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_blue" + self.label);
    } else {
      maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_red" + self.label);
      maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_red" + self.label);
    }
  } else {
    maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_captureneutral" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral" + self.label);
    maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_captureneutral" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_captureneutral" + self.label);
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_white" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_white" + self.label);
  }

  if(var_0 == "allies") {
    common_scripts\utility::array_remove(level.alliescapturing, self.label);
  } else {
    common_scripts\utility::array_remove(level.alliescapturing, self.label);
  }
}

updatevisuals(var_0) {
  if(isDefined(var_0) && var_0) {
    waittillframeend;
  }

  if(!isremovedentity(self.visuals[0])) {
    var_1 = self.visuals[0];
    friendlyenemyeffects(var_1.origin, anglestoup(var_1.angles));
  }
}

friendlyenemyeffects(var_0, var_1) {
  var_2 = self.ownerteam;
  var_3 = level.flagfxid[game[var_2]]["friendly"];
  var_4 = level.boarderfxid[game[var_2]]["friendly"];
  var_5 = level.flagfxid[game[var_2]]["enemy"];
  var_6 = level.boarderfxid[game[var_2]]["enemy"];
  friendlyenemyeffectsstop();
  self.friendlyflagfxid = maps\mp\_utility::spawnfxshowtoteam(var_3, var_2, var_0, var_1);
  self.friendlyboarderfxid = maps\mp\_utility::spawnfxshowtoteam(var_4, var_2, var_0, var_1);
  self.enemyflagfxid = maps\mp\_utility::spawnfxshowtoteam(var_5, maps\mp\_utility::getotherteam(var_2), var_0, var_1);
  self.enemyboarderfxid = maps\mp\_utility::spawnfxshowtoteam(var_6, maps\mp\_utility::getotherteam(var_2), var_0, var_1);
}

friendlyenemyeffectsstop() {
  if(isDefined(self.friendlyflagfxid)) {
    self.friendlyflagfxid delete();
  }

  if(isDefined(self.friendlyboarderfxid)) {
    self.friendlyboarderfxid delete();
  }

  if(isDefined(self.enemyflagfxid)) {
    self.enemyflagfxid delete();
  }

  if(isDefined(self.enemyboarderfxid)) {
    self.enemyboarderfxid delete();
  }
}

updateuiflagomnvars(var_0, var_1) {
  var_2 = "ui_mlg_game_mode_status_1";

  if(var_0 == "_b") {
    var_2 = "ui_mlg_game_mode_status_2";
  }

  if(var_0 == "_c") {
    var_2 = "ui_mlg_game_mode_status_3";
  }

  if(var_1 == "allies") {
    setomnvar(var_2, -1);
  } else if(var_1 == "axis") {
    setomnvar(var_2, 1);
  } else {
    setomnvar(var_2, 0);
  }
}

onuse(var_0) {
  var_1 = var_0.team;
  var_2 = maps\mp\gametypes\_gameobjects::getownerteam();
  var_3 = maps\mp\gametypes\_gameobjects::getlabel();
  var_4 = 0;

  if(self.firstcapture && var_3 == "_b") {
    var_4 = 1;
  }

  self.capturetime = gettime();
  self.firstcapture = 0;
  self.has_been_captured = 1;

  if(isDefined(self.ownedtheentiregame)) {
    self.ownedtheentireround = 0;
  } else {
    self.ownedtheentireround = 1;
  }

  maps\mp\gametypes\_gameobjects::setownerteam(var_1);
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_capture" + var_3);
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_capture" + var_3);
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + self.label);
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + self.label);

  if(var_1 == "allies") {
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_blue" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_blue" + self.label);
  } else {
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_red" + self.label);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_red" + self.label);
  }

  updatevisuals();
  level.usestartspawns = 0;

  if(var_2 == "neutral") {
    var_5 = maps\mp\_utility::getotherteam(var_1);
    statusdialog("secured" + self.label, var_1, 1);
    statusdialog("enemy_has" + self.label, var_5, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_1);
  } else {
    if(getteamflagcount(var_1) == level.flags.size) {
      statusdialog("secure_all", var_1);
      statusdialog("lost_all", var_2);
    } else {
      statusdialog("secured" + self.label, var_1, 1);
      statusdialog("lost" + self.label, var_2, 1);
    }

    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_2);
    level.bestspawnflag[var_2] = self.levelflag;
  }

  updateuiflagomnvars(self.label, var_1);
  var_0 thread maps\mp\_audio::snd_play_team_splash("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  thread giveflagcapturexp(self.touchlist[var_1], var_4);
}

giveflagcapturexp(var_0, var_1) {
  level endon("game_ended");
  var_2 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();

  if(isDefined(var_2.owner)) {
    var_2 = var_2.owner;
  }

  if(isPlayer(var_2)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label, var_2);
  }

  var_3 = getarraykeys(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2 = var_0[var_3[var_4]].player;

    if(isDefined(var_2.owner)) {
      var_2 = var_2.owner;
    }

    if(!isPlayer(var_2)) {
      continue;
    }
    var_2 thread maps\mp\_events::domcaptureevent(var_1);
    var_2 thread updatecpm();
    wait 0.05;
  }
}

giveflagneutralizexp(var_0) {
  level endon("game_ended");
  var_1 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();

  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(isPlayer(var_1)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_neutralized_position" + self.label, var_1);
  }

  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1 = var_0[var_2[var_3]].player;

    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    if(!isPlayer(var_1)) {
      continue;
    }
    var_1 thread maps\mp\_events::domneutralizeevent();
    wait 0.05;
  }
}

delayedleaderdialog(var_0, var_1) {
  level endon("game_ended");
  wait 0.1;
  maps\mp\_utility::waittillslowprocessallowed();
  maps\mp\_utility::leaderdialog(var_0, var_1);
}

delayedleaderdialogbothteams(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait 0.1;
  maps\mp\_utility::waittillslowprocessallowed();
  maps\mp\_utility::leaderdialogbothteams(var_0, var_1, var_2, var_3);
}

updatedomscores() {
  level endon("game_ended");

  while(!level.gameended) {
    var_0 = getowneddomflags();

    if(var_0.size) {
      var_1 = undefined;
      var_2 = undefined;

      foreach(var_4 in var_0) {
        var_5 = var_4 maps\mp\gametypes\_gameobjects::getownerteam();
        maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_5, 1);

        if(!isDefined(var_1) || var_1 < var_4.capturetime) {
          var_1 = var_4.capturetime;
        }

        if(!isDefined(var_2)) {
          var_2 = var_5;
        }

        if(var_2 != var_5) {
          var_2 = "none";
        }
      }

      if(var_0.size == 3 && var_2 != "none" && level.players.size > 5) {
        level.threecaptime[var_2]["time"] = gettime() - var_1;
        level.threecaptime[maps\mp\_utility::getotherteam(var_2)]["time"] = 0;

        if(level.threecaptime[var_2]["time"] > 60000 && level.threecaptime["axis"]["awarded"] == 0) {
          level.threecaptime["axis"]["awarded"] = 1;

          foreach(var_8 in level.players) {
            if(var_8.team != var_2) {
              continue;
            }
            var_8 maps\mp\gametypes\_missions::processchallenge("ch_dom_tripcap");
          }
        }
      } else {
        level.threecaptime["axis"]["time"] = 0;
        level.threecaptime["allies"]["time"] = 0;
      }
    }

    var_10 = 0;
    var_11 = 0;
    var_12 = 0;

    foreach(var_14 in level.domflags) {
      if(var_14.label == "_a") {
        if(var_14.has_been_captured == 1) {
          var_11 = 1;
        }

        continue;
      }

      if(var_14.label == "_c") {
        if(var_14.has_been_captured == 1) {
          var_12 = 1;
        }
      }
    }

    if(var_11 == 1 || var_12 == 1) {
      var_10 = 1;
    }

    if(maps\mp\_utility::matchmakinggame() && !level.allowneutral && !var_10 && getdomroundtimepassed() > 120000 && !getdvarint("force_ranking")) {
      level.finalkillcam_winner = "none";
      thread maps\mp\gametypes\_gamelogic::endgame("none", game["end_reason"]["time_limit_reached"]);
      return;
    }

    wait 5.0;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

getdomroundtimepassed() {
  return gettime() - level.domroundstarttime;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::isfriendlyfire(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(isDefined(var_4) && maps\mp\_utility::iskillstreakweapon(var_4)) {
    return;
  }
  var_10 = 0;
  var_11 = self;

  foreach(var_13 in var_1.touchtriggers) {
    if(var_13 != level.flags[0] && var_13 != level.flags[1] && var_13 != level.flags[2]) {
      continue;
    }
    var_14 = var_13.useobj.ownerteam;

    if(var_1.team != var_14) {
      var_1 thread maps\mp\_events::killwhilecapture(var_11, var_9);
      var_10 = 1;
    }
  }

  var_16 = 90000;

  foreach(var_13 in level.flags) {
    var_14 = var_13.useobj.ownerteam;
    var_18 = distancesquared(var_13.origin, var_11.origin);
    var_19 = distancesquared(var_13.origin, var_1.origin);

    if(var_14 == var_1.team) {
      if(var_18 < var_16 || var_19 < var_16) {
        var_1 thread maps\mp\_events::defendobjectiveevent(var_11, var_9);
        var_1 maps\mp\_utility::setextrascore1(var_1.pers["defends"]);
      }
    }

    if(var_10) {
      break;
    }

    if(var_14 == var_11.team) {
      if(var_19 < var_16 || var_18 < var_16) {
        var_1 thread maps\mp\_events::assaultobjectiveevent(self, var_9);
      }
    }
  }
}

getowneddomflags() {
  var_0 = [];

  foreach(var_2 in level.domflags) {
    if(var_2 maps\mp\gametypes\_gameobjects::getownerteam() != "neutral" && isDefined(var_2.capturetime)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

getteamflagcount(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.flags.size; var_2++) {
    if(level.domflags[var_2] maps\mp\gametypes\_gameobjects::getownerteam() == var_0) {
      var_1++;
    }
  }

  return var_1;
}

getflagteam() {
  return self.useobj maps\mp\gametypes\_gameobjects::getownerteam();
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

  var_3 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");

  foreach(var_5 in var_3) {
    var_5.preferreddompoint = undefined;

    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "a_override") {
        var_5.preferreddompoint = 0;
        continue;
      } else if(var_5.script_noteworthy == "b_override") {
        var_5.preferreddompoint = 1;
        continue;
      } else if(var_5.script_noteworthy == "c_override") {
        var_5.preferreddompoint = 2;
        continue;
      }
    }

    var_5.nearflagpoint = getnearestflagpoint(var_5);

    switch (var_5.nearflagpoint.useobj.dompointnumber) {
      case 0:
        var_5.preferreddompoint = 0;
        break;
      case 1:
        var_5.preferreddompoint = 1;
        break;
      case 2:
        var_5.preferreddompoint = 2;
        break;
    }
  }
}

getnearestflagpoint(var_0) {
  var_1 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
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

onspawnplayer() {}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(maps\mp\_utility::getminutespassed() < 1) {
    return;
  }
  self.cpm = self.numcaps / maps\mp\_utility::getminutespassed();
}

getcapxpscale() {
  if(self.cpm < 4) {
    return 1;
  } else {
    return 0.25;
  }
}