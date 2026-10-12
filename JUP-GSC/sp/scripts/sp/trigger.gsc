/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\trigger.gsc
***********************************************/



#using script_6c1b22ea36b176be;
#using script_72ef6b9f0cf1f55a;
#using scripts\anim\battlechatter;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\art;
#using scripts\sp\audio;
#using scripts\sp\autosave;
#using scripts\sp\colors;
#using scripts\sp\compass;
#using scripts\sp\fakeactor;
#using scripts\sp\geo_mover;
#using scripts\sp\hud_util;
#using scripts\sp\lights;
#using scripts\sp\mgturret;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\stealth\player;
#namespace trigger;

function get_load_trigger_classes() {
  trigger_classes = [];
  trigger_classes["trigger_multiple_nobloodpool"] = &trigger_nobloodpool;
  trigger_classes["trigger_multiple_flag_set"] = &trigger_flag_set;
  trigger_classes["trigger_radius_flag_set"] = &trigger_flag_set;
  trigger_classes["trigger_multiple_flag_clear"] = &trigger_flag_clear;
  trigger_classes["trigger_radius_flag_clear"] = &trigger_flag_clear;
  trigger_classes["trigger_multiple_sun_off"] = &trigger_sun_off;
  trigger_classes["trigger_multiple_sun_on"] = &trigger_sun_on;
  trigger_classes["trigger_use_flag_set"] = &trigger_flag_set;
  trigger_classes["trigger_use_flag_clear"] = &trigger_flag_clear;
  trigger_classes["trigger_multiple_flag_set_touching"] = &trigger_flag_set_touching;
  trigger_classes["trigger_multiple_flag_lookat"] = &trigger_lookat;
  trigger_classes["trigger_multiple_flag_looking"] = &trigger_looking;
  trigger_classes["trigger_multiple_no_prone"] = &trigger_no_prone;
  trigger_classes["trigger_multiple_no_crouch_or_prone"] = &trigger_no_crouch_or_prone;
  trigger_classes["trigger_multiple_compass"] = &trigger_multiple_compass;
  trigger_classes["trigger_multiple_fx_volume"] = &trigger_multiple_fx_volume;
  trigger_classes["trigger_multiple_kleenex"] = &trigger_multiple_kleenex;
  trigger_classes["trigger_multiple_light_sunshadow"] = &scripts\sp\lights::sun_shadow_trigger;
  trigger_classes["trigger_multiple_arbitrary_up"] = &trigger_arbitrary_up;

  if(!scripts\sp\starts::is_no_game_start()) {
    trigger_classes["trigger_multiple_autosave"] = &scripts\sp\autosave::trigger_autosave;
    trigger_classes["trigger_multiple_autosave_silent"] = &scripts\sp\autosave::function_e96f7708c1775016;
    trigger_classes["trigger_multiple_spawn"] = &scripts\sp\spawner::trigger_spawner;
    trigger_classes["trigger_multiple_spawn_reinforcement"] = &scripts\sp\spawner::trigger_spawner_reinforcement;
    trigger_classes["trigger_multiple_zone_spawn"] = &scripts\sp\spawner::trigger_zone_spawn;
  }

  trigger_classes["trigger_multiple_stealth_shadow"] = &trigger_stealth_shadow;
  trigger_classes["trigger_multiple_slide"] = &namespace_7b69f911b6d80230::trigger_slide;
  trigger_classes["trigger_multiple_depthoffield"] = &trigger_multiple_depthoffield;
  trigger_classes["trigger_multiple_tessellationcutoff"] = &trigger_multiple_tessellationcutoff;
  trigger_classes["trigger_damage_player_flag_set"] = &trigger_damage_player_flag_set;
  trigger_classes["trigger_multiple_glass_break"] = &trigger_glass_break;
  trigger_classes["trigger_radius_glass_break"] = &trigger_glass_break;
  trigger_classes["trigger_multiple_friendly_respawn"] = &trigger_friendly_respawn;
  trigger_classes["trigger_multiple_friendly_stop_respawn"] = &trigger_friendly_stop_respawn;
  trigger_classes["trigger_multiple_physics"] = &trigger_physics;
  trigger_classes["trigger_multiple_fx_watersheeting"] = &trigger_multiple_fx_watersheeting;
  trigger_classes["trigger_multiple_fakeactor_move"] = &scripts\sp\fakeactor::trigger_fakeactor_move;
  trigger_classes["trigger_multiple_fakeactor_node_disable"] = &scripts\sp\fakeactor::trigger_fakeactor_node_disable;
  trigger_classes["trigger_multiple_fakeactor_node_enable"] = &scripts\sp\fakeactor::trigger_fakeactor_node_enable;
  trigger_classes["trigger_multiple_fakeactor_node_disablegroup"] = &scripts\sp\fakeactor::trigger_fakeactor_node_disablegroup;
  trigger_classes["trigger_multiple_fakeactor_node_enablegroup"] = &scripts\sp\fakeactor::trigger_fakeactor_node_enablegroup;
  trigger_classes["trigger_multiple_fakeactor_node_passthrough"] = &scripts\sp\fakeactor::trigger_fakeactor_node_passthrough;
  trigger_classes["trigger_multiple_fakeactor_node_lock"] = &scripts\sp\fakeactor::trigger_fakeactor_node_lock;
  trigger_classes["trigger_multiple_geo_mover"] = &scripts\sp\geo_mover::trigger_moveto;

  trigger_classes["<dev string:x1c>"] = &trigger_createart_transient;

  trigger_classes["trigger_multiple_transient"] = &trigger_multiple_transient;
  trigger_classes["trigger_multiple_fire"] = &trigger_fire;
  trigger_classes["trigger_radius_fire"] = &trigger_fire;
  trigger_classes["trigger_multiple_fx_on"] = &trigger_multiple_fx;
  trigger_classes["trigger_multiple_fx_off"] = &trigger_multiple_fx;
  trigger_classes["trigger_multiple_fx_fxzone"] = &trigger_flag_set_touching;
  trigger_classes["trigger_multiple_unlock"] = &trigger_unlock;
  trigger_classes["trigger_multiple_light_on_touching"] = &scripts\sp\lights::function_adb0429de1a7284;
  return trigger_classes;
}

