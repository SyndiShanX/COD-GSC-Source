/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm.gsc
*****************************************************/

main() {
  maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 3.5, 6.0);
  maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.45, 1.45);
  setsaveddvar("sm_sunShadowScale", 0.65);
  setsaveddvar("sm_sunsamplesizenear", 0.45);
  setsaveddvar("r_ssaofadedepth", 1200);
  maps\_utility::template_level("satfarm");
  maps\createart\satfarm_art::main();
  maps\satfarm_fx::main();
  maps\satfarm_precache::main();
  maps\satfarm_anim::main();
  maps\_utility::transient_init("satfarm_start_tr");
  maps\_utility::transient_init("satfarm_tower_tr");
  satfarm_starts();
  satfarm_precache();
  maps\satfarm_scriptlights::main();
  maps\_load::main();
  maps\satfarm_audio::main();
  maps\_rv_vfx::init();
  satfarm_global_flags();
  maps\satfarm_code_heli::chopper_ai_init();
  maps\satfarm_code_heli::heli_ai_collision_cylinder_setup();
  maps\satfarm_code::nav_mesh_build();
  maps\satfarm_code::init_system();
  maps\_drone_ai::init();
  maps\satfarm_code::generic_tank_dynamic_path_spawner_setup();
  maps\satfarm_code::generic_gaz_spawner_setup();
  maps\satfarm_code::generic_tank_spawner_setup();
  maps\_utility::array_spawn_function_noteworthy("hangar_runner", maps\satfarm_air_strip::hangar_runner_anims);
  maps\_utility::array_spawn_function_noteworthy("crawling_guys", maps\satfarm_code::crawling_guys_spawnfunc);
  maps\_utility::array_spawn_function_noteworthy("limping_guys", maps\satfarm_code::limping_guys_spawnfunc);
  maps\_utility::array_spawn_function_noteworthy("air_strip_quick_cleanup_enemies", maps\satfarm_air_strip::air_strip_ai_quick_cleanup_spawn_function, 12250000);
  maps\_utility::array_spawn_function_noteworthy("base_array_enemies", maps\satfarm_base_array::base_array_ai_cleanup_spawn_function);
  maps\_utility::array_spawn_function_noteworthy("sandbag_bunker_gunner", maps\satfarm_air_strip::sandbag_bunker_gunner_spawn_function);
  maps\_utility::array_spawn_function_targetname("sat_array_initial_flank_enemies", maps\satfarm_code::delayed_kill, randomfloatrange(0.1, 3.0), "start_base_array_mortar_strike");
  maps\_utility::array_spawn_function_targetname("sat_array_end_enemies", maps\satfarm_code::delayed_kill, randomfloatrange(0.1, 3.0), "start_base_array_mortar_strike");
  maps\satfarm_fx::create_view_particle_source();
  setnorthyaw(0.0);
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 9, 9);
  maps\satfarm_ambient_a10::a10_precache();
  maps\satfarm_ambient_a10::a10_spawn_funcs();
  level.corpseflag = "satfarmCorpseLevelFlag";
  common_scripts\utility::flag_init(level.corpseflag);
  common_scripts\utility::flag_set(level.corpseflag);
  maps\satfarm_code::sand_effects_init();
  level.default_level_vision_set = "satfarm";
  thread maps\satfarm_code::satfarm_corpse_cleanup();
}

