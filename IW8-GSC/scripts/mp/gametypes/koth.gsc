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
  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/KOTH_HINT");
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
    ref_12bbc();
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
  level.ref_1221a = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 0.5, 0, 10);
  level.usehqrules = scripts\mp\utility\dvars::dvarintvalue("useHQRules", 0, 0, 1);

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
  scripts\mp\utility\game::ref_119ac(undefined, undefined, "New Hardpoint", level.zone.trigger.origin);
  level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_moved", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("prematch_done");

  if(level.ref_1221a) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var1 = 0;

  if(level.firstzoneactivationdelay) {
    var1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 12);
    level.ref_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 36, 36);
    thread waitthenplaynewobj();
    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199e(level.firstzoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait level.firstzoneactivationdelay;
    level.ref_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 35, 35);
    scripts\mp\utility\game::setmlgannouncement(5, "free");
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_hq_activate_sfx");

  for(;;) {
    if(!isDefined(level.ref_11ad5)) {
      thread setupzonecallouts();
    }

    level.objectivesetorder = 1;

    if(level.ref_1221a) {
      level scripts\mp\gamelogic::resumetimer();
    }

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
    setomnvar("ui_hq_status", 10);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var2 = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.ref_1221a) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
    killhardpointvfx(level.zone);
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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_first", var1);
  }
}

function killhardpointvfx() {
  foreach(var1 in level.players) {
    foreach(var3 in var1._hardpointeffect) {
      var1._hardpointeffect = scripts\engine\utility::array_remove(var1._hardpointeffect, var3);

      if(isDefined(var3)) {
        var3 delete();
      }
    }
  }

  if(isDefined(self.neutralhardpointfx) && self.neutralhardpointfx.size > 0) {
    foreach(var3 in self.neutralhardpointfx) {
      var3 delete();
    }
  }

  self.neutralhardpointfx = [];
}

function ref_12bbc() {
  switch (level.mapname) {
    case "mp_hackney_yard":
    case "mp_hackney_am":
      level.ref_12bbe = ["1", "4", "3", "9", "8"];
      break;
    case "mp_spear":
    case "mp_spear_pm":
      level.ref_12bbe = ["5", "4", "3", "2", "6"];
      break;
    case "mp_cave":
    case "mp_cave_am":
      level.ref_12bbe = ["1", "5", "2", "3", "4"];
      break;
    case "mp_petrograd":
      level.ref_12bbe = ["1", "9", "4", "5", "2"];
      break;
    case "mp_deadzone":
      level.ref_12bbe = ["12", "11", "3", "1", "2"];
      break;
    case "mp_raid":
      level.ref_12bbe = ["20", "2", "8", "9", "5"];
      break;
    case "mp_piccadilly":
      level.ref_12bbe = ["1", "5", "7", "3", "8"];
      break;
    case "mp_crash2_pm":
    case "mp_crash2":
      level.ref_12bbe = ["1", "20", "5", "4", "19"];
      break;
    case "mp_emporium":
      level.ref_12bbe = ["1", "2", "3", "4", "5"];
      break;
    case "mp_broadcast2":
      level.ref_12bbe = ["1", "2", "3", "4", "5"];
      break;
    default:
      break;
  }
}

function getfirstzone() {
  if(isDefined(level.ref_12bbe)) {
    var0 = level.objectives[level.ref_12bbe[0]];
    level.prevzoneindex = 0;
    level.playerzombiedroploot = level.objectives[level.ref_12bbe[1]];
  } else {
    var0 = level.objectives["1"];
    level.prevzoneindex = 1;
    level.playerzombiedroploot = level.objectives["2"];
  }

  var0 thread scripts\mp\gametypes\obj_zonecapture::ref_144da();
  level.playerzombiedroploot thread scripts\mp\gametypes\obj_zonecapture::ref_144da();
  return var0;
}

