/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_rog.gsc
*****************************************************/

section_main() {
  level.timestep = 0.05;
  level.rog_explosion_radius = [];
  level.rog_explosion_radius["rod"] = 8112;
  level.rog_explosion_radius["danger_close"] = 10050;
  level.rog_explosion_radius["missile"] = 1536;
  level.rog_explosion_radius["tank"] = 512;
  level.rog_explosion_grow_time = 3;
  level.crater_array = [];
  level.rog_blast_markers = [];
  level.rog_max_waypoints = 160;
  level.rog_current_lookat_node_index = 0;
  level.rog_reticle_hieght = -127675;
  level.rog_active_visibilty_volume = undefined;
  level.rog_visibility_volume_index = 0;
  level.rog_train = [];
  level.current_target_hud_count = 0;
  level.rog_target_models = [];
  level.rog_fx_delay = 0.25;
  level.rog_ff_fail = 0;
  level.rog_track_fail = 0;
  level.rog_section = 0;
  level.rog_in_flight = 0;
  level.rog_strike_active = 0;
  level.rog_full_sequence_max_time = 90.0;
  level.rog_num_enemy_targets_killed = 0;
  level.rog_achievement_target_count = 0;
  level.rog_achievement_target_count_adjustment = 0;
  level.vfx_debug_do_rog_impact_effect = 1;
  level.vfx_debug_do_rog_post_hit_vfx = 0;
  level.vfx_debug_do_structure_destruction = 1;
  level.vfx_debug_do_shockwave = 0;
  level.rog_pass_fail = ["allies", "axis"];
  level.rog_pass_fail["allies"] = ["a", "b", "c", "targets"];
  level.rog_pass_fail["axis"] = ["a", "b", "c", "targets"];
  level.rog_pass_fail["allies"]["a"] = 0;
  level.rog_pass_fail["allies"]["b"] = 0;
  level.rog_pass_fail["allies"]["c"] = 20;
  level.rog_pass_fail["allies"]["targets"] = 0;
  level.rog_pass_fail["axis"]["a"] = 2;
  level.rog_pass_fail["axis"]["b"] = 2;
  level.rog_pass_fail["axis"]["c"] = 1;
  level.rog_pass_fail["axis"]["targets"] = 0;
  level.rog_single_velocity_max = 54000.0;
  level.rog_single_acceleration = 90000;
  level.rog_uav_lookat_pos = [];
  level.rog_uav_lookat_pos[0] = (-704, -10769, -128435);
  level.rog_uav_lookat_pos[1] = (-9108, -55463, -128435);
  level.rog_uav_lookat_pos[2] = (-1677, -47165, -128435);
  level.rog_uav_lookat_pos[3] = (2862, -30098, -128435);
  level.rog_uav_lookat_pos[4] = (-10950, -11861, -128435);
  level.rog_uav_lookat_pos[5] = (-7046, 13586, -128435);
  level.rog_uav_lookat_pos[6] = (-25438, 28952, -128435);
  level.static_lines = [];
  level.static_lines[0] = "ac130_overlay_pip_static_a";
  level.static_lines[1] = "ac130_overlay_pip_static_b";
  level.static_lines[2] = "ac130_overlay_pip_static_c";
  maps\_utility::add_hint_string("activate_console_hint", &"LOKI_ACTIVATE_CONSOLE", ::console_hint_button_press);
  maps\_utility::add_hint_string("activate_console_hint_pc", &"LOKI_ACTIVATE_CONSOLE_PC", ::console_hint_button_press_pc);
  maps\_utility::add_hint_string("press_to_fire", &"LOKI_PRESS_TO_FIRE", ::fire_hint_button_press);
}

section_precache() {
  precacheturret("player_view_controller");
  precacheturret("player_view_controller_loki");
  precacherumble("steady_rumble");
  precachemodel("ac_prs_ter_crater_a_1");
  precachemodel("afr_bg_building_04");
  precachemodel("loki_rog_crater_01");
  precachemodel("loki_rog_dish_frame_destroyed");
  precachemodel("tag_turret");
  precachemodel("vehicle_m880_launcher_low");
  precachemodel("vehicle_m880_launcher_destroyed_low");
  precachemodel("vehicle_uav");
  precachemodel("projectile_sidewinder_missile");
  precachemodel("vehicle_battle_hind_destroyed");
  precachemodel("vehicle_t90ms_tank_destroyed_iw6_low");
  precachemodel("vehicle_t90ms_tank_iw6_low");
  precachemodel("vehicle_m1a2_abrams_iw6_low");
  precachemodel("vehicle_m1a2_abrams_iw6_dmg_low");
  precachemodel("loki_rog_dish_d1");
  precachemodel("loki_rog_dish_d2");
  precachemodel("loki_rog_dish_d3");
  precachemodel("loki_rog_dish_d4");
  precachemodel("loki_rog_dish_d5");
  precachemodel("loki_rog_dish_d6");
  precachemodel("loki_rog_dish_d7");
  precachemodel("loki_rog_dish_d8");
  precachemodel("vehicle_mig29_destroyed_back_low");
  precachemodel("vehicle_mig29_destroyed_front_low");
  precachemodel("vehicle_mig29_destroyed_tail_piece_low");
  precacheitem("hunted_crash_missile");
  precacheshader("ac130_overlay_pip_static_a");
  precacheshader("ac130_overlay_pip_static_b");
  precacheshader("ac130_overlay_pip_static_c");
  maps\loki_rog_hud::section_precache();
}

section_flag_inits() {
  common_scripts\utility::flag_init("starting_anim_done");
  common_scripts\utility::flag_init("attack_pressed");
  common_scripts\utility::flag_init("dont_show_pull_trigger_hint");
  common_scripts\utility::flag_init("dont_show_zoom_hint");
  common_scripts\utility::flag_init("final_descent_active");
  common_scripts\utility::flag_init("skip_start_vo");
  common_scripts\utility::flag_init("ROG_can_fire");
  common_scripts\utility::flag_init("player_is_firing");
  common_scripts\utility::flag_init("allies_been_hit");
  common_scripts\utility::flag_init("enemies_been_hit");
  common_scripts\utility::flag_init("rog_intro_player_flipped_switch");
  common_scripts\utility::flag_init("ROG_is_cooling_down");
  common_scripts\utility::flag_init("ROG_hit_loc_1");
  common_scripts\utility::flag_init("ROG_hit_loc_2");
  common_scripts\utility::flag_init("ROG_hit_loc_3");
  common_scripts\utility::flag_init("ROG_hit_loc_4");
  common_scripts\utility::flag_init("ROG_exit");
  common_scripts\utility::flag_init("ROG_section_done");
  common_scripts\utility::flag_init("ROG_take_in_battle_scene");
  common_scripts\utility::flag_init("ROG_look_at_sat_farm");
  common_scripts\utility::flag_init("ROG_look_at_train");
  common_scripts\utility::flag_init("ROG_look_at_main_base");
  common_scripts\utility::flag_init("ROG_look_at_airfield");
  common_scripts\utility::flag_init("ROG_take_in_destruction");
  common_scripts\utility::flag_init("ROG_early_out");
  common_scripts\utility::flag_init("ROG_script_done");
  common_scripts\utility::flag_init("ROG_no_fail");
  common_scripts\utility::flag_init("ROG_VO_script_active");
  common_scripts\utility::flag_init("click_too_soon");
  common_scripts\utility::flag_init("rog_controls_start_done");
  common_scripts\utility::flag_init("rog_vo_0");
  common_scripts\utility::flag_init("ROG_passed");
}

rog_start() {
  common_scripts\utility::flag_init("space_breach_vo_done");
  thread delete_all_ents();
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\loki_util::player_move_to_checkpoint_start("rog");
  maps\loki_util::spawn_allies();
  common_scripts\utility::flag_set("skip_start_vo");
  common_scripts\utility::flag_set("space_breach_vo_done");

  foreach(var_1 in level.allies) {
    var_1 maps\_utility::disable_ai_color();
    var_1 setgoalpos(var_1.origin);
  }

  maps\loki_space_breach::create_rog_controls();
  thread maps\loki_space_breach::set_flags_on_input();
  common_scripts\utility::flag_set("turn_off_rogs");
  level notify("stop_close_rogs");
}

rog() {
  maps\loki_util::loki_autosave_by_name_silent("rog");

  if(!common_scripts\utility::flag("skip_start_vo")) {
    wait_till_player_uses_terminal();
    maps\loki_util::loki_autosave_by_name_silent("rog");
  }

  thread maps\loki_fx::light_rog_threads();
  maps\_utility::stop_exploder("be_stm_01");
  common_scripts\utility::exploder("lod_big_smoke");
  maps\loki_fx::fx_helmet_mask_off();
  thread maps\loki_fx::fx_rog_amb_exp();
  level thread rog_logic();
  common_scripts\utility::flag_wait("rog_done");
  common_scripts\utility::flag_wait("ROG_script_done");
  rog_exit();
  setsaveddvar("sm_sunSampleSizeNear", ".15");
  maps\_utility::vision_set_fog_changes("loki", 0);
}

rog_init() {
  thread maps\loki_audio::sfx_set_rog_amb();
  level.space_breathing_enabled = 0;
  thread checking_for_hits();
  level.player_mover = (0, 0, 0);
  level.rog_aoe_reticle = getent("AOE", "targetname");
  level.rog_aoe_reticle hide();
  level.rog_aoe_reticle notsolid();

  for(var_0 = 0; var_0 < 8; var_0++) {
    level.rog_blast_markers[var_0] = getent("blast_marker_" + var_0, "targetname");
    level.rog_blast_markers[var_0] notsolid();
    level.rog_blast_markers[var_0] hide();
    level.rog_blast_markers[var_0].time = undefined;
  }

  level.player.ignoreme = 1;
  common_scripts\utility::flag_clear("ROG_can_fire");
  level thread rog_setup_structures();
  level.player hideviewmodel();
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowjump(0);
  level.player allowlean(0);
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowads(0);
  setsaveddvar("scr_dof_enable", "0");
  level.uav_model = spawn("script_model", level.player.origin);
  level.uav_model setModel("vehicle_uav");
  level.uav_model.angles = level.player.angles;
  level.player playerlinkto(level.uav_model, "TAG_PLAYER");
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level maps\_utility::delaythread(0.1, maps\loki_rog_hud::rog_hud);
  rog_achievement_gather_targets();
  rog_update_visibility_volume_empty();
  thread script_move_vehicles();
  thread set_rog_section_gravity();
  thread setup_rog_warscene();
  level.player thread rog_uav_camera_move_audio();
  level thread rog_check_early_out();
  level thread rog_reveal_audio();
}

rog_mission_dialogue() {
  level endon("fail");
  level thread maps\_utility::notify_delay("ROG_initial_reveal", 17.7);
  maps\_utility::delaythread(11.2, ::rog_update_visibility_volume);
  maps\_utility::delaythread(11.7, common_scripts\utility::flag_set, "ROG_can_fire");
  level.player setclientomnvar("ui_loki_rog_message_progress", 12.0);
  wait 3.5;
  common_scripts\utility::flag_set("ROG_VO_script_active");
  maps\_utility::smart_radio_dialogue("loki_us6_droneisenteringdesignated");
  wait 1.3;
  maps\_utility::smart_radio_dialogue("loki_us6_ohman");
  maps\_utility::smart_radio_dialogue("loki_mrk_icarusfocusfireon");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  common_scripts\utility::flag_set("ROG_VO_script_active");
  maps\_utility::smart_radio_dialogue("loki_us3_targetingonlinefirewhen");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  level thread rog_vo_section_a();
  common_scripts\utility::flag_wait("ROG_look_at_train");
  wait 0.05;

  if(common_scripts\utility::flag("missionfailed")) {
    return;
  }
  level thread maps\_utility::notify_delay("early_fail_check", 4.95);
  maps\_utility::delaythread(1.0, ::rog_update_visibility_volume_empty);
  maps\_utility::delaythread(0.5, common_scripts\utility::flag_clear, "ROG_can_fire");
  level.player common_scripts\utility::delaycall(0.5, ::setclientomnvar, "ui_loki_rog_message_progress", 10.3);
  maps\_utility::delaythread(0.5, ::rog_tag_train);
  common_scripts\utility::flag_waitopen("ROG_VO_script_active");
  thread maps\_utility::notify_delay("ROG_reveal_allies", 6);
  common_scripts\utility::flag_set("ROG_VO_script_active");
  maps\_utility::smart_radio_dialogue("loki_mrk_icarusactualcommand");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  level maps\_utility::delaythread(2.2, ::rog_update_visibility_volume);
  level maps\_utility::delaythread(2.7, common_scripts\utility::flag_set, "ROG_can_fire");
  wait 1;
  level.rog_section = 1;
  common_scripts\utility::flag_set("ROG_VO_script_active");
  level.player setclientomnvar("ui_loki_rog_section", 1);
  maps\_utility::smart_radio_dialogue("loki_mrk_icarusnowfeedingyou");
  maps\_utility::smart_radio_dialogue("loki_kgn_lockingintarget");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  level thread rog_vo_section_b();
  wait 5.5;
  maps\_utility::delaythread(5.0, common_scripts\utility::flag_clear, "ROG_can_fire");
  maps\_utility::delaythread(5.0, ::rog_update_visibility_volume_empty);
  common_scripts\utility::flag_wait("ROG_look_at_airfield");
  wait 0.05;

  if(common_scripts\utility::flag("missionfailed")) {
    return;
  }
  common_scripts\utility::flag_set("ROG_VO_script_active");
  level.player setclientomnvar("ui_loki_rog_message_progress", 3.9);
  maps\_utility::smart_radio_dialogue("loki_mrk_heavyarmorhasbeen");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  wait 0.5;
  common_scripts\utility::flag_set("ROG_VO_script_active");
  level maps\_utility::delaythread(1.5, ::rog_update_visibility_volume);
  maps\_utility::smart_radio_dialogue("loki_mrk_groundunitsarebeing");
  level.player setclientomnvar("ui_loki_rog_section", 2);
  level.rog_section = 2;
  maps\_utility::delaythread(0, common_scripts\utility::flag_set, "ROG_can_fire");
  maps\_utility::smart_radio_dialogue("loki_gs3_visualconfirmedtargeting");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  level thread rog_vo_section_c();
  common_scripts\utility::flag_wait_any("ROG_take_in_destruction", "ROG_early_out");
  wait 0.05;

  if(common_scripts\utility::flag("missionfailed")) {
    return;
  }
  level thread maps\loki_ending::ending_bink_display();
  level thread maps\loki_ending::ending_ally_anims();
  common_scripts\utility::flag_set("ROG_VO_script_active");
  maps\_utility::smart_radio_dialogue("loki_mrk_goodworkicaruslocal");
  common_scripts\utility::flag_clear("ROG_VO_script_active");
  wait 1.0;
  common_scripts\utility::flag_set("ROG_script_done");
}

script_train_stuff_02() {
  var_0 = getvehiclenode("node_target_mover_train_01", "targetname");
  var_1 = [1.0, 0.75, 0.85, 0.85, 0.85, 1.0, 1.15, 1.0];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = getent("script_model_train_0" + (var_2 + 1), "targetname");
    var_4 = getent("vehicle_target_mover_train_0" + (var_2 + 1), "targetname");
    var_3 linkto(var_4);
    var_4 attachpath(var_0);
    level.rog_train[var_2] = var_3;
    level.rog_train_veh[var_2] = var_4;
    wait(var_1[var_2]);
    var_4 maps\_vehicle::gopath();
  }

  level.rog_closest_path_node = var_0;
}

script_move_train_02(var_0, var_1) {}

