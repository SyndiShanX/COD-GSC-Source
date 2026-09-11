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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/GRND");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/GRND");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/GRND_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/DOM_HINT");
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
  level.ref_1221a = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
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
  var0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var0) {
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
  var0 = getsubstr(level.mapname, 0, 7);

  switch (var0) {
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
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

  foreach(var3 in level.objectives) {
    var3.furthestspawndistsq = 0;
    var3.spawnpoints = [];
    var3.fallbackspawnpoints = [];
  }

  foreach(var6 in level.spawnpoints) {
    calculatespawndisttozones(var6);
    var7 = scripts\mp\spawnlogic::getoriginidentifierstring(var6);

    if(isDefined(level.grndextraprimaryspawnpoints) && isDefined(level.grndextraprimaryspawnpoints[var7])) {
      foreach(var9 in level.grndextraprimaryspawnpoints[var7]) {
        var3 = level.objectives[var9];
        var3.spawnpoints[var3.spawnpoints.size] = var6;
      }
    }

    var11 = 0;
    var12 = var6.classname == "mp_tdm_spawn_allies_start" || var6.classname == "mp_tdm_spawn_axis_start";
    var13 = var6.classname == "mp_tdm_spawn";
    var14 = var6.classname == "mp_tdm_spawn_secondary";

    if(var12) {
      continue;
    }

    if(var13 || var14) {
      if(isDefined(var6.script_noteworthy) && var6.script_noteworthy != "") {
        foreach(var3 in level.objectives) {
          if(var13) {
            var3.spawnpoints[var3.spawnpoints.size] = var6;
            continue;
          }

          var3.fallbackspawnpoints[var3.fallbackspawnpoints.size] = var6;
        }
      }
    }

    calculatespawndisttozones(var6);

    if(!var11) {
      foreach(var3 in level.objectives) {
        if(var6.scriptdata.distsqtokothzones[var3.trigger getentitynumber()] < level.close_spawn_min_dist_sq || var6.scriptdata.distsqtokothzones[var3.trigger getentitynumber()] > level.max_spawn_dist_sq) {
          var6.removespawn = 1;
        }

        if(var13) {
          if(!isDefined(var6.removespawn)) {
            var3.spawnpoints[var3.spawnpoints.size] = var6;
          }
        } else {
          var3.fallbackspawnpoints[var3.fallbackspawnpoints.size] = var6;
        }

        var6.removespawn = undefined;
      }
    }
  }

  foreach(var3 in level.objectives) {
    var3.spawnset = "dropzone_" + var21;
    scripts\mp\spawnlogic::registerspawnset(var3.spawnset, var3.spawnpoints);
    var3.fallbackspawnset = "dropzone_fallback_" + var21;
    scripts\mp\spawnlogic::registerspawnset(var3.fallbackspawnset, var3.fallbackspawnpoints);
  }
}

function calculatespawndisttozones(var0, var1) {
  var0.scriptdata.distsqtokothzones = [];

  foreach(var3 in level.objectives) {
    var4 = getpathdist(var0.origin, var3.origin, level.max_relevant_spawn_dist);

    if(var4 < 0) {
      var4 = scripts\engine\utility::distance_2d_squared(var0.origin, var3.origin);
    } else {
      var4 *= var4;
    }

    var0.scriptdata.distsqtokothzones[var3.trigger getentitynumber()] = var4;

    if(var4 > var3.furthestspawndistsq) {
      var3.furthestspawndistsq = var4;
    }
  }
}

function comparezoneindexes(var0, var1) {
  var2 = int(var0.objectivekey);
  var3 = int(var1.objectivekey);

  if(!isDefined(var2) && !isDefined(var3)) {
    return false;
  }

  if(!isDefined(var2) && isDefined(var3)) {
    return true;
  }

  if(isDefined(var2) && !isDefined(var3)) {
    return false;
  }

  if(var2 > var3) {
    return true;
  }

  return false;
}

function getzonearray(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3.objectivekey = var3.script_label;
  }

  if(!isDefined(var1) || var1.size == 0) {
    return undefined;
  }

  var5 = 1;

  for(var6 = var1.size; var5; var6--) {
    var5 = 0;

    for(var7 = 0; var7 < var6 - 1; var7++) {
      if(comparezoneindexes(var1[var7], var1[var7 + 1])) {
        var8 = var1[var7];
        var1 = var1[var7 + 1];
        var1 = var8;
        var5 = 1;
      }
    }
  }

  return var1;
}

