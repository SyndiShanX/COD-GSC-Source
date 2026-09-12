/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grnd.gsc
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
  setdynamicdvar("scr_grnd_dropTime", getmatchrulesdata("grndData", "dropTime"));
  setdynamicdvar("scr_grnd_enableVariantDZ", getmatchrulesdata("grndData", "enableVariantDZ"));
  setdynamicdvar("scr_grnd_zoneLifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_grnd_zoneCaptureTime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_grnd_firstZoneActivationDelay", getmatchrulesdata("kothData", "firstZoneActivationDelay"));
  setdynamicdvar("scr_grnd_zoneActivationDelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_grnd_randomLocationOrder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_grnd_additiveScoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_grnd_pauseTime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_grnd_delayPlayer", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("scr_grnd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("grnd", 0);
  setdynamicdvar("scr_grnd_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/GRND");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/GRND");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/GRND_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/DOM_HINT");
  }

  thread setupzones();
  setmapsizespawnconsts();
  initspawns();
  thread dzmainloop();

  if(level.droptime > 0) {
    thread randomdrops();
    return;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.droptime = scripts\mp\utility\dvars::dvarfloatvalue("dropTime", 15, 0, 60);
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("firstZoneActivationDelay", 30, 0, 120);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneActivationDelay", 30, 0, 120);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.ref_1221A = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
  level.enablevariantdrops = scripts\mp\utility\dvars::dvarintvalue("enableVariantDZ", 0, 0, 1);
  level.usehqrules = 0;
  level.usehprules = 1;

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

function setmapsizespawnconsts() {
  var_0 = getsubstr(level.mapname, 0, 7);

  switch (var_0) {
    case "mp_aniyah":
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 225000000;
      level.max_relevant_spawn_dist = 7000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    case "mp_shipment":
      level.spawn_deadzone_dist = 500;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    default:
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
  }
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  enablespawnpointbyindex("mp_tdm_spawn");
  level.spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

  if(!level.spawnpoints.size) {
    return;
  }

  foreach(var_3 in level.objectives) {
    var_3.furthestspawndistsq = 0;
    var_3.spawnpoints = [];
    var_3.fallbackspawnpoints = [];
  }

  foreach(var_6 in level.spawnpoints) {
    calculatespawndisttozones(var_6);
    var_7 = scripts\mp\spawnlogic::getoriginidentifierstring(var_6);

    if(isDefined(level.grndextraprimaryspawnpoints) && isDefined(level.grndextraprimaryspawnpoints[var_7])) {
      foreach(var_9 in level.grndextraprimaryspawnpoints[var_7]) {
        var_3 = level.objectives[var_9];
        var_3.spawnpoints[var_3.spawnpoints.size] = var_6;
      }
    }

    var_11 = 0;
    var_12 = var_6.classname == "mp_tdm_spawn_allies_start" || var_6.classname == "mp_tdm_spawn_axis_start";
    var_13 = var_6.classname == "mp_tdm_spawn";
    var_14 = var_6.classname == "mp_tdm_spawn_secondary";

    if(var_12) {
      continue;
    }

    if(var_13 || var_14) {
      if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy != "") {
        foreach(var_3 in level.objectives) {
          if(var_13) {
            var_3.spawnpoints[var_3.spawnpoints.size] = var_6;
            continue;
          }

          var_3.fallbackspawnpoints[var_3.fallbackspawnpoints.size] = var_6;
        }
      }
    }

    calculatespawndisttozones(var_6);

    if(!var_11) {
      foreach(var_3 in level.objectives) {
        if(var_6.scriptdata.distsqtokothzones[var_3.trigger getentitynumber()] < level.close_spawn_min_dist_sq || var_6.scriptdata.distsqtokothzones[var_3.trigger getentitynumber()] > level.max_spawn_dist_sq) {
          var_6.removespawn = 1;
        }

        if(var_13) {
          if(!isDefined(var_6.removespawn)) {
            var_3.spawnpoints[var_3.spawnpoints.size] = var_6;
          }
        } else {
          var_3.fallbackspawnpoints[var_3.fallbackspawnpoints.size] = var_6;
        }

        var_6.removespawn = undefined;
      }
    }
  }

  foreach(var_3 in level.objectives) {
    var_3.spawnset = "dropzone_" + var_21;
    scripts\mp\spawnlogic::registerspawnset(var_3.spawnset, var_3.spawnpoints);
    var_3.fallbackspawnset = "dropzone_fallback_" + var_21;
    scripts\mp\spawnlogic::registerspawnset(var_3.fallbackspawnset, var_3.fallbackspawnpoints);
  }
}

