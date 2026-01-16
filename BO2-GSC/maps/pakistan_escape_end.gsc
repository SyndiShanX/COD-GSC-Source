/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_escape_end.gsc
****************************************/

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
#include maps\pakistan_escape;

skipto_escape_bosses() {
  skipto_teleport("skipto_escape_bosses");
  escape_setup(1);
  clientnotify("enter_soct");
  level.vh_player_drone thread store_previous_veh_nodes();
  level.vh_player_drone play_fx("drone_spotlight_cheap", level.vh_player_drone gettagorigin("tag_spotlight"), level.vh_player_drone gettagangles("tag_spotlight"), "remove_fx_cheap", 1, "tag_spotlight");
  level.vh_player_soct play_fx("soct_spotlight", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx", 1, "tag_headlights");
  level.vh_player_soct thread watch_for_boost();
  nd_start = getvehiclenode(level.skipto_point + "_player_start", "script_noteworthy");
  level thread vehicle_switch(nd_start);
  a_ai_targets = getentarray("ai_target", "script_noteworthy");
  array_thread(a_ai_targets, ::add_spawn_function, ::set_lock_on_target, vectorscale((0, 0, 1), 45.0));
  add_spawn_function_veh("boss_apache", ::apache_setup);
  trigger_use("spawn_apache");
  trigger_use("spawn_hotel_0");
  onsaverestored_callback(::checkpoint_save_restored);
  set_objective(level.obj_escape);
  flag_set("vehicle_switched");
  level.vh_player_drone setup_vehicle_regen();
  level.vh_player_soct setup_vehicle_regen();
  flag_set("vehicle_can_switch");
  level.player_soct_test_for_water = 1;
}

main() {
  iprintln("Escape End");

  level notify("escape_bosses_started");
  level thread spawn_super_soct_trigger();
  level thread right_approach_warehouse_soct_trigger("evac_chase_starts");
  level thread left_approach_warehouse_soct_trigger("evac_chase_starts");
  level thread big_jump4_water_sheeting_trigger("pipe_fall_done");
  level thread hotel_approach_wall_hole_damage_trigger();
  level thread hotel_left_garage_trigger();
  level thread pakistan_escape_end_triggers();
  level thread pipes_bosses_chopper1_trigger();
  level thread post_bosses_trigger();
  level thread warehouse_approach_catwalk_trigger();
  level thread warehouse_approach_chopper_trigger();
  level thread warehouse_approach_chopper2_trigger();
  level thread warehouse_approach_chopper3_trigger();
  level thread warehouse_approach_chopper4_trigger();
  level.vh_player_drone thread escape_boss_drone_logic();
  level thread setup_moving_elevators();
  escape_boss_spawn_func();
  level thread escape_bosses_objectives();
  level thread escape_bosses_checkpoints();
  level thread escape_bosses_clean_up();
  level thread escape_bosses_vo();

  if(level.skipto_point != "escape_bosses")
    trigger_wait("spawn_apache");

  level.vh_apache thread apache_think();
  level.vh_player_soct thread hotel_super_soct_condition();
  level thread drone_attack_water_tower();
  level thread water_tower();
  pipe_fall();
  level thread post_pipes_soct_trigger("evac_chase_starts");
  level thread post_pipes_elevated_soct_trigger("evac_chase_starts");
  level thread hack_triggers();
  level thread soct_walkway_ai_spawn();
  level thread drone_attack_silo();
}

setup_moving_elevators() {
  wait 0.2;
  a_time = [];
  a_time[a_time.size] = 8;
  a_time[a_time.size] = 7;
  a_time[a_time.size] = 9;

  for(i = 1; i <= 3; i++) {
    m_eleveator = getent("elevator0" + i, "targetname");
    n_move_time = a_time[i - 1];
    m_eleveator thread elevator_logic(i, n_move_time);
  }
}

hotel_super_soct_condition() {
  level.harper thread hotel_super_soct_condition_vo();
  level.harper thread hotel_drone_condition_vo();

  if(level.player get_temp_stat(1)) {
    level.vh_player_soct.n_intensity_min = 0;
    flag_wait("super_soct_created");
    level.vh_player_soct.n_intensity_min = 6;
  } else {
    trigger_wait("spawn_hotel_block_socts");
    wait 0.05;
    ai_shooter_742 = getent("shooter_742_drone", "targetname");
    ai_shooter_743 = getent("shooter_743_drone", "targetname");
    ai_shooter_742.overrideactordamage = ::hotel_soct_shooter_damage_override;
    ai_shooter_743.overrideactordamage = ::hotel_soct_shooter_damage_override;
    trigger_wait("non_super_soct_crash");
    level thread player_hotel_collision_effects();
  }
}

player_hotel_collision_effects() {
  level.vh_player_soct dodamage(150, level.vh_player_soct.origin);
  level.player playsound("exp_veh_large");
  power = 0.6;
  time = 0.8;
  earthquake(power, time, level.player.origin, 1500);

  for(i = 0; i < 3; i++) {
    level.player playrumbleonentity("damage_heavy");
    wait 0.1;
  }
}

hotel_super_soct_condition_vo() {
  level.vh_salazar_soct waittill("turn_left");

  if(level.player.vehicle_state == 1) {
  }
}

hotel_drone_condition_vo() {
  trigger_wait("behind_hotel_drone");

  if(level.player.vehicle_state == 2)
    self say_dialog("harp_where_gotta_keep_mov_0");
}

hotel_soct_shooter_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(str_weapon == "boat_gun_turret")
    n_damage = 0;

  return n_damage;
}

