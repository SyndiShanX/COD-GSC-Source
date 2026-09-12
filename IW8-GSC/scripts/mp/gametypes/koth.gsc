/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\koth.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_koth_zoneLifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_koth_zoneCaptureTime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_koth_firstZoneActivationDelay", getmatchrulesdata("kothData", "firstZoneActivationDelay"));
  setdynamicdvar("scr_koth_zoneActivationDelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_koth_randomLocationOrder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_koth_additiveScoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_koth_pauseTime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_koth_delayPlayer", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("scr_koth_spawndelay", getmatchrulesdata("kothData", "spawnDelay"));
  setdynamicdvar("scr_koth_useHQRules", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("scr_koth_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("koth", 0);
}

function onstartgametype() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/KOTH_HINT");
  }

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  thread setupzones();
  thread setupzoneareabrushes();
  initspawns();
  setkothwaypoints();
  seticonnames();

  if(!level.zonerandomlocationorder) {
    ref_12BBC();
  }

  thread hardpointmainloop();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("firstZoneActivationDelay", 30, 0, 60);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneActivationDelay", 0, 0, 60);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.ref_1221A = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 0.5, 0, 10);
  level.usehqrules = scripts\mp\utility\dvars::dvarintvalue("useHQRules", 0, 0, 1);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::isanymlgmatch() && getdvarint("scr_koth_playlistZoneActivationDelay", 15) != 0) {
    level.zoneactivationdelay = binoculars_getfov();
    return;
  }
}

function binoculars_getfov() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_0) {
    case "mp_raid":
    case "mp_euphrates":
    case "mp_deadzone":
      return getdvarint("scr_koth_playlistZoneActivationDelay", 15);
    case "mp_aniyah":
      return (getdvarint("scr_koth_playlistZoneActivationDelay", 15) + 15);
    default:
      return level.zoneactivationdelay;
  }
}

function seticonnames() {
  level.icontarget = "koth_target";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_destroy";
  level.icondefend = "koth_defend";
  level.iconcontested = "koth_contested";
  level.icontaking = "koth_taking";
  level.iconlosing = "koth_losing";
  level.icondefending = "koth_defending";
}

function hardpointmainloop() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  level.zone = getfirstzone();
  var_0 = 1;
  level.kothhillrotation = 0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143A5("prematch_done", "start_mode_setup");
  }

  level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("any");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  scripts\mp\utility\game::ref_119AC(undefined, undefined, "New Hardpoint", level.zone.trigger.origin);
  level.zone thread scripts\common\utility::ref_13E0A(level.ref_11B29, "hill_moved", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("prematch_done");

  if(level.ref_1221A) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var_1 = 0;

  if(level.firstzoneactivationdelay) {
    var_1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 12);
    level.ref_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 36, 36);
    thread waitthenplaynewobj();
    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199E(level.firstzoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait level.firstzoneactivationdelay;
    level.ref_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 35, 35);
    scripts\mp\utility\game::setmlgannouncement(5, "free");
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_hq_activate_sfx");

  for(;;) {
    if(!isDefined(level.ref_11AD5)) {
      thread setupzonecallouts();
    }

    level.objectivesetorder = 1;

    if(level.ref_1221A) {
      level scripts\mp\gamelogic::resumetimer();
    }

    waittillframeend();
    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
    }

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_1, var_0);
    var_0 = 0;
    var_1 = 0;
    setomnvar("ui_hq_status", 10);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var_2 = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.ref_1221A) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
    killhardpointvfx(level.zone);
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_4 in level.players) {
        level.zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var_4);
      }
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("none");
    level.zone scripts\mp\gameobjects::setownerteam("neutral");
    updateservericons("zone_shift", 0);
    level notify("zone_reset");
    setomnvar("ui_hq_status", -1);
    spawn_next_zone();

    if(scripts\mp\utility\game::getgametype() == "grnd" && level.kothhillrotation == 1) {}

    wait 0.5;

    if(level.usehqrules) {
      thread forcespawnplayers();
    }

    wait 0.5;
  }
}

