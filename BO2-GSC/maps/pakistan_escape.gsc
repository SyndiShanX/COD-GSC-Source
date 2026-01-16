/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_escape.gsc
**************************************/

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

skipto_escape_battle() {
  skipto_teleport("skipto_escape_battle");
  escape_setup(1);
  clientnotify("enter_soct");
  setmusicstate("PAKISTAN_CHASE");
  level.vh_player_drone play_fx("drone_spotlight_cheap", level.vh_player_drone gettagorigin("tag_spotlight"), level.vh_player_drone gettagangles("tag_spotlight"), "remove_fx_cheap", 1, "tag_spotlight");
  level.vh_player_soct play_fx("soct_spotlight", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx", 1, "tag_headlights");
  level.vh_player_soct.driver = level.player;
  a_ai_targets = getentarray("ai_target", "script_noteworthy");
  array_thread(a_ai_targets, ::add_spawn_function, ::set_lock_on_target, vectorscale((0, 0, 1), 45.0));
  onsaverestored_callback(::checkpoint_save_restored);
  set_objective(level.obj_escape);
  flag_set("vehicle_switched");
  level.vh_player_drone setup_vehicle_regen();
  level.vh_player_soct setup_vehicle_regen();
}

main() {
  iprintln("Escape");

  level.a_lanes = [];
  level.a_lanes["lane_0"] = "occupied";
  level.a_lanes["lane_1"] = "occupied";
  level.a_lanes["lane_2"] = "occupied";
  escape_battle_spawn_func();
  level thread escape_battle_checkpoints();
  level thread escape_battle_hint();
  level thread escape_battle_vo();
  level.health_regen_restart_scale = undefined;
  level.health_regen_hp_scale = undefined;
  level.health_regen_damage_multiplier = undefined;
  level thread pakistan_escape_fx_triggers();
  level.vh_player_drone thread store_previous_veh_nodes();
  level thread enemy_speed_control();
  level thread start_market_inside_guys_trigger();
  level.vh_player_soct thread set_training_speed(10);
  trigger_wait("vs_st_surprise");
  wait 0.1;
  level.vh_player_soct thread watch_for_boost();
  level thread drone_fire_at_market_walkway_trigger();
  level thread enemy_respawn();
  level thread escape_battle_cleanup();

  if(-1)
    level thread dukes_of_hazzard_trigger();

  trigger_wait("vehicle_can_switch");
  nd_start = getvehiclenode("escape_battle_player_start", "script_noteworthy");
  level thread vehicle_switch(nd_start);

  if(0)
    flag_set("vehicle_can_switch");
  else
    flag_clear("vehicle_can_switch");

  level thread market_fake_missile_breaks_window();
  level thread load_gump_escape();
  level thread big_jump_check_1();
  level thread heli_crash();
  level thread big_jump1_water_sheeting_trigger("approaching_hotel_cleanup_notify");
  level thread big_jump2_water_sheeting_trigger("approaching_hotel_cleanup_notify");
  level thread big_jump3_water_sheeting_trigger("approaching_hotel_cleanup_notify");
  level thread suicide_tunnel_running_guys_trigger();
  level thread shoot_or_collide_triggers_calls_fxanim_notify("catwalk1_trigger", "catwalk1_damage_trigger", "fxanim_pak_catwalk01_start");
  level thread catwalks_destroyed_vo();
  level thread kill_fxanim_catwalk1("fxanim_pak_catwalk01_start", "escape_bosses_started");
  level thread slanted_building_soct_trigger("approaching_hotel_cleanup_notify");
  level thread soct_market_inside_trigger("approaching_hotel_cleanup_notify");
  level thread soct_market_outside_trigger("approaching_hotel_cleanup_notify");
  level thread soct_post_broken_freeway_trigger("fxanim_pipes_block_start");
  trigger_wait("spawn_apache");
}

catwalks_destroyed_vo() {
  level waittill("fxanim_pak_catwalk01_start");
  level.disable_harper_background_vo = 1;
  level.harper say_dialog("harp_nice_shot_0");
  wait 1;
  level.harper say_dialog("harp_it_s_bringing_the_wh_0");
  wait 2;
  level.disable_harper_background_vo = undefined;
}

set_training_speed(reduse_speed_training_mpg) {
  max_speed = self getmaxspeed() / 17.6;
  training_max_speed = self getmaxspeed() / 17.6 - reduse_speed_training_mpg;
  self setvehmaxspeed(training_max_speed);
  trigger_wait("vs_st_surprise");
  self setvehmaxspeed(max_speed);
}

soct_speed_penalty(reduce_speed_amount_mpg, time) {
  max_speed = self getmaxspeed() / 17.6;
  penalty_speed = self getmaxspeed() / 17.6 - reduce_speed_amount_mpg;
  self setvehmaxspeed(penalty_speed);
  wait(time);
  self setvehmaxspeed(max_speed);
}

enemy_speed_control() {
  trigger_wait("start_enemy_speed_control");
  level.vh_player_soct thread rubberband_potential_soct();
}

escape_battle_vo() {
  level thread general_congrats_vo();
  level.vh_player_soct thread general_ram_vo();
  trigger_wait("vs_st_surprise");
  level thread general_help_vo();
  trigger_wait("escape_battle_save_2");
  level.harper say_dialog("harp_go_left_onto_the_f_0");
  trigger_wait("change_course_vo");
  level.harper say_dialog("harp_change_course_man_0");
  trigger_wait("slanted_building_intro_vo");
  level notify("slanted_building_started");
  trigger_wait("squeeze_vo");

  if(level.player.vehicle_state == 1)
    level.harper say_dialog("harp_gonna_be_a_squeeze_0");

  trigger_wait("go_for_it_vo");

  if(level.player.vehicle_state == 1)
    level.harper say_dialog("harp_gotta_go_for_it_0");
}

escape_battle_hint() {
  trigger_wait("vs_st_surprise");
  level endon("abort_hints");
  screen_message_create(&"PAKISTAN_SHARED_SOCT_HINT_RAM");
  level waittill_notify_or_timeout("takedown", 5.5);
  screen_message_delete();
  trigger_wait("vehicle_can_switch");
  wait 0.05;

  if(0) {
    screen_message_create(&"PAKISTAN_SHARED_SOCT_TO_DRONE_HINT");
    level.player.viewlockedentity waittill_notify_or_timeout("change_seat", 4.5);
    screen_message_delete();
  }

  if(level.player get_temp_stat(1)) {
    wait 3;
    b_hint_set = 0;
    level.player.b_hint_done = 0;
    level thread boost_while_in_soct();

    while(!level.player.b_hint_done) {
      if(level.player.vehicle_state == 1 && (isDefined(b_hint_set) && !b_hint_set)) {
        screen_message_create(&"PAKISTAN_SHARED_SOCT_HINT_BOOST");
        b_hint_set = 1;
      } else if(level.player.vehicle_state == 2 && (isDefined(b_hint_set) && b_hint_set)) {
        screen_message_delete();
        b_hint_set = 0;
      }

      wait 0.05;
    }

    screen_message_delete();
  }
}

boost_while_in_soct() {
  for(n_counter = 0; !level.player sprintbuttonpressed() && n_counter < 10.5; n_counter = n_counter + 0.05)
    wait 0.05;

  level.player.b_hint_done = 1;
}

escape_battle_checkpoints() {
  trigger_wait("escape_intro_done");
  autosave_by_name("escape_intro_done");
  level.n_save = 1;
  trigger_wait("escape_battle_save_2");
  autosave_by_name("escape_battle_save_2");
  level.n_save = 2;
  trigger_wait("escape_battle_save_3");

  while(!isDefined(flag("pakistan_3_gump_escape")))
    wait 0.05;

  while(!flag("pakistan_3_gump_escape"))
    wait 0.05;

  autosave_by_name("escape_battle_save_3");
  level.n_save = 3;
  trigger_wait("escape_battle_done");
  level notify("approaching_hotel_cleanup_notify");
  autosave_by_name("escape_battle_done");
  level.n_save = 4;
}

escape_battle_spawn_func() {
  a_h_drop_bad = getentarray("h_drop_bad", "targetname");
  array_thread(a_h_drop_bad, ::add_spawn_function, ::run_over);
  sp_heli_crash_shooter = getent("heli_crash_shooter", "targetname");
  sp_heli_crash_shooter add_spawn_function(::heli_crash_ai_spawn_func);
  add_spawn_function_veh("st_surprise_soct", ::enemy_soct_setup, undefined, undefined, undefined, undefined);
  add_spawn_function_veh("st_soct_0", ::temp_magic_bullet_shield);
  add_spawn_function_veh("st_soct_1", ::temp_magic_bullet_shield);
  add_spawn_function_veh("st_soct_0", ::clear_lane, "lane_0");
  add_spawn_function_veh("st_soct_1", ::clear_lane, "lane_1");
  add_spawn_function_veh("st_surprise_soct", ::clear_lane, "lane_2");
  add_spawn_function_veh("h_soct_0", ::enemy_soct_setup, 1, undefined, undefined, undefined);
  add_spawn_function_veh("h_soct_1", ::enemy_soct_setup, undefined, undefined, undefined, undefined);
  add_spawn_function_veh("h_soct_2", ::enemy_soct_setup, undefined, undefined, undefined, undefined);
  add_spawn_function_veh("hwy_soct_3", ::enemy_soct_setup, 1, level.vh_player_soct, undefined, undefined);
  add_spawn_function_veh("hwy_drone_0", ::hwy_drone_0_logic);
  add_spawn_function_veh("hwy_soct_3", ::hwy_soct_3_logic);
  add_spawn_function_veh("h_hind", ::heli_crash_hind_logic);
  add_spawn_function_veh("h_hind", ::heli_shoot_logic, 1);
  add_spawn_function_veh("heli_crash_soct", ::enemy_soct_setup, 1, undefined, undefined, undefined);
  add_spawn_function_veh("heli_crash_soct", ::lerp_crash_soct_to_position);
  add_spawn_function_veh("boss_apache", ::apache_setup);
  level thread escape_intro_left_turn_fway_trigger();
  level thread slanted_building_approach_trigger();
  level thread slanted_building_drone_1();
  level thread slanted_building_drone_2();
  level thread hotel_front_drone_0();
  level thread hotel_front_drone_1();
}

hwy_drone_0_logic() {
  self endon("death");
  self thread enemy_drone_setup(1);
  self setlookatent(level.vh_player_soct);
}

escape_intro_left_turn_fway_trigger() {
  e_trigger = getent("escape_intro_left_turn_fway_trigger", "targetname");
  e_trigger waittill("trigger");
  e_chopper = maps\_vehicle::spawn_vehicle_from_targetname("hwy_heli_drop");
  e_chopper endon("death");
  nd_chopper_path_start = getvehiclenode("h_drop_start", "targetname");
  e_chopper thread go_path(nd_chopper_path_start);
  e_chopper waittill("reached_end_node");
}

slanted_building_approach_trigger() {
  e_trigger = getent("slanted_building_approach_trigger", "targetname");
  e_trigger waittill("trigger");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("slanted_building_approach_drones1", 35, 1, 1, undefined, 1);
}

slanted_building_drone_1() {
  trigger_wait("slanted_building_drones");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("slanted_building_drones1", 63, 0, 1, level.player, 1);
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("slanted_building_drones2", 125, 0, 1, level.player, 0);
}

slanted_building_drone_2() {
  trigger_wait("heli_approach");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone endon("death");
  vh_drone thread enemy_drone_setup(1);
  vh_drone thread vehicle_target_player(0);
  vh_drone.origin = (4608, -19968, 1216);
  vh_drone setphysangles(vectorscale((0, 1, 0), 180.0));
  vh_drone setlookatent(level.player);
  vh_drone.drivepath = 1;
  vh_drone setvehgoalpos((4608, -20992, 896));
  vh_drone setneargoalnotifydist(512);
  vh_drone setspeed(33);
  vh_drone waittill("goal");

  if(level.player.vehicle_state == 1)
    vh_drone dodamage(vh_drone.health, vh_drone.origin);
  else {
    vh_drone setvehgoalpos((3072, -22528, 1024));
    vh_drone waittill("goal");

    if(!(isDefined(vh_drone.crashing) && vh_drone.crashing)) {
      vh_drone.delete_on_death = 1;
      vh_drone notify("death");

      if(!isalive(vh_drone))
        vh_drone delete();
    }
  }
}

hotel_front_drone_0() {
  trigger_wait("hotel_front_drones");
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("hotel_front_drone_0_path", 63, 0, 1, undefined, 1);
}

hotel_front_drone_1() {
  trigger_wait("hotel_front_drones");
  wait 0.05;
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("hotel_front_drone_1_path", 63, 0, 1, undefined, 1);
}

escape_battle_cleanup() {
  enemy_clean_up(10000, 1);
  trigger_wait("spawn_crash_heli");
  enemy_clean_up(-6100, 1);
  trigger_wait("spawn_apache");
  enemy_clean_up(4096, 0, 1, 1);
}

load_gump_escape() {
  trigger_wait("load_gump_escape");
  load_gump("pakistan_3_gump_escape");
}

hwy_soct_3_logic() {
  self endon("death");
  trigger_wait("move_vehicle_721");
  wait 0.75;
  v_force = vectorscale((0, 0, 1), 9.0);
  self launchvehicle(v_force, self.origin + vectorscale((-1, 0, 0), 64.0), 0, 1);
}

heli_crash() {
  trigger_wait("heli_approach");
  vh_soct_crashes_into_heli = getent("heli_crash_soct", "targetname");
  level.vh_salazar_soct add_turret_priority_target(vh_soct_crashes_into_heli, 1);
  flag_wait("heli_crash_ready");
  level.vh_salazar_soct clear_turret_target_ent_array(1);
  run_scene("heli_crash", 1);
}

#using_animtree("vehicles");

heli_crash_hind_logic() {
  self endon("death");
  self waittill("reached_end_node");
  self clearvehgoalpos();
  s_goal = getstruct("soct_slant_bldg_jump", "targetname");
  v_anim_start_pos = getstartorigin(s_goal.origin, (0, 0, 0), % v_pakistan_7_4_helo_crash_hind);
  self.origin = v_anim_start_pos - vectorscale((0, 0, 1), 512.0);
  self setphysangles(vectorscale((0, 1, 0), 180.0));
  self setlookatent(level.vh_salazar_soct);
  self.drivepath = 1;
  self sethoverparams(64);
  trigger_wait("heli_approach");
  self setvehgoalpos(v_anim_start_pos, 1);
  self waittill("goal");
  self notify("shoot");
  trigger_wait("heli_target_player");
  self setlookatent(level.vh_player_soct);
  flag_wait("heli_crash_ready");
  self notify("stop_shooting");
}

lerp_crash_soct_to_position() {
  self endon("death");
  self waittill("heli_crash_soct_end");
  flag_set("heli_crash_ready");
}

heli_crash_ai_spawn_func() {
  self endon("death");
  self.overrideactordamage = ::crash_ai_damage_override;
}

crash_ai_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isDefined(e_attacker.vteam) && e_attacker.vteam == "axis")
    n_damage = 0;
  else if(isDefined(e_attacker.vehicletype) && e_attacker.vehicletype == "boat_soct_axis")
    n_damage = 0;
  else if(str_weapon == "boat_gun_turret")
    n_damage = 0;

  return n_damage;
}