function setupzones() {
  var0 = getzonearray("grnd");

  if(level.mapname == "mp_piccadilly") {
    foreach(var2 in var0) {
      if(distance(var2.origin, (-1547, -1512, 165)) < 10) {
        var2.origin -= (0, 0, 10);
      }
    }
  } else if(level.mapname == "mp_aniyah") {
    foreach(var2 in var0) {
      if(distance(var2.origin, (-1117, 2295, 398)) < 10) {
        var2.origin -= (0, 0, 10);
        continue;
      }

      if(distance(var2.origin, (-4501, -2, 322)) < 10) {
        var2.script_label = "9";
        continue;
      }

      if(distance(var2.origin, (-4474, 1159, 388)) < 10) {
        var2.origin -= (0, 0, 20);
      }
    }
  }

  var6 = [];
  var7 = scripts\engine\utility::getStructArray("dz_flare", "targetname");
  var8 = [];
  var9 = [];

  if(level.mapname == "mp_shipment") {
    foreach(var2 in var0) {
      if(var2.script_label == "1" && distance(var2.origin, (-333, 1999, 119)) < 5) {
        var8 = var2;
        continue;
      }

      if(var2.script_label == "2" && distance(var2.origin, (189, 1564, 75)) < 5) {
        var8 = var2;
        continue;
      }

      if(var2.script_label == "3" && distance(var2.origin, (-751, 2416, 81)) < 5) {
        var8 = var2;
        continue;
      }

      if(var2.script_label == "4" && distance(var2.origin, (165, 2420, 79)) < 5) {
        var8 = var2;
        continue;
      }

      if(var2.script_label == "5" && distance(var2.origin, (-823, 1536, 68)) < 5) {
        var8 = var2;
      }
    }

    var0 = scripts\engine\utility::array_remove_array(var0, var8);

    foreach(var13 in var7) {
      if(distance(var13.origin, (192.944, 1583.51, 16.344)) < 5) {
        var9 = var13;
        continue;
      }

      if(distance(var13.origin, (-743.056, 2447.51, 17.844)) < 5) {
        var9 = var13;
        continue;
      }

      if(distance(var13.origin, (152.944, 2415.51, 16.344)) < 5) {
        var9 = var13;
        continue;
      }

      if(distance(var13.origin, (-334.5, 1990.5, 17.25)) < 5) {
        var9 = var13;
        continue;
      }

      if(distance(var13.origin, (-751.056, 1479.51, 16.844)) < 5) {
        var9 = var13;
      }
    }

    var7 = scripts\engine\utility::array_remove_array(var7, var9);
  } else if(level.mapname == "mp_hardbor") {
    foreach(var13 in var7) {
      if(distance(var13.origin, (4491, -942, 183.25)) < 5) {
        var9 = var13;
      }
    }

    var7 = scripts\engine\utility::array_remove_array(var7, var9);
  } else if(level.mapname == "mp_killhouse") {
    foreach(var13 in var7) {
      if(distance(var13.origin, (99, 830.5, 11.25)) < 5) {
        var13.origin = (-22.5, 86.5, 11);
        continue;
      }

      if(distance(var13.origin, (-531.5, -485.5, 11.25)) < 5) {
        var13.origin = (265, 845.5, 10);
        continue;
      }

      if(distance(var13.origin, (-586, 567.5, 11.25)) < 5) {
        var13.origin = (-339.5, -509.5, 10);
        continue;
      }

      if(distance(var13.origin, (-38, -738.5, 11.25)) < 5) {
        var13.origin = (-452, 599.5, 10);
      }
    }
  }

  foreach(var13 in var7) {
    var20 = spawn("script_model", var13.origin);
    var20.angles = var13.angles;
    var20 setModel("dz_flare_scriptable");
    var13.scriptable = var20;
  }

  var22 = [];
  level.objectives = [];

  for(var23 = 0; var23 < var7.size; var23++) {
    var24 = 0;
    var13 = var7[var23];
    var2 = undefined;

    for(var25 = 0; var25 < var0.size; var25++) {
      if(var13.scriptable istouching(var0[var25])) {
        if(isDefined(var2)) {
          var6 = "flare at " + var13.origin + " is touching more than one \"flaretrigger\" trigger";
          var24 = 1;
          break;
        }

        var2 = var0[var25];
        break;
      }
    }

    if(!isDefined(var2)) {
      if(!var24) {
        var6 = "flare at " + var13.origin + " is not inside any \"flaretrigger\" trigger";
        continue;
      }
    }

    var22 = [];
    var22 = var13.scriptable;
    var26 = scripts\mp\gametypes\obj_zonecapture::setupobjective(var2, var22);
    var26.origin = var2.origin;
    level.objectives[var26.objectivekey] = var26;
  }

  if(var6.size > 0) {
    for(var23 = 0; var23 < var6.size; var23++) {}

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
  var0 = 1;
  level.kothhillrotation = 0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("any");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_moved", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  var1 = 0;

  if(level.firstzoneactivationdelay) {
    var1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 6);
    level.ref_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 42, 42);
    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199e(level.firstzoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait level.firstzoneactivationdelay;
    level.ref_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 41, 41);
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_obj_new");

  for(;;) {
    if(!isDefined(level.ref_11ad5)) {
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
    hqactivatenextzone(var1, var0);
    var0 = 0;
    var1 = 0;
    setomnvar("ui_hq_status", 8);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var2 = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.ref_1221a) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var4 in level.players) {
        level.zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var4);
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
    var0 = level.objectives["5"];
    level.prevzoneindex = 5;
  } else {
    var0 = level.objectives["1"];
    level.prevzoneindex = 1;
  }

  return var0;
}