function waitthenplaynewobj() {
  if(istrue(level.infilvotiming)) {
    wait 9.5;
  } else {
    wait 7;
  }

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_first", var_1);
  }
}

function killhardpointvfx() {
  foreach(var_1 in level.players) {
    foreach(var_3 in var_1._hardpointeffect) {
      var_1._hardpointeffect = scripts\engine\utility::array_remove(var_1._hardpointeffect, var_3);

      if(isDefined(var_3)) {
        var_3 delete();
      }
    }
  }

  if(isDefined(self.neutralhardpointfx) && self.neutralhardpointfx.size > 0) {
    foreach(var_3 in self.neutralhardpointfx) {
      var_3 delete();
    }
  }

  self.neutralhardpointfx = [];
}

function ref_12BBC() {
  switch (level.mapname) {
    case "mp_hackney_yard":
    case "mp_hackney_am":
      level.ref_12BBE = ["1", "4", "3", "9", "8"];
      break;
    case "mp_spear":
    case "mp_spear_pm":
      level.ref_12BBE = ["5", "4", "3", "2", "6"];
      break;
    case "mp_cave":
    case "mp_cave_am":
      level.ref_12BBE = ["1", "5", "2", "3", "4"];
      break;
    case "mp_petrograd":
      level.ref_12BBE = ["1", "9", "4", "5", "2"];
      break;
    case "mp_deadzone":
      level.ref_12BBE = ["12", "11", "3", "1", "2"];
      break;
    case "mp_raid":
      level.ref_12BBE = ["20", "2", "8", "9", "5"];
      break;
    case "mp_piccadilly":
      level.ref_12BBE = ["1", "5", "7", "3", "8"];
      break;
    case "mp_crash2_pm":
    case "mp_crash2":
      level.ref_12BBE = ["1", "20", "5", "4", "19"];
      break;
    case "mp_emporium":
      level.ref_12BBE = ["1", "2", "3", "4", "5"];
      break;
    case "mp_broadcast2":
      level.ref_12BBE = ["1", "2", "3", "4", "5"];
      break;
    default:
      break;
  }
}

function getfirstzone() {
  if(isDefined(level.ref_12BBE)) {
    var_0 = level.objectives[level.ref_12BBE[0]];
    level.prevzoneindex = 0;
    level.playerzombiedroploot = level.objectives[level.ref_12BBE[1]];
  } else {
    var_0 = level.objectives["1"];
    level.prevzoneindex = 1;
    level.playerzombiedroploot = level.objectives["2"];
  }

  var_0 thread scripts\mp\gametypes\obj_zonecapture::ref_144DA();
  level.playerzombiedroploot thread scripts\mp\gametypes\obj_zonecapture::ref_144DA();
  return var_0;
}

