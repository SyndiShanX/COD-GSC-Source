/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_escape_intro.gsc
******************************************/

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
#include maps\_music;
#include maps\_vehicle_death;

skipto_escape_intro() {
  skipto_teleport("skipto_escape_intro");
}

main() {
  level thread screen_fade_out(0);
  escape_setup();
  onsaverestored_callback(::checkpoint_save_restored);
  level.vh_player_drone play_fx("firescout_spotlight", level.vh_player_drone gettagorigin("tag_spotlight"), level.vh_player_drone gettagangles("tag_spotlight"), "remove_fx", 1, "tag_spotlight");
  level.vh_player_soct play_fx("soct_spotlight_cheap", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx_cheap", 1, "tag_headlights");
  level.vh_player_drone thread maps\_vehicle_death::vehicle_damage_filter("firestorm_turret", 20, 3, 0);
  level.vh_player_drone thread firescout_fire_missiles();
  wait 0.38;
  level.vh_player_drone setup_vehicle_regen();
  level.vh_player_soct setup_vehicle_regen();
  rpc("clientscripts/pakistan_3", "put_on_oxygen_mask", 0);
  level.vh_player_drone useby(level.player);
  level.player.vehicle_state = 2;
  level.player setclientflag(15);
  level.vh_player_soct setclientflag(1);
  level.vh_salazar_soct setclientflag(1);
  waittill_textures_loaded();
  level thread screen_fade_in(2.5);
  escape_intro_spawn_funcs();
  level thread escape_intro_objectives();
  level thread escape_intro_checkpoints();
  level thread escape_intro_hints();
  level thread escape_intro_vo();
  m_blockade = getent("drone_blockade", "targetname");
  m_blockade thread drone_intro_blockade();
  level thread blockade_scaffolding_damage_triggers();
  level thread shoot_or_collide_triggers_creates_fx("scaffolding_1_collide_trigger", "scaffolding_1_damage_trigger", "scaffolding_1", "soct_window_smash", undefined, undefined);
  level thread start_left_balcony_damage_trigger();
  level thread blockage_walkway_damage_trigger("dukes_of_hazard_button_choice_made");
  setmusicstate("PAKISTAN_CHASE");
  level.health_regen_restart_scale = 1.1;
  level.health_regen_hp_scale = 0.5;
  level.health_regen_damage_multiplier = 4.0;
  level.vh_player_drone drone_intro();
  level.vh_player_drone thread drone_escape_start();
  level.vh_salazar_soct thread soct_intro_change_speed();
}

escape_intro_objectives() {
  set_objective(level.obj_escape);
  trigger_wait("sm_di_scaffolding");
  s_blockade_obj = getstruct("blockade_obj", "targetname");
  set_objective(level.obj_blockade, s_blockade_obj, "destroy");
  level waittill("di_blockade_destroyed");
  set_objective(level.obj_blockade, s_blockade_obj, "done");
  set_objective(level.obj_blockade, s_blockade_obj, "delete");
}

escape_intro_checkpoints() {
  flag_wait("vehicle_switched");
  autosave_by_name("drone_intro_done");
  level.n_save = 0;
}

escape_intro_vo() {
  level.harper say_dialog("harp_gotta_clear_a_path_f_0");
  level.harper say_dialog("harp_soc_t_s_blocking_the_0");
  trigger_wait("sm_di_scaffolding");
  level.harper say_dialog("harp_take_out_that_barric_0");
  level waittill("player_changed_seat");
  level.harper say_dialog("harp_go_go_go_0");
  trigger_wait("reverse_brake_hint");
  level.harper say_dialog("harp_we_gotta_make_that_e_0");
  level.player say_dialog("seal_we_re_clearing_a_pat_0");
}

escape_intro_spawn_funcs() {
  sp_st_fork = getent("st_fork_bad", "targetname");
  sp_st_fork add_spawn_function(::run_over);
  a_st_scaffolding_left_0 = getentarray("st_scaffolding_left_0", "targetname");
  array_thread(a_st_scaffolding_left_0, ::add_spawn_function, ::run_over);
  sp_st_scaffolding_middle_0 = getent("st_scaffolding_middle_0", "targetname");
  sp_st_scaffolding_middle_0 add_spawn_function(::shoot_at_target_untill_dead, level.player);
  sp_st_scaffolding_right_0 = getent("st_scaffolding_right_0", "targetname");
  sp_st_scaffolding_right_0 add_spawn_function(::shoot_at_target_untill_dead, level.player);
  a_ai_targets = getentarray("ai_target", "script_noteworthy");
  array_thread(a_ai_targets, ::add_spawn_function, ::set_lock_on_target, vectorscale((0, 0, 1), 45.0));
  add_spawn_function_veh("di_soct_0", ::enemy_soct_shoot_logic);
  add_spawn_function_veh("di_soct_0", ::set_lock_on_target, vectorscale((0, 0, 1), 32.0));
  add_spawn_function_veh("di_soct_0", ::drone_kill_count);
  add_spawn_function_veh("di_soct_0", ::drone_intro_soct_0_logic);
  add_spawn_function_veh("chicken_soct", ::soct_intro_chicken);
}

drone_intro() {
  level thread drone_intro_enemies();
  self thread drone_intro_entries();
  nd_drone_intro_start = getvehiclenode("drone_intro_spline", "targetname");
  self setvehgoalpos(nd_drone_intro_start.origin);
  self waittill("goal");
  spawn_vehicle_from_targetname_and_drive("di_soct_0");
  self go_path(nd_drone_intro_start);
  self sethoverparams(128);
  flag_set("drone_intro_path_complete");
  level.vehicle_switch_fadein_delay = 0.5;
  flag_set("vehicle_can_switch");
  level thread cleanup_intro_part1();
  level waittill("player_changed_seat");
  level notify("soct_intro_ready");
  level thread cleanup_di_right_guys();

  if(-1)
    level.vh_player_soct thread player_in_soct_keep_up_with_salazar_fail();

  if(-1)
    level.vh_player_soct thread player_in_soct_keep_moving_fail();
}

cleanup_di_right_guys() {
  a_ents = getentarray("di_right_0_ai", "targetname");

  if(isDefined(a_ents) && a_ents.size > 0) {
    for(i = 0; i < a_ents.size; i++) {
      e_ent = a_ents[i];
      e_ent delete();
    }
  }
}

cleanup_intro_part1() {
  e_ent = getent("di_left_0_ai", "targetname");

  if(isDefined(e_ent))
    e_ent dodamage(e_ent.health + 100, e_ent.origin);

  e_ent = getent("di_glass_building_1_ai", "targetname");

  if(isDefined(e_ent))
    e_ent dodamage(e_ent.health + 100, e_ent.origin);

  e_ent = getent("di_glass_building_2_ai", "targetname");

  if(isDefined(e_ent))
    e_ent dodamage(e_ent.health + 100, e_ent.origin);
}

drone_intro_lookat_targets() {
  self endon("death");
  self waittill("di_billboard");
  self setlookatent(getent("lookat_di_billboard", "targetname"));

  iprintlnbold("look at billboard");

  self waittill("di_left_side");
  self setlookatent(getent("lookat_di_left", "targetname"));

  iprintlnbold("look left");

  self waittill("di_blockade");
  self setlookatent(getent("drone_blockade_01", "targetname"));
  iprintlnbold("look at blockade");
}

drone_escape_start() {
  nd_soct_intro_start = getvehiclenode("drone_path", "targetname");
  self setvehgoalpos(nd_soct_intro_start.origin);
  self waittill("goal");
  self thread go_path(nd_soct_intro_start);
  self thread player_drone_speed_control();
}

drone_intro_entries() {
  nd_start = getnode("di_right_0_nd", "script_noteworthy");
  nd_end = getvehiclenode("di_left_side", "script_noteworthy");
  waittill_ai_group_cleared("di_right");
  v_tag_player_org = self gettagorigin("tag_player");
  v_end_pos = (nd_end.origin[0], nd_end.origin[1], v_tag_player_org[2]);
  magicbullet("usrpg_sp", nd_start.origin + vectorscale((0, 0, 1), 64.0), v_end_pos);
  waittill_ai_group_cleared("di_left");
  trigger_use("sm_di_scaffolding");
}

drone_intro_enemies() {
  level thread drone_intro_billboard();
  level thread drone_intro_glass_building();
  level thread drone_intro_scaffolding();
}

drone_intro_billboard() {
  trigger_wait("sm_di_right_0");
  level thread lower_scaffolding_guys();
  level thread intro_pipe_building_01_guy();
  level thread run_scene("di_billboard_below");
  trigger_wait("sm_di_right_1");
  level thread run_scene_clear_goal("di_billboard_right");
  level thread run_scene_clear_goal("di_billboard_side");
  scene_wait("di_billboard_right");
  m_billboard = getent("billboard_fall", "targetname");
  t_billboard = getent("t_di_billboard", "targetname");
  e_triggerer = undefined;

  while(!isplayer(e_triggerer)) {
    t_billboard waittill("trigger", e_triggerer);
    wait 0.05;
  }

  e_floor = getent("intro_billboard_walkway", "targetname");
  e_floor delete();
  billboard_ragdoll(1);
  billboard_ragdoll(2);
  billboard_ragdoll(4);
  m_billboard delete();
  t_billboard delete();
  level notify("fxanim_billboard_pillar_top03_start");
}

lower_scaffolding_guys() {
  trigger_wait("sm_di_right_1");
  wait 9.5;
  level thread run_scene("intro_lower_scaffoldind_01");
  level thread run_scene("intro_lower_scaffoldind_02");
}

intro_pipe_building_01_guy() {
  trigger_wait("sm_di_right_1");
  wait 3.5;
  level thread run_scene("intro_pipe_building_01");
}

billboard_ragdoll(n_index) {
  s_target = getstruct("billboard_target_" + n_index, "targetname");
  ai_billboard = getent("di_billboard_" + n_index + "_ai", "targetname");

  if(isalive(ai_billboard)) {
    v_launch = s_target.origin - ai_billboard.origin;
    ai_billboard _launch_ai(v_launch);
  }
}

drone_intro_glass_building() {
  trigger_wait("ts_di_left_0");
  run_scene_first_frame("di_glass_building");
  trigger_wait("di_glass_building");
  run_scene("di_glass_building");
}

drone_intro_scaffolding() {
  trigger_wait("sm_di_scaffolding");
  trigger_use("di_glass_building");
  level thread drone_intro_path_end();
  level thread run_scene("di_scaffolding_middle_1");
  wait 0.2;
  level thread run_scene("di_scaffolding_middle_2");
  wait 0.1;
  level thread run_scene("di_scaffolding_middle_3");
  wait 0.2;
  level thread run_scene("di_scaffolding_middle_4");
  wait 0.1;
  level thread run_scene("di_scaffolding_middle_5");
  wait 0.2;
  level thread run_scene("di_scaffolding_middle_6");
  wait 0.1;
  level thread run_scene("di_scaffolding_middle_7");
  wait 0.2;
  level thread run_scene("di_scaffolding_middle_8");
  e_spawner = getent("intro_launcher_left_side_spawner", "targetname");
  e_ai = simple_spawn_single(e_spawner);
  e_ai.goalradius = 48;
}

drone_intro_path_end() {
  level.vh_player_drone waittill("di_path_end");
  trigger_use("di_scaffolding_middle");
}

escape_intro_hints() {
  level thread drone_hints();
  level waittill("di_blockade_destroyed");
  screen_message_delete();
  flag_wait("drone_intro_path_complete");

  if(0) {
    screen_message_create(&"PAKISTAN_SHARED_DRONE_HINT_SWITCH");
    level.player.viewlockedentity waittill("change_seat");
    screen_message_delete();
  } else
    level.player.viewlockedentity waittill("change_seat");

  trigger_use("di_scaffolding_middle");
  flag_wait("vehicle_switched");
  level notify("end_vehicle_switch");
  wait 1;
  screen_message_create(&"PAKISTAN_SHARED_SOCT_HINT_GAS", & "PAKISTAN_SHARED_SOCT_HINT_BRAKE");
  trigger_wait("sm_st_fork");
  screen_message_delete();
}

drone_hints() {
  level endon("di_blockade_destroyed");
  wait 1;
  screen_message_create(&"PAKISTAN_SHARED_DRONE_HINT_TURRET");
  trigger_wait("ts_di_left_0");
  wait_to_remove_turret_hint();
  screen_message_delete();
  wait 3;
  wait 3;
  level.player waittill_ads_button_pressed();
  screen_message_delete();
}

wait_to_remove_turret_hint() {
  level endon("turret_hint_done");
  level.player thread wait_for_turret_fire();
  trigger_wait("sm_di_scaffolding");
  level notify("turret_hint_done");
}

wait_for_turret_fire() {
  level endon("turret_hint_done");
  self waittill_attack_button_pressed();
  level notify("turret_hint_done");
}

drone_intro_blockade() {
  self.n_damage_total = 0;
  trigger_wait("sm_di_scaffolding");
  wait 1;
  b_blockade_destroyed = 0;

  while(!b_blockade_destroyed) {
    self waittill("damage", n_damage, e_attacker, direction_vec, point, damagetype);

    if(e_attacker == level.player) {
      if(damagetype == "MOD_PROJECTILE_SPLASH")
        n_damage = n_damage / 2;
      else if(damagetype == "MOD_PROJECTILE")
        n_damage = 2600;

      self.n_damage_total = self.n_damage_total + n_damage;
    }

    if(self.n_damage_total >= 2600) {
      level notify("fxanim_drone_blockade_start");
      level notify("di_blockade_destroyed");
      level.blockade_destroyed_time = gettime();
      s_blockade_obj = getstruct("blockade_obj", "targetname");
      a_blockades = getentarray("drone_blockade_01", "targetname");
      array_delete(a_blockades);
      b_blockade_destroyed = 1;
    }
  }

  self thread remove_targets_at_drone_intro();
  flag_wait("drone_intro_path_complete");
  nd_start = getvehiclenode("player_soct_path", "targetname");
  level thread vehicle_switch(nd_start);

  if(0) {
    flag_set("vehicle_can_switch");
    level.player.viewlockedentity waittill("change_seat");
  } else {
    flag_clear("vehicle_can_switch");
    watch_blockade_destroyed_time = 3;

    while(true) {
      time = gettime();
      time_destroyed = (time - level.blockade_destroyed_time) / 1000;

      if(time_destroyed >= watch_blockade_destroyed_time) {
        break;
      }

      wait 0.01;
    }

    flag_set("vehicle_can_switch");
    level.player.viewlockedentity notify("change_seat");
  }

  level notify("player_changed_seat");
  nd_salazar_start = getvehiclenode("salazar_path", "targetname");
  level.vh_salazar_soct thread go_path(nd_salazar_start);
  level thread salazar_run_into_scaffolding();
  wait 1;
  level.vh_salazar_soct thread salazar_soct_speed_control();
  self delete();
}

remove_targets_at_drone_intro() {
  a_enemies = getaiarray("axis");

  foreach(ai_enemy in a_enemies) {
    if(ai_enemy istouching(self))
      ai_enemy notify("end_lock_on");
  }
}

drone_intro_soct_0_logic() {
  self endon("death");
  self thread kill_on_player_vehicle_swap();
  self waittill("stop_vehicle");
  self setspeed(0);
  self setspeedimmediate(0);
}

kill_on_player_vehicle_swap() {
  while(!isDefined(level.player.viewlockedentity))
    wait 0.01;

  level.player.viewlockedentity waittill("change_seat");
  pak3_kill_vehicle(self);
  e_drone = getent("passenger_700_drone", "targetname");

  if(isDefined(e_drone))
    e_drone delete();

  e_drone = getent("shooter_700_drone", "targetname");

  if(isDefined(e_drone))
    e_drone delete();
}

soct_intro_chicken() {
  self endon("death");
  self thread soct_intro_chicken_left();
  self thread soct_intro_chicken_right();
  self thread soct_intro_chicken_cleanup();
  self thread enemy_soct_setup(1, undefined, undefined, undefined);
  self set_turret_max_target_distance(2048, 1);
}

soct_intro_chicken_cleanup() {
  self endon("death");
  trigger_wait("vs_st_surprise");
  wait 0.1;
  pak3_kill_vehicle(self);
}

soct_intro_chicken_left() {
  self endon("death");
  self endon("swerved_right");
  nd_swerve = getvehiclenode("chicken_swerve", "targetname");
  nd_dest = getvehiclenode("chicken_dest_left", "targetname");
  e_trigger = getent("chicken_swerve_left", "targetname");

  if(isDefined(e_trigger)) {
    e_trigger waittill("trigger");
    self notify("swerved_left");
    self setswitchnode(nd_swerve, nd_dest);
    self waittill("chicken_swerve");
  }
}

soct_intro_chicken_right() {
  self endon("death");
  self endon("swerved_left");
  nd_swerve = getvehiclenode("chicken_swerve", "targetname");
  nd_dest = getvehiclenode("chicken_dest_right", "targetname");
  trigger_wait("chicken_swerve_right");
  self notify("swerved_right");
  self setswitchnode(nd_swerve, nd_dest);
  self waittill("chicken_swerve");
}

salazar_run_into_scaffolding() {
  trigger_wait("collapse_scaffolding");
  level notify("fxanim_scaffold_collapse_start");
}

soct_intro_change_speed() {
  trigger_wait("st_middle");
  self.n_speed_max = 89;
  self waittill("escape_battle_drone_start");
  self.n_speed_max = 71;
}

blockade_scaffolding_damage_triggers() {
  health = 3000;
  scaffolding_trigger1 = getent("scaffolding_start1_damage_trigger", "targetname");
  scaffolding_trigger1 thread scaffolding_damage_trigger1(health);
  scaffolding_trigger2 = getent("scaffolding_start2_damage_trigger", "targetname");
  scaffolding_trigger2 thread scaffolding_damage_trigger2(health);
  scaffolding_trigger5 = getent("scaffolding_start5_damage_trigger", "targetname");
  scaffolding_trigger5 thread scaffolding_damage_trigger5(health);
}

scaffolding_damage_trigger1(health) {
  while(health > 0) {
    self waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(attacker == level.player)
      health = health - amount;
  }

  playsoundatposition("evt_soct_scaffold_1", self.origin);
  level notify("fxanim_drone_scaffold_01_start");
  self delete();
  remove_blockage_scaffolding_upper_collision();
}

scaffolding_damage_trigger2(health) {
  while(health > 0) {
    self waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(attacker == level.player)
      health = health - amount;
  }

  level notify("fxanim_drone_scaffold_02_start");
  level notify("fxanim_drone_scaffold_03_start");
  self delete();
  remove_blockage_scaffolding_upper_collision();
}

scaffolding_damage_trigger5(health) {
  while(health > 0) {
    self waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(attacker == level.player)
      health = health - amount;
  }

  level notify("fxanim_drone_scaffold_04_start");
  level notify("fxanim_drone_scaffold_05_start");
  self delete();
}

remove_blockage_scaffolding_upper_collision() {
  if(flag("blockage_scaffolding_collision_deleted") == 0) {
    flag_set("blockage_scaffolding_collision_deleted");
    e_ent = getent("blockade_scaffolding_1", "targetname");
    e_ent delete();
    e_ent = getent("blockade_scaffolding_2", "targetname");
    e_ent delete();
    e_ent = getent("blockade_scaffolding_3", "targetname");
    e_ent delete();
  }
}

start_left_balcony_damage_trigger() {
  wait 6;
  e_ai = simple_spawn_single("start_left_balcony_spawner");
  e_ai thread left_balcony_ai();
  e_damage_trigger = getent("start_left_balcony_damage_trigger", "targetname");
  health = 500;

  while(health > 0) {
    e_damage_trigger waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(attacker == level.player)
      health = health - amount;
  }

  level notify("fxanim_balcony_collapse_start");
  e_clip = getent("start_left_balcony_clip", "targetname");
  e_clip delete();
  e_damage_trigger delete();
}

left_balcony_ai() {
  self endon("death");
  self thread cleanup_ai_on_level_notify("end_vehicle_switch");
  self.goalradius = 48;
  level waittill("fxanim_balcony_collapse_start");
  self ai_explosive_death(70, 20, 0.01);
}

blockage_walkway_damage_trigger(str_endon) {
  level endon(str_endon);
  e_info_volume = getent("blockage_walkway_info_volume", "targetname");
  e_damage_trigger = getent("blockage_walkway_damage_trigger", "targetname");

  while(true) {
    e_damage_trigger waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(attacker == level.player) {
      a_axis = getaiarray("axis");

      if(isDefined(a_axis)) {
        for(i = 0; i < a_axis.size; i++) {
          e_ent = a_axis[i];

          if(e_ent istouching(e_info_volume)) {
            if(isalive(e_ent)) {
              dist = distance(damage_ori, e_ent.origin);

              if(dist < 336)
                e_ent dodamage(e_ent.health + 100, e_ent.origin, level.player);
            }
          }
        }
      }
    }
  }
}