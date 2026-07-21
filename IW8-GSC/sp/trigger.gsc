/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\trigger.gsc
***********************************************/

get_load_trigger_classes() {
  var_0 = [];
  var_0["trigger_multiple_nobloodpool"] = ::trigger_nobloodpool;
  var_0["trigger_multiple_flag_set"] = ::trigger_flag_set;
  var_0["trigger_radius_flag_set"] = ::trigger_flag_set;
  var_0["trigger_multiple_flag_clear"] = ::trigger_flag_clear;
  var_0["trigger_radius_flag_clear"] = ::trigger_flag_clear;
  var_0["trigger_multiple_sun_off"] = ::trigger_sun_off;
  var_0["trigger_multiple_sun_on"] = ::trigger_sun_on;
  var_0["trigger_use_flag_set"] = ::trigger_flag_set;
  var_0["trigger_use_flag_clear"] = ::trigger_flag_clear;
  var_0["trigger_multiple_flag_set_touching"] = ::trigger_flag_set_touching;
  var_0["trigger_multiple_flag_lookat"] = ::trigger_lookat;
  var_0["trigger_multiple_flag_looking"] = ::trigger_looking;
  var_0["trigger_multiple_no_prone"] = ::trigger_no_prone;
  var_0["trigger_multiple_no_crouch_or_prone"] = ::trigger_no_crouch_or_prone;
  var_0["trigger_multiple_compass"] = ::trigger_multiple_compass;
  var_0["trigger_multiple_fx_volume"] = ::trigger_multiple_fx_volume;
  var_0["trigger_multiple_kleenex"] = ::trigger_multiple_kleenex;
  var_0["trigger_multiple_light_sunshadow"] = scripts\sp\lights::sun_shadow_trigger;
  var_0["trigger_multiple_arbitrary_up"] = ::trigger_arbitrary_up;

  if(!scripts\sp\starts::is_no_game_start()) {
    var_0["trigger_multiple_autosave"] = scripts\sp\autosave::trigger_autosave;
    var_0["trigger_multiple_spawn"] = scripts\sp\spawner::trigger_spawner;
    var_0["trigger_multiple_spawn_reinforcement"] = scripts\sp\spawner::trigger_spawner_reinforcement;
    var_0["trigger_multiple_zone_spawn"] = scripts\sp\spawner::trigger_zone_spawn;
  }

  var_0["trigger_multiple_stealth_shadow"] = ::trigger_stealth_shadow;
  var_0["trigger_multiple_slide"] = ::trigger_slide;
  var_0["trigger_multiple_depthoffield"] = ::trigger_multiple_depthoffield;
  var_0["trigger_multiple_tessellationcutoff"] = ::trigger_multiple_tessellationcutoff;
  var_0["trigger_damage_player_flag_set"] = ::trigger_damage_player_flag_set;
  var_0["trigger_multiple_sunflare"] = ::trigger_multiple_sunflare;
  var_0["trigger_multiple_glass_break"] = ::trigger_glass_break;
  var_0["trigger_radius_glass_break"] = ::trigger_glass_break;
  var_0["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
  var_0["trigger_multiple_physics"] = ::trigger_physics;
  var_0["trigger_multiple_fx_watersheeting"] = ::trigger_multiple_fx_watersheeting;
  var_0["trigger_multiple_fakeactor_move"] = scripts\sp\fakeactor::trigger_fakeactor_move;
  var_0["trigger_multiple_fakeactor_node_disable"] = scripts\sp\fakeactor::trigger_fakeactor_node_disable;
  var_0["trigger_multiple_fakeactor_node_enable"] = scripts\sp\fakeactor::trigger_fakeactor_node_enable;
  var_0["trigger_multiple_fakeactor_node_disablegroup"] = scripts\sp\fakeactor::trigger_fakeactor_node_disablegroup;
  var_0["trigger_multiple_fakeactor_node_enablegroup"] = scripts\sp\fakeactor::trigger_fakeactor_node_enablegroup;
  var_0["trigger_multiple_fakeactor_node_passthrough"] = scripts\sp\fakeactor::trigger_fakeactor_node_passthrough;
  var_0["trigger_multiple_fakeactor_node_lock"] = scripts\sp\fakeactor::trigger_fakeactor_node_lock;
  var_0["trigger_multiple_geo_mover"] = scripts\sp\geo_mover::trigger_moveto;
  var_0["trigger_multiple_transient"] = ::trigger_multiple_transient;
  var_0["trigger_multiple_fire"] = ::trigger_fire;
  var_0["trigger_radius_fire"] = ::trigger_fire;
  var_0["trigger_multiple_fx_on"] = ::trigger_multiple_fx;
  var_0["trigger_multiple_fx_off"] = ::trigger_multiple_fx;
  var_0["trigger_multiple_unlock"] = ::trigger_unlock;
  var_0 = scripts\game\sp\trigger::get_load_trigger_classes(var_0);
  return var_0;
}

trigger_multiple_fx_watersheeting(var_0) {
  var_1 = 3;

  if(isDefined(var_0.script_duration))
    var_1 = var_0.script_duration;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_2 setwatersheeting(1, var_1);
      wait(var_1 * 0.2);
    }
  }
}