function getnextzone() {
  if(level.zonerandomlocationorder) {
    var0 = [];

    foreach(var2 in level.teamnamelist) {
      var0 = (0, 0, 0);
    }

    var4 = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(var6 in var4) {
      if(var6.team == "spectator") {
        continue;
      }

      var0 = var0[var6.team] + var6.origin;
    }

    var8 = [];

    foreach(var2 in level.teamnamelist) {
      var10 = scripts\mp\utility\teams::getteamdata(var2, "players");
      var11 = max(var10.size, 1);
      var8 = var0[var2] / var11;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1) {
      level.prevzonelist = [];
    }

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    var13 = 0.7;
    var14 = 0.3;
    var15 = undefined;
    var16 = undefined;

    foreach(var18 in level.objectives) {
      var19 = 0;

      foreach(var21 in level.prevzonelist) {
        if(var18.objectivekey == scripts\engine\utility::string(var21)) {
          var19 = 1;
          break;
        }
      }

      if(var19) {
        continue;
      }

      var23 = var18;
      var24 = 0;

      foreach(var2 in level.teamnamelist) {
        var24 += distance2dsquared(var23.curorigin, var8[var2]);
      }

      var27 = distance2dsquared(var23.curorigin, level.zone.curorigin);
      var28 = var24 * var13 + var27 * var14;

      if(!isDefined(var16) || var28 > var16) {
        var16 = var28;
        var15 = var18.objectivekey;
      }
    }

    var23 = level.objectives[var15];
    level.prevzoneindex = var15;
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size) {
      level.prevzoneindex = 1;
    }

    var23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
  }

  return var23;
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

  level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_moved", level.zone.trigger.origin);
}