function trigger_multiple_fx_watersheeting(trigger) {
  duration = 3;

  if(isDefined(trigger.script_duration)) {
    duration = trigger.script_duration;
  }

  while(true) {
    trigger waittill("trigger", other);

    if(isPlayer(other)) {
      other setwatersheeting(1, duration);
      wait duration * 0.2;
    }
  }
}

function get_load_trigger_funcs() {
  trigger_funcs = [];
  trigger_funcs["friendly_mgTurret"] = &scripts\sp\spawner::friendly_mgturret;

  if(!scripts\sp\starts::is_no_game_start()) {
    trigger_funcs["camper_spawner"] = &scripts\sp\spawner::camper_trigger_think;
    trigger_funcs["flood_spawner"] = &scripts\sp\spawner::flood_trigger_think;
    trigger_funcs["trigger_spawner"] = &scripts\sp\spawner::trigger_spawner;
    trigger_funcs["trigger_autosave"] = &scripts\sp\autosave::trigger_autosave;
    trigger_funcs["trigger_spawngroup"] = &trigger_spawngroup;
    trigger_funcs["trigger_vehicle_spline_spawn"] = &trigger_vehicle_spline_spawn;
    trigger_funcs["trigger_vehicle_spawn"] = &scripts\sp\spawner::trigger_spawner;
    trigger_funcs["random_spawn"] = &scripts\sp\spawner::random_spawn;
    trigger_funcs["zone_spawn"] = &scripts\sp\spawner::trigger_zone_spawn;
  }

  trigger_funcs["autosave_now"] = &scripts\sp\autosave::autosave_now_trigger;
  trigger_funcs["trigger_autosave_tactical"] = &scripts\sp\autosave::trigger_autosave_tactical;
  trigger_funcs["trigger_autosave_stealth"] = &scripts\sp\autosave::trigger_autosave_stealth;
  trigger_funcs["trigger_unlock"] = &trigger_unlock;
  trigger_funcs["trigger_lookat"] = &trigger_lookat;
  trigger_funcs["trigger_looking"] = &trigger_looking;
  trigger_funcs["trigger_cansee"] = &trigger_cansee;
  trigger_funcs["flag_set"] = &trigger_flag_set;
  trigger_funcs["flag_set_player"] = &trigger_flag_set_player;
  trigger_funcs["flag_unset"] = &trigger_flag_clear;
  trigger_funcs["flag_clear"] = &trigger_flag_clear;
  trigger_funcs["friendly_respawn_trigger"] = &trigger_friendly_respawn;
  trigger_funcs["radio_trigger"] = &trigger_radio;
  trigger_funcs["trigger_ignore"] = &trigger_ignore;
  trigger_funcs["trigger_pacifist"] = &trigger_pacifist;
  trigger_funcs["trigger_delete"] = &trigger_turns_off;
  trigger_funcs["trigger_delete_on_touch"] = &trigger_delete_on_touch;
  trigger_funcs["trigger_off"] = &trigger_turns_off;
  trigger_funcs["trigger_outdoor"] = &scripts\sp\spawner::outdoor_think;
  trigger_funcs["trigger_indoor"] = &scripts\sp\spawner::indoor_think;
  trigger_funcs["trigger_hint"] = &trigger_hint;
  trigger_funcs["trigger_grenade_at_player"] = &trigger_throw_grenade_at_player;
  trigger_funcs["flag_on_cleared"] = &trigger_flag_on_cleared;
  trigger_funcs["flag_set_touching"] = &trigger_flag_set_touching;
  trigger_funcs["delete_link_chain"] = &trigger_delete_link_chain;
  trigger_funcs["trigger_slide"] = &trigger_slide;
  trigger_funcs["trigger_dooropen"] = &trigger_dooropen;
  trigger_funcs["geo_mover"] = &scripts\sp\geo_mover::trigger_moveto;
  trigger_funcs["out_of_bounds"] = &trigger_outofbounds;
  trigger_funcs["no_crouch_or_prone"] = &trigger_no_crouch_or_prone;
  trigger_funcs["no_prone"] = &trigger_no_prone;
  return trigger_funcs;
}

function init_script_triggers() {
  scripts\sp\colors::init_colors();
  scripts\sp\audio::init_audio();
  array_delete(getEntArray("trigger_multiple_softlanding", "classname"));
  trigger_classes = get_load_trigger_classes();
  trigger_funcs = get_load_trigger_funcs();

  foreach(function in trigger_classes) {
    triggers = getEntArray(classname, "classname");
    array_levelthread(triggers, function);
  }

  trigger_multiple = getEntArray("trigger_multiple", "classname");
  trigger_radius = getEntArray("trigger_radius", "classname");
  triggers = array_merge(trigger_multiple, trigger_radius);
  trigger_disk = getEntArray("trigger_disk", "classname");
  triggers = array_merge(triggers, trigger_disk);
  trigger_once = getEntArray("trigger_once", "classname");
  triggers = array_merge(triggers, trigger_once);

  if(!scripts\sp\starts::is_no_game_start()) {
    for(i = 0; i < triggers.size; i++) {
      if(triggers[i].spawnflags & 32) {
        thread scripts\sp\spawner::trigger_spawner(triggers[i]);
      }
    }
  }

  code_classes = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];

  foreach(triggertype in code_classes) {
    triggers = getEntArray(triggertype, "code_classname");

    foreach(trigger in triggers) {
      if(isDefined(trigger.script_flag_true)) {
        level thread trigger_script_flag_true(trigger);
      }

      if(isDefined(trigger.script_flag_false)) {
        level thread trigger_script_flag_false(trigger);
      }

      if(isDefined(trigger.script_autosavename) || isDefined(trigger.script_autosave)) {
        level thread scripts\sp\autosave::function_806ee0c06769f6f(trigger);
      }

      if(isDefined(trigger.script_mgturretauto)) {
        level thread scripts\sp\mgturret::mgturret_auto(trigger);
      }

      if(isDefined(trigger.script_killspawner)) {
        level thread scripts\sp\spawner::kill_spawner(trigger);
      }

      if(isDefined(trigger.script_kill_vehicle_spawner)) {
        level thread scripts\common\vehicle_code::vehicle_triggerkillspawner(trigger);
      }

      if(isDefined(trigger.script_emptyspawner)) {
        level thread scripts\sp\spawner::empty_spawner(trigger);
      }

      if(isDefined(trigger.script_prefab_exploder)) {
        trigger.script_exploder = trigger.script_prefab_exploder;
      }

      if(isDefined(trigger.script_exploder)) {
        level thread exploder_load(trigger);
      }

      if(isDefined(trigger.script_triggered_playerseek)) {
        level thread trigger_playerseek(trigger);
      }

      if(isDefined(trigger.script_bctrigger)) {
        level thread trigger_battlechatter(trigger);
      }

      if(isDefined(trigger.script_trigger_group)) {
        trigger thread trigger_group();
      }

      if(isDefined(trigger.script_random_killspawner)) {
        level thread scripts\sp\spawner::random_killspawner(trigger);
      }

      if(isDefined(trigger.targetname)) {
        targetname = trigger.targetname;

        if(isDefined(trigger_funcs[targetname])) {
          level thread[[trigger_funcs[targetname]]](trigger);
        }
      }
    }
  }
}

