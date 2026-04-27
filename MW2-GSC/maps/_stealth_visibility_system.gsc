/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stealth_visibility_system.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_stealth_utility;
#include maps\_stealth_shared_utilities;

stealth_visibility_system_main() {
  system_init();

  thread system_message_loop();
  array_thread(getEntArray("stealth_clipbrush", "targetname"), ::system_handle_clipbrush);
}

system_message_loop() {
  flag = "_stealth_spotted";

  while(1) {
    flag_wait("_stealth_enabled");

    flag_wait(flag);

    if(!flag("_stealth_enabled")) {
      continue;
    }
    system_event_change("spotted");

    thread system_state_spotted();

    flag_waitopen(flag);

    if(!flag("_stealth_enabled")) {
      continue;
    }
    system_event_change("hidden");

    waittillframeend;
  }
}
system_event_change(name) {
  level._stealth.logic.detection_level = name;

  foreach(key, event in level._stealth.logic.ai_event) {
    setsaveddvar(key, event[name]);

    busyEventDvarName = "ai_busyEvent" + getsubstr(key, 8);
    setsaveddvar(busyEventDvarName, event[name]);
  }
}
system_state_spotted() {
  while(flag("_stealth_spotted")) {
    flag_wait("_stealth_enabled");

    array = level._stealth.group.groups;

    foreach(group_name, group in array) {
      _flag = group_get_flagname_from_group("_stealth_spotted", group_name);
      if(!flag(_flag)) {
        continue;
      }
      thread system_state_try_clear_flag(group_name);
    }

    flag_waitopen_or_timeout("_stealth_spotted", 1.25);
  }
}

system_state_try_clear_flag(group_name) {
  clear = system_state_check_no_enemy(group_name);

  if(!clear) {
    return;
  }

  wait 1;

  clear = system_state_check_no_enemy(group_name);

  if(!clear) {
    return;
  }
  group_flag_clear("_stealth_spotted", group_name);
}

system_state_check_no_enemy(group_name) {
  group = group_get_ai_in_group(group_name);

  foreach(key, ai in group) {
    if(!isalive(ai.enemy)) {
      continue;
    }
    return false;
  }

  return true;
}

system_save_processes() {
  flag_init("_stealth_player_nade");
  level._stealth.logic.player_nades = 0;

  array_thread(level.players, ::player_grenade_check);
}

player_grenade_check() {
  while(1) {
    flag_set("_stealth_player_nade");

    self waittill("grenade_fire", grenade);
    thread player_grenade_check_dieout(grenade);
  }
}

player_grenade_check_dieout(grenade) {
  level._stealth.logic.player_nades++;
  grenade waittill_notify_or_timeout("death", 10);
  level._stealth.logic.player_nades--;

  waittillframeend;

  if(!level._stealth.logic.player_nades)
    flag_clear("_stealth_player_nade");
}

system_init_shadows() {
  array_thread(getEntArray("_stealth_shadow", "targetname"), ::stealth_shadow_volumes);
  array_thread(getEntArray("stealth_shadow", "targetname"), ::stealth_shadow_volumes);
}

stealth_shadow_volumes() {
  self endon("death");

  while(1) {
    self waittill("trigger", other);

    if(!isalive(other)) {
      continue;
    }
    if(other ent_flag("_stealth_in_shadow")) {
      continue;
    }
    other thread stealth_shadow_ai_in_volume(self);
  }
}

stealth_shadow_ai_in_volume(volume) {
  self endon("death");

  self ent_flag_set("_stealth_in_shadow");

  while(self istouching(volume))
    wait .05;

  self ent_flag_clear("_stealth_in_shadow");
}

system_handle_clipbrush() {
  self endon("death");

  if(isDefined(self.script_flag_wait))
    flag_wait(self.script_flag_wait);

  waittillframeend;

  spotted_flag = "_stealth_spotted";
  corpse_flag = "_stealth_found_corpse";
  event_flag = "_stealth_event";

  if(isDefined(self.script_stealthgroup)) {
    group_wait_group_spawned(string(self.script_stealthgroup));

    spotted_flag = group_get_flagname_from_group(spotted_flag, self.script_stealthgroup);
    corpse_flag = group_get_flagname_from_group(corpse_flag, self.script_stealthgroup);
    event_flag = group_get_flagname_from_group(event_flag, self.script_stealthgroup);
  }

  self setCanDamage(true);

  self add_wait(::waittill_msg, "damage");
  level add_wait(::flag_wait, spotted_flag);
  level add_wait(::flag_wait, corpse_flag);
  level add_wait(::flag_wait, event_flag);
  do_wait_any();

  if(self.spawnflags & 1)
    self connectpaths();

  self delete();
}