function hqactivatenextzone(var0, var1) {
  jumpiffalse(var1) LOC_00000040;

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("obj_generic_capture", var3);
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

    var0 = level scripts\engine\utility::ref_143ad("zone_captured", "zone_destroyed");
    var1 = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", var1);
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", scripts\mp\utility\game::getotherteam(var1)[0]);
    thread updaterespawntimer();
    level waittill("zone_destroyed", var2);
    level.spawndelay = undefined;

    if(isDefined(var2)) {
      level.zone scripts\mp\gameobjects::setownerteam(var2);
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
  var0 = 1;
  var1 = 1;

  while(!level.gameended) {
    for(var2 = 0; var2 < var0; var2 = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var2 += level.framedurationseconds;

      if(level.zone.stalemate) {}
    }

    var3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var3 == "neutral") {
      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring) {
        var1 = level.zone.touchlist[var3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var3, var1, 0);

      foreach(var5 in level.zone.touchlist[var3]) {
        var5.player scripts\mp\utility\stats::incpersstat("objTime", 1);

        if(isDefined(var5.player.timebyrotation[level.kothhillrotation])) {
          var5.player.timebyrotation[level.kothhillrotation]++;
        } else {
          var5.player.timebyrotation[level.kothhillrotation] = 1;
        }

        var5.player scripts\mp\persistence::statsetchild("round", "objTime", var5.player.pers["objTime"]);
        var5.player scripts\mp\utility\stats::setextrascore0(var5.player.pers["objTime"]);
        var5.player scripts\mp\gamescore::giveplayerscore("koth_in_obj", 10);
      }
    }
  }
}

function movezoneaftertime(var0) {
  level notify("startMoveTimer");
  level endon("startMoveTimer");
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = var0;
  level.zonedestroyedbytimer = 0;
  scripts\mp\gametypes\obj_zonecapture::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function give_capture_credit(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  var6 = var4;

  if(isDefined(var6.owner)) {
    var6 = var6.owner;
  }

  if(isPlayer(var6)) {
    if(!isscoreboosting(var6)) {
      var6 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var6.origin);
      var6 thread scripts\mp\utility\points::giveunifiedpoints("dz_capture");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
        var6 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
      }

      if(var6.lastkilltime + 500 > gettime()) {} else {
        var6 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var6);
      }
    }
  }

  var7 = getarraykeys(var0);

  for(var8 = 0; var8 < var7.size; var8++) {
    var9 = var0[var7[var8]].player;
    updatecapsperminute(var9, var3);

    if(!isscoreboosting(var9)) {
      var9 scripts\mp\utility\stats::incpersstat("captures", 1);
      var9 scripts\mp\persistence::statsetchild("round", "captures", var9.pers["captures"]);
    }

    if(var6 != var9) {
      var9 thread scripts\mp\rank::scoreeventpopup("capture_assist");
      var9 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_assist");
      var9 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var9);
    }

    wait 0.05;
  }
}

function randomdrops() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.grnd_previouscratetypes = [];

  for(;;) {
    var0 = getbestplayer();
    var1 = 1;

    if(isDefined(var0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      var2 = getdropzonecratetype();
      var3 = getnodesintrigger(level.zone.trigger);

      if(level.mapname == "mp_killhouse") {
        var4 = relic_shieldsonly_set_player_stats_after_spawn();
      } else {
        var4 = relic_shieldsonly_set_player_stats_after_spawn() + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
      }

      if(var3 == "mega") {
        var5 = spawnStruct();
        var5.cratetype = undefined;
        var5.numcrates = undefined;
        var5.usephysics = undefined;
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var1, var1.team, var4, randomfloat(360), var4, var5);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(var1, var1.team, var3, var4, randomfloat(360), var4, 1);
      }

      var2 = level.droptime;
    } else {
      var2 = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var2);
  }
}

