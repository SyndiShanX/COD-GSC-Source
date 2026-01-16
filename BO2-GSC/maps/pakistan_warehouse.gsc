/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_warehouse.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_scene;
#include maps\_turret;
#include maps\_vehicle;
#include maps\pakistan_util;
#include maps\pakistan_s3_util;
#include maps\pakistan_escape_end;

warehouse_spawn_func() {
  add_spawn_function_veh("warehouse_soct_0", ::enemy_soct_setup, 1, undefined, undefined, undefined);
}

skipto_warehouse() {
  skipto_teleport("skipto_warehouse");
  escape_setup(1);
  clientnotify("enter_soct");
  level.vh_player_drone thread store_previous_veh_nodes();
  level.vh_player_drone play_fx("drone_spotlight_cheap", level.vh_player_drone gettagorigin("tag_spotlight"), level.vh_player_drone gettagangles("tag_spotlight"), "remove_fx_cheap", 1, "tag_spotlight");
  level.vh_player_soct play_fx("soct_spotlight", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx", 1, "tag_headlights");
  level.vh_player_soct thread watch_for_boost();
  a_ai_targets = getentarray("ai_target", "script_noteworthy");
  array_thread(a_ai_targets, ::add_spawn_function, ::set_lock_on_target, vectorscale((0, 0, 1), 45.0));
  add_spawn_function_veh("boss_apache", ::apache_setup);
  level.vh_apache = spawn_vehicle_from_targetname("boss_apache");
  level.vh_super_soct = spawn_vehicle_from_targetname("boss_soct");
  level thread warehouse_vehicle_switch();
  level thread maps\pakistan_escape_end::escape_bosses_objectives();
  level thread hack_triggers();
  onsaverestored_callback(::checkpoint_save_restored);
  set_objective(level.obj_escape);
  flag_set("vehicle_switched");
  level.vh_player_drone setup_vehicle_regen();
  level.vh_player_soct setup_vehicle_regen();
  flag_set("vehicle_can_switch");
  level.player_soct_test_for_water = 1;
  level.vh_salazar_soct thread warehouse_salazar_logic();
}

warehouse_vehicle_switch() {
  trigger_wait("enter_final_warehouse");
  nd_start = getvehiclenode(level.skipto_point + "_player_start", "script_noteworthy");
  level thread vehicle_switch(nd_start);
}

warehouse_main() {
  warehouse_spawn_func();
  level thread warehouse_vo();
  level.vh_player_drone thread warehouse_drone_logic();
  level.vh_salazar_soct thread salazar_soct_end_chase_logic();
  setup_warehouse_super_soct();

  if(isDefined(level.vh_apache.classname) && level.vh_apache.classname == "script_vehicle")
    level.vh_apache thread warehouse_apache_logic();

  level thread warehouse_effects_triggers();
  level thread player_drone_crashes_with_boss_chopper_update();
  level thread big_jump_check_2();
  level thread load_ending_gump_trigger();
  level thread warehouse_enter_right_path_soct_trigger("escape_done");
  level thread warehouse_enter_left_path_soct_trigger("escape_done");
  level thread enemy_soct_stop_firing_at_end();

  if(-1)
    level thread pak3_new_ending();

  prepare_for_hangar();
}

setup_warehouse_super_soct() {
  if(isDefined(level.vh_super_soct))
    pak3_kill_vehicle(level.vh_super_soct);

  level.vh_super_soct = spawn_vehicle_from_targetname("boss_soct");
  level.vh_super_soct.dontunloadonend = 1;
  level.vh_super_soct thread warehouse_super_soct_logic();
}

prepare_for_hangar() {
  trigger_wait("prepare_for_hangar");
  level notify("escape_done");
  cleanup_follow_salazar_objective();
  flag_wait("evac_chase_starts");
  wait 0.01;
  flag_wait("player_drone_fatal_collision_starts");
}

warehouse_salazar_logic() {
  trigger_wait("enter_final_warehouse");
  nd_start = getvehiclenode("salazar_path_3", "targetname");
  self.origin = nd_start.origin;
  wait 0.05;
  self thread go_path(nd_start);
  n_new_speed = nd_start.speed / 17.6;
  self setspeed(n_new_speed, 26, 12);
}

warehouse_super_soct_logic() {
  self endon("death");
  trigger_wait("enter_final_warehouse");
  self notify("end_speed_control");
  nd_start = getvehiclenode("super_soct_start_2", "targetname");
  self.origin = nd_start.origin;
  wait 0.05;
  self thread go_path(nd_start);
  n_new_speed = 63;
  self setspeed(n_new_speed, 26, 12);
  self waittill("reached_end_node");
}

warehouse_drone_logic() {
  self endon("death");
  self waittill("prepare_for_death_collision");
  flag_set("player_drone_death_collision");
  wait 0.1;
  self setspeed(50, 26, 12);
}

player_drone_crashes_with_boss_chopper_update() {
  flag_wait("player_drone_death_collision");

  if(isDefined(level.warehouse_apache) && isalive(level.warehouse_apache)) {
    level.warehouse_apache.delete_on_death = 1;
    level.warehouse_apache notify("death");

    if(!isalive(level.warehouse_apache))
      level.warehouse_apache delete();
  }

  if(is_player_in_drone()) {
    str_chopper_spawner = "heli_factory_exit_boss_spawner";
    str_target_struct = "heli_factory_exit_struct";
    str_chopper_crash_scene = "heli_factory_exit_crash";
  } else {
    str_chopper_spawner = "scot_factory_exit_boss_spawner";
    str_target_struct = "scot_factory_exit_struct";
    str_chopper_crash_scene = "soct_factory_exit_crash";
  }

  e_heli = spawn_vehicle_from_targetname(str_chopper_spawner);
  e_heli play_fx("drone_spotlight_cheap", e_heli gettagorigin("tag_spotlight"), e_heli gettagangles("tag_spotlight"), "remove_fx_cheap", 1, "tag_spotlight");
  e_heli thread get_collision_chopper_in_position(str_target_struct);
  level thread chopper_collision_dialog();

  if(is_player_in_drone()) {
    e_heli thread set_lock_on_target(vectorscale((0, 0, -1), 32.0));
    level thread player_soct_collision_ending_check();
  } else
    level thread player_soct_collision_ending_check();

  level waittill("player_drone_fatal_collision");

  if(is_player_in_drone()) {
    level.static_vehicle_switch_fadeout = 1;
    force_trigger("soct_hanger_chase_trigger");
  }

  if(!is_player_in_drone()) {
    level.vh_player_drone.delete_on_death = 1;
    level.vh_player_drone notify("death");

    if(!isalive(level.vh_player_drone))
      level.vh_player_drone delete();
  }

  playfx(level._effect["blockade_explosion"], e_heli.origin);
  e_heli playsound("exp_veh_large");
  e_heli.delete_on_death = 1;
  e_heli notify("death");

  if(!isalive(e_heli))
    e_heli delete();

  if(is_player_in_drone())
    earthquake(0.65, 1.0, level.vh_player_drone.origin, 512);

  wait 0.01;
  level thread chopper_crashes_into_pipes_anim(str_chopper_crash_scene);
  level thread chopper_crash_scene_starts_chain_reaction(str_chopper_crash_scene, 2.0);
  level thread chopper_crash_savepoint(1);
  wait 0.1;
  flag_set("player_drone_fatal_collision_starts");
  level notify("player_drone_fatal_collision_starts");
}

chopper_collision_dialog() {
  level.harper thread say_dialog("harp_shit_drone_s_heade_0");
}

chopper_crash_savepoint(delay) {
  wait(delay);
  autosave_by_name("chopper_crash_savepoint");
}

chopper_crashes_into_pipes_anim(str_scene) {
  level thread run_scene(str_scene);
  wait 0.1;
  e_chopper = getent("heli_factory_exit_boss_anim_crash_spawner", "targetname");

  if(isDefined(e_chopper))
    playfxontag(level._effect["ending_helicopter_explosion"], e_chopper, "tag_origin");
}

get_collision_chopper_in_position(str_target_struct) {
  self endon("death");
  self.drivepath = 1;
  s_struct = getstruct(str_target_struct, "targetname");
  level.heli_collision_point = s_struct.origin;

  if(is_player_in_drone())
    speed = 20;
  else
    speed = 15;

  self setspeed(speed, 100, 100);
  self setvehgoalpos(level.heli_collision_point);
  self waittill("goal");

  self clearvehgoalpos();
}

player_soct_collision_ending_check() {
  level thread pak3_timescale(1.25, 2.25);
  wait 2.0;
  level.player playsound("exp_veh_large");
  earthquake(0.65, 1.0, level.vh_player_drone.origin, 512);
  level notify("player_drone_fatal_collision");
}

chopper_crash_scene_starts_chain_reaction(str_chopper_crash_scene, wait_time) {
  if(isDefined(wait_time) && wait_time > 0)
    wait(wait_time);

  e_heli = getent("heli_factory_exit_boss_anim_crash_spawner", "targetname");

  if(isDefined(e_heli)) {
    playfx(level._effect["blockade_explosion"], e_heli.origin);
    earthquake(0.65, 1.2, e_heli.origin, 2048);
    e_heli playsound("exp_veh_large");
  }

  delete_scene(str_chopper_crash_scene);
  flag_set("player_drone_crashes_chain_reaction");
}

salazar_soct_end_chase_logic() {
  self endon("death");
  flag_wait("evac_chase_starts");
  self notify("end_salazar_speed_control");
  self setspeed(91, 26, 12);
  self waittill("stop_soct");

  iprintlnbold("Stopping Soct");

  self setspeed(0, 26, 12);
}

warehouse_effects_triggers() {
  level thread shoot_or_collide_triggers_creates_fx("smelt_window1_trigger", "smelt_window1_damage_trigger", "smelt_window_1", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx("smelt_window2_trigger", "smelt_window2_damage_trigger", "smelt_window_2", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx("smelt_window3_trigger", "smelt_window3_damage_trigger", "smelt_window_3", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx("factory_window1_trigger", "factory_window1_damage_trigger", "factory_window_1", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx("factory_window2_trigger", "factory_window2_damage_trigger", "factory_window_2", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx(undefined, "factory_window5_damage_trigger", "factory_window_5", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx("factory_window6_trigger", "factory_window6_damage_trigger", "factory_window_6", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_calls_fxanim_notify("catwalk2_trigger", "catwalk2_damage_trigger", "fxanim_pak_catwalk02_start");
}

fx_exp_factory_window_7_volume(str_targetname) {
  info_volume = getent("fx_exp_factory_window_7_volume", "targetname");
  s_struct = getstruct(info_volume.target, "targetname");

  while(true) {
    e_ent = getent(str_targetname, "targetname");

    if(isDefined(e_ent)) {
      if(e_ent istouching(info_volume)) {
        break;
      }
    }

    wait 0.05;
  }

  fx_exp_model_triggered("factory_window_7", s_struct.origin, "soct_window_smash", s_struct.angles, undefined, undefined, undefined, undefined);
  info_volume delete();
}

warehouse_vo() {
  level thread takedown_apache_vo();
  level waittill("see_purple_smoke");
  level.harper say_dialog("harp_they_re_all_over_us_0");
  level.harper say_dialog("harp_got_a_gunship_bearin_0");
}

warehouse_enter_right_path_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("warehouse_enter_right_path_soct_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("warehouse_enter_right_path_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
}

warehouse_enter_left_path_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("warehouse_enter_left_path_soct_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("warehouse_enter_left_path_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
}

warehouse_apache_logic() {
  self endon("death");
  trigger_wait("enter_final_warehouse");
  self clearvehgoalpos();
  self clear_turret_target(1);
  self clear_turret_target(2);
  nd_start = getvehiclenode("apache_start_3", "targetname");
  self.origin = nd_start.origin;
  self setphysangles(vectorscale((0, 1, 0), 270.0));
  self setlookatent(level.vh_player_drone);
  self.drivepath = 1;
  self sethoverparams(64);
  level.warehouse_apache = self;
  e_target = getent("apache_fake_drone_target", "targetname");
  self set_turret_target(e_target, undefined, 1);
  self set_turret_target(e_target, undefined, 2);
  trigger_wait("apache_final_appearance");
  nd_start = getvehiclenode("apache_start_4", "targetname");
  self thread set_lock_on_target();
  self setvehgoalpos(nd_start.origin, 1);
  level notify("apache_showed_up");
  self waittill("goal");
  self veh_magic_bullet_shield(0);
  self.overridevehicledamage = ::apache_damage_override;
  self set_turret_target(e_target, undefined, 0);
  self waittill("turret_on_target");
  self fire_turret(1);
  self fire_turret(2);
  self sethoverparams(64);
  trigger_wait("apache_retreat");
  self thread go_path(nd_start);
  self set_turret_target(level.vh_player_drone, undefined, 0);
  self thread warehouse_apache_shoot_logic();
  level.vh_player_drone setlookatent(self);
  self thread warehouse_apache_death();
}

apache_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(e_attacker != level.player) {
    if(isDefined(e_attacker.vteam) && e_attacker.vteam == "allies")
      n_damage = 1;
    else
      n_damage = 0;
  } else if(level.player.vehicle_state == 1)
    n_damage = 1;

  return n_damage;
}

warehouse_apache_shoot_logic() {
  self endon("death");
  self endon("stop_shooting");
  self waittill("shoot");
  self set_turret_target(level.vh_player_drone, undefined, 0);
  self set_turret_target(level.vh_player_drone, undefined, 1);
  self set_turret_target(level.vh_player_drone, undefined, 2);

  while(true) {
    self waittill("turret_on_target");
    self fire_turret(1);
    self fire_turret(2);
    wait(randomfloatrange(0.4, 1.1));
  }
}

warehouse_apache_death() {
  level.vh_player_drone endon("death");
  self waittill("death");
  level.vh_player_drone clearlookatent();
}

load_ending_gump_trigger() {
  trigger_wait("exit_warehouse_gump_load_trigger");
  level thread load_gump("pakistan_3_gump_escape_end");
  level waittill("gump_loaded");
  flag_set("evac_chase_starts");
}

big_jump_check_2() {
  trigger_wait("big_jump_2_start");
  trigger_wait("big_jump_2_end");
  level notify("big_jump");
}

enemy_soct_stop_firing_at_end() {
  flag_wait("player_enters_hanger");
  a_vehicles = getvehiclearray("axis");

  if(isDefined(a_vehicles)) {
    for(i = 0; i < a_vehicles.size; i++) {
      e_veh = a_vehicles[i];
      e_veh set_turret_target_flags(0, 1);
      e_veh disable_turret(1);
      e_veh notify("terminate_all_turrets_firing");
    }
  }
}

pak3_new_ending() {
  e_trigger = getent("placeholder_ending_blocker_trigger", "targetname");
  e_trigger waittill("trigger");
  wait 1;
  level notify("fxanim_water_tower_block_end_start");
  flag_set("ending_player_blocker_moving");
  a_ents = [];
  a_ents[a_ents.size] = getent("placeholder_ending_blocker_clip", "targetname");

  for(i = 0; i < a_ents.size; i++) {
    e_ent = a_ents[i];
    v_dir = anglestoforward(e_ent.angles);
    v_new_pos = e_ent.origin - v_dir * 500;
    time = 1;
    e_ent moveto(v_new_pos, time);
  }
}