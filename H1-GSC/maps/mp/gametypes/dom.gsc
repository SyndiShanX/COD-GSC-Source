/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\dom.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 200);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.teambased = 1;
  level.classicgamemode = 1;
  level.allowneutral = 0;
  level.checkscorelimitonframeend = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onspawnplayer = ::onspawnplayer;
  level.domroundstarttime = gettime();
  level.allowboostingabovetriggerradius = 1;
  level.domcapturetime = maps\mp\_utility::getfloatproperty("scr_dom_capture_time", 10);
  level.halftimeonscorelimit = 1;
  level.halftimeonscorelimitsettimetobeat = 0;
  level.threecaptime["axis"]["time"] = 0;
  level.threecaptime["axis"]["awarded"] = 0;
  level.threecaptime["allies"]["time"] = 0;
  level.threecaptime["allies"]["awarded"] = 0;
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.dom = spawnstruct();

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  level.domborderfx = [];
  level.domborderfx["friendly"] = [];
  level.domborderfx["friendly"]["_a"] = "vfx\unique\vfx_marker_dom";
  level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom";
  level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom";
  level.domborderfx["enemy"] = [];
  level.domborderfx["enemy"]["_a"] = "vfx\unique\vfx_marker_dom_red";
  level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red";
  level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red";
  level.domborderfx["neutral"] = [];
  level.domborderfx["neutral"]["_a"] = "vfx\unique\vfx_marker_dom_white";
  level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_white";
  level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_white";
  game["dialog"]["gametype"] = "domination";
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_dom_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("dom", 1);
  setdynamicdvar("scr_dom_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("dom", 1);
  var_0 = getmatchrulesdata("domData", "halfTime");
  setdynamicdvar("scr_dom_halftime", var_0);
  maps\mp\_utility::registerhalftimedvar("dom", var_0);
  setdynamicdvar("scr_dom_capture_time", getmatchrulesdata("domData", "captureTime"));
  setdynamicdvar("scr_dom_allowNeutral", getmatchrulesdata("domData", "allowNeutral"));
  setdynamicdvar("scr_dom_halftimeswitchsides", getmatchrulesdata("domData", "halfTimeSwitchSides"));
}

onstartgametype() {
  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(game["status"] == "halftime")
    setomnvar("ui_current_round", 2);
  else if(game["status"] == "overtime")
    setomnvar("ui_current_round", 3);
  else if(game["status"] == "overtime_halftime")
    setomnvar("ui_current_round", 4);

  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_DOM");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_DOM");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_DOM");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_DOM");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_DOM_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_DOM_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_DOM_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_DOM_HINT");
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

  for (;;) {
    level waittill("connected", var_0);
    var_0 thread updatecaptures();
    var_0 thread updatedefends();
  }
}