get_load_trigger_funcs() {
  var_0 = [];
  var_0["friendly_mgTurret"] = scripts\sp\spawner::friendly_mgturret;

  if(!scripts\sp\starts::is_no_game_start()) {
    var_0["camper_spawner"] = scripts\sp\spawner::camper_trigger_think;
    var_0["flood_spawner"] = scripts\sp\spawner::flood_trigger_think;
    var_0["trigger_spawner"] = scripts\sp\spawner::trigger_spawner;
    var_0["trigger_autosave"] = scripts\sp\autosave::trigger_autosave;
    var_0["trigger_spawngroup"] = ::trigger_spawngroup;
    var_0["trigger_vehicle_spline_spawn"] = ::trigger_vehicle_spline_spawn;
    var_0["trigger_vehicle_spawn"] = scripts\sp\spawner::trigger_spawner;
    var_0["random_spawn"] = scripts\sp\spawner::random_spawn;
    var_0["zone_spawn"] = scripts\sp\spawner::trigger_zone_spawn;
  }

  var_0["autosave_now"] = scripts\sp\autosave::autosave_now_trigger;
  var_0["trigger_autosave_tactical"] = scripts\sp\autosave::trigger_autosave_tactical;
  var_0["trigger_autosave_stealth"] = scripts\sp\autosave::trigger_autosave_stealth;
  var_0["trigger_unlock"] = ::trigger_unlock;
  var_0["trigger_lookat"] = ::trigger_lookat;
  var_0["trigger_looking"] = ::trigger_looking;
  var_0["trigger_cansee"] = ::trigger_cansee;
  var_0["flag_set"] = ::trigger_flag_set;
  var_0["flag_set_player"] = ::trigger_flag_set_player;
  var_0["flag_unset"] = ::trigger_flag_clear;
  var_0["flag_clear"] = ::trigger_flag_clear;
  var_0["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
  var_0["radio_trigger"] = ::trigger_radio;
  var_0["trigger_ignore"] = ::trigger_ignore;
  var_0["trigger_pacifist"] = ::trigger_pacifist;
  var_0["trigger_delete"] = ::trigger_turns_off;
  var_0["trigger_delete_on_touch"] = ::trigger_delete_on_touch;
  var_0["trigger_off"] = ::trigger_turns_off;
  var_0["trigger_outdoor"] = scripts\sp\spawner::outdoor_think;
  var_0["trigger_indoor"] = scripts\sp\spawner::indoor_think;
  var_0["trigger_hint"] = ::trigger_hint;
  var_0["trigger_grenade_at_player"] = ::trigger_throw_grenade_at_player;
  var_0["flag_on_cleared"] = ::trigger_flag_on_cleared;
  var_0["flag_set_touching"] = ::trigger_flag_set_touching;
  var_0["delete_link_chain"] = ::trigger_delete_link_chain;
  var_0["trigger_slide"] = ::trigger_slide;
  var_0["trigger_dooropen"] = ::trigger_dooropen;
  var_0["geo_mover"] = scripts\sp\geo_mover::trigger_moveto;
  var_0["out_of_bounds"] = ::trigger_outofbounds;
  var_0["no_crouch_or_prone"] = ::trigger_no_crouch_or_prone;
  var_0["no_prone"] = ::trigger_no_prone;
  var_0 = scripts\game\sp\trigger::get_load_trigger_funcs(var_0);
  return var_0;
}

init_script_triggers() {
  scripts\sp\colors::init_colors();
  scripts\sp\audio::init_audio();
  scripts\engine\utility::array_delete(getEntArray("trigger_multiple_softlanding", "classname"));
  var_0 = get_load_trigger_classes();
  var_1 = get_load_trigger_funcs();

  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    scripts\engine\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = scripts\engine\sp\utility::array_merge(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = scripts\engine\sp\utility::array_merge(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = scripts\engine\sp\utility::array_merge(var_4, var_9);

  if(!scripts\sp\starts::is_no_game_start()) {
    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32)
        thread scripts\sp\spawner::trigger_spawner(var_4[var_10]);
    }
  }

  var_11 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];

  foreach(var_13 in var_11) {
    var_4 = getEntArray(var_13, "code_classname");

    foreach(var_15 in var_4) {
      if(isDefined(var_15.script_flag_true))
        level thread trigger_script_flag_true(var_15);

      if(isDefined(var_15.script_flag_false))
        level thread trigger_script_flag_false(var_15);

      if(isDefined(var_15.script_autosavename) || isDefined(var_15.script_autosave))
        level thread scripts\sp\autosave::autosave_think(var_15);

      if(isDefined(var_15.script_mgturretauto))
        level thread scripts\sp\mgturret::mgturret_auto(var_15);

      if(isDefined(var_15.script_killspawner))
        level thread scripts\sp\spawner::kill_spawner(var_15);

      if(isDefined(var_15.script_kill_vehicle_spawner))
        level thread scripts\common\vehicle_code::vehicle_triggerkillspawner(var_15);

      if(isDefined(var_15.script_emptyspawner))
        level thread scripts\sp\spawner::empty_spawner(var_15);

      if(isDefined(var_15.script_prefab_exploder))
        var_15.script_exploder = var_15.script_prefab_exploder;

      if(isDefined(var_15.script_exploder))
        level thread exploder_load(var_15);

      if(isDefined(var_15.script_triggered_playerseek))
        level thread trigger_playerseek(var_15);

      if(isDefined(var_15.script_bctrigger))
        level thread trigger_battlechatter(var_15);

      if(isDefined(var_15.script_trigger_group))
        var_15 thread trigger_group();

      if(isDefined(var_15.script_random_killspawner))
        level thread scripts\sp\spawner::random_killspawner(var_15);

      if(isDefined(var_15.targetname)) {
        var_16 = var_15.targetname;

        if(isDefined(var_1[var_16]))
          level thread[[var_1[var_16]]](var_15);
      }
    }
  }
}