function getnextzone() {
  level notify("stop_watching_trigger");

  if(level.zonerandomlocationorder) {
    var_0 = [];

    foreach(var_2 in level.teamnamelist) {
      var_0 = (0, 0, 0);
    }

    var_4 = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(var_6 in var_4) {
      if(var_6.team == "spectator") {
        continue;
      }

      var_0 = var_0[var_6.team] + var_6.origin;
    }

    var_8 = [];

    foreach(var_2 in level.teamnamelist) {
      var_10 = scripts\mp\utility\teams::getteamdata(var_2, "players");
      var_11 = max(var_10.size, 1);
      var_8 = var_0[var_2] / var_11;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1) {
      level.prevzonelist = [];
    }

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    var_13 = 0.7;
    var_14 = 0.3;
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_18 in level.objectives) {
      var_19 = 0;

      foreach(var_21 in level.prevzonelist) {
        if(var_18.objectivekey == scripts\engine\utility::string(var_21)) {
          var_19 = 1;
          break;
        }
      }

      if(var_19) {
        continue;
      }

      var_23 = var_18;
      var_24 = 0;

      foreach(var_2 in level.teamnamelist) {
        var_24 += distance2dsquared(var_23.curorigin, var_8[var_2]);
      }

      var_27 = distance2dsquared(var_23.curorigin, level.zone.curorigin);
      var_28 = var_24 * var_13 + var_27 * var_14;

      if(!isDefined(var_16) || var_28 > var_16) {
        var_16 = var_28;
        var_15 = var_18.objectivekey;
      }
    }

    var_23 = level.objectives[var_15];
    level.prevzoneindex = var_15;
  } else {
    if(isDefined(level.ref_12BBE)) {
      level.prevzoneindex++;

      if(level.prevzoneindex > level.ref_12BBE.size - 1) {
        level.prevzoneindex = 0;
      }

      var_23 = level.objectives[level.ref_12BBE[level.prevzoneindex]];
      var_30 = level.prevzoneindex + 1;

      if(var_30 > level.ref_12BBE.size - 1) {
        var_30 = 1;
      }

      level.playerzombiedroploot = level.objectives[level.ref_12BBE[var_30]];
    } else {
      level.prevzoneindex++;

      if(level.prevzoneindex > level.objectives.size) {
        level.prevzoneindex = 1;
      }

      var_23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
      var_30 = level.prevzoneindex + 1;

      if(var_30 > level.objectives.size) {
        var_30 = 2;
      }

      level.playerzombiedroploot = level.objectives[scripts\engine\utility::string(var_30)];
    }

    level.playerzombiedroploot thread scripts\mp\gametypes\obj_zonecapture::ref_144DA();
  }

  return var_23;
}

function spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone scripts\mp\gametypes\obj_zonecapture::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  } else {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  }

  scripts\mp\utility\game::ref_119AC(undefined, undefined, "New Hardpoint", level.zone.trigger.origin);
  level.zone thread scripts\common\utility::ref_13E0A(level.ref_11B29, "hill_moved", level.zone.trigger.origin);
}

function hqactivatenextzone(var_0, var_1) {
  jumpiffalse(var_1) LOC_00000040;

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("obj_generic_capture", var_3);
  }

  goto LOC_00000073;
}

function locktimeruntilcap() {
  level endon("zone_captured");

  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    waitframe();
  }
}

function hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("enemy");
    level.zone scripts\mp\gameobjects::setvisibleteam("any");
    level.zone scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");

    if(!level.usehqrules) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
      level.zone scripts\mp\gameobjects::cancontestclaim(1);
    }

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      level thread scripts\mp\gametypes\grnd::randomdrops();
    }

    var_0 = level scripts\engine\utility::ref_143AD("zone_captured", "zone_destroyed");

    if(var_0 == "zone_destroyed") {
      continue;
    }

    var_1 = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_positive", var_1);
    scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_negative", scripts\mp\utility\game::getotherteam(var_1)[0]);

    if(level.usehqrules && level.zoneduration > 0) {
      thread movezoneaftertime(level.zoneduration);
    }

    level waittill("zone_destroyed", var_2);

    if(isDefined(var_2)) {
      level.zone scripts\mp\gameobjects::setownerteam(var_2);
    } else {
      level.zone scripts\mp\gameobjects::setownerteam("none");
    }

    if(level.usehqrules) {
      setomnvar("ui_hq_status", -1);
      break;
    }
  }
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_koth_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_koth_spawn_axis_start");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn_secondary", 1, 1);

  if(!isDefined(level.spawnpoints) || istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", var_2);
    scripts\mp\spawnlogic::registerspawnset("fallback", var_3);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.binoculars_clearuidata)) {
    return;
  }

  foreach(var_5 in level.objectives) {
    var_5.furthestspawndistsq = 0;
    var_5.spawnpoints = [];
    var_5.fallbackspawnpoints = [];
  }

  foreach(var_8 in level.spawnpoints) {
    var_9 = var_8.classname == "mp_koth_spawn_allies_start" || var_8.classname == "mp_koth_spawn_axis_start";
    var_10 = 0;
    var_11 = var_8.classname == "mp_koth_spawn";
    var_12 = var_8.classname == "mp_koth_spawn_secondary";
    var_13 = [];

    if(var_9) {
      continue;
    }

    if(var_11 || var_12) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy != "") {
        var_10 = 1;
        var_13 = strtok(var_8.script_noteworthy, " ");

        foreach(var_15 in var_13) {
          if(var_15 == "6v6" || var_15 == "10v10") {
            continue;
          }

          if(!postshipmodifiedzones(var_15)) {
            var_5 = level.objectives[var_15];

            if(var_11) {
              var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
              continue;
            }

            var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
          }
        }
      }
    }

    calculatespawndisttozones(var_8, var_13);
    var_17 = scripts\mp\spawnlogic::getoriginidentifierstring(var_8);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var_17])) {
      foreach(var_15 in level.kothextraprimaryspawnpoints[var_17]) {
        var_5 = level.objectives[var_15];
        var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
      }
    }

    if(!var_10) {
      foreach(var_5 in level.objectives) {
        if(var_11) {
          var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
          continue;
        }

        var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
      }
    }
  }

  foreach(var_5 in level.objectives) {
    var_5.spawnset = "koth_" + var_24;
    scripts\mp\spawnlogic::registerspawnset(var_5.spawnset, var_5.spawnpoints);
    var_5.fallbackspawnset = "koth_fallback_" + var_24;
    scripts\mp\spawnlogic::registerspawnset(var_5.fallbackspawnset, var_5.fallbackspawnpoints);
  }
}

