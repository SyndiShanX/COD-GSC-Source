/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\koth.gsc
*********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
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
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 300);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.hpstarttime = 0;
  level.scoreperplayer = undefined;
  level.teambased = 1;
  if(scripts\mp\utility::isanymlgmatch()) {
    level.var_112BF = 0;
  }

  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.lastcaptime = gettime();
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "hardpoint";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  thread onplayerconnect();
  thread writeplayerrotationscoretomatchdataongameend();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_koth_zoneLifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_koth_zoneCaptureTime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_koth_zoneActivationDelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_koth_randomLocationOrder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_koth_additiveScoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_koth_pauseTime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_koth_delayPlayer", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("scr_koth_useHQRules", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("scr_koth_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("koth", 0);
}

onstartgametype() {
  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_KOTH");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_KOTH");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_KOTH_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_KOTH_HINT");
  setclientnamemode("auto_change");
  var_0[0] = "hardpoint";
  var_0[1] = "tdm";
  scripts\mp\gameobjects::main(var_0);
  level thread setupzones();
  level thread setupzoneareabrushes();
  initspawns();
  level thread hardpointmainloop();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.zoneduration = scripts\mp\utility::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.zoneactivationdelay = scripts\mp\utility::dvarfloatvalue("zoneActivationDelay", 0, 0, 60);
  level.zonerandomlocationorder = scripts\mp\utility::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility::dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = scripts\mp\utility::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility::dvarintvalue("delayPlayer", 0, 0, 1);
  level.usehqrules = scripts\mp\utility::dvarintvalue("useHQRules", 0, 0, 1);
}

seticonnames() {
  level.icontarget = "waypoint_hardpoint_target";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_enemy";
  level.icondefend = "koth_friendly";
  level.iconcontested = "waypoint_hardpoint_contested";
  level.icontaking = "waypoint_taking_chevron";
  level.iconlosing = "waypoint_hardpoint_losing";
}

hardpointmainloop() {
  level endon("game_ended");
  seticonnames();
  setomnvar("ui_uplink_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  level.zone = getfirstzone();
  level.kothhillrotation = 0;
  level.zone.gameobject scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.gameobject.var_19 = 1;
  level.zone.gameobject scripts\mp\gameobjects::setvisibleteam("any");
  level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.icontarget);
  level.zone.gameobject thread scripts\mp\matchdata::loggameevent("hill_moved", level.zone.origin);
  scripts\mp\utility::gameflagwait("prematch_done");
  level.zoneendtime = int(gettime() + 5000);
  setomnvar("ui_hardpoint_timer", level.zoneendtime);
  setomnvar("ui_uplink_timer_stopped", 0);
  wait(5);
  scripts\mp\utility::statusdialog("hp_new_location", "allies");
  scripts\mp\utility::statusdialog("hp_new_location", "axis");
  scripts\mp\utility::playsoundonplayers("mp_killstreak_radar");
  for(;;) {
    if(!isDefined(level.mapcalloutsready)) {
      level thread setupzonecallouts();
    }

    level.objectivesetorder = 1;
    waittillframeend;
    level.zone.gameobject scripts\mp\gameobjects::enableobject();
    level.zone.gameobject.capturecount = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      level.zone.gameobject thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
    }

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone();
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var_0 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
    if(level.timerstoppedforgamemode && level.pausemodetimer) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
    level.zone.gameobject killhardpointvfx();
    level.zone.gameobject.var_19 = 0;
    if(level.usehpzonebrushes) {
      foreach(var_2 in level.players) {
        level.zone.gameobject scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var_2);
      }
    }

    level.zone.gameobject scripts\mp\gameobjects::disableobject();
    level.zone.gameobject scripts\mp\gameobjects::allowuse("none");
    level.zone.gameobject scripts\mp\gameobjects::setownerteam("neutral");
    updateservericons("zone_shift", 0);
    level notify("zone_reset");
    spawn_next_zone();
    if(level.gametype == "grnd" && level.kothhillrotation == 1) {
      scripts\mp\killstreaks\_airdrop::dropzoneaddcratetypes();
    }

    wait(0.5);
    if(level.usehqrules) {
      thread forcespawnplayers();
    }

    wait(0.5);
  }
}