updatecaptures() {
  waittillframeend;
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

updatedefends() {
  waittillframeend;
  maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

updatemlgobjectives() {
  level endon("game_ended");

  for (;;) {
    foreach(var_1 in level.players) {
      var_1.objective = 0;

      foreach(var_3 in level.domflags) {
        if(var_1 istouching(var_3.levelflag)) {
          if(var_3.numtouching["axis"] * var_3.numtouching["allies"] > 0)
            var_1.objective = 1;
          else if(var_3.ownerteam == "neutral") {
            if(var_1.team == "allies")
              var_1.objective = 2;
            else
              var_1.objective = 3;
          } else if(var_3.ownerteam == "allies") {
            if(var_1.team == "allies")
              var_1.objective = 4;
            else
              var_1.objective = 5;
          } else if(var_3.ownerteam == "axis") {
            if(var_1.team == "axis")
              var_1.objective = 6;
            else
              var_1.objective = 7;
          }

          if(var_1.objective > 0) {
            if(var_3.label == "_b") {
              var_1.objective = var_1.objective + 7;
              continue;
            }

            if(var_3.label == "_c")
              var_1.objective = var_1.objective + 14;
          }
        }
      }
    }

    wait 0.05;
  }
}

precacheflags() {
  game["neutral"] = "neutral";
  level.flagmodels["marines"]["friendly"] = "h1_flag_mp_domination_usmc_blue";
  level.flagmodels["marines"]["enemy"] = "h1_flag_mp_domination_usmc_red";
  level.flagmodels["sas"]["friendly"] = "h1_flag_mp_domination_sas_blue";
  level.flagmodels["sas"]["enemy"] = "h1_flag_mp_domination_sas_red";
  level.flagmodels["opfor"]["friendly"] = "h1_flag_mp_domination_arab_blue";
  level.flagmodels["opfor"]["enemy"] = "h1_flag_mp_domination_arab_red";
  level.flagmodels["russian"]["friendly"] = "h1_flag_mp_domination_spetsnaz_blue";
  level.flagmodels["russian"]["enemy"] = "h1_flag_mp_domination_spetsnaz_red";
  level.flagmodels["neutral"]["friendly"] = "h1_flag_mp_domination_default";
  level.flagmodels["neutral"]["enemy"] = "h1_flag_mp_domination_default";
  level.flagfxid["marines"] = [];
  level.flagfxid["marines"]["friendly"] = undefined;
  level.flagfxid["marines"]["enemy"] = undefined;
  level.flagfxid["sas"] = [];
  level.flagfxid["sas"]["friendly"] = undefined;
  level.flagfxid["sas"]["enemy"] = undefined;
  level.flagfxid["opfor"] = [];
  level.flagfxid["opfor"]["friendly"] = undefined;
  level.flagfxid["opfor"]["enemy"] = undefined;
  level.flagfxid["russian"] = [];
  level.flagfxid["russian"]["friendly"] = undefined;
  level.flagfxid["russian"]["enemy"] = undefined;
  level.flagfxid["neutral"] = [];
  level.flagfxid["neutral"]["friendly"] = undefined;
  level.flagfxid["neutral"]["enemy"] = undefined;
  var_0 = ["marines", "sas", "opfor", "russian", "neutral"];

  foreach(var_2 in var_0) {
    level.boarderfxid[var_2] = [];
    var_3 = ["friendly", "enemy"];

    foreach(var_5 in var_3) {
      level.boarderfxid[var_2][var_5] = [];
      var_6 = ["_a", "_b", "_c"];

      foreach(var_8 in var_6) {
        if(var_2 == "neutral") {
          level.boarderfxid[var_2][var_5][var_8] = loadfx(level.domborderfx[var_2][var_8]);
          continue;
        }

        level.boarderfxid[var_2][var_5][var_8] = loadfx(level.domborderfx[var_5][var_8]);
      }
    }
  }
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(level.usestartspawns && level.ingraceperiod) {
    if(game["switchedsides"])
      var_0 = maps\mp\_utility::getotherteam(var_0);

    var_1 = maps\mp\gametypes\_spawnlogic::getbeststartspawn("mp_dom_spawn_" + var_0 + "_start");
  } else if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
    var_1 = getspawnpointlegacy(var_0);
  else {
    var_2 = getteamdompoints(var_0);
    var_3 = maps\mp\_utility::getotherteam(var_0);
    var_4 = getteamdompoints(var_3);
    var_5 = getprefereddompoints(var_2, var_4);
    var_6 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_domination(var_6, var_5);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_1);
  return var_1;
}

getteamdompoints(var_0) {
  var_1 = [];

  foreach(var_3 in level.domflags) {
    if(var_3.ownerteam == var_0)
      var_1[var_1.size] = var_3;
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

      if(var_8 > 80000 && var_9 > 80000 && var_10 > 80000)
        return var_2;
    }
  }

  if(var_0.size > 0) {
    foreach(var_12 in var_0)
    var_2[var_12.dompointnumber] = 1;

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
  var_0 = getentarray("flag_primary", "targetname");
  var_1 = getentarray("flag_primary_augmented", "targetname");

  if(var_0.size < 2) {
    return;
  }
  if(maps\mp\_utility::isaugmentedgamemode()) {
    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2].script_label;

      for (var_4 = 0; var_4 < var_0.size; var_4++) {
        if(var_0[var_4].script_label == var_3) {
          var_0[var_4] delete();
          break;
        }
      }
    }
  } else {
    for (var_5 = 0; var_5 < var_1.size; var_5++)
      var_1[var_5] delete();
  }

  level.flags = [];
  level.flags = common_scripts\utility::array_combine(var_0, var_1);
  level.domflags = [];

  for (var_5 = 0; var_5 < level.flags.size; var_5++) {
    var_6 = level.flags[var_5];

    if(isdefined(var_6.target))
      var_7[0] = getent(var_6.target, "targetname");
    else {
      var_7[0] = spawn("script_model", var_6.origin);
      var_7[0].angles = var_6.angles;
    }

    var_7[1] = spawn("script_model", var_7[0].origin);
    var_7[1].angles = var_7[0].angles;
    var_7[0] thread maps\mp\_utility::showfxtoteam("allies");
    var_7[1] thread maps\mp\_utility::showfxtoteam("axis");
    var_8 = maps\mp\gametypes\_gameobjects::createuseobject("neutral", var_6, var_7, (0, 0, 100));
    var_8 maps\mp\gametypes\_gameobjects::allowuse("enemy");
    var_8 maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime);
    var_8 maps\mp\gametypes\_gameobjects::setusetext(&"MP_SECURING_POSITION");
    var_9 = var_8 maps\mp\gametypes\_gameobjects::getlabel();
    var_8.label = var_9;
    var_8 updatedomicon();
    var_8 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    var_8.onuse = ::onuse;
    var_8.onbeginuse = ::onbeginuse;
    var_8.onuseupdate = ::onuseupdate;
    var_8.onenduse = ::onenduse;
    var_8.onnumtouchingchanged = ::onnumtouchingchanged;
    var_8.nousebar = 1;
    var_8.contesteduiprogress = 1;
    var_8.id = "domFlag";
    var_8.has_been_captured = 0;
    var_8.firstcapture = 1;
    var_10 = var_7[0].origin + (0, 0, 32);
    var_11 = var_7[0].origin + (0, 0, -32);
    var_12 = bullettrace(var_10, var_11, 0, var_7[0]);
    var_13 = vectortoangles(var_12["normal"]);
    var_8.baseeffectforward = anglestoforward(var_13);
    var_8.baseeffectright = anglestoright(var_13);
    var_8.baseeffectpos = var_12["position"];
    var_7[0].origin = var_12["position"];
    var_7[1].origin = var_12["position"];
    var_8 thread updatevisuals(1);
    level.flags[var_5].useobj = var_8;

    if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning()) {
      level.flags[var_5].adjflags = [];
      level.flags[var_5].nearbyspawns = [];
    }

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

  if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
    flagsetuplegacy();
  else
    flagsetup();
}