function calculatespawndisttozones(var_0, var_1) {
  var_2 = 0;
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_4 in level.objectives) {
    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "") {
      var_2 = 1;
    } else {
      foreach(var_6 in var_1) {
        if(var_6 == var_4.trigger.objectivekey) {
          var_2 = 1;
          break;
        }
      }
    }

    if(!var_2) {
      continue;
    }

    var_8 = getpathdist(var_0.origin, var_4.trigger.baseorigin, 5000);

    if(var_8 < 0) {
      var_8 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_4.trigger.baseorigin);
    } else {
      var_8 *= var_8;
    }

    var_0.scriptdata.distsqtokothzones[var_4.trigger getentitynumber()] = var_8;

    if(var_8 > var_4.furthestspawndistsq) {
      var_4.furthestspawndistsq = var_8;
    }
  }
}

function comparezoneindexes(var_0, var_1) {
  var_2 = int(var_0.objectivekey);
  var_3 = int(var_1.objectivekey);

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return false;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return true;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return false;
  }

  if(var_2 > var_3) {
    return true;
  }

  return false;
}

function getzonearray(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3.objectivekey = var_3.script_label;
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  var_5 = 1;

  for(var_6 = var_1.size; var_5; var_6--) {
    var_5 = 0;

    for(var_7 = 0; var_7 < var_6 - 1; var_7++) {
      if(comparezoneindexes(var_1[var_7], var_1[var_7 + 1])) {
        var_8 = var_1[var_7];
        var_1 = var_1[var_7 + 1];
        var_1 = var_8;
        var_5 = 1;
      }
    }
  }

  return var_1;
}

function setupzones() {
  var_0 = getzonearray("hardpoint_zone");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2];
  }

  level.objectives = [];

  foreach(var_4 in var_1) {
    var_5 = scripts\mp\gametypes\obj_zonecapture::setupobjective(var_4);
    level.objectives[var_5.objectivekey] = var_5;
  }

  var_7 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  var_8 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  level.startpos["allies"] = var_8[0].origin;
  level.startpos["axis"] = var_7[0].origin;
  return true;
}