killhardpointvfx() {
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

getfirstzone() {
  var_0 = level.zones[0];
  level.prevzoneindex = 0;
  return var_0;
}

getnextzone() {
  if(level.zonerandomlocationorder) {
    var_13["allies"] = (0, 0, 0);
    var_13["axis"] = (0, 0, 0);
    var_1 = scripts\mp\utility::getpotentiallivingplayers();
    foreach(var_3 in var_1) {
      if(var_3.team == "spectator") {
        continue;
      }

      var_13[var_3.team] = var_13[var_3.team] + var_3.origin;
    }

    var_5 = scripts\mp\utility::getteamarray("allies");
    var_6 = max(var_5.size, 1);
    var_7 = scripts\mp\utility::getteamarray("axis");
    var_8 = max(var_7.size, 1);
    var_9["allies"] = var_13["allies"] / var_6;
    var_9["axis"] = var_13["axis"] / var_8;
    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.zones.size - 1) {
      level.prevzonelist = [];
    }

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    var_10 = 0.7;
    var_11 = 0.3;
    var_12 = undefined;
    var_13 = undefined;
    for(var_14 = 0; var_14 < level.zones.size; var_14++) {
      var_15 = 0;
      foreach(var_11 in level.prevzonelist) {
        if(var_14 == var_11) {
          var_15 = 1;
          break;
        }
      }

      if(var_15) {
        continue;
      }

      var_13 = level.zones[var_14];
      var_14 = distance2dsquared(var_13.gameobject.curorigin, var_9["allies"]);
      var_15 = distance2dsquared(var_13.gameobject.curorigin, var_9["axis"]);
      var_16 = distance2dsquared(var_13.gameobject.curorigin, level.zone.gameobject.curorigin);
      var_17 = var_14 + var_15 * var_10 + var_16 * var_11;
      if(!isDefined(var_13) || var_17 > var_13) {
        var_13 = var_17;
        var_12 = var_14;
      }
    }

    var_13 = level.zones[var_12];
    level.prevzoneindex = var_12;
  } else {
    var_18 = level.prevzoneindex + 1 % level.zones.size;
    var_13 = level.zones[var_18];
    level.prevzoneindex = var_18;
  }

  return var_13;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  scripts\mp\utility::setmlgannouncement(5, "free");
  level.zone.gameobject scripts\mp\gametypes\obj_zonecapture::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone.gameobject scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.gameobject.var_19 = 1;
  level.zone.gameobject.lastactivatetime = gettime();
  var_0 = int(level.zone.script_label);
  level.zone.gameobject.neutralbrush = level.neutralzonebrushes[var_0 - 1];
  level.zone.gameobject.friendlybrush = level.friendlyzonebrushes[var_0 - 1];
  level.zone.gameobject.enemybrush = level.enemyzonebrushes[var_0 - 1];
  level.zone.gameobject.contestedbrush = level.contestedzonebrushes[var_0 - 1];
  if(level.zoneactivationdelay > 0) {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.icontarget);
  } else {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.iconneutral);
  }

  level.zone.gameobject thread scripts\mp\matchdata::loggameevent("hill_moved", level.zone.origin);
}

hqactivatenextzone() {
  scripts\mp\utility::statusdialog("hp_new_location", "allies");
  scripts\mp\utility::statusdialog("hp_new_location", "axis");
  scripts\mp\utility::playsoundonplayers("mp_killstreak_radar");
  level.zone.gameobject thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
  level.zone.gameobject scripts\mp\gameobjects::allowuse("none");
  if(level.zoneactivationdelay) {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
  }

  wait(level.zoneactivationdelay);
  level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.iconneutral);
  updateservericons("neutral", 0);
  if(level.zoneduration) {
    updateservericons("neutral", 0);
    if(level.usehqrules) {
      thread locktimeruntilcap();
      return;
    }

    thread movezoneaftertime(level.zoneduration);
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    return;
  }

  level.zonedestroyedbytimer = 0;
}

locktimeruntilcap() {
  level endon("zone_captured");
  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    wait(0.05);
  }
}

hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();
  for(;;) {
    level.zone.gameobject scripts\mp\gameobjects::allowuse("enemy");
    level.zone.gameobject scripts\mp\gameobjects::setvisibleteam("any");
    level.zone.gameobject scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
    if(!level.usehqrules) {
      level.zone.gameobject thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
      level.zone.gameobject scripts\mp\gameobjects::cancontestclaim(1);
    }

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      level thread scripts\mp\gametypes\grnd::randomdrops();
    }

    var_0 = level scripts\engine\utility::waittill_any_return("zone_captured", "zone_destroyed");
    if(var_0 == "zone_destroyed") {
      continue;
    }

    var_1 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
    thread func_12F03();
    if(level.usehqrules && level.zoneduration > 0) {
      thread movezoneaftertime(level.zoneduration);
    }

    level waittill("zone_destroyed", var_2);
    level.spawndelay = undefined;
    if(isDefined(var_2)) {
      level.zone.gameobject scripts\mp\gameobjects::setownerteam(var_2);
    } else {
      level.zone.gameobject scripts\mp\gameobjects::setownerteam("none");
    }

    if(level.usehqrules) {
      break;
    }
  }
}

func_12F03() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var_0 = gettime();
  if(level.zoneduration > 0) {
    var_1 = var_0 + level.zoneduration * 1000;
  } else {
    var_1 = var_1 + scripts\mp\utility::gettimelimit() * 60 * 1000 - scripts\mp\utility::gettimepassed();
  }

  var_2 = var_0;
  while(var_2 < var_1) {
    var_2 = gettime();
    level.spawndelay = var_1 - var_2 / 1000;
    wait(0.05);
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn_secondary", 1, 1);
  if(!isDefined(level.spawnpoints)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_0 = [];
  foreach(var_2 in level.zones) {
    var_2.furthestspawndistsq = 0;
    var_2.spawnpoints = [];
    var_2.fallbackspawnpoints = [];
    var_0[var_2.script_label] = var_2;
  }

  foreach(var_5 in level.spawnpoints) {
    calculatespawndisttozones(var_5);
    var_6 = scripts\mp\spawnlogic::getoriginidentifierstring(var_5);
    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var_6])) {
      foreach(var_8 in level.kothextraprimaryspawnpoints[var_6]) {
        var_2 = var_0[var_8];
        var_2.spawnpoints[var_2.spawnpoints.size] = var_5;
      }
    }

    var_10 = 0;
    var_11 = var_5.classname == "mp_koth_spawn";
    var_12 = var_5.classname == "mp_koth_spawn_secondary";
    if(var_11 || var_12) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy != "") {
        var_10 = 1;
        var_13 = strtok(var_5.script_noteworthy, " ");
        foreach(var_8 in var_13) {
          if(!postshipmodifiedzones(var_8)) {
            var_2 = var_0[var_8];
            if(var_11) {
              var_2.spawnpoints[var_2.spawnpoints.size] = var_5;
              continue;
            }

            var_2.fallbackspawnpoints[var_2.fallbackspawnpoints.size] = var_5;
          }
        }
      }
    }

    if(!var_10) {
      foreach(var_2 in level.zones) {
        if(var_11) {
          var_2.spawnpoints[var_2.spawnpoints.size] = var_5;
          continue;
        }

        var_2.fallbackspawnpoints[var_2.fallbackspawnpoints.size] = var_5;
      }
    }
  }
}

calculatespawndisttozones(var_0) {
  var_0.distsqtokothzones = [];
  foreach(var_2 in level.zones) {
    var_3 = getpathdist(var_0.origin, var_2.baseorigin, 5000);
    if(var_3 < 0) {
      var_3 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_2.baseorigin);
    } else {
      var_3 = var_3 * var_3;
    }

    var_0.distsqtokothzones[var_2 getentitynumber()] = var_3;
    if(var_3 > var_2.furthestspawndistsq) {
      var_2.furthestspawndistsq = var_3;
    }
  }
}