script_move_vehicles() {
  level maps\_utility::delaythread(1.0, ::script_train_stuff_02);
  level thread script_missile_attacks01();
  thread script_vehicle_jets_01();
  thread script_shooting_tanks_01();
  thread script_shooting_tanks_02();
  thread script_shooting_tanks_03();
  thread script_shooting_tanks_04();
  thread script_shooting_tanks_05();
  thread script_shooting_tanks_06();
  thread script_shooting_tanks_07();
  wait 7;
  level notify("delete_start_tanks");
  level thread rog_spawn_and_move("base_array_intro_flyby_choppers");
  common_scripts\utility::flag_wait("ROG_look_at_airfield");
  thread script_shooting_tanks_08();
  thread script_shooting_tanks_09();
}

script_shooting_tanks_01() {
  var_0 = getEntArray("targets_spaceport_firing01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 23;
  var_1 = getEntArray("targets_spaceport_firing01_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (6880, -23728, -127675));

  wait 30;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_04() {
  var_0 = getEntArray("targets_spaceport_firing04", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 28;
  var_1 = getEntArray("targets_spaceport_firing04_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (7896, -13914, -127675));

  wait 34;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_02() {
  var_0 = getEntArray("targets_spaceport_firing02", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 32;
  var_1 = getEntArray("targets_spaceport_firing02_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (6555, -575, -127565));

  wait 34;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_03() {
  var_0 = getEntArray("targets_spaceport_firing03", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 32;
  var_1 = getEntArray("targets_spaceport_firing03_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (4109, 9387, -127565));

  wait 35;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_05() {
  var_0 = getEntArray("targets_spaceport_firing05", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 32;
  var_1 = getEntArray("targets_spaceport_firing05_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (4109, 9387, -127565));

  wait 35;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_06() {
  var_0 = getEntArray("targets_spaceport_firing06", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 40;
  var_1 = getEntArray("targets_spaceport_firing06_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (-12067, 5129, -127565));

  wait 35;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_07() {
  var_0 = getEntArray("targets_spaceport_firing07", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 40;
  var_1 = getEntArray("targets_spaceport_firing07_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (-12067, 5129, -127565));

  wait 35;

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position");
}

script_shooting_tanks_08() {
  var_0 = getEntArray("targets_west_firing01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 50;
  var_1 = getEntArray("targets_west_firing01_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (-10551, 3849, -127565));
}

script_shooting_tanks_09() {
  var_0 = getEntArray("targets_airfield_north_firing01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 50;
  var_1 = getEntArray("targets_airfield_north_firing01_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (-6665, 10065, -127565));
}

script_shooting_tanks_10() {
  var_0 = getEntArray("targets_airfield_north_firing02", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  wait 55;
  var_1 = getEntArray("targets_airfield_north_firing02_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (10671, 9063, -127565));
}

script_vehicle_jets_01() {
  wait 0;
  thread maps\loki_audio::sfx_setup_jet_nodes();
  level thread rog_spawn_and_move("vehicle_jets_high_dishfield_01");
  thread script_air_strike_exp01();
  thread maps\loki_audio::sfx_jet_passby_01();
  wait 1;
  level thread rog_spawn_and_move("vehicle_jet_dishes_00");
  level thread rog_spawn_and_move("vehicle_jet_dishes_01");
  wait 3;
  level thread rog_spawn_and_move("vehicle_jet_dishes_04");
  wait 2;
  level thread rog_spawn_and_move("vehicle_jet_dishes_02", undefined, 1);
  thread maps\loki_audio::sfx_jet_passby_02();
  wait 9;
  level thread rog_spawn_and_move("vehicle_train_sequence_jet_01");
  wait 4;
  level thread rog_spawn_and_move("vehicle_train_sequence_jet_02");
  thread maps\loki_audio::sfx_jet_passby_04();
  wait 1;
  level thread rog_spawn_and_move("vehicle_train_sequence_jet_03");
  thread maps\loki_audio::sfx_jet_passby_05();
  wait 7;
  level thread rog_spawn_and_move("vehicle_jet_spaceport_01");
  level thread rog_airstrike("vehicle_jet_spaceport_01", ::script_airstrike_exp02);
  thread maps\loki_audio::sfx_jet_passby_08();
  wait 9;
  level thread rog_spawn_and_move("vehicle_jet_spaceport_02", undefined, 0);
  level thread rog_airstrike("vehicle_jet_spaceport_02", ::script_airstrike_exp03);
  wait 0;
  wait 3;
  wait 9;
  level thread rog_spawn_and_move("vehicle_jet_airstrip_01", undefined, 0);
  level thread rog_airstrike("vehicle_jet_airstrip_01", ::script_airstrike_exp04);
  wait 9;
  level thread rog_spawn_and_move("vehicle_jet_airstrip_02", undefined, 1);
  level thread rog_airstrike("vehicle_jet_airstrip_02", ::script_airstrike_exp05);
  thread maps\loki_audio::sfx_jet_passby_10();
  level thread rog_spawn_and_move("vehicle_jet_spaceport_04");
  wait 20;
  level thread rog_spawn_and_move("base_array_ambient_mig29_missile_dive_2_buddy");
  thread maps\loki_audio::sfx_jet_passby_11();
}

rog_airstrike(var_0, var_1) {
  var_2 = var_0 + "_vehicle";
  var_3 = getEntArray(var_2, "targetname");

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_5 thread[[var_1]]();
      break;
    }
  }
}

script_air_strike_exp01() {
  wait 15;
  common_scripts\utility::exploder("strafe_exp01");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp02");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp03");
  wait 2.5;
  common_scripts\utility::exploder("strafe_exp05");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp04");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp07");
  wait 1.5;
  common_scripts\utility::exploder("strafe_exp08");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp06");
}

script_airstrike_exp02() {
  self endon("death");
  wait 18.5;
  common_scripts\utility::exploder("strafe_exp07");
  wait 0.4;
  common_scripts\utility::exploder("strafe_exp08");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp06");
}

script_airstrike_exp03() {
  self endon("death");
  wait 18.5;
  common_scripts\utility::exploder("strafe_exp07");
  wait 1;
  common_scripts\utility::exploder("strafe_exp05");
  wait 0.7;
  common_scripts\utility::exploder("strafe_exp09");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp10");
}

script_airstrike_exp04() {
  self endon("death");
  wait 17.5;
  common_scripts\utility::exploder("strafe_exp06");
  wait 0.4;
  common_scripts\utility::exploder("strafe_exp11");
  wait 0.3;
  common_scripts\utility::exploder("strafe_exp04");
  wait 1;
  common_scripts\utility::exploder("strafe_exp03");
}

script_airstrike_exp05() {
  self endon("death");
  wait 19.5;
  common_scripts\utility::exploder("strafe_exp09");
  wait 0.4;
  common_scripts\utility::exploder("strafe_exp10");
  wait 0.7;
  common_scripts\utility::exploder("strafe_exp12");
  wait 0.8;
  common_scripts\utility::exploder("strafe_exp01");
}

script_missile_attacks01() {
  wait 7;
  var_0 = getEntArray("targets_missile_launcher_area_01_model", "targetname");

  foreach(var_2 in var_0)
  var_2 notify("update_firing_position", (-8108, -2642, -127714));

  wait 10;
  var_0 = getEntArray("targets_missile_launcher_area_01_model", "targetname");

  foreach(var_2 in var_0)
  var_2 notify("update_firing_position", (-1196, -3108, -127730));

  wait 6;
  var_0 = getEntArray("targets_missile_launcher_area_01_model", "targetname");

  foreach(var_2 in var_0)
  var_2 notify("update_firing_position", (-6274, 574, -127730));

  wait 2;
  thread script_missile_attacks02();
}

script_missile_attacks02() {
  var_0 = getEntArray("targets_missile_launcher_area_02", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done", (7174, -19454, -127728));
  wait 7;
  var_1 = getEntArray("targets_missile_launcher_area_02_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (7206, -10192, -127728));

  wait 7;
  var_1 = getEntArray("targets_missile_launcher_area_02_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (6952, -7622, -127728));

  common_scripts\utility::flag_wait("ROG_look_at_airfield");
  thread script_missile_attacks03();
}

script_missile_attacks03() {
  var_0 = getEntArray("targets_missile_launcher_area_03", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done", (-14612, 8762, -127728));
  wait 7;
  var_1 = getEntArray("targets_missile_launcher_area_03_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (-12860, 2976, -127728));

  wait 7;
  var_1 = getEntArray("targets_missile_launcher_area_03_model", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("update_firing_position", (-7074, 12432, -127728));
}

rog_spawn_and_move(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");
  var_4 = [];

  foreach(var_8, var_6 in var_3) {
    var_6.script_cheap = 1;
    var_7 = var_6 maps\_vehicle::spawn_vehicle_and_gopath();

    if(isDefined(var_2) && var_2) {
      var_7.targetname = var_0 + "_vehicle_" + var_8;
      var_7 thread rog_audio_hook();
    } else
      var_7.targetname = var_0 + "_vehicle";

    var_7 thread rog_target_vehicle_tracking();
    var_7 thread rog_target_handle_explosions();
    var_7 thread check_for_rog_death(var_7);
    var_4 = common_scripts\utility::array_add(var_4, var_7);
  }

  if(isDefined(var_2) && !var_2)
    level thread rog_audio_hook_group(var_0);

  if(isDefined(var_1))
    level thread script_delete_vehicles(var_4, var_1);
}

rog_audio_hook_group(var_0) {
  var_1 = undefined;

  if("vehicle_jet_spaceport_02" == var_0)
    var_1 = level.jet_passby_09b;
  else if("vehicle_jet_airstrip_01" == var_0)
    var_1 = level.jet_passby_10;

  if(isDefined(var_1)) {
    for(var_2 = getEntArray(var_0 + "_vehicle", "targetname"); var_2.size > 0; var_2 = getEntArray(var_0 + "_vehicle", "targetname"))
      wait 0.2;

    var_1 notify("destroyed");
  }
}

rog_audio_hook() {
  var_0 = undefined;
  var_1 = undefined;

  switch (self.targetname) {
    case "vehicle_jet_dishes_02_vehicle_3":
      var_0 = level.jet_passby_04;
      break;
    case "vehicle_jet_dishes_02_vehicle_5":
      var_0 = level.jet_passby_04b;
      break;
    case "vehicle_jet_dishes_02_vehicle_4":
      var_0 = level.jet_passby_05;
      break;
    case "vehicle_jet_dishes_02_vehicle_0":
      var_0 = level.jet_passby_06;
      break;
    case "vehicle_jet_dishes_02_vehicle_1":
      var_0 = level.jet_passby_06b;
      break;
    case "vehicle_jet_dishes_02_vehicle_2":
      var_0 = level.jet_passby_07;
      break;
    case "vehicle_jet_airstrip_02_vehicle_2":
      var_0 = level.jet_passby_11;
      break;
    case "vehicle_jet_airstrip_02_vehicle_0":
      var_0 = level.jet_passby_12;
      var_1 = level.jet_passby_15;
      break;
    case "vehicle_jet_airstrip_02_vehicle_1":
      var_0 = level.jet_passby_13;
      break;
    case "vehicle_jet_airstrip_02_vehicle_3":
      var_0 = level.jet_passby_14;
      break;
  }

  if(isDefined(var_0)) {
    self waittill("death");
    var_0 notify("destroyed");

    if(isDefined(var_1))
      var_1 notify("destroyed");
  }
}

rog_spawn_and_move_friendly(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
    var_6 thread check_for_rog_death(var_6);
    var_6 thread rog_target_vehicle_tracking();
    var_3 = common_scripts\utility::array_add(var_3, var_6);
  }

  if(isDefined(var_1))
    level thread script_delete_vehicles(var_3, var_1);
}

script_delete_vehicles(var_0, var_1) {
  level waittill(var_1);

  foreach(var_3 in var_0)
  var_3 delete();
}

wait_till_player_uses_terminal() {
  if(maps\_utility::is_gen4())
    setsaveddvar("r_mbEnable", 0);

  thread control_screen_bink_init();

  if(!isDefined(level.breach_anim_node))
    maps\loki_space_breach::create_anim_node();

  while(!isDefined(level.breach_anim_node))
    common_scripts\utility::waitframe();

  var_0 = 50;
  var_1 = getent("rog_terminal", "targetname");
  var_1 wait_for_player_to_use_chair();
  thread maps\loki_audio::sfx_loki_control_room_start();
  maps\loki_util::player_boundaries_off();

  if(isDefined(level.glow_console))
    level.glow_console delete();

  level.allies[0] notify("stop nags");
  level notify("kill_thrusters");
  var_2 = maps\_utility::spawn_anim_model("player_rig", level.breach_anim_node.origin);
  var_2.angles = level.player.angles;
  var_2 hide();
  var_3 = [];
  var_3["player"] = var_2;
  level.breach_anim_node maps\_anim::anim_first_frame(var_3, "breach_rog_controls_start");
  level.player disableweapons();
  level.player playerlinktoblend(var_2, "tag_player", 0.5);
  wait 0.5;
  thread put_ally_in_chair();
  var_4 = level.player getweaponammoclip(level.breach_weapon);

  if(var_4 < 10)
    var_4 = 20;

  level.player setweaponammoclip(level.breach_weapon, var_4);
  var_5 = 60;
  level.player playerlinktodelta(var_2, "tag_player", 1, var_5, var_5, var_5, var_5, 1);
  wait 0.1;
  var_5 = 1;
  level.player playerlinktodelta(var_2, "tag_player", 1, var_5, var_5, var_5, var_5, 1);
  var_2 show();
  level.player_rig = var_2;
  common_scripts\utility::flag_set("console_activated");
  level notify("player_rog_screen_reboot");
  thread player_console_anims(var_2);
  wait 0.1;
  level.allies[0] notify("stop nags");
  thread manage_player_linked_view(var_2);
  var_5 = 32;
  maps\_utility::smart_radio_dialogue("loki_kgn_merrickbeadvisedcurveball");
  maps\_utility::smart_radio_dialogue("loki_mrk_copythat");
  common_scripts\utility::flag_set("space_breach_vo_done");

  if(!common_scripts\utility::flag("rog_controls_start_done"))
    thread maps\_utility::smart_radio_dialogue("loki_gs3_wilcofiringforeffect");

  thread maps\_utility::smart_radio_dialogue("loki_gs3_thompsonyouhavetargeting");
  common_scripts\utility::flag_wait("rog_controls_start_done");
  wait 2.0;
  level thread start_rog_fail_timer(25);
  level notify("player_rog_screen_wait");
  var_6 = ["loki_us3_launchtherods", "loki_us3_ourforcesneedsupport", "loki_us3_releasethepayloadsnow"];
  level.allies[0] thread maps\loki_space_breach::play_nag_after_delay(5.0, var_6, "attack_pressed");
  maps\loki_util::waittill_fire_trigger_activate("press_to_fire", 1);
  common_scripts\utility::flag_set("rog_intro_player_flipped_switch");
  thread maps\loki_audio::sfx_control_room_launch();
  level.allies[0] notify("stop nags");
  level notify("player_rog_screen_fire");
  var_1 makeunusable();
  thread delete_all_ents();
  wait 3.0;
  thread maps\loki_audio::sfx_control_room_rog_launch();
  thread fire_rogs_in_space();
  wait 0.95;
  thread maps\_utility::smart_radio_dialogue("loki_us3_allrodsaway");
  wait 3.0;
  thread maps\_utility::smart_radio_dialogue("loki_us3_connectingtotargeting");
  level waittill("rog_controls_fire_done");
  level notify("player_rog_screen_zoom");
  wait 1.0;
  wait 1.5;
  setsaveddvar("cg_cinematicFullScreen", "1");
  wait 0.5;
  level.player unlink();
  level.allies[0] stopanimscripted();
  level.allies[1] stopanimscripted();
  maps\_utility::delaythread(1.5, ::enable_weapons);
  level notify("switching_to_rog");
}

wait_for_player_to_use_chair() {
  while(common_scripts\utility::flag("use_pressed"))
    wait 0.1;

  var_0 = getent("rog_controls_use_trigger", "targetname");

  if(level.console || level.player usinggamepad())
    maps\loki_util::waittill_trigger_activate_looking_at(self, "activate_console_hint", 100, 0.5, undefined, 1, var_0);
  else
    maps\loki_util::waittill_trigger_activate_looking_at(self, "activate_console_hint_pc", 100, 0.5, undefined, 1, var_0);
}

manage_player_linked_view(var_0) {
  level.player playerlinktodelta(var_0, "tag_player", 1, 13, 30, 60, 13, 1);
  wait 3.0;
  level.player playerlinktodelta(var_0, "tag_player", 1, 13, 50, 60, 10, 1);
}

manage_use_region() {
  self endon("trigger");
  var_0 = getent("rog_controls_use_trigger", "targetname");
  self sethintstring(&"SCRIPT_HOLD_TO_USE");

  for(;;) {
    if(level.player istouching(var_0))
      self makeusable();
    else
      self makeunusable();

    common_scripts\utility::waitframe();
  }
}

put_ally_in_chair() {
  var_0 = [];
  var_0["ally_1"] = level.allies[1];
  level.breach_anim_node thread maps\_anim::anim_loop(var_0, "rog_intro", "stop_loops");
  level waittill("switching_to_rog");
  level.breach_anim_node notify("stop_loops");
}

player_console_anims(var_0) {
  var_1 = [];
  var_1["player"] = var_0;
  level.breach_anim_node maps\_anim::anim_single(var_1, "breach_rog_controls_start");
  common_scripts\utility::flag_set("rog_controls_start_done");
  level.breach_anim_node thread maps\_anim::anim_loop(var_1, "breach_rog_controls_wait_loop");
  level waittill("player_rog_screen_fire");
  level.breach_anim_node maps\_anim::anim_single(var_1, "breach_rog_controls_fire");
  level notify("rog_controls_fire_done");
}

fire_rogs_in_space() {
  var_0 = getEntArray("pretarget_rog_sats", "script_noteworthy");
  var_1[0] = [1, 1.5, 1, 0.8, 0.8, 1];
  var_1[1] = [1.5, 1, 0.8, 1, 1, 1];
  var_1[2] = [0.8, 1, 1.5, 1, 1, 1];
  var_1[3] = [1, 0.8, 0.8, 1, 1.5, 1];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_4 thread launch_rogs(var_1[var_2]);
    var_2++;
  }
}

zoom_player_view(var_0, var_1) {
  level endon("switching_to_rog");
  level.player lerpfov(var_0, var_1);
}

launch_rogs(var_0) {
  var_1 = [0, 1, 2, 3, 4, 5];
  var_2 = common_scripts\utility::array_randomize(var_1);

  for(var_3 = 0; var_3 < 6; var_3++) {
    if(var_3 < 6)
      var_4 = "tag_rogfx_0" + var_2[var_3];
    else
      var_4 = "tag_rogfx_" + var_2[var_3];

    playFXOnTag(common_scripts\utility::getfx("loki_rog_close_1_missile"), self, var_4);
    common_scripts\utility::waitframe();
  }

  wait 0.1;

  for(var_3 = 0; var_3 < 6; var_3++) {
    if(var_3 < 6)
      var_4 = "tag_rogfx_0" + var_2[var_3];
    else
      var_4 = "tag_rogfx_" + var_2[var_3];

    killfxontag(common_scripts\utility::getfx("loki_rog_close_1_missile"), self, var_4);
    playFXOnTag(common_scripts\utility::getfx("loki_rog_trail_close_2_emit"), self, var_4);
    wait(var_0[var_3]);
  }
}

control_screen_bink_init() {
  setsaveddvar("cg_cinematicFullScreen", "0");
  show_hide_all_static(1);
  level thread play_cinematic_thread("loki_rog_intro_offline", "player_rog_screen_reboot");
  thread maps\loki_audio::sfx_laptop_offline_lp();
  level waittill("player_rog_screen_reboot");
  thread maps\loki_audio::sfx_laptop_static();
  show_hide_all_static(1);
  common_scripts\utility::waitframe();
  stopcinematicingame();
  wait 0.5;
  level thread play_cinematic_thread_once("loki_rog_intro_rebooting", "player_rog_screen_wait", 7300);
  thread maps\loki_audio::sfx_laptop_reboot();
  level waittill("player_rog_screen_wait");
  thread maps\loki_audio::sfx_laptop_static();
  show_hide_all_static(1);
  common_scripts\utility::waitframe();
  stopcinematicingame();
  common_scripts\utility::waitframe();
  level thread play_cinematic_thread("loki_rog_intro_target_locked", "player_rog_screen_fire");
  thread maps\loki_audio::sfx_laptop_target_lp();
  level waittill("player_rog_screen_fire");
  wait 3.75;
  thread maps\loki_audio::sfx_laptop_static();
  show_hide_all_static(1);
  common_scripts\utility::waitframe();
  stopcinematicingame();
  common_scripts\utility::waitframe();
  level thread play_cinematic_thread("loki_rog_intro_launching_missiles", "player_rog_screen_zoom");
  thread maps\loki_audio::sfx_laptop_launching();
  level waittill("player_rog_screen_zoom");
  thread maps\loki_audio::sfx_laptop_static();
  show_hide_all_static(1);
  common_scripts\utility::waitframe();
  stopcinematicingame();
  common_scripts\utility::waitframe();
  setsaveddvar("cg_cinematicCanPause", "1");
  level thread play_cinematic_thread("loki_rog_intro_connecting", "end_connection");
  thread maps\loki_audio::sfx_laptop_connecting();
}

play_cinematic_thread(var_0, var_1) {
  level endon(var_1);
  cinematicingameloopresident(var_0);
  var_2 = 0;

  while(!iscinematicloaded() || !iscinematicplaying()) {
    var_2++;
    common_scripts\utility::waitframe();
  }

  wait 0.1;
  show_hide_all_static(0);
}

play_cinematic_thread_once(var_0, var_1, var_2) {
  level endon(var_1);
  cinematicingame(var_0);
  var_3 = 0;

  while(!iscinematicloaded() || !iscinematicplaying()) {
    var_3++;
    common_scripts\utility::waitframe();
  }

  wait 0.1;
  show_hide_all_static(0);

  while(cinematicgettimeinmsec() < var_2)
    common_scripts\utility::waitframe();

  level notify(var_1);
}

show_hide_all_static(var_0) {
  var_1 = getEntArray("ambush_breach_monitor_screen_static", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 show();
      continue;
    }

    var_3 hide();
  }
}

start_rog_fail_timer(var_0) {
  wait(var_0);

  if(!common_scripts\utility::flag("rog_intro_player_flipped_switch")) {
    setdvar("ui_deadquote", &"LOKI_ENDING_FAIL");
    level thread maps\_utility::missionfailedwrapper();
  }
}

delete_all_ents() {
  var_0 = getent("intelligence_item", "targetname");

  if(isDefined(var_0)) {
    var_0 notify("end_loop_thread");
    var_0 notify("end_trigger_thread");
  }

  if(!isDefined(level.breach_anim_node))
    maps\loki_space_breach::create_anim_node();

  var_1 = 0;
  var_2 = getEntArray();
  wait 0.2;

  foreach(var_4 in var_2) {
    if(isDefined(var_4.origin) && var_4.origin[2] > 55000 && var_4.origin[0] > -76000) {
      if(isai(var_4))
        var_4 kill();
    }

    if(isDefined(var_4.origin) && var_4.origin[2] > 55000 && var_4.origin[2] < 92300) {
      if(!isDefined(var_4.model) || var_4.model != "loki_rog_satellite_close") {
        if(isai(var_4))
          var_4 kill();
      }
    }
  }

  common_scripts\utility::waitframe();
  common_scripts\utility::waitframe();
  var_2 = getEntArray();

  foreach(var_4 in var_2) {
    if(var_1 < 100) {
      if(isDefined(var_4.origin) && var_4.origin[2] > 55000 && var_4.origin[0] > -76000) {
        if(!isai(var_4)) {
          var_4 delete();
          var_1++;
        }
      }

      if(isDefined(var_4.origin) && var_4.origin[2] > 55000 && var_4.origin[2] < 92300) {
        if(!isDefined(var_4.model) || var_4.model != "loki_rog_satellite_close") {
          if(!isai(var_4)) {
            var_4 delete();
            var_1++;
          }
        }
      }

      continue;
    }

    common_scripts\utility::waitframe();
    common_scripts\utility::waitframe();
    var_1 = 0;
  }

  var_2 = getEntArray();
}

enable_weapons() {
  level.player enableweapons();
}

console_hint_button_press() {
  return !common_scripts\utility::flag("activate_console_hint");
}

console_hint_button_press_pc() {
  return !common_scripts\utility::flag("activate_console_hint_pc");
}

fire_hint_button_press() {
  return !common_scripts\utility::flag("press_to_fire");
}

cleanup_layout(var_0) {}

rog_target_spawn_logic() {
  var_0 = getEntArray("large_target_markers", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_missile_launcher_area_01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_spaceport_01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_dish_field_01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_dish_field_02", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_dish_field_03", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_retreating_allies03", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_retreating_allies04", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  thread script_retreating_allies04_firing();
  var_0 = getEntArray("targets_airfield_allies_moving_01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_airfield_allies_static_01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_airfield_allies_west_firing01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_airfield_allies_north_firing01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_airfield_allies_north_firing02", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  common_scripts\utility::flag_wait("ROG_look_at_sat_farm");
  common_scripts\utility::flag_wait("ROG_look_at_airfield");
  thread script_airfield_allies_west_firing01();
  thread script_airfield_allies_north_firing01();
  thread script_airfield_allies_north_firing02();
  var_0 = getEntArray("targets_airfield_west", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_airfield_north_01", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
  var_0 = getEntArray("targets_airfield_north_02", "targetname");
  common_scripts\utility::array_thread(var_0, ::rog_target_create_model_logic, "rog_done");
}

script_retreating_allies04_firing() {
  level endon("ROG_look_at_airfield");
  wait 33;

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = randomint(3);
    var_2 = getEntArray("targets_retreating_allies04_model", "targetname");

    if(var_1 == 0) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-17315, -12647, -127565));
    } else if(var_1 == 1) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-5171, -7815, -127565));
    } else if(var_1 == 2) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-2531, -12535, -127565));
    }

    wait(randomfloatrange(10.0, 15.0));
  }
}

script_airfield_allies_west_firing01() {
  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = randomint(3);
    var_2 = getEntArray("targets_airfield_allies_west_firing01_model", "targetname");

    if(var_1 == 0) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-27907, 13705, -127565));
    } else if(var_1 == 1) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-24515, 8857, -127565));
    } else if(var_1 == 2) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-30675, 6313, -127565));
    }

    wait(randomfloatrange(10.0, 15.0));
  }
}

script_airfield_allies_north_firing01() {
  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = randomint(3);
    var_2 = getEntArray("targets_airfield_allies_north_firing01_model", "targetname");

    if(var_1 == 0) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-16963, 20105, -127565));
    } else if(var_1 == 1) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-15011, 24633, -127565));
    } else if(var_1 == 2) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-9859, 20857, -127565));
    }

    wait(randomfloatrange(10.0, 15.0));
  }
}

