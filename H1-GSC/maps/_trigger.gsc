/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_trigger.gsc
********************************/

get_load_trigger_classes() {
  var_0 = [];
  var_0["trigger_multiple_nobloodpool"] = ::trigger_nobloodpool;
  var_0["trigger_multiple_flag_set"] = ::trigger_flag_set;
  var_0["trigger_multiple_flag_clear"] = ::trigger_flag_clear;
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
  var_0["trigger_multiple_specialops_flag_set"] = ::trigger_flag_set_specialops;
  var_0["trigger_multiple_fx_volume"] = ::trigger_multiple_fx_volume;
  var_0["trigger_multiple_fx_fxzone"] = ::trigger_flag_set_touching;
  var_0["trigger_multiple_light_sunshadow"] = maps\_lights::sun_shadow_trigger;

  if(!maps\_utility::is_no_game_start()) {
    var_0["trigger_multiple_autosave"] = maps\_autosave::trigger_autosave;
    var_0["trigger_multiple_spawn"] = maps\_spawner::trigger_spawner;
    var_0["trigger_multiple_spawn_reinforcement"] = maps\_spawner::trigger_spawner_reinforcement;
  }

  var_0["trigger_multiple_slide"] = ::trigger_slide;
  var_0["trigger_multiple_statscheckpoint"] = ::trigger_stats;
  var_0["trigger_multiple_fog"] = ::trigger_fog;
  var_0["trigger_multiple_depthoffield"] = ::trigger_multiple_depthoffield;
  var_0["trigger_multiple_tessellationcutoff"] = ::trigger_multiple_tessellationcutoff;
  var_0["trigger_damage_player_flag_set"] = ::trigger_damage_player_flag_set;
  var_0["trigger_multiple_visionset"] = ::trigger_multiple_visionset;
  var_0["trigger_multiple_visionset_touch"] = ::trigger_multiple_visionset_touch;
  var_0["trigger_multiple_sunflare"] = ::trigger_multiple_sunflare;
  var_0["trigger_multiple_glass_break"] = ::trigger_glass_break;
  var_0["trigger_radius_glass_break"] = ::trigger_glass_break;
  var_0["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
  var_0["trigger_multiple_enemy_respawn"] = ::trigger_enemy_respawn;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
  var_0["trigger_multiple_enemy_stop_respawn"] = ::trigger_enemy_stop_respawn;
  var_0["trigger_multiple_physics"] = ::trigger_physics;
  var_0["trigger_multiple_fx_watersheeting"] = ::trigger_multiple_fx_watersheeting;
  var_0["trigger_multiple_fx_wakevolume"] = ::trigger_wakevolume_think;
  var_0["trigger_multiple_fx_fallingwatervolume"] = ::trigger_fallingwatervolume_think;
  var_0["trigger_multiple_interval"] = ::trigger_multiple_interval;
  return var_0;
}

trigger_multiple_fx_watersheeting(var_0) {
  var_1 = 3;

  if(isdefined(var_0.script_duration))
    var_1 = var_0.script_duration;

  for (;;) {
    var_0 waittill("trigger", var_2);

    if(isplayer(var_2)) {
      var_2 setwatersheeting(1, var_1);
      wait(var_1 * 0.2);
    }
  }
}

get_load_trigger_funcs() {
  var_0 = [];
  var_0["friendly_wave"] = maps\_spawner::friendly_wave;
  var_0["friendly_wave_off"] = maps\_spawner::friendly_wave;
  var_0["friendly_mgTurret"] = maps\_spawner::friendly_mgturret;

  if(!maps\_utility::is_no_game_start()) {
    var_0["camper_spawner"] = maps\_spawner::camper_trigger_think;
    var_0["flood_spawner"] = maps\_spawner::flood_trigger_think;
    var_0["trigger_spawner"] = maps\_spawner::trigger_spawner;
    var_0["trigger_autosave"] = maps\_autosave::trigger_autosave;
    var_0["trigger_spawngroup"] = ::trigger_spawngroup;
    var_0["two_stage_spawner"] = maps\_spawner::two_stage_spawner_think;
    var_0["trigger_vehicle_spline_spawn"] = ::trigger_vehicle_spline_spawn;
    var_0["trigger_vehicle_spawn"] = ::trigger_vehicle_spawn;
    var_0["trigger_vehicle_getin_spawn"] = ::trigger_vehicle_getin_spawn;
    var_0["random_spawn"] = maps\_spawner::random_spawn;
  }

  var_0["autosave_now"] = maps\_autosave::autosave_now_trigger;
  var_0["trigger_autosave_tactical"] = maps\_autosave::trigger_autosave_tactical;
  var_0["trigger_autosave_stealth"] = maps\_autosave::trigger_autosave_stealth;
  var_0["trigger_unlock"] = ::trigger_unlock;
  var_0["trigger_lookat"] = ::trigger_lookat;
  var_0["trigger_looking"] = ::trigger_looking;
  var_0["trigger_cansee"] = ::trigger_cansee;
  var_0["autosave_immediate"] = maps\_autosave::trigger_autosave_immediate;
  var_0["flag_set"] = ::trigger_flag_set;

  if(maps\_utility::is_coop())
    var_0["flag_set_coop"] = ::trigger_flag_set_coop;

  var_0["flag_set_player"] = ::trigger_flag_set_player;
  var_0["flag_unset"] = ::trigger_flag_clear;
  var_0["flag_clear"] = ::trigger_flag_clear;
  var_0["objective_event"] = maps\_spawner::objective_event_init;
  var_0["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
  var_0["friendly_respawn_clear"] = ::friendly_respawn_clear;
  var_0["enemy_respawn_trigger"] = ::trigger_enemy_respawn;
  var_0["radio_trigger"] = ::trigger_radio;
  var_0["trigger_ignore"] = ::trigger_ignore;
  var_0["trigger_pacifist"] = ::trigger_pacifist;
  var_0["trigger_delete"] = ::trigger_turns_off;
  var_0["trigger_delete_on_touch"] = ::trigger_delete_on_touch;
  var_0["trigger_off"] = ::trigger_turns_off;
  var_0["trigger_outdoor"] = maps\_spawner::outdoor_think;
  var_0["trigger_indoor"] = maps\_spawner::indoor_think;
  var_0["trigger_hint"] = ::trigger_hint;
  var_0["trigger_grenade_at_player"] = ::trigger_throw_grenade_at_player;
  var_0["flag_on_cleared"] = ::trigger_flag_on_cleared;
  var_0["flag_set_touching"] = ::trigger_flag_set_touching;
  var_0["delete_link_chain"] = ::trigger_delete_link_chain;
  var_0["trigger_fog"] = ::trigger_fog;
  var_0["trigger_slide"] = ::trigger_slide;
  var_0["trigger_stats"] = ::trigger_stats;
  var_0["trigger_dooropen"] = ::trigger_dooropen;
  var_0["no_crouch_or_prone"] = ::trigger_no_crouch_or_prone;
  var_0["no_prone"] = ::trigger_no_prone;
  return var_0;
}

init_script_triggers() {
  var_0 = get_load_trigger_classes();
  var_1 = get_load_trigger_funcs();

  foreach(var_5, var_3 in var_0) {
    var_4 = getentarray(var_5, "classname");
    common_scripts\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getentarray("trigger_multiple", "classname");
  var_7 = getentarray("trigger_radius", "classname");
  var_4 = maps\_utility::array_merge(var_6, var_7);
  var_8 = getentarray("trigger_disk", "classname");
  var_4 = maps\_utility::array_merge(var_4, var_8);
  var_9 = getentarray("trigger_once", "classname");
  var_4 = maps\_utility::array_merge(var_4, var_9);

  if(!maps\_utility::is_no_game_start()) {
    for (var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32)
        thread maps\_spawner::trigger_spawner(var_4[var_10]);
    }
  }

  for (var_11 = 0; var_11 < 7; var_11++) {
    switch (var_11) {
      case 0:
        var_12 = "trigger_multiple";
        break;
      case 1:
        var_12 = "trigger_once";
        break;
      case 2:
        var_12 = "trigger_use";
        break;
      case 3:
        var_12 = "trigger_radius";
        break;
      case 4:
        var_12 = "trigger_lookat";
        break;
      case 5:
        var_12 = "trigger_disk";
        break;
      default:
        var_12 = "trigger_damage";
        break;
    }

    var_4 = getentarray(var_12, "code_classname");

    for (var_10 = 0; var_10 < var_4.size; var_10++) {
      if(isdefined(var_4[var_10].script_flag_true))
        level thread trigger_script_flag_true(var_4[var_10]);

      if(isdefined(var_4[var_10].script_flag_false))
        level thread trigger_script_flag_false(var_4[var_10]);

      if(isdefined(var_4[var_10].script_autosavename) || isdefined(var_4[var_10].script_autosave))
        level thread maps\_autosave::autosavenamethink(var_4[var_10]);

      if(isdefined(var_4[var_10].script_fallback))
        level thread maps\_spawner::fallback_think(var_4[var_10]);

      if(isdefined(var_4[var_10].script_mgturretauto))
        level thread maps\_mgturret::mgturret_auto(var_4[var_10]);

      if(isdefined(var_4[var_10].script_killspawner))
        level thread maps\_spawner::kill_spawner(var_4[var_10]);

      if(isdefined(var_4[var_10].script_kill_vehicle_spawner))
        level thread maps\_vehicle_code::kill_vehicle_spawner(var_4[var_10]);

      if(isdefined(var_4[var_10].script_emptyspawner))
        level thread maps\_spawner::empty_spawner(var_4[var_10]);

      if(isdefined(var_4[var_10].script_prefab_exploder))
        var_4[var_10].script_exploder = var_4[var_10].script_prefab_exploder;

      if(isdefined(var_4[var_10].script_exploder))
        level thread maps\_load::exploder_load(var_4[var_10]);

      if(isdefined(var_4[var_10].ambient))
        var_4[var_10] thread soundscripts\_audio::trigger_multiple_audio_trigger(1);

      if(isdefined(var_4[var_10].script_audio_zones) || isdefined(var_4[var_10].script_audio_enter_msg) || isdefined(var_4[var_10].script_audio_exit_msg) || isdefined(var_4[var_10].script_audio_progress_msg) || isdefined(var_4[var_10].script_audio_enter_func) || isdefined(var_4[var_10].script_audio_exit_func) || isdefined(var_4[var_10].script_audio_progress_func) || isdefined(var_4[var_10].script_audio_point_func) || isdefined(var_4[var_10].script_audio_use_distance_only))
        var_4[var_10] thread soundscripts\_audio::trigger_multiple_audio_trigger();

      if(isdefined(var_4[var_10].script_triggered_playerseek))
        level thread trigger_playerseek(var_4[var_10]);

      if(isdefined(var_4[var_10].script_bctrigger))
        level thread trigger_battlechatter(var_4[var_10]);

      if(isdefined(var_4[var_10].script_trigger_group))
        var_4[var_10] thread trigger_group();

      if(isdefined(var_4[var_10].script_random_killspawner))
        level thread maps\_spawner::random_killspawner(var_4[var_10]);

      if(isdefined(var_4[var_10].script_parameters))
        level thread maps\_colors::init_color_delay_info(var_4[var_10]);

      if(isdefined(var_4[var_10].targetname)) {
        var_13 = var_4[var_10].targetname;

        if(isdefined(var_1[var_13]))
          level thread[[var_1[var_13]]](var_4[var_10]);
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

trigger_damage_player_flag_set(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  for (;;) {
    var_0 waittill("trigger", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(!isplayer(var_2)) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

trigger_flag_clear(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  for (;;) {
    var_0 waittill("trigger");
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_clear(var_1);
  }
}

trigger_flag_on_cleared(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  for (;;) {
    var_0 waittill("trigger");
    wait 1;

    if(var_0 found_toucher()) {
      continue;
    }
    break;
  }

  common_scripts\utility::flag_set(var_1);
}

found_toucher() {
  var_0 = getaiarray("bad_guys");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(self))
      return 1;

    wait 0.1;
  }

  var_0 = getaiarray("bad_guys");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 istouching(self))
      return 1;
  }

  return 0;
}

trigger_flag_set(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  for (;;) {
    var_0 waittill("trigger", var_2);
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

trigger_flag_set_coop(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  var_2 = [];

  for (;;) {
    var_0 waittill("trigger", var_3);

    if(!isplayer(var_3)) {
      continue;
    }
    var_4 = [];
    var_4[var_4.size] = var_3;
    var_2 = maps\_utility::array_merge(var_2, var_4);

    if(var_2.size == level.players.size) {
      break;
    }
  }

  var_0 maps\_utility::script_delay();
  common_scripts\utility::flag_set(var_1);
}

trigger_flag_set_specialops(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  var_0.player_touched_arr = level.players;
  var_0 thread trigger_flag_set_specialops_clear(var_1);

  for (;;) {
    var_0 waittill("trigger", var_2);
    var_0.player_touched_arr = common_scripts\utility::array_remove(var_0.player_touched_arr, var_2);

    if(var_0.player_touched_arr.size) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

trigger_flag_set_specialops_clear(var_0) {
  for (;;) {
    level waittill(var_0);

    if(common_scripts\utility::flag(var_0)) {
      self.player_touched_arr = [];
      continue;
    }

    self.player_touched_arr = level.players;
  }
}

trigger_friendly_respawn(var_0) {
  var_1 = getentarray(var_0.target, "targetname");
  var_2 = var_1[0];
  var_1 = undefined;
  var_2 endon("death");

  for (;;) {
    var_0 waittill("trigger");
    level.respawn_spawner = var_2;
    common_scripts\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

trigger_friendly_respawn_preh1(var_0) {
  var_0 endon("death");
  var_1 = getent(var_0.target, "targetname");
  var_2 = undefined;

  if(isdefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for (;;) {
    var_0 waittill("trigger");
    level.respawn_spawner = var_1;
    common_scripts\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

trigger_friendly_stop_respawn(var_0) {
  for (;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_friendlies");
  }
}

friendly_respawn_clear(var_0) {
  for (;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_friendlies");
    wait 0.5;
  }
}

trigger_enemy_respawn(var_0) {
  var_0 endon("death");
  var_1 = getent(var_0.target, "targetname");
  var_2 = undefined;

  if(isdefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for (;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_set("respawn_enemies");
    wait 0.5;
  }
}

trigger_enemy_stop_respawn(var_0) {
  for (;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_enemies");
  }
}

trigger_flag_set_touching(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  for (;;) {
    var_0 waittill("trigger", var_2);
    var_0 maps\_utility::script_delay();

    if(isalive(var_2) && var_2 istouching(var_0) && isdefined(var_0))
      common_scripts\utility::flag_set(var_1);

    while (isalive(var_2) && var_2 istouching(var_0) && isdefined(var_0))
      wait 0.25;

    common_scripts\utility::flag_clear(var_1);
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
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    var_1.skipbloodpool = 1;
    var_1 thread set_wait_then_clear_skipbloodpool();
  }
}

trigger_multiple_interval(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread trigger_multiple_interval_thread(var_0);
  }
}

trigger_multiple_interval_thread(var_0) {
  if(!isalive(self)) {
    return;
  }
  self endon("death");

  if(isdefined(self.touching_trigger_multiple_interval)) {
    return;
  }
  self.touching_trigger_multiple_interval = 1;
  var_1 = self.interval;
  self.interval = float(var_0.script_parameters);

  while (self istouching(var_0))
    wait 0.05;

  self.interval = var_1;
  self.touching_trigger_multiple_interval = undefined;
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
  var_2 = common_scripts\utility::getstructarray(var_0.target, "targetname");
  var_3 = getentarray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawnstruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2[var_2.size] = var_6;
    var_5 delete();
  }

  var_0.org = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 maps\_utility::script_delay();

  foreach(var_6 in var_2) {
    var_9 = var_6.radius;
    var_10 = var_6.script_parameters;
    var_11 = var_6.script_damage;

    if(!isdefined(var_9))
      var_9 = 350;

    if(!isdefined(var_10))
      var_10 = 0.25;

    setdvar("tempdvar", var_10);
    var_10 = getdvarfloat("tempdvar");

    if(isdefined(var_11))
      radiusdamage(var_6.origin, var_9, var_11, var_11 * 0.5);

    physicsexplosionsphere(var_6.origin, var_9, var_9 * 0.5, var_10);
  }
}

trigger_playerseek(var_0) {
  var_1 = var_0.script_triggered_playerseek;
  var_0 waittill("trigger");
  var_2 = getaiarray();

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }
    if(isdefined(var_2[var_3].script_triggered_playerseek) && var_2[var_3].script_triggered_playerseek == var_1) {
      var_2[var_3].goalradius = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread maps\_spawner::delayed_player_seek_think(var_2[var_3]);
    }
  }
}

trigger_script_flag_false(var_0) {
  var_1 = common_scripts\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 common_scripts\utility::update_trigger_based_on_flags();
}

trigger_script_flag_true(var_0) {
  var_1 = common_scripts\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 common_scripts\utility::update_trigger_based_on_flags();
}

add_tokens_to_trigger_flags(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isdefined(level.trigger_flags[var_2]))
      level.trigger_flags[var_2] = [];

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

trigger_spawngroup(var_0) {
  waittillframeend;
  var_1 = var_0.script_spawngroup;

  if(!isdefined(level.spawn_groups[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = common_scripts\utility::random(level.spawn_groups[var_1]);

  foreach(var_5, var_4 in var_2)
  var_4 maps\_utility::spawn_ai();
}

trigger_sun_off(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }
    setsaveddvar("sm_sunenable", 0);
  }
}

trigger_sun_on(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }
    setsaveddvar("sm_sunenable", 1);
  }
}

trigger_vehicle_getin_spawn(var_0) {
  var_1 = getentarray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = getentarray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      if(!issubstr(var_6.code_classname, "actor")) {
        continue;
      }
      if(!(var_6.spawnflags & 1)) {
        continue;
      }
      var_6.dont_auto_ride = 1;
    }
  }

  var_0 waittill("trigger");
  var_1 = getentarray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, maps\_vehicle_free_drive::spawn_vehicle_and_attach_to_free_path(undefined, 0, 1));
}

trigger_vehicle_spline_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getentarray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread maps\_vehicle_free_drive::spawn_vehicle_and_attach_to_free_path(70);
    wait 0.05;
  }
}

get_trigger_targs() {
  var_0 = [];
  var_1 = undefined;

  if(isdefined(self.target)) {
    var_2 = getentarray(self.target, "targetname");
    var_3 = [];

    foreach(var_5 in var_2) {
      if(var_5.classname == "script_origin")
        var_3[var_3.size] = var_5;

      if(issubstr(var_5.classname, "trigger"))
        var_0[var_0.size] = var_5;
    }

    var_2 = common_scripts\utility::getstructarray(self.target, "targetname");

    foreach(var_5 in var_2)
    var_3[var_3.size] = var_5;

    if(var_3.size == 1) {
      var_9 = var_3[0];
      var_1 = var_9.origin;

      if(isdefined(var_9.code_classname))
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

  if(isdefined(var_0.script_dot))
    var_2 = var_0.script_dot;

  var_3 = var_0 get_trigger_targs();
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isdefined(var_0.script_flag) || isdefined(var_0.script_noteworthy);
  var_7 = undefined;

  if(var_6) {
    var_7 = var_0 maps\_utility::get_trigger_flag();

    if(!isdefined(level.flag[var_7]))
      common_scripts\utility::flag_init(var_7);
  } else if(!var_4.size) {}

  if(var_1 && var_6)
    level endon(var_7);

  var_0 endon("death");
  var_8 = 1;

  if(isdefined(var_0.script_parameters))
    var_8 = !issubstr(var_0.script_parameters, "no_sight");

  for (;;) {
    if(var_6)
      common_scripts\utility::flag_clear(var_7);

    var_0 waittill("trigger", var_9);
    var_10 = [];

    while (var_9 istouching(var_0)) {
      if(var_8 && !sighttracepassed(var_9 geteye(), var_5, 0, undefined)) {
        if(var_6)
          common_scripts\utility::flag_clear(var_7);

        wait 0.5;
        continue;
      }

      var_11 = vectornormalize(var_5 - var_9.origin);
      var_12 = var_9 getplayerangles();
      var_13 = anglestoforward(var_12);
      var_14 = vectordot(var_13, var_11);

      if(var_14 >= var_2) {
        common_scripts\utility::array_thread(var_4, maps\_utility::send_notify, "trigger");

        if(var_6)
          common_scripts\utility::flag_set(var_7, var_9);

        if(var_1) {
          return;
        }
        wait 2;
      } else if(var_6)
        common_scripts\utility::flag_clear(var_7);

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
  var_4 = isdefined(var_0.script_flag) || isdefined(var_0.script_noteworthy);
  var_5 = undefined;

  if(var_4) {
    var_5 = var_0 maps\_utility::get_trigger_flag();

    if(!isdefined(level.flag[var_5]))
      common_scripts\utility::flag_init(var_5);
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

  for (;;) {
    if(var_4)
      common_scripts\utility::flag_clear(var_5);

    var_0 waittill("trigger", var_8);

    while (level.player istouching(var_0)) {
      if(!var_8 cantraceto(var_2, var_7)) {
        if(var_4)
          common_scripts\utility::flag_clear(var_5);

        wait 0.1;
        continue;
      }

      if(var_4)
        common_scripts\utility::flag_set(var_5);

      common_scripts\utility::array_thread(var_1, maps\_utility::send_notify, "trigger");
      wait 0.5;
    }
  }
}

cantraceto(var_0, var_1) {
  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self geteye(), var_0 + var_1[var_2], 1, self))
      return 1;
  }

  return 0;
}

trigger_unlock(var_0) {
  var_1 = "not_set";

  if(isdefined(var_0.script_noteworthy))
    var_1 = var_0.script_noteworthy;

  var_2 = getentarray(var_0.target, "targetname");
  var_0 thread trigger_unlock_death(var_0.target);

  for (;;) {
    common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_off);
    var_0 waittill("trigger");
    common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_on);
    wait_for_an_unlocked_trigger(var_2, var_1);
    maps\_utility::array_notify(var_2, "relock");
  }
}

trigger_unlock_death(var_0) {
  self waittill("death");
  var_1 = getentarray(var_0, "targetname");
  common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
}

wait_for_an_unlocked_trigger(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnstruct();

  for (var_3 = 0; var_3 < var_0.size; var_3++)
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

  if(isdefined(var_0.target)) {
    var_2 = getentarray(var_0.target, "targetname");

    if(issubstr(var_2[0].classname, "trigger"))
      var_1 = var_2[0];
  }

  if(isdefined(var_1))
    var_1 waittill("trigger", var_3);
  else
    var_0 waittill("trigger", var_3);

  var_4 = undefined;

  if(isdefined(var_1)) {
    if(var_3.team != level.player.team && level.player istouching(var_0))
      var_4 = level.player animscripts\battlechatter::getclosestfriendlyspeaker("custom");
    else if(var_3.team == level.player.team) {
      var_5 = "axis";

      if(level.player.team == "axis")
        var_5 = "allies";

      var_6 = animscripts\battlechatter::getspeakers("custom", var_5);
      var_6 = common_scripts\utility::get_array_of_farthest(level.player.origin, var_6);

      foreach(var_8 in var_6) {
        if(var_8 istouching(var_0)) {
          var_4 = var_8;

          if(battlechatter_dist_check(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isplayer(var_3))
    var_4 = var_3 animscripts\battlechatter::getclosestfriendlyspeaker("custom");
  else
    var_4 = var_3;

  if(!isdefined(var_4)) {
    return;
  }
  if(battlechatter_dist_check(var_4.origin)) {
    return;
  }
  var_4 maps\_utility::custom_battlechatter(var_0.script_bctrigger);
}

battlechatter_dist_check(var_0) {
  return distancesquared(var_0, level.player getorigin()) <= 262144;
}

trigger_vehicle_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getentarray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.05;
  }
}

trigger_dooropen(var_0) {
  var_0 waittill("trigger");
  var_1 = getentarray(var_0.target, "targetname");
  var_2 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;

  foreach(var_4 in var_1) {
    var_5 = var_2[var_4.script_noteworthy];
    var_4 connectpaths();
    var_4 rotateyaw(var_5, 1, 0, 0.5);
  }
}

trigger_glass_break(var_0) {
  var_1 = getglassarray(var_0.target);

  if(!isdefined(var_1) || var_1.size == 0) {
    return;
  }
  for (;;) {
    level waittill("glass_break", var_2);

    if(var_2 istouching(var_0)) {
      var_3 = var_2.origin;
      wait 0.05;
      var_4 = var_2.origin;
      var_5 = undefined;

      if(var_3 != var_4)
        var_5 = var_4 - var_3;

      if(isdefined(var_5)) {
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
  common_scripts\utility::array_thread(var_1, ::delete_links_then_self);
}

get_script_linkto_targets() {
  var_0 = [];

  if(!isdefined(self.script_linkto))
    return var_0;

  var_1 = strtok(self.script_linkto, " ");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getent(var_3, "script_linkname");

    if(isdefined(var_4))
      var_0[var_0.size] = var_4;
  }

  return var_0;
}

delete_links_then_self() {
  var_0 = get_script_linkto_targets();
  common_scripts\utility::array_thread(var_0, ::delete_links_then_self);
  self delete();
}

trigger_throw_grenade_at_player(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  maps\_utility::throwgrenadeatplayerasap();
}

trigger_hint(var_0) {
  if(maps\_utility::is_no_game_start()) {
    return;
  }
  if(!isdefined(level.displayed_hints))
    level.displayed_hints = [];

  waittillframeend;
  var_1 = var_0.script_hint;
  var_0 waittill("trigger", var_2);

  if(isdefined(level.displayed_hints[var_1])) {
    return;
  }
  level.displayed_hints[var_1] = 1;
  var_2 maps\_utility::display_hint(var_1);
}

trigger_delete_on_touch(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(isdefined(var_1))
      var_1 delete();
  }
}

trigger_turns_off(var_0) {
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();

  if(!isdefined(var_0.script_linkto)) {
    return;
  }
  var_1 = strtok(var_0.script_linkto, " ");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    common_scripts\utility::array_thread(getentarray(var_1[var_2], "script_linkname"), common_scripts\utility::trigger_off);
}

trigger_ignore(var_0) {
  thread trigger_runs_function_on_touch(var_0, maps\_utility::set_ignoreme, maps\_utility::get_ignoreme);
}

trigger_pacifist(var_0) {
  thread trigger_runs_function_on_touch(var_0, maps\_utility::set_pacifist, maps\_utility::get_pacifist);
}

trigger_runs_function_on_touch(var_0, var_1, var_2) {
  for (;;) {
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

  while (self istouching(var_0))
    wait 1;

  [[var_1]](0);
}

trigger_radio(var_0) {
  var_0 waittill("trigger");
  maps\_utility::radio_dialogue(var_0.script_noteworthy);
}

trigger_flag_set_player(var_0) {
  if(maps\_utility::is_coop()) {
    thread trigger_flag_set_coop(var_0);
    return;
  }

  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isdefined(level.flag[var_1]))
    common_scripts\utility::flag_init(var_1);

  for (;;) {
    var_0 waittill("trigger", var_2);

    if(!isplayer(var_2)) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1);
  }
}

trigger_multiple_sunflare(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);
    var_1 maps\_art::sunflare_changes(var_0.script_visionset, var_0.script_delay);
    waitframe();
  }
}

trigger_multiple_visionset_preh1(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(isdefined(var_0.script_visionset_start) && isdefined(var_0.script_visionset_end)) {
    var_1 = 1;
    var_3 = getent(var_0.target, "targetname");

    if(!isdefined(var_3))
      var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");

    var_4 = getent(var_3.target, "targetname");

    if(!isdefined(var_4))
      var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");

    var_3 = var_3.origin;
    var_4 = var_4.origin;
    var_2 = distance(var_3, var_4);
    var_0 init_visionset_progress_trigger();
  }

  var_5 = -1;

  for (;;) {
    var_0 waittill("trigger", var_6);

    if(isplayer(var_6)) {
      if(var_1) {
        var_7 = 0;

        while (var_6 istouching(var_0)) {
          var_7 = maps\_utility::get_progress(var_3, var_4, var_6.origin, var_2);
          var_7 = clamp(var_7, 0, 1);

          if(var_7 != var_5) {
            var_5 = var_7;
            var_6 vision_set_fog_progress(var_0, var_7);
          }

          wait 0.05;
        }

        if(var_7 < 0.5)
          var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset_start, var_0.script_delay);
        else
          var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset_end, var_0.script_delay);

        continue;
      }

      var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset, var_0.script_delay);
    }
  }
}

trigger_multiple_visionset(var_0, var_1) {
  var_0.visionset_trigger_id = var_0 get_new_visionset_trigger_id();
  var_2 = 0;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(!isdefined(level.default_visionset))
    level.default_visionset = level.script;

  if(!isdefined(level.default_lightset))
    level.default_lightset = level.script;

  if(!isdefined(level.default_clut))
    level.default_clut = level.script;

  if(isdefined(var_0.script_visionset)) {}

  if(isdefined(var_0.script_clut)) {}

  if(isdefined(var_0.script_visionset_start) && isdefined(var_0.script_visionset_end)) {
    var_3 = 1;
    var_5 = getent(var_0.target, "targetname");

    if(!isdefined(var_5))
      var_5 = common_scripts\utility::getstruct(var_0.target, "targetname");

    var_6 = getent(var_5.target, "targetname");

    if(!isdefined(var_6))
      var_6 = common_scripts\utility::getstruct(var_5.target, "targetname");

    var_5 = var_5.origin;
    var_6 = var_6.origin;
    var_4 = distance(var_5, var_6);
    var_0 init_visionset_progress_trigger();
  }

  for (;;) {
    var_0 waittill("trigger", var_7);

    if(var_7 != level.player) {
      continue;
    }
    level.player.current_visionset_trigger_id = var_0.visionset_trigger_id;
    var_8 = -1;

    for (;;) {
      if(level.player istouching(var_0)) {
        if(!var_2) {
          var_2 = 1;

          if(var_3) {
            var_9 = 0;

            while (level.player istouching(var_0)) {
              var_9 = maps\_utility::get_progress(var_5, var_6, level.player.origin, var_4);
              var_9 = clamp(var_9, 0, 1);

              if(var_9 != var_8) {
                var_8 = var_9;
                level.player vision_set_fog_progress(var_0, var_9);
              }

              wait 0.05;
            }
          } else if(isdefined(var_0.script_visionset))
            level.player maps\_utility::vision_set_fog_changes(var_0.script_visionset, var_0.script_delay);

          if(isdefined(var_0.script_lightset))
            level.player maps\_utility::set_light_set_player(var_0.script_lightset);

          if(isdefined(var_0.script_clut))
            level.player setclutforplayer(var_0.script_clut, var_0.script_delay);
        }
      } else {
        if(var_2) {
          var_2 = 0;

          if(isdefined(var_1) && var_1) {
            if(var_3 && can_reset_vision_type(var_0, "visionset")) {
              if(var_8 < 0.5)
                level.player maps\_utility::vision_set_fog_changes(var_0.script_visionset_start, var_0.script_delay);
              else
                level.player maps\_utility::vision_set_fog_changes(var_0.script_visionset_end, var_0.script_delay);
            } else if(isdefined(var_0.script_visionset) && can_reset_vision_type(var_0, "visionset"))
              level.player maps\_utility::vision_set_fog_changes(level.default_visionset, var_0.script_delay);

            if(isdefined(var_0.script_lightset) && can_reset_vision_type(var_0, "lightset"))
              level.player maps\_utility::set_light_set_player(level.default_lightset);

            if(isdefined(var_0.script_clut) && can_reset_vision_type(var_0, "clut"))
              level.player setclutforplayer(level.default_clut, var_0.script_delay);
          }
        }

        break;
      }

      wait 0.05;
    }
  }
}

trigger_multiple_visionset_touch(var_0) {
  trigger_multiple_visionset(var_0, 1);
}

get_new_visionset_trigger_id() {
  if(!isdefined(level.visionset_trigger_count))
    level.visionset_trigger_count = 0;

  level.visionset_trigger_count++;
  return level.visionset_trigger_count;
}

get_visionset_trigger(var_0) {
  if(!isdefined(var_0))
    return undefined;

  var_1 = getentarray("trigger_multiple_visionset", "classname");
  var_1 = common_scripts\utility::array_combine(var_1, getentarray("trigger_multiple_visionset_touch", "classname"));

  foreach(var_3 in var_1) {
    if(isdefined(var_3.visionset_trigger_id) && var_3.visionset_trigger_id == var_0)
      return var_3;
  }

  return undefined;
}

can_reset_vision_type(var_0, var_1) {
  var_2 = get_visionset_trigger(level.player.current_visionset_trigger_id);

  if(!isdefined(var_2))
    return 1;

  if(isdefined(var_2) && var_2 == var_0)
    return 1;

  if(var_1 == "visionset")
    return !isdefined(var_2.script_visionset);
  else if(var_1 == "lightset")
    return !isdefined(var_2.script_lightset);
  else if(var_1 == "clut")
    return !isdefined(var_2.script_clut);

  return 0;
}

init_visionset_progress_trigger() {
  if(!isdefined(self.script_delay))
    self.script_delay = 2;

  var_0 = maps\_utility::get_vision_set_fog(self.script_visionset_start);
  var_1 = maps\_utility::get_vision_set_fog(self.script_visionset_end);

  if(!isdefined(var_0) || !isdefined(var_1)) {
    return;
  }
  var_2 = spawnstruct();
  var_2.startdist = var_1.startdist - var_0.startdist;
  var_2.halfwaydist = var_1.halfwaydist - var_0.halfwaydist;
  var_2.red = var_1.red - var_0.red;
  var_2.blue = var_1.blue - var_0.blue;
  var_2.green = var_1.green - var_0.green;
  var_2.hdrcolorintensity = var_1.hdrcolorintensity - var_0.hdrcolorintensity;
  var_2.maxopacity = var_1.maxopacity - var_0.maxopacity;
  var_2.sunfogenabled = isdefined(var_0.sunfogenabled) && var_0.sunfogenabled || isdefined(var_1.sunfogenabled) && var_1.sunfogenabled;
  var_2.hdrsuncolorintensity = var_1.hdrsuncolorintensity - var_0.hdrsuncolorintensity;
  var_2.skyfogintensity = var_1.skyfogintensity - var_0.skyfogintensity;
  var_2.skyfogminangle = var_1.skyfogminangle - var_0.skyfogminangle;
  var_2.skyfogmaxangle = var_1.skyfogmaxangle - var_0.skyfogmaxangle;
  var_3 = 0;

  if(isdefined(var_0.sunred))
    var_3 = var_0.sunred;

  var_4 = 0;

  if(isdefined(var_1.sunred))
    var_4 = var_1.sunred;

  var_2.sunred_start = var_3;
  var_2.sunred = var_4 - var_3;
  var_5 = 0;

  if(isdefined(var_0.sungreen))
    var_5 = var_0.sungreen;

  var_6 = 0;

  if(isdefined(var_1.sungreen))
    var_6 = var_1.sungreen;

  var_2.sungreen_start = var_5;
  var_2.sungreen = var_6 - var_5;
  var_7 = 0;

  if(isdefined(var_0.sunblue))
    var_7 = var_0.sunblue;

  var_8 = 0;

  if(isdefined(var_1.sunblue))
    var_8 = var_1.sunblue;

  var_2.sunblue_start = var_7;
  var_2.sunblue = var_8 - var_7;
  var_9 = (0, 0, 0);

  if(isdefined(var_0.sundir))
    var_9 = var_0.sundir;

  var_10 = (0, 0, 0);

  if(isdefined(var_1.sundir))
    var_10 = var_1.sundir;

  var_2.sundir_start = var_9;
  var_2.sundir = var_10 - var_9;
  var_11 = 0;

  if(isdefined(var_0.sunbeginfadeangle))
    var_11 = var_0.sunbeginfadeangle;

  var_12 = 0;

  if(isdefined(var_1.sunbeginfadeangle))
    var_12 = var_1.sunbeginfadeangle;

  var_2.sunbeginfadeangle_start = var_11;
  var_2.sunbeginfadeangle = var_12 - var_11;
  var_13 = 0;

  if(isdefined(var_0.sunendfadeangle))
    var_13 = var_0.sunendfadeangle;

  var_14 = 0;

  if(isdefined(var_1.sunendfadeangle))
    var_14 = var_1.sunendfadeangle;

  var_2.sunendfadeangle_start = var_13;
  var_2.sunendfadeangle = var_14 - var_13;
  var_15 = 0;

  if(isdefined(var_0.normalfogscale))
    var_15 = var_0.normalfogscale;

  var_16 = 0;

  if(isdefined(var_1.normalfogscale))
    var_16 = var_1.normalfogscale;

  var_2.normalfogscale_start = var_15;
  var_2.normalfogscale = var_16 - var_15;

  if(isdefined(var_0.atmosfogenabled) && isdefined(var_1.atmosfogenabled)) {
    var_2.atmosfogenabled = var_0.atmosfogenabled;
    var_2.atmosfogsunfogcolor = var_1.atmosfogsunfogcolor - var_0.atmosfogsunfogcolor;
    var_2.atmosfoghazecolor = var_1.atmosfoghazecolor - var_0.atmosfoghazecolor;
    var_2.atmosfoghazestrength = var_1.atmosfoghazestrength - var_0.atmosfoghazestrength;
    var_2.atmosfoghazespread = var_1.atmosfoghazespread - var_0.atmosfoghazespread;
    var_2.atmosfogextinctionstrength = var_1.atmosfogextinctionstrength - var_0.atmosfogextinctionstrength;
    var_2.atmosfoginscatterstrength = var_1.atmosfoginscatterstrength - var_0.atmosfoginscatterstrength;
    var_2.atmosfoghalfplanedistance = var_1.atmosfoghalfplanedistance - var_0.atmosfoghalfplanedistance;
    var_2.atmosfogstartdistance = var_1.atmosfogstartdistance - var_0.atmosfogstartdistance;
    var_2.atmosfogdistancescale = var_1.atmosfogdistancescale - var_0.atmosfogdistancescale;
    var_2.atmosfogskydistance = var_1.atmosfogskydistance - var_0.atmosfogskydistance;
    var_2.atmosfogskyangularfalloffenabled = var_1.atmosfogskyangularfalloffenabled - var_0.atmosfogskyangularfalloffenabled;
    var_2.atmosfogskyfalloffstartangle = var_1.atmosfogskyfalloffstartangle - var_0.atmosfogskyfalloffstartangle;
    var_2.atmosfogskyfalloffanglerange = var_1.atmosfogskyfalloffanglerange - var_0.atmosfogskyfalloffanglerange;
    var_2.atmosfogsundirection = var_1.atmosfogsundirection - var_0.atmosfogsundirection;
    var_2.atmosfogheightfogenabled = var_1.atmosfogheightfogenabled - var_0.atmosfogheightfogenabled;
    var_2.atmosfogheightfogbaseheight = var_1.atmosfogheightfogbaseheight - var_0.atmosfogheightfogbaseheight;
    var_2.atmosfogheightfoghalfplanedistance = var_1.atmosfogheightfoghalfplanedistance - var_0.atmosfogheightfoghalfplanedistance;
  }

  self.visionset_diff = var_2;
}

vision_set_fog_progress(var_0, var_1) {
  maps\_utility::init_self_visionset();
  var_0 init_visionset_progress_trigger();

  if(var_1 < 0.5)
    self.vision_set_transition_ent.vision_set = var_0.script_visionset_start;
  else
    self.vision_set_transition_ent.vision_set = var_0.script_visionset_end;

  self.vision_set_transition_ent.time = 0;

  if(var_0.script_visionset_start == var_0.script_visionset_end) {
    return;
  }
  level.lvl_visionset = var_0.script_visionset_end;

  if(!level.vision_cheat_enabled)
    self visionsetnakedforplayer_lerp(var_0.script_visionset_start, var_0.script_visionset_end, var_1);

  var_2 = maps\_utility::get_vision_set_fog(var_0.script_visionset_start);
  var_3 = maps\_utility::get_vision_set_fog(var_0.script_visionset_end);
  var_4 = var_0.visionset_diff;
  var_5 = spawnstruct();
  var_5.startdist = var_2.startdist + var_4.startdist * var_1;
  var_5.halfwaydist = var_2.halfwaydist + var_4.halfwaydist * var_1;
  var_5.halfwaydist = max(1, var_5.halfwaydist);
  var_5.red = var_2.red + var_4.red * var_1;
  var_5.green = var_2.green + var_4.green * var_1;
  var_5.blue = var_2.blue + var_4.blue * var_1;
  var_5.hdrcolorintensity = var_2.hdrcolorintensity + var_4.hdrcolorintensity * var_1;
  var_5.maxopacity = var_2.maxopacity + var_4.maxopacity * var_1;
  var_5.skyfogintensity = var_2.skyfogintensity + var_4.skyfogintensity * var_1;
  var_5.skyfogminangle = var_2.skyfogminangle + var_4.skyfogminangle * var_1;
  var_5.skyfogmaxangle = var_2.skyfogmaxangle + var_4.skyfogmaxangle * var_1;

  if(var_4.sunfogenabled) {
    var_5.sunfogenabled = 1;
    var_5.sunred = var_4.sunred_start + var_4.sunred * var_1;
    var_5.sungreen = var_4.sungreen_start + var_4.sungreen * var_1;
    var_5.sunblue = var_4.sunblue_start + var_4.sunblue * var_1;
    var_5.hdrsuncolorintensity = var_2.hdrsuncolorintensity + var_4.hdrsuncolorintensity * var_1;
    var_5.sundir = var_4.sundir_start + var_4.sundir * var_1;
    var_5.sunbeginfadeangle = var_4.sunbeginfadeangle_start + var_4.sunbeginfadeangle * var_1;
    var_5.sunendfadeangle = var_4.sunendfadeangle_start + var_4.sunendfadeangle * var_1;
    var_5.normalfogscale = var_4.normalfogscale_start + var_4.normalfogscale * var_1;
  }

  if(isdefined(var_4.atmosfogenabled)) {
    var_5.atmosfogenabled = var_4.atmosfogenabled;
    var_5.atmosfogsunfogcolor = var_2.atmosfogsunfogcolor + var_4.atmosfogsunfogcolor * var_1;
    var_5.atmosfoghazecolor = var_2.atmosfoghazecolor + var_4.atmosfoghazecolor * var_1;
    var_5.atmosfoghazestrength = var_2.atmosfoghazestrength + var_4.atmosfoghazestrength * var_1;
    var_5.atmosfoghazespread = var_2.atmosfoghazespread + var_4.atmosfoghazespread * var_1;
    var_5.atmosfogextinctionstrength = var_2.atmosfogextinctionstrength + var_4.atmosfogextinctionstrength * var_1;
    var_5.atmosfoginscatterstrength = var_2.atmosfoginscatterstrength + var_4.atmosfoginscatterstrength * var_1;
    var_5.atmosfoghalfplanedistance = var_2.atmosfoghalfplanedistance + var_4.atmosfoghalfplanedistance * var_1;
    var_5.atmosfogstartdistance = var_2.atmosfogstartdistance + var_4.atmosfogstartdistance * var_1;
    var_5.atmosfogdistancescale = var_2.atmosfogdistancescale + var_4.atmosfogdistancescale * var_1;
    var_5.atmosfogskydistance = var_2.atmosfogskydistance + var_4.atmosfogskydistance * var_1;
    var_5.atmosfogskyangularfalloffenabled = int(var_2.atmosfogskyangularfalloffenabled + var_4.atmosfogskyangularfalloffenabled * var_1);
    var_5.atmosfogskyfalloffstartangle = var_2.atmosfogskyfalloffstartangle + var_4.atmosfogskyfalloffstartangle * var_1;
    var_5.atmosfogskyfalloffanglerange = var_2.atmosfogskyfalloffanglerange + var_4.atmosfogskyfalloffanglerange * var_1;
    var_5.atmosfogsundirection = var_2.atmosfogsundirection + var_4.atmosfogsundirection * var_1;
    var_5.atmosfogheightfogenabled = int(var_2.atmosfogheightfogenabled + var_4.atmosfogheightfogenabled * var_1);
    var_5.atmosfogheightfogbaseheight = var_2.atmosfogheightfogbaseheight + var_4.atmosfogheightfogbaseheight * var_1;
    var_5.atmosfogheightfoghalfplanedistance = var_2.atmosfogheightfoghalfplanedistance + var_4.atmosfogheightfoghalfplanedistance * var_1;
  }

  common_scripts\utility::set_fog_to_ent_values(var_5, 0.05);
}

trigger_fog(var_0) {
  if(isdefined(var_0.script_fogset_start) && isdefined(var_0.script_fogset_end)) {
    trigger_fog_preh1(var_0);
    return;
  }

  var_1 = getent(var_0.target, "targetname");
  var_2 = var_1.origin;
  var_3 = undefined;

  if(isdefined(var_1.target)) {
    var_4 = getent(var_1.target, "targetname");
    var_3 = var_4.origin;
  } else
    var_3 = var_2 + common_scripts\utility::vectorscale(var_0.origin - var_2, 2);

  var_5 = distance(var_2, var_3);

  for (;;) {
    var_0 waittill("trigger", var_6);
    var_7 = undefined;

    while (level.player istouching(var_0)) {
      var_7 = maps\_utility::get_progress(var_2, var_3, level.player.origin, var_5);

      if(var_7 < 0)
        var_7 = 0;

      if(var_7 > 1)
        var_7 = 1;

      var_0 maps\_art::set_fog_progress(var_7);
      wait 0.05;
    }

    if(var_7 > 0.5)
      var_7 = 1;
    else
      var_7 = 0;

    var_0 maps\_art::set_fog_progress(var_7);
  }
}

trigger_fog_preh1(var_0) {
  waittillframeend;
  var_1 = var_0.script_fogset_start;
  var_2 = var_0.script_fogset_end;
  var_0.sunfog_enabled = 0;

  if(isdefined(var_1) && isdefined(var_2)) {
    var_3 = maps\_utility::get_fog(var_1);
    var_4 = maps\_utility::get_fog(var_2);
    var_0.sunfog_enabled = isdefined(var_3.sunred) || isdefined(var_4.sunred);
    var_0.start_neardist = var_3.startdist;
    var_0.start_fardist = var_3.halfwaydist;
    var_0.start_color = (var_3.red, var_3.green, var_3.blue);
    var_0.start_hdrcolorintensity = var_3.hdrcolorintensity;
    var_0.start_opacity = var_3.maxopacity;
    var_0.start_skyfogintensity = var_3.skyfogintensity;
    var_0.start_skyfogminangle = var_3.skyfogminangle;
    var_0.start_skyfogmaxangle = var_3.skyfogmaxangle;

    if(isdefined(var_3.sunred)) {
      var_0.start_suncolor = (var_3.sunred, var_3.sungreen, var_3.sunblue);
      var_0.start_hdrsuncolorintensity = var_3.hdrsuncolorintensity;
      var_0.start_sundir = var_3.sundir;
      var_0.start_sunbeginfadeangle = var_3.sunbeginfadeangle;
      var_0.start_sunendfadeangle = var_3.sunendfadeangle;
      var_0.start_sunfogscale = var_3.normalfogscale;
    } else if(var_0.sunfog_enabled) {
      var_0.start_suncolor = var_0.start_color;
      var_0.start_hdrsuncolorintensity = 1;
      var_0.start_sundir = (0, 0, 0);
      var_0.start_sunbeginfadeangle = 0;
      var_0.start_sunendfadeangle = 90;
      var_0.start_sunfogscale = 1;
    }

    var_0.end_neardist = var_4.startdist;
    var_0.end_fardist = var_4.halfwaydist;
    var_0.end_color = (var_4.red, var_4.green, var_4.blue);
    var_0.end_hdrcolorintensity = var_4.hdrcolorintensity;
    var_0.end_opacity = var_4.maxopacity;
    var_0.end_skyfogintensity = var_4.skyfogintensity;
    var_0.end_skyfogminangle = var_4.skyfogminangle;
    var_0.end_skyfogmaxangle = var_4.skyfogmaxangle;

    if(isdefined(var_4.sunred)) {
      var_0.end_suncolor = (var_4.sunred, var_4.sungreen, var_4.sunblue);
      var_0.end_hdrsuncolorintensity = var_4.hdrsuncolorintensity;
      var_0.end_sundir = var_4.sundir;
      var_0.end_sunbeginfadeangle = var_4.sunbeginfadeangle;
      var_0.end_sunendfadeangle = var_4.sunendfadeangle;
      var_0.end_sunfogscale = var_4.normalfogscale;
    } else if(var_0.sunfog_enabled) {
      var_0.end_suncolor = var_0.end_color;
      var_0.end_hdrsuncolorintensity = 1;
      var_0.end_sundir = (0, 0, 0);
      var_0.end_sunbeginfadeangle = 0;
      var_0.end_sunendfadeangle = 90;
      var_0.end_sunfogscale = 1;
    }
  }

  var_5 = getent(var_0.target, "targetname");
  var_6 = var_5.origin;
  var_7 = undefined;

  if(isdefined(var_5.target)) {
    var_8 = getent(var_5.target, "targetname");
    var_7 = var_8.origin;
  } else
    var_7 = var_6 + (var_0.origin - var_6) * 2;

  var_9 = distance(var_6, var_7);

  for (;;) {
    var_0 waittill("trigger", var_10);
    var_11 = 0;

    while (var_10 istouching(var_0)) {
      var_11 = maps\_utility::get_progress(var_6, var_7, var_10.origin, var_9);
      var_11 = clamp(var_11, 0, 1);
      var_0 maps\_art::set_fog_progress(var_11);
      wait 0.05;
    }

    if(var_11 > 0.5)
      var_11 = 1;
    else
      var_11 = 0;

    var_0 maps\_art::set_fog_progress(var_11);
  }
}

trigger_multiple_depthoffield(var_0) {
  waittillframeend;

  for (;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.script_dof_near_start;
    var_3 = var_0.script_dof_near_end;
    var_4 = var_0.script_dof_near_blur;
    var_5 = var_0.script_dof_far_start;
    var_6 = var_0.script_dof_far_end;
    var_7 = var_0.script_dof_far_blur;
    var_8 = var_0.script_delay;

    if(var_2 != level.dof["base"]["goal"]["nearStart"] || var_3 != level.dof["base"]["goal"]["nearEnd"] || var_4 != level.dof["base"]["goal"]["nearBlur"] || var_5 != level.dof["base"]["goal"]["farStart"] || var_6 != level.dof["base"]["goal"]["farEnd"] || var_7 != level.dof["base"]["goal"]["farBlur"]) {
      maps\_art::dof_set_base(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      wait(var_8);
      continue;
    }

    waitframe();
  }
}

trigger_multiple_tessellationcutoff(var_0) {
  if(level.xenon || level.ps3) {
    return;
  }
  waittillframeend;

  for (;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.script_tess_distance;
    var_3 = var_0.script_tess_falloff;
    var_4 = var_0.script_delay;

    if(var_2 != level.tess.cutoff_distance_goal || var_3 != level.tess.cutoff_falloff_goal) {
      var_2 = max(0, var_2);
      var_2 = min(10000, var_2);
      var_3 = max(0, var_3);
      var_3 = min(10000, var_3);
      maps\_art::tess_set_goal(var_2, var_3, var_4);
      continue;
    }

    waitframe();
  }
}

trigger_slide(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread slidetriggerplayerthink(var_0);
  }
}

slidetriggerplayerthink(var_0) {
  if(isdefined(self.vehicle)) {
    return;
  }
  if(maps\_utility::issliding()) {
    return;
  }
  if(isdefined(self.player_view)) {
    return;
  }
  self endon("death");

  if(soundexists("SCN_cliffhanger_player_hillslide"))
    self playsound("SCN_cliffhanger_player_hillslide");

  var_1 = undefined;

  if(isdefined(var_0.script_accel))
    var_1 = var_0.script_accel;

  self endon("cancel_sliding");
  maps\_utility::beginsliding(undefined, var_1);

  for (;;) {
    if(!self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isdefined(level.end_slide_delay))
    wait(level.end_slide_delay);

  maps\_utility::endsliding();
}

trigger_stats(var_0) {
  var_0 waittill("trigger", var_1);
}

trigger_multiple_fx_volume(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_3 in level.createfxent)
  assign_fx_to_trigger(var_3, var_0, var_1);

  var_1 delete();

  if(!isdefined(var_0.target)) {
    return;
  }
  var_5 = getentarray(var_0.target, "targetname");
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
  for (;;) {
    self waittill("trigger");

    if(!var_0.fx_on)
      common_scripts\utility::array_thread(var_0.fx, maps\_utility::restarteffect);

    wait 1;
  }
}

trigger_multiple_fx_trigger_off_think(var_0) {
  for (;;) {
    self waittill("trigger");

    if(var_0.fx_on)
      common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);

    wait 1;
  }
}

assign_fx_to_trigger(var_0, var_1, var_2) {
  if(isdefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isdefined(var_0.v["stopable"]) || !var_0.v["stopable"])
      return;
  }

  var_2.origin = var_0.v["origin"];

  if(var_2 istouching(var_1))
    var_1.fx[var_1.fx.size] = var_0;
}

trigger_multiple_compass(var_0) {
  var_1 = var_0.script_parameters;

  if(!isdefined(level.minimap_image))
    level.minimap_image = "";

  for (;;) {
    var_0 waittill("trigger");

    if(level.minimap_image != var_1)
      maps\_compass::setupminimap(var_1);
  }
}

trigger_no_crouch_or_prone(var_0) {
  common_scripts\utility::array_thread(level.players, ::no_crouch_or_prone_think_for_player, var_0);
}

no_crouch_or_prone_think_for_player(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while (var_1 istouching(var_0)) {
      var_1 allowprone(0);
      var_1 allowcrouch(0);
      wait 0.05;
    }

    var_1 allowprone(1);
    var_1 allowcrouch(1);
  }
}