function setupzoneareabrushes() {
  level.neutralzonebrushes = [];
  level.contestedzonebrushes = [];
  level.friendlyzonebrushes = [];
  level.enemyzonebrushes = [];
  var_0 = getzonearray("hardpoint_zone_visual");
  var_1 = getzonearray("hardpoint_zone_visual_contest");
  var_2 = getzonearray("hardpoint_zone_visual_friend");
  var_3 = getzonearray("hardpoint_zone_visual_enemy");

  if(!isDefined(var_0)) {
    level.usehpzonebrushes = 0;
  } else {
    level.usehpzonebrushes = 1;
  }

  if(istrue(level.usehpzonebrushes)) {
    foreach(var_5 in var_0) {
      level.neutralzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_1) {
      level.contestedzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_2) {
      level.friendlyzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_3) {
      level.enemyzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    postshipmodifiedzonebrushes();
    thread matchbrushestozones();
    return;
  }
}

function postshipmodifiedzonebrushes() {
  if(level.mapname == "mp_parkour") {
    for(var_0 = 0; var_0 < level.neutralzonebrushes.size; var_0++) {
      if(level.neutralzonebrushes[var_0].script_label == "1") {
        level.neutralzonebrushes[var_0] hide();
        var_1 = spawn("script_model", (0, 0, 0));
        var_1 setModel("mp_parkour_hardpoint_floor_01");
        var_1.angles = (0, 0, 0);
        var_1.script_label = "1";
        level.neutralzonebrushes[var_0] = var_1;
      }
    }

    for(var_0 = 0; var_0 < level.contestedzonebrushes.size; var_0++) {
      if(level.contestedzonebrushes[var_0].script_label == "1") {
        level.contestedzonebrushes[var_0] hide();
        var_2 = spawn("script_model", (0, 0, 0));
        var_2 setModel("mp_parkour_hardpoint_floor_01_contest");
        var_2.angles = (0, 0, 0);
        var_2.script_label = "1";
        level.contestedzonebrushes[var_0] = var_2;
      }
    }

    for(var_0 = 0; var_0 < level.friendlyzonebrushes.size; var_0++) {
      if(level.friendlyzonebrushes[var_0].script_label == "1") {
        level.friendlyzonebrushes[var_0] hide();
        var_3 = spawn("script_model", (0, 0, 0));
        var_3 setModel("mp_parkour_hardpoint_floor_01_friend");
        var_3.angles = (0, 0, 0);
        var_3.script_label = "1";
        level.friendlyzonebrushes[var_0] = var_3;
      }
    }

    for(var_0 = 0; var_0 < level.enemyzonebrushes.size; var_0++) {
      if(level.enemyzonebrushes[var_0].script_label == "1") {
        level.enemyzonebrushes[var_0] hide();
        var_4 = spawn("script_model", (0, 0, 0));
        var_4 setModel("mp_parkour_hardpoint_floor_01_enemy");
        var_4.angles = (0, 0, 0);
        var_4.script_label = "1";
        level.enemyzonebrushes[var_0] = var_4;
      }
    }

    return;
  }
}

function matchbrushestozones() {
  foreach(var_1 in level.objectives) {
    var_1.neutralbrush = level.neutralzonebrushes[var_1.objectivekey];
    var_1.enemybrush = level.enemyzonebrushes[var_1.objectivekey];
    var_1.contestedbrush = level.contestedzonebrushes[var_1.objectivekey];
    var_1.friendlybrush = level.friendlyzonebrushes[var_1.objectivekey];
  }
}

function setupzonecallouts() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.zone.visuals[0];

  foreach(var_5 in level.calloutglobals.areatriggers) {
    var_1 = ispointinvolume(var_3.baseorigin, var_5);
    var_2 = isDefined(var_3.script_noteworthy) && isDefined(var_5.script_noteworthy) && var_3.script_noteworthy == var_5.script_noteworthy;

    if(var_1 || var_2) {
      var_0 = level.calloutglobals.areaidmap[var_5.script_noteworthy];

      foreach(var_7 in level.players) {
        if(isDefined(var_0)) {
          var_7 setclientomnvar("ui_hp_callout_id", var_0);
        }
      }

      break;
    }
  }

  scripts\mp\utility\game::setmlgannouncement(4, "free");
}