escape_bosses_objectives() {
  trigger_wait("see_evac_point");
  set_objective(level.obj_evac_face_burn_point, getstruct("evac_face_burn_point", "targetname"), "breadcrumb");
  purple_smoke();
  level notify("see_purple_smoke");
}

escape_bosses_checkpoints() {
  trigger_wait("escape_bosses_save_6");
  autosave_by_name("escape_bosses_save_6");
  level.n_save = 6;
  trigger_wait("escape_bosses_save_7");
  autosave_by_name("escape_bosses_save_7");
  level.n_save = 7;
  level notify("pipe_fall_done");
}

escape_bosses_clean_up() {
  level waittill("hotel_clean_up");
  enemy_clean_up(18944, 0, 1, 1);
}

escape_bosses_vo() {
  wait 2;
  level.harper say_dialog("harp_what_the_fuck_0");
  trigger_wait("near_pipes_drone");
  level.harper thread say_dialog("harp_something_tells_me_t_0");
  trigger_wait("pipe_fall_0");
  level.harper say_dialog("harp_the_whole_place_is_c_0");
  level.harper say_dialog("harp_go_left_0");
  flag_wait("pipe_fall_1");
  level.harper say_dialog("harp_go_right_0");
  flag_wait("pipe_fall_2");
  level.harper say_dialog("harp_go_left_0");
  trigger_wait("spawn_factory_catwalk_1");
  level.harper say_dialog("harp_dammit_man_this_a_0");
  level.harper say_dialog("harp_find_a_way_through_0");
  level waittill("fxanim_silo_end_collapse_start");
}

takedown_apache_vo() {
  trigger_wait("apache_retreat");

  if(level.player.vehicle_state == 2) {
  }
}

hack_triggers() {
  trigger_wait("enter_final_warehouse");
  level notify("enter_final_warehouse");
  flag_set("enter_final_warehouse");
}

escape_boss_spawn_func() {
  a_hallway_bad = getentarray("hotel_hallway_0", "targetname");
  array_thread(a_hallway_bad, ::add_spawn_function, ::hallway_ai_logic);
  a_factory_walkway_2 = getentarray("factory_walkway_2", "targetname");
  array_thread(a_factory_walkway_2, ::add_spawn_function, ::soct_walkway_ai_logic);
  add_spawn_function_veh("hotel_block_l", ::hotel_blocker_soct_setup);
  add_spawn_function_veh("hotel_block_r", ::hotel_blocker_soct_setup);
  add_spawn_function_veh("hotel_block_l", ::vehicle_detach_from_path_at_end);
  add_spawn_function_veh("hotel_block_r", ::vehicle_detach_from_path_at_end);
  level thread behind_hotel_drone();
  level thread near_pipes_drone();
  level thread near_catwalk_drone();
}