function getnextzone() {
  level notify("stop_watching_trigger");

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
    if(isDefined(level.ref_12bbe)) {
      level.prevzoneindex++;

      if(level.prevzoneindex > level.ref_12bbe.size - 1) {
        level.prevzoneindex = 0;
      }

      var23 = level.objectives[level.ref_12bbe[level.prevzoneindex]];
      var30 = level.prevzoneindex + 1;

      if(var30 > level.ref_12bbe.size - 1) {
        var30 = 1;
      }

      level.playerzombiedroploot = level.objectives[level.ref_12bbe[var30]];
    } else {
      level.prevzoneindex++;

      if(level.prevzoneindex > level.objectives.size) {
        level.prevzoneindex = 1;
      }

      var23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
      var30 = level.prevzoneindex + 1;

      if(var30 > level.objectives.size) {
        var30 = 2;
      }

      level.playerzombiedroploot = level.objectives[scripts\engine\utility::string(var30)];
    }

    level.playerzombiedroploot thread scripts\mp\gametypes\obj_zonecapture::ref_144da();
  }

  return var23;
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

  scripts\mp\utility\game::ref_119ac(undefined, undefined, "New Hardpoint", level.zone.trigger.origin);
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

    if(!level.usehqrules) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
      level.zone scripts\mp\gameobjects::cancontestclaim(1);
    }

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      level thread scripts\mp\gametypes\grnd::randomdrops();
    }

    var0 = level scripts\engine\utility::ref_143ad("zone_captured", "zone_destroyed");

    if(var0 == "zone_destroyed") {
      continue;
    }

    var1 = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_positive", var1);
    scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_negative", scripts\mp\utility\game::getotherteam(var1)[0]);

    if(level.usehqrules && level.zoneduration > 0) {
      thread movezoneaftertime(level.zoneduration);
    }

    level waittill("zone_destroyed", var2);

    if(isDefined(var2)) {
      level.zone scripts\mp\gameobjects::setownerteam(var2);
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn_secondary", 1, 1);

  if(!isDefined(level.spawnpoints) || istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", var2);
    scripts\mp\spawnlogic::registerspawnset("fallback", var3);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.binoculars_clearuidata)) {
    return;
  }

  foreach(var5 in level.objectives) {
    var5.furthestspawndistsq = 0;
    var5.spawnpoints = [];
    var5.fallbackspawnpoints = [];
  }

  foreach(var8 in level.spawnpoints) {
    var9 = var8.classname == "mp_koth_spawn_allies_start" || var8.classname == "mp_koth_spawn_axis_start";
    var10 = 0;
    var11 = var8.classname == "mp_koth_spawn";
    var12 = var8.classname == "mp_koth_spawn_secondary";
    var13 = [];

    if(var9) {
      continue;
    }

    if(var11 || var12) {
      if(isDefined(var8.script_noteworthy) && var8.script_noteworthy != "") {
        var10 = 1;
        var13 = strtok(var8.script_noteworthy, " ");

        foreach(var15 in var13) {
          if(var15 == "6v6" || var15 == "10v10") {
            continue;
          }

          if(!postshipmodifiedzones(var15)) {
            var5 = level.objectives[var15];

            if(var11) {
              var5.spawnpoints[var5.spawnpoints.size] = var8;
              continue;
            }

            var5.fallbackspawnpoints[var5.fallbackspawnpoints.size] = var8;
          }
        }
      }
    }

    calculatespawndisttozones(var8, var13);
    var17 = scripts\mp\spawnlogic::getoriginidentifierstring(var8);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var17])) {
      foreach(var15 in level.kothextraprimaryspawnpoints[var17]) {
        var5 = level.objectives[var15];
        var5.spawnpoints[var5.spawnpoints.size] = var8;
      }
    }

    if(!var10) {
      foreach(var5 in level.objectives) {
        if(var11) {
          var5.spawnpoints[var5.spawnpoints.size] = var8;
          continue;
        }

        var5.fallbackspawnpoints[var5.fallbackspawnpoints.size] = var8;
      }
    }
  }

  foreach(var5 in level.objectives) {
    var5.spawnset = "koth_" + var24;
    scripts\mp\spawnlogic::registerspawnset(var5.spawnset, var5.spawnpoints);
    var5.fallbackspawnset = "koth_fallback_" + var24;
    scripts\mp\spawnlogic::registerspawnset(var5.fallbackspawnset, var5.fallbackspawnpoints);
  }
}

function calculatespawndisttozones(var0, var1) {
  var2 = 0;
  var0.scriptdata.distsqtokothzones = [];

  foreach(var4 in level.objectives) {
    if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "") {
      var2 = 1;
    } else {
      foreach(var6 in var1) {
        if(var6 == var4.trigger.objectivekey) {
          var2 = 1;
          break;
        }
      }
    }

    if(!var2) {
      continue;
    }

    var8 = getpathdist(var0.origin, var4.trigger.baseorigin, 5000);

    if(var8 < 0) {
      var8 = scripts\engine\utility::distance_2d_squared(var0.origin, var4.trigger.baseorigin);
    } else {
      var8 *= var8;
    }

    var0.scriptdata.distsqtokothzones[var4.trigger getentitynumber()] = var8;

    if(var8 > var4.furthestspawndistsq) {
      var4.furthestspawndistsq = var8;
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
  var0 = getzonearray("hardpoint_zone");
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 = var0[var2];
  }

  level.objectives = [];

  foreach(var4 in var1) {
    var5 = scripts\mp\gametypes\obj_zonecapture::setupobjective(var4);
    level.objectives[var5.objectivekey] = var5;
  }

  var7 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  var8 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  level.startpos["allies"] = var8[0].origin;
  level.startpos["axis"] = var7[0].origin;
  return true;
}

