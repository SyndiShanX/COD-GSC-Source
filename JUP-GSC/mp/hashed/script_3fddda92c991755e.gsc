/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3fddda92c991755e.gsc
*************************************************/

#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace namespace_440053aa087d84ad;

function updategametypedvars() {
  level.winrule = dvarintvalue("winRule", 0, 0, 1);
  level.showenemycarrier = dvarintvalue("showEnemyCarrier", 1, 0, 6);
  level.idleresettime = dvarfloatvalue("idleResetTime", 30, 0, 60);
  level.capturecondition = dvarintvalue("captureCondition", 0, 0, 1);
  level.pickuptime = dvarfloatvalue("pickupTime", 0.5, 0, 10);
  level.returntime = dvarfloatvalue("returnTime", 0.5, -1, 25);
  level.carryzonespeedscale = dvarfloatvalue("carryZoneSpeedScale", 0.6, 0, 1);
  level.flagswitchtp = dvarintvalue("flagSwitchTP", 0, 0, 1);
  level.requiredflag = dvarintvalue("requiredFlag", 1, 1, 10);
  level.enableflagcheckpoint = dvarintvalue("enableFlagCheckPoint", 0, 0, 1);
}

function function_a892b65a4cfef993(flagpoints) {
  if(flagpoints.size == 0) {
    assertmsg("<dev string:x1c>");
    return;
  }

  captureflags = [];

  foreach(flagpoint in flagpoints) {
    captureflags[captureflags.size] = createteamflag(flagpoint);
  }

  return captureflags;
}

function function_c10d8e3981d437eb() {
  foreach(captureflag in level.zone.captureflags) {
    captureflag scripts\mp\gameobjects::allowcarry("none");
    captureflag scripts\mp\gameobjects::setvisibleteam("none");
  }
}

function function_fef84731c75ce2c5() {
  foreach(captureflag in level.zone.captureflags) {
    objective_state(captureflag.objidnum, "current");
    captureflag scripts\mp\gameobjects::allowcarry("enemy");
    captureflag scripts\mp\gameobjects::setvisibleteam("any");
    scripts\mp\gametypes\wm_objectives::function_a2ef0341d328f8e1(captureflag.objectivekey);
  }
}

function createteamflag(flagpoint) {
  if(isDefined(flagpoint)) {
    if(isDefined(flagpoint.target)) {
      ent = getStruct(flagpoint.target, "targetname");
      flagorigin = ent.origin;
      flagangles = ent.angles;
    } else {
      flagorigin = flagpoint.origin;
    }
  } else {
    assertmsg("<dev string:x3a>");
  }

  trigger = flagpoint;
  visuals = [];
  visuals[0] = spawn("script_model", flagorigin);
  visuals[0].angles = flagangles;
  visuals[0] setModel(level.flagmodel);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(game["defenders"]);
  visuals[0] setnonstick(1);
  teamflag = scripts\mp\gameobjects::createcarryobject(game["defenders"], trigger, visuals, (0, 0, 32));
  teamflag.iconname = trigger.objectivekey;
  teamflag.objectivekey = trigger.objectivekey;
  teamflag scripts\mp\gameobjects::setteamusetime("enemy", level.pickuptime);
  teamflag scripts\mp\gameobjects::allowcarry("none");
  teamflag scripts\mp\gameobjects::allowuse("enemy");
  teamflag scripts\mp\gameobjects::setvisibleteam("none");
  teamflag scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_flag", "waypoint_take_flag");
  teamflag scripts\mp\objidpoolmanager::objective_set_play_intro(teamflag.objidnum, 0);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_outro(teamflag.objidnum, 0);
  teamflag scripts\mp\gameobjects::registercarryobjectpickupcheck(&flagpickupchecks);
  teamflag scripts\mp\gameobjects::setusehinttext(&"MP_JUP_SKYDIVING/PRESS_TO_TAKE_DEVICE");
  teamflag.trigger setuseprioritymax();
  teamflag.allowweapons = 1;
  teamflag.onpickup = &onpickup;
  teamflag.onpickupfailed = &onpickupfailed;
  teamflag.ondrop = &ondrop;
  teamflag.onreset = &onreset;
  teamflag scripts\mp\gameobjects::create_manual_drop_data_struct([visuals[0]], trigger, 1, 80, 0);
  teamflag.manualdropdata.var_1ecf2919ce07add = 1;
  objective_state(teamflag.objidnum, "done");
  return teamflag;
}