trigger_createart_transient(var_0) {
  var_1 = 1;

  if(var_1)
    var_0 delete();
}

createart_transient_thread() {}

is_transient_createart_enabled() {
  if(getDvar("LSTTOTKPNP") != "")
    return 1;

  if(getdvarint("scr_art_tweak") > 0)
    return 1;

  if(isDefined(level.start_point) && level.start_point == "no_game")
    return 1;

  return 0;
}

trigger_multiple_transient(var_0) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;

  if(isDefined(var_0.script_transient))
    var_2 = strtok(var_0.script_transient, " ");

  if(isDefined(var_0.script_transient_unload))
    var_3 = strtok(var_0.script_transient_unload, " ");

  if(isDefined(var_0.script_transient_set))
    var_4 = var_0.script_transient_set;

  if(isDefined(var_0.script_transient_unload_set))
    var_5 = 1;

  var_6 = [];
  var_6 = scripts\engine\utility::array_combine(var_2, var_3);

  if(isDefined(var_0.script_transient_set)) {
    var_7 = gettransientsetnames(var_0.script_transient_set);
    var_6 = scripts\engine\utility::array_combine(var_6, var_7);
  }

  foreach(var_9 in var_6) {
    if(!scripts\engine\utility::flag_exist(var_9 + "_loaded"))
      scripts\engine\utility::flag_init(var_9 + "_loaded");
  }

  for(;;) {
    var_0 waittill("trigger");

    if(isDefined(var_3))
      scripts\engine\sp\utility::transient_unload_array(var_3);

    if(isDefined(var_2))
      scripts\engine\sp\utility::transient_load_array(var_2);

    if(isDefined(var_4))
      switchtransientset(var_4);

    if(istrue(var_5))
      switchtransientset("none");
  }
}

trigger_damage_player_flag_set(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);
  }
}

trigger_flag_clear(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_clear(var_1);
  }
}

trigger_flag_on_cleared(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger");
    wait 1;

    if(var_0 found_toucher()) {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set(var_1);
}

found_toucher() {
  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(self))
      return 1;

    wait 0.1;
  }

  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 istouching(self))
      return 1;
  }

  return 0;
}

trigger_flag_set(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);

    if(!isDefined(var_0)) {
      break;
    }
  }
}

trigger_friendly_respawn(var_0) {
  var_0 endon("death");
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for(;;) {
    var_0 waittill("trigger");
    level.respawn_spawner_org = var_2;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

trigger_landingzone(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  if(!isDefined(level.landingzones_active))
    level.landingzones_active = [];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0))
      level.landingzones_active = scripts\engine\utility::array_add(level.landingzones_active, var_0);

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      if(!scripts\engine\utility::flag(var_1))
        thread trigger_landingzone_active(var_1);

      wait 0.25;
    }

    level.landingzones_active = scripts\engine\utility::array_remove(level.landingzones_active, var_0);
  }
}

