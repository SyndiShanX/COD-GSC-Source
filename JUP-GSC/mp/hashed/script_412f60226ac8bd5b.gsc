/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_412f60226ac8bd5b.gsc
*************************************************/

#using script_7406801b4c228018;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#namespace namespace_2776c9448d38a270;

function setupobjective(trigger, index, skipobjid, var_5ddbc1faed2c56e6, usingvisualhintstring) {
  hackzone = undefined;
  label = undefined;

  if(isDefined(trigger.originalpos)) {
    trigger.origin = trigger.originalpos;
  } else {
    trigger.originalpos = trigger.origin;
  }

  visual = getEnt(trigger.target, "targetname");
  var_4511b372ffc686e = getentitylessscriptablearray(visual.target, "targetname");
  screenred = getEnt(var_4511b372ffc686e[0].target, "targetname");

  if(isDefined(screenred.target)) {
    animsendnode = getEnt(screenred.target, "targetname");
    visual.animsendnode = animsendnode;
  }

  visuals = [visual];

  if(isDefined(trigger.script_noteworthy)) {
    offsetnode = getStruct(trigger.script_noteworthy, "script_noteworthy");
  }

  if(isDefined(trigger.objectivekey)) {
    objectivekey = trigger.objectivekey;
  } else {
    objectivekey = trigger.script_label;
  }

  if(istrue(var_5ddbc1faed2c56e6)) {
    reservedobjid = getreservedobjid(objectivekey);
  } else {
    reservedobjid = undefined;
  }

  hackzone = scripts\mp\gameobjects::createuseobject(game["defenders"], trigger, visuals, (0, 0, 32), reservedobjid, skipobjid);
  hackzone scripts\mp\gameobjects::requestid(1, 1);
  hackzone.consoleindex = index + 1;
  assertex(hackzone.consoleindex >= 1 && hackzone.consoleindex <= 2, "<dev string:x1c>");
  hackzone.objectivekey = objectivekey;
  hackzone.iconname = objectivekey;
  hackzone.screen = var_4511b372ffc686e[0];
  hackzone.redscreen = screenred;
  hackzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_hack");
  hackzone.trigger setusepriority(-1 - 1 - 1 - 1);
  hackzone scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("hackUseTime", 3));
  scripts\mp\objidpoolmanager::objective_set_show_progress(hackzone.objidnum, 0);
  hackzone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_HACK");
  hackzone.trigger setuseholdduration("duration_none");
  hackzone.trigger setuseprioritymax();
  hackzone.trigger setuserange(256);
  hackzone.trigger setusefov(80);
  hackzone.onbeginuse = &function_c4537fbaab36b51e;
  hackzone.onenduse = &function_647ca2a49f347576;
  hackzone.onuse = &function_3a285102f73c5a7f;
  hackzone.hacked = 0;
  hackzone.usingvisualhintstring = usingvisualhintstring;
  hackzone.mapname = "_" + getmapname();

  if(isDefined(offsetnode)) {
    scripts\mp\objidpoolmanager::update_objective_position(hackzone.objidnum, offsetnode.origin);
  }

  return hackzone;
}

function getreservedobjid(objectivekey) {
  if(objectivekey == "_a") {
    reservedid = 0;
  } else {
    reservedid = 1;
  }

  return reservedid;
}

function function_c4537fbaab36b51e(player) {
  if(self.hacked) {
    self.var_9832d5270deb1889 = 1;
    scripts\mp\gametypes\wm_utility::function_e3cd4f9e858ab6ee(player, "recovering_" + self.consoleindex + self.mapname);
  } else {
    self.ishacking = 1;
    scripts\mp\gametypes\wm_utility::function_e3cd4f9e858ab6ee(player, "hacking_" + self.consoleindex + self.mapname);
  }

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, player.team);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 1);
  self.visuals[0] function_bd8563c34b78c85b(player);
  self.screen setscriptablepartstate("consoleScreen", "hacking_" + self.consoleindex);
  setomnvar("ui_wm_launch_console_screen_" + self.consoleindex, 2);
  thread function_8a671a44c8f902ac();
  player scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_init_ally", player.team);
  player scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_init_enemy", getotherteam(player.team)[0]);
  player lerpfovscalefactor(0, 0);
  scripts\mp\gametypes\wm_utility::function_204ff26efb937261(1, self.curorigin, player.team, 64, 80, self.usingvisualhintstring);
}

function function_8a671a44c8f902ac() {
  self endon("hack_recovered");
  self notify("end_use");
  self endon("end_use");

  if(!isDefined(self.usetime) || self.usetime <= 0) {
    return;
  }

  omnvar = "ui_wm_launch_console_upload_" + self.consoleindex;

  while(true) {
    progress = self.curprogress / self.usetime;
    setomnvar(omnvar, progress);

    if(progress >= 1) {
      break;
    }

    waitframe();
  }
}