function createflagzone(flagzone) {
  trigger = flagzone;
  visuals = [];
  capzone = scripts\mp\gameobjects::createuseobject(game["defenders"], trigger, visuals, (0, 0, 85), undefined);
  capzone.objectivekey = trigger.objectivekey;
  capzone.iconname = trigger.objectivekey;
  capzone scripts\mp\gameobjects::allowuse("none");
  capzone scripts\mp\gameobjects::setvisibleteam("none");
  capzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_PDS", "waypoint_install_PDS");
  capzone scripts\mp\gameobjects::setusetime(0.01);
  capzone scripts\mp\gameobjects::setusehinttext(&"MP_JUP_SKYDIVING/PRESS_TO_DEPLOY_DEVICE");
  capzone.trigger setuseprioritymax();
  capzone.trigger setuseholdduration("duration_none");
  objective_state(capzone.objidnum, "done");
  capzone.onuse = &onuse;
  capzone.oncantuse = &oncantuse;
  var_31a72e6f2e39b666 = spawn("script_model", capzone.curorigin);
  var_31a72e6f2e39b666.angles = trigger.angles;
  var_31a72e6f2e39b666 makeusable();
  var_31a72e6f2e39b666 sethintdisplayrange(256);
  var_31a72e6f2e39b666 sethintdisplayfov(360);
  var_31a72e6f2e39b666 setuserange(128);
  var_31a72e6f2e39b666 setusefov(360);
  var_31a72e6f2e39b666 sethintonobstruction("show");
  var_31a72e6f2e39b666 setCursorHint("HINT_NOBUTTON");
  var_31a72e6f2e39b666 setHintString(&"MP_JUP_WM/NEED_FILTER");
  capzone.var_31a72e6f2e39b666 = var_31a72e6f2e39b666;
  slots = getStructArray(trigger.target, "targetname");

  foreach(slot in slots) {
    slot.isdeployed = 0;
  }

  capzone.var_be1fd1f8d27142d8 = slots;
  return capzone;
}