system_init() {
  flag_init("_stealth_spotted");
  flag_init("_stealth_event");
  flag_init("_stealth_enabled");
  flag_set("_stealth_enabled");

  thread stealth_flag_debug_print("_stealth_spotted");

  level._stealth = spawnStruct();
  level._stealth.logic = spawnStruct();
  level._stealth.group = spawnStruct();
  level._stealth.group.flags = [];
  level._stealth.group.groups = [];

  level._stealth.logic.detection_level = "hidden";
  level._stealth.logic.detect_range = [];
  level._stealth.logic.detect_range["hidden"] = [];
  level._stealth.logic.detect_range["spotted"] = [];
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

  stealth_alert_level_duration(0.5);
}

system_default_detect_ranges() {
  hidden = [];
  hidden["prone"] = 70;
  hidden["crouch"] = 600;
  hidden["stand"] = 1024;

  spotted = [];
  spotted["prone"] = 512;
  spotted["crouch"] = 5000;
  spotted["stand"] = 8000;

  system_set_detect_ranges(hidden, spotted);
}

system_set_detect_ranges(hidden, spotted) {
  if(isDefined(hidden)) {
    level._stealth.logic.detect_range["hidden"]["prone"] = hidden["prone"];
    level._stealth.logic.detect_range["hidden"]["crouch"] = hidden["crouch"];
    level._stealth.logic.detect_range["hidden"]["stand"] = hidden["stand"];
  }

  if(isDefined(spotted)) {
    level._stealth.logic.detect_range["spotted"]["prone"] = spotted["prone"];
    level._stealth.logic.detect_range["spotted"]["crouch"] = spotted["crouch"];
    level._stealth.logic.detect_range["spotted"]["stand"] = spotted["stand"];
  }
}

system_default_event_distances() {
  ai_event["ai_eventDistDeath"] = [];
  ai_event["ai_eventDistPain"] = [];
  ai_event["ai_eventDistExplosion"] = [];
  ai_event["ai_eventDistBullet"] = [];
  ai_event["ai_eventDistFootstep"] = [];
  ai_event["ai_eventDistFootstepWalk"] = [];
  ai_event["ai_eventDistFootstepSprint"] = [];
  ai_event["ai_eventDistGunShot"] = [];
  ai_event["ai_eventDistGunShotTeam"] = [];
  ai_event["ai_eventDistNewEnemy"] = [];

  ai_event["ai_eventDistDeath"]["spotted"] = getDvar("ai_eventDistDeath");
  ai_event["ai_eventDistDeath"]["hidden"] = 512;

  ai_event["ai_eventDistPain"]["spotted"] = getDvar("ai_eventDistPain");
  ai_event["ai_eventDistPain"]["hidden"] = 256;

  ai_event["ai_eventDistExplosion"]["spotted"] = 4000;
  ai_event["ai_eventDistExplosion"]["hidden"] = 4000;

  ai_event["ai_eventDistBullet"]["spotted"] = 96;
  ai_event["ai_eventDistBullet"]["hidden"] = 64;

  ai_event["ai_eventDistFootstep"]["spotted"] = 350;
  ai_event["ai_eventDistFootstep"]["hidden"] = 64;

  ai_event["ai_eventDistFootstepWalk"]["spotted"] = 256;
  ai_event["ai_eventDistFootstepWalk"]["hidden"] = 32;

  ai_event["ai_eventDistFootstepSprint"]["spotted"] = 400;
  ai_event["ai_eventDistFootstepSprint"]["hidden"] = 400;

  ai_event["ai_eventDistGunShot"]["spotted"] = 2048;
  ai_event["ai_eventDistGunShot"]["hidden"] = 2048;

  ai_event["ai_eventDistGunShotTeam"]["spotted"] = 750;
  ai_event["ai_eventDistGunShotTeam"]["hidden"] = 750;

  ai_event["ai_eventDistNewEnemy"]["spotted"] = 750;
  ai_event["ai_eventDistNewEnemy"]["hidden"] = 750;

  system_set_event_distances(ai_event);
}

system_set_event_distances(array) {
  foreach(event, event_array in array) {
    foreach(state, value in event_array) {
      level._stealth.logic.ai_event[event][state] = value;
    }
  }
}