function trigger_createart_transient(trigger) {
  delete_trigger = 1;

  delete_trigger = 0;
  assertex(isDefined(trigger.script_transient), "<dev string:x41>" + trigger.origin + "<dev string:x61>");

  if(!isDefined(level.var_66f10e73bb798144)) {
    level.var_66f10e73bb798144 = [];
  }

  level.var_66f10e73bb798144[level.var_66f10e73bb798144.size] = trigger;
  level thread createart_transient_thread();

  if(delete_trigger) {
    trigger delete();
  }
}

function createart_transient_thread() {
  level notify("<dev string:x7f>");
  level endon("<dev string:x7f>");

  while(!is_transient_createart_enabled()) {
    wait 1;
  }

  current_trans = "<dev string:x9a>";
  all_trans = [];

  foreach(trigger in level.var_66f10e73bb798144) {
    array = strtok(trigger.script_transient, "<dev string:x9b>");

    foreach(tran in array) {
      exists = 0;

      if(!array_contains(all_trans, tran)) {
        all_trans[all_trans.size] = tran;
      }
    }
  }

  new_trans = current_trans;

  while(true) {
    wait 1;

    if(!is_transient_createart_enabled()) {
      continue;
    }

    foreach(trigger in level.var_66f10e73bb798144) {
      if(level.player istouching(trigger)) {
        new_trans = trigger.script_transient;
        break;
      }
    }

    if(current_trans != new_trans) {
      load_array = [];
      unload_array = [];
      var_686fd3960ce92c66 = strtok(new_trans, "<dev string:x9b>");

      foreach(str in all_trans) {
        if(array_contains(var_686fd3960ce92c66, str)) {
          load_array[load_array.size] = str;
          continue;
        }

        unload_array[unload_array.size] = str;
      }

      if(current_trans == "<dev string:x9a>") {
        unloadalltransients();
      }

      if(unload_array.size > 0) {
        transient_unload_array(unload_array);
      }

      foreach(trans in load_array) {
        transient_load(trans);
      }

      current_trans = new_trans;
    }
  }
}

function is_transient_createart_enabled() {
  if(getDvar(@ "createfx") != "") {
    return true;
  }

  if(getdvarint(@ "scr_art_tweak") > 0) {
    return true;
  }

  if(isDefined(level.start_point) && level.start_point == "no_game") {
    return true;
  }

  return false;
}

function trigger_multiple_transient(trigger) {
  pass = 0;

  if(!isDefined(trigger.script_transient) && !isDefined(trigger.script_transient_unload) && !isDefined(trigger.script_transient_set) && !isDefined(trigger.script_transient_unload_set) && !isDefined(trigger.var_6803211c32618486) && !isDefined(trigger.var_e6aa8bd6620dc7cf)) {
    assertmsg("<dev string:x9d>" + trigger.origin + "<dev string:xbc>");
  }

  loads = undefined;
  unloads = undefined;
  load_set = undefined;
  unload_set = 0;
  vis = undefined;
  invis = undefined;

  if(isDefined(trigger.script_transient)) {
    loads = strtok(trigger.script_transient, " ");
  }

  if(isDefined(trigger.script_transient_unload)) {
    unloads = strtok(trigger.script_transient_unload, " ");
  }

  if(isDefined(trigger.script_transient_set)) {
    load_set = trigger.script_transient_set;
  }

  if(isDefined(trigger.script_transient_unload_set)) {
    unload_set = 1;
  }

  if(isDefined(trigger.var_6803211c32618486)) {
    vis = strtok(trigger.var_6803211c32618486, " ");
  }

  if(isDefined(trigger.var_e6aa8bd6620dc7cf)) {
    invis = strtok(trigger.var_e6aa8bd6620dc7cf, " ");
  }

  flag_check = [];
  flag_check = array_combine(loads, unloads);

  if(isDefined(trigger.script_transient_set)) {
    names = gettransientsinset(trigger.script_transient_set);
    flag_check = array_combine(flag_check, names);
  }

  foreach(str in flag_check) {
    if(!flag_exist(str + "_loaded")) {
      flag_init(str + "_loaded");
    }
  }

  while(true) {
    trigger waittill("trigger");

    if(isDefined(vis)) {
      function_17175f6af83bafea(vis);
    }

    if(isDefined(unloads)) {
      transient_unload_array(unloads);
    }

    if(isDefined(loads)) {
      transient_load_array(loads);
    }

    if(isDefined(invis)) {
      function_7dcc5e04ab79399b(invis);
    }

    if(isDefined(load_set)) {
      switchtransientset(load_set);
    }

    if(istrue(unload_set)) {
      switchtransientset("none");
    }
  }
}

function trigger_damage_player_flag_set(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  for(;;) {
    trigger waittill("trigger", other);

    if(!isalive(other)) {
      continue;
    }

    if(!isPlayer(other)) {
      continue;
    }

    trigger script_delay();
    flag_set(flag, other);
  }
}

function trigger_flag_clear(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  for(;;) {
    trigger waittill("trigger");
    trigger script_delay();
    flag_clear(flag);
  }
}

function trigger_flag_on_cleared(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  for(;;) {
    trigger waittill("trigger");
    wait 1;

    if(trigger found_toucher()) {
      continue;
    }

    break;
  }

  flag_set(flag);
}

function found_toucher() {
  ai = getaiarray("bad_guys");

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isalive(guy)) {
      continue;
    }

    if(guy istouching(self)) {
      return true;
    }

    wait 0.1;
  }

  ai = getaiarray("bad_guys");

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(guy istouching(self)) {
      return true;
    }
  }

  return false;
}