function forcespawnplayers() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }

    var_2 notify("force_spawn");
    waitframe();
  }
}

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = getkothzonedeadzonedist();
  var_2 = [];
  GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.zone.trigger getentitynumber());
}

function getkothzonedeadzonedist() {
  return 1000;
}

function onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
}

function movezoneaftertime(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = var_0;
  level.zonedestroyedbytimer = 0;
  scripts\mp\gametypes\obj_zonecapture::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(var_1 == self) {
    return;
  }

  if(!isDefined(level.zone)) {
    return;
  }

  var_10 = level.zone.ownerteam;

  if(!isDefined(var_10)) {
    return;
  }

  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }

  var_11 = self;
  var_12 = 0;
  var_13 = var_1.team;

  if(level.zonecapturetime > 0 && var_1 istouching(level.zone.trigger)) {
    if(var_10 != var_13) {
      var_12 = 1;
    }
  }

  if(var_13 != var_10) {
    if(var_12) {
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      return;
    }

    if(var_11 istouching(level.zone.trigger)) {
      var_1 thread scripts\mp\rank::scoreeventpopup("assault");
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
      thread scripts\common\utility::ref_13E0A(level.ref_11B30, var_9, "defending");
      return;
    }

    return;
  }

  if(var_1 istouching(level.zone.trigger)) {
    var_1 thread scripts\mp\rank::scoreeventpopup("defend");
    var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["defends"]);
    return;
  }
}

function give_capture_credit(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  scripts\mp\utility\game::ref_119AC(var_4, undefined, "Hardpoint Captured", var_4.origin);
  var_6 = var_4;

  if(isDefined(var_6.owner)) {
    var_6 = var_6.owner;
  }

  if(isPlayer(var_6)) {
    var_6 thread scripts\common\utility::ref_13E0A(level.ref_11B29, "capture", var_6.origin);

    if(unset_forced_aitype_armored(var_6) && !scripts\mp\utility\game::isanymlgmatch()) {} else if(!isscoreboosting(var_6)) {
      var_6 thread scripts\mp\rank::scoreeventpopup("hp_secure");
      var_6 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");
    } else {
      var_6 thread scripts\mp\rank::scoreeventpopup("hp_secure");
      var_6 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure_reduced");
    }

    if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
      var_6 thread scripts\mp\rank::scoreeventpopup("hp_quick_cap");
      var_6 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
    }

    if(var_6.lastkilltime + 500 > gettime()) {} else {
      var_6 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var_6);
    }
  }

  var_7 = getarraykeys(var_0);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_0[var_7[var_8]].player;
    updatecapsperminute(var_9, var_3);

    if(!isscoreboosting(var_9)) {
      var_9 scripts\mp\utility\stats::incpersstat("captures", 1);
      var_9 scripts\mp\persistence::statsetchild("round", "captures", var_9.pers["captures"]);
    }

    if(var_6 != var_9) {
      var_9 thread scripts\mp\rank::scoreeventpopup("capture_assist");
      var_9 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_assist");
      var_9 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var_9);
    }

    wait 0.05;
  }
}