trigger_no_prone(var_0) {
  common_scripts\utility::array_thread(level.players, ::no_prone_for_player, var_0);
}

no_prone_for_player(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while (var_1 istouching(var_0)) {
      var_1 allowprone(0);
      wait 0.05;
    }

    var_1 allowprone(1);
  }
}

trigger_wakevolume_think(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 maps\_utility::ent_flag_exist("in_wake_volume")) {

    } else
      var_1 maps\_utility::ent_flag_init("in_wake_volume");

    if(distancesquared(var_1.origin, level.player.origin) < 9250000) {
      if(var_1 maps\_utility::ent_flag("in_wake_volume")) {
        continue;
      }
      var_1 thread volume_wakefx(var_0);
      var_1 maps\_utility::ent_flag_set("in_wake_volume");
    }
  }
}

volume_wakefx(var_0) {
  self endon("death");
  var_1 = 200;

  for (;;) {
    if(self istouching(var_0)) {
      if(var_1 > 0)
        wait(max(1 - var_1 / 120, 0.1));
      else
        wait 0.15;

      var_2 = var_0.script_fxid;
      var_3 = (0, 0, 0);

      if(isplayer(self))
        var_3 = self getvelocity();

      if(isai(self))
        var_3 = self.velocity;

      var_1 = distance(var_3, (0, 0, 0));

      if(var_1 < 5)
        var_2 = "null";

      if(var_2 != "null") {
        var_4 = vectornormalize((var_3[0], var_3[1], 0));
        var_5 = anglestoforward(vectortoangles(var_4) + (270, 180, 0));
        var_6 = self.origin + (0, 0, 64);
        var_7 = self.origin - (0, 0, 150);
        var_8 = bullettrace(var_6, var_7, 0, undefined);

        if(isdefined(var_0.script_surfacetype)) {
          if(var_8["surfacetype"] != var_0.script_surfacetype)
            continue;
        }

        var_9 = common_scripts\utility::getfx(var_2);
        var_6 = var_8["position"] + var_1 / 4 * var_4;

        if(isdefined(var_0.script_usenormals) && var_0.script_usenormals == 1) {
          var_10 = vectornormalize(vectorcross(var_8["normal"], vectorcross(var_4, var_8["normal"])));

          if(var_8["normal"] != (0, 0, 0) && var_10 != (0, 0, 0))
            playfx(var_9, var_6, var_8["normal"], var_10);
        } else
          playfx(var_9, var_6, var_5);
      }

      continue;
    }

    maps\_utility::ent_flag_clear("in_wake_volume");
    return;
  }
}