satfarm_starts() {
  maps\_utility::add_start("intro", maps\satfarm_intro::intro_init, "Intro", maps\satfarm_intro::intro_main, "satfarm_start_tr");
  maps\_utility::add_start("crash_site", maps\satfarm_crash_site::crash_site_init, "Crash Site", maps\satfarm_crash_site::crash_site_main, "satfarm_start_tr");
  maps\_utility::add_start("base_array", maps\satfarm_base_array::base_array_init, "Base Array", maps\satfarm_base_array::base_array_main, "satfarm_start_tr");
  maps\_utility::add_start("air_strip", maps\satfarm_air_strip::air_strip_init, "Air Strip", maps\satfarm_air_strip::air_strip_main, "satfarm_tower_tr");
  maps\_utility::add_start("air_strip_secured", maps\satfarm_air_strip_secured::air_strip_secured_init, "Air Strip Secured", maps\satfarm_air_strip_secured::air_strip_secured_main, "satfarm_tower_tr");
  maps\_utility::add_start("tower", maps\satfarm_tower::tower_init, "Tower", maps\satfarm_tower::tower_main, "satfarm_tower_tr");
  maps\_utility::add_start("post_missile_launch", maps\satfarm_tower::post_missile_launch_init, "Post Missile Launch", maps\satfarm_tower::post_missile_launch_main, "satfarm_tower_tr");
  maps\_utility::add_start("warehouse", maps\satfarm_tower::warehouse_init, "Warehouse", maps\satfarm_tower::warehouse_main, "satfarm_tower_tr");
  maps\_utility::default_start(maps\satfarm_intro::intro_init);
  maps\_utility::set_default_start("intro");
}