trigger_landingzone_active(var_0) {
  scripts\engine\utility::flag_set(var_0);

  for(;;) {
    level.landingzones_active = scripts\engine\utility::array_removeundefined(level.landingzones_active);

    if(level.landingzones_active.size == 0) {
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear(var_0);
}

trigger_arbitrary_up(var_0) {
  var_0 setworlduptrigger(1);

  if(isDefined(var_0.target)) {
    var_1 = getEnt(var_0.target, "targetname");
    var_0 enablelinkTo();
    var_0 linkTo(var_1);
  }
}

trigger_flag_set_touching(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\engine\utility::script_delay();

    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0))
      scripts\engine\utility::flag_set(var_1);

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0))
      wait 0.25;

    scripts\engine\utility::flag_clear(var_1);
  }
}

trigger_friendly_stop_respawn(var_0) {
  for(;;) {
    var_0 waittill("trigger");
    scripts\engine\utility::flag_clear("respawn_friendlies");
  }
}

trigger_group() {
  thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, var_0);

  if(self != var_0)
    self delete();
}

trigger_nobloodpool(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    var_1.skipbloodpool = 1;
    var_1 thread set_wait_then_clear_skipbloodpool();
  }
}

set_wait_then_clear_skipbloodpool() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self.skipbloodpool = undefined;
}

trigger_physics(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawnStruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2[var_2.size] = var_6;
    var_5 delete();
  }

  var_0.org = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 scripts\engine\utility::script_delay();

  foreach(var_6 in var_2) {
    var_9 = var_6.radius;
    var_10 = var_6.script_parameters;
    var_11 = var_6.script_damage;

    if(!isDefined(var_9))
      var_9 = 350;

    if(!isDefined(var_10))
      var_10 = 0.25;

    setDvar("tempdvar", var_10);
    var_10 = getdvarfloat("tempdvar");

    if(isDefined(var_11))
      radiusdamage(var_6.origin, var_9, var_11, var_11 * 0.5);

    physicsexplosionsphere(var_6.origin, var_9, var_9 * 0.5, var_10);
  }
}

trigger_playerseek(var_0) {
  var_1 = var_0.script_triggered_playerseek;
  var_0 waittill("trigger");
  var_2 = getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }
    if(isDefined(var_2[var_3].script_triggered_playerseek) && var_2[var_3].script_triggered_playerseek == var_1) {
      var_2[var_3].goalradius = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread scripts\sp\spawner::delayed_player_seek_think(var_2[var_3]);
    }
  }
}

trigger_script_flag_false(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

trigger_script_flag_true(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

add_tokens_to_trigger_flags(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2]))
      level.trigger_flags[var_2] = [];

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

trigger_spawngroup(var_0) {
  waittillframeend;
  var_1 = var_0.script_spawngroup;

  if(!isDefined(level.spawn_group) || !isDefined(level.spawn_groups[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = scripts\engine\utility::random(level.spawn_groups[var_1]);

  foreach(var_5, var_4 in var_2)
  var_4 scripts\engine\sp\utility::spawn_ai();
}

trigger_sun_off(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("MQRQQONQSL") == 0) {
      continue;
    }
    setsaveddvar("MQRQQONQSL", 0);
  }
}

trigger_sun_on(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("MQRQQONQSL") == 1) {
      continue;
    }
    setsaveddvar("MQRQQONQSL", 1);
  }
}

trigger_vehicle_spline_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

get_trigger_targs() {
  var_0 = [];
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_2 = getEntArray(self.target, "targetname");
    var_3 = [];

    foreach(var_5 in var_2) {
      if(var_5.classname == "script_origin")
        var_3[var_3.size] = var_5;

      if(issubstr(var_5.classname, "trigger"))
        var_0[var_0.size] = var_5;
    }

    var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_5 in var_2)
    var_3[var_3.size] = var_5;

    if(var_3.size == 1) {
      var_9 = var_3[0];
      var_1 = var_9.origin;

      if(isDefined(var_9.code_classname))
        var_9 delete();
    }
  }

  var_10 = [];
  var_10["triggers"] = var_0;
  var_10["target_origin"] = var_1;
  return var_10;
}

trigger_lookat(var_0) {
  trigger_lookat_think(var_0, 1);
}

trigger_looking(var_0) {
  trigger_lookat_think(var_0, 0);
}