comparezoneindexes(var_0, var_1) {
  var_2 = int(var_0.script_label);
  var_3 = int(var_1.script_label);
  if(!isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(var_2 > var_3) {
    return 1;
  }

  return 0;
}

getzonearray(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  var_2 = 1;
  for(var_3 = var_1.size; var_2; var_3--) {
    var_2 = 0;
    for(var_4 = 0; var_4 < var_3 - 1; var_4++) {
      if(comparezoneindexes(var_1[var_4], var_1[var_4 + 1])) {
        var_5 = var_1[var_4];
        var_1[var_4] = var_1[var_4 + 1];
        var_1[var_4 + 1] = var_5;
        var_2 = 1;
      }
    }
  }

  return var_1;
}

setupzones() {
  scripts\mp\utility::func_98D3();
  level.zones = [];
  level.var_13FC6 = [];
  var_0 = getzonearray("hardpoint_zone");
  if(level.mapname == "mp_fallen") {
    var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_0.size - 1]);
  }

  level.zones = [];
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level.zones[level.zones.size] = var_0[var_1];
  }

  level.objectives = level.zones;
  for(var_1 = 0; var_1 < level.zones.size; var_1++) {
    var_2 = scripts\mp\gametypes\obj_zonecapture::func_8B4A(var_1);
    level.zones[var_1].useobj = var_2;
    var_2.levelflag = level.zones[var_1];
    level.var_13FC6[level.var_13FC6.size] = var_2;
  }

  level.var_1BEB = level.zones;
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  level.areanynavvolumesloaded["allies"] = var_4[0].origin;
  level.areanynavvolumesloaded["axis"] = var_3[0].origin;
  return 1;
}

setupzoneareabrushes() {
  level.neutralzonebrushes = [];
  level.friendlyzonebrushes = [];
  level.enemyzonebrushes = [];
  level.contestedzonebrushes = [];
  var_0 = getzonearray("hardpoint_zone_visual");
  var_1 = getzonearray("hardpoint_zone_visual_contest");
  var_2 = getzonearray("hardpoint_zone_visual_friend");
  var_3 = getzonearray("hardpoint_zone_visual_enemy");
  if(!isDefined(var_0)) {
    level.usehpzonebrushes = 0;
  } else {
    level.usehpzonebrushes = 1;
  }

  if(level.usehpzonebrushes) {
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      level.neutralzonebrushes[level.neutralzonebrushes.size] = var_0[var_4];
      level.neutralzonebrushes[var_4] hide();
    }

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      level.contestedzonebrushes[level.contestedzonebrushes.size] = var_1[var_4];
      level.contestedzonebrushes[var_4] hide();
    }

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      level.friendlyzonebrushes[level.friendlyzonebrushes.size] = var_2[var_4];
      level.friendlyzonebrushes[var_4] hide();
    }

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      level.enemyzonebrushes[level.enemyzonebrushes.size] = var_3[var_4];
      level.enemyzonebrushes[var_4] hide();
    }

    postshipmodifiedzonebrushes();
    thread matchbrushestozones();
  }
}

postshipmodifiedzonebrushes() {
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
  }
}

matchbrushestozones() {
  for(var_0 = 0; var_0 < level.zones.size; var_0++) {
    var_1 = level.zones[var_0];
    var_1.gameobject.neutralbrush = level.neutralzonebrushes[var_0];
    var_1.gameobject.enemybrush = level.enemyzonebrushes[var_0];
    var_1.gameobject.contestedbrush = level.contestedzonebrushes[var_0];
    var_1.gameobject.friendlybrush = level.friendlyzonebrushes[var_0];
  }
}

setupzonecallouts() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = level.zone.gameobject.visuals[0];
  if(level.mapname == "mp_afghan") {
    if(var_2.script_label == "1") {
      var_2.script_noteworthy = "crash_middle";
    }
  }

  foreach(var_4 in level.calloutglobals.areatriggers) {
    var_0 = ispointinvolume(var_2.baseorigin, var_4);
    var_1 = isDefined(var_2.script_noteworthy) && isDefined(var_4.script_noteworthy) && var_2.script_noteworthy == var_4.script_noteworthy;
    if(var_0 || var_1) {
      var_5 = level.calloutglobals.areaidmap[var_4.script_noteworthy];
      foreach(var_7 in level.players) {
        if(isDefined(var_5)) {
          var_7 setclientomnvar("ui_hp_callout_id", var_5);
        }
      }

      break;
    }
  }
}