satfarm_global_flags() {
  common_scripts\utility::flag_init("player_in_tank");
  common_scripts\utility::flag_init("intro_end");
  common_scripts\utility::flag_init("crash_site_end");
  common_scripts\utility::flag_init("base_array_end");
  common_scripts\utility::flag_init("air_strip_end");
  common_scripts\utility::flag_init("air_strip_secured_end");
  common_scripts\utility::flag_init("tower_end");
  common_scripts\utility::flag_init("post_missile_launch_end");
  common_scripts\utility::flag_init("warehouse_end");
  common_scripts\utility::flag_init("bridge_deploy_end");
  common_scripts\utility::flag_init("all_tanks_stop_firing");
  common_scripts\utility::flag_init("stop_red_flickering_light");
  common_scripts\utility::flag_init("hangar_blasted");
  common_scripts\utility::flag_init("nostopping");
  common_scripts\utility::flag_init("MG_FIRE");
  common_scripts\utility::flag_init("PLAYER_FIRED_MG_ONCE");
  common_scripts\utility::flag_init("THERMAL_ON");
  common_scripts\utility::flag_init("PLAYER_TURNED_ON_THERMAL_ONCE");
  common_scripts\utility::flag_init("PLAYER_ZOOMED_ONCE");
  common_scripts\utility::flag_init("ZOOM_ON");
  common_scripts\utility::flag_init("POPPED_SMOKE");
  common_scripts\utility::flag_init("PLAYER_POPPED_SMOKE_ONCE");
  common_scripts\utility::flag_init("DISPLAYED_WEAPON_TOGGLE_HINT_ONCE");
  common_scripts\utility::flag_init("stop_turbulence");
  common_scripts\utility::flag_init("cargo_doors_opened");
  common_scripts\utility::flag_init("GUIDED_ROUND_ENABLED");
  common_scripts\utility::flag_init("PLAYER_FIRED_GUIDED_ROUND");
  common_scripts\utility::flag_init("PLAYER_GUIDING_ROUND");
  common_scripts\utility::flag_init("enough_crash_site_enemies_dead");
  common_scripts\utility::flag_init("air_strip_secured_begin");
  common_scripts\utility::flag_init("spawn_sat_view_ally_choppers");
  common_scripts\utility::flag_init("chopper_flyin_begin");
  common_scripts\utility::flag_init("ghost1_start_firing");
  common_scripts\utility::flag_init("ghost2_landed");
  common_scripts\utility::flag_init("ghost1_is_jumping");
  common_scripts\utility::flag_init("start_jump");
  common_scripts\utility::flag_init("player_landed");
  common_scripts\utility::flag_init("tower_begin");
  common_scripts\utility::flag_init("spawn_control_room_enemies_wave_2");
  common_scripts\utility::flag_init("control_room_three_left");
  common_scripts\utility::flag_init("control_room_enemies_dead");
  common_scripts\utility::flag_init("turn_move_allies_to_breach_entrance_trigger_on");
  common_scripts\utility::flag_init("ready_for_breach");
  common_scripts\utility::flag_init("breach_start");
  common_scripts\utility::flag_init("player_shot_extinguisher");
  common_scripts\utility::flag_init("ghost1_shot_extinguisher");
  common_scripts\utility::flag_init("breach_room_enemies_dead");
  common_scripts\utility::flag_init("ghost1_at_table");
  common_scripts\utility::flag_init("trajectory_updated");
  common_scripts\utility::flag_init("show_mantis_turrets");
  common_scripts\utility::flag_init("ready_to_launch");
  common_scripts\utility::flag_init("missile_launch_start");
  common_scripts\utility::flag_init("silo_doors_open");
  common_scripts\utility::flag_init("missile_launched");
  common_scripts\utility::flag_init("bad_guy_on_radio");
  common_scripts\utility::flag_init("go_get_bad_guy");
  common_scripts\utility::flag_init("start_breach_outside_ambience");
  common_scripts\utility::flag_init("tank_enemies_killed");
  common_scripts\utility::flag_init("post_missile_launch_begin");
  common_scripts\utility::flag_init("post_missile_launch_breach_done");
  common_scripts\utility::flag_init("loading_bay_enemies_wave_2");
  common_scripts\utility::flag_init("loading_bay_enemies_retreat");
  common_scripts\utility::flag_init("all_enemies_out_of_loading_bay");
  common_scripts\utility::flag_init("most_ghost1_to_elevator_room");
  common_scripts\utility::flag_init("send_in_wave_2");
  common_scripts\utility::flag_init("send_in_elevator");
  common_scripts\utility::flag_init("elevator_enemies_unload");
  common_scripts\utility::flag_init("elevator_room_cleared");
  common_scripts\utility::flag_init("warehouse_begin");
  common_scripts\utility::flag_init("player_shot_at_enemies_in_warehouse");
  common_scripts\utility::flag_init("allies_in_elevator");
  common_scripts\utility::flag_init("player_and_allies_in_elevator");
  common_scripts\utility::flag_init("elevator_landed");
  common_scripts\utility::flag_init("unload_elevator");
  common_scripts\utility::flag_init("lift_landed");
  common_scripts\utility::flag_init("warehouse_enemies_alerted");
  common_scripts\utility::flag_init("start_warehouse_runners");
  common_scripts\utility::flag_init("advance_allies_wave_2_flag");
  common_scripts\utility::flag_init("advance_allies_wave_3_flag");
  common_scripts\utility::flag_init("advance_allies_wave_3a_flag");
  common_scripts\utility::flag_init("advance_allies_wave_4_flag");
  common_scripts\utility::flag_init("warehouse_last_push");
  common_scripts\utility::flag_init("ghost1_at_train_node");
  common_scripts\utility::flag_init("send_allies_to_train");
  common_scripts\utility::flag_init("player_train_trigger_on");
  common_scripts\utility::flag_init("player_train_trigger");
  common_scripts\utility::flag_init("ghost1_on_train");
  common_scripts\utility::flag_init("dismounted_tank");
  common_scripts\utility::flag_init("missile_out_of_bounds");
  common_scripts\utility::flag_init("optics_out");
  common_scripts\utility::flag_init("smoke_out");
  common_scripts\utility::flag_init("tow_out");
  common_scripts\utility::flag_init("compass_out");
  common_scripts\utility::flag_init("thermal_out");
  common_scripts\utility::flag_init("all_guns_out");
  common_scripts\utility::flag_init("final_hit");
}

