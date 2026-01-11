/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_visibility_system.gsc
***********************************************/

stealth_visibility_system_main() {
  system_init();
  thread system_message_loop();
  common_scripts\utility::array_thread(getEntArray("stealth_clipbrush", "targetname"), ::system_handle_clipbrush);
}

system_message_loop() {
  var_0 = "_stealth_spotted";

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_enabled");
    common_scripts\utility::flag_wait(var_0);

    if(!common_scripts\utility::flag("_stealth_enabled")) {
      continue;
    }
    system_event_change("spotted");
    thread system_state_spotted();
    common_scripts\utility::flag_waitopen(var_0);

    if(!common_scripts\utility::flag("_stealth_enabled")) {
      continue;
    }
    system_event_change("hidden");
    waittillframeend;
  }
}

system_event_change(var_0) {
  level._stealth.logic.detection_level = var_0;

  foreach(var_4, var_2 in level._stealth.logic.ai_event) {
    setsaveddvar(var_4, var_2[var_0]);
    var_3 = "ai_busyEvent" + getsubstr(var_4, 8);
    setsaveddvar(var_3, var_2[var_0]);
  }
}

system_state_spotted() {
  while(common_scripts\utility::flag("_stealth_spotted")) {
    common_scripts\utility::flag_wait("_stealth_enabled");
    var_0 = level._stealth.group.groups;

    foreach(var_4, var_2 in var_0) {
      var_3 = maps\_stealth_shared_utilities::group_get_flagname_from_group("_stealth_spotted", var_4);

      if(!common_scripts\utility::flag(var_3)) {
        continue;
      }
      var_2 = common_scripts\utility::array_removeundefined(var_2);

      if(var_2.size > 0) {
        if(var_2[0].team == "allies") {
          continue;
        }
      }

      thread system_state_try_clear_flag(var_4);
    }

    common_scripts\utility::flag_waitopen_or_timeout("_stealth_spotted", level._stealth.logic.detection_timeout * 1.25);
  }

  var_0 = level._stealth.group.groups;

  foreach(var_4, var_2 in var_0) {
  maps\_stealth_shared_utilities::group_flag_clear("_stealth_spotted", var_4);
  }
}

system_state_try_clear_flag(var_0) {
  var_1 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_0);
  common_scripts\utility::array_thread(var_1, ::notify_level_on_enemy, var_0);
  level endon("enemy_" + var_0);

  if(var_1.size > 0) {
    var_2 = system_state_check_no_enemy(var_0);

    if(!var_2) {
      return;
    }
    wait(level._stealth.logic.detection_timeout);
    var_2 = system_state_check_no_enemy(var_0);

    if(!var_2) {
      return;
    }
  }

  level notify("enemy_" + var_0 + "_stop");
  maps\_stealth_shared_utilities::group_flag_clear("_stealth_spotted", var_0);
}

system_state_check_no_enemy(var_0) {
  var_1 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_0);

  foreach(var_4, var_3 in var_1) {
    if(!isalive(var_3.enemy)) {
      continue;
    }
    return 0;
  }

  return 1;
}

system_save_processes() {
  common_scripts\utility::flag_init("_stealth_player_nade");
  level._stealth.logic.player_nades = 0;
  common_scripts\utility::array_thread(level.players, ::player_grenade_check);
}

player_grenade_check() {
  for(;;) {
    self waittill("grenade_pullback");
    common_scripts\utility::flag_set("_stealth_player_nade");
    self waittill("grenade_fire", var_0);
    thread player_grenade_check_dieout(var_0);
  }
}

player_grenade_check_dieout(var_0) {
  level._stealth.logic.player_nades++;
  var_0 common_scripts\utility::waittill_notify_or_timeout("death", 10);
  level._stealth.logic.player_nades--;
  waittillframeend;

  if(!level._stealth.logic.player_nades) {
    common_scripts\utility::flag_clear("_stealth_player_nade");
  }
}

system_init_shadows() {
  common_scripts\utility::array_thread(getEntArray("_stealth_shadow", "targetname"), ::stealth_shadow_volumes);
  common_scripts\utility::array_thread(getEntArray("stealth_shadow", "targetname"), ::stealth_shadow_volumes);
}

stealth_shadow_volumes() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isalive(var_0)) {
      continue;
    }
    if(var_0 maps\_utility::ent_flag("_stealth_in_shadow")) {
      continue;
    }
    var_0 thread stealth_shadow_ai_in_volume(self);
  }
}

stealth_shadow_ai_in_volume(var_0) {
  self endon("death");
  maps\_utility::ent_flag_set("_stealth_in_shadow");

  while(self istouching(var_0)) {
    wait 0.05;
  }

  maps\_utility::ent_flag_clear("_stealth_in_shadow");
}

system_handle_clipbrush() {
  self endon("death");

  if(isDefined(self.script_flag_wait)) {
    common_scripts\utility::flag_wait(self.script_flag_wait);
  }

  waittillframeend;
  var_0 = "_stealth_spotted";
  var_1 = "_stealth_found_corpse";
  var_2 = "_stealth_event";

  if(isDefined(self.script_stealthgroup)) {
    maps\_stealth_shared_utilities::group_wait_group_spawned(maps\_utility::string(self.script_stealthgroup));
    var_0 = maps\_stealth_shared_utilities::group_get_flagname_from_group(var_0, self.script_stealthgroup);
    var_1 = maps\_stealth_shared_utilities::group_get_flagname_from_group(var_1, self.script_stealthgroup);
    var_2 = maps\_stealth_shared_utilities::group_get_flagname_from_group(var_2, self.script_stealthgroup);
  }

  self setCanDamage(1);
  maps\_utility::add_wait(maps\_utility::waittill_msg, "damage");
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, var_0);
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, var_1);
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, var_2);
  maps\_utility::do_wait_any();

  if(self.spawnflags & 1) {
    self connectpaths();
  }

  self delete();
}

