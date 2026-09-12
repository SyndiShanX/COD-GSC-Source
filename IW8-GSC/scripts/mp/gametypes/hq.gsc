/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\hq.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, "hqloc");
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_hq_zoneTimeout", getmatchrulesdata("hqData", "zoneTimeout"));
  setdynamicdvar("scr_hq_zoneLifetime", getmatchrulesdata("hqData", "zoneLifetime"));
  setdynamicdvar("scr_hq_zoneCaptureTime", getmatchrulesdata("hqData", "zoneCaptureTime"));
  setdynamicdvar("scr_hq_firstZoneActivationDelay", getmatchrulesdata("hqData", "firstZoneActivationDelay"));
  setdynamicdvar("scr_hq_zoneActivationDelay", getmatchrulesdata("hqData", "zoneActivationDelay"));
  setdynamicdvar("scr_hq_zoneSelectionDelay", getmatchrulesdata("hqData", "zoneSelectionDelay"));
  setdynamicdvar("scr_hq_randomLocationOrder", getmatchrulesdata("hqData", "randomLocationOrder"));
  setdynamicdvar("scr_hq_additiveScoring", getmatchrulesdata("hqData", "additiveScoring"));
  setdynamicdvar("scr_hq_pauseTime", getmatchrulesdata("hqData", "pauseTime"));
  setdynamicdvar("scr_hq_delayPlayer", getmatchrulesdata("hqData", "delayPlayer"));
  setdynamicdvar("scr_hq_useHPRules", getmatchrulesdata("hqData", "useHPRules"));
  setdynamicdvar("scr_hq_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("hq", 0);
}

function onstartgametype() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/HQ");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/HQ");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/HQ_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/HQ_HINT");
  }

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  thread setupzones();
  player_give_chopper();
  thread setupzoneareabrushes();
  initspawns();
  seticonnames();

  if(!level.zonerandomlocationorder) {
    ref_12BBC();
  }

  thread hqmainloop();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.zonetimeout = scripts\mp\utility\dvars::dvarfloatvalue("zoneTimeout", 60, 0, 300);
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("firstZoneActivationDelay", 30, 0, 120);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneActivationDelay", 30, 0, 120);
  level.zoneselectiondelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneSelectionDelay", 15, 0, 120);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.ref_1221A = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
  level.usehprules = scripts\mp\utility\dvars::dvarintvalue("useHPRules", 0, 0, 1);
}

function hqmainloop() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  setomnvar("ui_hq_status", -1);
  level.zone = getfirstzone();
  var_0 = 1;
  level.kothhillrotation = 0;
  level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");

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

  if(level.ref_1221A) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var_1 = 0;

  if(level.firstzoneactivationdelay) {
    thread waitthenshowfirsthqsplash();
    var_1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);
    thread waitthenplaynewobj();
    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199E(level.firstzoneactivationdelay, level.zone.visuals[0].origin + (0, 0, 70));
    wait level.firstzoneactivationdelay;
    scripts\mp\utility\game::setmlgannouncement(7, "free");
  }

  setomnvar("ui_objective_timer_stopped", 0);
  scripts\mp\utility\sound::playsoundonplayers("mp_hq_activate_sfx");

  for(;;) {
    if(!isDefined(level.ref_11AD5)) {
      thread setupzonecallouts();
    }

    level.objectivesetorder = 1;
    waittillframeend();

    if(!var_1) {
      foreach(var_3 in level.players) {
        scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var_3);
      }
    }

    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
    }

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_1, var_0);
    var_0 = 0;
    var_1 = 0;
    setomnvar("ui_hq_status", 2);
    scripts\mp\spawnlogic::clearlastteamspawns();
    level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_open");
    level.zone.visuals[0] playLoopSound("mp_iw8_hq_crate_active_idle");
    hpcaptureloop();
    var_5 = level.zone scripts\mp\gameobjects::getownerteam();
    setomnvar("ui_hq_ownerteam", 0);
    level.spectateoverride[game["attackers"]].allowenemyspectate = 0;
    level.spectateoverride[game["defenders"]].allowenemyspectate = 0;

    if(level.usehprules) {
      if(level.ref_1221A) {
        level scripts\mp\gamelogic::resumetimer();
      }
    }

    level.lastcaptureteam = undefined;
    killhardpointvfx(level.zone);
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_3 in level.players) {
        level.zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var_3);
      }
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("none");
    level.zone scripts\mp\gameobjects::setownerteam("neutral");
    updateservericons("zone_shift", 0);
    level notify("zone_reset");
    level.zone scripts\mp\gametypes\obj_zonecapture::deactivatezone();
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    setomnvar("ui_hq_status", 5);
    var_8 = int(gettime() + level.zoneselectiondelay * 1000 + 500);
    setomnvar("ui_hardpoint_timer", var_8);

    if(!level.usehprules) {
      if(level.zoneselectiondelay > 0) {
        if(level.ref_1221A) {
          level scripts\mp\gamelogic::pausetimer();
        }

        scripts\mp\spawnlogic::setactivespawnlogic("HQTDM", "Crit_Frontline");
        level.usetdmspawns = 1;
      }

      thread forcespawnplayers();

      if(level.zoneselectiondelay >= 10) {
        thread scripts\mp\gametypes\obj_zonecapture::hp_move_soon(level.zoneselectiondelay);
      }

      wait level.zoneselectiondelay;

      if(!istrue(level.binoculars_clearuidata)) {
        scripts\mp\spawnlogic::deactivatespawnset("normal");
        level.usetdmspawns = undefined;
        scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
      }
    }

    spawn_next_zone();
    wait 0.5;
  }
}