function trigger_flag_set(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  for(;;) {
    trigger waittill("trigger", other);
    trigger script_delay();
    flag_set(flag, other);

    if(!isDefined(trigger)) {
      break;
    }
  }
}

function trigger_friendly_respawn(trigger) {
  trigger endon("death");
  org = getEnt(trigger.target, "targetname");
  origin = undefined;

  if(isDefined(org)) {
    origin = org.origin;
    org delete();
  } else {
    org = getStruct(trigger.target, "targetname");
    assertex(isDefined(org), "trigger_multiple_friendly_respawn doesn't target an origin.");
    origin = org.origin;
  }

  for(;;) {
    trigger waittill("trigger");
    level.respawn_spawner_org = origin;
    flag_set("respawn_friendlies");
    wait 0.5;
  }
}

function trigger_landingzone(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  if(!isDefined(level.landingzones_active)) {
    level.landingzones_active = [];
  }

  for(;;) {
    trigger waittill("trigger", player);

    if(isalive(player) && isDefined(trigger) && player istouching(trigger)) {
      level.landingzones_active = array_add(level.landingzones_active, trigger);
    }

    while(isalive(player) && isDefined(trigger) && player istouching(trigger)) {
      if(!flag(flag)) {
        thread trigger_landingzone_active(flag);
      }

      wait 0.25;
    }

    level.landingzones_active = array_remove(level.landingzones_active, trigger);
  }
}

function trigger_landingzone_active(flag) {
  flag_set(flag);

  for(;;) {
    level.landingzones_active = array_removeundefined(level.landingzones_active);

    if(level.landingzones_active.size == 0) {
      break;
    }

    wait 0.25;
  }

  flag_clear(flag);
}

function trigger_arbitrary_up(trigger) {
  trigger setworlduptrigger(1);

  if(isDefined(trigger.target)) {
    parent = getEnt(trigger.target, "targetname");
    trigger enablelinkTo();
    trigger linkTo(parent);
  }
}

function trigger_flag_set_touching(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  for(;;) {
    trigger waittill("trigger", other);
    trigger script_delay();

    if(isalive(other) && isDefined(trigger) && other istouching(trigger)) {
      flag_set(flag);
    }

    while(isalive(other) && isDefined(trigger) && other istouching(trigger)) {
      wait 0.25;
    }

    flag_clear(flag);
  }
}

function trigger_friendly_stop_respawn(trigger) {
  for(;;) {
    trigger waittill("trigger");
    flag_clear("respawn_friendlies");
  }
}

function trigger_group() {
  thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

function trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, trigger);

  if(self != trigger) {
    self delete();
  }
}

function trigger_nobloodpool(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(!isalive(other)) {
      continue;
    }

    other.skipbloodpool = 1;
    other thread set_wait_then_clear_skipbloodpool();
  }
}

function set_wait_then_clear_skipbloodpool() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self.skipbloodpool = undefined;
}

function trigger_physics(trigger) {
  assertex(isDefined(trigger.target), "Trigger_physics at " + trigger.origin + " has no target for physics.");
  ents = [];
  structs = getStructArray(trigger.target, "targetname");
  orgs = getEntArray(trigger.target, "targetname");

  foreach(org in orgs) {
    struct = spawnStruct();
    struct.origin = org.origin;
    struct.script_parameters = org.script_parameters;
    struct.script_damage = org.script_damage;
    struct.radius = org.radius;
    structs[structs.size] = struct;
    org delete();
  }

  assertex(structs.size, "Trigger_physics at " + trigger.origin + " has no target for physics.");
  trigger.org = structs[0].origin;
  trigger waittill("trigger");
  trigger script_delay();

  foreach(struct in structs) {
    radius = struct.radius;
    vel = struct.script_parameters;
    damage = struct.script_damage;

    if(!isDefined(radius)) {
      radius = 350;
    }

    if(!isDefined(vel)) {
      vel = 0.25;
    }

    setDvar(@ "tempdvar", vel);
    vel = getdvarfloat(@ "tempdvar");

    if(isDefined(damage)) {
      radiusdamage(struct.origin, radius, damage, damage * 0.5);
    }

    physicsexplosionsphere(struct.origin, radius, radius * 0.5, vel);
  }
}

function trigger_playerseek(trig) {
  groupnum = trig.script_triggered_playerseek;
  trig waittill("trigger");
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(!isalive(ai[i])) {
      continue;
    }

    if(isDefined(ai[i].script_triggered_playerseek) && ai[i].script_triggered_playerseek == groupnum) {
      ai[i].goalradius = 800;
      ai[i] setgoalentity(level.player);
      level thread scripts\sp\spawner::delayed_player_seek_think(ai[i]);
    }
  }
}

function trigger_script_flag_false(trigger) {
  tokens = create_flags_and_return_tokens(trigger.script_flag_false);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_trigger_based_on_flags();
}

function trigger_script_flag_true(trigger) {
  tokens = create_flags_and_return_tokens(trigger.script_flag_true);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_trigger_based_on_flags();
}

function add_tokens_to_trigger_flags(tokens) {
  for(i = 0; i < tokens.size; i++) {
    flag = tokens[i];

    if(!isDefined(level.trigger_flags[flag])) {
      level.trigger_flags[flag] = [];
    }

    level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
  }
}

function trigger_spawngroup(trigger) {
  waittillframeend();
  assertex(isDefined(trigger.script_spawngroup), "spawngroup Trigger at " + trigger.origin + " has no script_spawngroup");
  spawngroup = trigger.script_spawngroup;

  if(!isDefined(level.spawn_group) || !isDefined(level.spawn_groups[spawngroup])) {
    return;
  }

  trigger waittill("trigger");
  spawners = random(level.spawn_groups[spawngroup]);

  foreach(spawner in spawners) {
    spawner spawn_ai();
  }
}

function trigger_sun_off(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(getdvarint(@ "hash_531180c075033638") == 0) {
      continue;
    }

    setsaveddvar(@ "hash_531180c075033638", 0);
  }
}

function trigger_sun_on(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(getdvarint(@ "hash_531180c075033638") == 1) {
      continue;
    }

    setsaveddvar(@ "hash_531180c075033638", 1);
  }
}