big_jump_check_1() {
  trigger_wait("big_jump_1");
  level notify("big_jump");
}

big_jump1_water_sheeting_trigger(str_level_endon) {
  level endon(str_level_endon);
  e_trigger = getent("water_jump1_trigger", "targetname");
  e_trigger waittill("trigger");
  level thread pak3_water_sheeting(0.9, 0, 6, 1);
}

big_jump2_water_sheeting_trigger(str_level_endon) {
  level endon(str_level_endon);
  str_abort_big_jump2_notify = "abort_big_jump_notify";
  level endon(str_abort_big_jump2_notify);
  e_disable_trigger = getent("water_jump2_disable_it_trigger", "targetname");
  e_disable_trigger thread check_for_disable_big_jump2_trigger(str_level_endon, str_abort_big_jump2_notify);
  e_trigger = getent("water_jump2_trigger", "targetname");
  e_trigger waittill("trigger");
  level thread pak3_water_sheeting(0.8, 0, 6, 1);
}

check_for_disable_big_jump2_trigger(str_level_endon, str_abort_big_jump2_notify) {
  self endon("death");
  level endon(str_level_endon);
  level endon("str_abort_big_jump2_notify");
  self waittill("trigger");
  level notify(str_abort_big_jump2_notify);
}

big_jump3_water_sheeting_trigger(str_level_endon) {
  level endon(str_level_endon);
  e_trigger = getent("water_jump3_trigger", "targetname");
  e_trigger waittill("trigger");
  level thread pak3_water_sheeting(0.8, 0, 6, 1);
}