script_airfield_allies_north_firing02() {
  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = randomint(3);
    var_2 = getEntArray("targets_airfield_allies_north_firing02_model", "targetname");

    if(var_1 == 0) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (-1827, 21161, -127565));
    } else if(var_1 == 1) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (2413, 22585, -127565));
    } else if(var_1 == 2) {
      foreach(var_4 in var_2)
      var_4 notify("update_firing_position", (5661, 21369, -127565));
    }

    wait(randomfloatrange(10.0, 15.0));
  }
}

rog_target_create_model_logic(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2.angles = self.angles;
  var_2 setModel(self.model);
  var_2.script_team = self.script_team;
  var_2.targetname = self.targetname + "_model";

  if(isDefined(self.target)) {
    var_2.target = self.target;
    var_2 thread rog_target_move_along_path();
  }

  if(isDefined(self.script_deathtime)) {
    var_2.script_deathtime = self.script_deathtime;
    var_2 thread rog_target_deathtimer();
  }

  if(isDefined(self.script_noteworthy))
    var_2.script_noteworthy = self.script_noteworthy;

  var_2 thread rog_target_hud_logic(var_2, "ROG_reveal_allies");
  var_2 thread rog_target_firing_logic(var_1);
  var_2 thread rog_target_handle_explosions();
  var_2 thread rog_target_cleanup(var_0);
  level.rog_target_models[level.rog_target_models.size] = var_2;
  self delete();
}

rog_target_cleanup(var_0) {
  if(!isDefined(var_0))
    var_0 = "rog_done";

  self endon("death");
  common_scripts\utility::flag_wait("ROG_take_in_destruction");

  if("allies" != self.script_team)
    childthread rog_target_cleaned_up_by_allies();

  common_scripts\utility::flag_wait(var_0);
  rog_target_overkill_death(1, 0);
}

rog_target_cleaned_up_by_allies() {
  wait(randomfloatrange(0.0, 20.0));
  rog_target_normal_death(1);
}

rog_target_handle_explosions() {
  self endon("death");
  self.is_dead = 0;

  for(;;) {
    level waittill("rog_explosion", var_0, var_1);

    if(maps\_vehicle::isvehicle()) {
      if(maps\_vehicle::ishelicopter() && var_1 == "rod") {
        var_2 = anglesToForward(self.angles);
        var_3 = self.origin + var_2 * 6144;
        var_4 = distance2d(var_3, var_0);
        var_5 = get_explosion_radius();

        if(var_4 < var_5) {
          self notify("newpath");
          var_6 = vectornormalize(self.origin - var_0);
          var_7 = self.origin + 2045 * var_6;
          self vehicle_helisetai(var_7, 65, 10, 15, 0, (0, 0, 0), 0, 0.0, 0, 0, 0, 0, 0);
        }
      }

      continue;
    }

    switch (var_1) {
      case "rod":
        childthread rog_target_handle_rod_impact(var_0);
        break;
      case "missile":
      case "tank":
        childthread rog_target_handle_enemy_fire(var_0, var_1);
        break;
    }
  }
}

rog_target_handle_rod_impact(var_0) {
  var_1 = self.origin - var_0;
  var_2 = length(var_1);
  var_3 = get_explosion_radius();
  var_4 = [level.rog_fx_delay, 0.2, 0.3, 0.4];
  var_5 = [0.4, 0.7, 0.9, 1.0];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    wait(var_4[var_6]);

    if(var_2 < var_3 * var_5[var_6]) {
      if(self.script_team == "allies")
        level.rog_pass_fail["allies"]["targets"]++;
      else if(!self.is_dead)
        level.rog_num_enemy_targets_killed++;

      if(var_6 < 2)
        thread rog_target_overkill_death(0, 0);
      else if(!self.is_dead) {
        self.is_dead = 1;
        thread rog_target_normal_death(0, self.origin - (var_0 - (0, 0, 384)));
      }

      break;
    }
  }
}

rog_vehicle_handle_rod_impact(var_0) {
  var_1 = get_explosion_radius();
  var_2 = [0.3, 0.4, 0.5, 0.6];
  var_3 = [0.4, 0.7, 0.9, 1.0];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    wait(var_2[var_4]);
    var_5 = length(self.origin - var_0);

    if(var_5 < var_1 * var_3[var_4]) {
      if(var_4 < 1)
        childthread vehicle_overkill_from_rog();
      else
        childthread vehicle_blow_up_from_rog();

      break;
    }
  }
}