trigger_lookat_think(var_0, var_1) {
  var_2 = 0.78;

  if(isDefined(var_0.script_dot))
    var_2 = var_0.script_dot;

  var_3 = var_0 get_trigger_targs();
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isDefined(var_0.script_flag) || isDefined(var_0.script_noteworthy);
  var_7 = undefined;

  if(var_6) {
    var_7 = var_0 scripts\engine\sp\utility::get_trigger_flag();

    if(!isDefined(level.flag[var_7]))
      scripts\engine\utility::flag_init(var_7);
  } else if(!var_4.size) {}

  if(var_1 && var_6)
    level endon(var_7);

  var_0 endon("death");
  var_8 = 1;

  if(isDefined(var_0.script_nosight))
    var_8 = var_0.script_nosight;

  for(;;) {
    if(var_6)
      scripts\engine\utility::flag_clear(var_7);

    var_0 waittill("trigger", var_9);
    var_10 = [];

    while(var_9 istouching(var_0)) {
      if(var_8 && !sighttracepassed(var_9 getEye(), var_5, 0, undefined)) {
        if(var_6)
          scripts\engine\utility::flag_clear(var_7);

        wait 0.5;
        continue;
      }

      var_11 = vectorNormalize(var_5 - var_9.origin);
      var_12 = var_9 getplayerangles();
      var_13 = anglesToForward(var_12);
      var_14 = vectordot(var_13, var_11);

      if(var_14 >= var_2) {
        scripts\engine\utility::array_thread(var_4, scripts\engine\utility::send_notify, "trigger");

        if(var_6)
          scripts\engine\utility::flag_set(var_7, var_9);

        if(var_1) {
          return;
        }
        wait 2;
      } else if(var_6)
        scripts\engine\utility::flag_clear(var_7);

      if(var_8) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

trigger_cansee(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = var_0 get_trigger_targs();
  var_1 = var_3["triggers"];
  var_2 = var_3["target_origin"];
  var_4 = isDefined(var_0.script_flag) || isDefined(var_0.script_noteworthy);
  var_5 = undefined;

  if(var_4) {
    var_5 = var_0 scripts\engine\sp\utility::get_trigger_flag();

    if(!isDefined(level.flag[var_5]))
      scripts\engine\utility::flag_init(var_5);
  } else if(!var_1.size) {}

  var_0 endon("death");
  var_6 = 12;
  var_7 = [];
  var_7[var_7.size] = (0, 0, 0);
  var_7[var_7.size] = (var_6, 0, 0);
  var_7[var_7.size] = (var_6 * -1, 0, 0);
  var_7[var_7.size] = (0, var_6, 0);
  var_7[var_7.size] = (0, var_6 * -1, 0);
  var_7[var_7.size] = (0, 0, var_6);

  for(;;) {
    if(var_4)
      scripts\engine\utility::flag_clear(var_5);

    var_0 waittill("trigger", var_8);

    while(level.player istouching(var_0)) {
      if(!var_8 cantraceto(var_2, var_7)) {
        if(var_4)
          scripts\engine\utility::flag_clear(var_5);

        wait 0.1;
        continue;
      }

      if(var_4)
        scripts\engine\utility::flag_set(var_5);

      scripts\engine\utility::array_thread(var_1, scripts\engine\utility::send_notify, "trigger");
      wait 0.5;
    }
  }
}

cantraceto(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self getEye(), var_0 + var_1[var_2], 1, self))
      return 1;
  }

  return 0;
}

trigger_unlock(var_0) {
  var_1 = "not_set";

  if(isDefined(var_0.script_noteworthy))
    var_1 = var_0.script_noteworthy;

  var_2 = getEntArray(var_0.target, "targetname");
  var_0 thread trigger_unlock_death(var_0.target);

  for(;;) {
    scripts\engine\utility::array_thread(var_2, scripts\engine\utility::trigger_off);
    var_0 waittill("trigger");
    scripts\engine\utility::array_thread(var_2, scripts\engine\utility::trigger_on);
    wait_for_an_unlocked_trigger(var_2, var_1);
    scripts\engine\sp\utility::array_notify(var_2, "relock");
  }
}

trigger_unlock_death(var_0) {
  self waittill("death");
  var_1 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\engine\utility::trigger_off);
}

wait_for_an_unlocked_trigger(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnStruct();

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    var_0[var_3] thread report_trigger(var_2, var_1);

  var_2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_1);
}

report_trigger(var_0, var_1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_1);
  self waittill("trigger");
  var_0 notify("trigger");
}