function trigger_vehicle_spline_spawn(trigger) {
  trigger waittill("trigger");
  spawners = getEntArray(trigger.target, "targetname");

  foreach(spawner in spawners) {
    spawner thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

function get_trigger_targs() {
  triggers = [];
  target_origin = undefined;

  if(isDefined(self.target)) {
    targets = getEntArray(self.target, "targetname");
    orgs = [];

    foreach(target in targets) {
      if(target.classname == "script_origin" || target.classname == "script_origin_mini") {
        orgs[orgs.size] = target;
      }

      if(issubstr(target.classname, "trigger")) {
        triggers[triggers.size] = target;
      }
    }

    targets = getStructArray(self.target, "targetname");

    foreach(target in targets) {
      orgs[orgs.size] = target;
    }

    assertex(orgs.size < 2, "Trigger at " + self.origin + " targets multiple script origins");

    if(orgs.size == 1) {
      org = orgs[0];
      target_origin = org.origin;

      if(isDefined(org.code_classname)) {
        org delete();
      }
    }
  }

  if(isDefined(self.targetname)) {
    assertex(isDefined(target_origin), self.targetname + "<dev string:x165>" + self.origin + "<dev string:x16a>");
  } else {
    assertex(isDefined(target_origin), self.classname + "<dev string:x165>" + self.origin + "<dev string:x16a>");
  }

  array = [];
  array["triggers"] = triggers;
  array["target_origin"] = target_origin;
  return array;
}

function trigger_lookat(trigger) {
  trigger_lookat_think(trigger, 1);
}

function trigger_looking(trigger) {
  trigger_lookat_think(trigger, 0);
}

function trigger_lookat_think(trigger, endonflag) {
  success_dot = 0.78;

  if(isDefined(trigger.script_dot)) {
    success_dot = trigger.script_dot;
    assertex(success_dot <= 1, "Script_dot should be between 0 and 1");
  }

  array = trigger get_trigger_targs();
  triggers = array["triggers"];
  target_origin = array["target_origin"];
  has_flag = isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy);
  flagname = undefined;

  if(has_flag) {
    flagname = trigger get_trigger_flag();

    if(!isDefined(level.flag[flagname])) {
      flag_init(flagname);
    }
  } else if(!triggers.size) {
    assertex(isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy), "Trigger_lookat at " + trigger.origin + " has no script_flag! The script_flag is used as a flag that gets set when the trigger is activated.");
  }

  if(endonflag && has_flag) {
    level endon(flagname);
  }

  trigger endon("death");
  do_sighttrace = 1;

  if(isDefined(trigger.script_nosight)) {
    do_sighttrace = trigger.script_nosight;
  }

  duration = 0;

  if(isDefined(trigger.script_duration)) {
    duration = trigger.script_duration;
  }

  debounce = 0.05;

  if(do_sighttrace) {
    debounce = 0.5;
  }

  for(;;) {
    if(has_flag) {
      flag_clear(flagname);
    }

    trigger waittill("trigger", other);
    assertex(isPlayer(other), "trigger_lookat currently only supports looking from the player");
    touching_trigger = [];
    time_elapsed = 0;

    while(other istouching(trigger)) {
      player_eye = other getEye();

      if(do_sighttrace) {
        sighttracesuccess = 0;

        if(isDefined(level.var_76be4c1d6bd7dbd9)) {
          sighttracesuccess = scripts\engine\trace::ray_trace_passed(player_eye, target_origin, level.player, level.var_76be4c1d6bd7dbd9);
        } else {
          sighttracesuccess = sighttracepassed(player_eye, target_origin, 0, undefined);
        }

        if(!sighttracesuccess) {
          time_elapsed = 0;

          if(has_flag) {
            flag_clear(flagname);
          }

          wait debounce;
          continue;
        }
      }

      normal = vectorNormalize(target_origin - player_eye);
      player_angles = other getplayerangles();
      player_forward = anglesToForward(player_angles);
      dot = vectordot(player_forward, normal);

      if(dot >= success_dot) {
        time_elapsed += debounce;

        if(time_elapsed >= duration) {
          array_thread(triggers, &send_notify, "trigger");

          if(has_flag) {
            flag_set(flagname, other);
          }

          if(endonflag) {
            return;
          }

          wait 2;
        }
      } else {
        time_elapsed = 0;

        if(has_flag) {
          flag_clear(flagname);
        }
      }

      wait debounce;
    }
  }
}

function trigger_cansee(trigger) {
  triggers = [];
  target_origin = undefined;
  array = trigger get_trigger_targs();
  triggers = array["triggers"];
  target_origin = array["target_origin"];
  has_flag = isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy);
  flagname = undefined;

  if(has_flag) {
    flagname = trigger get_trigger_flag();

    if(!isDefined(level.flag[flagname])) {
      flag_init(flagname);
    }
  } else if(!triggers.size) {
    assertex(isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy), "Trigger_cansee at " + trigger.origin + " has no script_flag! The script_flag is used as a flag that gets set when the trigger is activated.");
  }

  trigger endon("death");
  range = 12;
  offsets = [];
  offsets[offsets.size] = (0, 0, 0);
  offsets[offsets.size] = (range, 0, 0);
  offsets[offsets.size] = (range * -1, 0, 0);
  offsets[offsets.size] = (0, range, 0);
  offsets[offsets.size] = (0, range * -1, 0);
  offsets[offsets.size] = (0, 0, range);

  for(;;) {
    if(has_flag) {
      flag_clear(flagname);
    }

    trigger waittill("trigger", other);
    assertex(isPlayer(other), "trigger_cansee currently only supports looking from the player");

    while(level.player istouching(trigger)) {
      if(!other cantraceto(target_origin, offsets)) {
        if(has_flag) {
          flag_clear(flagname);
        }

        wait 0.1;
        continue;
      }

      if(has_flag) {
        flag_set(flagname);
      }

      array_thread(triggers, &send_notify, "trigger");
      wait 0.5;
    }
  }
}

function cantraceto(target_origin, offsets) {
  for(i = 0; i < offsets.size; i++) {
    if(sighttracepassed(self getEye(), target_origin + offsets[i], 1, self)) {
      return true;
    }
  }

  return false;
}

function trigger_unlock(trigger) {
  noteworthy = "ent_" + trigger getentitynumber() + "_not_set";

  if(isDefined(trigger.script_noteworthy)) {
    noteworthy = trigger.script_noteworthy;
  }

  target_triggers = getEntArray(trigger.target, "targetname");
  trigger thread trigger_unlock_death(trigger.target);

  for(;;) {
    array_thread(target_triggers, &trigger_off);
    trigger waittill("trigger");
    array_thread(target_triggers, &trigger_on);
    wait_for_an_unlocked_trigger(target_triggers, noteworthy);
    array_notify(target_triggers, "relock");
  }
}