pakistan_escape_fx_triggers() {
  a_extra_models = [];
  a_extra_models[a_extra_models.size] = "scaffolding_2";
  a_extra_models[a_extra_models.size] = "scaffolding_2a";
  a_extra_models[a_extra_models.size] = "scaffolding_2b";
  level thread shoot_or_collide_triggers_creates_fx("garage_break1_collide_trigger", "garage_break1_damage_trigger", "garage_break1", "soct_window_smash", undefined, a_extra_models);
  level thread shoot_or_collide_triggers_creates_fx("scaffolding_3_collide_trigger", "scaffolding_3_damage_trigger", "scaffolding_3", "soct_window_smash", undefined, undefined);
  level thread shoot_or_collide_triggers_creates_fx("fx_exp_glass_market_entrance_trigger", "fx_exp_glass_market_entrance_damage_trigger", "glass_market_entrance", "soct_window_smash", undefined, undefined);
  level thread fx_exp_glass_market_exit_trigger();
  level thread shoot_or_collide_triggers_creates_fx("fx_exp_glass_side_jump_entrance_trigger", "glass_side_jump_entrance_damage_trigger", "glass_side_jump_entrance", "soct_window_smash", "glass_side_jump_entrance_info_volume", undefined);
  level thread shoot_or_collide_triggers_creates_fx("fx_exp_glass_side_jump_exit_trigger", "glass_side_jump_exit_damage_trigger", "glass_side_jump_exit", "soct_window_smash", "glass_side_jump_exit_info_volume", undefined);
  level thread shoot_or_collide_triggers_creates_fx(undefined, "glass_mall_entrance_damage_trigger", "glass_mall_entrance", "soct_window_smash", "glass_mall_entrance_info_volume", undefined);
  level thread shoot_or_collide_triggers_creates_fx(undefined, "glass_mall_exit_damage_trigger", "glass_mall_exit", "soct_window_smash", "glass_mall_exit_info_volume", undefined);
  level thread fxanim_tree_trigger("fxanim_tree1_trigger");
  level thread fxanim_tree_trigger("fxanim_tree2_trigger");
  level thread fxanim_tree_trigger("fxanim_tree3_trigger");
  level thread fxanim_tree_trigger("fxanim_tree4_trigger");
  level thread fxanim_tree_trigger("fxanim_tree5_trigger");
  level thread fxanim_tree_trigger("fxanim_tree6_trigger");
  a_models = [];
  a_models[a_models.size] = "street_sign_1";
  a_models[a_models.size] = "street_base_1_01";
  a_models[a_models.size] = "street_base_1_02";
  level thread street_sign_damage_trigger("street_sign_1_damage_trigger", "escape_bosses_started", a_models, "fxanim_highway_sign_01_start");
  a_models = [];
  a_models[a_models.size] = "street_sign_2";
  a_models[a_models.size] = "street_base_2_01";
  level thread street_sign_damage_trigger("street_sign_2_damage_trigger", "escape_bosses_started", a_models, "fxanim_highway_sign_02_start");
  a_models = [];
  a_models[a_models.size] = "street_sign_3";
  a_models[a_models.size] = "street_base_3_01";
  a_models[a_models.size] = "street_base_3_02";
  level thread street_sign_damage_trigger("street_sign_3_damage_trigger", "escape_bosses_started", a_models, "fxanim_highway_sign_03_start");
  a_models = [];
  a_models[a_models.size] = "street_sign_4";
  a_models[a_models.size] = "street_base_4_01";
  a_models[a_models.size] = "street_base_4_02";
  level thread street_sign_damage_trigger("street_sign_4_damage_trigger", "escape_bosses_started", a_models, "fxanim_highway_sign_04_start");
  a_models = [];
  a_models[a_models.size] = "street_sign_5";
  a_models[a_models.size] = "street_base_5_01";
  a_models[a_models.size] = "street_base_5_02";
  level thread street_sign_damage_trigger("street_sign_5_damage_trigger", "escape_bosses_started", a_models, "fxanim_highway_sign_05_start");
  level thread pak_scaffold_collapse_02_volume("han_ai");
}