function function_647ca2a49f347576(team, player, result) {
  if(result == 0) {
    scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
    self.visuals[0] thread function_55c29a7f07974c53(player);
    scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 0);
  }

  if(istrue(self.ishacking)) {
    self.ishacking = undefined;
    self.screen setscriptablepartstate("consoleScreen", "init");
    setomnvar("ui_wm_launch_console_screen_" + self.consoleindex, 0);
  } else if(istrue(self.var_9832d5270deb1889)) {
    self.var_9832d5270deb1889 = undefined;
    self.screen setscriptablepartstate("consoleScreen", "hacking_" + self.consoleindex);
    setomnvar("ui_wm_launch_console_screen_" + self.consoleindex, 1);
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  }

  player lerpfovscalefactor(1, 0);
  scripts\mp\gametypes\wm_utility::function_204ff26efb937261(0);
  self notify("end_use");
}

function function_3a285102f73c5a7f(player) {
  self.visuals[0] thread function_55c29a7f07974c53(player);
  self.curprogress = 0;
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 0);
  scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);

  if(!self.hacked) {
    if(isDefined(self.var_9e987a57f0db587a)) {
      level thread[[self.var_9e987a57f0db587a]](self, player);
    } else {
      level thread function_3437d0c8eca62f1c(self, player);
    }
  } else if(isDefined(self.var_c2b12d87bb80faff)) {
    level thread[[self.var_c2b12d87bb80faff]](self, player);
  } else {
    level thread function_cc4020b25a7774e9(self, player);
  }

  self notify("end_use");
}