function waitthenplaynewobj() {
  if(istrue(level.infilvotiming)) {
    wait 8.5;
  } else {
    wait 6;
  }

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_first", var_1);
  }
}

function waitthenshowfirsthqsplash() {
  if(istrue(level.infilvotiming)) {
    wait 6.5;
  } else {
    wait 5.5;
  }

  level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
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
    default:
      break;
  }
}

function getfirstzone() {
  if(isDefined(level.ref_12BBE)) {
    var_0 = level.objectives[level.ref_12BBE[0]];
    level.prevzoneindex = 0;
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
  } else if(isDefined(level.ref_12BBE)) {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.ref_12BBE.size - 1) {
      level.prevzoneindex = 0;
    }

    var_23 = level.objectives[level.ref_12BBE[level.prevzoneindex]];
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
  level.zone = getnextzone();
  level.kothhillrotation++;
  resetzone(level.zone);
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

function resetzone() {
  self.lastclaimteam = "none";
  self.lastprogressteam = "none";
  self.ownerteam = "neutral";
  self.prevownerteam = "neutral";
  self.curprogress = 0;
  var_0 = getarraykeys(self.teamprogress);

  foreach(var_2 in var_0) {
    self.teamprogress[var_2] = 0;
  }

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

function hqactivatenextzone(var_0, var_1) {
  if(!var_1) {
    foreach(var_3 in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("hp_new_location", var_3);
    }
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_hq_activate_sfx");
  thread scripts\mp\music_and_dialog::headquarters_newhq_music();
  level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(var_0)) {} else if(level.zoneactivationdelay) {
    level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);

    if(level.ref_1221A) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199E(level.zoneactivationdelay, level.zone.visuals[0].origin + (0, 0, 70));
    wait level.zoneactivationdelay;
    scripts\mp\utility\game::setmlgannouncement(7, "free");
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_active", var_3);
  }

  level thread scripts\mp\hud_message::notifyteam("hq_capture", "hq_capture", "allies");

  if(level.ref_1221A) {
    level scripts\mp\gamelogic::resumetimer();
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("neutral", 0);

  if(level.zoneduration) {
    updateservericons("neutral", 0);

    if(level.zonetimeout == 0 && !level.usehprules) {
      thread locktimeruntilcap();
      return;
    }

    var_7 = scripts\engine\utility::ter_op(level.usehprules, level.zoneduration, level.zonetimeout);
    thread movezoneaftertime(var_7);
    level.zoneendtime = int(gettime() + 1000 * var_7);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    return;
  }

  level.zonedestroyedbytimer = 0;
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

    if(level.usehprules) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
      level.zone scripts\mp\gameobjects::cancontestclaim(1);
    }

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      level thread scripts\mp\gametypes\grnd::randomdrops();
    }

    var_0 = level scripts\engine\utility::ref_143AD("zone_captured", "zone_destroyed");

    if(var_0 == "zone_destroyed") {
      continue;
    } else if(!level.usehprules) {
      level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
      setomnvar("ui_hardpoint_timer", level.zoneendtime);
      setomnvar("ui_hq_status", 3);
    }

    var_1 = level.zone scripts\mp\gameobjects::getownerteam();
    thread updaterespawntimer();

    if(!level.usehprules && level.zoneduration > 0) {
      thread movezoneaftertime(level.zoneduration);
    }

    if(!level.usehprules && level.zonecapturetime > 0) {
      var_2 = scripts\mp\utility\teams::getteamdata(var_1, "players");
      level thread scripts\mp\hud_message::notifyteam("hq_captured", "hq_destroy", var_1, var_2);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1, 17, 29);
    scripts\mp\utility\game::setmlgannouncement(8, var_1);
    level waittill("zone_destroyed", var_3);
    scripts\mp\utility\game::setmlgannouncement(9, "free");

    if(!level.usehprules && level.zonecapturetime > 0) {
      level thread scripts\mp\hud_message::notifyteam("hq_destroyed", "hq_destroyed", "allies");
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    level.spawndelay = undefined;

    if(isDefined(var_3)) {
      level.zone scripts\mp\gameobjects::setownerteam(var_3);
    } else {
      level.zone scripts\mp\gameobjects::setownerteam("none");
    }

    if(!level.usehprules) {
      setomnvar("ui_hardpoint_timer", 0);
      setomnvar("ui_hq_status", -1);
      break;
    }
  }
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
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_2);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_3);
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
    var_9 = scripts\mp\spawnlogic::getoriginidentifierstring(var_8);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var_9])) {
      foreach(var_11 in level.kothextraprimaryspawnpoints[var_9]) {
        var_5 = level.objectives[var_11];
        var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
      }
    }

    var_13 = 0;
    var_14 = var_8.classname == "mp_koth_spawn_allies_start" || var_8.classname == "mp_koth_spawn_axis_start";
    var_15 = var_8.classname == "mp_koth_spawn";
    var_16 = var_8.classname == "mp_koth_spawn_secondary";
    var_17 = var_8.classname == "mp_tdm_spawn";
    var_18 = var_8.classname == "mp_tdm_spawn_secondary";
    var_19 = [];

    if(var_14) {
      continue;
    }

    if(var_15 || var_16) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy != "") {
        var_13 = 1;
        var_19 = strtok(var_8.script_noteworthy, " ");

        foreach(var_11 in var_19) {
          if(var_11 == "6v6" || var_11 == "10v10") {
            continue;
          }

          if(!postshipmodifiedzones(var_11)) {
            var_5 = level.objectives[var_11];

            if(var_15) {
              var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
              continue;
            }

            var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
          }
        }
      }
    }

    calculatespawndisttozones(var_8, var_19);

    if(!var_13 && !var_17 && !var_18) {
      foreach(var_5 in level.objectives) {
        if(var_15) {
          var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
          continue;
        }

        var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
      }
    }
  }

  foreach(var_5 in level.objectives) {
    var_5.spawnset = "koth_" + var_26;
    scripts\mp\spawnlogic::registerspawnset(var_5.spawnset, var_5.spawnpoints);
    var_5.fallbackspawnset = "koth_fallback_" + var_26;
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

    var_8 = getpathdist(var_0.origin, var_4.trigger.origin, 5000);

    if(var_8 < 0) {
      var_8 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_4.trigger.origin);
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
  var_0 = player_give_loadout(var_0);
  var_1 = [];
  var_2 = 0;
  var_3 = getEntArray("hqloc", "targetname");
  var_4 = [];

  if(var_0.size != var_3.size) {
    var_1 = "Number of hqloc Radios and hardpoint_zone triggers are not equal";
    var_2 = 1;

    foreach(var_6 in var_0) {
      var_7 = 0;

      foreach(var_9 in var_3) {
        if(var_9 istouching(var_6)) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = "hardpoint_zone: " + var_6.script_label + " has no hqloc radio inside it";
      }
    }
  }

  level.objectives = [];

  for(var_12 = 0; var_12 < var_3.size; var_12++) {
    var_9 = var_3[var_12];
    var_6 = undefined;

    for(var_13 = 0; var_13 < var_0.size; var_13++) {
      if(var_9 istouching(var_0[var_13])) {
        if(isDefined(var_6)) {
          var_1 = "Radio at " + var_9.origin + " is touching more than one \"hardpoint_zone\" trigger";
          var_2 = 1;
          break;
        }

        var_6 = var_0[var_13];
        break;
      }
    }

    if(!isDefined(var_6)) {
      if(!var_2) {
        var_1 = "Radio at " + var_9.origin + " is not inside any \"hardpoint_zone\" trigger";
        var_2 = 1;
        continue;
      }
    }

    var_4 = [];
    var_4 = var_9;
    var_14 = getEntArray(var_9.target, "targetname");

    for(var_15 = 0; var_15 < var_14.size; var_15++) {
      var_4 = var_14[var_15];
    }

    var_16 = scripts\mp\gametypes\obj_zonecapture::setupobjective(var_6, var_4);
    level.objectives[var_16.objectivekey] = var_16;
  }

  if(var_1.size > 0) {
    for(var_12 = 0; var_12 < var_1.size; var_12++) {}

    return;
  }

  var_17 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  var_18 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  level.startpos["allies"] = var_18[0].origin;
  level.startpos["axis"] = var_17[0].origin;
  return 1;
}