fx_exp_glass_market_exit_trigger() {
  level endon("escape_bosses_started");
  e_trigger = getent("fx_exp_glass_market_exit_trigger", "targetname");
  s_struct = getstruct(e_trigger.target, "targetname");
  e_trigger waittill("trigger");
  exploder_id = undefined;

  if(isDefined(s_struct.script_int))
    exploder_id = s_struct.script_int;

  fx_exp_model_triggered("glass_market_exit", s_struct.origin, "soct_window_smash", undefined, 1, "evt_soct_window_explode_2", undefined, exploder_id);
}

fxanim_tree_trigger(str_trigger_name) {
  level endon("escape_bosses_started");
  e_trigger = getent(str_trigger_name, "targetname");
  e_trigger waittill("trigger");
  level notify(e_trigger.script_string);
  power = 0.5;
  time = 1;
  earthquake(power, time, level.vh_player_soct.origin, 800);
  level.player playrumbleonentity("damage_light");
  level.vh_player_soct dodamage(360, level.vh_player_soct.origin);

  for(i = 0; i < 5; i++) {
    level.vh_player_soct launchvehicle(vectornormalize(level.vh_player_soct.velocity) * -30.0);
    wait 0.01;
  }
}

street_sign_damage_trigger(str_damage_trigger, str_level_endon, a_model_names, str_level_notify) {
  if(isDefined(str_level_endon))
    level endon(str_level_endon);

  e_damage_trigger = getent(str_damage_trigger, "targetname");

  while(true) {
    e_damage_trigger waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    for(i = 0; i < a_model_names.size; i++) {
      e_model = getent(a_model_names[i], "targetname");
      e_model delete();
    }

    level notify(str_level_notify);
    e_damage_trigger delete();
    break;
  }
}