function function_3437d0c8eca62f1c(zone, player) {
  zone.hacked = 1;
  zone.screen setscriptablepartstate("consoleScreen", "hacking_" + zone.consoleindex);
  setomnvar("ui_wm_launch_console_screen_" + zone.consoleindex, 1);
  zone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_RECOVER");
  zone scripts\mp\gameobjects::setownerteam(game["attackers"]);
  zone scripts\mp\gameobjects::allowuse("enemy");
  zone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse", "waypoint_hacking");

  if(isDefined(level.zone.objective) && isDefined(level.zone.objective.params["hackRestoreTime"])) {
    zone scripts\mp\gameobjects::setusetime(level.zone.objective.params["hackRestoreTime"]);
  } else {
    zone scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("hackRestoreTime", 3));
  }

  mapname = getmapname();

  if(mapname == "mp_jup_launchfacility") {
    foreach(target_player in level.players) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(zone.objidnum, target_player);
    }
  }

  player scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_start_ally", game["attackers"]);
  player scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_start_enemy", game["defenders"]);

  switch (getmapname()) {
    case #"hash_5f400f0334a4a47b":
      player scripts\mp\utility\points::doscoreevent(#"hash_690087e1d0c26f49");
      break;
    case #"hash_a57f5ebbc35a8c1f":
      player scripts\mp\utility\points::doscoreevent(#"hash_829f771d70a75937");
      break;
    default:
      break;
  }

  level notify("hack_zone_upload_start");
  player notify("hackZone_captured");
  zone thread function_2b5fe0c2fc4de973();
}

function function_cc4020b25a7774e9(zone, player) {
  zone.hacked = 0;
  zone.screen setscriptablepartstate("consoleScreen", "init");
  setomnvar("ui_wm_launch_console_screen_" + zone.consoleindex, 0);
  zone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_HACK");
  zone scripts\mp\gameobjects::setownerteam(game["defenders"]);
  zone scripts\mp\gameobjects::allowuse("enemy");
  zone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_hack");

  if(isDefined(level.zone) && isDefined(level.zone.objective.params["hackUseTime"])) {
    zone scripts\mp\gameobjects::setusetime(level.zone.objective.params["hackUseTime"]);
  } else {
    zone scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("hackUseTime", 3));
  }

  scripts\mp\objidpoolmanager::objective_set_show_progress(zone.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_progress(zone.objidnum, 0);
  mapname = getmapname();

  if(mapname == "mp_jup_launchfacility") {
    foreach(target_player in level.players) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(zone.objidnum, target_player);
    }
  }

  player scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_recovered_ally", player.team);
  player scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_recovered_enemy", getotherteam(player.team)[0]);

  switch (getmapname()) {
    case #"hash_5f400f0334a4a47b":
      player scripts\mp\utility\points::doscoreevent(#"hash_a0e490be654a4fa8");
      break;
    case #"hash_a57f5ebbc35a8c1f":
      player scripts\mp\utility\points::doscoreevent(#"hash_c4a41d69e7440dc3");
      break;
    default:
      break;
  }

  zone notify("hack_recovered");
  level notify("hack_recovered");
}

function function_2b5fe0c2fc4de973() {
  self endon("hack_recovered");
  progress = 1;
  totalsec = namespace_9e98bfcb3b4a9888::getobjectiveparam("hackUploadTime", 30);
  totaltime = 1000 * totalsec;
  hackendtime = gettime() + totaltime;
  level.objectives[self.objectivekey].complete = 0;
  thread function_b56ba89586796a75(2);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_show_progress(self.objidnum, 1);
  omnvar = "ui_wm_launch_console_countdown_" + self.consoleindex;

  while(progress > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = hackendtime - currenttime;
    progress = max(0, var_c301d652d9a73075 / totaltime);
    self.var_256648199aa47753 = 1 - progress;
    setomnvar(omnvar, int(max(0, var_c301d652d9a73075)));
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 1 - progress);
    waitframe();
  }

  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("none");
  setomnvar(omnvar, 0);
  self.redscreen dontinterpolate();
  self.redscreen moveTo(self.screen.origin, 0.1);
  wait 0.1;
  self.screen setscriptablepartstate("consoleScreen", "hacked");
  scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_complete_ally", game["attackers"]);
  scripts\mp\utility\sound::playsoundonplayers("jup_wm_hack_complete_enemy", game["defenders"]);

  switch (getmapname()) {
    case #"hash_5f400f0334a4a47b":
      scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_3818dd528f142987");
      break;
    case #"hash_a57f5ebbc35a8c1f":
      scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_7bcf4357b9ee8d9a");
      break;
    default:
      break;
  }

  level.objectives[self.objectivekey].complete = 1;
  level notify("obj_hack_zone_uploaded");

  if(isDefined(level.zone.hackzones)) {
    completed = 0;

    foreach(zone in level.zone.hackzones) {
      if(istrue(zone.complete)) {
        completed++;
      }
    }

    if(completed < level.zone.hackzones.size) {
      scripts\mp\hud_message::notifyteam(level.zone.objective.params["hack_zone_upload_complete_splash_friendly"], level.zone.objective.params["hack_zone_upload_complete_splash_enemy"], game["attackers"]);
      level notify("hack_zone_upload_complete");
    } else {
      scripts\mp\hud_message::notifyteam(level.zone.objective.params["hack_zone_upload_full_complete_splash_friendly"], level.zone.objective.params["hack_zone_upload_full_complete_splash_enemy"], game["attackers"]);
      level notify("hack_zone_upload_full_complete");
    }
  }

  if(isDefined(self.var_bde11092e7372a01)) {
    self[[self.var_bde11092e7372a01]]();
  }
}

#using_animtree("script_model");

function function_e27a6d1eec1c355e() {
  level.scr_animtree["uav_tower"] = #animtree;
  level.scr_anim["uav_tower"]["use_uav_tower_enter"] = % jup_uav_tower_enter;
  level.scr_animname["uav_tower"]["use_uav_tower_enter"] = "jup_uav_tower_enter";
  level.scr_eventanim["uav_tower"]["use_uav_tower_enter"] = "use_jup_uav_tower_enter";
  level.scr_anim["uav_tower"]["use_uav_tower_idle"] = % jup_uav_tower_idle;
  level.scr_animname["uav_tower"]["use_uav_tower_idle"] = "jup_uav_tower_idle";
  level.scr_eventanim["uav_tower"]["use_uav_tower_idle"] = "use_jup_uav_tower_idle";
  level.scr_anim["uav_tower"]["use_uav_tower_exit"] = % jup_uav_tower_exit;
  level.scr_animname["uav_tower"]["use_uav_tower_exit"] = "jup_uav_tower_exit";
  level.scr_eventanim["uav_tower"]["use_uav_tower_exit"] = "use_jup_uav_tower_exit";
}

function function_bd8563c34b78c85b(player) {
  player thread watchplayerdeathordisconnect();
  player thread function_76367f9c7910b465();
  thread typinganimstart(player);
}

function function_76367f9c7910b465() {
  level endon("game_ended");
  self endon("interact_finished");

  while(!istrue(self isinexecutionvictim())) {
    waitframe();
  }

  function_53e042e990afc9c4();
}

function watchplayerdeathordisconnect() {
  level endon("game_ended");
  self endon("interact_finished");
  scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  function_53e042e990afc9c4();
}

function function_53e042e990afc9c4() {
  self notify("interact_interrupt");
  self stopanimscriptsceneevent();

  if(isDefined(self.linktoent)) {
    self unlink();
    self.linktoent delete();
    self.linktoent = undefined;
  }

  self notify("remove_rig");
  function_3c288bbdd4016fd4(1);
}

function function_3c288bbdd4016fd4(isallowed) {
  if(!isallowed) {
    val::set("typing", "allow_jump", 0);
    val::set("typing", "gesture", 0);
    val::set("typing", "melee", 0);
    val::set("typing", "mantle", 0);
    val::set("typing", "offhand_weapons", 0);
    val::set("typing", "allow_movement", 0);
    val::set("typing", "sprint", 0);
    val::set("typing", "fire", 0);
    val::set("typing", "reload", 0);
    val::set("typing", "weapon_pickup", 0);
    val::set("typing", "weapon_switch", 0);
    val::set("typing", "offhand_weapons", 0);
    val::set("typing", "execution_victim", 0);
    val::set("typing", "supers", 0);
    self function_35501b42058d4de9();
    return;
  }

  val::reset_all("typing");
  self function_bb04491d50d9e43e();
}

function function_55c29a7f07974c53(player) {
  level endon("game_ended");
  player endon("interact_interrupt");
  player endon("death_or_disconnect");
  player notify("interact_begin_exit");

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player stopanimscriptsceneevent();
  player notify("remove_rig");
  player.linktoent = player spawn_tag_origin(player.origin, player getplayerangles(0));
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 1);
  goalpos = self.origin - rotatevector((75.632, 0, 0), self.angles * -1);

  if(isDefined(self.animsendnode)) {
    goalpos = self.animsendnode.origin;
  }

  movetotime = 0.3;
  player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
  var_a6a8051850a85f4a = gettime();
  player scripts\mp\gametypes\wm_utility::function_7e72b60d5d515d3a();
  var_c14e6d148e0efcb9 = gettime();
  var_86a0cb70d5d42f9c = max(0, movetotime - (var_c14e6d148e0efcb9 - var_a6a8051850a85f4a) / 1000);
  wait var_86a0cb70d5d42f9c;
  player setstance("stand");
  player function_3c288bbdd4016fd4(1);
  player unlink();
  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(goalpos);
  player notify("interact_finished");
}