satfarm_precache() {
  precachedigitaldistortcodeassets();
  precacheitem("lsat");
  precacheitem("kriss");
  precacheitem("rpg_straight");
  precacheitem("tankfire_straight_fast");
  precacheitem("zippy_rockets_apache");
  precacheshader("thermalbody_snowlevel");
  precacheturret("player_view_controller");
  precachemodel("tag_turret");
  precacheshader("m1a1_compass_center");
  precacheshader("m1a1_compass_enemy");
  precacheshader("m1a1_compass_objective");
  precacheshader("m1a1_compass_scanline");
  precacheshader("m1a1_tank_missile_reticle_inner_bottom_left");
  precacheshader("m1a1_tank_missile_reticle_inner_bottom_left_cyan");
  precacheshader("m1a1_tank_missile_reticle_inner_bottom_left_red");
  precacheshader("m1a1_tank_missile_reticle_inner_bottom_right");
  precacheshader("m1a1_tank_missile_reticle_inner_bottom_right_cyan");
  precacheshader("m1a1_tank_missile_reticle_inner_bottom_right_red");
  precacheshader("m1a1_tank_missile_reticle_inner_top_left");
  precacheshader("m1a1_tank_missile_reticle_inner_top_left_cyan");
  precacheshader("m1a1_tank_missile_reticle_inner_top_left_red");
  precacheshader("m1a1_tank_missile_reticle_inner_top_right");
  precacheshader("m1a1_tank_missile_reticle_inner_top_right_cyan");
  precacheshader("m1a1_tank_missile_reticle_inner_top_right_red");
  precacheshader("m1a1_tank_sabot_fuel_gauge");
  precacheshader("m1a1_tank_sabot_fuel_range");
  precacheshader("m1a1_tank_sabot_fuel_range_horizontal");
  precacheshader("m1a1_tank_sabot_grid_overlay");
  precacheshader("m1a1_tank_sabot_reticle_center");
  precacheshader("m1a1_tank_sabot_reticle_center_cyan");
  precacheshader("m1a1_tank_sabot_reticle_center_red");
  precacheshader("m1a1_tank_sabot_reticle_outer_left");
  precacheshader("m1a1_tank_sabot_reticle_outer_left_cyan");
  precacheshader("m1a1_tank_sabot_reticle_outer_left_red");
  precacheshader("m1a1_tank_sabot_reticle_outer_right");
  precacheshader("m1a1_tank_sabot_reticle_outer_right_cyan");
  precacheshader("m1a1_tank_sabot_reticle_outer_right_red");
  precacheshader("m1a1_tank_sabot_target_range");
  precacheshader("m1a1_tank_sabot_vignette");
  precacheshader("m1a1_tank_primary_reticle");
  precacheshader("m1a1_tank_primary_reticle_center");
  precacheshader("m1a1_tank_primary_reticle_center_cyan");
  precacheshader("m1a1_tank_primary_reticle_center_red");
  precacheshader("m1a1_tank_primary_reticle_cross");
  precacheshader("m1a1_tank_primary_reticle_cross_cyan");
  precacheshader("m1a1_tank_primary_reticle_cross_red");
  precacheshader("m1a1_tank_weapon_progress_bar");
  precacheshader("m1a1_tank_weapon_progress_bar_infinite");
  precacheshader("m1a1_tank_weapon_select_arrow");
  precacheshader("green_block");
  precacheshader("red_block");
  precacheshader("ugv_screen_overlay");
  precacheshader("ugv_vignette_overlay");
  precacheshader("overlay_static");
  precacheshader("m1a1_tank_sabot_scanline");
  precacheshader("m1a1_tank_screen_crack_left");
  precacheshader("m1a1_tank_screen_crack_right");
  precacheshader("m1a1_tank_warning");
  precacheshader("m1a1_hud_tank_body");
  precacheshader("m1a1_hud_tank_turret");
  precacheitem("sabot_guided");
  precacheitem("sabot_guided_detonate");
  precachestring(&"SATFARM_RANGE_ON_TARGET");
  precachestring(&"SATFARM_FUEL_RANGE");
  precachestring(&"SATFARM_FUELRANGE");
  precachestring(&"SATFARM_RANGE_1");
  precachestring(&"SATFARM_RANGE_2");
  precachestring(&"SATFARM_RANGE_3");
  precachestring(&"SATFARM_RANGE_4");
  precachestring(&"SATFARM_RANGE_5");
  precachestring(&"SATFARM_INITIALIZING");
  precachestring(&"SATFARM_SYSTEM_CHECK");
  precachestring(&"SATFARM_READY");
  precachestring(&"SATFARM_IDLE");
  precachestring(&"SATFARM_MACHING_GUN");
  precachestring(&"SATFARM_MISSILE");
  precachestring(&"SATFARM_TURRET");
  precachestring(&"SATFARM_SMOKE");
  precachestring(&"SATFARM_MPH");
  precachestring(&"SATFARM_LOADING");
  precachestring(&"SATFARM_ONLINE");
  precachemodel("viewhands_player_gs_stealth");
  precachemodel("viewhands_gs_stealth");
  precachemodel("saf_federation_crate");
  precachemodel("saf_federation_crate_small");
  precachemodel("carrier_red_toolbox");
  precachemodel("generic_prop_raven");
  precachemodel("vehicle_m880_launcher_destroyed");
  precachemodel("saf_satellite_destroyed_anim_dish");
  precachemodel("saf_satellite_destroyed_anim_base");
  precachemodel("vehicle_a10_warthog");
  precachemodel("accessories_windsock_large");
  precacheshader("overlay_static");
  precacheshader("ac130_hud_diamond");
  precacheshader("remotemissile_infantry_target");
  precacheshader("uav_vehicle_target");
  precacheshader("veh_hud_target");
  precacheshader("veh_hud_friendly");
  precacheshader("ac130_hud_diamond");
  precacheshader("ac130_hud_tag");
  precacheshader("button_360_rt");
  precacheshader("button_360_x");
  precacheshader("cinematic");
  precachemodel("saf_hangar_fence_breach_fence_left");
  precachemodel("saf_hangar_fence_breach_fence_right");
  precachemodel("saf_hangar_fence_breach_gate");
  precachemodel("vehicle_m1a2_abrams_iw6_dmg");
  precachemodel("vehicle_m1a2_abrams_iw6_non_anim");
  precacheshader("ac130_hud_enemy_vehicle_target_s_w");
  precacheshader("ac130_hud_friendly_vehicle_diamond_s_w");
  precachemodel("viewhands_player_delta");
  precachemodel("viewhands_player_us_rangers");
  precachemodel("viewhands_player_us_army");
  precachemodel("viewlegs_us_ranger");
  precachemodel("projectile_m203grenade");
  precachemodel("vehicle_boeing_c17");
  precachemodel("vehicle_m1a2_abrams_viewmodel");
  precachemodel("saf_parachute_small");
  precachemodel("saf_parachute_large");
  precachemodel("saf_c17_hanging_net_animated");
  precachemodel("saf_streetlight_01");
  precachemodel("saf_streetlight_broken_01");
  precachemodel("saf_streetlight_broken_02");
  precachemodel("saf_parking_post_01");
  precachemodel("saf_large_sign_01");
  precachemodel("projectile_slamraam_missile");
  precacherumble("subtler_tank_rumble");
  precacherumble("subtle_tank_rumble");
  precacherumble("tank_missile");
  precacherumble("ac130_artillery_rumble");
  precacherumble("ac130_40mm_fire");
  precacheshellshock("satfarm_blackout");
  precacheshellshock("satfarm_explosion");
  precachemodel("weapon_blackhawk_minigun");
  precachemodel("saf_exit_door_right_obj");
  precachemodel("clk_fire_extinguisher_lrg_anim");
  precacheitem("javelin_satfarm");
  precacherumble("missile_launch");
  precachemodel("saf_car_troop_handrails");
  precachemodel("saf_train_whole_01");
  precacheitem("missile_attackheli");
  maps\_utility::intro_screen_create(&"SATFARM_INTROSCREEN_LINE_1", & "SATFARM_INTROSCREEN_LINE_2", & "SATFARM_INTROSCREEN_LINE_3", & "SATFARM_INTROSCREEN_LINE_4");
  maps\_utility::add_hint_string("HINT_SWITCH_TO_GUIDED_ROUND", & "SATFARM_HINT_SWITCH_TO_GUIDED_ROUND", ::hint_switch_to_guided_round_off);
  maps\_utility::add_hint_string("HINT_GUIDED_ROUND_FIRE", & "SATFARM_HINT_GUIDED_ROUND_FIRE", ::hint_guided_round_fire_off);
  maps\_utility::add_hint_string("HINT_GUIDED_ROUND_GUIDING", & "SATFARM_HINT_GUIDED_ROUND_GUIDING", ::hint_guided_round_guiding_off);
  maps\_utility::add_hint_string("HINT_GUIDED_ROUND_GUIDING_TOGGLEADS_THROW", & "SATFARM_HINT_GUIDED_ROUND_GUIDING_TOGGLEADS_THROW", ::hint_guided_round_guiding_off);
  maps\_utility::add_hint_string("HINT_THERMAL", & "SATFARM_HINT_THERMAL", ::hint_thermal_off);
  maps\_utility::add_hint_string("HINT_TOGGLE_THERMAL", & "SATFARM_HINT_TOGGLE_THERMAL", ::hint_toggle_thermal_off);
  maps\_utility::add_hint_string("HINT_MACHINE_GUN", & "SATFARM_HINT_MACHINE_GUN", ::hint_machine_gun_off);
  maps\_utility::add_hint_string("HINT_SMOKE", & "SATFARM_HINT_SMOKE", ::hint_smoke_off);
  maps\_utility::add_hint_string("HINT_JUMP", & "SATFARM_JUMP", maps\satfarm_air_strip_secured::hint_jump_off);
  precachestring(&"SATFARM_MISSILE_LAUNCH");
  precachestring(&"SATFARM_MISSILE_LAUNCH_CONSOLE");
  precachestring(&"SATFARM_BREACH");
  precachestring(&"SATFARM_BREACH_CONSOLE");
  maps\_utility::add_hint_string("HINT_WEAPON_TOGGLE", & "SATFARM_HINT_WEAPON_TOGGLE", ::hint_weapon_toggle_off);
  maps\_utility::add_hint_string("HINT_ZOOM_SPEED_THROW", & "SATFARM_HINT_ZOOM_SPEED_THROW", ::hint_zoom_off);
  maps\_utility::add_hint_string("HINT_ZOOM_SPEED", & "SATFARM_HINT_ZOOM_SPEED", ::hint_zoom_off);
  maps\_utility::add_hint_string("HINT_ZOOM_TOGGLEADS_THROW", & "SATFARM_HINT_ZOOM_TOGGLEADS_THROW", ::hint_zoom_off);
  maps\_utility::add_hint_string("HINT_ZOOM_TOGGLEADS", & "SATFARM_HINT_ZOOM_TOGGLEADS", ::hint_zoom_off);
  precachestring(&"SATFARM_INTROSCREEN_GHOST_LINE_2");
  precachestring(&"SATFARM_INTROSCREEN_GHOST_LINE_3");
  precachestring(&"SATFARM_INTROSCREEN_GHOST_LINE_4");
}