forcespawnplayers() {
  var_0 = level.players;
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }

    var_2 notify("force_spawn");
    wait(0.1);
  }
}

getspawnpoint() {
  var_0 = self.pers["team"];
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = func_E172(level.zone.spawnpoints);
    var_3 = func_E172(level.zone.fallbackspawnpoints);
    var_4 = getkothzonedeadzonedist();
    var_5 = [];
    var_5["activeKOTHZoneNumber"] = level.zone getentitynumber();
    var_5["maxSquaredDistToObjective"] = level.zone.furthestspawndistsq;
    var_5["kothZoneDeadzoneDistSq"] = var_4 * var_4;
    var_5["closestEnemyInfluenceDistSq"] = 12250000;
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_3, var_5);
  }

  return var_2;
}

getkothzonedeadzonedist() {
  return 1000;
}

func_E172(var_0) {
  var_1 = [];
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.zone)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

onspawnplayer() {
  scripts\mp\utility::clearlowermessage("hq_respawn");
  self.forcespawnnearteammates = undefined;
}

movezoneaftertime(var_0) {
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

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(var_1 == self) {
    return;
  }

  if(!isDefined(level.zone)) {
    return;
  }

  var_10 = level.zone.gameobject.ownerteam;
  if(!isDefined(var_10)) {
    return;
  }

  if(isDefined(var_4) && scripts\mp\utility::iskillstreakweapon(var_4)) {
    return;
  }

  var_11 = self;
  var_12 = 0;
  var_13 = var_1.team;
  if(level.zonecapturetime > 0 && var_1 istouching(level.zone.gameobject.trigger)) {
    if(var_10 != var_13) {
      var_12 = 1;
    }
  }

  if(var_13 != var_10) {
    if(var_11 istouching(level.zone.gameobject.trigger)) {
      var_1.lastkilltime = gettime();
      if(var_12) {
        var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
      }

      var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
      thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
      return;
    }

    return;
  }

  if(var_1 istouching(level.zone.gameobject.trigger)) {
    if(var_12) {
      var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
    }

    var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
    var_1 scripts\mp\utility::incperstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    var_1 scripts\mp\utility::setextrascore1(var_1.pers["defends"]);
  }
}

give_capture_credit(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  var_4 = level.zone.gameobject scripts\mp\gameobjects::getearliestclaimplayer();
  if(isDefined(var_4.owner)) {
    var_4 = var_4.owner;
  }

  if(isPlayer(var_4)) {
    if(!isscoreboosting(var_4)) {
      var_4 thread scripts\mp\matchdata::loggameevent("capture", var_4.origin);
      var_4 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");
      if(isDefined(level.zone.gameobject.lastactivatetime) && gettime() - level.zone.gameobject.lastactivatetime <= 2100) {
        var_4 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
      }

      if(var_4.lastkilltime + 500 > gettime()) {} else {
        var_4 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var_4);
      }
    }
  }

  var_5 = getarraykeys(var_0);
  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_0[var_5[var_6]].player;
    var_7 updatecapsperminute(var_3);
    if(!isscoreboosting(var_7)) {
      var_7 scripts\mp\utility::incperstat("captures", 1);
      var_7 scripts\mp\persistence::statsetchild("round", "captures", var_7.pers["captures"]);
    }

    wait(0.05);
  }
}