function player_give_loadout(var_0) {
  var_1 = getDvar("ui_mapname");

  if(var_1 == "mp_m_cornfield") {
    foreach(var_3 in var_0) {
      var_3.origin -= (0, 0, 9);

      if(isDefined(var_3.script_label) && var_3.script_label == "2") {
        var_3.origin -= (0, 0, 9);
        continue;
      }

      if(isDefined(var_3.script_label) && var_3.script_label == "3") {
        var_3.origin -= (0, 0, 9);
      }
    }
  }

  return var_0;
}

function player_give_chopper(var_0) {
  var_1 = getDvar("ui_mapname");

  if(var_1 == "mp_harbor") {
    level.objectives["5"].visuals[0].origin = level.objectives["5"].visuals[0].origin - (0, 0, 8);
    level.objectives["5"].visuals[1].origin = level.objectives["5"].visuals[1].origin - (0, 0, 8);
    return;
  }
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

  scripts\mp\utility\game::setmlgannouncement(6, "free");
}

function forcespawnplayers() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || istrue(var_2.fauxdead) && var_2 scripts\mp\utility\player::isusingremote() || isalive(var_2) && !istrue(var_2.fauxdead)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var_2);
    var_2 notify("force_spawn");
    waitframe();
  }

  thread ref_14394();
}

