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
  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/HQ");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/HQ");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/HQ_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/HQ_HINT");
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
    ref_12bbc();
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
  level.ref_1221a = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
  level.usehprules = scripts\mp\utility\dvars::dvarintvalue("useHPRules", 0, 0, 1);
}

function hqmainloop() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  setomnvar("ui_hq_status", -1);
  level.zone = getfirstzone();
  var0 = 1;
  level.kothhillrotation = 0;
  level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");

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

  if(level.ref_1221a) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var1 = 0;

  if(level.firstzoneactivationdelay) {
    thread waitthenshowfirsthqsplash();
    var1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);
    thread waitthenplaynewobj();
    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199e(level.firstzoneactivationdelay, level.zone.visuals[0].origin + (0, 0, 70));
    wait level.firstzoneactivationdelay;
    scripts\mp\utility\game::setmlgannouncement(7, "free");
  }

  setomnvar("ui_objective_timer_stopped", 0);
  scripts\mp\utility\sound::playsoundonplayers("mp_hq_activate_sfx");

  for(;;) {
    if(!isDefined(level.ref_11ad5)) {
      thread setupzonecallouts();
    }

    level.objectivesetorder = 1;
    waittillframeend();

    if(!var1) {
      foreach(var3 in level.players) {
        scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var3);
      }
    }

    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
    }

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var1, var0);
    var0 = 0;
    var1 = 0;
    setomnvar("ui_hq_status", 2);
    scripts\mp\spawnlogic::clearlastteamspawns();
    level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_open");
    level.zone.visuals[0] playLoopSound("mp_iw8_hq_crate_active_idle");
    hpcaptureloop();
    var5 = level.zone scripts\mp\gameobjects::getownerteam();
    setomnvar("ui_hq_ownerteam", 0);
    level.spectateoverride[game["attackers"]].allowenemyspectate = 0;
    level.spectateoverride[game["defenders"]].allowenemyspectate = 0;

    if(level.usehprules) {
      if(level.ref_1221a) {
        level scripts\mp\gamelogic::resumetimer();
      }
    }

    level.lastcaptureteam = undefined;
    killhardpointvfx(level.zone);
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var3 in level.players) {
        level.zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(var3);
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
    var8 = int(gettime() + level.zoneselectiondelay * 1000 + 500);
    setomnvar("ui_hardpoint_timer", var8);

    if(!level.usehprules) {
      if(level.zoneselectiondelay > 0) {
        if(level.ref_1221a) {
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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_first", var1);
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
    default:
      break;
  }
}

function getfirstzone() {
  if(isDefined(level.ref_12bbe)) {
    var0 = level.objectives[level.ref_12bbe[0]];
    level.prevzoneindex = 0;
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
  } else if(isDefined(level.ref_12bbe)) {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.ref_12bbe.size - 1) {
      level.prevzoneindex = 0;
    }

    var23 = level.objectives[level.ref_12bbe[level.prevzoneindex]];
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

  level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_moved", level.zone.trigger.origin);
}

function resetzone() {
  self.lastclaimteam = "none";
  self.lastprogressteam = "none";
  self.ownerteam = "neutral";
  self.prevownerteam = "neutral";
  self.curprogress = 0;
  var0 = getarraykeys(self.teamprogress);

  foreach(var2 in var0) {
    self.teamprogress[var2] = 0;
  }

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

function hqactivatenextzone(var0, var1) {
  if(!var1) {
    foreach(var3 in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("hp_new_location", var3);
    }
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_hq_activate_sfx");
  thread scripts\mp\music_and_dialog::headquarters_newhq_music();
  level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(var0)) {} else if(level.zoneactivationdelay) {
    level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);

    if(level.ref_1221a) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level.zone thread scripts\mp\gametypes\obj_zonecapture::ref_1199e(level.zoneactivationdelay, level.zone.visuals[0].origin + (0, 0, 70));
    wait level.zoneactivationdelay;
    scripts\mp\utility\game::setmlgannouncement(7, "free");
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_active", var3);
  }

  level thread scripts\mp\hud_message::notifyteam("hq_capture", "hq_capture", "allies");

  if(level.ref_1221a) {
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

    var7 = scripts\engine\utility::ter_op(level.usehprules, level.zoneduration, level.zonetimeout);
    thread movezoneaftertime(var7);
    level.zoneendtime = int(gettime() + 1000 * var7);
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

    var0 = level scripts\engine\utility::ref_143ad("zone_captured", "zone_destroyed");

    if(var0 == "zone_destroyed") {
      continue;
    } else if(!level.usehprules) {
      level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
      setomnvar("ui_hardpoint_timer", level.zoneendtime);
      setomnvar("ui_hq_status", 3);
    }

    var1 = level.zone scripts\mp\gameobjects::getownerteam();
    thread updaterespawntimer();

    if(!level.usehprules && level.zoneduration > 0) {
      thread movezoneaftertime(level.zoneduration);
    }

    if(!level.usehprules && level.zonecapturetime > 0) {
      var2 = scripts\mp\utility\teams::getteamdata(var1, "players");
      level thread scripts\mp\hud_message::notifyteam("hq_captured", "hq_destroy", var1, var2);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var1, 17, 29);
    scripts\mp\utility\game::setmlgannouncement(8, var1);
    level waittill("zone_destroyed", var3);
    scripts\mp\utility\game::setmlgannouncement(9, "free");

    if(!level.usehprules && level.zonecapturetime > 0) {
      level thread scripts\mp\hud_message::notifyteam("hq_destroyed", "hq_destroyed", "allies");
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    level.spawndelay = undefined;

    if(isDefined(var3)) {
      level.zone scripts\mp\gameobjects::setownerteam(var3);
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
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn");
  var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var2);
  scripts\mp\spawnlogic::registerspawnset("fallback", var3);
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
    var9 = scripts\mp\spawnlogic::getoriginidentifierstring(var8);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var9])) {
      foreach(var11 in level.kothextraprimaryspawnpoints[var9]) {
        var5 = level.objectives[var11];
        var5.spawnpoints[var5.spawnpoints.size] = var8;
      }
    }

    var13 = 0;
    var14 = var8.classname == "mp_koth_spawn_allies_start" || var8.classname == "mp_koth_spawn_axis_start";
    var15 = var8.classname == "mp_koth_spawn";
    var16 = var8.classname == "mp_koth_spawn_secondary";
    var17 = var8.classname == "mp_tdm_spawn";
    var18 = var8.classname == "mp_tdm_spawn_secondary";
    var19 = [];

    if(var14) {
      continue;
    }

    if(var15 || var16) {
      if(isDefined(var8.script_noteworthy) && var8.script_noteworthy != "") {
        var13 = 1;
        var19 = strtok(var8.script_noteworthy, " ");

        foreach(var11 in var19) {
          if(var11 == "6v6" || var11 == "10v10") {
            continue;
          }

          if(!postshipmodifiedzones(var11)) {
            var5 = level.objectives[var11];

            if(var15) {
              var5.spawnpoints[var5.spawnpoints.size] = var8;
              continue;
            }

            var5.fallbackspawnpoints[var5.fallbackspawnpoints.size] = var8;
          }
        }
      }
    }

    calculatespawndisttozones(var8, var19);

    if(!var13 && !var17 && !var18) {
      foreach(var5 in level.objectives) {
        if(var15) {
          var5.spawnpoints[var5.spawnpoints.size] = var8;
          continue;
        }

        var5.fallbackspawnpoints[var5.fallbackspawnpoints.size] = var8;
      }
    }
  }

  foreach(var5 in level.objectives) {
    var5.spawnset = "koth_" + var26;
    scripts\mp\spawnlogic::registerspawnset(var5.spawnset, var5.spawnpoints);
    var5.fallbackspawnset = "koth_fallback_" + var26;
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

    var8 = getpathdist(var0.origin, var4.trigger.origin, 5000);

    if(var8 < 0) {
      var8 = scripts\engine\utility::distance_2d_squared(var0.origin, var4.trigger.origin);
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
  var0 = player_give_loadout(var0);
  var1 = [];
  var2 = 0;
  var3 = getEntArray("hqloc", "targetname");
  var4 = [];

  if(var0.size != var3.size) {
    var1 = "Number of hqloc Radios and hardpoint_zone triggers are not equal";
    var2 = 1;

    foreach(var6 in var0) {
      var7 = 0;

      foreach(var9 in var3) {
        if(var9 istouching(var6)) {
          var7 = 1;
          break;
        }
      }

      if(!var7) {
        var1 = "hardpoint_zone: " + var6.script_label + " has no hqloc radio inside it";
      }
    }
  }

  level.objectives = [];

  for(var12 = 0; var12 < var3.size; var12++) {
    var9 = var3[var12];
    var6 = undefined;

    for(var13 = 0; var13 < var0.size; var13++) {
      if(var9 istouching(var0[var13])) {
        if(isDefined(var6)) {
          var1 = "Radio at " + var9.origin + " is touching more than one \"hardpoint_zone\" trigger";
          var2 = 1;
          break;
        }

        var6 = var0[var13];
        break;
      }
    }

    if(!isDefined(var6)) {
      if(!var2) {
        var1 = "Radio at " + var9.origin + " is not inside any \"hardpoint_zone\" trigger";
        var2 = 1;
        continue;
      }
    }

    var4 = [];
    var4 = var9;
    var14 = getEntArray(var9.target, "targetname");

    for(var15 = 0; var15 < var14.size; var15++) {
      var4 = var14[var15];
    }

    var16 = scripts\mp\gametypes\obj_zonecapture::setupobjective(var6, var4);
    level.objectives[var16.objectivekey] = var16;
  }

  if(var1.size > 0) {
    for(var12 = 0; var12 < var1.size; var12++) {}

    return;
  }

  var17 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  var18 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  level.startpos["allies"] = var18[0].origin;
  level.startpos["axis"] = var17[0].origin;
  return 1;
}

function player_give_loadout(var0) {
  var1 = getDvar("NSQLTTMRMP");

  if(var1 == "mp_m_cornfield") {
    foreach(var3 in var0) {
      var3.origin -= (0, 0, 9);

      if(isDefined(var3.script_label) && var3.script_label == "2") {
        var3.origin -= (0, 0, 9);
        continue;
      }

      if(isDefined(var3.script_label) && var3.script_label == "3") {
        var3.origin -= (0, 0, 9);
      }
    }
  }

  return var0;
}

function player_give_chopper(var0) {
  var1 = getDvar("NSQLTTMRMP");

  if(var1 == "mp_harbor") {
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

  scripts\mp\utility\game::setmlgannouncement(6, "free");
}

function forcespawnplayers() {
  var0 = level.players;

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(!isDefined(var2) || istrue(var2.fauxdead) && var2 scripts\mp\utility\player::isusingremote() || isalive(var2) && !istrue(var2.fauxdead)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var2);
    var2 notify("force_spawn");
    waitframe();
  }

  thread ref_14394();
}

function ref_14394() {
  wait 3;
  var0 = level.players;

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(var2 scripts\mp\utility\player::isinkillcam()) {
      thread ref_14373();
      continue;
    }

    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var2);
    var2 notify("force_spawn");
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
  var0 = self.pers["team"];
  var1 = getkothzonedeadzonedist();
  var2 = [];
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

  foreach(var2 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_timeout", var2);
  }

  scripts\mp\utility\game::setmlgannouncement(9, "free");
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function onsuicidedeath(var0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(var0.team, "aliveCount"));
}

function modeonteamchangedeath(var0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(var0.leaving_team, "aliveCount"));
}