function setteaminhuddatafromteamname(teamname) {
  if(teamname == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(teamname == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function onpickup(player, playervo, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");
  level notify("filter_picked_up");
  team = player.pers["team"];

  if(team == game["attackers"]) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
    player attachflag();
    player.carryingflag = self;
    player.playerstreakspeedscale = -0.4;
    player scripts\mp\weapons::updatemovespeedscale();
    player setclientomnvar("ui_filter_player_hud_icon", 1);
    player function_47f0240ed7f9e0c8();
    player function_2dc4851c2a22292d();
    thread scripts\mp\hud_util::teamplayercardsplash("jup_wm_picked_up_filter", player);

    if(istrue(level.flagswitchtp)) {
      player setcamerathirdperson(1);
    }

    if(getgametype() == "wm") {
      player playsoundtoteam("jup_mode_wm_pds_ally_pickup", player.team, undefined, player);
      player playsoundtoteam("jup_mode_wm_pds_enemy_pickup", getotherteam(player.team)[0], undefined, player);
      var_f2d1c732ad41ab26 = 30000;

      if(!isDefined(player.var_998a7d0073e1ef74) || gettime() - player.var_998a7d0073e1ef74 >= var_f2d1c732ad41ab26) {
        player.var_998a7d0073e1ef74 = gettime();
        player scripts\mp\utility\points::doscoreevent(#"hash_b2a15ba5409c3d64");
      }

      thread function_6a0f0924e7106d6d(player);
    }

    if(isDefined(level.showenemycarrier)) {
      if(level.showenemycarrier == 0) {
        scripts\mp\gameobjects::setvisibleteam("none");
      } else {
        scripts\mp\gameobjects::setvisibleteam("any");
      }
    }

    scripts\mp\gameobjects::setownerteam(game["attackers"]);
    scripts\mp\gameobjects::allowuse("none");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_escort_flag", "waypoint_kill_flag");
    self.previouscarrier = player;
    self.iscarrying = 1;
    player thread function_360f092fbc4fbf80(level.zone);
  }
}

function function_6a0f0924e7106d6d(player) {
  level endon("game_ended");
  self endon("dropped");
  self endon("gameobject_deleted");
  player endon("death_or_disconnect");
  player endon("flag_drop");
  nearbyrange = getdvarint(@ "hash_d2747c44489080dc", 300);

  while(true) {
    wait 5;
    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
    var_95f2a51e7b487eb2 = sortbydistancecullbyradius(attackers, player.origin, nearbyrange);

    foreach(player in var_95f2a51e7b487eb2) {
      player scripts\mp\utility\points::doscoreevent(#"hash_f95e4d51587aea39");
    }
  }
}

function onpickupfailed(player) {}

function returnflag() {
  homeorigin = undefined;

  if(istrue(level.enableflagcheckpoint)) {
    checkpoints = level.zone.var_dcecc1ffe9d55d6e;
    flagzone = level.zone.flagzone;
    mindistance = 99999999;

    foreach(checkpoint in checkpoints) {
      var_5b8739b926bc8fe2 = distance2d(self.trigger.origin, flagzone.trigger.origin);
      var_7dfc0d96730df112 = distance2d(checkpoint.origin, flagzone.trigger.origin);

      if(var_7dfc0d96730df112 < var_5b8739b926bc8fe2) {
        continue;
      }

      if(var_5b8739b926bc8fe2 < mindistance) {
        mindistance = var_5b8739b926bc8fe2;
        nearestcheckpoint = checkpoint;
      }
    }

    if(isDefined(nearestcheckpoint)) {
      homeorigin = nearestcheckpoint.origin;
    }
  }

  scripts\mp\gameobjects::returnhome(homeorigin);
}

function ondrop(player) {
  scripts\mp\gameobjects::setownerteam(game["defenders"]);
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setvisibleteam("any");
  self notify("dropped");
  scripts\mp\gameobjects::setobjectivestatusallicons("waypoint_defend_flag", "waypoint_take_flag");

  if(getgametype() == "wm") {
    player playsoundtoteam("jup_mode_wm_pds_ally_drop", player.team, undefined, player);
    player playsoundtoteam("jup_mode_wm_pds_enemy_drop", getotherteam(player.team)[0], undefined, player);
  }

  if(isDefined(player)) {
    if(!isreallyalive(player)) {
      player.carryobject.previouscarrier = undefined;
    }

    if(isDefined(player.carryflag)) {
      player.carryingflag = undefined;
      player detachflag();
      player notify("flag_drop");
      level notify("filter_drop");
      player setclientomnvar("ui_filter_player_hud_icon", 0);
      player function_4c5338b95958e2bf();
      player function_96948ca6cd6b143e();
    }

    player.playerstreakspeedscale = 0;
    player scripts\mp\weapons::updatemovespeedscale();

    if(istrue(level.flagswitchtp)) {
      player setcamerathirdperson(0);
    }

    thread scripts\mp\hud_util::teamplayercardsplash("jup_wm_dropped_filter", player);
    self.iscarrying = 0;
    volumes = level.zone.subzones;

    if(isDefined(volumes)) {
      foreach(volume in volumes) {
        if(ispointinvolume(player.origin, volume)) {
          returnflag();
          return;
        }
      }
    }
  }

  if(level.idleresettime > 0) {
    thread returnaftertime();
  }
}

function returnaftertime() {
  level endon("complete_capture_flag");
  self endon("picked_up");
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 1);
  currentwaittime = 0;

  while(currentwaittime < level.idleresettime) {
    waitframe();

    if(!isDefined(self.claimteam) || self.claimteam == "none") {
      currentwaittime += level.framedurationseconds;
    }

    progress = 1 - currentwaittime / level.idleresettime;
    progress = clamp(progress, 0, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
  }

  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  returnflag();
}

function onreset() {
  scripts\mp\gameobjects::setownerteam(game["defenders"]);
  scripts\mp\gameobjects::allowcarry("enemy");
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_flag", "waypoint_take_flag");
  self.previouscarrier = undefined;
}

function onuse(player) {
  if(!level.gameended) {
    if(player scripts\cp_mp\utility\player_utility::isinvehicle() || !isDefined(player.carryingflag)) {
      return;
    }

    player notify("objective", "captured");

    if(isDefined(player.carryflag)) {
      player detachflag();
    }

    player.playerstreakspeedscale = 0;
    player scripts\mp\weapons::updatemovespeedscale();

    if(istrue(level.flagswitchtp)) {
      player setcamerathirdperson(0);
    }

    player.carryingflag function_966c7001d35327ef(self);
    player.carryingflag = undefined;
    player notify("place_flag");
    player setclientomnvar("ui_filter_player_hud_icon", 0);

    if(getgametype() == "wm") {
      player playsoundtoteam("jup_mode_wm_pds_ally_placed", player.team, undefined, player);
      player playsoundtoteam("jup_mode_wm_pds_enemy_placed", getotherteam(player.team)[0], undefined, player);
    }
  }
}

function function_966c7001d35327ef(flagzone) {
  if(isDefined(level.flagbase)) {
    var_2142cf85673ffc94 = level.flagbase gettagorigin("tag_turret03");
    var_fed994968ca2f916 = level.flagbase gettagangles("tag_turret03");
    completedflag = spawnscriptable("jup_skydiving_military_pdsf", var_2142cf85673ffc94, var_fed994968ca2f916);

    if(isDefined(level.var_544a602bcb83bd67)) {
      level.var_544a602bcb83bd67[level.var_544a602bcb83bd67.size] = completedflag;

      foreach(pdsf in level.var_544a602bcb83bd67) {
        pdsf function_3677f2be30fdd581("model", "deploy");
      }
    }
  }

  scripts\mp\gameobjects::disableobject();
  self.completed = 1;
  self notify("manual_drop_cleanup");
  self notify("gameobject_deleted");
  objectivekey = self.trigger.objectivekey;
  level.objectives[objectivekey].complete = 1;
  level.zone.var_a41fe785a977666f++;
  level notify("flag_placed");
  level.defendersrespawndelay = getdvarint(@ "hash_1017300f1352f2fa", 0);
  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_a11b33bfb5de050c");
  scripts\mp\gametypes\wm_objectives::function_8bce9c7e1a380040(objectivekey);

  if(level.zone.var_a41fe785a977666f >= level.requiredflag) {
    foreach(flag in level.zone.captureflags) {
      if(!istrue(flag.completed)) {
        objectivekey = flag.trigger.objectivekey;
        level.objectives[objectivekey].complete = 1;
        flag scripts\mp\gameobjects::disableobject();
        flag notify("manual_drop_cleanup");
        scripts\mp\gametypes\wm_objectives::function_8bce9c7e1a380040(objectivekey);
      }
    }

    foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
      if(isDefined(player.carryflag)) {
        player.carryingflag = undefined;
        player detachflag();
        player notify("flag_drop");
        player setclientomnvar("ui_filter_player_hud_icon", 0);
        player function_4c5338b95958e2bf();
        player.playerstreakspeedscale = 0;
        player scripts\mp\weapons::updatemovespeedscale();
      }
    }

    objectivekey = flagzone.trigger.objectivekey;
    flagzone scripts\mp\gameobjects::allowuse("none");
    flagzone scripts\mp\gameobjects::setvisibleteam("none");
    flagzone scripts\mp\gameobjects::disableobject();
    flagzone.var_31a72e6f2e39b666 disableplayeruseforallplayers();
    level.objectives[objectivekey].complete = 1;
    scripts\mp\gametypes\wm_objectives::function_8bce9c7e1a380040(objectivekey);
    var_b9429780179a3937 = getdvarint(@ "hash_c940b4d3990293e5", -30);
    level.extratime = max(0, float(gettimepassed() / 1000) + float(var_b9429780179a3937));
    level.zone.currentphase = "capture_zone";
    level notify("complete_capture_flag");
    scripts\mp\hud_message::notifyteam("jup_wm_install_filter_attacker", "jup_wm_install_filter_defender", game["attackers"]);

    if(isDefined(level.var_c9c970dce548c506)) {
      [[level.var_c9c970dce548c506]]();
    } else {
      level.flagbase function_3677f2be30fdd581("model", "green");
    }

    var_f414affbb2644d5a = level.zone.flag_capture_zone;
    var_f414affbb2644d5a scripts\mp\gameobjects::enableobject();
    var_f414affbb2644d5a scripts\mp\gameobjects::setownerteam(game["defenders"]);
    var_f414affbb2644d5a scripts\mp\gameobjects::allowuse("enemy");
    objective_state(var_f414affbb2644d5a.objidnum, "current");
    var_f414affbb2644d5a scripts\mp\gameobjects::function_3e4a31be47aee8f3(1);
    var_f414affbb2644d5a scripts\mp\gameobjects::function_c882c384f0e771a1(1);
    scripts\mp\gametypes\wm_objectives::function_a2ef0341d328f8e1(var_f414affbb2644d5a.objectivekey);
    scripts\mp\gametypes\wm_utility::function_6b73db5099aa7a56();
    level thread function_bd98c9e85905e50d(var_f414affbb2644d5a);
    level notify("captureflag_device_deployed");

    if(isDefined(level.flagbase)) {
      level.flagbase.nextstate = "charging_1";
      waitframe();
      level.flagbase function_3677f2be30fdd581("model", "charging_1");
      level.flagbase function_3677f2be30fdd581("beam", "on");
      level.flagbase.nextstate = "charged_1";
    }
  }
}

function attachflag() {
  self attach(level.carryflag, "tag_shield_back", 1);
  self.carryflag = level.carryflag;
}

function detachflag() {
  self detach(self.carryflag, "tag_shield_back");
  self.carryflag = undefined;
}

function flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

function oncantuse(player) {}

function function_ce0967f06e5921a4() {
  return level.requiredflag - level.zone.var_a41fe785a977666f;
}

function function_360f092fbc4fbf80(zone) {
  level endon("game_ended");
  self endon("place_flag");
  self endon("flag_drop");
  self endon("death_or_disconnect");
  volumes = zone.subzones;

  if(isDefined(level.var_354c397f5458af46)) {
    volumes = level.var_354c397f5458af46;
  }

  if(getdvarint(@ "hash_2dd79d3cf0785c5b", 0)) {
    return;
  }

  level thread scripts\mp\gametypes\wm::function_460a7a4604f2b0ad(volumes);

  player = self;
  player.var_de9c2f646782e415 = gettime();
  player.var_87727548c0fb1cb1 = 0;
  firststart = 1;

  while(true) {
    foreach(volume in volumes) {
      if(function_bdeeeb8728afc606(player, volume)) {
        if(!istrue(player.var_87727548c0fb1cb1)) {
          player.var_98d1c28a91b8ebca = gettime();

          if(player.var_98d1c28a91b8ebca - player.var_de9c2f646782e415 > 5000 || istrue(firststart)) {
            player.var_9841e3b8e53d1a0b = 5;
          }
        }

        player.var_87727548c0fb1cb1 = 1;
        player scripts\mp\gametypes\wm::function_fc402cde7f63185();
        player scripts\mp\gametypes\wm_ui::function_557efb699f50447b(player.var_9841e3b8e53d1a0b);
        player thread function_77a8f4e3ad0830db(volume);

        if(istrue(player.var_87727548c0fb1cb1)) {
          player thread function_114808366456147a(player.var_9841e3b8e53d1a0b);
        }
      }
    }

    wait 0.25;
  }
}

function function_bdeeeb8728afc606(player, volume) {
  if(istrue(player.var_87727548c0fb1cb1)) {
    return false;
  }

  if(!player istouching(volume)) {
    return false;
  }

  if(!player scripts\mp\gametypes\wm::function_65487b37f7e5d4a7(volume)) {
    return false;
  }

  if(!isreallyalive(player)) {
    return false;
  }

  return true;
}

function function_77a8f4e3ad0830db(volume) {
  player = self;
  player endon("death_or_disconnect");
  player endon("place_flag");
  player endon("flag_drop");

  while(player istouching(volume)) {
    waitframe();
  }

  if(istrue(player.var_87727548c0fb1cb1)) {
    player function_3a105c7558ed71cb();
  }
}

function function_3a105c7558ed71cb() {
  player = self;
  player.var_87727548c0fb1cb1 = 0;
  player.var_de9c2f646782e415 = gettime();

  if(isDefined(player.var_9841e3b8e53d1a0b) && isDefined(player.var_98d1c28a91b8ebca)) {
    player.var_9841e3b8e53d1a0b = int(player.var_9841e3b8e53d1a0b - (player.var_de9c2f646782e415 - player.var_98d1c28a91b8ebca) / 1000);
  }

  player notify("left_FlagOOB");
  player setclientomnvar("ui_out_of_bounds_type", 0);
  player setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function function_114808366456147a(time) {
  player = self;
  player endon("left_FlagOOB");
  player endon("death_or_disconnect");

  if(time > 0) {
    wait time;
  }

  player.oobdeath = 1;
  player scripts\mp\utility\damage::_suicide(undefined, 1);
  player.oobdeath = undefined;
  player.var_87727548c0fb1cb1 = 0;
}

function function_47f0240ed7f9e0c8() {
  foreach(captureflag in level.zone.captureflags) {
    captureflag.trigger disableplayeruse(self);
  }
}

function function_4c5338b95958e2bf() {
  foreach(captureflag in level.zone.captureflags) {
    captureflag.trigger enableplayeruse(self);
  }
}

function function_96948ca6cd6b143e() {
  level.zone.flagzone.trigger disableplayeruse(self);
  level.zone.flagzone.var_31a72e6f2e39b666 enableplayeruse(self);
}

function function_2dc4851c2a22292d() {
  level.zone.flagzone.trigger enableplayeruse(self);
  level.zone.flagzone.var_31a72e6f2e39b666 disableplayeruse(self);
}

function function_e8c48ecc4a22fcd1() {
  level.zone.flagzone.var_31a72e6f2e39b666 disableplayeruseforallplayers();

  foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
    player function_96948ca6cd6b143e();
  }
}