rog_target_handle_enemy_fire(var_0, var_1) {
  var_2 = self.origin - var_0;
  var_3 = length(var_2);
  var_4 = level.rog_explosion_radius[var_1];

  if(var_3 < var_4)
    rog_target_normal_death(1);
}

rog_target_move_along_path() {
  self endon("death");
  self endon("husk");
  self endon("stop_pathing");
  var_0 = getvehiclenode(self.target, "targetname");
  var_1 = undefined;

  if(isDefined(var_0.target))
    var_1 = getvehiclenode(var_0.target, "targetname");

  var_2 = var_0.speed;

  while(isDefined(var_0)) {
    var_3 = distance(self.origin, var_0.origin);
    var_4 = var_3 / var_2;
    self moveto(var_0.origin, var_4);

    if("allies" != self.script_team)
      thread rog_target_interupt_path(var_0.origin);

    if(isDefined(var_1)) {
      wait(var_4 * 0.8);
      self rotateto(vectortoangles(var_1.origin - var_0.origin), var_4 * 0.4);
      wait(var_4 * 0.2);
    } else
      wait(var_4);

    if(isDefined(var_1)) {
      var_0 = var_1;

      if(isDefined(var_1.target))
        var_1 = getvehiclenode(var_1.target, "targetname");
      else
        var_1 = undefined;

      continue;
    }

    var_0 = undefined;
  }
}

rog_target_interupt_path(var_0) {
  self notify("ROG_target_interupt_path");
  self endon("ROG_target_interupt_path");
  self endon("death");
  self endon("husk");

  for(;;) {
    level waittill("rog_explosion", var_1, var_2);

    if(var_2 == "rod") {
      var_3 = vectornormalize(var_0 - self.origin);
      var_4 = vectornormalize(var_1 - self.origin);
      var_5 = vectordot(var_3, var_4);

      if(var_5 > 0.5) {
        var_6 = length(var_0 - var_1);

        if(level.rog_explosion_radius["rod"] > var_6) {
          break;
        }
      }
    }
  }

  self notify("stop_pathing");

  if(self.model == "vehicle_battle_hind_low" && var_6 < level.rog_explosion_radius["danger_close"]) {
    var_7 = vectornormalize(var_1 - self.origin);
    self moveto(self.origin + var_7 * 2048, 10, 4, 3);
  } else
    self moveto(self.origin, 0.05);

  self notify("stop_pathing");
}

rog_target_firing_logic(var_0) {
  self endon("death");
  self endon("husk");
  self.firing_position = var_0;
  childthread rog_target_update_firing_position();

  for(;;) {
    if(isDefined(self.firing_position)) {
      switch (self.model) {
        case "vehicle_m1a2_abrams_iw6_low":
        case "vehicle_t90ms_tank_iw6_low":
          wait(randomfloatrange(7, 15));

          if(isDefined(self.firing_position)) {
            var_1 = vectornormalize(self.firing_position - self.origin);
            playFX(level._effect["abrams_flash_wv_no_tracer"], self.origin + (0, 0, 68) + 246 * var_1, var_1, (0, 0, 1));
            var_2 = self.firing_position + (randomfloatrange(-1024, 1024), randomfloatrange(-1024, 1024), 0);
            playFX(level._effect["tank_blast_sand"], var_2);
            level notify("rog_explosion", var_2, "tank");
          }

          break;
        case "vehicle_m880_launcher_low":
          wait(randomfloatrange(0.0, 2.0));

          if(isDefined(self.firing_position)) {
            var_2 = self.firing_position + (randomfloatrange(-3072, 3072), randomfloatrange(-3072, 3072), 0);
            var_1 = vectornormalize(self.firing_position - self.origin);
            playFX(level._effect["abrams_flash_wv_no_tracer"], self.origin + (0, 0, 68) + 246 * var_1, var_1, (0, 0, 1));
            thread missile_truck_fire_missile(var_2);
            self.firing_position = undefined;
          }

          break;
        case "vehicle_mig29":
        case "vehicle_battle_hind_low":
          wait(randomfloatrange(7.0, 15));

          if(isDefined(self.firing_position)) {
            var_2 = self.firing_position + (randomfloatrange(-1024, 1024), randomfloatrange(-1024, 1024), 0);
            rog_target_launch_missile(var_2);
          }

          break;
        default:
          return;
      }

      continue;
    }

    self waittill("update_firing_position");
    wait 0.05;
  }
}

rog_target_update_firing_position() {
  for(;;) {
    self waittill("update_firing_position", var_0);
    self.firing_position = var_0;
  }
}

rog_target_launch_missile(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("projectile_sidewinder_missile");
  playFXOnTag(level._effect["missile_trail"], var_1, "tag_fx");
  var_2 = length(var_0 - var_1.origin) / 2500;
  var_1 moveto(var_0, var_2, var_2 * 0.2);
  wait(var_2);
  level notify("rog_explosion", var_0, "missile");
  var_1 delete();
}

rog_target_deathtimer() {
  self endon("death");
  wait(self.script_deathtime);
  thread rog_target_normal_death(1);
}

rog_target_normal_death(var_0, var_1) {
  if(self.script_team == "allies" && !var_0)
    level notify("ally_hit");

  self notify("stop_pathing");
  self moveto(self.origin, 0.05);

  if(!var_0)
    thread rog_target_get_thrown(var_1);

  rog_target_remove_hud_element(var_0 == 0);
  self notify("husk");

  switch (self.model) {
    case "vehicle_m1a2_abrams_iw6_low":
    case "vehicle_t90ms_tank_iw6_low":
      self setModel("vehicle_t90ms_tank_destroyed_iw6_low");

      if(var_0)
        playFXOnTag(level._effect["target_explosion_tank"], self, "TAG_DEATHFX");

      break;
    case "vehicle_sa6_static_desert":
    case "vehicle_m880_launcher_low":
      self setModel("vehicle_m880_launcher_destroyed_low");

      if(var_0)
        playFX(level._effect["target_explosion_tank"], self.origin + (0, 0, 64));

      break;
    case "vehicle_mig29":
      playFXOnTag(level._effect["target_explosion_tank"], self, "TAG_DEATHFX");
      wait 0.3;
      rog_target_overkill_death(0, 1);
      break;
    case "vehicle_battle_hind_low":
      self setModel("vehicle_battle_hind_destroyed");
      playFXOnTag(level._effect["target_explosion_tank"], self, "tag_origin");
      wait 0.3;
      rog_target_overkill_death(0, 1);
      break;
  }
}

rog_target_overkill_death(var_0, var_1) {
  if(self.script_team == "allies" && !var_0)
    level notify("ally_hit");

  if(var_1)
    playFX(level._effect["target_explosion_tank"], self.origin + (0, 0, 64));

  rog_target_remove_hud_element(var_0 == 0);
  self delete();
}

rog_target_get_thrown(var_0) {
  if(!isDefined(level.rog_fired_targ))
    level.rog_fired_targ = (0, 0, 0);

  var_1 = self.origin - level.rog_fired_targ;
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = vectornormalize(var_1) * randomfloatrange(500, 900) * randomintrange(1, 3) + self.origin;
  var_3 = (0, randomintrange(-179, 179) * randomintrange(1, 3), 0);
  self moveto(var_2, 3.0, 0.0, 1.5);
  self rotateby(var_3, 3.0, 0.0, 1.0);
}

rog_target_hud_logic(var_0, var_1) {
  self endon("death");
  self endon("husk");

  if(self.script_team == "allies") {
    level waittill(var_1);
    maps\_utility::delaythread(randomfloatrange(0.0, 1.5), ::rog_target_add_hud_element);
  } else {
    var_2 = 0;
    var_3 = randomfloatrange(0.0, 1.5);

    for(;;) {
      if(!var_2) {
        if(var_0 istouching(level.rog_active_visibilty_volume)) {
          childthread rog_target_add_hud_element(var_3);
          var_2 = 1;
        }
      } else if(!var_0 istouching(level.rog_active_visibilty_volume)) {
        maps\_utility::delaythread(var_3, ::rog_target_remove_hud_element);
        var_2 = 0;
      }

      wait 0.5;
    }
  }
}

rog_target_add_hud_element(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  var_1 = undefined;

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "large_target":
        var_1 = common_scripts\utility::ter_op(self.script_team == "allies", "hud_rog_target_big_g", "hud_rog_target_big_r");

        if(self.script_team == "axis")
          level.rog_pass_fail["axis"]["targets"]++;

        break;
      case "vehicle":
        var_1 = common_scripts\utility::ter_op(self.script_team == "allies", "hud_rog_target_g", "hud_rog_target_r");
        break;
      case "jet":
        var_1 = common_scripts\utility::ter_op(self.script_team == "allies", "hud_rog_target_vehicle_b_g", "hud_rog_target_vehicle_b_r");
        break;
      default:
        var_1 = common_scripts\utility::ter_op(self.script_team == "allies", "hud_rog_target_g", "hud_rog_target_r");
    }
  } else
    var_1 = common_scripts\utility::ter_op(self.script_team == "allies", "hud_rog_target_g", "hud_rog_target_r");

  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2.alpha = 1.0;
  var_2 setshader(var_1, 8, 8);
  level.current_target_hud_count++;

  if(level.current_target_hud_count >= level.rog_max_waypoints) {}

  var_2 settargetent(self);
  var_2 setwaypoint(1);
  level notify("target_reveal");

  if(self.script_team == "axis")
    self hudoutlineenable(common_scripts\utility::ter_op(self.script_team == "allies", 3, 4), 0);

  self.hud_element = var_2;
}

rog_target_remove_hud_element(var_0) {
  if(isDefined(self.hud_element)) {
    if(isDefined(var_0) && var_0) {
      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "large_target" && self.script_team == "axis")
        level.rog_pass_fail["axis"]["targets"]--;
    }

    self.hud_element destroy();
    self.hud_element = undefined;
    level.current_target_hud_count--;
  }

  if(isDefined(self))
    self hudoutlinedisable();
}

rog_target_vehicle_tracking() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self);
  var_0.script_team = self.script_team;
  thread rog_target_hud_logic(var_0, "ROG_reveal_allies");
  self waittill("death");
  var_0 delete();
}

rog_logic() {
  level thread transition_static(2.0, 1);
  common_scripts\utility::flag_set("turn_off_rogs");
  space_cleanup();
  level notify("kill_thrusters");
  rog_init();
  level thread rog_check_progress();
  level thread rog_mission_dialogue();
  level thread rog_card_swap();
  level thread rog_running_cleanup();
  level thread rog_target_spawn_logic();
  level thread rog_mechanics();
  level.player thread rog_attach_to_firing_position();
  level.player thread rog_ambiant_battle_chatter();
  level.player thread rog_check_friendly_fire();
}

black_fade(var_0, var_1, var_2) {
  var_3 = maps\_hud_util::create_client_overlay("black", 0, level.player);

  if(var_0 > 0)
    var_3 fadeovertime(var_0);

  var_3.alpha = 1;
  wait(var_0);
  wait(var_1);

  if(var_2 > 0)
    var_3 fadeovertime(var_2);

  var_3.alpha = 0;
  wait(var_2);
  var_3 destroy();
}

check_anim_time(var_0, var_1, var_2) {
  var_3 = self getanimtime(level.scr_anim[var_0][var_1]);

  if(var_3 >= var_2)
    return 1;

  return 0;
}

rog_targeting_logic() {
  level endon("ROG_passed");
  var_0 = 1;
  level childthread rog_move_aoe_target();

  for(;;) {
    var_1 = level.player getEye();
    var_2 = level.player getplayerangles();
    var_3 = anglesToForward(var_2);

    if(level.player attackbuttonpressed()) {
      if(var_0 && common_scripts\utility::flag("ROG_can_fire") && !common_scripts\utility::flag("ROG_is_cooling_down")) {
        var_0 = 0;
        var_4 = bulletTrace(var_1, var_1 + var_3 * 250000, 0, level.uav_model, 0);
        level thread rog_fire_single_new(var_4["position"]);
        common_scripts\utility::flag_set("player_is_firing");
        level notify("ROG_locked_in");
      }
    } else
      var_0 = 1;

    wait(level.timestep);
  }
}

rog_fire_single_new(var_0) {
  level notify("ROG_fired", var_0);
  level.rog_fired_targ = var_0;
  var_1 = maps\_utility::spawn_anim_model("loki_rog_single", level.player_mover);
  level.player playSound("scn_loki_rog_press_trigger");
  var_1 playSound("scn_loki_rog_reentry");
  playFXOnTag(level._effect["ROG_single_geotrail"], var_1, "tag_origin");
  level thread rog_rechamber_logic();
  var_2 = rog_get_next_target_marker();
  var_2 thread rog_show_target_marker();
  var_3 = (0, 0, 0);
  var_4 = level.rog_single_velocity_max * level.rog_single_velocity_max * level.timestep * level.timestep + 100;
  var_5 = abs(var_3[0]);
  var_6 = abs(var_3[1]);
  var_7 = abs(var_3[2]);
  var_8 = lengthsquared(var_0 - var_1.origin);
  level thread rog_increment_active_strikes();
  wait(randomfloatrange(0.05, 1.5));
  thread maps\loki_audio::sfx_rog_incoming(var_1);

  for(;;) {
    var_5 = var_5 + level.rog_single_acceleration * level.timestep;
    var_6 = var_6 + level.rog_single_acceleration * level.timestep;
    var_7 = var_7 + level.rog_single_acceleration * level.timestep;

    if(var_7 > level.rog_single_velocity_max)
      var_7 = level.rog_single_velocity_max;

    var_9 = lengthsquared(var_0 - var_1.origin);
    var_10 = 1.0 - var_9 / var_8;
    var_11 = vectornormalize(var_0 - var_1.origin);
    var_11 = (var_11[0] * var_10, var_11[1] * var_10, var_11[2]);
    var_12 = var_11[0] * var_5 * level.timestep;
    var_13 = var_11[1] * var_6 * level.timestep;
    var_14 = var_11[2] * var_7 * level.timestep;
    var_15 = (var_12, var_13, var_14);
    var_1.origin = var_1.origin + var_15;

    if(lengthsquared(var_0 - var_1.origin) < var_4) {
      stopFXOnTag(level._effect["ROG_single_geotrail"], var_1, "tag_origin");
      var_1.origin = var_0;
      level thread rog_impact_danger_close_check(var_0);
      var_2 maps\_utility::delaythread(level.rog_fx_delay, ::rog_hide_target_marker);
      level thread rog_uav_explosion_effects(var_0);
      var_1 thread rog_explosion_fx();
      var_1 thread rog_structure_destruction(var_0);
      var_1 thread rog_scriptable_radius_damage(var_0);
      level thread rog_check_train_track_damage(var_0);
      level thread rog_decrement_active_strikes();
      break;
    }

    wait(level.timestep);
  }

  var_1 hide();
}

rog_increment_active_strikes() {
  level.rog_in_flight++;
  level.rog_strike_active++;
}

rog_decrement_active_strikes() {
  level.rog_in_flight--;
  wait 1.15;
  level.rog_strike_active--;
}

rog_impact_danger_close_check(var_0) {
  var_1 = 0;

  if(isDefined(level.rog_train)) {
    foreach(var_3 in level.rog_train) {
      var_4 = distance2d(var_3.origin, var_0);

      if(var_4 > get_explosion_radius()) {
        if(level.rog_explosion_radius["danger_close"] > var_4)
          level notify("danger_close_train");

        continue;
      }

      if(!common_scripts\utility::flag("ROG_no_fail")) {
        setdvar("ui_deadquote", &"LOKI_ROG_FAIL_FF");
        level thread maps\_utility::missionfailedwrapper();
        return;
      }
    }
  }

  if(var_1)
    level notify("danger_close");
}