function trigger_unlock_death(target) {
  self waittill("death");
  target_triggers = getEntArray(target, "targetname");
  array_thread(target_triggers, &trigger_off);
}

function wait_for_an_unlocked_trigger(triggers, noteworthy) {
  level endon("unlocked_trigger_hit" + noteworthy);
  ent = spawnStruct();

  for(i = 0; i < triggers.size; i++) {
    triggers[i] thread report_trigger(ent, noteworthy);
  }

  ent waittill("trigger");
  level notify("unlocked_trigger_hit" + noteworthy);
}

function report_trigger(ent, noteworthy) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + noteworthy);
  self waittill("trigger");
  ent notify("trigger");
}

function trigger_battlechatter(trigger) {
  realtrigger = undefined;

  if(isDefined(trigger.target)) {
    targetents = getEntArray(trigger.target, "targetname");

    if(issubstr(targetents[0].classname, "trigger")) {
      realtrigger = targetents[0];
    }
  }

  if(isDefined(realtrigger)) {
    realtrigger waittill("trigger", other);
  } else {
    trigger waittill("trigger", other);
  }

  soldier = undefined;

  if(isDefined(realtrigger)) {
    if(other.team != level.player.team && level.player istouching(trigger)) {
      soldier = level.player scripts\anim\battlechatter::getclosestfriendlyspeaker("custom");
    } else if(other.team == level.player.team) {
      enemyteam = "axis";

      if(level.player.team == "axis") {
        enemyteam = "allies";
      }

      soldiers = scripts\anim\battlechatter::getspeakers(enemyteam);
      soldiers = get_array_of_farthest(level.player.origin, soldiers);

      foreach(guy in soldiers) {
        if(guy istouching(trigger)) {
          soldier = guy;

          if(battlechatter_dist_check(guy.origin)) {
            break;
          }
        }
      }
    }
  } else if(isPlayer(other)) {
    soldier = other scripts\anim\battlechatter::getclosestfriendlyspeaker("custom");
  } else {
    soldier = other;
  }

  if(!isDefined(soldier)) {
    return;
  }

  if(battlechatter_dist_check()) {
    return;
  }

  success = soldier custom_battlechatter(trigger.script_bctrigger);

  if(!success) {
    level delaythread(0.25, &trigger_battlechatter, trigger);
    return;
  }

  trigger notify("custom_battlechatter_done");
}

function battlechatter_dist_check(origin) {
  return distancesquared(origin, level.player getorigin()) <= 262144;
}

function trigger_dooropen(trigger) {
  trigger waittill("trigger");
  targets = getEntArray(trigger.target, "targetname");
  rotations = [];
  rotations["left_door"] = -170;
  rotations["right_door"] = 170;

  foreach(door in targets) {
    assertex(isDefined(door.script_noteworthy), "Door had no script_noteworthy to indicate which door it is. Must be left_door or right_door.");
    rotation = rotations[door.script_noteworthy];
    door connectpaths();
    door rotateYaw(rotation, 1, 0, 0.5);
  }
}

function trigger_glass_break(trigger) {
  glassid = getglassarray(trigger.target);
  type = "notetrack";

  if(isDefined(trigger.script_type)) {
    type = "trigger";
  }

  if(!isDefined(glassid) || glassid.size == 0) {
    assertmsg("Glass shatter trigger at origin " + trigger.origin + " needs to target a func_glass.");
    return;
  }

  other = undefined;

  while(true) {
    if(type == "notetrack") {
      level waittill("glass_break", other);
    } else {
      trigger waittill("trigger", other);
    }

    if(other istouching(trigger)) {
      ref1 = other.origin;
      waitframe();
      ref2 = other.origin;
      direction = undefined;

      if(ref1 != ref2) {
        direction = ref2 - ref1;
      }

      if(isDefined(direction)) {
        foreach(glass in glassid) {
          destroyglass(glass, direction);
        }

        break;
      }

      foreach(glass in glassid) {
        destroyglass(glass);
      }

      break;
    }
  }

  trigger delete();
}

function trigger_delete_link_chain(trigger) {
  trigger waittill("trigger");
  targets = trigger get_script_linkto_targets();
  array_thread(targets, &delete_links_then_self);
}

function get_script_linkto_targets() {
  targets = [];

  if(!isDefined(self.script_linkto)) {
    return targets;
  }

  tokens = strtok(self.script_linkto, " ");

  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    target = getEnt(token, "script_linkname");

    if(isDefined(target)) {
      targets[targets.size] = target;
    }
  }

  return targets;
}

function delete_links_then_self() {
  targets = get_script_linkto_targets();
  array_thread(targets, &delete_links_then_self);
  self delete();
}

function trigger_throw_grenade_at_player(trigger) {
  trigger endon("death");
  trigger waittill("trigger");
  throwgrenadeatplayerasap();
}

function trigger_hint(trigger) {
  assertex(isDefined(trigger.script_hint), "Trigger_hint at " + trigger.origin + " has no .script_hint");

  if(!isDefined(level.displayed_hints)) {
    level.displayed_hints = [];
  }

  waittillframeend();
  assertex(isDefined(level.trigger_hint_string), "tried trigger hint without add_hint_string");
  hint = trigger.script_hint;
  assertex(isDefined(level.trigger_hint_string[hint]), "Trigger_hint with hint " + hint + " had no hint string assigned to it. Define hint strings with add_hint_string()");
  trigger waittill("trigger", other);
  assertex(isPlayer(other), "Tried to do a trigger_hint on a non player entity");

  if(isDefined(level.displayed_hints[hint])) {
    return;
  }

  level.displayed_hints[hint] = 1;
  other display_hint(hint);
}

function trigger_delete_on_touch(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(isDefined(other)) {
      other delete();
    }
  }
}

function trigger_turns_off(trigger) {
  trigger waittill("trigger");
  trigger trigger_off();

  if(!isDefined(trigger.script_linkto)) {
    return;
  }

  tokens = strtok(trigger.script_linkto, " ");

  for(i = 0; i < tokens.size; i++) {
    array_thread(getEntArray(tokens[i], "script_linkname"), &trigger_off);
  }
}