awardcapturepoints() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_0 = 1;
  var_1 = 1;
  while(!level.gameended) {
    var_2 = 0;
    while(var_2 < var_0) {
      wait(0.05);
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + 0.05;
      if(level.zone.gameobject.stalemate) {
        var_2 = 0;
      }
    }

    var_3 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
    if(var_3 == "neutral") {
      continue;
    }

    if(level.usehqrules) {
      if(level.zoneadditivescoring) {
        var_1 = level.zone.gameobject.touchlist[var_3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);
      continue;
    }

    if(!level.zone.gameobject.stalemate && !level.gameended) {
      if(level.zoneadditivescoring) {
        var_1 = level.zone.gameobject.touchlist[var_3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);
      foreach(var_5 in level.zone.gameobject.touchlist[var_3]) {
        var_5.player scripts\mp\utility::incperstat("objTime", 1);
        if(isDefined(var_5.player.timebyrotation[level.kothhillrotation])) {
          var_5.player.timebyrotation[level.kothhillrotation]++;
        } else {
          var_5.player.timebyrotation[level.kothhillrotation] = 1;
        }

        var_5.player scripts\mp\persistence::statsetchild("round", "objTime", var_5.player.pers["objTime"]);
        var_5.player scripts\mp\utility::setextrascore0(var_5.player.pers["objTime"]);
        var_5.player scripts\mp\gamescore::giveplayerscore("koth_in_obj", 10);
      }
    }
  }
}

updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "neutral") {
    return;
  }

  self.numcaps++;
  var_1 = scripts\mp\utility::gettimepassed() / -5536;
  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    var_1 = self.timeplayed["total"] / 60;
  }

  self.capsperminute = self.numcaps / var_1;
  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
  }
}

isscoreboosting(var_0) {
  if(!level.rankedmatch) {
    return 0;
  }

  if(var_0.capsperminute > 6) {
    return 1;
  }

  return 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._hardpointeffect = [];
    var_0.numcaps = 0;
    var_0.capsperminute = 0;
    var_0.timebyrotation = [];
    var_0 scripts\mp\utility::setextrascore0(0);
    if(isDefined(var_0.pers["objTime"])) {
      var_0 scripts\mp\utility::setextrascore0(var_0.pers["objTime"]);
    }

    var_0 scripts\mp\utility::setextrascore1(0);
    if(isDefined(var_0.pers["defends"])) {
      var_0 scripts\mp\utility::setextrascore1(var_0.pers["defends"]);
    }

    thread onplayerspawned(var_0);
    foreach(var_2 in level.zones) {
      if(level.usehpzonebrushes) {
        var_2.gameobject scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var_0);
      }
    }

    var_0 thread refreshfreecamhardpointfx();
  }
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
    foreach(var_2 in level.zones) {
      if(isDefined(var_2.gameobject.var_19) && var_2.gameobject.var_19) {
        if(var_2.gameobject.ownerteam == "neutral") {
          var_2.gameobject scripts\mp\gametypes\obj_zonecapture::playhardpointneutralfx();
          continue;
        }

        var_2.gameobject scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(var_2.gameobject.ownerteam, var_0);
      }
    }
  }
}

updateservericons(var_0, var_1) {
  var_2 = -1;
  if(var_1) {
    var_2 = -2;
  } else {
    switch (var_0) {
      case "allies":
      case "axis":
        var_3 = thread getownerteamplayer(var_0);
        if(isDefined(var_3)) {
          var_2 = var_3 getentitynumber();
        }
        break;

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

getownerteamplayer(var_0) {
  var_1 = undefined;
  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

refreshfreecamhardpointfx() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "mlg_view_change") {
      foreach(var_3 in level.zones) {
        if(var_3.gameobject.ownerteam != "neutral") {
          var_3.gameobject scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(var_3.gameobject.ownerteam, self);
        }
      }
    }
  }
}

getrespawndelay() {
  if(!level.delayplayer) {
    return undefined;
  }

  var_0 = level.zone.gameobject.ownerteam;
  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level.spawndelay) {
        return undefined;
      }

      return level.spawndelay;
    }
  }
}

postshipmodifiedzones(var_0) {
  if(level.mapname == "mp_fallen" && var_0 == "5") {
    return 1;
  }

  return 0;
}

writeplayerrotationscoretomatchdataongameend() {
  level waittill("game_ended");
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      foreach(var_4, var_3 in var_1.timebyrotation) {
        if(var_4 < 14) {
          if(var_3 > 255) {
            var_3 = 255;
          }

          setmatchdata("players", var_1.clientid, "kothRotationScores", var_4, var_3);
        }
      }
    }
  }

  writecurrentrotationteamscore();
}

writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
  }
}