hotel_blocker_soct_setup() {
  self.good_old_style_turret_tracing = 1;
  self thread enemy_soct_setup(1, undefined, 1, undefined);
}

vehicle_detach_from_path_at_end() {
  self endon("death");
  wait 4;
  self vehicle_detachfrompath();
}

hotel_left_garage_trigger() {
  e_trigger = getent("hotel_left_garage_trigger", "targetname");
  e_trigger waittill("trigger");
  wait 0.01;
  a_ai = getentarray("hotel_left_garage_spawner", "targetname");

  for(i = 0; i < a_ai.size; i++) {
    e_ai = simple_spawn_single(a_ai[i]);

    if(isDefined(e_ai))
      e_ai thread ai_run_to_goal_wait_kill_flag("pipe_fall_0");

    wait 0.01;
  }
}

behind_hotel_drone() {
  trigger_wait("behind_hotel_drone");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone endon("death");
  vh_drone thread enemy_drone_setup();
  vh_drone.origin = (25600, -21504, 832);
  vh_drone setphysangles(vectorscale((0, 1, 0), 180.0));
  vh_drone setlookatent(level.vh_player_drone);
  vh_drone.drivepath = 1;
  vh_drone thread vehicle_target_player(0);
  vh_drone setvehgoalpos((24064, -19456, 512));
  vh_drone setneargoalnotifydist(512);
  vh_drone setspeed(63);
  vh_drone waittill("near_goal");
  vh_drone sethoverparams(64);
  flag_wait("pipe_fall_0");
  vh_drone setvehgoalpos((20992, -21504, 832));
  vh_drone waittill("near_goal");
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

near_pipes_drone() {
  trigger_wait("near_pipes_drone");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone endon("death");
  vh_drone thread enemy_drone_setup(1);
  vh_drone.origin = (26112, -18944, 256);
  vh_drone setphysangles(vectorscale((0, 1, 0), 180.0));
  vh_drone setlookatent(level.vh_player_drone);
  vh_drone.drivepath = 1;
  vh_drone thread vehicle_target_player(0);

  if(level.player.vehicle_state == 2)
    wait 2.6;
  else
    wait 2;

  vh_drone setvehgoalpos((28352, -18688, 448));
  vh_drone setspeed(63);
  vh_drone waittill("goal");
  vh_drone setvehgoalpos((32064, -18432, 704));
  vh_drone waittill("goal");
  vh_drone sethoverparams(64);
  wait 3;
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

near_catwalk_drone() {
  trigger_wait("spawn_factory_catwalk_1");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone endon("death");
  vh_drone thread enemy_drone_setup();
  vh_drone.origin = (39424, -13312, 448);
  vh_drone setphysangles(vectorscale((0, 1, 0), 270.0));
  vh_drone setlookatent(level.vh_player_soct);
  vh_drone.drivepath = 1;
  vh_drone setvehgoalpos((39680, -13824, 576));
  vh_drone setspeed(63);
  vh_drone waittill("goal");
  vh_drone setvehgoalpos((37888, -16000, 384));
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

escape_boss_drone_logic() {
  self waittill("end_speed_control");

  if(level.player.vehicle_state == 2) {
    flag_set("stop_drone_speed_control");
    self setspeed(29, 26, 12);
  }

  self waittill("resume_drone_speed_control");
  flag_clear("stop_drone_speed_control");
}

elevator_logic(n_elevator_number, n_move_time) {
  self endon("being_deleted");
  self setcandamage(1);
  self.health = 512;
  self.is_alive = 1;
  ai_elevator = undefined;

  for(i = 1; i <= 1; i++) {
    s_position = getstruct("elevator_spot_" + n_elevator_number + "_" + i, "targetname");
    ai_elevator = simple_spawn_single("elevator_" + i);
    ai_elevator forceteleport(s_position.origin, s_position.angles);
    ai_elevator linkto(self);
    ai_elevator thread eleveator_ai_logic(self, n_elevator_number);
  }

  trigger_wait("move_elevators");
  self thread set_lock_on_target();
  self thread elevator_delete();
  n_height_offset = 125;
  n_dest_height = self.origin[2];
  n_dest_height = n_dest_height - n_height_offset;
  self thread ai_in_elevator_damage_check(ai_elevator, n_dest_height);

  if(is_player_in_drone())
    time_scale = 1.0;
  else
    time_scale = 0.5;

  self moveto(self.origin - (0, 0, n_dest_height), n_move_time * time_scale);
  self waittill("movedone");
  self.move_done = 1;

  if(!is_player_in_drone())
    self notify("elevator_at_rest");
}

ai_in_elevator_damage_check(e_ai_passenger, n_dest_height) {
  self endon("death");
  e_ai_passenger waittill("death");

  if(!isDefined(self.move_done)) {
    v_dest_position = self.origin - (0, 0, n_dest_height);
    self thread elevator_fall_and_explode(v_dest_position);
  }
}

elevator_fall_and_explode(v_dest_position) {
  self endon("death");
  self moveto(v_dest_position, 2);

  while(self.origin[2] > 150)
    wait 0.05;

  playfx(level._effect["blockade_explosion"], self.origin);
  self delete();
}

elevator_delete() {
  self endon("death");
  flag_wait("enter_hotel_cleanup");
  self notify("being_deleted");
  self delete();
}

eleveator_ai_logic(m_elevator, n_elevator_number) {
  self endon("death");
  self set_ignoreall(1);
  trigger_wait("move_elevators");
  self thread shoot_at_target(level.vh_player_drone, undefined, undefined, -1);
  self thread run_over();

  if(is_player_in_drone()) {
    m_elevator waittill("death");
    self delete();
  } else {
    m_elevator waittill("elevator_at_rest");
    self unlink();
    self setgoalpos(self.origin);
    wait 0.01;
    str_node = "elevator_target_node_" + n_elevator_number;
    nd_node = getnode(str_node, "targetname");
    self.goalradius = 48;
    self setgoalnode(nd_node);
    self waittill("goal");
    self dodamage(self.health + 100, self.origin);
  }
}

hallway_ai_logic() {
  self endon("death");
  self thread run_over();
  trigger_wait("hotel_hallway_runaway");

  if(self.script_noteworthy == "behind")
    self change_movemode("sprint");
  else
    self disable_tactical_walk();

  self.goalradius = 16;
}

spawn_super_soct_trigger() {
  str_notify = "super_socit_to_em";
  multiple_trigger_waits("spawn_super_soct_trigger", str_notify);
  level waittill(str_notify);
  flag_set("super_soct_created");
  flag_set("enter_hotel_cleanup");
  e_soct = spawn_vehicle_from_targetname("boss_soct");
  level.vh_super_soct = e_soct;
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
}

super_soct_think() {
  self endon("death");
  level.vh_super_soct = self;
  self veh_magic_bullet_shield(1);
  self.n_time_between_shots = 0.05;
  self.e_target_current = getent("pipe_0", "targetname");
  self thread super_soct_shoot_logic();
  self thread super_soct_speed_control(1);
  self thread set_lock_on_target(vectorscale((0, 0, 1), 32.0));
  flag_wait("pipe_fall_0");
  self.e_target_current = getent("pipe_1", "targetname");
  flag_wait("pipe_fall_1");
  self.e_target_current = getent("water_tower_end", "targetname");
  flag_wait("pipe_fall_2");
  self.n_time_between_shots = 3;
  self.e_target_current = level.player;
  self veh_magic_bullet_shield(0);
  self thread drone_kill_count();
  self thread add_scripted_damage_state(0.5, ::soct_damaged_fx);
  self.overridevehicledamage = ::enemy_soct_damage_override;
}

super_soct_shoot_logic() {
  self endon("death");
  level endon("hangar_started");
  level endon("hanger_chase_started");
  e_target_previous = self.e_target_current;
  self set_turret_target(self.e_target_current, undefined, 1);

  while(true) {
    if(e_target_previous != self.e_target_current) {
      self set_turret_target(self.e_target_current, undefined, 1);
      e_target_previous = self.e_target_current;
    }

    self thread fire_turret_for_time(4.5, 1);
    wait(self.n_time_between_shots);
  }
}

super_soct_speed_control(b_initial) {
  self endon("death");
  self endon("end_speed_control");

  if(isDefined(b_initial) && b_initial) {
    self thread super_soct_speed();
    self waittill("speed_control");
  }

  while(true) {
    if(level.player.vehicle_state == 1)
      self setspeed(self.n_speed_based_on_soct, 26, 12);
    else if(level.player.vehicle_state == 2)
      self setspeed(self.n_speed_based_on_drone, 26, 12);

    wait 0.05;
  }
}

super_soct_speed() {
  self endon("death");
  self.n_speed_based_on_drone = 77;
  self.n_speed_based_on_soct = 86;
  self waittill("speed_control");
  self.n_speed_based_on_drone = 67;
  flag_wait("pipe_fall_0");
  self.n_speed_based_on_drone = 63;
  self.n_speed_based_on_soct = 63;
  flag_wait("pipe_fall_1");
  self.n_speed_based_on_soct = 71;
  flag_wait("pipe_fall_2");
  self.n_speed_based_on_drone = 89;
  self.n_speed_based_on_soct = 63;
  self thread left_outside_speed_up();
}

soct_walkway_ai_spawn() {
  trigger_wait("spawn_factory_walkway_2");
  ai_behind = simple_spawn_single("factory_walkway_2_behind");
  ai_behind thread soct_walkway_ai_logic();
  ai_behind endon("death");
  flag_wait("enter_final_warehouse");
  ai_behind delete();
}

soct_walkway_ai_logic() {
  self endon("death");
  self thread shoot_at_target(level.vh_player_drone);
  trigger_wait("runaway_factory_walkway");
  self thread run_over();

  if(self.targetname == "factory_walkway_2_behind_ai")
    self change_movemode("sprint");
  else
    self disable_tactical_walk();

  self.goalradius = 16;
}

apache_think() {
  self endon("death");
  flag_wait("pipe_fall_0");
  self clearvehgoalpos();
  self.origin = (40448, 2048, 768);
  self setphysangles(vectorscale((0, 1, 0), 270.0));
  self setlookatent(level.vh_player_drone);
  self.drivepath = 1;
  self sethoverparams(512);
  wait 0.05;
  level notify("hotel_clean_up");
  level waittill("fxanim_silo_end_collapse_start");
  self enable_turret(0);
  self setvehgoalpos((40448, 2048, 768));
  self setspeed(119);
}

drone_attack_water_tower() {
  trigger_wait("shoot_water_tower");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone endon("death");
  nd_start = getvehiclenode("apache_start_1", "targetname");
  vh_drone thread enemy_drone_setup(1);
  vh_drone go_path(nd_start);
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

drone_attack_silo() {
  trigger_wait("attack_catwalk_final");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone endon("death");
  vh_drone thread enemy_drone_setup();
  e_target = getent("catwalk_final", "targetname");
  vh_drone setlookatent(e_target);
  vh_drone set_turret_target(e_target, undefined, 0);
  vh_drone fire_turret(0);
  nd_start = getvehiclenode("apache_start_2", "targetname");
  vh_drone thread go_path(nd_start);
  vh_drone waittill("shoot_catwalk_final");
  vh_drone set_turret_target(e_target, undefined, 1);
  vh_drone set_turret_target(e_target, undefined, 2);
  wait 2;
  vh_drone fire_turret(1);
  vh_drone fire_turret(2);
  wait 0.05;
  e_target playsound("exp_veh_large");
  e_target playsound("evt_watertower_collapse");
  playfx(level._effect["blockade_explosion"], e_target.origin);
  level notify("fxanim_silo_end_collapse_start");
  level notify("fxanim_catwalk_end_collapse_start");
  vh_drone waittill("stop_lookat");
  vh_drone clearlookatent();
  vh_drone veh_magic_bullet_shield(0);
  vh_drone waittill("reached_end_node");
  vh_drone dodamage(vh_drone.health, vh_drone.origin);
}

left_outside_speed_up() {
  trigger_wait("super_soct_speed_up");
  self.n_speed_based_on_drone = 61;
  self.n_speed_based_on_soct = 76;
}

pipe_fall() {
  flag_wait("super_soct_created");
  flag_set("player_cannot_get_hurt");
  trigger_wait("pipe_fall_0");
  flag_set("pipe_fall_0");
  level notify("fxanim_tower_collapse_start");
  level thread pipe0_boss_damage_volume();
  level thread pipe1_boss_damage_volume();
  trigger_wait("pipe_fall_1");
  flag_set("pipe_fall_1");
  level notify("fxanim_pipes_block_start");
  trigger_wait("pipe_fall_2");
  flag_set("pipe_fall_2");
  level notify("fxanim_water_tower_block_start");
  flag_clear("player_cannot_get_hurt");
}

pipe0_boss_damage_volume() {
  damage_per_frame = 100;
  last_hurt_time = 0;
  last_speed_penalty_time = 0;
  speed_penalty_time = 2.0;
  e_info_volume = getent("pipes0_boss_info_volume", "targetname");

  while(true) {
    if(level.player.vehicle_state == 1) {
      if(level.vh_player_soct istouching(e_info_volume)) {
        level.vh_player_soct dodamage(damage_per_frame, level.vh_player_soct.origin);
        time = gettime();
        dt = (time - last_hurt_time) / 1000;

        if(dt > 0.1) {
          earthquake(0.5, 0.5, level.vh_player_soct.origin, 512);
          level.player playrumbleonentity("damage_heavy");
          last_hurt_time = time;
        }

        dt = (time - last_speed_penalty_time) / 1000;

        if(dt > speed_penalty_time) {
          level.vh_player_soct thread maps\pakistan_escape::soct_speed_penalty(50, speed_penalty_time - 0.1);
          last_speed_penalty_time = time;
        }
      }
    }

    wait 0.01;
  }

  e_info_volume delete();
}

pipe1_boss_damage_volume() {
  damage_per_frame = 100;
  last_hurt_time = 0;
  e_info_volume = getent("pipes1_boss_info_volume", "targetname");

  while(true) {
    if(level.player.vehicle_state == 1) {
      if(level.vh_player_soct istouching(e_info_volume)) {
        level.vh_player_soct dodamage(damage_per_frame, level.vh_player_soct.origin);
        time = gettime();
        dt = (time - last_hurt_time) / 1000;

        if(dt > 0.1) {
          earthquake(0.5, 0.5, level.vh_player_soct.origin, 512);
          level.player playrumbleonentity("damage_heavy");
          last_hurt_time = time;
        }
      }
    }

    wait 0.01;
  }

  e_info_volume delete();
}

pipe_zone_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  n_damage = 0;
  return n_damage;
}

play_delayed_impact_sound(num) {
  self waittill("movedone");
  self playsound("evt_water_impact_0" + num);
}

water_tower() {
  trigger_wait("shoot_water_tower");
  v_pos_start = getstruct("water_tower_start", "targetname");
  v_pos_end = getent("water_tower_end", "targetname");
  magicbullet("usrpg_sp", v_pos_start.origin, v_pos_end.origin);
  wait 1;
  magicbullet("usrpg_sp", v_pos_start.origin, v_pos_end.origin);
  level.vh_apache waittill("fire_rocket");
  e_target = getent("apache_target_1", "targetname");
  level.vh_apache set_turret_target(e_target, undefined, 1);
  level.vh_apache set_turret_target(e_target, undefined, 2);
  level.vh_apache fire_turret(1);
  level.vh_apache fire_turret(2);
}

pakistan_escape_end_triggers() {
  level thread fx_exp_glass_hotel_entrance_volume("han_ai");
  level thread shoot_or_collide_triggers_creates_fx(undefined, "exit_hotel_damage_trigger", "glass_hotel_exit", "soct_window_smash", "fx_exp_glass_hotel_exit_info_volume", undefined);
  level thread fx_exp_glass_hotel_garage_entrance_volume("han_ai");
  level thread fx_exp_glass_hotel_garage_exit_volume("han_ai");
  level thread shoot_or_collide_triggers_creates_fx(undefined, "fx_exp_right_hotel_entrance_damage_trigger", "glass_hotel_entrance_2", "soct_window_smash", "fx_exp_right_hotel_entrance_info_volume", undefined);
}

fx_exp_glass_hotel_entrance_volume(str_targetname) {
  level endon("hotel_clean_up");
  info_volume = getent("fx_exp_glass_hotel_entrance_volume", "targetname");
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

  fx_exp_model_triggered("glass_hotel_entrance", s_struct.origin, "soct_window_smash", s_struct.angles, undefined, undefined, undefined, undefined);
  info_volume delete();
}

fx_exp_glass_hotel_garage_entrance_volume(str_targetname) {
  level endon("hotel_clean_up");
  info_volume = getent("fx_exp_glass_hotel_garage_entrance_volume", "targetname");
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

  fx_exp_model_triggered("glass_hotel_garage_entrance", s_struct.origin, "soct_window_smash", s_struct.angles, undefined, undefined, undefined, undefined);
  info_volume delete();
}

fx_exp_glass_hotel_garage_exit_volume(str_targetname) {
  level endon("hotel_clean_up");
  info_volume = getent("fx_exp_glass_hotel_garage_exit_volume", "targetname");
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

  fx_exp_model_triggered("glass_hotel_garage_exit", s_struct.origin, "soct_window_smash", s_struct.angles, undefined, undefined, undefined, undefined);
  info_volume delete();
}

hotel_approach_wall_hole_damage_trigger() {
  level endon("hotel_clean_up");
  e_damage_trigger = getent("hotel_approach_wall_hole_damage_trigger", "targetname");

  while(true) {
    e_damage_trigger waittill("damage", n_damage, e_attacker, direction_vec, point, damagetype);

    if(isDefined(e_attacker) && e_attacker == level.player) {
      a_ai = getentarray("hotel_0_ai", "targetname");

      if(isDefined(a_ai)) {
        for(i = 0; i < a_ai.size; i++) {
          e_ent = a_ai[i];
          delay = randomfloatrange(0.01, 0.5);
          height = 90 + randomfloatrange(1, 20);
          e_ent thread ai_explosive_death(height, 30, delay);
        }

        playfx(level._effect["blockade_explosion"], point);
        break;
      }
    }
  }

  e_damage_trigger delete();
}

post_bosses_trigger() {
  e_trigger = getent("post_bosses_trigger", "targetname");
  e_trigger waittill("trigger");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("post_bosses_chopper_path", 110, 1, 1, level.player, 1);
}

warehouse_approach_catwalk_trigger() {
  e_trigger = getent("warehouse_approach_catwalk_trigger", "targetname");
  e_trigger waittill("trigger");
  a_ai = getentarray("warehouse_approach_catwalk_spawner", "targetname");

  for(i = 0; i < a_ai.size; i++) {
    e_ai = simple_spawn_single(a_ai[i]);
    e_ai thread ai_run_to_goal_wait_kill_flag("enter_final_warehouse");
  }
}

warehouse_approach_chopper_trigger() {
  e_trigger = getent("warehouse_approach_chopper_trigger", "targetname");
  e_trigger waittill("trigger");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("warehouse_approach_chopper_path", 20, 1, 1, undefined, 0);
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("warehouse_approach_chopper1_1_path", 55, 1, 1, level.player, 1);
  a_ai = getentarray("warehouse_approach_chopper_spawner", "targetname");

  for(i = 0; i < a_ai.size; i++) {
    e_ai = simple_spawn_single(a_ai[i]);
    e_ai thread ai_run_to_goal_wait_kill_flag("enter_final_warehouse");
  }
}

ai_run_to_goal_wait_kill_flag(str_killoff_flag) {
  self endon("death");
  self thread run_over();
  self set_goalradius(48);
  self set_ignoreme(1);
  self waittill("goal");
  self set_goalradius(2048);
  self set_ignoreme(0);

  while(true) {
    if(flag(str_killoff_flag)) {
      break;
    }

    wait 0.01;
  }

  self delete();
}

warehouse_approach_chopper2_trigger() {
  e_trigger = getent("warehouse_approach_chopper2_trigger", "targetname");
  e_trigger waittill("trigger");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("warehouse_approach_chopper2_path", 24, 1, 1, level.player, 1);
}

warehouse_approach_chopper3_trigger() {
  e_trigger = getent("warehouse_approach_chopper3_trigger", "targetname");
  e_trigger waittill("trigger");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("warehouse_approach_chopper3_path", 35, 1, 1, level.player, 1);
}

warehouse_approach_chopper4_trigger() {
  e_trigger = getent("warehouse_approach_chopper4_trigger", "targetname");
  e_trigger waittill("trigger");
  level thread enemy_runner_in_warehouse_spawner(2);
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("warehouse_approach_chopper4_path", 30, 1, 1, level.player, 1);
}

pipes_bosses_chopper1_trigger() {
  e_trigger = getent("pipes_bosses_chopper1_trigger", "targetname");
  e_trigger waittill("trigger");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("pipes_bosses_chopper1_path", 50, 1, 1, level.player, 1);
}

get_the_player_up_drone_vo() {
  level endon("apache_showed_up");
  n_array_counter = 0;
  a_nag_vo = array("harp_you_gotta_use_the_dr_0", "harp_switch_to_drone_cont_0", "harp_take_direct_control_0");

  while(true) {
    if(level.player.vehicle_state == 1) {
      waittill_vo_done();
      level.harper say_dialog(a_nag_vo[n_array_counter]);
      n_array_counter++;

      if(n_array_counter == a_nag_vo.size) {
        a_nag_vo = random_shuffle(a_nag_vo);
        n_array_counter = 0;
      }

      wait 9;
    }

    wait 0.05;
  }
}

right_approach_warehouse_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("right_approach_warehouse_soct_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("right_approach_warehouse_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
  e_soct thread kill_vehicle_on_flag("enter_final_warehouse");
}

left_approach_warehouse_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("left_approach_warehouse_soct_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("left_approach_warehouse_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
  e_soct thread kill_vehicle_on_flag("enter_final_warehouse");
}

post_pipes_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("post_pipes_scot_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("post_pipes_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
  e_soct thread kill_vehicle_on_flag("enter_final_warehouse");
}

post_pipes_elevated_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("post_pipes_scot_trigger", "targetname");
  e_trigger waittill("trigger");
  wait 1.0;
  e_soct = spawn_vehicle_from_targetname("post_pipes_elevated_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
  e_soct thread kill_vehicle_on_flag("enter_final_warehouse");
}

big_jump4_water_sheeting_trigger(str_level_endon) {
  level endon(str_level_endon);
  e_trigger = getent("water_jump4_trigger", "targetname");
  e_trigger waittill("trigger");
  level thread pak3_water_sheeting(undefined, 0, 6, 1);
}

enemy_runner_in_warehouse_spawner(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  a_spawners = getentarray("enemy_runner_in_warehouse_spawner", "targetname");

  if(isDefined(a_spawners)) {
    for(i = 0; i < a_spawners.size; i++) {
      e_ai = simple_spawn_single(a_spawners[i]);
      e_ai thread ai_run_to_goal_wait_kill_flag("evac_chase_starts");
      wait 1.5;
    }
  }
}

debug_show_ent() {
  self endon("death");

  while(true) {
    v_endpos = (self.origin[0], self.origin[1], self.origin[2] + 300);

    line(self.origin, v_endpos, (0, 0, 1), 10);

    wait 0.01;
  }
}