pak_scaffold_collapse_02_volume(str_soct_targetname) {
  level endon("escape_bosses_started");
  info_volume = getent("pak_scaffold_collapse_02_volume", "targetname");

  while(true) {
    e_ent = getent(str_soct_targetname, "targetname");

    if(isDefined(e_ent)) {
      if(e_ent istouching(info_volume)) {
        break;
      }
    }

    wait 0.05;
  }

  level notify("fxanim_scaffold_collapse_02_start");
  info_volume playsound("evt_soct_scaffold_1");
  exploder(10855);
  wait 1.3;
  exploder(10856);
  info_volume delete();
}

suicide_tunnel_running_guys_trigger() {
  e_trigger = getent("suicide_tunnel_trigger", "targetname");
  e_trigger waittill("trigger");
  a_spawners = getentarray("end_suicide_tunnel_spawner", "targetname");

  for(i = 0; i < a_spawners.size; i++)
    level thread spawner_run_to_node(a_spawners[i]);
}

kill_fxanim_catwalk1(str_level_notify, str_endon_notify) {
  level endon(str_endon_notify);
  level waittill(str_level_notify);
  a_ai = [];
  a_ents = getentarray("mall_1_ai", "targetname");

  if(isDefined(a_ents)) {
    for(i = 0; i < a_ents.size; i++)
      a_ai[a_ai.size] = a_ents[i];
  }

  a_ents = getentarray("end_suicide_tunnel_spawner_ai", "targetname");

  if(isDefined(a_ents)) {
    for(i = 0; i < a_ents.size; i++)
      a_ai[a_ai.size] = a_ents[i];
  }

  for(i = 0; i < a_ai.size; i++) {
    e_ent = a_ai[i];
    delay = randomfloatrange(0.01, 0.5);
    e_ent thread ai_explosive_death(100, 30, delay);
  }

  wait 0.5;
  e_ent = getent("catwalk1_floor_collision_model", "targetname");
  e_ent delete();
}

