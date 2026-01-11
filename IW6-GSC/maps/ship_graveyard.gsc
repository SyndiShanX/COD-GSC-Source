/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard.gsc
*****************************************************/

main() {
  level.shark_functions = [];
  level.shark_functions["init"] = animscripts\shark\shark_init::main;
  level.shark_functions["move"] = animscripts\shark\shark_move::main;
  level.shark_functions["stop"] = animscripts\shark\shark_stop::main;
  level.shark_functions["pain"] = animscripts\shark\shark_pain::main;
  level.shark_functions["scripted"] = animscripts\shark\shark_scripted::main;
  level.shark_functions["scripted_init"] = animscripts\shark\shark_scripted::init;
  level.shark_functions["reactions"] = animscripts\shark\shark_reactions::main;
  level.shark_functions["flashed"] = animscripts\shark\shark_flashed::main;
  level.shark_functions["death"] = animscripts\shark\shark_death::main;
  level.shark_functions["combat"] = animscripts\shark\shark_combat::main;
  maps\ship_graveyard_util::shark_collision_setup();
  maps\_player_rig::init_player_rig("viewhands_player_us_udt");
  maps\_utility::intro_screen_create(&"SHIP_GRAVEYARD_INTROSCREEN_LINE_1", &"SHIP_GRAVEYARD_INTROSCREEN_LINE_2", &"SHIP_GRAVEYARD_INTROSCREEN_LINE_5");
  maps\_utility::intro_screen_custom_func(::custom_intro_screen_func);
  level.debris = ["shpg_machinery_baggage_container_dmg"];

  foreach(var_1 in level.debris) {
  precachemodel(var_1);
  }

  precacheitem("remote_torpedo_tablet");
  precacheitem("underwater_torpedo");
  precachemodel("vehicle_boat_underneath_1");
  precachemodel("vehicle_boat_underneath_2");
  precachemodel("vehicle_mini_sub_iw6");
  precachemodel("body_seal_udt_dive_a");
  precachemodel("vehicle_lcs");
  precachemodel("vehicle_lcs_flir");
  precachemodel("vehicle_lcs_destroyed_front");
  precachemodel("vehicle_lcs_destroyed_back");
  precachemodel("shpg_udt_headgear_player_a");
  precachemodel("fullbody_tigershark");
  precachemodel("vehicle_mi_28_destroyed");
  precachemodel("weapon_parabolic_knife");
  precachemodel("viewmodel_knife");
  precachemodel("com_barrel_benzin2");
  precachemodel("shpg_wrkdoor_a1_obj");
  precachemodel("shpg_lighthouse_top");
  precachemodel("shpg_lighthouse_glass");
  precachemodel("shpg_lighthouse_glass_broken");
  precachemodel("weapon_underwater_torch");
  precachemodel("props_scuba_hose_a");
  precachemodel("viewmodel_torpedo");
  precachemodel("shpg_dbreach_pipe_a");
  precachemodel("shpg_viewmodel_scuba_mask_cr01");
  precachemodel("shpg_viewmodel_scuba_mask_cr02");
  precachemodel("shpg_viewmodel_scuba_mask_cr03");
  precachemodel("viewmodel_underwater_torch");
  precachemodel("shpg_wrkdoor_a1_normal");
  precachemodel("shpg_wrkdoor_a1_broken01");
  precachemodel("shpg_wrkdoor_a1_broken02");
  precachemodel("torpedo_crtplane");
  precachemodel("shpg_bang_stick");
  precachemodel("body_fed_udt_assault_a_ally_trailer");
  precacheshellshock("depth_charge_hit");
  precacheshellshock("sonar_ping");
  precacheshellshock("sonar_ping_light");
  precacheshellshock("nearby_crash_underwater");
  precacheshellshock("shipg_player_drown");
  precacherumble("damage_light");
  precacherumble("damage_heavy");
  precacherumble("tank_rumble_fading");
  precacherumble("subtle_tank_rumble");
  precacherumble("littoral_ship_rumble");
  precacherumble("heavy_3s");
  precacherumble("light_1s");
  precachestring(&"SHIP_GRAVEYARD_HINT_TORPEDO");
  precachestring(&"SHIP_GRAVEYARD_HINT_DROWN");
  precachestring(&"SHIP_GRAVEYARD_HINT_X");
  precachestring(&"SHIP_GRAVEYARD_HINT_RT");
  precachestring(&"SHIP_GRAVEYARD_HINT_SPRINT");
  precachestring(&"SHIP_GRAVEYARD_HINT_DOWN_GAMEPAD");
  precachestring(&"SHIP_GRAVEYARD_HINT_DOWN_STANCE");
  precachestring(&"SHIP_GRAVEYARD_HINT_DOWN_CROUCH");
  precachestring(&"SHIP_GRAVEYARD_HINT_DOWN_HOLD_CROUCH");
  precachestring(&"SHIP_GRAVEYARD_HINT_UP_GAMEPAD");
  precachestring(&"SHIP_GRAVEYARD_HINT_UP_STAND");
  precachestring(&"SHIP_GRAVEYARD_HINT_TRENCH");
  precachestring(&"SHIP_GRAVEYARD_E3_TIME");
  precachestring(&"SHIP_GRAVEYARD_HINT_FLASHLIGHT");
  precachestring(&"SHIP_GRAVEYARD_HINT_WELD");
  precachestring(&"SHIP_GRAVEYARD_HINT_DIVE");
  precachestring(&"SHIP_GRAVEYARD_HINT_TGT_NOTFOUND");
  precachestring(&"SHIP_GRAVEYARD_HINT_TGT_BLOCKED");
  precacheshader("gasmask_overlay");
  precacheshader("halo_overlay_scuba_steam");
  precacheshader("halo_overlay_water");
  precacheshader("blank");
  precacheshader("overlay_grain");
  precacheshader("torpedo_center");
  precacheshader("torpedo_centerbox");
  precacheshader("torpedo_centerline");
  precacheshader("torpedo_databit_1");
  precacheshader("torpedo_databit_2");
  precacheshader("torpedo_databit_3");
  precacheshader("torpedo_frame_center");
  precacheshader("torpedo_frame_center_bottom");
  precacheshader("torpedo_frame_edge");
  precacheshader("torpedo_frame_edge_l");
  precacheshader("torpedo_frame_edge_r");
  precacheshader("torpedo_frame_lines_ll");
  precacheshader("torpedo_frame_lines_lr");
  precacheshader("torpedo_frame_lines_ul");
  precacheshader("torpedo_frame_lines_ur");
  precacheshader("torpedo_horizonline");
  precacheshader("torpedo_sidebracket_l");
  precacheshader("torpedo_sidebracket_r");
  precacheshader("torpedo_connection_bar");
  precacheshader("torpedo_connection_frame");
  precacheshader("torpedo_connection_text");
  precacheshader("apache_targeting_circle");
  precacheshader("white");
  maps\_swim_player::init_player_swim();
  maps\_swim_ai::init_ai_swim();
  maps\_drone_ai::init();
  maps\_utility::template_level("ship_graveyard");
  maps\_utility::add_hint_string("hint_down_gamepad", &"SHIP_GRAVEYARD_HINT_DOWN_GAMEPAD", maps\ship_graveyard_util::hintdown_test);
  maps\_utility::add_hint_string("hint_down_stance", &"SHIP_GRAVEYARD_HINT_DOWN_STANCE", maps\ship_graveyard_util::hintdown_test);
  maps\_utility::add_hint_string("hint_down_crouch", &"SHIP_GRAVEYARD_HINT_DOWN_CROUCH", maps\ship_graveyard_util::hintdown_test);
  maps\_utility::add_hint_string("hint_down_hold_crouch", &"SHIP_GRAVEYARD_HINT_DOWN_HOLD_CROUCH", maps\ship_graveyard_util::hintdown_test);
  maps\_utility::add_hint_string("hint_up_gamepad", &"SHIP_GRAVEYARD_HINT_UP_GAMEPAD", maps\ship_graveyard_util::hintup_test);
  maps\_utility::add_hint_string("hint_up_stand", &"SHIP_GRAVEYARD_HINT_UP_STAND", maps\ship_graveyard_util::hintup_test);
  maps\_utility::add_hint_string("hint_sprint", &"SHIP_GRAVEYARD_HINT_SPRINT", maps\ship_graveyard_util::hintsprint_test);
  maps\_utility::add_hint_string("hint_flashlight", &"SHIP_GRAVEYARD_HINT_FLASHLIGHT", maps\ship_graveyard_util::hintflashlight_test);
  maps\_utility::add_hint_string("hint_notfound", &"SHIP_GRAVEYARD_HINT_TGT_NOTFOUND");
  maps\_utility::add_hint_string("hint_blocked", &"SHIP_GRAVEYARD_HINT_TGT_BLOCKED");
  maps\_utility::add_start("start_tutorial", ::start_tutorial, undefined, ::tutorial_setup);
  maps\_utility::add_start("start_swim", ::start_swim, undefined, ::intro_setup);
  maps\_utility::add_start("start_wreck_approach", ::start_wreck_approach, undefined, ::wreck_approach_setup);
  maps\_utility::add_start("start_small_wreck", ::start_small_wreck, undefined, ::small_wreck_setup);
  maps\_utility::add_start("start_stealth_1", ::start_stealth_1, undefined, ::stealth_area_1_setup);
  maps\_utility::add_start("start_stealth_2", ::start_stealth_2, undefined, ::stealth_area_2_setup);
  maps\_utility::add_start("start_cave", ::start_cave, undefined, ::cave_setup);
  maps\_utility::add_start("start_sonar", ::start_sonar, undefined, ::sonar_setup);
  maps\_utility::add_start("start_sonar_mines", ::start_sonar_mines, undefined, ::sonar_mine_setup);
  maps\_utility::add_start("start_new_trench", ::start_new_trench, undefined, ::new_trench_setup);
  maps\_utility::add_start("start_new_canyon", ::start_new_canyon, undefined, ::new_canyon_setup);
  maps\_utility::add_start("start_depth_charges", ::start_depth_charges, undefined, ::depth_charges_setup);
  maps\_utility::add_start("start_big_wreck", ::start_big_wreck, undefined, ::big_wreck_setup);
  maps\_utility::add_start("start_big_wreck_2", ::start_big_wreck_2, undefined, ::big_wreck_2_setup);
  maps\_utility::add_start("end_tunnel_swim", ::start_end_tunnel_swim, undefined, maps\ship_graveyard_code::end_tunnel_swim);
  maps\_utility::add_start("test_area_1", ::start_test_1, undefined);
  maps\_utility::add_start("test_area_2", ::start_test_2, undefined);
  maps\_utility::set_default_start("start_tutorial");
  maps\ship_graveyard_anim::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 3.5);

  if(maps\_utility::is_gen4()) {}

  if(getdvar("createfx", "") == "on") {
    level.struct_class_names = undefined;
    common_scripts\utility::struct_class_init();
    var_3 = common_scripts\utility::getstruct("lighthouse_node", "targetname");
    var_4 = spawn("script_model", (0, 0, 0));
    var_4 setModel("vehicle_lcs_destroyed_front");
    var_4.animname = "lcs_front";
    var_4 maps\_anim::setanimtree();
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel("vehicle_lcs_destroyed_back");
    var_5.animname = "lcs_back";
    var_5 maps\_anim::setanimtree();
    var_3 maps\_anim::anim_first_frame([var_4, var_5], "lighthouse_fall");
    level.struct_class_names = undefined;
  }

  maps\createart\ship_graveyard_art::main();
  maps\ship_graveyard_fx::main();
  maps\ship_graveyard_precache::main();
  thread maps\ship_graveyard_fx::mask_interactives();
  maps\_load::main();

  if(level.xenon) {
    setsaveddvar("r_texFilterProbeBilinear", 1);
  }

  if(!maps\_utility::is_gen4()) {
    setsaveddvar("sm_sunshadowscale", 0.55);
  }

  if(maps\_utility::is_gen4()) {
    maps\_art::disable_ssao_over_time(40);
    setsaveddvar("r_tessellationFactor", 40);
  }

  maps\ship_graveyard_audio::main();
  init_level_flags();
  maps\ship_graveyard_util::paired_death_restart();
  thread set_dof_for_player_mask();
  maps\_swim_player::init_player_swim_anims();
  level.water_level_z = common_scripts\utility::get_target_ent("water_level_org");
  level.water_level_z = level.water_level_z.origin[2];
  level.default_goalradius = 64;
  maps\ship_graveyard_stealth::stealth_init();
  level.player thread maps\ship_graveyard_stealth::player_stealth();
  level.balloon_count = 0;
  common_scripts\utility::array_thread(getEntArray("salvage_cargo", "script_noteworthy"), maps\ship_graveyard_util::salvage_cargo_setup);
  common_scripts\utility::array_thread(getEntArray("moveup_when_clear", "targetname"), maps\ship_graveyard_util::move_up_when_clear);
  common_scripts\utility::array_thread(getEntArray("trigger_depth_charges", "targetname"), maps\ship_graveyard_util::trigger_depth_charges);
  common_scripts\utility::array_thread(getEntArray("dyn_balloon", "targetname"), maps\ship_graveyard_util::dyn_balloon_think);
  common_scripts\utility::array_thread(getEntArray("dyn_balloon_new", "targetname"), maps\ship_graveyard_util::new_dyn_balloon_think);
  common_scripts\utility::array_thread(getEntArray("shark_go", "targetname"), maps\ship_graveyard_util::shark_go_trig);
  common_scripts\utility::array_thread(getEntArray("trigger_multiple_fx_volume_off", "classname"), maps\ship_graveyard_util::trigger_multiple_fx_volume_off_target);
  common_scripts\utility::array_thread(getEntArray("cull_trigger", "targetname"), maps\ship_graveyard_util::cull_trigger_logic);
  maps\_utility::array_spawn_function(vehicle_getspawnerarray(), maps\ship_graveyard_util::vehicle_setup);
  maps\_utility::array_spawn_function(getspawnerarray(), maps\ship_graveyard_util::make_swimmer);
  maps\_utility::array_spawn_function(getspawnerarray(), maps\ship_graveyard_util::add_headlamp);
  maps\_utility::array_spawn_function(getspawnerarray(), maps\ship_graveyard_stealth::ai_stealth_init);
  maps\_utility::array_spawn_function(getspawnerarray(), maps\ship_graveyard_util::track_death);
  maps\_utility::array_spawn_function(getspawnerarray(), maps\ship_graveyard_util::read_parameters);
  maps\_utility::array_spawn_function(getEntArray("actor_test_enemy_shark_dog", "classname"), maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::array_spawn_function(getEntArray("actor_test_enemy_shark_dog", "classname"), maps\_swim_ai::underwater_blood);
  maps\_utility::array_spawn_function_noteworthy("jumper", maps\ship_graveyard_util::jump_into_water);
  maps\_utility::array_spawn_function_noteworthy("ground_hug_sdv", maps\ship_graveyard_util::sdv_silt_kickup);
  maps\_utility::array_spawn_function_targetname("sdv_follow", maps\ship_graveyard_code::sdv_follow_spotted_react);
  maps\_utility::array_spawn_function_targetname("sdv_follow", maps\ship_graveyard_util::sdv_patrol_setup);
  maps\_utility::array_spawn_function_targetname("sdv_follow", common_scripts\utility::flag_set, "small_wreck_sdv_spawned");
  maps\_utility::array_spawn_function_targetname("sdv_follow", maps\ship_graveyard_util::sdv_play_sound_on_entity);
  maps\_utility::array_spawn_function_targetname("sdv_follow_2", maps\ship_graveyard_util::sdv_patrol_setup);
  maps\_utility::array_spawn_function_targetname("sdv_follow_2", maps\ship_graveyard_code::sdv_follow_2_passby_audio);
  maps\_utility::array_spawn_function_targetname("stealth_2_sub_1", maps\ship_graveyard_code::sdv_stealth_2_sub_1_passby_audio);
  maps\_utility::array_spawn_function_targetname("stealth_2_sub_2", maps\ship_graveyard_code::sdv_stealth_2_sub_2_passby_audio);
  maps\_utility::array_spawn_function_targetname("a1_patrol_1", maps\ship_graveyard_code::a1_patrol_1_setup);
  maps\_utility::array_spawn_function_targetname("a1_patrol_2", maps\ship_graveyard_code::a1_patrol_1_setup);
  maps\_utility::array_spawn_function_targetname("stealth_1_riser", maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::array_spawn_function_targetname("stealth_1_zodiac", maps\ship_graveyard_code::stealth_1_zodiac_setup);
  maps\_utility::array_spawn_function_targetname("stealth_1_riser", maps\_utility::set_moveplaybackrate, 0.85);
  maps\_utility::array_spawn_function_targetname("stealth_2_guys", maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::array_spawn_function_targetname("stealth_2_guys_b", maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::array_spawn_function_targetname("stealth_2_guys_b", maps\ship_graveyard_util::stop_path_on_damage);
  maps\_utility::array_spawn_function_targetname("stealth_2_backup", maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::array_spawn_function_targetname("sonar_boat_cave", maps\ship_graveyard_util::littoral_ship_lights);
  maps\_utility::array_spawn_function_targetname("sonar_boat_cave", maps\ship_graveyard_code::sonar_ping_light_think);
  maps\_utility::array_spawn_function_targetname("sonar_boat_cave", maps\ship_graveyard_code::sonar_boat_cave_think);
  maps\_utility::array_spawn_function_targetname("sonar_boat_cave", maps\ship_graveyard_code::sonar_boat_cave_quake);
  maps\_utility::array_spawn_function_targetname("sonar_boat_cave", maps\ship_graveyard_code::sonar_boat_think);
  maps\_utility::array_spawn_function_targetname("sonar_boat", maps\ship_graveyard_code::sonar_boat_audio_e3);
  maps\_utility::array_spawn_function_targetname("lcs_abovewater", maps\ship_graveyard_util::lcs_intro_setup);
  maps\_utility::array_spawn_function_targetname("sonar_boat", maps\ship_graveyard_util::lcs_setup);
  maps\_utility::array_spawn_function_targetname("sonar_boat_cave", maps\ship_graveyard_util::lcs_setup);
  maps\_utility::array_spawn_function_targetname("sonar_boat_late", maps\ship_graveyard_util::lcs_setup);
  maps\_utility::array_spawn_function_targetname("intro_shark_model_veh", maps\ship_graveyard_util::shark_vehicle);
  maps\_utility::array_spawn_function_targetname("big_wreck_shark_model_veh", maps\ship_graveyard_util::shark_vehicle);
  maps\_utility::array_spawn_function_targetname("nc_enemies_1", maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::array_spawn_function_targetname("nc_enemies_2", maps\ship_graveyard_util::go_to_nodes_off_sub);
  maps\_utility::array_spawn_function_targetname("new_canyon_jump_1", maps\ship_graveyard_code::canyon_jumper_setup);
  maps\_utility::array_spawn_function_targetname("dc_enemies_1", maps\ship_graveyard_util::teleport_to_target);
  maps\_utility::add_earthquake("small", 0.3, 0.6, 2048);
  maps\_utility::add_earthquake("med", 0.6, 0.7, 2048);
  maps\_utility::add_earthquake("large", 0.7, 1.4, 2048);
  maps\ship_graveyard_util::spawn_baker();
  maps\ship_graveyard_util::underwater_setup();
  createthreatbiasgroup("ignoring_baker");
  createthreatbiasgroup("baker");
  setignoremegroup("baker", "ignoring_baker");
  level.baker setthreatbiasgroup("baker");
  thread maps\ship_graveyard_code::sonar_wreck_think();
  thread maps\ship_graveyard_code::stealth_2_middle_boat_think();
  thread maps\ship_graveyard_code::baker_weld_door();
  thread maps\ship_graveyard_code::cave_flashlight_logic();
  level.sonar_wreck_crash_after = getEntArray("sonar_wreck_crash_after", "targetname");
  common_scripts\utility::array_call(level.sonar_wreck_crash_after, ::hide);
  maps\_colors::add_cover_node("Path 3D");
  maps\_colors::add_cover_node("Cover Stand 3D");
  maps\_colors::add_cover_node("Cover Right 3D");
  maps\_colors::add_cover_node("Cover Left 3D");
  maps\_colors::add_cover_node("Cover Up 3D");
  createthreatbiasgroup("easy_kills");
  setthreatbias("easy_kills", "allies", 500);
  createthreatbiasgroup("not_a_threat");
  setthreatbias("not_a_threat", "axis", 10);
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  level.player notifyonplayercommand("fire weapon", "+attack");
  level.player notifyonplayercommand("fire weapon", "+attack_akimbo_accessible");
  level.player notifyonplayercommand("used ads", "+toggleads_throw");
  level.player notifyonplayercommand("used ads", "+speed_throw");
  level.oldff_block = getdvar("ai_friendlyFireBlockDuration");
  level.player notifyonplayercommand("melee_button_pressed", "+melee");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_breath");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_zoom");
  level.shark_attack_playbackrate = 6;
  level.player.gs.custombreathingtime = 0.85;
  var_6 = getent("grab_torpedo", "targetname");
  var_6 common_scripts\utility::trigger_off();
  setsaveddvar("r_hudOutlineWidth", 2);
  setsaveddvar("r_hudOutlineEnable", 1);
  common_scripts\utility::create_dvar("demo_mode", 0);
  thread objectives();
  level.weld_use_trigger = common_scripts\utility::get_target_ent("weld_use_trigger");
  level.weld_use_trigger common_scripts\utility::trigger_off();
  setsaveddvar("fx_alphathreshold", 5);
  setdvar("shpg_torpedo_tries", 0);

  if(!maps\_utility::is_gen4()) {
    var_7 = getEntArray("trigger_multiple_depthoffield", "classname");
    common_scripts\utility::array_thread(var_7, common_scripts\utility::trigger_off);
  }
}

objectives() {
  objective_add(maps\_utility::obj("1"), "current", &"SHIP_GRAVEYARD_OBJ_1");
  common_scripts\utility::flag_wait("sonar_boat_explode");
  objective_state(maps\_utility::obj("1"), "done");
  common_scripts\utility::flag_wait("drown_unlink_player");
  objective_add(maps\_utility::obj("2"), "current", &"SHIP_GRAVEYARD_OBJ_2");
  common_scripts\utility::flag_wait("the_end");
  objective_state(maps\_utility::obj("2"), "done");
}

set_motion_blur() {
  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", 2);
    setsaveddvar("r_mbCameraRotationInfluence", 2);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
    setsaveddvar("r_mbModelVelocityScalar", 0.7);
    setsaveddvar("r_mbStaticVelocityScalar", 0.2);
  }
}

set_dof_for_player_mask() {
  if(maps\_utility::is_gen4()) {
    level.player setviewmodeldepthoffield(0, 17.0112);
    level.player enableforceviewmodeldof();
  }
}

custom_intro_screen_func() {
  common_scripts\utility::flag_wait("start_swim");
  wait 6;
  maps\_introscreen::introscreen(1);
}

init_level_flags() {
  common_scripts\utility::flag_init("pause_dynamic_dof");
  common_scripts\utility::flag_init("greenlight_next_phase");
  common_scripts\utility::flag_init("start_swim");
  common_scripts\utility::flag_init("baker_at_wreck");
  common_scripts\utility::flag_init("wreck_approach_guys_dead");
  common_scripts\utility::flag_init("clear_to_enter_wreck");
  common_scripts\utility::flag_init("small_wreck_sdv_spawned");
  common_scripts\utility::flag_init("baker_at_small_wreck");
  common_scripts\utility::flag_init("move_to_stealth_1");
  common_scripts\utility::flag_init("clear_to_enter_cave");
  common_scripts\utility::flag_init("cave_sonar");
  common_scripts\utility::flag_init("start_sonar_pings");
  common_scripts\utility::flag_init("sonar_clear_to_go");
  common_scripts\utility::flag_init("welding_done");
  common_scripts\utility::flag_init("start_trench");
  common_scripts\utility::flag_init("start_big_wreck");
  common_scripts\utility::flag_init("depth_charge_muffle");
  common_scripts\utility::flag_init("sonar_boat_explode");
  common_scripts\utility::flag_init("mine_moveup");
  common_scripts\utility::flag_init("first_damage_state");
  common_scripts\utility::flag_init("wreck_tilt");
  common_scripts\utility::flag_init("pause_sonar_pings");
  common_scripts\utility::flag_init("baker_ready_at_sharks");
  common_scripts\utility::flag_init("start_new_trench");
  common_scripts\utility::flag_init("trench_allow_things_to_crash");
  common_scripts\utility::flag_init("shark_a_clear");
  common_scripts\utility::flag_init("shark_b_clear");
  common_scripts\utility::flag_init("shark_a_clear_comeback");
  common_scripts\utility::flag_init("shark_b_clear_comeback");
  common_scripts\utility::flag_init("shark_b_clear_2");
  common_scripts\utility::flag_init("shark_room_player_can_go");
  common_scripts\utility::flag_init("shark_eating_player");
  common_scripts\utility::flag_init("shark_always_eat_front");
  common_scripts\utility::flag_init("player_can_rise");
  common_scripts\utility::flag_init("player_can_fall");
  common_scripts\utility::flag_init("player_can_sprint");
  common_scripts\utility::flag_init("ai_ready_to_weld");
  common_scripts\utility::flag_init("player_ready_to_weld");
  common_scripts\utility::flag_init("player_on_torpedo");
  common_scripts\utility::flag_init("player_holding_torpedo");
  common_scripts\utility::flag_init("go_to_surface");
  common_scripts\utility::flag_init("baker_past_sharks");
  common_scripts\utility::flag_init("baker_prepare_to_leave_flag");
  common_scripts\utility::flag_init("player_warp_hesh");
  common_scripts\utility::flag_init("grabbed_torpedo");
  common_scripts\utility::flag_init("go_into_cave_vo");
  common_scripts\utility::flag_init("to_cave_vo_begin");
  common_scripts\utility::flag_init("stop_npc_weld_sfx_loop");
  common_scripts\utility::flag_init("stop_player_weld_sfx_loop");
  common_scripts\utility::flag_init("fade_sound_player_torch1");
  common_scripts\utility::flag_init("fade_sound_player_torch2");
  common_scripts\utility::flag_init("fade_sound_player_torch3");
  common_scripts\utility::flag_init("fade_sound_player_torch4");
  common_scripts\utility::flag_init("fade_sound_player_torch5");
  common_scripts\utility::flag_init("big_wreck_wait_turnaround");
  common_scripts\utility::flag_init("turn_on_bubbles_after_torpedo");
  common_scripts\utility::flag_init("torpedo_out");
  common_scripts\utility::flag_init("player_chose_auto");
  common_scripts\utility::flag_init("picked_torpedo_mode");
  common_scripts\utility::flag_init("wreck_jumpers_alive");
  common_scripts\utility::flag_init("wreck_patrol_in");
  common_scripts\utility::flag_init("exiting_to_end");
  common_scripts\utility::flag_init("spotted_at_wreck");
  common_scripts\utility::flag_init("end_of_cave_path");
  common_scripts\utility::flag_init("stealth2_approach_guys_damaged");
  level.deadly_sharks = [];
}

start_test_1() {
  maps\ship_graveyard_util::set_start_positions("test_area_1");
  common_scripts\utility::flag_set("start_swim");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("test_sub");
}

start_test_2() {
  maps\ship_graveyard_util::set_start_positions("shoot_mines");
  common_scripts\utility::flag_set("start_swim");
  level.player maps\_utility::vision_set_fog_changes("shpg_lcs_detonation", 1);
  thread lcs_exploder_loop();
}

lcs_exploder_loop() {
  for(;;) {
    common_scripts\utility::exploder("lighthouse_lcs_detonation");
    wait 5;
  }
}

start_test_above_1() {
  maps\ship_graveyard_util::set_start_positions("test_abovewater_start");
}

start_test_above_2() {
  maps\ship_graveyard_util::set_start_positions("test_abovewater_start");
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player maps\_utility::player_speed_percent(10, 0.1);
  level.baker maps\_utility::set_generic_idle_anim("surface_swim_idle");
  level.player_view_pitch_down = getdvar("player_view_pitch_down");
  level.player maps\_underwater::player_scuba_mask();
  setsaveddvar("player_view_pitch_down", 5);
  level.player enableslowaim(0.5, 0.5);
  var_0 = getEntArray("bobbing_object", "targetname");
  common_scripts\utility::array_thread(var_0, maps\ship_graveyard_surface::pitch_and_roll);
  level.ground_ref_ent = common_scripts\utility::spawn_tag_origin();
  level.player playersetgroundreferenceent(level.ground_ref_ent);
  level.ground_ref_ent.script_max_left_angle = 8;
  level.ground_ref_ent.script_duration = 2;
  level.ground_ref_ent thread maps\ship_graveyard_surface::pitch_and_roll();
  var_1 = common_scripts\utility::get_target_ent("start_fishing_boat");
  var_1.script_max_left_angle = 8;
  var_1.script_duration = 4;
  var_1 thread maps\ship_graveyard_surface::pitch_and_roll();
  wait 0.1;
  level.player freezecontrols(0);
}

start_greenlight() {
  maps\_hud_util::start_overlay("black");
  setdvar("greenlight", 1);
  maps\ship_graveyard_util::set_start_positions("start_tutorial");
  common_scripts\utility::flag_set("start_swim");
}

start_tutorial() {
  maps\_hud_util::start_overlay("white");
  setdvar("greenlight", 0);
  maps\ship_graveyard_util::set_start_positions("start_tutorial");
  common_scripts\utility::flag_set("start_swim");
}

start_swim() {
  maps\ship_graveyard_util::set_start_positions("start_swim");
  common_scripts\utility::flag_set("start_swim");
}

start_wreck_approach() {
  maps\ship_graveyard_util::set_start_positions("start_wreck_approach");
  common_scripts\utility::flag_set("start_swim");
  thread maps\ship_graveyard_code::wreck_zodiac_event();
  wait 1;

  while(distance2d(level.player.origin, level.baker.origin) < 300) {
    wait 0.05;
  }

  common_scripts\utility::flag_set("baker_at_wreck");
}

start_small_wreck() {
  maps\ship_graveyard_util::set_start_positions("start_small_wreck");
  common_scripts\utility::flag_set("start_swim");
  common_scripts\utility::flag_set("clear_to_enter_wreck");
}

start_stealth_1() {
  maps\ship_graveyard_util::set_start_positions("stealth_area_1");
  common_scripts\utility::flag_set("start_swim");
  common_scripts\utility::flag_set("move_to_stealth_1");
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_stealth_1_path"));
}

start_stealth_2() {
  maps\ship_graveyard_util::set_start_positions("stealth_area_2");
  common_scripts\utility::flag_set("start_swim");
  thread maps\ship_graveyard_code::baker_move_to_stealth_2();
}

start_cave() {
  maps\ship_graveyard_util::set_start_positions("cave_event");
  common_scripts\utility::flag_set("start_swim");
  common_scripts\utility::flag_set("clear_to_enter_cave");
}

start_sonar() {
  maps\ship_graveyard_util::set_start_positions("sonar_event");
  common_scripts\utility::flag_set("start_swim");
  common_scripts\utility::flag_set("inside_cave");
  common_scripts\utility::flag_set("end_of_cave_path");
  thread maps\ship_graveyard_code::sonar_boat_e3();
}

start_sonar_mines() {
  maps\ship_graveyard_util::set_start_positions("shoot_mines");
  common_scripts\utility::flag_set("start_swim");
  common_scripts\utility::flag_set("sonar_clear_to_go");
  maps\_utility::delaythread(1, common_scripts\utility::flag_clear, "sonar_clear_to_go");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("sonar_boat_late");
  var_0 thread maps\ship_graveyard_util::littoral_ship_lights();
  level.sonar_boat = var_0;
}

start_trench() {
  maps\ship_graveyard_util::set_start_positions("trench");
  common_scripts\utility::flag_set("start_swim");
  thread maps\_hud_util::fade_out(0);
  maps\_utility::delaythread(0.2, common_scripts\utility::flag_set, "start_trench");
}

start_canyon() {
  maps\ship_graveyard_util::set_start_positions("canyon");
  common_scripts\utility::flag_set("start_swim");
  maps\ship_graveyard_stealth::stealth_disable();
}

start_big_wreck() {
  maps\ship_graveyard_util::set_start_positions("big_wreck");
  common_scripts\utility::flag_set("start_swim");
  maps\ship_graveyard_stealth::stealth_disable();
  level.baker.moveplaybackrate = 1.5;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_enter_big_wreck_middle"));
}

start_big_wreck_2() {
  maps\ship_graveyard_util::set_start_positions("big_wreck_2");
  common_scripts\utility::flag_set("start_swim");
  common_scripts\utility::flag_set("inside_big_wreck");
  maps\ship_graveyard_stealth::stealth_disable();
  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  var_0 = common_scripts\utility::get_target_ent("dead_body_spawner");
  var_0 thread maps\ship_graveyard_util::dead_body_spawner();
  thread maps\ship_graveyard_code::big_wreck_fake_shake();
}

start_new_trench() {
  maps\ship_graveyard_util::set_start_positions("new_trench");
  common_scripts\utility::flag_set("start_swim");
  thread maps\_hud_util::fade_out(0);
  maps\_utility::delaythread(0.2, common_scripts\utility::flag_set, "start_new_trench");
}

start_new_canyon() {
  maps\ship_graveyard_util::set_start_positions("new_canyon");
  common_scripts\utility::flag_set("start_swim");
  maps\ship_graveyard_stealth::stealth_disable();
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("new_canyon_start_path"), 0);
}

start_depth_charges() {
  maps\ship_graveyard_util::set_start_positions("depth_charges");
  common_scripts\utility::flag_set("start_swim");
  maps\ship_graveyard_stealth::stealth_disable();
  level.baker maps\_utility::set_force_color("r");
}

start_end_tunnel_swim() {
  maps\ship_graveyard_util::set_start_positions("end_tunnel_swim");
  common_scripts\utility::flag_set("start_swim");
  maps\ship_graveyard_stealth::stealth_disable();
  thread maps\_utility::music_play("mus_shipgrave_collapse_travel");
  level.baker.goalradius = 128;
  level.baker.moveplaybackrate = 1.1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker.pathrandompercent = 0;
  level.baker maps\_utility::disable_exits();
  level.baker thread maps\_anim::anim_generic_run(level.baker, "swimming_idle_to_aiming_move_180");
  wait 0.5;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable();
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_end_level_path_start"));
  level.baker maps\_utility::delaythread(2, maps\_utility::enable_exits);
  thread maps\ship_graveyard_code::end_dialogue();
  thread maps\ship_graveyard_code::depth_charge_death();
}

start_end_surface() {
  maps\ship_graveyard_util::set_start_positions("end_tunnel_above_surface");
  maps\ship_graveyard_stealth::stealth_disable();
  common_scripts\utility::flag_set("go_to_surface");
}

above_water_start_setup() {
  maps\ship_graveyard_surface::main();
}

tutorial_setup() {
  common_scripts\utility::flag_wait("start_swim");
  level.player maps\_utility::vision_set_fog_changes("", 0.1);
  thread common_scripts\utility::play_sound_in_space("scn_player_dive_in_e3", level.player.origin);
  level.player unlink();
  level.baker unlink();
  level.baker maps\_utility::anim_stopanimscripted();
  level.baker notify("kill surface unlink");

  if(isDefined(level.player_rig)) {
    level.player_rig delete();
  }

  setsaveddvar("player_swimSpeed", 75);
  level.player disableweapons();
  wait 0.1;
  thread maps\ship_graveyard_code::wreck_zodiac_event();
  thread give_back_aim_over_time();
  wait 0.1;
  thread maps\ship_graveyard_code::tutorial_player_recover();
  wait 0.1;
  thread maps\ship_graveyard_code::intro_track_player_gunfire();
  thread maps\ship_graveyard_util::sardines_path_sound("sardines_first_path");
  level.player setwatersheeting(1, 2);
  maps\_hud_util::fade_in(1, "white");
  level.baker.goalradius = 128;
  level.baker.goalheight = 128;
  level.baker.moveplaybackrate = 1;
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("tutorial_path"));
  wait 3;
  maps\_utility::smart_radio_dialogue("shipg_hsh_descending");
  wait 1.5;
  level.baker.moveplaybackrate = 0.8;
  maps\_utility::smart_radio_dialogue("shipg_hsh_fiftymeters");
  wait 3;
  maps\ship_graveyard_util::baker_glint_on();
  maps\_utility::smart_radio_dialogue("shipg_bkr_approach");
  thread maps\_utility::music_play("mus_shipgrave_stealth1");
  level.baker.moveplaybackrate = 1;
  level notify("disable_tutorial_slow_aim");
  level.player disableslowaim();
  level.shark_heartbeat_distances = [650, 250, 200, 150];
}

give_back_aim_over_time() {
  level endon("disable_tutorial_slow_aim");
  level.player enableslowaim(0.1, 0.1);
  wait 3;
  var_0 = 0;

  while(var_0 < 1) {
    level.player enableslowaim(var_0, var_0);
    var_0 = var_0 + 0.01;
    wait 0.15;
  }
}

fade_in_blue(var_0, var_1) {
  var_2 = maps\_hud_util::get_optional_overlay(var_1);
  var_2 fadeovertime(var_0);
  var_2.color = (0, 0, 0.4);
  var_2.alpha = 0;
}

intro_setup() {
  common_scripts\utility::flag_wait("start_intro");
  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable();
  thread maps\ship_graveyard_code::intro_dialgue();
  thread maps\ship_graveyard_code::baker_path_to_wreck();
}

wreck_approach_setup() {
  level endon("stop_for_e3");
  common_scripts\utility::flag_wait("start_small_wreck");

  if(maps\_utility::is_gen4()) {
    thread maps\_utility::lerp_saveddvar("r_tessellationFactor", 60, 8);
  }

  common_scripts\utility::flag_clear("allow_killfirms");
  thread maps\ship_graveyard_util::delete_fish_in_volume("fish_start_area");
  level.shark_heartbeat_distances = [400, 250, 200, 150];
  thread maps\ship_graveyard_code::baker_approach();
  thread maps\ship_graveyard_code::baker_wreck_cleanup();
  thread maps\ship_graveyard_code::baker_enter_wreck();
  thread maps\ship_graveyard_code::wreck_hint_up();
}

small_wreck_setup() {
  level endon("stop_for_e3");
  common_scripts\utility::flag_wait("entering_small_wreck");
  thread maps\ship_graveyard_code::wreck_spotted_reaction();
  thread maps\ship_graveyard_code::wreck_cargo_surprise();
  thread maps\ship_graveyard_code::transition_to_stealth_1();
}

stealth_area_1_setup() {
  level endon("stop_for_e3");

  if(maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  common_scripts\utility::flag_wait("start_stealth_area_1");
  level.baker maps\ship_graveyard_util::dyn_swimspeed_disable();
  common_scripts\utility::flag_set("allow_killfirms");
  maps\_utility::delaythread(1, common_scripts\utility::flag_clear, "no_shark_heartbeat");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sdv_follow_2");
  thread maps\ship_graveyard_code::stealth_1_encounter();
  thread maps\ship_graveyard_code::stealth_1_dialogue();
}

stealth_area_2_setup() {
  level endon("stop_for_e3");

  if(maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  common_scripts\utility::flag_wait("start_stealth_area_2");
  maps\_utility::autosave_stealth();
  thread maps\ship_graveyard_code::stealth_2_encounter();
  thread maps\ship_graveyard_code::stealth_2_dialogue();
}

cave_setup() {
  level endon("stop_for_e3");

  if(maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  common_scripts\utility::flag_wait_any("clear_to_enter_cave", "cave_sonar");
  maps\_utility::autosave_stealth();

  if(common_scripts\utility::flag("cave_sonar")) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
    var_2 kill();
    }
  }

  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  thread maps\ship_graveyard_code::cave_dialogue();
  thread maps\ship_graveyard_code::sonar_approach();
  thread maps\ship_graveyard_code::cave_dust();
  thread setup_lcs_audio();
}

setup_lcs_audio() {
  common_scripts\utility::flag_wait("cave_sonar");
  thread maps\ship_graveyard_code::sonar_boat_audio();
  thread maps\ship_graveyard_code::sonar_boat_one_shot_audio();
}

sonar_setup() {
  common_scripts\utility::flag_wait("start_sonar");

  foreach(var_1 in level.deadly_sharks) {
  var_1 delete();
  }

  var_3 = maps\_utility::getvehiclearray();

  foreach(var_5 in var_3) {
    if(var_5.vehicletype != "lcs") {
      var_5 delete();
    }
  }

  level.baker.pathrandompercent = 0;
  setsaveddvar("glass_linear_vel", "100 300");
  thread maps\ship_graveyard_code::first_sonar_ping();
  thread maps\ship_graveyard_code::weaponized_sonar_pings();
  thread maps\ship_graveyard_code::sonar_door_think();
  thread maps\ship_graveyard_util::sardines_path_sound("lighthouse_sardines", "scn_fish_swim_away_lighthouse");
}

sonar_mine_setup() {
  common_scripts\utility::flag_wait("start_sonar_mines");
  setdvar("shpg_torpedo_tries", 0);
  common_scripts\utility::array_thread(getEntArray("dyn_balloon", "targetname"), maps\ship_graveyard_util::dyn_balloon_delete);
  thread maps\ship_graveyard_code::torpedo_the_ship();
  common_scripts\utility::waitframe();

  if(maps\ship_graveyard_code::player_safe_from_sonar()) {
    level.sonar_times_hit = 0;
    maps\_utility::autosave_by_name("sonar_mines");
  }
}

new_trench_setup() {
  common_scripts\utility::flag_wait("start_new_trench");
  thread maps\ship_graveyard_util::delete_fish_in_volume("area_1_fx_vol");
  level.player setclienttriggeraudiozone("ship_graveyard_rescue", 6);
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  thread maps\ship_graveyard_new_trench::main();
  thread maps\ship_graveyard_code::base_alarm();
  thread maps\ship_graveyard_util::sardines_path_sound("sardines_after_helicrash", "scn_fish_swim_away_silent");
}

new_canyon_setup() {
  common_scripts\utility::flag_wait("start_new_canyon");
  setsaveddvar("ai_friendlyFireBlockDuration", level.oldff_block);
  thread maps\ship_graveyard_new_trench::canyon_main();
}

depth_charges_setup() {
  common_scripts\utility::flag_wait("start_depth_charges");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  level.baker.baseaccuracy = 3;
  thread maps\ship_graveyard_code::depth_charges();
  thread maps\ship_graveyard_code::boat_fall_trigs();
  thread maps\ship_graveyard_util::sardines_path_sound("sardines_depthcharges_path", "scn_fish_swim_away_silent");
}

big_wreck_setup() {
  common_scripts\utility::flag_wait("start_big_wreck");

  foreach(var_1 in level.deadly_sharks) {
  var_1 delete();
  }

  level.deadly_sharks = [];
  setsaveddvar("glass_linear_vel", "20 40");
  common_scripts\utility::flag_clear("_stealth_spotted");
  setsaveddvar("player_swimSpeed", 75);
  common_scripts\utility::flag_set("depth_charge_muffle");
  common_scripts\utility::flag_set("shark_always_eat_front");
  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  var_3 = common_scripts\utility::get_target_ent("dead_body_spawner");
  var_3 thread maps\ship_graveyard_util::dead_body_spawner();

  if(maps\_utility::is_gen4()) {
    thread maps\_utility::lerp_saveddvar("r_tessellationFactor", 25, 10);
    thread maps\_art::tess_set_goal(300, 300, 1);
  }

  thread maps\ship_graveyard_code::big_wreck_dialogue();
  thread maps\ship_graveyard_code::big_wreck_fake_shake();
  thread maps\ship_graveyard_code::big_wreck_kill_when_outside();
  thread maps\ship_graveyard_code::big_wreck_baker_stealth();
}

big_wreck_2_setup() {
  level.baker maps\_utility::set_battlechatter(0);
  thread maps\ship_graveyard_code::big_wreck_shark();
  thread maps\ship_graveyard_code::shark_room();
  common_scripts\utility::flag_wait("start_big_wreck_2");
  common_scripts\utility::flag_set("shark_always_eat_front");
  maps\_utility::autosave_stealth();
  setsaveddvar("player_swimVerticalSpeed", 55);
  thread maps\ship_graveyard_code::big_wreck_2_dialogue();
  thread maps\ship_graveyard_code::big_wreck_collapse();
  common_scripts\utility::flag_wait("player_past_sharks");
  setsaveddvar("glass_linear_vel", "100 300");
  common_scripts\utility::flag_clear("depth_charge_muffle");
  wait 1;
  thread maps\ship_graveyard_code::random_depth_charges("depth_charge_constant_2", 4, 8);
}