system_init() {
  common_scripts\utility::flag_init("_stealth_spotted");
  common_scripts\utility::flag_init("_stealth_event");
  common_scripts\utility::flag_init("_stealth_enabled");
  common_scripts\utility::flag_set("_stealth_enabled");
  level._stealth = spawnStruct();
  level._stealth.logic = spawnStruct();
  level._stealth.group = spawnStruct();
  level._stealth.group.flags = [];
  level._stealth.group.groups = [];
  level._stealth.group.ally_groups = [];
  level._stealth.logic.detection_level = "hidden";
  level._stealth.logic.detect_range = [];
  level._stealth.logic.detect_range["hidden"] = [];
  level._stealth.logic.detect_range["spotted"] = [];
  level._stealth.logic.detection_timeout = 1;
  system_default_detect_ranges();
  level._stealth.logic.ai_event = [];
  level._stealth.logic.ai_event["ai_eventDistDeath"] = [];
  level._stealth.logic.ai_event["ai_eventDistPain"] = [];
  level._stealth.logic.ai_event["ai_eventDistExplosion"] = [];
  level._stealth.logic.ai_event["ai_eventDistBullet"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstep"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstepWalk"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstepSprint"] = [];
  level._stealth.logic.ai_event["ai_eventDistGunShot"] = [];
  level._stealth.logic.ai_event["ai_eventDistGunShotTeam"] = [];
  level._stealth.logic.ai_event["ai_eventDistNewEnemy"] = [];
  system_default_event_distances();
  system_event_change("hidden");
  system_save_processes();
  system_init_shadows();
  maps\_stealth_utility::stealth_alert_level_duration(0.5);
}

system_default_detect_ranges() {
  var_0 = [];
  var_0["prone"] = 70;
  var_0["crouch"] = 600;
  var_0["stand"] = 1024;
  var_1 = [];
  var_1["prone"] = 512;
  var_1["crouch"] = 5000;
  var_1["stand"] = 8000;
  system_set_detect_ranges(var_0, var_1);
}

system_set_detect_ranges(var_0, var_1) {
  if(isDefined(var_0)) {
    level._stealth.logic.detect_range["hidden"]["prone"] = var_0["prone"];
    level._stealth.logic.detect_range["hidden"]["crouch"] = var_0["crouch"];
    level._stealth.logic.detect_range["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    level._stealth.logic.detect_range["spotted"]["prone"] = var_1["prone"];
    level._stealth.logic.detect_range["spotted"]["crouch"] = var_1["crouch"];
    level._stealth.logic.detect_range["spotted"]["stand"] = var_1["stand"];
  }
}

system_default_event_distances() {
  var_0["ai_eventDistDeath"] = [];
  var_0["ai_eventDistPain"] = [];
  var_0["ai_eventDistExplosion"] = [];
  var_0["ai_eventDistBullet"] = [];
  var_0["ai_eventDistFootstep"] = [];
  var_0["ai_eventDistFootstepWalk"] = [];
  var_0["ai_eventDistFootstepSprint"] = [];
  var_0["ai_eventDistGunShot"] = [];
  var_0["ai_eventDistGunShotTeam"] = [];
  var_0["ai_eventDistNewEnemy"] = [];
  var_0["ai_eventDistDeath"]["spotted"] = getdvar("ai_eventDistDeath");
  var_0["ai_eventDistDeath"]["hidden"] = 512;
  var_0["ai_eventDistPain"]["spotted"] = getdvar("ai_eventDistPain");
  var_0["ai_eventDistPain"]["hidden"] = 256;
  var_0["ai_eventDistExplosion"]["spotted"] = 4000;
  var_0["ai_eventDistExplosion"]["hidden"] = 4000;
  var_0["ai_eventDistBullet"]["spotted"] = 96;
  var_0["ai_eventDistBullet"]["hidden"] = 64;
  var_0["ai_eventDistFootstep"]["spotted"] = 350;
  var_0["ai_eventDistFootstep"]["hidden"] = 64;
  var_0["ai_eventDistFootstepWalk"]["spotted"] = 256;
  var_0["ai_eventDistFootstepWalk"]["hidden"] = 32;
  var_0["ai_eventDistFootstepSprint"]["spotted"] = 400;
  var_0["ai_eventDistFootstepSprint"]["hidden"] = 400;
  var_0["ai_eventDistGunShot"]["spotted"] = 2048;
  var_0["ai_eventDistGunShot"]["hidden"] = 2048;
  var_0["ai_eventDistGunShotTeam"]["spotted"] = 750;
  var_0["ai_eventDistGunShotTeam"]["hidden"] = 750;
  var_0["ai_eventDistNewEnemy"]["spotted"] = 750;
  var_0["ai_eventDistNewEnemy"]["hidden"] = 750;
  system_set_event_distances(var_0);
}

system_set_event_distances(var_0) {
  foreach(var_6, var_2 in var_0) {
    foreach(var_5, var_4 in var_2) {
    level._stealth.logic.ai_event[var_6][var_5] = var_4;
    }
  }
}

notify_level_on_enemy(var_0) {
  self notify("notify_level_on_enemy");
  self endon("notify_level_on_enemy");
  var_1 = "enemy_" + var_0;
  self endon("death");
  level endon(var_1);
  level endon(var_1 + "_stop");
  self waittill("enemy");
  level notify(var_1);
}