dukes_of_hazzard_trigger() {
  str_notify = "dukes_of_haz_choice";
  multiple_trigger_waits("dukes_of_hazzard_trigger", str_notify);
  level waittill(str_notify);
  level.player_soct_test_for_water = 1;
  level.dukes_of_hazard_mode = 1;
  level notify("abort_hints");
  screen_message_delete();
  level.player thread magic_bullet_shield();
  level.vh_player_soct disable_turret(1);
  wait 0.01;

  if(!level.console && !level.player gamepadusedlast())
    screen_message_create(&"PAKISTAN_SHARED_CHOOSE_VEHICLE_TO_FINISH_LEVEL_KEYBOARD");
  else
    screen_message_create(&"PAKISTAN_SHARED_CHOOSE_VEHICLE_TO_FINISH_LEVEL");

  e_can_switch_trigger = getent("vehicle_can_switch", "targetname");
  e_can_switch_trigger activate_trigger();
  wait 0.1;
  ts_start = 0.18;
  ts_end = 0.01;
  total_time = 100;
  delay = undefined;
  step_time = 0.1;
  level thread timescale_tween(ts_start, ts_end, total_time, delay, step_time);
  level thread check_vehicle_button_lt();
  level thread check_vehicle_button_rt();
  num_frames = 0;

  while(num_frames < 25) {
    if(level.dukes_of_hazard_mode == 2) {
      break;
    }

    if(level.dukes_of_hazard_mode == 3) {
      break;
    }

    num_frames++;
    wait 0.01;
  }

  screen_message_delete();
  level notify("dukes_of_hazard_button_choice_made");
  level notify("timescale_tween");
  level.player stop_magic_bullet_shield();
  level.vh_player_soct enable_turret(1);
  level thread timescale_tween(1, 1, 0);

  if(level.dukes_of_hazard_mode == 3) {
    level.switchto_drone_override_node = "drone_dukes_teleport_node";
    flag_set("vehicle_can_switch");
    level.player.viewlockedentity notify("change_seat");
    level thread drone_choice_helper_message(12);
    level thread drone_slowdown_for_time(3.5, 0.75);
    level thread hint_missile_helper_check();
  } else
    level.dukes_of_hazard_mode = 2;

  wait 0.5;

  if(isgodmode(level.player))
    flag_set("vehicle_can_switch");
  else
    flag_clear("vehicle_can_switch");
}