function typinganimstart(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("interact_interrupt");
  player endon("interact_begin_exit");
  player notify("typingAnimStart");
  player endon("typingAnimStart");

  if(isDefined(player.linktoent)) {
    player.linktoent delete();
  }

  player function_3c288bbdd4016fd4(0);

  if(!isDefined(self.animstruct)) {
    animstruct = spawnStruct();
    animstruct.origin = self.origin;
    animstruct.angles = self.angles;
    self.animstruct = animstruct;
  }

  player.linktoent = player spawn_tag_origin(player.origin, player getplayerangles(0));
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 1, 1);
  anglesrotated = self.angles;
  goalpos = self.origin + rotatevector((55.632, -1.279, 0), anglesrotated);
  forward = (0, 0, 0) - anglesToForward(anglesrotated);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  goalangles = axistoangles(forward, right, up);
  movetotime = 0.3;
  player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
  player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
  player setstance("crouch");
  var_cd9982adb17761a8 = gettime();
  player scripts\mp\gametypes\wm_utility::function_d533cf8b8c42e0e8();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = max(0, movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000);
  wait var_218f64cb035d54be;
  player unlink();
  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(goalpos);
  player setplayerangles(goalangles);
  player thread function_d10cfdc3ba07b4ea("uav_tower", goalpos, goalangles);

  while(!isDefined(player.player_rig)) {
    waitframe();
  }

  self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "use_uav_tower_enter");

  while(isreallyalive(player)) {
    self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "use_uav_tower_idle");
  }
}

function function_d10cfdc3ba07b4ea(animname, spawnpos, spawnang) {
  level endon("game_ended");
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  self function_b88c89bb7cd1ab8e(spawnpos);
  player_rig = spawn("script_arms", self.origin, 0, 0, self);
  self.player_rig = player_rig;
  player_rig.origin = spawnpos;
  player_rig.angles = spawnang;
  player_rig.player = self;
  player_rig hide(1);
  player_rig.animname = animname;
  player_rig useanimtree(#animtree);
  player_rig.updatedversion = 1;
  self playerlinktoabsolute(player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  player_rig showonlytoplayer(self);
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(isDefined(player_rig) && player_rig islinked()) {
    player_rig unlink();
  }

  if(isDefined(player_rig)) {
    player_rig delete();
  }
}

function function_b56ba89586796a75(timer) {
  self endon("hack_recovered");
  sfx_zone = spawn("script_origin", self.trigger.origin + (0, 0, 10));

  while(true) {
    if(level.objectives[self.objectivekey].complete == 0) {
      if(istrue(self.zonesecured) && scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_skydiving") {
        break;
      }

      sfx_zone playsoundtoteam("jup_wm_hack_beep_ally", game["attackers"]);
      sfx_zone playsoundtoteam("jup_wm_hack_beep_enemy", game["defenders"]);
      wait timer;
      continue;
    }

    break;
  }

  sfx_zone delete();
}