preimpactsmoke(var_0) {
  if(self.targetname == "destroy_spaceport") {
    playFX(level._effect["loki_rog_spaceport_center_explosion"], self.origin + (0, 0, 8000), vectornormalize(self.origin - var_0), (0, 0, 1));
    wait 0.5;
    self delete();
  } else {
    var_1 = 1000;

    for(var_2 = 0; var_2 < 2; var_2++) {
      var_3 = (randomintrange(-1 * var_1, var_1), randomintrange(-1 * var_1, var_1), randomintrange(-1 * var_1, var_1));
      playFX(level._effect["building_crumble_directional"], self.origin + var_3, vectornormalize(self.origin - var_0), (0, 0, 1));
      wait 0.5;
    }
  }
}

rog_get_next_target_marker() {
  var_0 = undefined;

  for(var_1 = 0; var_1 < level.rog_blast_markers.size; var_1++) {
    if(!isDefined(level.rog_blast_markers[var_1].time)) {
      level.rog_blast_markers[var_1].time = gettime();
      var_0 = level.rog_blast_markers[var_1];
      break;
    }
  }

  if(!isDefined(var_0)) {
    var_2 = level.rog_blast_markers[var_1].time;

    for(var_1 = 1; var_1 < level.rog_blast_markers.size; var_1++) {
      if(level.rog_blast_markers[var_1].time < var_2)
        var_2 = level.rog_blast_markers[var_1];
    }

    var_2.time = gettime();
    var_0 = var_2;
  }

  return var_0;
}

rog_show_target_marker() {
  if(!common_scripts\utility::flag("final_descent_active")) {
    self.origin = level.rog_aoe_reticle.origin;
    wait 0.05;
    self solid();
    self show();
    self rotateyaw(720, 14);
  }
}

rog_hide_target_marker() {
  self notsolid();
  self hide();
  self.time = undefined;
}

rog_target_marker_blink() {
  self hudoutlineenable(4, 0);
  wait 0.75;
  self hudoutlinedisable();
  wait 0.75;
  self hudoutlineenable(4, 0);
  wait 0.75;
  self hudoutlinedisable();
  wait 0.75;
  self hudoutlineenable(4, 0);
  wait 0.75;
  self hudoutlinedisable();
}

rog_rechamber_logic() {
  level endon("ROG_take_in_destruction");
  common_scripts\utility::flag_set("ROG_is_cooling_down");
  wait 1.3;
  common_scripts\utility::flag_clear("ROG_is_cooling_down");
}

rog_mechanics() {
  level endon("ROG_end");
  level childthread rog_targeting_logic();
  level notify("ROG_new_sequence");
  common_scripts\utility::flag_wait_or_timeout("ROG_early_out", level.rog_full_sequence_max_time);
  common_scripts\utility::flag_clear("ROG_can_fire");
  level.player setclientomnvar("ui_loki_rog_message_progress", 15.0);
  common_scripts\utility::flag_wait("ROG_script_done");
  common_scripts\utility::flag_set("rog_done");
}

rog_adjust_firing_position() {
  var_0 = -15000.0 - level.player_mover[2];
  level.player_mover = level.player_mover + (0, 0, var_0);
}

rog_move_aoe_target() {
  level endon("final_descent_active");
  level thread rog_aoe_reticle_visibility_logic();
  var_0 = 74832.0;

  for(;;) {
    var_1 = level.player getEye();
    var_1 = var_1 + (0, 0, var_0);
    var_2 = level.player getplayerangles();
    var_3 = anglesToForward(var_2);
    var_4 = bulletTrace(var_1, var_1 + var_3 * 250000, 0, level.uav_model, 1);
    level.rog_aoe_reticle.origin = (var_4["position"][0], var_4["position"][1], level.rog_reticle_hieght);
    wait 0.05;
  }
}

rog_adjust_aoe_target_height() {
  common_scripts\utility::flag_wait("ROG_look_at_sat_farm");
  wait 3.5;

  for(;;) {
    level.rog_reticle_hieght++;

    if(level.rog_reticle_hieght >= -127675) {
      break;
    }

    wait 0.05;
  }
}

rog_aoe_reticle_visibility_logic() {
  var_0 = 0;

  while(!common_scripts\utility::flag("ROG_take_in_destruction")) {
    if(!var_0) {
      if(common_scripts\utility::flag("ROG_can_fire")) {
        rog_aoe_show_reticle();
        var_0 = 1;
      }
    } else if(!common_scripts\utility::flag("ROG_can_fire")) {
      rog_aoe_hide_reticle();
      var_0 = 0;
    }

    wait 0.05;
  }

  rog_aoe_hide_reticle();
}

rog_aoe_show_reticle() {
  level.rog_aoe_reticle show();
  level.rog_aoe_reticle solid();
}

rog_aoe_hide_reticle() {
  level.rog_aoe_reticle hide();
  level.rog_aoe_reticle notsolid();
}

rog_display_hint_strings() {
  if(!common_scripts\utility::flag("dont_show_pull_trigger_hint"))
    level maps\_utility::delaythread(0.5, maps\_utility::display_hint, "hint_launch_single_rod");
}

rog_uav_camera_logic() {
  self endon("death");
  setsaveddvar("r_hudOutlineWidth", 1.0);
  common_scripts\utility::flag_set("ROG_take_in_battle_scene");
  self vehicle_setspeedimmediate(210, 20);
  wait 6.5;
  self vehicle_setspeed(90, 50, 25);
  wait 1.5;
  common_scripts\utility::flag_set("ROG_look_at_sat_farm");
  level thread rog_uav_update_lookat(6.0);
  wait 6.0;
  level thread rog_uav_update_lookat(15.0);
  wait 11.0;
  common_scripts\utility::flag_set("rog_vo_0");
  wait 4.0;
  common_scripts\utility::flag_set("ROG_look_at_train");
  level thread rog_uav_update_lookat(7.5);
  wait 7.5;
  common_scripts\utility::flag_set("ROG_look_at_main_base");
  level thread rog_uav_update_lookat(18.0);
  wait 18.0;
  level thread rog_uav_update_lookat(17.0);
  wait 4.0;
  common_scripts\utility::flag_set("ROG_look_at_airfield");
  common_scripts\utility::flag_wait_or_timeout("ROG_early_out", 22.0);
  common_scripts\utility::flag_set("ROG_take_in_destruction");
  level thread rog_uav_update_lookat(25.0);
  level notify("final_clamp");
  setsaveddvar("r_hudOutlineWidth", 2.0);
}

rog_uav_clamp_logic() {
  self endon("death");
  level.player lerpviewangleclamp(0.05, 0.01, 0.01, 15, 15, 10, 10);
  wait 7.5;
  level.player lerpviewangleclamp(2.5, 0.2, 0.2, 20, 40, 2.5, 21);
  wait 4.0;
  level.player lerpviewangleclamp(5.0, 0.2, 0.2, 29, 75, 14, 19.5);
  wait 7.5;
  level.player lerpviewangleclamp(7.5, 0.2, 0.2, 38, 85, 12, 15);
  wait 9.0;
  level.player lerpviewangleclamp(10.0, 0.2, 0.2, 12, 3, 19, 5);
  wait 10.5;
  level.player lerpviewangleclamp(4.5, 0.2, 0.2, 30, 30, 11, 3);
  wait 4.5;
  level.player lerpviewangleclamp(4.2, 0.2, 0.2, 45, 33, 11, 14);
  wait 4.5;
  level.player lerpviewangleclamp(6.0, 0.2, 0.2, 45, 45, 10, 20);
  wait 12.0;
  level.player lerpviewangleclamp(5.0, 0.2, 0.2, 50, 50, 15, 25);
  wait 10.0;
  level.player lerpviewangleclamp(10.0, 0.2, 0.2, 50, 19, 15, 25);
  level waittill("final_clamp");
  level.player lerpviewangleclamp(6.0, 0.2, 0.2, 9, 9, 6, 6);
}

rog_uav_explosion_effects(var_0) {
  var_1 = distancesquared(var_0, level.uav.origin);
  var_2 = int(var_1 / pow(10, 8));
  var_3 = var_2 / 10;

  if(var_3 > 2)
    return;
  else {
    var_4 = 0.0;
    level thread rog_uav_initial_blur(4 * var_3);
    wait(var_3);
    level.player playrumbleonentity("grenade_rumble");

    if(var_3 < 1.5) {
      for(var_5 = 0; var_5 < 6; var_5++)
        level thread maps\loki_rog_hud::uav_static_lines(1);
    }

    if(var_3 < 1.0) {
      for(var_5 = 0; var_5 < 2; var_5++)
        level thread maps\loki_rog_hud::uav_static_lines(1);

      level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "grenade_rumble");
      var_4 = 2.6;
      setblur(4 * var_3, 0.05);
    }

    if(var_3 < 0.6) {
      for(var_5 = 0; var_5 < 3; var_5++)
        level thread maps\loki_rog_hud::uav_static_lines(1);

      level maps\_utility::delaythread(0.4, ::static_flash, 1);
      level.player common_scripts\utility::delaycall(1.0, ::playrumbleonentity, "grenade_rumble");
      var_4 = 1.6;
      setblur(4 * var_3, 0.05);
    }

    if(0.0 < var_4) {
      level.player screenshakeonentity(2, 1, 3, 2.5, 0, 2.5, 1000, 2, 1, 4, var_4);
      level thread uav_focus_recover();
    }
  }
}

uav_focus_recover() {
  level notify("UAV_focus_recover");
  level endon("UAV_focus_recover");
  wait 0.2;
  setblur(4, 0.25);
  wait 0.15;
  setblur(1, 0.5);
  wait 0.2;
  setblur(3, 0.5);
  wait 0.1;
  setblur(0, 0.25);
}

rog_uav_initial_blur(var_0) {
  setblur(var_0, 0.25);
  wait 0.5;
  setblur(0, 0.5);
}

rog_tag_train() {
  var_0 = 4.5;
  var_1 = 0.0;

  for(var_2 = 0; var_2 < 5; var_2++) {
    foreach(var_4 in level.rog_train)
    var_4 hudoutlineenable(3, 0);

    level.player playSound("scn_loki_rog_target_on");
    wait 0.2;

    foreach(var_4 in level.rog_train)
    var_4 hudoutlinedisable();

    wait 0.25;
  }

  foreach(var_4 in level.rog_train)
  var_4 hudoutlineenable(3, 0);

  var_10 = [];
  level.rog_train[7].script_team = "allies";
  var_10[var_10.size] = level.rog_train[7] thread rog_add_hud_element_on_target();
  level.player playSound("scn_loki_rog_target_on");
  common_scripts\utility::flag_wait("ROG_look_at_main_base");
  wait 13.0;

  foreach(var_4 in level.rog_train)
  var_4 hudoutlinedisable();

  common_scripts\utility::flag_wait("ROG_look_at_airfield");

  foreach(var_14 in var_10)
  var_14 destroy();
}

rog_uav_update_lookat(var_0) {
  level.rog_current_lookat_node_index++;
  level.uav.target_ent moveto(level.rog_uav_lookat_pos[level.rog_current_lookat_node_index], var_0, 0.5 * var_0, 0.5 * var_0);
}

rog_attach_to_firing_position() {
  level.player unlink();
  level.player playersetgroundreferenceent(undefined);
  rog_adjust_firing_position();
  level.uav_defualt_fov = 55;
  level.uav = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("uav_camera_spawner_new");
  level.uav_model.origin = level.uav.origin;
  level.uav_model.angles = level.uav.angles;
  level.uav_model linkto(level.uav);
  level.uav uav_useby(level.player, level.rog_uav_lookat_pos[level.rog_current_lookat_node_index]);
  level thread maps\loki_rog_hud::uav_static_lines(0);
  level.uav thread rog_uav_camera_logic();
  level.uav thread rog_uav_clamp_logic();
}

transition_static(var_0, var_1) {
  wait(var_0);
  level thread static_flash(1);
  level notify("end_connection");
  setsaveddvar("cg_cinematicCanPause", "0");

  if(var_1)
    stopcinematicingame();
}

static_flash(var_0, var_1) {
  var_2 = newhudelem();
  var_2.hidewheninmenu = 0;
  var_2.hidewhendead = 1;
  var_2 setshader("overlay_static", 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = 0;
  var_2.sort = 1;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_2.alpha = 1;

    if(isDefined(var_1))
      level.player thread maps\_utility::play_sound_on_entity(var_1);

    wait 0.1;
    var_2.alpha = 0;
    wait 0.2;
  }

  var_2 destroy();
}

uav_useby(var_0, var_1) {
  self.player = var_0;
  self.view_controller = maps\_utility::get_player_view_controller(self, "tag_origin", (0, 0, -8), "player_view_controller");
  var_2 = self.origin + (0, 0, -1000);

  if(isDefined(var_1))
    var_2 = var_1;

  self.target_ent = spawn("script_origin", var_2);
  self.view_controller snaptotargetentity(self.target_ent);
  var_0 unlink();
  self.view_rig = uav_rig_controller(self.view_controller, "player_view_controller_loki");
  var_0 playerlinktodelta(self.view_controller, "tag_player", 0.85, 0, 0, 0, 0, 1);
  setsaveddvar("sv_znear", 192);
  self.view_rig useby(var_0);
  level.player disableturretdismount();
  level.player allowads(0);
  level.player maps\_art::dof_disable_ads();
  self hide();
  self.view_rig setturretfov(level.uav_defualt_fov);
}