trigger_fallingwatervolume_think(var_0) {
  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 maps\_utility::ent_flag_exist("in_fallingwater_volume")) {

    } else
      var_1 maps\_utility::ent_flag_init("in_fallingwater_volume");

    if(distancesquared(var_1.origin, level.player.origin) < 6250000) {
      if(var_1 maps\_utility::ent_flag("in_fallingwater_volume")) {
        continue;
      }
      var_1 thread volume_fallingwaterfx(var_0);
      var_1 maps\_utility::ent_flag_set("in_fallingwater_volume");
    }
  }
}

volume_fallingwaterfx(var_0) {
  self endon("death");
  var_1 = var_0 getpointinbounds(1, 1, 0);
  var_2 = var_0 getpointinbounds(-1, -1, 0);
  var_3 = (var_1[0] - var_2[0]) * (var_1[1] - var_2[1]);
  var_4 = 3;

  if(isdefined(var_0.script_duration))
    var_4 = var_0.script_duration;

  var_5 = 1;

  if(isdefined(var_0.script_flowrate))
    var_5 = var_0.script_flowrate;

  var_6 = int(var_5 * (var_3 / 50));
  var_7 = "null";

  if(isdefined(var_0.script_fxid))
    var_7 = var_0.script_fxid;

  var_8 = "null";

  if(isdefined(var_0.script_screen_fxid))
    var_8 = var_0.script_screen_fxid;

  var_9 = -1;

  for (;;) {
    if(self istouching(var_0)) {
      if(isai(self)) {
        wait 0.05;

        for (var_10 = 0; var_10 < var_6; var_10++) {
          if(var_7 != "null") {
            var_11 = var_0 getpointinbounds(randomfloat(2) - 1, randomfloat(2) - 1, 1);
            var_12 = (var_11[0], var_11[1], self.origin[2]);

            if(distance2dsquared(var_12, self.origin) < 900) {
              var_13 = bullettrace(var_11, var_12, 1, undefined, 0, 1);

              if(isdefined(var_13["entity"]) && var_13["entity"] == self) {
                var_14 = common_scripts\utility::getfx(var_7);
                var_11 = var_13["position"];
                var_15 = vectortoangles(var_13["normal"] + (90, 0, 0));
                var_16 = anglestoforward(var_15);
                var_17 = anglestoup(var_15);
                playfx(var_14, var_11, var_17, var_16);
              }
            }
          }
        }
      }

      if(isplayer(self)) {
        wait 0.05;
        var_9 = var_9 + 0.05;

        if(var_9 > var_4 * 0.2 || var_9 < 0) {
          self setwatersheeting(1, var_4);
          var_9 = 0;
        }

        if(!isdefined(level.effectonplayerviewent)) {
          if(var_8 != "null")
            spawneffectonplayerview(var_8, (500, 0, 0), (180, 0, 0));
        }
      }

      continue;
    }

    maps\_utility::ent_flag_clear("in_fallingwater_volume");

    if(var_8 != "null")
      stopeffectonplayerview(var_8);

    return;
  }
}

spawneffectonplayerview(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = (0, 0, 0);

  if(!isdefined(var_2))
    var_2 = (0, 0, 0);

  var_3 = common_scripts\utility::getfx(var_0);
  level.effectonplayerviewent = common_scripts\utility::spawn_tag_origin();
  level.effectonplayerviewent linktoplayerview(level.player, "tag_origin", var_1, var_2, 1);
  level.effectonplayerview = playfxontag(var_3, level.effectonplayerviewent, "tag_origin");
}

stopeffectonplayerview(var_0, var_1) {
  if(isdefined(level.effectonplayerviewent)) {
    if(isdefined(level.effectonplayerview)) {
      if(var_1)
        killfxontag(common_scripts\utility::getfx(var_0), level.effectonplayerviewent, "tag_origin");
      else
        stopfxontag(common_scripts\utility::getfx(var_0), level.effectonplayerviewent, "tag_origin");
    }

    level.effectonplayerviewent delete();
  }
}