function ref_14394() {
  wait 3;
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 scripts\mp\utility\player::isinkillcam()) {
      thread ref_14373();
      continue;
    }

    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var_2);
    var_2 notify("force_spawn");
    waitframe();
    LOC_00000083:
  }
}

function ref_14373() {
  level endon("game_ended");
  self endon("spawned");

  while(scripts\mp\utility\player::isinkillcam()) {
    wait 0.1;
  }

  wait 1;
  self notify("force_spawn");
}

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = getkothzonedeadzonedist();
  var_2 = [];
  GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.zone.trigger getentitynumber());
}

function getkothzonedeadzonedist() {
  if(!istrue(level.zone.active)) {
    return 2000;
  }

  return 1000;
}

function onspawnplayer() {
  self setclientomnvar("ui_hq_norespawn", 0);

  if(isDefined(level.zone) && isDefined(level.zone.ownerteam) && level.zone.ownerteam != "neutral") {
    setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "aliveCount"));
  }

  self.forcespawnnearteammates = undefined;
  self.skipspawncamera = undefined;
  thread updatematchstatushintonspawn();
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

  foreach(var_2 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_timeout", var_2);
  }

  scripts\mp\utility\game::setmlgannouncement(9, "free");
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function onsuicidedeath(var_0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(var_0.team, "aliveCount"));
}

function modeonteamchangedeath(var_0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(var_0.leaving_team, "aliveCount"));
}

function get_br_jugg_setting(var_0) {
  var_1 = level.zone.ownerteam == var_0.team;
  return !var_1;
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.zone.ownerteam;

  if(!isPlayer(var_1) || var_1.team == self.team) {
    if(var_10 != "neutral") {
      self.skipspawncamera = 1;
    }

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

  if(var_10 != "neutral") {
    updatehqaliveomnvars(level, var_10);
  }

  if(var_10 == var_11.team) {
    var_11.skipspawncamera = 1;
  }

  if(level.zone.active) {
    if(level.zonecapturetime > 0 && var_1 istouching(level.zone.trigger)) {
      if(var_10 != var_13) {
        var_12 = 1;
      }
    }

    if(var_13 != var_10) {
      if(var_12) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      } else if(var_11 istouching(level.zone.trigger)) {
        var_1 thread scripts\mp\rank::scoreeventpopup("assault");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13E0A(level.ref_11B30, var_9, "defending");
      }
    } else if(var_1 istouching(level.zone.trigger)) {
      var_1 thread scripts\mp\rank::scoreeventpopup("defend");
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["defends"]);
    }
  }

  thread checkallowspectating();
}