trigger_battlechatter(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");

    if(issubstr(var_2[0].classname, "trigger"))
      var_1 = var_2[0];
  }

  if(isDefined(var_1))
    var_1 waittill("trigger", var_3);
  else
    var_0 waittill("trigger", var_3);

  var_4 = undefined;

  if(isDefined(var_1)) {
    if(var_3.team != level.player.team && level.player istouching(var_0))
      var_4 = level.player scripts\anim\battlechatter.gsc::getclosestfriendlyspeaker("custom");
    else if(var_3.team == level.player.team) {
      var_5 = "axis";

      if(level.player.team == "axis")
        var_5 = "allies";

      var_6 = scripts\anim\battlechatter.gsc::getspeakers("custom", var_5);
      var_6 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_6);

      foreach(var_8 in var_6) {
        if(var_8 istouching(var_0)) {
          var_4 = var_8;

          if(battlechatter_dist_check(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isPlayer(var_3))
    var_4 = var_3 scripts\anim\battlechatter.gsc::getclosestfriendlyspeaker("custom");
  else
    var_4 = var_3;

  if(!isDefined(var_4)) {
    return;
  }
  if(battlechatter_dist_check()) {
    return;
  }
  var_10 = var_4 scripts\engine\sp\utility::custom_battlechatter(var_0.script_bctrigger);

  if(!var_10)
    level scripts\engine\utility::delaythread(0.25, ::trigger_battlechatter, var_0);
  else
    var_0 notify("custom_battlechatter_done");
}

battlechatter_dist_check(var_0) {
  return distancesquared(var_0, level.player getorigin()) <= 262144;
}

trigger_dooropen(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;

  foreach(var_4 in var_1) {
    var_5 = var_2[var_4.script_noteworthy];
    var_4 connectpaths();
    var_4 rotateYaw(var_5, 1, 0, 0.5);
  }
}

trigger_glass_break(var_0) {
  var_1 = getglassarray(var_0.target);

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  for(;;) {
    level waittill("glass_break", var_2);

    if(var_2 istouching(var_0)) {
      var_3 = var_2.origin;
      wait 0.05;
      var_4 = var_2.origin;
      var_5 = undefined;

      if(var_3 != var_4)
        var_5 = var_4 - var_3;

      if(isDefined(var_5)) {
        foreach(var_7 in var_1)
        destroyglass(var_7, var_5);

        break;
      } else {
        foreach(var_7 in var_1)
        destroyglass(var_7);

        break;
      }
    }
  }

  var_0 delete();
}

trigger_delete_link_chain(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0 get_script_linkto_targets();
  scripts\engine\utility::array_thread(var_1, ::delete_links_then_self);
}

get_script_linkto_targets() {
  var_0 = [];

  if(!isDefined(self.script_linkto))
    return var_0;

  var_1 = strtok(self.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getEnt(var_3, "script_linkname");

    if(isDefined(var_4))
      var_0[var_0.size] = var_4;
  }

  return var_0;
}

delete_links_then_self() {
  var_0 = get_script_linkto_targets();
  scripts\engine\utility::array_thread(var_0, ::delete_links_then_self);
  self delete();
}

trigger_throw_grenade_at_player(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  scripts\sp\utility::throwgrenadeatplayerasap();
}

trigger_hint(var_0) {
  if(!isDefined(level.displayed_hints))
    level.displayed_hints = [];

  waittillframeend;
  var_1 = var_0.script_hint;
  var_0 waittill("trigger", var_2);

  if(isDefined(level.displayed_hints[var_1])) {
    return;
  }
  level.displayed_hints[var_1] = 1;
  var_2 scripts\engine\sp\utility::display_hint(var_1);
}

trigger_delete_on_touch(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1))
      var_1 delete();
  }
}

trigger_turns_off(var_0) {
  var_0 waittill("trigger");
  var_0 scripts\engine\utility::trigger_off();

  if(!isDefined(var_0.script_linkto)) {
    return;
  }
  var_1 = strtok(var_0.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    scripts\engine\utility::array_thread(getEntArray(var_1[var_2], "script_linkname"), scripts\engine\utility::trigger_off);
}

trigger_ignore(var_0) {
  thread trigger_runs_function_on_touch(var_0, scripts\engine\sp\utility::set_ignoreme, scripts\engine\sp\utility::get_ignoreme);
}

trigger_pacifist(var_0) {
  thread trigger_runs_function_on_touch(var_0, scripts\engine\sp\utility::set_pacifist, scripts\engine\sp\utility::get_pacifist);
}

trigger_runs_function_on_touch(var_0, var_1, var_2) {
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isalive(var_3)) {
      continue;
    }
    if(var_3[[var_2]]()) {
      continue;
    }
    var_3 thread touched_trigger_runs_func(var_0, var_1);
  }
}

touched_trigger_runs_func(var_0, var_1) {
  self endon("death");
  self.ignoreme = 1;
  [[var_1]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var_0))
    wait 1;

  [[var_1]](0);
}

trigger_radio(var_0) {
  var_0 waittill("trigger");
  scripts\engine\sp\utility::radio_dialogue(var_0.script_noteworthy);
}

trigger_flag_set_player(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var_1);
  }
}

trigger_multiple_sunflare(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_0.script_noteworthy))
      var_1 scripts\sp\art::sunflare_changes(var_0.script_noteworthy, var_0.script_delay);

    waitframe();
  }
}

trigger_multiple_depthoffield(var_0) {
  waittillframeend;

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.script_dof_near_start;
    var_3 = var_0.script_dof_near_end;
    var_4 = var_0.script_dof_near_blur;
    var_5 = var_0.script_dof_far_start;
    var_6 = var_0.script_dof_far_end;
    var_7 = var_0.script_dof_far_blur;
    var_8 = var_0.script_delay;

    if(var_2 != level.dof["base"]["goal"]["nearStart"] || var_3 != level.dof["base"]["goal"]["nearEnd"] || var_4 != level.dof["base"]["goal"]["nearBlur"] || var_5 != level.dof["base"]["goal"]["farStart"] || var_6 != level.dof["base"]["goal"]["farEnd"] || var_7 != level.dof["base"]["goal"]["farBlur"]) {
      scripts\sp\art::dof_set_base(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      wait(var_8);
      continue;
    }

    waitframe();
  }
}