function setupzoneareabrushes() {
  level.neutralzonebrushes = [];
  level.contestedzonebrushes = [];
  level.friendlyzonebrushes = [];
  level.enemyzonebrushes = [];
  var0 = getzonearray("hardpoint_zone_visual");
  var1 = getzonearray("hardpoint_zone_visual_contest");
  var2 = getzonearray("hardpoint_zone_visual_friend");
  var3 = getzonearray("hardpoint_zone_visual_enemy");

  if(!isDefined(var0)) {
    level.usehpzonebrushes = 0;
  } else {
    level.usehpzonebrushes = 1;
  }

  if(istrue(level.usehpzonebrushes)) {
    foreach(var5 in var0) {
      level.neutralzonebrushes[var5.script_label] = var5;
      var5 hide();
    }

    foreach(var5 in var1) {
      level.contestedzonebrushes[var5.script_label] = var5;
      var5 hide();
    }

    foreach(var5 in var2) {
      level.friendlyzonebrushes[var5.script_label] = var5;
      var5 hide();
    }

    foreach(var5 in var3) {
      level.enemyzonebrushes[var5.script_label] = var5;
      var5 hide();
    }

    postshipmodifiedzonebrushes();
    thread matchbrushestozones();
    return;
  }
}

function postshipmodifiedzonebrushes() {
  if(level.mapname == "mp_parkour") {
    for(var0 = 0; var0 < level.neutralzonebrushes.size; var0++) {
      if(level.neutralzonebrushes[var0].script_label == "1") {
        level.neutralzonebrushes[var0] hide();
        var1 = spawn("script_model", (0, 0, 0));
        var1 setModel("mp_parkour_hardpoint_floor_01");
        var1.angles = (0, 0, 0);
        var1.script_label = "1";
        level.neutralzonebrushes[var0] = var1;
      }
    }

    for(var0 = 0; var0 < level.contestedzonebrushes.size; var0++) {
      if(level.contestedzonebrushes[var0].script_label == "1") {
        level.contestedzonebrushes[var0] hide();
        var2 = spawn("script_model", (0, 0, 0));
        var2 setModel("mp_parkour_hardpoint_floor_01_contest");
        var2.angles = (0, 0, 0);
        var2.script_label = "1";
        level.contestedzonebrushes[var0] = var2;
      }
    }

    for(var0 = 0; var0 < level.friendlyzonebrushes.size; var0++) {
      if(level.friendlyzonebrushes[var0].script_label == "1") {
        level.friendlyzonebrushes[var0] hide();
        var3 = spawn("script_model", (0, 0, 0));
        var3 setModel("mp_parkour_hardpoint_floor_01_friend");
        var3.angles = (0, 0, 0);
        var3.script_label = "1";
        level.friendlyzonebrushes[var0] = var3;
      }
    }

    for(var0 = 0; var0 < level.enemyzonebrushes.size; var0++) {
      if(level.enemyzonebrushes[var0].script_label == "1") {
        level.enemyzonebrushes[var0] hide();
        var4 = spawn("script_model", (0, 0, 0));
        var4 setModel("mp_parkour_hardpoint_floor_01_enemy");
        var4.angles = (0, 0, 0);
        var4.script_label = "1";
        level.enemyzonebrushes[var0] = var4;
      }
    }

    return;
  }
}

function matchbrushestozones() {
  foreach(var1 in level.objectives) {
    var1.neutralbrush = level.neutralzonebrushes[var1.objectivekey];
    var1.enemybrush = level.enemyzonebrushes[var1.objectivekey];
    var1.contestedbrush = level.contestedzonebrushes[var1.objectivekey];
    var1.friendlybrush = level.friendlyzonebrushes[var1.objectivekey];
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

  scripts\mp\utility\game::setmlgannouncement(4, "free");
}

function forcespawnplayers() {
  var0 = level.players;

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(!isDefined(var2) || isalive(var2)) {
      continue;
    }

    var2 notify("force_spawn");
    waitframe();
  }
}