drone_slowdown_for_time(delay, speed) {
  level.player_drone_speed_scale = speed;
  wait(delay);

  while(level.player_drone_speed_scale < 1) {
    level.player_drone_speed_scale = level.player_drone_speed_scale + 0.1;
    wait 0.01;
  }

  level.player_drone_speed_scale = undefined;
}

check_vehicle_button_lt() {
  level endon("dukes_of_hazard_button_choice_made");

  while(true) {
    if(level.player usebuttonpressed()) {
      break;
    }

    wait 0.01;
  }

  level.dukes_of_hazard_mode = 2;
}

check_vehicle_button_rt() {
  level endon("dukes_of_hazard_button_choice_made");

  while(true) {
    if(!level.console && !level.player gamepadusedlast() && level.player reloadbuttonpressed()) {
      break;
    }

    if(level.player stancebuttonpressed()) {
      break;
    }

    wait 0.01;
  }

  level.dukes_of_hazard_mode = 3;
}

drone_choice_helper_message(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  wait 7;
  screen_message_delete();
}

slanted_building_soct_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("slanted_building_soct_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("slanted_building_soct");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 60);
  e_soct thread kill_vehicle_on_flag("pipe_fall_0");
}

soct_market_inside_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("soct_market_inside_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("soct_market_inside");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 60);
  e_soct thread kill_vehicle_on_flag("heli_crash_ready");
}