function ref_132f5(var0) {
  if(var0 == "mega") {
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
        var0 = [(-589, -479, 68), (289, 830, 68), (-589, -479, 68), (301, 525, 68)];
        var1 = scripts\engine\utility::random(var0);
        return var1;
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
  var0 = undefined;
  var1 = 0;
  var2 = level.zone scripts\mp\gameobjects::getownerteam();

  if(var2 == "neutral") {
    return var0;
  }

  foreach(var4 in level.zone.touchlist[var2]) {
    if(var1 == 0 || var1 > var4.starttime) {
      var1 = var4.starttime;
      var0 = var4.player;
    }
  }

  return var0;
}

function getdropzonecratetype() {
  var0 = undefined;

  if(level.mapname != "mp_killhouse" && !isDefined(level.grnd_previouscratetypes["mega"]) && randomintrange(0, 100) < 5) {
    var0 = "mega";
  } else {
    if(level.grnd_previouscratetypes.size) {
      for(var1 = 200; var1; var1--) {
        var0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

        if(isDefined(level.grnd_previouscratetypes[var0])) {
          var0 = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(var0)) {
      var0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
    }
  }

  level.grnd_previouscratetypes[var0] = 1;

  if(level.grnd_previouscratetypes.size == 15) {
    level.grnd_previouscratetypes = [];
  }

  return var0;
}

function getspawnpoint() {
  var0 = self.pers["team"];
  var1 = getobjzonedeadzonedist();
  var2 = [];
  GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.zone.visuals[0] getentitynumber());
}

function getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

function removespawnsinactivedz(var0) {
  var1 = [];

  if(isDefined(var0)) {
    foreach(var3 in var0) {
      if(!ispointinvolume(var3.origin, level.zone.trigger)) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function onplayerconnect(var0) {
  var0.numcaps = 0;
  var0.capsperminute = 0;
  var0.timebyrotation = [];
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["objTime"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["objTime"]);
  }

  var0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var0.pers["defends"])) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["defends"]);
    return;
  }
}

function onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  thread updatematchstatushintonspawn();
  level.ref_12305 = 30;
}

function updateservericons(var0, var1) {
  var2 = -1;

  if(var1) {
    var2 = -2;
  } else if(scripts\mp\utility\teams::isgameplayteam(var0)) {
    var3 = thread getownerteamplayer(var0);

    if(isDefined(var3)) {
      var2 = var3 getentitynumber();
    }
  } else {
    switch (var0) {
      case "zone_activation_delay":
        var2 = -3;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_hardpoint", var2);
}

function getownerteamplayer(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(var3.team == var0) {
      var1 = var3;
      break;
    }
  }

  return var1;
}

function updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var0 = gettime();

  if(level.zoneduration > 0) {
    var1 = var0 + level.zoneduration * 1000;
  } else {
    var1 = var1 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
  }

  var2 = var1;

  while(var2 < var1) {
    var2 = gettime();
    level.spawndelay = (var1 - var2) / 1000 + 0.1;
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

function updatecapsperminute(var0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var0) || var0 == "neutral") {
    return;
  }

  self.numcaps++;
  var1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    var1 = self.timeplayed["total"] / 60;
  }

  self.capsperminute = self.numcaps / var1;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
    return;
  }
}

function isscoreboosting(var0) {
  if(var0.capsperminute > 3) {
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
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = level.zone.visuals[0];

  foreach(var5 in level.calloutglobals.areatriggers) {
    var1 = ispointinvolume(var3.baseorigin, var5);
    var2 = isDefined(var3.script_noteworthy) && isDefined(var5.script_noteworthy) && var3.script_noteworthy == var5.script_noteworthy;

    if(var1 || var2) {
      var0 = level.calloutglobals.areaidmap[var5.script_noteworthy];

      foreach(var7 in level.players) {
        if(isDefined(var0)) {
          var7 setclientomnvar("ui_hp_callout_id", var0);
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