function trigger_ignore(trigger) {
  thread trigger_runs_function_on_touch(trigger, &set_ignoreme, &get_ignoreme);
}

function trigger_pacifist(trigger) {
  thread trigger_runs_function_on_touch(trigger, &set_pacifist, &get_pacifist);
}

function trigger_runs_function_on_touch(trigger, set_func, get_func) {
  for(;;) {
    trigger waittill("trigger", other);

    if(!isalive(other)) {
      continue;
    }

    if(other[[get_func]]()) {
      continue;
    }

    other thread touched_trigger_runs_func(trigger, set_func);
  }
}

function touched_trigger_runs_func(trigger, set_func) {
  self endon("death");
  self.ignoreme = 1;
  [[set_func]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(trigger)) {
    wait 1;
  }

  [[set_func]](0);
}

function trigger_radio(trigger) {
  trigger waittill("trigger");
  radio_dialogue(trigger.script_noteworthy);
}

function trigger_flag_set_player(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }

  for(;;) {
    trigger waittill("trigger", other);

    if(!isPlayer(other)) {
      continue;
    }

    trigger script_delay();
    flag_set(flag);
  }
}

function trigger_multiple_depthoffield(trigger) {
  waittillframeend();

  while(true) {
    trigger waittill("trigger", player);
    nearstart = trigger.script_dof_near_start;
    nearend = trigger.script_dof_near_end;
    nearblur = trigger.script_dof_near_blur;
    farstart = trigger.script_dof_far_start;
    farend = trigger.script_dof_far_end;
    farblur = trigger.script_dof_far_blur;
    time = trigger.script_delay;

    if(nearstart != level.dof["base"]["goal"]["nearStart"] || nearend != level.dof["base"]["goal"]["nearEnd"] || nearblur != level.dof["base"]["goal"]["nearBlur"] || farstart != level.dof["base"]["goal"]["farStart"] || farend != level.dof["base"]["goal"]["farEnd"] || farblur != level.dof["base"]["goal"]["farBlur"]) {
      scripts\sp\art::dof_set_base(nearstart, nearend, nearblur, farstart, farend, farblur, time);
      wait time;
      continue;
    }

    waitframe();
  }
}

function trigger_multiple_tessellationcutoff(trigger) {
  waittillframeend();

  while(true) {
    trigger waittill("trigger", player);
    cutoff_distance = trigger.script_tess_distance;
    cutoff_falloff = trigger.script_tess_falloff;
    time = trigger.script_delay;

    if(cutoff_distance != level.tess.cutoff_distance_goal || cutoff_falloff != level.tess.cutoff_falloff_goal) {
      cutoff_distance = max(0, cutoff_distance);
      cutoff_distance = min(10000, cutoff_distance);
      cutoff_falloff = max(0, cutoff_falloff);
      cutoff_falloff = min(10000, cutoff_falloff);
      scripts\sp\art::tess_set_goal(cutoff_distance, cutoff_falloff, time);
      continue;
    }

    waitframe();
  }
}

function trigger_multiple_fx_volume(trigger) {
  dummy = spawn("script_origin", (0, 0, 0));
  trigger.fx = [];

  foreach(entfx in level.createfxent) {
    assign_fx_to_trigger(entfx, trigger, dummy);
  }

  dummy delete();

  if(!isDefined(trigger.target)) {
    return;
  }

  targets = getEntArray(trigger.target, "targetname");
  trigger.fx_on = 1;

  foreach(target in targets) {
    switch (target.classname) {
      case #"hash_3507493b67792336":
        target thread trigger_multiple_fx_trigger_on_think(trigger);
        break;
      case #"hash_f3b48883e3c60578":
        target thread trigger_multiple_fx_trigger_off_think(trigger);
        break;
      default:
        break;
    }
  }
}

function trigger_multiple_fx_trigger_on_think(volume) {
  while(true) {
    self waittill("trigger");

    if(!volume.fx_on) {
      array_thread(volume.fx, &restarteffect);
    }

    wait 1;
  }
}

function trigger_multiple_fx_trigger_off_think(volume) {
  while(true) {
    self waittill("trigger");

    if(volume.fx_on) {
      array_thread(volume.fx, &pauseeffect);
    }

    wait 1;
  }
}

function assign_fx_to_trigger(entfx, trigger, dummy) {
  if(isDefined(entfx.v["soundalias"]) && entfx.v["soundalias"] != "nil") {
    if(!isDefined(entfx.v["stopable"]) || !entfx.v["stopable"]) {
      return;
    }
  }

  dummy.origin = entfx.v["origin"];

  if(dummy istouching(trigger)) {
    trigger.fx[trigger.fx.size] = entfx;
  }
}

function trigger_multiple_compass(trigger) {
  minimap_image = trigger.script_parameters;
  assertex(isDefined(minimap_image), "trigger_multiple_compass has no script_parameters for its minimap_image.");

  if(!isDefined(level.minimap_image)) {
    level.minimap_image = "";
  }

  for(;;) {
    trigger waittill("trigger");

    if(level.minimap_image != minimap_image) {
      scripts\sp\compass::setupminimap(minimap_image);
    }
  }
}

function trigger_no_crouch_or_prone(trigger) {
  array_thread(level.players, &no_crouch_or_prone_think_for_player, trigger);
}

function no_crouch_or_prone_think_for_player(trigger) {
  assert(isPlayer(self));

  for(;;) {
    trigger waittill("trigger", player);

    if(!isDefined(player)) {
      continue;
    }

    if(player != self) {
      continue;
    }

    while(player istouching(trigger)) {
      player allowprone(0);
      player allowcrouch(0);
      wait 0.05;
    }

    player allowprone(1);
    player allowcrouch(1);
  }
}

function trigger_no_prone(trigger) {
  array_thread(level.players, &no_prone_for_player, trigger);
}

function no_prone_for_player(trigger) {
  assert(isPlayer(self));

  for(;;) {
    trigger waittill("trigger", player);

    if(!isDefined(player)) {
      continue;
    }

    if(player != self) {
      continue;
    }

    while(player istouching(trigger)) {
      player allowprone(0);
      wait 0.05;
    }

    player allowprone(1);
  }
}

function exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");

  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(!trigger script_delay()) {
      wait 4;
    }

    level thread exploder_load(trigger);
    return;
  }

  if(!trigger script_delay() && isDefined(trigger.script_exploder_delay)) {
    wait trigger.script_exploder_delay;
  }

  exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
}