function checkallowspectating() {
  if(level.zone.ownerteam == "neutral") {
    return;
  }

  if(!scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "aliveCount")) {
    level.spectateoverride[level.zone.ownerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function updatehqaliveomnvars(var_0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(var_0, "aliveCount"));
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
      var_6 thread scripts\mp\rank::scoreeventpopup("hq_secure");
      var_6 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");

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
      var_9 scripts\mp\utility\stats::setextrascore0(var_9.pers["captures"]);
    }

    wait 0.05;
  }

  if(isDefined(var_5.assisttouchlist)) {
    if(var_5.assisttouchlist[var_2].size > 0) {
      var_10 = getarraykeys(var_5.assisttouchlist[var_2]);

      foreach(var_12 in var_7) {
        foreach(var_14 in var_10) {
          if(var_14 == var_12) {
            var_5.assisttouchlist[var_2][var_14] = undefined;
          }
        }
      }
    }

    if(var_5.assisttouchlist[var_2].size > 0) {
      thread scriptedagentmodifieddamage(var_5);
      return;
    }

    return;
  }
}

function scriptedagentmodifieddamage(var_0) {
  level endon("game_ended");
  var_1 = getarraykeys(self.assisttouchlist[var_0]);

  if(var_1.size > 0) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = self.assisttouchlist[var_0][var_1[var_2]].player;

      if(isDefined(var_3.owner)) {
        var_3 = var_3.owner;
      }

      if(!isPlayer(var_3)) {
        continue;
      }

      var_3 scripts\mp\utility\stats::incpersstat("captures", 1);
      var_3 scripts\mp\persistence::statsetchild("round", "captures", var_3.pers["captures"]);
      var_3 scripts\mp\utility\stats::setextrascore0(var_3.pers["captures"]);
      var_3 thread scripts\mp\rank::scoreeventpopup("capture_assist");
      var_3 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_assist");
      var_3 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var_3);
      self.assisttouchlist[var_0][var_1[var_2]] = undefined;
      wait 0.05;
    }

    return;
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
      wait level.framedurationseconds;
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 += level.framedurationseconds;

      if(level.usehprules) {
        if(level.zone.stalemate) {}
      }
    }

    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_3 == "neutral") {
      continue;
    }

    if(!level.usehprules) {
      if(level.zoneadditivescoring) {
        var_1 = level.zone.touchlist[var_3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);

      if(!istrue(level.ref_12F0E)) {
        binoculars_cleanupheadiconondisconnect(var_3);
      }

      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring) {
        var_1 = level.zone.touchlist[var_3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);
    }
  }
}

function binoculars_cleanupheadiconondisconnect(var_0) {
  if(!level.ref_1221A) {
    return;
  }

  var_1 = scripts\mp\gamescore::_getteamscore(var_0);
  var_2 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var_0)[0]);

  if(var_1 > var_2) {
    level.ref_12F0E = 1;
    level scripts\mp\gamelogic::resumetimer();
    return;
  }

  level scripts\mp\gamelogic::pausetimer();
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

function onplayerconnect(var_0) {
  var_0 setclientomnvar("ui_hq_norespawn", 0);
  var_0._hardpointeffect = [];
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["captures"])) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["captures"]);
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

function gethqownerteamvalue(var_0) {
  if(var_0 == "allies") {
    var_1 = 2;
  } else if(var_1 == "axis") {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  return var_1;
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

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.zone)) {
    if(isDefined(level.zone.ownerteam)) {
      if(level.zone.ownerteam == "neutral") {
        self setclientomnvar("ui_match_status_hint_text", 16);
        return;
      }

      if(level.zone.ownerteam == self.team) {
        self setclientomnvar("ui_match_status_hint_text", 17);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 29);
      return;
    }

    return;
  }
}

function showrespawnwarningmessage() {
  self endon("death_or_disconnect");
  self setclientomnvar("ui_hq_norespawn", 1);
  wait 5;
  self setclientomnvar("ui_hq_norespawn", 0);
}

function postshipmodifiedzones(var_0) {
  if(level.mapname == "mp_fallen" && var_0 == "5") {
    return true;
  }

  return false;
}

function seticonnames() {
  level.icontarget = "hq_target";
  level.iconneutral = "hq_neutral";
  level.iconcapture = "hq_destroy";
  level.icondefend = "hq_defend";
  level.iconcontested = "hq_contested";
  level.icontaking = "hq_taking";
  level.iconlosing = "hq_losing";
  level.icondefending = "hq_defending";
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