function getspawnpoint() {
  var0 = self.pers["team"];
  var1 = getkothzonedeadzonedist();
  var2 = [];
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

function movezoneaftertime(var0) {
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  if(var1 == self) {
    return;
  }

  if(!isDefined(level.zone)) {
    return;
  }

  var10 = level.zone.ownerteam;

  if(!isDefined(var10)) {
    return;
  }

  if(isDefined(var4) && scripts\mp\utility\weapon::iskillstreakweapon(var4.basename)) {
    return;
  }

  var11 = self;
  var12 = 0;
  var13 = var1.team;

  if(level.zonecapturetime > 0 && var1 istouching(level.zone.trigger)) {
    if(var10 != var13) {
      var12 = 1;
    }
  }

  if(var13 != var10) {
    if(var12) {
      var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      return;
    }

    if(var11 istouching(level.zone.trigger)) {
      var1 thread scripts\mp\rank::scoreeventpopup("assault");
      var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
      return;
    }

    return;
  }

  if(var1 istouching(level.zone.trigger)) {
    var1 thread scripts\mp\rank::scoreeventpopup("defend");
    var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
    var1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
    var1 scripts\mp\utility\stats::setextrascore1(var1.pers["defends"]);
    return;
  }
}

function give_capture_credit(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  scripts\mp\utility\game::ref_119ac(var4, undefined, "Hardpoint Captured", var4.origin);
  var6 = var4;

  if(isDefined(var6.owner)) {
    var6 = var6.owner;
  }

  if(isPlayer(var6)) {
    var6 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var6.origin);

    if(unset_forced_aitype_armored(var6) && !scripts\mp\utility\game::isanymlgmatch()) {} else if(!isscoreboosting(var6)) {
      var6 thread scripts\mp\rank::scoreeventpopup("hp_secure");
      var6 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");
    } else {
      var6 thread scripts\mp\rank::scoreeventpopup("hp_secure");
      var6 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure_reduced");
    }

    if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
      var6 thread scripts\mp\rank::scoreeventpopup("hp_quick_cap");
      var6 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
    }

    if(var6.lastkilltime + 500 > gettime()) {} else {
      var6 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var6);
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

function awardcapturepoints() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var0 = 1;
  var1 = 1;

  while(!level.gameended) {
    for(var2 = 0; var2 < var0 && !level.gameended; var2 = 0) {
      wait level.framedurationseconds;
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var2 += level.framedurationseconds;

      if(level.zone.stalemate) {}
    }

    var3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var3 == "neutral") {
      continue;
    }

    if(level.gameended) {
      break;
    }

    if(level.usehqrules) {
      if(level.zoneadditivescoring) {
        var1 = level.zone.touchlist[var3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var3, var1, 0);
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

        if(isDefined(var5.player.spawn_sentry_at_pos) && var5.player.spawn_sentry_at_pos > 3) {
          var5.player.spawn_sentry_at_pos = 0;

          if(scripts\mp\utility\game::getgametype() == "koth") {
            var5.player scripts\mp\utility\points::giveunifiedpoints("koth_in_obj", undefined, 15);
          } else if(scripts\mp\utility\game::getgametype() == "grnd") {
            var5.player scripts\mp\utility\points::giveunifiedpoints("grnd_in_obj", undefined, 15);
          }

          continue;
        }

        if(!isDefined(var5.player.spawn_sentry_at_pos)) {
          var5.player.spawn_sentry_at_pos = 0;
        } else {
          var5.player.spawn_sentry_at_pos++;
        }

        var5.player scripts\mp\gamescore::giveplayerscore("koth_in_obj", 10);
      }
    }
  }
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

function unset_forced_aitype_armored(var0) {
  if(var0.capsperminute > 6) {
    return true;
  }

  return false;
}

function onplayerconnect(var0) {
  var0._hardpointeffect = [];
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
  }

  thread onplayerspawned(var0);

  foreach(var2 in level.objectives) {
    if(istrue(level.usehpzonebrushes)) {
      var2 scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var0);
    }
  }

  thread refreshfreecamhardpointfx();
}

function onplayerspawned(var0) {
  for(;;) {
    var0 waittill("spawned");

    foreach(var2 in level.objectives) {
      if(istrue(var2.active)) {
        if(var2.ownerteam == "neutral") {
          var2 scripts\mp\gametypes\obj_zonecapture::playhardpointneutralfx();
          continue;
        }

        var2 scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(var2.ownerteam, var0);
      }
    }
  }
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

function refreshfreecamhardpointfx() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "mlg_view_change") {
      foreach(var3 in level.objectives) {
        if(var3.ownerteam != "neutral") {
          var3 scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(var3.ownerteam, self);
        }
      }
    }
  }
}

function getrespawndelay() {
  if(!level.delayplayer) {
    return undefined;
  }

  var0 = level.zone.ownerteam;

  if(isDefined(var0)) {
    if(self.pers["team"] == var0) {
      if(!level.spawndelay) {
        return undefined;
      }

      return level.spawndelay;
    }

    return;
  }
}

function postshipmodifiedzones(var0) {
  if(level.mapname == "mp_fallen" && var0 == "5") {
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