function calculatespawndisttozones(var_0, var_1) {
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_3 in level.objectives) {
    var_4 = getpathdist(var_0.origin, var_3.origin, level.max_relevant_spawn_dist);

    if(var_4 < 0) {
      var_4 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_3.origin);
    } else {
      var_4 *= var_4;
    }

    var_0.scriptdata.distsqtokothzones[var_3.trigger getentitynumber()] = var_4;

    if(var_4 > var_3.furthestspawndistsq) {
      var_3.furthestspawndistsq = var_4;
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
  var_0 = getzonearray("grnd");

  if(level.mapname == "mp_piccadilly") {
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1547, -1512, 165)) < 10) {
        var_2.origin -= (0, 0, 10);
      }
    }
  } else if(level.mapname == "mp_aniyah") {
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1117, 2295, 398)) < 10) {
        var_2.origin -= (0, 0, 10);
        continue;
      }

      if(distance(var_2.origin, (-4501, -2, 322)) < 10) {
        var_2.script_label = "9";
        continue;
      }

      if(distance(var_2.origin, (-4474, 1159, 388)) < 10) {
        var_2.origin -= (0, 0, 20);
      }
    }
  }

  var_6 = [];
  var_7 = scripts\engine\utility::getStructArray("dz_flare", "targetname");
  var_8 = [];
  var_9 = [];

  if(level.mapname == "mp_shipment") {
    foreach(var_2 in var_0) {
      if(var_2.script_label == "1" && distance(var_2.origin, (-333, 1999, 119)) < 5) {
        var_8 = var_2;
        continue;
      }

      if(var_2.script_label == "2" && distance(var_2.origin, (189, 1564, 75)) < 5) {
        var_8 = var_2;
        continue;
      }

      if(var_2.script_label == "3" && distance(var_2.origin, (-751, 2416, 81)) < 5) {
        var_8 = var_2;
        continue;
      }

      if(var_2.script_label == "4" && distance(var_2.origin, (165, 2420, 79)) < 5) {
        var_8 = var_2;
        continue;
      }

      if(var_2.script_label == "5" && distance(var_2.origin, (-823, 1536, 68)) < 5) {
        var_8 = var_2;
      }
    }

    var_0 = scripts\engine\utility::array_remove_array(var_0, var_8);

    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (192.944, 1583.51, 16.344)) < 5) {
        var_9 = var_13;
        continue;
      }

      if(distance(var_13.origin, (-743.056, 2447.51, 17.844)) < 5) {
        var_9 = var_13;
        continue;
      }

      if(distance(var_13.origin, (152.944, 2415.51, 16.344)) < 5) {
        var_9 = var_13;
        continue;
      }

      if(distance(var_13.origin, (-334.5, 1990.5, 17.25)) < 5) {
        var_9 = var_13;
        continue;
      }

      if(distance(var_13.origin, (-751.056, 1479.51, 16.844)) < 5) {
        var_9 = var_13;
      }
    }

    var_7 = scripts\engine\utility::array_remove_array(var_7, var_9);
  } else if(level.mapname == "mp_hardbor") {
    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (4491, -942, 183.25)) < 5) {
        var_9 = var_13;
      }
    }

    var_7 = scripts\engine\utility::array_remove_array(var_7, var_9);
  } else if(level.mapname == "mp_killhouse") {
    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (99, 830.5, 11.25)) < 5) {
        var_13.origin = (-22.5, 86.5, 11);
        continue;
      }

      if(distance(var_13.origin, (-531.5, -485.5, 11.25)) < 5) {
        var_13.origin = (265, 845.5, 10);
        continue;
      }

      if(distance(var_13.origin, (-586, 567.5, 11.25)) < 5) {
        var_13.origin = (-339.5, -509.5, 10);
        continue;
      }

      if(distance(var_13.origin, (-38, -738.5, 11.25)) < 5) {
        var_13.origin = (-452, 599.5, 10);
      }
    }
  }

  foreach(var_13 in var_7) {
    var_20 = spawn("script_model", var_13.origin);
    var_20.angles = var_13.angles;
    var_20 setModel("dz_flare_scriptable");
    var_13.scriptable = var_20;
  }

  var_22 = [];
  level.objectives = [];

  for(var_23 = 0; var_23 < var_7.size; var_23++) {
    var_24 = 0;
    var_13 = var_7[var_23];
    var_2 = undefined;

    for(var_25 = 0; var_25 < var_0.size; var_25++) {
      if(var_13.scriptable istouching(var_0[var_25])) {
        if(isDefined(var_2)) {
          var_6 = "flare at " + var_13.origin + " is touching more than one \"flaretrigger\" trigger";
          var_24 = 1;
          break;
        }

        var_2 = var_0[var_25];
        break;
      }
    }

    if(!isDefined(var_2)) {
      if(!var_24) {
        var_6 = "flare at " + var_13.origin + " is not inside any \"flaretrigger\" trigger";
        continue;
      }
    }

    var_22 = [];
    var_22 = var_13.scriptable;
    var_26 = scripts\mp\gametypes\obj_zonecapture::setupobjective(var_2, var_22);
    var_26.origin = var_2.origin;
    level.objectives[var_26.objectivekey] = var_26;
  }

  if(var_6.size > 0) {
    for(var_23 = 0; var_23 < var_6.size; var_23++) {}

    return;
  }

  return 1;
}