domseticon(var_0, var_1) {
  var_2 = self.compassicons[var_0];

  if(!isdefined(var_2) || var_2 != var_1)
    maps\mp\gametypes\_gameobjects::set2dicon(var_0, var_1);

  var_3 = self.worldicons[var_0];

  if(!isdefined(var_3) || var_3 != var_1)
    maps\mp\gametypes\_gameobjects::set3dicon(var_0, var_1);
}

updatedomicon() {
  self notify("updateDomIcon");
  self endon("updateDomIcon");
  waittillframeend;
  var_0 = !self.numtouching["allies"] && !self.numtouching["axis"];
  var_1 = self.numtouching["allies"] && self.numtouching["axis"];
  var_2 = maps\mp\gametypes\_gameobjects::getownerteam();

  if(var_1) {
    domseticon("enemy", "waypoint_contested" + self.label);
    domseticon("friendly", "waypoint_contested" + self.label);
    domseticon("mlg", "waypoint_contested" + self.label);
  } else if(var_2 != "neutral") {
    var_3 = maps\mp\_utility::getotherteam(var_2);
    var_4 = self.numtouching[var_3];

    if(var_4) {
      domseticon("enemy", "waypoint_taking" + self.label);
      domseticon("friendly", "waypoint_losing" + self.label);

      if(var_2 == "allies") {
        domseticon("mlg", "waypoint_esports_dom_blue_losing" + self.label);
        return;
      }

      domseticon("mlg", "waypoint_esports_dom_red_losing" + self.label);
      return;
      return;
    }

    domseticon("enemy", "waypoint_capture" + self.label);
    domseticon("friendly", "waypoint_defend" + self.label);

    if(var_2 == "allies") {
      domseticon("mlg", "waypoint_esports_dom_blue" + self.label);
      return;
    }

    domseticon("mlg", "waypoint_esports_dom_red" + self.label);
    return;
    return;
  } else if(var_0) {
    domseticon("enemy", "waypoint_captureneutral" + self.label);
    domseticon("friendly", "waypoint_captureneutral" + self.label);
    domseticon("mlg", "waypoint_esports_dom_white" + self.label);
  } else {
    domseticon("enemy", "waypoint_taking" + self.label);
    domseticon("friendly", "waypoint_losing" + self.label);

    if(self.numtouching["allies"])
      domseticon("mlg", "waypoint_esports_dom_blue_taking" + self.label);
    else
      domseticon("mlg", "waypoint_esports_dom_red_taking" + self.label);
  }
}