uav_rig_controller(var_0, var_1) {
  var_2 = "tag_aim";
  var_3 = var_0 gettagorigin(var_2);
  var_4 = var_0 gettagangles(var_2);

  if(!isDefined(var_1))
    var_1 = "player_view_controller";

  var_5 = spawnturret("misc_turret", var_3, var_1);
  var_5.angles = var_4;
  var_5 setModel("tag_turret");
  var_5 linkto(var_0, var_2, (0, 0, 0), (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  var_5 turretfiredisable();
  return var_5;
}

uav_cam_lookat(var_0, var_1, var_2, var_3, var_4) {
  level.uav.view_controller cleartargetentity();

  if(isDefined(var_4)) {
    level.uav.target_ent.origin = var_0.origin;
    level.uav.target_ent linkto(var_0);
  } else
    level.uav.target_ent.origin = var_0.origin;

  level.uav.view_controller snaptotargetentity(level.uav.target_ent);
  level.player lerpviewangleclamp(var_1, 0, 0, 0, 0, 0, 0);
  wait(var_1);

  if(isDefined(var_3)) {
    thread lerp_turret_fov(var_3, var_1);
    wait(var_2);
  } else
    wait(var_2);

  if(isDefined(var_4))
    level.uav.target_ent unlink();

  if(isDefined(var_3))
    thread lerp_turret_fov(level.uav_defualt_fov, 0.5);

  level notify("camera_release");
  level.player lerpviewangleclamp(1, 0.5, 0.5, 45, 45, 45, 45);
}

lerp_turret_fov(var_0, var_1) {
  level.player lerpfov(var_0, var_1);
  level.uav.view_rig setturretfov(var_0);
}

rog_getcirclepoints(var_0, var_1, var_2) {
  var_3 = 3.14159;
  var_4 = 360 / var_0;
  var_5 = [];

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = var_2[0] + var_1 * cos(var_7);
    var_9 = var_2[1] + var_1 * sin(var_7);
    var_10 = (var_8, var_9, var_2[2]);
    var_5[var_5.size] = var_10;
  }

  return var_5;
}

rog_shockwave() {
  if(!level.vfx_debug_do_shockwave) {
    return;
  }
  var_0 = 3.14159;
  var_1 = var_0 * 2.0;
  var_2 = level._effect["vfx_rog_impact_test"];
  var_3 = self.origin;
  var_4 = 600;
  var_5 = 7;
  var_6 = get_explosion_radius() / var_5 + 1;

  for(var_7 = 1; var_7 < var_5 + 1; var_7++) {
    var_8 = var_7 * var_6;
    var_9 = var_1 * var_8;
    thread throw_rog_destruction(undefined, var_3, randomfloatrange(var_8 * 0.8, var_8 * 1.2));
    var_10 = floor(var_9 / var_4 + 0.5);
    var_11 = rog_getcirclepoints(var_10, var_7 * var_6, var_3);

    foreach(var_13 in var_11) {
      var_14 = vectornormalize(var_13 - var_3);
      var_15 = randomfloatrange(var_4 * -1.0, var_4 * 1.0);
    }

    wait(level.rog_explosion_grow_time / var_5);
  }
}

rog_explosion_fx() {
  var_0 = get_explosion_radius() / level.rog_explosion_grow_time;
  var_1 = self.origin;
  thread update_scripted_explosion_point(var_1);
  var_2 = spawn("script_model", var_1);
  var_2.angles = (-90, 0, 0);
  var_2 setModel("tag_origin");
  var_3 = spawn("script_model", var_1);
  var_3 setModel("tag_origin");
  level.crater_array = common_scripts\utility::add_to_array(level.crater_array, var_3);
  level.crater_array = common_scripts\utility::add_to_array(level.crater_array, var_2);
  thread maps\loki_audio::sfx_rog_impact(var_2);
  level notify("rog_explosion", var_1, "rod");
  level notify("rog_strike");
  thread rog_shockwave();
  wait 0.1;

  if(level.vfx_debug_do_rog_impact_effect) {
    wait 0.08;
    playFXOnTag(common_scripts\utility::getfx("rog_impact_04"), var_2, "tag_origin");
  } else
    wait 0.4;

  physicsexplosionsphere(var_1 + (0, 0, 1000), get_explosion_radius() * 0.5, get_explosion_radius() * 0.3, 3);
  var_4 = 5;
  var_5 = get_explosion_radius() * 0.1;

  while(var_5 < get_explosion_radius()) {
    thread throw_rog_destruction(undefined, var_1, randomfloatrange(var_5 * 0.8, var_5 * 1.2));
    var_5 = var_5 + get_explosion_radius() / var_4;
    wait(level.rog_explosion_grow_time / var_4);
  }

  if(common_scripts\utility::flag("enemies_been_hit") && !common_scripts\utility::flag("allies_been_hit"))
    level notify("enemy_hit");

  common_scripts\utility::flag_clear("enemies_been_hit");
  common_scripts\utility::flag_clear("allies_been_hit");
  physicsexplosionsphere(var_1 + (0, 0, 1000), get_explosion_radius(), get_explosion_radius() * 0.7, 3);

  if(level.vfx_debug_do_structure_destruction) {
    thread random_post_hit_explosions(var_1);
    wait 3;
    playFX(level._effect["thick_dark_smoke_giant_loki"], var_1);
    wait 5;
    playFX(level._effect["thick_black_smoke_l"], var_1);
  }
}

random_post_hit_explosions(var_0) {
  return;

  for(;;) {
    wait(randomfloatrange(1, 6));
    playFX(level._effect["explosion_01"], var_0 + (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0));
  }
}

rog_hit_radiate_ground_shockwave(var_0, var_1) {
  for(var_2 = 0; var_2 < randomintrange(1, 3); var_2++) {
    var_3 = randomfloatrange(0 - var_1 * 2, var_1 * 2);

    if(var_3 < 0 && var_3 > 0 - var_1 * 0.75)
      var_3 = 0 - var_1 * 0.75;

    if(var_3 > 0 && var_3 < var_1 * 0.75)
      var_3 = var_1 * 0.75;

    var_4 = randomfloatrange(0 - var_1 * 2, var_1 * 2);

    if(var_4 < 0 && var_4 > 0 - var_1 * 0.75)
      var_4 = 0 - var_1 * 0.75;

    if(var_4 > 0 && var_4 < var_1 * 0.75)
      var_4 = var_1 * 0.75;

    var_5 = var_0[0] + var_3;
    var_6 = var_0[1] + var_4;
    wait 0.05;
  }
}

get_ent_array_with_prefix(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];
  var_4 = 0;

  for(;;) {
    var_5 = maps\_utility::getent_or_struct_or_node(var_0 + var_2, var_1);

    if(isDefined(var_5))
      var_3[var_4] = var_5;
    else
      break;

    var_2++;
    var_4++;
  }

  return var_3;
}

rog_setup_structures() {
  level.rog_structures = [];
  var_0 = [];
  level.rog_scriptables = [];
  var_0 = getEntArray("destroy_erase", "targetname");
  level.rog_structures = maps\_utility::array_merge(level.rog_structures, var_0);
  var_0 = getEntArray("destroy_erase_terrain", "targetname");
  level.rog_structures = maps\_utility::array_merge(level.rog_structures, var_0);
  var_0 = getEntArray("destroy_spaceport", "targetname");
  level.rog_scriptables = maps\_utility::array_merge(level.rog_scriptables, var_0);
  var_0 = getEntArray("destroy_base", "targetname");
  level.rog_scriptables = maps\_utility::array_merge(level.rog_scriptables, var_0);
  var_0 = getEntArray("destroy_scaffolding", "targetname");
  level.rog_scriptables = maps\_utility::array_merge(level.rog_scriptables, var_0);
  var_0 = getEntArray("destroy_rocket", "targetname");
  level.rog_scriptables = maps\_utility::array_merge(level.rog_scriptables, var_0);
}