function dzmainloop() {
  level endon("game_ended");
  seticonnames();
  initwaypointicons();
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
  level.zone thread scripts\common\utility::ref_13E0A(level.ref_11B29, "hill_moved", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  var_1 = 0;

  if(level.firstzoneactivationdelay) {
    var_1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 6);
    level.ref_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 42, 42);
    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199E(level.firstzoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait level.firstzoneactivationdelay;
    level.ref_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 41, 41);
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_obj_new");

  for(;;) {
    if(!isDefined(level.ref_11AD5)) {
      thread setupzonecallouts();
    }

    level.zone.visuals[0] setscriptablepartstate("smoke", "idle", 0);
    level.objectivesetorder = 1;
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
    setomnvar("ui_hq_status", 8);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var_2 = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.ref_1221A) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
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

    setomnvar("ui_hq_status", -1);
    wait 1;
  }
}

function getfirstzone() {
  if(level.mapname == "mp_hardhat") {
    var_0 = level.objectives["5"];
    level.prevzoneindex = 5;
  } else {
    var_0 = level.objectives["1"];
    level.prevzoneindex = 1;
  }

  return var_0;
}

function getnextzone() {
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
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size) {
      level.prevzoneindex = 1;
    }

    var_23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
  }

  return var_23;
}

function spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone.visuals[0] setscriptablepartstate("smoke", "off", 0);
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
    level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
    level.zone scripts\mp\gameobjects::cancontestclaim(1);

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      thread randomdrops();
    }

    var_0 = level scripts\engine\utility::ref_143AD("zone_captured", "zone_destroyed");
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", var_1);
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", scripts\mp\utility\game::getotherteam(var_1)[0]);
    thread updaterespawntimer();
    level waittill("zone_destroyed", var_2);
    level.spawndelay = undefined;

    if(isDefined(var_2)) {
      level.zone scripts\mp\gameobjects::setownerteam(var_2);
      continue;
    }

    level.zone scripts\mp\gameobjects::setownerteam("none");
    LOC_00000106:
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
    for(var_2 = 0; var_2 < var_0; var_2 = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 += level.framedurationseconds;

      if(level.zone.stalemate) {}
    }

    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_3 == "neutral") {
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
        var_5.player scripts\mp\gamescore::giveplayerscore("koth_in_obj", 10);
      }
    }
  }
}

function movezoneaftertime(var_0) {
  level notify("startMoveTimer");
  level endon("startMoveTimer");
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

function give_capture_credit(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  var_6 = var_4;

  if(isDefined(var_6.owner)) {
    var_6 = var_6.owner;
  }

  if(isPlayer(var_6)) {
    if(!isscoreboosting(var_6)) {
      var_6 thread scripts\common\utility::ref_13E0A(level.ref_11B29, "capture", var_6.origin);
      var_6 thread scripts\mp\utility\points::giveunifiedpoints("dz_capture");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
        var_6 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
      }

      if(var_6.lastkilltime + 500 > gettime()) {} else {
        var_6 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var_6);
      }
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

function randomdrops() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.grnd_previouscratetypes = [];

  for(;;) {
    var_0 = getbestplayer();
    var_1 = 1;

    if(isDefined(var_0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      var_2 = getdropzonecratetype();
      var_3 = getnodesintrigger(level.zone.trigger);

      if(level.mapname == "mp_killhouse") {
        var_4 = relic_shieldsonly_set_player_stats_after_spawn();
      } else {
        var_4 = relic_shieldsonly_set_player_stats_after_spawn() + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
      }

      if(var_3 == "mega") {
        var_5 = spawnStruct();
        var_5.cratetype = undefined;
        var_5.numcrates = undefined;
        var_5.usephysics = undefined;
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_1, var_1.team, var_4, randomfloat(360), var_4, var_5);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(var_1, var_1.team, var_3, var_4, randomfloat(360), var_4, 1);
      }

      var_2 = level.droptime;
    } else {
      var_2 = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  }
}

function ref_132F5(var_0) {
  if(var_0 == "mega") {
    return false;
  }

  if(level.mapname == "mp_vacant") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_aniyah")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1") {
      return false;
    }
  } else if(level.mapname == "mp_raid") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "6") {
      return false;
    }
  } else if(level.mapname == "mp_petrograd") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_hackney")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_shipment")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_emporium")) {
    return false;
  } else if(level.mapname == "mp_backlot2") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "5") {
      return false;
    }
  }

  return true;
}