hint_zoom_off() {
  return common_scripts\utility::flag("ZOOM_ON") || common_scripts\utility::flag("GUIDED_ROUND_ENABLED");
}

hint_thermal_off() {
  return common_scripts\utility::flag("THERMAL_ON") || !common_scripts\utility::flag("player_in_tank");
}

hint_toggle_thermal_off() {
  return !common_scripts\utility::flag("THERMAL_ON") || !common_scripts\utility::flag("player_in_tank");
}

hint_machine_gun_off() {
  return common_scripts\utility::flag("MG_FIRE") || !common_scripts\utility::flag("player_in_tank");
}

hint_smoke_off() {
  return common_scripts\utility::flag("POPPED_SMOKE") || !common_scripts\utility::flag("player_in_tank");
}

hint_switch_to_guided_round_off() {
  return common_scripts\utility::flag("GUIDED_ROUND_ENABLED") || !common_scripts\utility::flag("player_in_tank");
}

hint_guided_round_fire_off() {
  return common_scripts\utility::flag("PLAYER_FIRED_GUIDED_ROUND") || !common_scripts\utility::flag("GUIDED_ROUND_ENABLED") || !common_scripts\utility::flag("player_in_tank");
}

hint_guided_round_guiding_off() {
  return !common_scripts\utility::flag("PLAYER_GUIDING_ROUND") || !common_scripts\utility::flag("GUIDED_ROUND_ENABLED");
}

hint_weapon_toggle_off() {
  return !common_scripts\utility::flag("GUIDED_ROUND_ENABLED") || !common_scripts\utility::flag("player_in_tank");
}