rog_scriptable_radius_damage(var_0) {
  var_1 = get_explosion_radius() * 0.7;
  var_2 = get_explosion_radius() * 2;
  wait 0.75;
  radiusdamage(var_0, var_1, 10000, 8000);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in level.rog_scriptables) {
    var_7 = length(var_6.origin - var_0);

    if(var_7 < var_1)
      var_3 = common_scripts\utility::array_add(var_3, var_6);
    else
      var_4 = common_scripts\utility::array_add(var_4, var_6);

    level.rog_scriptables = var_4;
  }

  foreach(var_6 in var_3) {
    switch (var_6.targetname) {
      case "destroy_spaceport":
        playFX(level._effect["loki_rog_spaceport_center_explosion"], var_6.origin + (0, 0, 0), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
      case "destroy_base":
        playFX(level._effect["loki_rog_satellite_dish_explosion"], var_6.origin + (0, 0, 1000), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
      case "destroy_scaffolding":
        playFX(level._effect["loki_rog_rocket_scaffolding_explosion"], var_6.origin + (0, 0, 0), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
    }
  }

  var_11 = [];
  var_4 = [];

  foreach(var_6 in level.rog_scriptables) {
    var_7 = length(var_6.origin - var_0);

    if(var_7 < var_2 && var_7 >= var_1)
      var_11 = common_scripts\utility::array_add(var_11, var_6);
  }

  wait 0.1;

  foreach(var_6 in var_11) {
    switch (var_6.targetname) {
      case "destroy_spaceport":
        playFX(level._effect["loki_rog_spaceport_center_perimeter_hit"], var_6.origin + (0, 0, 2500), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
      case "destroy_base":
        playFX(level._effect["loki_rog_satellite_dish_perimeter_hit"], var_6.origin + (0, 0, 1000), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
      case "destroy_scaffolding":
        playFX(level._effect["loki_rog_rocket_scaffolding_perimeter_hit"], var_6.origin + (0, 0, 2500), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
      case "destroy_rocket":
        playFX(level._effect["loki_rog_satellite_dish_perimeter_hit"], var_6.origin + (0, 0, 2000), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
      case "destroy_small":
        radiusdamage(var_6.origin, 10, 10000, 9000);
        var_6 delete();
        break;
      default:
        playFX(level._effect["loki_rog_satellite_dish_perimeter_hit"], var_6.origin + (0, 0, 500), vectornormalize(var_6.origin - var_0), (0, 0, 1));
        break;
    }
  }
}

rog_structure_destruction(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.rog_structures) {
    var_5 = length(var_4.origin - var_0);

    if(var_5 < get_explosion_radius()) {
      var_1 = common_scripts\utility::array_add(var_1, var_4);
      continue;
    }

    var_2 = common_scripts\utility::array_add(var_2, var_4);
  }

  level.rog_structures = var_2;
  var_7 = 1;
  var_8 = 0.06;

  while(var_7 < get_explosion_radius()) {
    var_7 = var_7 + get_explosion_radius() * var_8;

    foreach(var_4 in var_1) {
      var_5 = length(var_4.origin - var_0);

      if(!isDefined(var_4.already_thrown) && var_7 * 1.25 > var_5) {
        var_4.already_thrown = 1;

        if(var_4.targetname == "destroy_erase") {
          playFX(level._effect["small_building_post_exp"], var_4.origin, anglestoup(var_4.angles), anglesToForward(var_4.angles));
          var_4 hide();
          var_4 delete();
          continue;
        }

        if(var_4.targetname == "destroy_erase_terrain") {
          playFX(common_scripts\utility::getfx("explosion_01"), var_4.origin);
          wait 0.3;
          var_4 hide();
          var_4 delete();
        }
      }
    }

    var_1 = common_scripts\utility::array_removeundefined(var_1);
    wait 0.1;
  }
}

throw_rog_destruction(var_0, var_1, var_2, var_3) {
  if(!level.vfx_debug_do_structure_destruction) {
    return;
  }
  var_4 = 0;

  if(!isDefined(var_0)) {
    var_4 = 1;
    var_0 = spawn("script_model", (var_1[0] + randomintrange(-500, 500), var_1[1] + randomintrange(-500, 500), var_1[2] + randomintrange(10, 150)));
    var_5 = randomintrange(0, 6);

    switch (var_5) {
      case 0:
        var_0 setModel("afr_bg_building_04");
        break;
      case 2:
      case 1:
        var_0 setModel("afr_bg_building_04");
        break;
      case 3:
        var_0 setModel("afr_bg_building_04");
        break;
      case 6:
      case 5:
      case 4:
        var_0 setModel("afr_bg_building_04");
    }
  } else {}

  var_6 = randomfloatrange(0.1, 0.5);
  var_7 = var_0.origin[2];
  var_8 = var_0.origin;
  var_9 = vectornormalize(var_0.origin - var_1);
  var_10 = randomfloatrange(5000, 7500);
  var_11 = (randomfloatrange(5, 30), randomfloatrange(5, 30), randomfloatrange(5, 30));

  if(var_9[2] > var_9[1] && var_9[2] > var_9[0]) {
    var_0 hide();
    return;
  }

  var_12 = var_8 + var_9 * var_10 * 0.2;
  var_0 moveto(var_12 + (0, 0, 200), var_6, 0, 0);
  var_0 rotateby(var_11, var_6, 0, 0);
  wait(var_6 - 0.05);
  var_12 = var_8 + var_9 * var_10 * 0.4;
  var_0 moveto(var_12 + (0, 0, 350), var_6, 0, 0);
  var_0 rotateby(var_11, var_6, 0, 0);
  wait(var_6 - 0.05);
  var_12 = var_8 + var_9 * var_10 * 0.6;
  var_0 moveto(var_12 + (0, 0, 200), var_6, 0, 0);
  var_0 rotateby(var_11, var_6, 0, 0);
  wait(var_6 - 0.05);
  var_12 = var_8 + var_9 * var_10 * 0.8;
  var_0 moveto(var_12, var_6, 0, 0);
  var_0 rotateby(var_11, var_6, 0, 0);
  wait(var_6 - 0.05);
  var_12 = var_8 + var_9 * var_10 * 1.4;
  var_6 = var_6 + 0.5;
  var_0 moveto((var_12[0], var_12[1], getgroundposition(var_0.origin, 5)[2] - 1000), var_6, 0, 0);
  var_0 rotateby(var_11, var_6, 0, 0);
  wait(var_6 - 0.05);
  playFX(level._effect["building_crumble_directional"], var_0.origin, vectornormalize(var_0.origin - var_1), (0, 0, 1));
  wait(var_6 * 0.2);
  var_0.origin = var_0.origin + (0, 0, -3000);

  if(var_4)
    var_0 delete();
}

rog_building_collapse() {
  var_0 = self;
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 addpitch(randomintrange(-10, 10));
  var_1 addyaw(randomintrange(-10, 10));
  var_2 = randomintrange(-2000, -1500);
  var_1.origin = var_1.origin + (0, 0, var_2);
  var_3 = randomfloatrange(3.0, 6.0);
  var_4 = randomfloatrange(4.0, 8.0);

  if(isDefined(var_0.health)) {
    if(var_0.health == 100) {
      wait(randomfloatrange(0.5, 1.0));
      playFX(common_scripts\utility::getfx("building_blast"), var_0.origin);

      if(isDefined(var_0.target)) {
        var_5 = getent(var_0.target, "targetname");
        var_5 moveto(var_5.origin + (0, 0, 380), var_3, 3);
      }

      var_0 moveto(var_1.origin, var_3, 3, 0);
      var_0 rotateto(var_1.angles, var_4, 4, 0);
      wait 2.0;
      playFX(common_scripts\utility::getfx("building_collapse_01"), var_0.origin);
    }
  } else {
    playFX(common_scripts\utility::getfx("building_collapse_02"), var_0.origin);
    var_0 hide();
  }
}

destruction_reset() {
  foreach(var_1 in level.crater_array) {
    if(isDefined(var_1))
      var_1 delete();
  }
}

waittill_any_plus_return(var_0) {
  var_1 = 0;
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    childthread common_scripts\utility::waittill_string(var_4, var_2);

    if(var_4 == "death")
      var_1 = 1;
  }

  if(!var_1)
    self endon("death");

  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

space_cleanup() {
  var_0 = getweaponarray();

  foreach(var_2 in var_0)
  var_2 delete();

  var_4 = getscriptablearray();

  foreach(var_6 in var_4)
  var_6 delete();

  var_8 = getaiarray("axis");

  foreach(var_10 in var_8)
  var_10 delete();

  if(isDefined(level.player.hud_space_helmet_rim))
    level.player.hud_space_helmet_rim maps\_hud_util::destroyelem();

  level.player maps\loki::player_helmet_disable();
}

get_explosion_radius() {
  return level.rog_explosion_radius["rod"];
}

rog_add_hud_element_on_target() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.alpha = 1.0;
  var_0 setshader("hud_rog_target_building_g", 8, 8);
  var_0 settargetent(self);
  var_0 setwaypoint(1, 0, 0, 0);
  return var_0;
}

set_rog_section_gravity() {
  wait 1;
  setsaveddvar("phys_gravity_ragdoll", -610);
  setsaveddvar("phys_gravity", -610);
}

rog_targeting_pip() {
  level.pip_camera = common_scripts\utility::spawn_tag_origin();
  level.pip = level.player newpip();
  level.pip.x = -80;
  level.pip.y = 0;
  level.pip.width = 800;
  level.pip.height = 600;
  level.pip.freecamera = 1;
  level.pip.fov = 90;
  level.pip.enableshadows = 1;
  level.pip.entity = level.pip_camera;
  level.pip.origin = level.pip_camera.origin;
  level.pip.tag = "tag_origin";
  wait 1000;
  level.pip.entity = undefined;
  level.pip.camera = undefined;
  level.pip = undefined;
  level.pip_camera delete();
}

pip_show_target(var_0) {
  wait 2;
  level.pip_camera.origin = var_0 + (6000, 0, 1000);
  var_1 = var_0 - level.pip_camera.origin;
  level.pip_camera.angles = vectortoangles(var_1);
  level.pip.enable = 1;
  var_1 = level.rog_aoe_reticle.origin - level.pip_camera.origin;
  level.pip.look = var_1;
  wait 2;
  level.pip.enable = 0;
}

checking_for_hits() {
  level.recent_rog_hits = 0;

  while(!common_scripts\utility::flag("ROG_take_in_destruction"))
    wait 4;
}

update_scripted_explosion_point(var_0) {
  var_1 = 3.5;

  if(!common_scripts\utility::flag("ROG_hit_loc_1")) {
    common_scripts\utility::flag_set("ROG_hit_loc_1");
    level.explosion_vehicle_killer1 = common_scripts\utility::spawn_tag_origin();
    level.explosion_vehicle_killer1.origin = var_0 + (0, 0, 0);
    wait(var_1);
    level.explosion_vehicle_killer1 delete();
    common_scripts\utility::flag_clear("ROG_hit_loc_1");
    return;
  }

  if(!common_scripts\utility::flag("ROG_hit_loc_2")) {
    common_scripts\utility::flag_set("ROG_hit_loc_2");
    level.explosion_vehicle_killer2 = common_scripts\utility::spawn_tag_origin();
    level.explosion_vehicle_killer2.origin = var_0 + (0, 0, 0);
    wait(var_1);
    level.explosion_vehicle_killer2 delete();
    common_scripts\utility::flag_clear("ROG_hit_loc_2");
    return;
  }

  if(!common_scripts\utility::flag("ROG_hit_loc_3")) {
    common_scripts\utility::flag_set("ROG_hit_loc_3");
    level.explosion_vehicle_killer3 = common_scripts\utility::spawn_tag_origin();
    level.explosion_vehicle_killer3.origin = var_0 + (0, 0, 0);
    wait(var_1);
    level.explosion_vehicle_killer3 delete();
    common_scripts\utility::flag_clear("ROG_hit_loc_3");
    return;
  }

  if(!common_scripts\utility::flag("ROG_hit_loc_4")) {
    common_scripts\utility::flag_set("ROG_hit_loc_4");
    level.explosion_vehicle_killer4 = common_scripts\utility::spawn_tag_origin();
    level.explosion_vehicle_killer4.origin = var_0 + (0, 0, 0);
    wait(var_1);
    level.explosion_vehicle_killer4 delete();
    common_scripts\utility::flag_clear("ROG_hit_loc_4");
    return;
  }
}

vehicle_activate_outline(var_0) {
  self endon("death");

  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  self hudoutlineenable(4, 0);
}

friendly_vehicle_activate_outline(var_0) {
  self endon("death");

  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  self hudoutlineenable(3, 0);
}

check_for_rog_death(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    common_scripts\utility::flag_wait(var_1);

  for(;;) {
    level waittill("rog_explosion", var_2, var_3);

    if(var_3 != "rod") {
      continue;
    }
    childthread rog_vehicle_handle_rod_impact(var_2);
  }
}

vehicle_overkill_from_rog() {
  playFX(level._effect["building_blast"], self.origin);
  rog_target_remove_hud_element();
  self delete();
}

vehicle_blow_up_from_rog() {
  self notify("vehicle_ROG_death");

  if(isDefined(self.vehicletype)) {
    playFXOnTag(level._effect["building_blast"], self, "tag_origin");
    rog_target_remove_hud_element(1);

    if(issubstr(self.classname, "mig"))
      thread rog_kill_jet();

    if(issubstr(self.classname, "hind"))
      thread rog_kill_helicopter();
    else
      self kill();
  }
}

setup_rog_warscene() {
  level.impact_location1 = common_scripts\utility::spawn_tag_origin();
  level.impact_location = (0, 0, 0);
  wait 4;
  common_scripts\utility::flag_wait("ROG_take_in_destruction");
  wait 2;
}

spawn_stage1_missile_trucks() {
  var_0 = getEntArray("ROG_missile_truck_area01", "targetname");

  foreach(var_2 in var_0)
  var_2 thread create_single_missile_truck(1, var_2.origin, var_2.angles, "ROG_look_at_sat_farm");
}

spawn_stage2_missile_trucks() {
  var_0 = getEntArray("ROG_missile_truck_area02", "targetname");

  foreach(var_2 in var_0)
  var_2 thread create_single_missile_truck(2, var_2.origin, var_2.angles, "ROG_look_at_main_base");
}

spawn_stage3_missile_trucks() {
  var_0 = getEntArray("ROG_missile_truck_area03", "targetname");

  foreach(var_2 in var_0)
  var_2 thread create_single_missile_truck(3, var_2.origin, var_2.angles, "ROG_look_at_main_base");
}

create_single_missile_truck(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1);
  var_4 setModel("vehicle_m880_launcher_low");
  var_4.angles = var_2;
  var_4 endon("vehicle_ROG_death");
  var_4 thread vehicle_activate_outline(var_3);
  var_4 thread check_for_rog_death(var_4, var_3);
  wait 11;

  for(;;) {
    wait(randomfloatrange(4, 10));
    var_5 = (randomfloatrange(-19000, -15000), randomfloatrange(3000, 6404), -128075);
    var_4 thread missile_truck_fire_missile(var_5);
  }
}

missile_truck_fire_missile(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self.origin;
  var_2 = self.origin - var_0;
  var_1.angles = vectortoangles(var_2);
  var_3 = var_0[0] - self.origin[0];
  var_4 = var_0[1] - self.origin[1];
  var_5 = distance2d(var_0, self.origin) * 0.75;
  var_6 = 32;
  var_7 = 16;
  var_8 = 0.32;
  var_9 = 1 / var_6;
  var_10 = var_5 / var_6;
  var_11 = [];
  var_12 = [];
  var_13 = [];

  for(var_14 = 1; var_14 <= var_6; var_14++) {
    var_11[var_14 - 1] = self.origin[0] + var_3 * (var_9 * var_14);
    var_12[var_14 - 1] = self.origin[1] + var_4 * (var_9 * var_14);
  }

  for(var_14 = 1; var_14 <= var_7; var_14++)
    var_13[var_14 - 1] = self.origin[2] + var_10 * sqrt(var_14);

  var_15 = var_7;

  for(var_14 = var_7; var_14 <= var_6; var_14++) {
    var_13[var_14] = self.origin[2] + var_10 * sqrt(var_15);
    var_15--;
  }

  var_1 thread rog_missile_fx_trail(var_8, var_6);

  for(var_14 = 1; var_14 <= var_6; var_14++) {
    if(!isDefined(var_13[var_14 - 1])) {
      iprintln("Z " + (var_14 - 1) + " is undefined");
      break;
    }

    var_1 moveto((var_11[var_14 - 1], var_12[var_14 - 1], var_13[var_14]), var_8);
    wait(var_8 - 0.05);
  }

  var_1 moveto(var_0, var_8);
  wait(var_8 - 0.05);
  playFX(common_scripts\utility::getfx("loki_m880_missile_impact"), var_0, (0, 0, 1), anglesToForward(var_1.angles));
  stopFXOnTag(common_scripts\utility::getfx("smoke_geotrail_missile_large"), var_1, "tag_origin");
  level notify("rog_explosion", var_0, "missile");
  var_1 delete();
}

rog_missile_fx_trail(var_0, var_1) {
  var_2 = var_0 * var_1;
  playFXOnTag(common_scripts\utility::getfx("smoke_geotrail_missile_large"), self, "tag_origin");
  self.angles = (45, self.angles[1], self.angles[2]);
  self rotatepitch(-90, var_2);
}

spawn_stage1_bombing_runs() {
  while(!common_scripts\utility::flag("ROG_look_at_train")) {
    thread spawn_bombing_run();
    thread spawn_dogfight_pass();
    wait(randomfloatrange(2.5, 6));
  }
}

spawn_stage1_attack_ground_vehicles() {
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
  thread spawn_single_stage1_ground_vehicle();
}

spawn_stage2_attack_ground_vehicles() {
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
  thread spawn_single_stage2_ground_vehicle();
}

spawn_stage3_attack_ground_vehicles() {
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
  thread spawn_single_stage3_ground_vehicle();
}

spawn_single_stage1_ground_vehicle() {
  var_0 = (randomfloatrange(-9000, 9000), randomfloatrange(-68000, -44000), -128175);
  var_1 = (randomfloatrange(5126, 8385), randomfloatrange(-33139, -32415), -128470);
  var_2 = (randomfloatrange(3261, 6943), randomfloatrange(-21008, -20620), -127338);
  var_3 = (randomfloatrange(-7832, 7069), randomfloatrange(-2640, -1722), -127338);
  spawn_single_ground_vehicle(var_0, var_1, var_2, var_3, "ROG_look_at_sat_farm");
}

spawn_single_stage2_ground_vehicle() {
  var_0 = (randomfloatrange(-30000, -4000), randomfloatrange(-45000, -5000), -127515);
  var_1 = (randomfloatrange(-29000, 0), randomfloatrange(-23000, -5000), -127515);
  var_2 = (randomfloatrange(-29000, 0), randomfloatrange(-23000, -5000), -127515);
  var_3 = (randomfloatrange(-29000, 0), randomfloatrange(-23000, -5000), -127515);
  spawn_single_ground_vehicle(var_0, var_1, var_2, var_3, "ROG_look_at_main_base");
}

spawn_single_stage3_ground_vehicle() {
  var_0 = (randomfloatrange(-30000, 4000), randomfloatrange(15000, 34415), -127000);
  var_1 = (randomfloatrange(-10000, 0), randomfloatrange(15000, 20415), -127000);
  var_2 = (randomfloatrange(-10000, 0), randomfloatrange(15000, 20415), -127000);
  var_3 = (randomfloatrange(-10000, 0), randomfloatrange(15000, 20415), -127000);
  spawn_single_ground_vehicle(var_0, var_1, var_2, var_3, "ROG_look_at_airfield");
}

spawn_single_ground_vehicle(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel("vehicle_t90ms_tank_iw6_low");
  var_5 endon("vehicle_ROG_death");
  var_5 thread vehicle_activate_outline(var_4);
  var_5 thread check_for_rog_death(var_5, var_4);
  var_6 = randomfloatrange(55, 65);
  var_7 = var_1 - var_0;
  var_5 rotateto(vectortoangles(var_7), 0.1);

  if(isDefined(var_4))
    common_scripts\utility::flag_wait(var_4);
  else
    wait(randomfloatrange(0, 2));

  var_5 moveto(var_1, var_6, var_6 * 0.3, var_6 * 0.3);
  var_5 waittill("movedone");
  var_6 = randomfloatrange(25, 35);
  var_7 = var_2 - var_1;
  var_5 rotateto(vectortoangles(var_7), 5, 2, 2);
  var_5 moveto(var_2, var_6, var_6 * 0.3, var_6 * 0.3);
  var_5 waittill("movedone");
  var_6 = randomfloatrange(15, 25);
  var_7 = var_3 - var_2;
  var_5 rotateto(vectortoangles(var_7), 5, 2, 2);
  var_5 moveto(var_3, var_6, var_6 * 0.3, var_6 * 0.3);
  var_5 waittill("movedone");
}

spawn_stage1_attack_helos() {
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
  thread spawn_single_helo();
}

spawn_single_helo() {
  var_0 = (randomfloatrange(-36000, 13000), randomfloatrange(-80000, -50000), randomfloatrange(-126500, -124000));
  var_1 = spawn("script_model", var_0);
  var_1 setModel("vehicle_battle_hind_low");
  var_1 thread vehicle_activate_outline("ROG_look_at_main_base");
  var_1 endon("vehicle_ROG_death");
  var_1 thread check_for_rog_death(var_1);
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_1.origin;
  var_3 = (-16712, 6404, -128075);

  for(;;) {
    var_4 = (randomfloatrange(-30000, -4000), randomfloatrange(-45000, -5000), randomfloatrange(-126500, -124000));
    var_5 = randomfloatrange(15, 35);
    var_6 = var_4 - var_0;
    var_1 rotateto(vectortoangles(var_6), 5, 2, 2);
    var_1 moveto(var_4, var_5, var_5 * 0.3, var_5 * 0.3);
    var_1 waittill("movedone");
    var_6 = var_3 - var_1.origin;
    var_1 rotateto(vectortoangles(var_6), 5, 2, 2);
    var_2.origin = var_1.origin;
    var_2.angles = vectortoangles(var_6);
    playFXOnTag(level._effect["antiair_runner_flak"], var_2, "tag_origin");
    wait(var_5 * 0.5);
    stopFXOnTag(level._effect["antiair_runner_flak"], var_2, "tag_origin");
  }
}

spawn_dogfight_pass() {}

spawn_bombing_run(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = (randomfloatrange(-40638, -2454), randomfloatrange(-80675, -69493), -124148);

  if(!isDefined(var_1))
    var_1 = (randomfloatrange(-18256, 26735), randomfloatrange(48087, 52200), -124148);

  if(!isDefined(var_2))
    var_2 = randomfloatrange(10, 20);

  var_3 = 0;
  var_4 = randomintrange(2, 7);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    if(var_4 < 4)
      thread single_bomb_run_script(var_0 + (var_3, 0 - abs(var_3), 0), var_1 + (var_3, 0 - abs(var_3), 0), var_2, "large");
    else
      thread single_bomb_run_script(var_0 + (var_3, 0 - abs(var_3), 0), var_1 + (var_3, 0 - abs(var_3), 0), var_2, "small");

    if(var_3 < 0) {
      var_3 = (var_3 - randomfloatrange(500, 2000)) * -1;
      continue;
    }

    var_3 = (var_3 + randomfloatrange(500, 2000)) * -1;
  }
}

single_bomb_run_script(var_0, var_1, var_2, var_3) {
  var_2 = var_2 * randomfloatrange(0.9, 1.1);
  var_4 = spawn("script_model", var_0 + (0, 0, randomfloatrange(0, 3000)));
  var_4 setModel("vehicle_mig29");
  var_4 thread vehicle_activate_outline("ROG_look_at_sat_farm");
  var_4 endon("vehicle_ROG_death");
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.origin = var_4.origin + (0, -300, 0);
  var_5 linkto(var_4);
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_1;
  var_7 = var_1 - var_0;
  var_4.angles = vectortoangles(var_7);
  var_5 unlink();
  var_8 = var_0 - var_1;
  var_5.angles = vectortoangles(var_8);
  var_5 linkto(var_4);
  var_4 thread check_for_rog_death(var_4);
  playFXOnTag(level._effect["battle_contrail"], var_5, "tag_origin");
  playFXOnTag(level._effect["engineeffect"], var_5, "tag_origin");
  var_4 moveto(var_1, var_2);

  if(randomintrange(0, 10) > 3) {
    var_9 = var_2 * randomfloatrange(0.4, 0.75);
    wait(var_9);
    var_4 moveto(var_1 + (0, 0, randomfloatrange(5000, 16000)), var_2 - var_9);

    if(var_3 == "large") {
      for(var_10 = 0; var_10 < randomintrange(1, 3); var_10++) {
        playFX(level._effect["explosion_01"], var_4.origin + (0, 0, -4000));
        wait(randomfloatrange(0.1, 0.3));
      }
    } else {
      for(var_10 = 0; var_10 < randomintrange(4, 10); var_10++) {
        playFX(level._effect["loki_m880_missile_impact"], var_4.origin + (0, 0, -4000));
        wait(randomfloatrange(0.05, 0.2));
      }
    }

    var_4 waittill("movedone");
  } else {
    wait(var_2 * randomfloatrange(0.1, 0.7));
    playFXOnTag(level._effect["vfx_fire_burning_zerog"], var_4, "tag_origin");
    wait(var_2 * randomfloatrange(0.1, 0.2));
    playFXOnTag(level._effect["building_blast"], var_4, "tag_origin");
    var_4 moveto((var_4.origin[0] + randomfloatrange(1000, 2000), var_4.origin[1] + randomfloatrange(3000, 6000), var_4.origin[2] - 3000), 3);
    var_4 rotateto((randomintrange(100, 1350), randomintrange(100, 1350), randomintrange(100, 1350)), 3);
    wait 2.9;
    playFXOnTag(level._effect["building_blast"], var_4, "tag_origin");
    wait 0.1;
    stopFXOnTag(level._effect["vfx_fire_burning_zerog"], var_4, "tag_origin");
  }

  stopFXOnTag(level._effect["battle_contrail"], var_5, "tag_origin");
  stopFXOnTag(level._effect["engineeffect"], var_5, "tag_origin");
  wait 1;
  var_5 delete();
  var_6 delete();
  var_4 hudoutlinedisable();
  var_4 delete();
}

rog_update_visibility_volume() {
  level notify("visibility_update");
  level.rog_pass_fail["axis"]["targets"] = 0;
  level thread rog_check_done();
  level.rog_active_visibilty_volume = getent("ROG_visibility_vol_" + level.rog_visibility_volume_index, "targetname");
  level.rog_visibility_volume_index++;
}

rog_update_visibility_volume_empty() {
  level notify("visibility_update");
  level.rog_active_visibilty_volume = getent("ROG_visibility_vol_3", "targetname");
}

rog_update_visibility_volume_on_notify(var_0) {
  level waittill(var_0);
  rog_update_visibility_volume();
}

rog_check_done() {
  level endon("visibility_update");
  common_scripts\utility::flag_clear("ROG_section_done");

  for(;;) {
    if(level.rog_pass_fail["axis"]["targets"] <= 0) {
      break;
    }

    wait 0.5;
  }

  common_scripts\utility::flag_set("ROG_section_done");
}

wtf_is_it(var_0) {
  for(;;)
    wait 1.0;
}

debug_wait(var_0) {
  while(var_0 > 0) {
    iprintln(var_0);

    if(1.0 < var_0)
      wait 1.0;
    else
      wait(var_0);

    var_0 = var_0 - 1.0;
  }
}

rog_exit() {
  rog_achievement_check();
  level thread transition_static(0.0, 0);
  level thread rog_cleanup();
  common_scripts\utility::flag_set("ROG_exit");
}

rog_cleanup() {
  destruction_reset();
  level.player.ignoreme = 0;
  level notify("ROG_end");
  level notify("slamzoom_start");
  maps\loki_rog_hud::remove_all_static_lines();
  level notify("ROG_new_sequence");
  level.player playersetgroundreferenceent(undefined);
  level.player thermalvisionoff();
  level.player thread maps\_load::thermal_effectsoff();
  level.player enableturretdismount();
  level.uav.view_rig maketurretinoperable();
  level.uav.view_rig useby(level.player);
  level.uav.view_rig delete();
  level.uav.view_controller delete();
  level.uav.target_ent delete();
  level.uav delete();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level.player allowcrouch(1);
  level.player allowjump(1);
  level.player allowmelee(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player enableweaponswitch();
  level.player allowmelee(1);
  level.player allowfire(1);
  level.player showviewmodel();
  level.player clearclienttriggeraudiozone(0.1);
  level.player allowads(1);
  level.player maps\loki::player_helmet();
  level.player unlink();
  level.player notify("end_uav_audio");
  level.bg_loop_sound delete();
  level.uav_model delete();
  setsaveddvar("sv_znear", 0);
  setsaveddvar("scr_dof_enable", 0);
  stopallrumbles();
  level thread maps\loki_ending::get_player_ready_to_look_at_screen();
  level.player setclientomnvar("ui_loki_rog", 0);
}

rog_uav_camera_move_audio() {
  self endon("end_uav_audio");
  var_0 = 0;
  level.bg_loop_sound = spawn("script_origin", self.origin);
  thread play_actuator_click();

  for(;;) {
    var_1 = self getnormalizedcameramovement();

    if(!var_0 && (abs(var_1[0]) > 0.25 || abs(var_1[1]) > 0.25)) {
      level.bg_loop_sound playLoopSound("scn_loki_rog_servo_lp");
      var_0 = 1;
    }

    if(var_0 && (abs(var_1[0]) < 0.25 && abs(var_1[1]) < 0.25)) {
      level.bg_loop_sound stoploopsound();
      var_0 = 0;
    }

    wait 0.05;
  }
}

play_actuator_click() {
  level endon("ROG_script_done");
  var_0 = self getnormalizedcameramovement();
  var_1 = var_0;
  var_2 = var_0[0] - var_1[0] * 10;
  var_3 = var_0[1] - var_1[1] * 10;
  var_4 = var_2;
  var_5 = var_3;

  for(;;) {
    var_0 = self getnormalizedcameramovement();
    var_2 = var_0[0] - var_1[0] * 10;
    var_3 = var_0[1] - var_1[1] * 10;

    if(!common_scripts\utility::flag("click_too_soon")) {
      if(length(var_0 - var_1) * 10 > 11 || abs(var_3 - var_5) > 9 && abs(var_0[1] * 10) > 7.5 || abs(var_2 - var_4) > 9 && abs(var_0[0] * 10) > 7.5) {
        common_scripts\utility::flag_set("click_too_soon");
        thread actuator_click_wait(0.4);
      }
    }

    var_1 = var_0;
    var_4 = var_2;
    var_5 = var_3;
    wait 0.1;
  }
}

actuator_click_wait(var_0) {
  wait(var_0);
  common_scripts\utility::flag_clear("click_too_soon");
}

rog_reveal_audio() {
  level endon("ROG_script_done");

  for(;;) {
    level waittill("target_reveal");
    level.player playSound("scn_loki_rog_target_on");
    wait 0.05;
  }
}

rog_check_early_out() {
  common_scripts\utility::flag_wait("ROG_look_at_airfield");
  level waittill("visibility_update");
  wait 1.55;

  for(;;) {
    if(level.rog_pass_fail["axis"]["targets"] <= 0) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("ROG_early_out");
}

rog_ambiant_battle_chatter() {
  level endon("ROG_take_in_destruction");
  wait 1.0;
  var_0 = ["loki_mrk_beadvisedbadgerone", "loki_us2_roger", "loki_kgn_badgeronewheredo", "loki_us2_everywheretheyresettingup", "loki_us2_significantenemyforces", "loki_com_rogerbadgerrequisition", "loki_mrk_weretrackingmultiple", "loki_mrk_sendingintercept", "loki_kgn_coordinatesreceived"];
  var_1 = [4.25, 1.25, 2.75, 7.0, 5.5, 7.0, 3.75, 3.0, 8.0];

  for(;;) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      common_scripts\utility::flag_waitopen("ROG_VO_script_active");
      self playSound(var_0[var_2]);
      wait(var_1[var_2]);
    }
  }
}

rog_kill_jet() {
  var_0 = distance(self vehicle_getvelocity(), (0, 0, 0));
  var_1 = vectornormalize(anglesToForward(self.angles));
  playFX(level._effect["loki_rog_jet_explosion_death"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  self delete();
}

rog_kill_jet_even_more() {
  wait 7.0;
  playFX(level._effect["vfx_exp_heli_sml_cg_cheap"], self.origin);
  self delete();
}

rog_kill_helicopter() {
  self endon("death");
  self kill();
  wait(randomfloatrange(3.5, 6.5));
  playFX(level._effect["vfx_exp_heli_sml_cg_cheap"], self.origin);
  self delete();
}

rog_card_swap() {
  common_scripts\utility::flag_wait("ROG_look_at_airfield");

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = getent("ROG_air_strip_card_" + var_0, "targetname");
    var_1 delete();
  }
}

rog_running_cleanup() {
  var_0 = [37.0, 3.0, 9.5];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    wait(var_0[var_1]);
    var_2 = getent("ROG_cleanup_vol_" + var_1, "targetname");

    foreach(var_4 in level.rog_target_models) {
      if(isDefined(var_4) && var_4 istouching(var_2))
        var_4 rog_target_overkill_death(1, 0);
    }

    level.rog_target_models = common_scripts\utility::array_removeundefined(level.rog_target_models);
    var_2 delete();
  }
}

rog_check_pass_fail(var_0) {
  var_1 = 0;

  if(level.rog_pass_fail["axis"]["targets"] <= level.rog_pass_fail["axis"][var_0])
    var_1 = 1;

  return var_1;
}

rog_fail_wrapper() {
  if(!common_scripts\utility::flag("ROG_no_fail")) {
    if(level.rog_ff_fail)
      setdvar("ui_deadquote", &"LOKI_ROG_FAIL_FF");
    else if(level.rog_track_fail)
      setdvar("ui_deadquote", &"LOKI_ROG_FAIL_TRAINTRACK");
    else
      setdvar("ui_deadquote", &"LOKI_ROG_FAIL");

    level thread maps\_utility::missionfailedwrapper();
  }
}

rog_check_friendly_fire() {
  level endon("rog_done");
  level endon("ROG_passed");
  var_0 = 1;

  for(;;) {
    if(var_0 && level.rog_pass_fail["allies"]["targets"] > 0) {
      common_scripts\utility::flag_waitopen("ROG_VO_script_active");
      wait 0.5;
      maps\_utility::smart_radio_dialogue("loki_kgn_thompsongetyourshots");
      var_0 = 0;

      if(level.rog_pass_fail["allies"]["targets"] > level.rog_pass_fail["allies"]["c"])
        level.rog_pass_fail["allies"]["c"] = level.rog_pass_fail["allies"]["targets"] + 2;
    } else if(!var_0) {
      level.rog_ff_fail = level.rog_pass_fail["allies"]["targets"] > level.rog_pass_fail["allies"]["c"];

      if(level.rog_ff_fail) {
        level notify("fail");
        rog_fail_wrapper();
      }
    }

    wait 0.2;
  }
}

rog_check_progress() {
  common_scripts\utility::flag_wait("ROG_look_at_train");

  if(!rog_check_pass_fail("a")) {
    rog_fail_wrapper();
    return;
  }

  common_scripts\utility::flag_wait("ROG_look_at_airfield");

  if(!rog_check_pass_fail("b")) {
    rog_fail_wrapper();
    return;
  }

  common_scripts\utility::flag_wait("ROG_take_in_destruction");

  if(!rog_check_pass_fail("c")) {
    rog_fail_wrapper();
    return;
  }

  common_scripts\utility::flag_set("ROG_passed");
}

rog_vo_section_a() {
  var_0 = 0;
  var_1 = level common_scripts\utility::waittill_any_timeout(6.0, "rog_strike");

  if(var_1 == "rog_strike" || level.rog_strike_active > 0) {
    if(var_1 == "rog_strike")
      wait 1.15;
    else {
      level waittill("rog_strike");
      wait 1.15;
    }

    if(level.rog_pass_fail["axis"]["targets"] < 3) {
      common_scripts\utility::flag_set("ROG_VO_script_active");
      level maps\_utility::smart_radio_dialogue("loki_mrk_holytheyfeltthat");
      common_scripts\utility::flag_clear("ROG_VO_script_active");
      var_0 = 1;
    } else {
      common_scripts\utility::flag_set("ROG_VO_script_active");
      maps\_utility::smart_radio_dialogue("loki_gs3_weneedtoclear");
      common_scripts\utility::flag_clear("ROG_VO_script_active");
    }
  } else {
    common_scripts\utility::flag_set("ROG_VO_script_active");
    level maps\_utility::smart_radio_dialogue("loki_gs3_weneedtoclear");
    common_scripts\utility::flag_clear("ROG_VO_script_active");
  }

  if(!var_0) {
    var_1 = level common_scripts\utility::waittill_any_timeout(3.0, "rog_strike");

    if(var_1 == "rog_strike" || level.rog_strike_active > 0) {
      if(var_1 == "rog_strike")
        wait 1.15;
      else {
        level waittill("rog_strike");
        wait 1.15;
      }

      if(level.rog_pass_fail["axis"]["targets"] < 3) {
        common_scripts\utility::flag_set("ROG_VO_script_active");
        level maps\_utility::smart_radio_dialogue("loki_mrk_holytheyfeltthat");
        common_scripts\utility::flag_clear("ROG_VO_script_active");
      }
    } else {
      common_scripts\utility::flag_set("ROG_VO_script_active");
      maps\_utility::smart_radio_dialogue("loki_us3_ourforcesneedsupport");
      common_scripts\utility::flag_clear("ROG_VO_script_active");
    }
  }

  var_2 = gettime();
  common_scripts\utility::flag_wait("rog_vo_0");

  if(gettime() - var_2 > 250) {
    if(level.rog_pass_fail["axis"]["targets"] <= 0) {
      common_scripts\utility::flag_set("ROG_VO_script_active");
      maps\_utility::smart_radio_dialogue("loki_kgn_southernreinforcements");
      common_scripts\utility::flag_clear("ROG_VO_script_active");
    }
  }
}

rog_vo_section_b() {
  wait 3.0;

  if(level.rog_pass_fail["axis"]["targets"] <= level.rog_pass_fail["axis"]["b"]) {
    wait 1.0;
    common_scripts\utility::flag_set("ROG_VO_script_active");
    maps\_utility::smart_radio_dialogue("loki_mrk_nicejobicarus");
    common_scripts\utility::flag_clear("ROG_VO_script_active");
  } else {
    common_scripts\utility::flag_set("ROG_VO_script_active");
    maps\_utility::smart_radio_dialogue("loki_mrk_groundforcesneedmore");
    common_scripts\utility::flag_clear("ROG_VO_script_active");
  }
}

rog_vo_section_c() {
  wait 6.0;

  while(level.rog_strike_active > 0)
    wait 0.05;

  if(level.rog_pass_fail["axis"]["targets"] > level.rog_pass_fail["axis"]["c"]) {
    common_scripts\utility::flag_set("ROG_VO_script_active");
    maps\_utility::smart_radio_dialogue("loki_mrk_icarusgroundunitsare");
    common_scripts\utility::flag_clear("ROG_VO_script_active");
  }
}

rog_achievement_gather_targets() {
  var_0 = 0;
  var_1 = getEntArray("targets_spaceport_firing01", "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_firing04", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_firing02", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_firing03", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_firing05", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_firing06", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_firing07", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_west_firing01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_north_firing01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_north_firing02", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_missile_launcher_area_02", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_missile_launcher_area_03", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("large_target_markers", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_missile_launcher_area_01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_spaceport_01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_dish_field_01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_dish_field_02", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_dish_field_03", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_retreating_allies03", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_retreating_allies04", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_allies_moving_01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_allies_static_01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_allies_west_firing01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_allies_north_firing01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_allies_north_firing02", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_west", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_north_01", "targetname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("targets_airfield_north_02", "targetname"));

  foreach(var_3 in var_1) {
    if(var_3.script_team == "axis")
      var_0++;
  }

  level.rog_achievement_target_count = var_0;
}

rog_achievement_check() {
  if(level.rog_pass_fail["allies"]["targets"] <= 0) {
    if(level.rog_num_enemy_targets_killed + level.rog_achievement_target_count_adjustment >= level.rog_achievement_target_count)
      level.player maps\_utility::player_giveachievement_wrapper("LEVEL_17A");
  }
}

rog_check_train_track_damage(var_0) {
  var_1 = level.rog_closest_path_node;
}