function relic_shieldsonly_set_player_stats_after_spawn() {
  if(level.mapname == "mp_vacant" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4") {
    return (1760, 701, 122);
  } else if(level.mapname == "mp_emporium" && isDefined(level.zone.trigger.script_label)) {
    switch (level.zone.trigger.script_label) {
      case "1":
        return (-732, -136, 608);
      case "2":
        return (672, -1336, 608);
      case "3":
        return (44, 968, 608);
      case "4":
        return (-680, -1552, 608);
      case "5":
        return (832, 4, 608);
    }
  } else if(level.mapname == "mp_backlot2" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "5") {
    return (-346, -2368, 66);
  } else if(level.mapname == "mp_herat" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "2") {
    return (-2057, 1042, 150);
  } else if(level.mapname == "mp_m_speed" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "3") {
    return (-100, 1780, 82);
  } else if(level.mapname == "mp_killhouse" && isDefined(level.zone.trigger.script_label)) {
    switch (level.zone.trigger.script_label) {
      case "1":
        var_0 = [(-589, -479, 68), (289, 830, 68), (-589, -479, 68), (301, 525, 68)];
        var_1 = scripts\engine\utility::random(var_0);
        return var_1;
      case "2":
        return (289, 830, 68);
      case "3":
        return (-589, -479, 68);
      case "4":
        return (-301, 525, 68);
    }
  }

  return level.zone.origin;
}

function getbestplayer() {
  var_0 = undefined;
  var_1 = 0;
  var_2 = level.zone scripts\mp\gameobjects::getownerteam();

  if(var_2 == "neutral") {
    return var_0;
  }

  foreach(var_4 in level.zone.touchlist[var_2]) {
    if(var_1 == 0 || var_1 > var_4.starttime) {
      var_1 = var_4.starttime;
      var_0 = var_4.player;
    }
  }

  return var_0;
}

function getdropzonecratetype() {
  var_0 = undefined;

  if(level.mapname != "mp_killhouse" && !isDefined(level.grnd_previouscratetypes["mega"]) && randomintrange(0, 100) < 5) {
    var_0 = "mega";
  } else {
    if(level.grnd_previouscratetypes.size) {
      for(var_1 = 200; var_1; var_1--) {
        var_0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

        if(isDefined(level.grnd_previouscratetypes[var_0])) {
          var_0 = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(var_0)) {
      var_0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
    }
  }

  level.grnd_previouscratetypes[var_0] = 1;

  if(level.grnd_previouscratetypes.size == 15) {
    level.grnd_previouscratetypes = [];
  }

  return var_0;
}

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = getobjzonedeadzonedist();
  var_2 = [];
  GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.zone.visuals[0] getentitynumber());
}

function getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

function removespawnsinactivedz(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.zone.trigger)) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function onplayerconnect(var_0) {
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
    return;
  }
}

function onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  thread updatematchstatushintonspawn();
  level.ref_12305 = 30;
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

function updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var_0 = gettime();

  if(level.zoneduration > 0) {
    var_1 = var_0 + level.zoneduration * 1000;
  } else {
    var_1 = var_1 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
  }

  var_2 = var_1;

  while(var_2 < var_1) {
    var_2 = gettime();
    level.spawndelay = (var_1 - var_2) / 1000 + 0.1;
    waitframe();
  }
}

function seticonnames() {
  level.icontarget = "dz_target";
  level.iconneutral = "dz_neutral";
  level.iconcapture = "dz_enemy";
  level.icondefend = "dz_friendly";
  level.iconcontested = "dz_contested";
  level.icontaking = "dz_taking";
  level.iconlosing = "dz_losing";
  level.icondefending = "dz_defending";
}

function initwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("dz_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dz", 1);
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

function writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
    return;
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
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(istrue(level.ref_14726)) {
    self setclientomnvar("ui_match_status_hint_text", 42);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", 41);
}