soct_market_outside_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("soct_market_outside_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("soct_market_outside");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
  e_soct thread kill_vehicle_on_flag("heli_crash_ready");
}

soct_post_broken_freeway_trigger(str_endon_notify) {
  level endon(str_endon_notify);
  e_trigger = getent("soct_post_broken_freeway_trigger", "targetname");
  e_trigger waittill("trigger");
  e_soct = spawn_vehicle_from_targetname("soct_post_broken_freeway");
  e_soct.overridevehicledamage = ::soct_player_attacker_damage_callback;
  nd_node = getvehiclenode(e_soct.target, "targetname");
  e_soct thread go_path(nd_node);
  e_soct thread enemy_soct_setup(0, level.vh_player_soct, undefined, 58);
  e_soct thread kill_vehicle_on_flag("pipe_fall_0");
}

drone_fire_at_market_walkway_trigger() {
  e_trigger = getent("drone_fire_at_market_walkway_trigger", "targetname");
  e_trigger waittill("trigger");

  if(maps\pakistan_s3_util::is_player_in_drone()) {
    return;
  }
  v_forward = anglestoforward(level.vh_player_drone.angles);
  v_up = anglestoup(level.vh_player_drone.angles);
  v_aim_pos = level.vh_player_drone.origin + v_forward * 5000 + v_up * 750;
  level.vh_player_drone setgunnertargetvec(v_aim_pos, 0);
  level.vh_player_drone setgunnertargetvec(v_aim_pos, 1);
  n_fire_time = weaponfiretime(level.vh_player_drone seatgetweapon(1));

  for(i = 0; i < 5; i++) {
    level.vh_player_drone firegunnerweapon(0);
    level.vh_player_drone firegunnerweapon(1);
    luinotifyevent(&"hud_gunner_missile_fire", 2, 1, int(n_fire_time * 1000));
    wait 0.15;
  }

  wait 0.5;
  catwalk1_trigger = getent("catwalk1_trigger", "targetname");

  if(isDefined(catwalk1_trigger)) {
    catwalk1_trigger activate_trigger();
    earthquake(0.4, 1.0, level.player.origin, 100);
  }
}

start_market_inside_guys_trigger() {
  e_trigger = getent("start_market_inside_guys_trigger", "targetname");
  e_trigger waittill("trigger");
  a_spawners = getentarray("start_market_inside_guys_spawner", "targetname");

  for(i = 0; i < a_spawners.size; i++) {
    e_ent = simple_spawn_single(a_spawners[i]);
    e_ent.goalradius = 48;
  }
}

hotel_crash_chopper_drone1() {
  e_trigger = getent("hotel_crash_chopper_drone_trigger", "targetname");
  e_trigger waittill("trigger");
  wait 12;
  vh_drone = spawn_vehicle_from_targetname("drone_respawner");
  vh_drone thread drone_follow_linked_structs("hotel_crash_chopper_drone1_path", 40, 1, 1, level.player, 1);
  target_clearreticlelockon();
}

market_fake_missile_breaks_window() {
  e_model = getent("pak_mall_glass", "targetname");
  e_model delete();
}

testline() {
  self endon("death");

  while(true) {
    v_start = self.origin;
    v_end = (v_start[0], v_start[1], v_start[2] + 500);
    line(v_start, v_end, (0, 0, 1), 4);
    wait 0.01;
  }

}