function awardcapturepoints() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    for(var_2 = 0; var_2 < var_0 && !level.gameended; var_2 = 0) {
      wait level.framedurationseconds;
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 += level.framedurationseconds;

      if(level.zone.stalemate) {}
    }

    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_3 == "neutral") {
      continue;
    }

    if(level.gameended) {
      break;
    }

    if(level.usehqrules) {
      if(level.zoneadditivescoring) {
        var_1 = level.zone.touchlist[var_3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);
      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring) {
        var_1 = level.zone.touchlist[var_3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);

      foreach(var_5 in level.zone.touchlist[var_3]) {
        var_5.player scripts\mp\utility\stats::incpersstat("objTime", 1);

        if(isDefined(var_5.player.timebyrotation[level.kothhillrotation])) {
          var_5.player.timebyrotation[level.kothhillrotation]++;
        } else {
          var_5.player.timebyrotation[level.kothhillrotation] = 1;
        }

        var_5.player scripts\mp\persistence::statsetchild("round", "objTime", var_5.player.pers["objTime"]);
        var_5.player scripts\mp\utility\stats::setextrascore0(var_5.player.pers["objTime"]);

        if(isDefined(var_5.player.spawn_sentry_at_pos) && var_5.player.spawn_sentry_at_pos > 3) {
          var_5.player.spawn_sentry_at_pos = 0;

          if(scripts\mp\utility\game::getgametype() == "koth") {
            var_5.player scripts\mp\utility\points::giveunifiedpoints("koth_in_obj", undefined, 15);
          } else if(scripts\mp\utility\game::getgametype() == "grnd") {
            var_5.player scripts\mp\utility\points::giveunifiedpoints("grnd_in_obj", undefined, 15);
          }

          continue;
        }

        if(!isDefined(var_5.player.spawn_sentry_at_pos)) {
          var_5.player.spawn_sentry_at_pos = 0;
        } else {
          var_5.player.spawn_sentry_at_pos++;
        }

        var_5.player scripts\mp\gamescore::giveplayerscore("koth_in_obj", 10);
      }
    }
  }
}

function updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "neutral") {
    return;
  }

  self.numcaps++;
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    var_1 = self.timeplayed["total"] / 60;
  }

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
    return;
  }
}

function isscoreboosting(var_0) {
  if(var_0.capsperminute > 3) {
    return true;
  }

  return false;
}

function unset_forced_aitype_armored(var_0) {
  if(var_0.capsperminute > 6) {
    return true;
  }

  return false;
}

function onplayerconnect(var_0) {
  var_0._hardpointeffect = [];
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["objTime"])) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["objTime"]);
  }

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["defends"])) {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["defends"]);
  }

  thread onplayerspawned(var_0);

  foreach(var_2 in level.objectives) {
    if(istrue(level.usehpzonebrushes)) {
      var_2 scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var_0);
    }
  }

  thread refreshfreecamhardpointfx();
}

function onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");

    foreach(var_2 in level.objectives) {
      if(istrue(var_2.active)) {
        if(var_2.ownerteam == "neutral") {
          var_2 scripts\mp\gametypes\obj_zonecapture::playhardpointneutralfx();
          continue;
        }

        var_2 scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(var_2.ownerteam, var_0);
      }
    }
  }
}

function updateservericons(var_0, var_1) {
  var_2 = -1;

  if(var_1) {
    var_2 = -2;
  } else if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
    var_3 = thread getownerteamplayer(var_0);

    if(isDefined(var_3)) {
      var_2 = var_3 getentitynumber();
    }
  } else {
    switch (var_0) {
      case "zone_activation_delay":
        var_2 = -3;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_hardpoint", var_2);
}

function getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

function refreshfreecamhardpointfx() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "mlg_view_change") {
      foreach(var_3 in level.objectives) {
        if(var_3.ownerteam != "neutral") {
          var_3 scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(var_3.ownerteam, self);
        }
      }
    }
  }
}

function getrespawndelay() {
  if(!level.delayplayer) {
    return undefined;
  }

  var_0 = level.zone.ownerteam;

  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level.spawndelay) {
        return undefined;
      }

      return level.spawndelay;
    }

    return;
  }
}

function postshipmodifiedzones(var_0) {
  if(level.mapname == "mp_fallen" && var_0 == "5") {
    return true;
  }

  return false;
}

function writeplayerrotationscoretomatchdataongameend() {
  level waittill("game_ended");
  writecurrentrotationteamscore();
}

function writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
    return;
  }
}

function setkothwaypoints() {
  scripts\mp\gamelogic::setwaypointiconinfo("koth_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_koth", 1);
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(istrue(level.ref_14726)) {
    self setclientomnvar("ui_match_status_hint_text", 36);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", 35);
}