trigger_multiple_tessellationcutoff(var_0) {
  waittillframeend;

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.script_tess_distance;
    var_3 = var_0.script_tess_falloff;
    var_4 = var_0.script_delay;

    if(var_2 != level.tess.cutoff_distance_goal || var_3 != level.tess.cutoff_falloff_goal) {
      var_2 = max(0, var_2);
      var_2 = min(10000, var_2);
      var_3 = max(0, var_3);
      var_3 = min(10000, var_3);
      scripts\sp\art::tess_set_goal(var_2, var_3, var_4);
      continue;
    }

    waitframe();
  }
}

trigger_slide(var_0) {
  setdvarifuninitialized("use_legacy_slide", 0);

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread slidetriggerplayerthink(var_0);
  }
}

slidetriggerplayerthink(var_0) {
  if(isDefined(self.vehicle)) {
    return;
  }
  if(scripts\engine\sp\utility::issliding() || self isjumping()) {
    return;
  }
  if(isDefined(self.player_view)) {
    return;
  }
  self endon("death");

  if(soundexists("SCN_cliffhanger_player_hillslide"))
    self playSound("SCN_cliffhanger_player_hillslide");

  var_1 = undefined;

  if(isDefined(var_0.script_accel))
    var_1 = var_0.script_accel;

  self endon("cancel_sliding");

  if(getdvarint("use_legacy_slide") > 0)
    thread scripts\engine\sp\utility::beginslidinglegacy();
  else
    thread scripts\engine\sp\utility::beginsliding(undefined, var_1);

  for(;;) {
    if(!self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(level.end_slide_delay))
    wait(level.end_slide_delay);

  if(getdvarint("use_legacy_slide") > 0)
    scripts\engine\sp\utility::endslidinglegacy();
  else
    scripts\engine\sp\utility::endsliding();
}

trigger_multiple_fx_volume(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_3 in level.createfxent)
  assign_fx_to_trigger(var_3, var_0, var_1);

  var_1 delete();

  if(!isDefined(var_0.target)) {
    return;
  }
  var_5 = getEntArray(var_0.target, "targetname");
  var_0.fx_on = 1;

  foreach(var_7 in var_5) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        var_7 thread trigger_multiple_fx_trigger_on_think(var_0);
        break;
      case "trigger_multiple_fx_volume_off":
        var_7 thread trigger_multiple_fx_trigger_off_think(var_0);
        break;
      default:
        break;
    }
  }
}

trigger_multiple_fx_trigger_on_think(var_0) {
  for(;;) {
    self waittill("trigger");

    if(!var_0.fx_on)
      scripts\engine\utility::array_thread(var_0.fx, scripts\engine\sp\utility::restarteffect);

    wait 1;
  }
}

trigger_multiple_fx_trigger_off_think(var_0) {
  for(;;) {
    self waittill("trigger");

    if(var_0.fx_on)
      scripts\engine\utility::array_thread(var_0.fx, scripts\engine\utility::pauseeffect);

    wait 1;
  }
}

assign_fx_to_trigger(var_0, var_1, var_2) {
  if(isDefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isDefined(var_0.v["stopable"]) || !var_0.v["stopable"])
      return;
  }

  var_2.origin = var_0.v["origin"];

  if(var_2 istouching(var_1))
    var_1.fx[var_1.fx.size] = var_0;
}

trigger_multiple_compass(var_0) {
  var_1 = var_0.script_parameters;

  if(!isDefined(level.minimap_image))
    level.minimap_image = "";

  for(;;) {
    var_0 waittill("trigger");

    if(level.minimap_image != var_1)
      scripts\sp\compass::setupminimap(var_1);
  }
}

trigger_no_crouch_or_prone(var_0) {
  scripts\engine\utility::array_thread(level.players, ::no_crouch_or_prone_think_for_player, var_0);
}

no_crouch_or_prone_think_for_player(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      var_1 allowcrouch(0);
      wait 0.05;
    }

    var_1 allowprone(1);
    var_1 allowcrouch(1);
  }
}

trigger_no_prone(var_0) {
  scripts\engine\utility::array_thread(level.players, ::no_prone_for_player, var_0);
}

no_prone_for_player(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      wait 0.05;
    }

    var_1 allowprone(1);
  }
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_0 scripts\engine\utility::script_delay())
      wait 4;

    level thread exploder_load(var_0);
    return;
  }

  if(!var_0 scripts\engine\utility::script_delay() && isDefined(var_0.script_exploder_delay))
    wait(var_0.script_exploder_delay);

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