getunownedflagneareststart(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(!isdefined(var_2))
    var_2 = 0;

  for (var_5 = 0; var_5 < level.flags.size; var_5++) {
    var_6 = level.flags[var_5];

    if(!var_2 && var_6 getflagteam() != "neutral") {
      continue;
    }
    var_7 = distancesquared(var_6.origin, level.startpos[var_0]);

    if((!isdefined(var_1) || var_6 != var_1) && (!isdefined(var_3) || var_7 < var_4)) {
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

  if(var_1 == "neutral")
    statusdialog("securing" + self.label, var_0.team);
  else {
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
    } else {
      statusdialog("losing" + self.label, var_3, 1);
      statusdialog("securing" + self.label, var_0);
    }

    self.didstatusnotify = 1;
  } else if(level.allowneutral && var_1 > 0.49 && var_2 && self.didstatusnotify && var_3 != "neutral") {
    maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    updatevisuals();
    statusdialog("lost" + self.label, var_3, 1);
    level thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken", var_0);
    level thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost", var_3);
    updateuiflagomnvars(self.label, "neutral");
    thread giveflagneutralizexp(self.touchlist[var_0]);
  }
}

statusdialog(var_0, var_1, var_2) {
  var_3 = gettime();

  if(gettime() < level.laststatus[var_1] + 5000 && (!isdefined(var_2) || !var_2)) {
    return;
  }
  thread delayedleaderdialog(var_0, var_1);
  level.laststatus[var_1] = gettime();
}

onenduse(var_0, var_1, var_2) {
  if(isplayer(var_1))
    var_1 setclientomnvar("ui_capture_icon", 0);

  if(var_0 == "allies")
    common_scripts\utility::array_remove(level.alliescapturing, self.label);
  else
    common_scripts\utility::array_remove(level.axiscapturing, self.label);
}

onnumtouchingchanged(var_0, var_1, var_2) {
  updatedomicon();
}

updatevisuals(var_0) {
  if(isdefined(var_0) && var_0)
    waittillframeend;

  if(!isremovedentity(self.visuals[0])) {
    var_1 = self.ownerteam;
    var_2 = level.flagmodels[game[var_1]]["friendly"];
    var_3 = level.flagmodels[game[var_1]]["enemy"];
    var_4 = self.visuals[0];
    var_5 = self.visuals[1];
    var_6 = common_scripts\utility::ter_op(var_1 == "allies", var_4, var_5);
    var_7 = common_scripts\utility::ter_op(var_1 == "allies", var_5, var_4);
    var_6 setmodel(var_2);
    var_7 setmodel(var_3);
    friendlyenemyeffects(var_4.origin, anglestoup(var_4.angles));
  }
}

friendlyenemyeffects(var_0, var_1) {
  var_2 = self.ownerteam;
  var_3 = maps\mp\gametypes\_gameobjects::getlabel();
  var_4 = level.flagfxid[game[var_2]]["friendly"];
  var_5 = level.boarderfxid[game[var_2]]["friendly"][var_3];
  var_6 = level.flagfxid[game[var_2]]["enemy"];
  var_7 = level.boarderfxid[game[var_2]]["enemy"][var_3];
  friendlyenemyeffectsstop();

  if(isdefined(var_4))
    self.friendlyflagfxid = maps\mp\_utility::spawnfxshowtoteam(var_4, var_2, var_0, var_1);

  if(isdefined(var_5))
    self.friendlyboarderfxid = maps\mp\_utility::spawnfxshowtoteam(var_5, var_2, var_0, var_1);

  if(isdefined(var_6))
    self.enemyflagfxid = maps\mp\_utility::spawnfxshowtoteam(var_6, maps\mp\_utility::getotherteam(var_2), var_0, var_1);

  if(isdefined(var_7))
    self.enemyboarderfxid = maps\mp\_utility::spawnfxshowtoteam(var_7, maps\mp\_utility::getotherteam(var_2), var_0, var_1);
}

friendlyenemyeffectsstop() {
  if(isdefined(self.friendlyflagfxid))
    self.friendlyflagfxid delete();

  if(isdefined(self.friendlyboarderfxid))
    self.friendlyboarderfxid delete();

  if(isdefined(self.enemyflagfxid))
    self.enemyflagfxid delete();

  if(isdefined(self.enemyboarderfxid))
    self.enemyboarderfxid delete();
}

updateuiflagomnvars(var_0, var_1) {
  var_2 = "ui_mlg_game_mode_status_1";

  if(var_0 == "_b")
    var_2 = "ui_mlg_game_mode_status_2";

  if(var_0 == "_c")
    var_2 = "ui_mlg_game_mode_status_3";

  if(var_1 == "allies")
    setomnvar(var_2, -1);
  else if(var_1 == "axis")
    setomnvar(var_2, 1);
  else
    setomnvar(var_2, 0);
}

onuse(var_0) {
  var_1 = var_0.team;
  var_2 = maps\mp\gametypes\_gameobjects::getownerteam();
  var_3 = maps\mp\gametypes\_gameobjects::getlabel();
  var_4 = 0;

  if(self.firstcapture && var_3 == "_b")
    var_4 = 1;

  self.capturetime = gettime();
  self.firstcapture = 0;
  self.has_been_captured = 1;

  if(isdefined(self.ownedtheentireround))
    self.ownedtheentireround = 0;
  else
    self.ownedtheentireround = 1;

  maps\mp\gametypes\_gameobjects::setownerteam(var_1);
  updatedomicon();
  updatevisuals();
  level.usestartspawns = 0;

  if(var_2 == "neutral") {
    var_5 = maps\mp\_utility::getotherteam(var_1);
    statusdialog("secured" + self.label, var_1, 1);
    statusdialog("enemy_has" + self.label, var_5, 1);
    level thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken", var_1);
  } else {
    if(getteamflagcount(var_1) == level.flags.size) {
      statusdialog("secure_all", var_1);
      statusdialog("lost_all", var_2);
    } else {
      statusdialog("secured" + self.label, var_1, 1);
      statusdialog("lost" + self.label, var_2, 1);
    }

    level thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken", var_1);
    level thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost", var_2);
    level.bestspawnflag[var_2] = self.levelflag;
  }

  updateuiflagomnvars(self.label, var_1);
  forcecapturehudoff(self.touchlist[var_1]);
  thread giveflagcapturexp(self.touchlist[var_1], var_4);
}

forcecapturehudoff(var_0) {
  var_1 = getarraykeys(var_0);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_0[var_1[var_2]].player;

    if(!isplayer(var_3)) {
      continue;
    }
    var_3 setclientomnvar("ui_capture_icon", 0);
  }
}