function trigger_multiple_kleenex(trigger) {
  if(getdvarint(@ "kleenex") != 1) {
    return;
  }

  trigger waittill("trigger");
  kleenex_popup();
}

function trigger_stealth_shadow(trigger) {
  trigger endon("death");
  the_flag = "stealth_in_shadow";

  if(!isDefined(level.trigger_stealth_shadow)) {
    level.trigger_stealth_shadow = [];
  }

  level.trigger_stealth_shadow[level.trigger_stealth_shadow.size] = trigger;
  function_b0d778fb201fea8d(trigger);

  while(true) {
    trigger waittill("trigger", other);

    if(!other ent_flag_exist(the_flag)) {
      println("<dev string:x181>" + the_flag + "<dev string:x184>" + other getentnum() + "<dev string:x1a4>");
      continue;
    }

    if(other ent_flag(the_flag)) {
      continue;
    }

    other thread in_shadow_thread(trigger, the_flag);
  }
}

function in_shadow_thread(volume, the_flag) {
  self endon("death");
  scripts\stealth\player::function_e403865f115834a8(the_flag);

  while(isDefined(volume) && self istouching(volume)) {
    wait 0.05;
  }

  scripts\stealth\player::function_3718fc282393305(the_flag);
}

function trigger_fire(trigger) {
  trigger endon("death");

  if(isDefined(trigger.trigger_fire_endon)) {
    trigger endon(trigger.trigger_fire_endon);
  }

  default_damage = 1;
  dam_multiplier = 5;
  final_damage = 0;

  if(!isDefined(trigger.script_delay_min) && !isDefined(trigger.script_delay_max)) {
    trigger.script_delay_min = 0.05;
    trigger.script_delay_max = 0.05;
  }

  if(trigger.script_delay_min == trigger.script_delay_max) {
    trigger.script_delay = trigger.script_delay_min;
  }

  if(isDefined(trigger.script_damage)) {
    default_damage = trigger.script_damage;
  }

  while(true) {
    trigger waittill("trigger", victim);
    center_point = trigger.origin;

    if(isPlayer(victim)) {
      final_damage = default_damage;

      if(trigger.classname == "trigger_radius_fire") {
        if(isDefined(trigger.script_radius)) {
          if(distance2dsquared(victim.origin, trigger.origin) <= squared(trigger.script_radius)) {
            if(isDefined(trigger.script_multiplier) && isnumber(trigger.script_multiplier)) {
              dam_multiplier = trigger.script_multiplier;
            }

            final_damage *= dam_multiplier;
          }
        }
      } else if(isDefined(trigger.target)) {
        struct = getStruct(trigger.target, "targetname");
        center_point = struct.origin;

        if(isDefined(struct.script_radius)) {
          if(distance2dsquared(victim.origin, struct.origin) <= squared(struct.script_radius)) {
            if(isDefined(trigger.script_multiplier) && isnumber(trigger.script_multiplier)) {
              dam_multiplier = trigger.script_multiplier;
            }

            final_damage *= dam_multiplier;
          }
        }
      }
    }

    if(istrue(victim.damageshield)) {
      continue;
    }

    victim do_damage(final_damage, center_point, undefined, undefined, "MOD_FIRE");

    if(final_damage < 6) {
      victim playRumbleOnEntity("damage_light");
    } else {
      victim playRumbleOnEntity("damage_heavy");
    }

    trigger script_delay();
  }
}

function trigger_multiple_fx(trigger) {
  if(trigger.classname == "trigger_multiple_fx_on") {
    bool = &scripts\common\fx::struct_fx_inactive;
    func = &scripts\common\fx::play_struct_fx;
  } else {
    bool = &scripts\common\fx::struct_fx_active;
    func = &scripts\common\fx::stop_struct_fx;
  }

  while(true) {
    trigger waittill("trigger");

    foreach(struct in level.struct_fx) {
      if([[bool]](struct) && is_equal(struct.script_fxgroup, trigger.script_fxgroup)) {
        [[func]](struct);
      }
    }
  }
}

function trigger_outofbounds(trigger, var_aa6a5ebd98bc3b10) {
  trigger.failtrigger = getEnt(trigger.target, "targetname");
  trigger endon("death");
  var_56c37e91e8b85f4d = trigger.spawnflags & 16;
  var_3f697146599a80c4 = function_6cd0a8e23ff14e13("scripted_widget_out_of_bounds");

  while(true) {
    trigger waittill("trigger", other);
    trigger.failtrigger childthread outofbounds_failthread();
    setomnvar("ui_out_of_bounds_countdown", 1);

    if(isDefined(var_3f697146599a80c4)) {
      if(!level.player function_ada0825249682644("scripted_widget_out_of_bounds")) {
        level.player function_90de31b2cbef19f9("scripted_widget_out_of_bounds", var_3f697146599a80c4);
        level.player function_f4c37324750dc183("scripted_widget_out_of_bounds", 0, -190, 1, 1);
        level.player function_af4f62f0f944a8f1("scripted_widget_out_of_bounds", "ReturnToMission");
      }

      fields = [];

      if(isDefined(var_aa6a5ebd98bc3b10)) {
        fields["msg_index"] = getlocstringindex(var_aa6a5ebd98bc3b10);
      }

      fields["countdown"] = 1;
      level.player function_14a0ee2aaf9128c3("scripted_widget_out_of_bounds", fields, 1);
    }

    if(var_56c37e91e8b85f4d && isDefined(other.driver) && other.driver == level.player) {
      ent = other;
    } else {
      ent = level.player;
    }

    while(ent istouching(trigger)) {
      waitframe();
    }

    if(isDefined(var_3f697146599a80c4) && level.player function_a0ae4b54aa48ade2(var_3f697146599a80c4)) {
      level.player function_d28fa5295a04d555("scripted_widget_out_of_bounds", "hide");
    }

    setomnvar("ui_out_of_bounds_countdown", 0);
    trigger.failtrigger notify("stop_failthread");
  }
}

function outofbounds_failthread() {
  self endon("death");
  self endon("stop_failthread");
  self waittill("trigger");
  level.player scripted_widget_destroy("scripted_widget_out_of_bounds");
  setomnvar("ui_out_of_bounds_countdown", 0);
  scripts\sp\player_death::set_custom_death_quote(29);
  missionfailedwrapper();
}