function get_br_jugg_setting(var0) {
  var1 = level.zone.ownerteam == var0.team;
  return !var1;
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = level.zone.ownerteam;

  if(!isPlayer(var1) || var1.team == self.team) {
    if(var10 != "neutral") {
      self.skipspawncamera = 1;
    }

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

  if(var10 != "neutral") {
    updatehqaliveomnvars(level, var10);
  }

  if(var10 == var11.team) {
    var11.skipspawncamera = 1;
  }

  if(level.zone.active) {
    if(level.zonecapturetime > 0 && var1 istouching(level.zone.trigger)) {
      if(var10 != var13) {
        var12 = 1;
      }
    }

    if(var13 != var10) {
      if(var12) {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      } else if(var11 istouching(level.zone.trigger)) {
        var1 thread scripts\mp\rank::scoreeventpopup("assault");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
      }
    } else if(var1 istouching(level.zone.trigger)) {
      var1 thread scripts\mp\rank::scoreeventpopup("defend");
      var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      var1 scripts\mp\utility\stats::setextrascore1(var1.pers["defends"]);
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

function updatehqaliveomnvars(var0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(var0, "aliveCount"));
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
      var6 thread scripts\mp\rank::scoreeventpopup("hq_secure");
      var6 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");

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
      var9 scripts\mp\utility\stats::setextrascore0(var9.pers["captures"]);
    }

    wait 0.05;
  }

  if(isDefined(var5.assisttouchlist)) {
    if(var5.assisttouchlist[var2].size > 0) {
      var10 = getarraykeys(var5.assisttouchlist[var2]);

      foreach(var12 in var7) {
        foreach(var14 in var10) {
          if(var14 == var12) {
            var5.assisttouchlist[var2][var14] = undefined;
          }
        }
      }
    }

    if(var5.assisttouchlist[var2].size > 0) {
      thread scriptedagentmodifieddamage(var5);
      return;
    }

    return;
  }
}

function scriptedagentmodifieddamage(var0) {
  level endon("game_ended");
  var1 = getarraykeys(self.assisttouchlist[var0]);

  if(var1.size > 0) {
    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = self.assisttouchlist[var0][var1[var2]].player;

      if(isDefined(var3.owner)) {
        var3 = var3.owner;
      }

      if(!isPlayer(var3)) {
        continue;
      }

      var3 scripts\mp\utility\stats::incpersstat("captures", 1);
      var3 scripts\mp\persistence::statsetchild("round", "captures", var3.pers["captures"]);
      var3 scripts\mp\utility\stats::setextrascore0(var3.pers["captures"]);
      var3 thread scripts\mp\rank::scoreeventpopup("capture_assist");
      var3 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure_assist");
      var3 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var3);
      self.assisttouchlist[var0][var1[var2]] = undefined;
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
  var0 = 1;
  var1 = 1;

  while(!level.gameended) {
    for(var2 = 0; var2 < var0; var2 = 0) {
      wait level.framedurationseconds;
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var2 += level.framedurationseconds;

      if(level.usehprules) {
        if(level.zone.stalemate) {}
      }
    }

    var3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var3 == "neutral") {
      continue;
    }

    if(!level.usehprules) {
      if(level.zoneadditivescoring) {
        var1 = level.zone.touchlist[var3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var3, var1, 0);

      if(!istrue(level.ref_12f0e)) {
        binoculars_cleanupheadiconondisconnect(var3);
      }

      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring) {
        var1 = level.zone.touchlist[var3].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(var3, var1, 0);
    }
  }
}

function binoculars_cleanupheadiconondisconnect(var0) {
  if(!level.ref_1221a) {
    return;
  }

  var1 = scripts\mp\gamescore::_getteamscore(var0);
  var2 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var0)[0]);

  if(var1 > var2) {
    level.ref_12f0e = 1;
    level scripts\mp\gamelogic::resumetimer();
    return;
  }

  level scripts\mp\gamelogic::pausetimer();
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

function onplayerconnect(var0) {
  var0 setclientomnvar("ui_hq_norespawn", 0);
  var0._hardpointeffect = [];
  var0.numcaps = 0;
  var0.capsperminute = 0;
  var0.timebyrotation = [];
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["captures"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["captures"]);
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

function gethqownerteamvalue(var0) {
  if(var0 == "allies") {
    var1 = 2;
  } else if(var1 == "axis") {
    var1 = 1;
  } else {
    var1 = 0;
  }

  return var1;
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

function postshipmodifiedzones(var0) {
  if(level.mapname == "mp_fallen" && var0 == "5") {
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