giveflagcapturexp(var_0, var_1) {
  level endon("game_ended");
  var_2 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();

  if(isdefined(var_2.owner))
    var_2 = var_2.owner;

  if(isplayer(var_2))
    level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label, var_2);

  var_3 = getarraykeys(var_0);

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2 = var_0[var_3[var_4]].player;

    if(isdefined(var_2.owner))
      var_2 = var_2.owner;

    if(!isplayer(var_2)) {
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

  if(isdefined(var_1.owner))
    var_1 = var_1.owner;

  if(isplayer(var_1))
    level thread maps\mp\_utility::teamplayercardsplash("callout_neutralized_position" + self.label, var_1);

  var_2 = getarraykeys(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1 = var_0[var_2[var_3]].player;

    if(isdefined(var_1.owner))
      var_1 = var_1.owner;

    if(!isplayer(var_1)) {
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

  while (!level.gameended) {
    var_0 = getowneddomflags();

    if(var_0.size) {
      var_1 = undefined;
      var_2 = undefined;
      var_3 = [];

      foreach(var_5 in var_0) {
        var_6 = var_5 maps\mp\gametypes\_gameobjects::getownerteam();

        if(!isdefined(var_3[var_6]))
          var_3[var_6] = 0;

        var_3[var_6]++;

        if(!isdefined(var_1) || var_1 < var_5.capturetime)
          var_1 = var_5.capturetime;

        if(!isdefined(var_2))
          var_2 = var_6;

        if(var_2 != var_6)
          var_2 = "none";
      }

      var_8 = maps\mp\_utility::getscorelimit();

      if(var_8 && maps\mp\_utility::gethalftime() && level.halftimeonscorelimit && (game["status"] == "normal" || game["status"] == "overtime"))
        var_8 = int(var_8 / 2 + 0.5);

      if(var_8 > 0) {
        var_9 = undefined;

        foreach(var_6, var_11 in var_3) {
          if(var_11 + maps\mp\gametypes\_gamescore::_getteamscore(var_6) >= var_8) {
            if(!isdefined(var_9)) {
              var_9 = var_6;
              continue;
            }

            var_9 = undefined;
            break;
          }
        }

        if(isdefined(var_9))
          var_3[var_9] = var_8 - maps\mp\gametypes\_gamescore::_getteamscore(var_9);
      }

      foreach(var_6, var_11 in var_3)
      maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_6, var_11);

      if(var_0.size == 3 && var_2 != "none" && level.players.size > 5) {
        level.threecaptime[var_2]["time"] = gettime() - var_1;
        level.threecaptime[maps\mp\_utility::getotherteam(var_2)]["time"] = 0;

        if(level.threecaptime[var_2]["time"] > 60000 && level.threecaptime["axis"]["awarded"] == 0) {
          level.threecaptime["axis"]["awarded"] = 1;

          foreach(var_14 in level.players) {
            if(var_14.team != var_2) {
              continue;
            }
            var_14 maps\mp\gametypes\_missions::processchallenge("ch_dom_tripcap");
          }
        }
      } else {
        level.threecaptime["axis"]["time"] = 0;
        level.threecaptime["allies"]["time"] = 0;
      }
    }

    var_16 = 0;
    var_17 = 0;
    var_18 = 0;

    foreach(var_20 in level.domflags) {
      if(var_20.label == "_a") {
        if(var_20.has_been_captured == 1)
          var_17 = 1;

        continue;
      }

      if(var_20.label == "_c") {
        if(var_20.has_been_captured == 1)
          var_18 = 1;
      }
    }

    if(var_17 == 1 || var_18 == 1)
      var_16 = 1;

    if(maps\mp\_utility::matchmakinggame() && !level.allowneutral && !var_16 && getdomroundtimepassed() > 120000 && !getdvarint("force_ranking")) {
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
  if(!isplayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::isfriendlyfire(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(isdefined(var_4) && maps\mp\_utility::iskillstreakweapon(var_4)) {
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
      if(var_19 < var_16 || var_18 < var_16)
        var_1 thread maps\mp\_events::assaultobjectiveevent(self, var_9);
    }
  }
}

getowneddomflags() {
  var_0 = [];

  foreach(var_2 in level.domflags) {
    if(var_2 maps\mp\gametypes\_gameobjects::getownerteam() != "neutral" && isdefined(var_2.capturetime))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

getteamflagcount(var_0) {
  var_1 = 0;

  for (var_2 = 0; var_2 < level.flags.size; var_2++) {
    if(level.domflags[var_2] maps\mp\gametypes\_gameobjects::getownerteam() == var_0)
      var_1++;
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

    if(isdefined(var_5.script_noteworthy)) {
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

    if(var_1)
      var_6 = getpathdist(var_0.origin, var_5.levelflag.origin, 999999);

    if(!isdefined(var_6) || var_6 == -1)
      var_6 = distancesquared(var_5.levelflag.origin, var_0.origin);

    if(!isdefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2.levelflag;
}

onspawnplayer() {}

updatecpm() {
  if(!isdefined(self.cpm)) {
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
  if(self.cpm < 4)
    return 1;
  else
    return 0.25;
}

getspawnpointlegacy(var_0) {
  var_1 = undefined;
  var_2 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");
  var_3 = 0;
  var_4 = 0;
  var_5 = self.pers["team"];
  var_6 = maps\mp\_utility::getotherteam(var_5);

  for (var_7 = 0; var_7 < level.flags.size; var_7++) {
    var_8 = level.flags[var_7] getflagteam();

    if(var_8 == var_5) {
      var_3++;
      continue;
    }

    if(var_8 == var_6)
      var_4++;
  }

  if(var_3 == level.flags.size) {
    var_9 = level.bestspawnflag[maps\mp\_utility::getotherteam(self.pers["team"])];
    var_1 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(var_2, getspawnsboundingflag(var_9));
  } else if(var_3 > 0)
    var_1 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(var_2, getboundaryflagspawns(var_5));
  else {
    var_10 = undefined;

    if(var_4 > 0 && var_4 < level.flags.size)
      var_10 = getunownedflagneareststart(var_5);

    if(!isdefined(var_10))
      var_10 = level.bestspawnflag[self.pers["team"]];

    level.bestspawnflag[self.pers["team"]] = var_10;
    var_1 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(var_2, var_10.nearbyspawns);
  }

  if(!isdefined(var_1)) {
    if(var_0 == "axis") {
      var_11 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
      var_1 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_random(var_11);
    } else {
      var_12 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
      var_1 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_random(var_12);
    }
  }

  return var_1;
}

getboundaryflags() {
  var_0 = [];

  for (var_1 = 0; var_1 < level.flags.size; var_1++) {
    for (var_2 = 0; var_2 < level.flags[var_1].adjflags.size; var_2++) {
      if(level.flags[var_1].useobj maps\mp\gametypes\_gameobjects::getownerteam() != level.flags[var_1].adjflags[var_2].useobj maps\mp\gametypes\_gameobjects::getownerteam()) {
        var_0[var_0.size] = level.flags[var_1];
        break;
      }
    }
  }

  return var_0;
}

getboundaryflagspawns(var_0) {
  var_1 = [];
  var_2 = getboundaryflags();

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isdefined(var_0) && var_2[var_3] getflagteam() != var_0) {
      continue;
    }
    for (var_4 = 0; var_4 < var_2[var_3].nearbyspawns.size; var_4++)
      var_1[var_1.size] = var_2[var_3].nearbyspawns[var_4];
  }

  return var_1;
}

getspawnsboundingflag(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.flags.size; var_2++) {
    var_3 = level.flags[var_2];

    if(var_3 == var_0) {
      continue;
    }
    var_4 = 0;

    for (var_5 = 0; var_5 < var_3.adjflags.size; var_5++) {
      if(var_3.adjflags[var_5] == var_0) {
        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      continue;
    }
    for (var_5 = 0; var_5 < var_3.nearbyspawns.size; var_5++)
      var_1[var_1.size] = var_3.nearbyspawns[var_5];
  }

  return var_1;
}

flagsetuplegacy() {
  var_0 = [];

  foreach(var_2 in level.flags)
  var_0[var_2.script_label] = var_2;

  var_4 = [];

  switch (level.script) {
    case "mp_pipeline":
    case "mp_overgrown":
    case "mp_citystreets":
    case "mp_broadcast":
    case "mp_countdown":
    case "mp_bog":
    case "mp_bog_summer":
      var_4["_a"] = ["_b", "_c"];
      var_4["_b"] = ["_a", "_c"];
      var_4["_c"] = ["_a", "_b"];
      break;
    case "mp_carentan":
    case "mp_creek":
    case "mp_killhouse":
    case "mp_vacant":
    case "mp_strike":
    case "mp_showdown":
    case "mp_shipment":
    case "mp_farm":
    case "mp_crossfire":
    case "mp_crash":
    case "mp_convoy":
    case "mp_bloc":
    case "mp_backlot":
    case "mp_cargoship":
    case "mp_farm_spring":
    case "mp_crash_snow":
    default:
      var_4["_a"] = ["_b"];
      var_4["_b"] = ["_a", "_c"];
      var_4["_c"] = ["_b"];
      break;
  }

  foreach(var_2 in level.flags) {
    var_6 = var_4[var_2.script_label];

    foreach(var_8 in var_6)
    var_2.adjflags[var_2.adjflags.size] = var_0[var_8];
  }

  var_11 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");

  for (var_12 = 0; var_12 < var_11.size; var_12++) {
    var_13 = undefined;

    if(isdefined(var_11[var_12].script_linkto)) {
      switch (var_11[var_12].script_linkto) {
        case "flag1":
          var_13 = var_0["_a"];
          break;
        case "flag2":
          var_13 = var_0["_b"];
          break;
        case "flag3":
          var_13 = var_0["_c"];
          break;
        default:
          break;
      }
    }

    if(!isdefined(var_13)) {
      var_14 = undefined;

      foreach(var_2 in level.flags) {
        var_16 = distancesquared(var_2.origin, var_11[var_12].origin);

        if(!isdefined(var_13) || var_16 < var_14) {
          var_13 = var_2;
          var_14 = var_16;
        }
      }
    }

    var_13.nearbyspawns[var_13.nearbyspawns.size] = var_11[var_12];
  }
}