trigger_multiple_kleenex(var_0) {
  if(getdvarint("kleenex") != 1) {
    return;
  }
  var_0 waittill("trigger");
  scripts\engine\sp\utility::kleenex_popup();
}

trigger_stealth_shadow(var_0) {
  var_0 endon("death");
  var_1 = "stealth_in_shadow";

  if(!isDefined(level.trigger_stealth_shadow))
    level.trigger_stealth_shadow = [];

  level.trigger_stealth_shadow[level.trigger_stealth_shadow.size] = var_0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!var_2 scripts\engine\utility::ent_flag_exist(var_1)) {
      continue;
    }
    if(var_2 scripts\engine\utility::ent_flag(var_1)) {
      continue;
    }
    var_2 thread in_shadow_thread(var_0, var_1);
  }
}

in_shadow_thread(var_0, var_1) {
  self endon("death");
  scripts\engine\utility::ent_flag_set(var_1);

  while(isDefined(var_0) && self istouching(var_0))
    wait 0.05;

  scripts\engine\utility::ent_flag_clear(var_1);
}

trigger_fire(var_0) {
  var_0 endon("death");

  if(isDefined(var_0.trigger_fire_endon))
    var_0 endon(var_0.trigger_fire_endon);

  var_1 = 1;
  var_2 = 5;
  var_3 = 0;

  if(!isDefined(var_0.script_delay_min) && !isDefined(var_0.script_delay_max)) {
    var_0.script_delay_min = 0.05;
    var_0.script_delay_max = 0.05;
  }

  if(var_0.script_delay_min == var_0.script_delay_max)
    var_0.script_delay = var_0.script_delay_min;

  if(isDefined(var_0.script_damage))
    var_1 = var_0.script_damage;

  for(;;) {
    var_0 waittill("trigger", var_4);
    var_5 = var_0.origin;

    if(isPlayer(var_4)) {
      var_3 = var_1;

      if(var_0.classname == "trigger_radius_fire") {
        if(isDefined(var_0.script_radius)) {
          if(distance2dsquared(var_4.origin, var_0.origin) <= squared(var_0.script_radius)) {
            if(isDefined(var_0.script_multiplier) && isnumber(var_0.script_multiplier))
              var_2 = var_0.script_multiplier;

            var_3 = var_3 * var_2;
          }
        }
      } else if(isDefined(var_0.target)) {
        var_6 = scripts\engine\utility::getStruct(var_0.target, "targetname");
        var_5 = var_6.origin;

        if(isDefined(var_6.script_radius)) {
          if(distance2dsquared(var_4.origin, var_6.origin) <= squared(var_6.script_radius)) {
            if(isDefined(var_0.script_multiplier) && isnumber(var_0.script_multiplier))
              var_2 = var_0.script_multiplier;

            var_3 = var_3 * var_2;
          }
        }
      }
    }

    if(istrue(var_4.damageshield)) {
      continue;
    }
    var_4 scripts\sp\utility::do_damage(var_3, var_5, undefined, undefined, "MOD_FIRE");

    if(var_3 < 6)
      var_4 playRumbleOnEntity("damage_light");
    else
      var_4 playRumbleOnEntity("damage_heavy");

    var_0 scripts\engine\utility::script_delay();
  }
}

trigger_multiple_fx(var_0) {
  if(var_0.classname == "trigger_multiple_fx_on") {
    var_1 = scripts\common\fx::struct_fx_inactive;
    var_2 = scripts\common\fx::play_struct_fx;
  } else {
    var_1 = scripts\common\fx::struct_fx_active;
    var_2 = scripts\common\fx::stop_struct_fx;
  }

  for(;;) {
    var_0 waittill("trigger");

    foreach(var_4 in level.struct_fx) {
      if([[var_1]](var_4) && scripts\engine\utility::is_equal(var_4.script_fxgroup, var_0.script_fxgroup))
        [[var_2]](var_4);
    }
  }
}

trigger_outofbounds(var_0) {
  var_0.failtrigger = getEnt(var_0.target, "targetname");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");
    var_0.failtrigger childthread outofbounds_failthread();
    setomnvar("ui_out_of_bounds_countdown", 1);

    while(level.player istouching(var_0))
      waitframe();

    setomnvar("ui_out_of_bounds_countdown", 0);
    var_0.failtrigger notify("stop_failthread");
  }
}

outofbounds_failthread() {
  self endon("death");
  self endon("stop_failthread");
  self waittill("trigger");
  setomnvar("ui_out_of_bounds_countdown", 0);
  scripts\sp\player_death::set_custom_death_quote(29);
  scripts\sp\utility::missionfailedwrapper();
}