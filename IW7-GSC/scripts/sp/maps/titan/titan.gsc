/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan.gsc
*******************************************/

main() {
  setdvarifuninitialized("greenlight", 0);
  setdvarifuninitialized("titan_newjackal", 1);
  setdvarifuninitialized("jackal_video_capture", 0);
  setdvarifuninitialized("flyin_pip", 0);
  scripts\sp\utility::_id_116CB("titan");
  _id_FA53();
  scripts\sp\maps\titanjackal\titanjackal_fx::main();
  scripts\sp\maps\titanjackal\titanjackal_precache::main();
  scripts\sp\maps\titan\titan_audio::main();
  scripts\engine\utility::add_func_ref_MAYBE("titan_spawn_heroes", scripts\sp\maps\titan\titan_code::_id_10733);
  scripts\sp\maps\titan\titan_c12fight::main();
  scripts\sp\maps\titan\titan_mons_intro::_id_B6D4();
  _id_D80A();
  init_flags();
  _id_976F();
  thread _id_ABE0();
  _id_F8CE();
  scripts\sp\load::main();
  _id_0F21::main();
  _id_0E4B::_id_8E06();

  if(level._id_10CDA == "flyin") {
    _id_0E4B::_id_1348D(1);
  }

  scripts\engine\utility::delaythread(5, _id_0E4B::_id_8DEA);
  scripts\sp\maps\titan\titan_anim::main();
  scripts\sp\maps\titan\gen\titan_art::main();
  _id_9770();
  scripts\sp\maps\titan\titan_code::_id_6233();
  setdvarifuninitialized("jackal_instant", 0);
  setdvarifuninitialized("street_c12", 1);
  setdvarifuninitialized("salter_spaceship", 1);
  setdvarifuninitialized("bink_capture", 0);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", "4");
  setsaveddvar("sm_sunSampleSizeNear", 0.3);
  level._id_4BCF = "0 : titan";
  thread _id_20E2();
  thread scripts\sp\maps\titan\titan_code::_id_4EF9();
  scripts\sp\utility::_id_9187("c12Targeting", 50, scripts\sp\maps\titan\titan_apc_attack::_id_114FF);
  _id_0E45::_id_5F81();
  _id_0E45::main();
  level thread _id_0A2F::_id_3D61();
}

_id_20E2() {
  wait 1;
  setsaveddvar("r_tessellationOverride", 0);
}

_id_F8CE() {
  level._id_157F = [];
  scripts\sp\maps\titan\titan_code::_id_DEE4("dropship_dismount", "+activate", &"TITAN_DISMOUNT_HINT_PC");
  scripts\sp\maps\titan\titan_code::_id_DEE4("dropship_dismount", "+usereload", &"TITAN_DISMOUNT_HINT");
}

_id_FA53() {
  scripts\sp\utility::_id_1749("flyin", scripts\sp\maps\titan\titan_flyin::_id_D612, "flyin", scripts\sp\maps\titan\titan_flyin::_id_D610, ["titan_launch_art_tr", "titan_flyin_art_tr", "titan_first_steps_tr"], scripts\sp\maps\titan\titan_flyin::_id_D611);
  scripts\sp\utility::_id_1749("first_steps", scripts\sp\maps\titan\titan_arrival::_id_6DDA, "First Steps", scripts\sp\maps\titan\titan_arrival::_id_6DD7, ["titan_base_tr", "titan_launch_art_tr", "titan_flyin_art_tr", "titan_first_steps_tr"], scripts\sp\maps\titan\titan_arrival::_id_6DD9);
  scripts\sp\utility::_id_1749("building1", scripts\sp\maps\titan\titan_arrival::_id_31F5, "Building 1", scripts\sp\maps\titan\titan_arrival::_id_31F3, ["titan_base_tr", "titan_launch_art_tr", "titan_flyin_art_tr", "titan_first_canyon_tr", "titan_first_steps_tr", "titan_building1_tr", "titan_stealth_street1_tr"], scripts\sp\maps\titan\titan_arrival::_id_31F4);
  scripts\sp\utility::_id_1749("building1_exit", scripts\sp\maps\titan\titan_arrival::_id_31EB, "Building 1 Exit", scripts\sp\maps\titan\titan_arrival::_id_31E9, ["titan_base_tr", "titan_first_canyon_tr", "titan_building1_tr", "titan_stealth_street1_tr", "titan_stealth_street2_tr", "titan_stealth_street3_tr"], scripts\sp\maps\titan\titan_arrival::_id_31EA);
  scripts\sp\utility::_id_1749("stealth_street1", scripts\sp\maps\titan\titan_stealth_street::_id_10F08, "Stealth Street 1", scripts\sp\maps\titan\titan_stealth_street::_id_10F06, ["titan_base_tr", "titan_first_canyon_tr", "titan_stealth_street1_tr", "titan_stealth_street2_tr", "titan_stealth_street3_tr", "titan_stealth_street3_road_tr"], scripts\sp\maps\titan\titan_stealth_street::_id_10F07);
  scripts\sp\utility::_id_1749("stealth_street2", scripts\sp\maps\titan\titan_stealth_street::_id_10F10, "Stealth Street 2", scripts\sp\maps\titan\titan_stealth_street::_id_10F0E, ["titan_base_tr", "titan_first_canyon_tr", "titan_stealth_street1_tr", "titan_stealth_street2_tr", "titan_stealth_street3_tr", "titan_stealth_street3_road_tr"], scripts\sp\maps\titan\titan_stealth_street::_id_10F0F);
  scripts\sp\utility::_id_1749("stealth_street3", scripts\sp\maps\titan\titan_stealth_street::_id_10F1F, "Stealth Street 3", scripts\sp\maps\titan\titan_stealth_street::_id_10F1D, ["titan_base_tr", "titan_first_canyon_tr", "titan_stealth_street1_tr", "titan_stealth_street2_tr", "titan_stealth_street3_tr", "titan_stealth_street3_road_tr"], scripts\sp\maps\titan\titan_stealth_street::_id_10F1E);
  scripts\sp\utility::_id_1749("buddy_door", scripts\sp\maps\titan\titan_stealth_street::buddy_down_damage_thread, "Through here...", scripts\sp\maps\titan\titan_stealth_street::buddy_boost_restart, ["titan_base_tr", "titan_stealth_street3_tr", "titan_canyon_a_tr"], scripts\sp\maps\titan\titan_stealth_street::buddy_down);
  scripts\sp\utility::_id_1749("squeeze_through", scripts\sp\maps\titan\titan_stealth_street::_id_10B25, "Squeeze Through", scripts\sp\maps\titan\titan_stealth_street::_id_10B23, ["titan_base_tr", "titan_stealth_street3_tr", "titan_canyon_a_tr", "titan_canyon_b_tr"], scripts\sp\maps\titan\titan_stealth_street::_id_10B24);
  scripts\sp\utility::_id_1749("second_encounter", scripts\sp\maps\titan\titan_stealth_street::_id_F09F, "Second Encounter..", scripts\sp\maps\titan\titan_stealth_street::_id_F099, ["titan_base_tr", "titan_canyon_a_tr", "titan_canyon_b_tr"], scripts\sp\maps\titan\titan_stealth_street::_id_F09E);
  scripts\sp\utility::_id_1749("beacon_moment", scripts\sp\maps\titan\titan_stealth_street::_id_2A0E, "beacon", scripts\sp\maps\titan\titan_stealth_street::_id_2A08, ["titan_base_tr", "titan_canyon_a_tr", "titan_canyon_b_tr"], scripts\sp\maps\titan\titan_stealth_street::_id_2A0C);
  scripts\sp\utility::_id_1749("apc_dropoff", scripts\sp\maps\titan\titan_apc_canyon::_id_206D, "APC Dropoff", scripts\sp\maps\titan\titan_apc_canyon::_id_206A, ["titan_base_tr", "titan_canyon_a_tr", "titan_canyon_b_tr"], scripts\sp\maps\titan\titan_apc_attack::_id_206C);
  scripts\sp\utility::_id_1749("apc_base_attack", scripts\sp\maps\titan\titan_apc_attack::_id_205A, "APC Attack", scripts\sp\maps\titan\titan_apc_attack::_id_2057, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr"], scripts\sp\maps\titan\titan_apc_attack::_id_2059);
  scripts\sp\utility::_id_1749("c12_fight", scripts\sp\maps\titan\titan_c12fight::_id_10D4F, "transition", scripts\sp\maps\titan\titan_c12fight::_id_12655, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("c12_dropoff", scripts\sp\maps\titan\titan_c12fight::_id_10BD0, "dropoff", scripts\sp\maps\titan\titan_c12fight::_id_5D2E, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("c12_charge", scripts\sp\maps\titan\titan_c12fight::_id_10BCC, "charge", scripts\sp\maps\titan\titan_c12fight::_id_3CB7, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("c12_apc", scripts\sp\maps\titan\titan_c12fight::_id_10BCA, "apc", scripts\sp\maps\titan\titan_c12fight::_id_2054, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("c12_rodeo", scripts\sp\maps\titan\titan_c12fight::_id_10CF7, "rodeo", scripts\sp\maps\titan\titan_c12fight::rodeo, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("c12_revive", scripts\sp\maps\titan\titan_c12fight::_id_10BD3, "revive", scripts\sp\maps\titan\titan_c12fight::_id_E494, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("mons_knockdown", scripts\sp\maps\titan\titan_mons_intro::_id_BAAB, "Knockdown", scripts\sp\maps\titan\titan_mons_intro::_id_BAA9, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("mons_pickup", scripts\sp\maps\titan\titan_mons_intro::_id_BAB5, "Pickup", scripts\sp\maps\titan\titan_mons_intro::_id_BAB4, ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"]);
  scripts\sp\utility::_id_1749("mons_door", scripts\sp\maps\titan\titan_mons_intro::_id_BAA4, "Door", scripts\sp\maps\titan\titan_mons_intro::_id_326D, ["titan_base_tr", "titan_refinery_tr", "titan_c12arena_tr", "titan_refinery_interior_tr"]);
  scripts\sp\utility::_id_1749("bunker_scene", scripts\sp\maps\titan\titan_bunker::_id_BA5F, "Bunker Scene", scripts\sp\maps\titan\titan_bunker::_id_BA5D, ["titan_base_tr", "titan_refinery_tr", "titan_launch_art_tr", "titan_refinery_interior_tr"]);
  scripts\sp\utility::_id_1749("bunker_overwatch", scripts\sp\maps\titan\titan_bunker::_id_3274, "Overwatch", scripts\sp\maps\titan\titan_bunker::_id_3273, ["titan_base_tr", "titan_refinery_tr", "titan_refinery_interior_tr", "titan_jackal_tr", "titan_launch_art_tr"], scripts\sp\maps\titan\titan_bunker::_id_3272);
  scripts\sp\utility::_id_1749("air_battle", scripts\sp\maps\titan\titan_bunker::_id_1A59, "Air Battle", scripts\sp\maps\titan\titan_bunker::_id_1A58, ["titan_base_tr", "titan_refinery_tr", "titan_jackal_tr", "titan_c12arena_tr", "titan_launch_art_tr"]);
  scripts\sp\utility::_id_1749("calvary_arrives", scripts\sp\maps\titan\titan_bunker::_id_3792, "Calvary Arrives", scripts\sp\maps\titan\titan_bunker::_id_3790, ["titan_base_tr", "titan_refinery_tr", "titan_jackal_tr", "titan_c12arena_tr", "titan_launch_art_tr"], scripts\sp\maps\titan\titan_bunker::_id_3791);
  scripts\sp\utility::_id_1749("jackal_arena_begin", scripts\sp\maps\titan\titan_jackal::_id_A086, "Jackal Arena Begin", scripts\sp\maps\titan\titan_jackal::_id_A084, ["titan_base_tr", "titan_refinery_tr", "titan_jackal_tr", "titan_c12arena_tr", "titan_launch_art_tr"], scripts\sp\maps\titan\titan_jackal::_id_A085, 1);
  scripts\sp\utility::_id_1749("loading_movie_record", scripts\sp\maps\titan\titan_flyin::_id_AE1C, "", undefined, ["titan_base_tr", "titan_flyin_art_tr"]);
  scripts\sp\utility::_id_F343("flyin");
}

_id_976F() {
  scripts\sp\maps\titan\titan_code::_id_971F();
  scripts\sp\maps\titan\titan_code::_id_969D();
  _id_0F1F::main();
  _id_0F1E::main();
  _id_0F20::main();
  _id_0E52::main();
  _id_0EDA::_id_3739();
  _id_0EDA::_id_10372();
}

_id_9770() {
  _id_0F21::main();
  var_0 = getEntArray("sandstorm_trig", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\titan\titan_code::_id_EB25);
  var_1 = getEntArray("geyser_spawner", "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\titan\titan_code::_id_8259);
  var_2 = getEntArray("methane_pool_splash", "targetname");
  scripts\engine\utility::array_thread(var_2, scripts\sp\maps\titan\titan_code::_id_B69F);
  var_3 = getEntArray("titan_safe_autosave_trig", "targetname");
  scripts\engine\utility::array_thread(var_3, scripts\sp\maps\titan\titan_code::_id_119A0);
  _id_0F21::main();
  _id_0F1E::main();
  _id_0F1F::main();
  scripts\sp\maps\titan\titan_code::_id_13D2D();
  scripts\engine\pipes::main();
  scripts\sp\utility::_id_22CA("omar_takedown_enemy", scripts\sp\maps\titan\titan_stealth_street::_id_C499);
  scripts\sp\utility::_id_22CA("building1_interior", scripts\sp\maps\titan\titan_stealth_street::_id_31EF);
  scripts\sp\utility::_id_F44E(0);
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
}

_id_D80A() {
  var_0 = ["tag_laser", "emp_grenade_wm", "seeker_grenade_wm", "door_pod_interior_single_01", "decor_titan_propaganda_poster_01", "building_pod_wall_panel_21_thick_titan", "veh_mil_air_un_dropship_seat", "tactical_knife_iw7", "ind_debris_metal_beam_01", "viewmodel_base_viewhands_iw7", "ctl_light_stadium_tower_on", "gate_perimeter_01", "body_hero_xo", "head_hero_noHair_xo", "helmet_hero_xo"];
  scripts\sp\maps\titan\titan_code::_id_D802(var_0);
  var_1 = ["magic_spaceship_20mm_bullet", "magic_spaceship_30mm_projectile", "cap_turret_proj_weapon", "cap_mons_projectile", "apc_target_designator"];
  scripts\sp\maps\titan\titan_code::_id_D7FF(var_1);
  var_2 = ["hud_icon_wireless", "hud_icon_missle_dpad", "apache_target_lock", "ac130_hud_target", "c12_hud_dots", "c12_hud_verticalscanlines", "hud_c12_reticle_lock", "hud_c12_reticle_lock_no_ammo", "hud_c12_reticle_no_lock"];
  scripts\sp\maps\titan\titan_code::_id_D801(var_2);
  var_3 = [ &"TITAN_JACKAL_LAUNCH_HINT", &"TIAN_JACKAL_LAND_CONSOLE", &"TITAN_MOTION_TRACKER_HINT", &"TITAN_TURBINE_STRUCTURES_1", &"TITAN_TURBINE_STRUCTURES_2", &"TITAN_TURBINE_BUILDING_CLEAR", &"TITAN_TURBINE_EXPOSE", &"TITAN_TURBINE_DESTORY_FAN", &"TITAN_JACKAL_THREATS"];
  scripts\sp\maps\titan\titan_code::_id_D809(var_3);
  precacheturret("fighter_spotlight");
  precacherumble("steady_rumble");
  precacherumble("damage_light");
  precacherumble("light_2s");
  precacheshellshock("default_nosound");
  precacheitem("spaceship_ai_30mm_projectile_titan_boss");
  precachemodel("viewmodel_base_animated_desert");
  precachemodel("body_hero_protagonist_vm_legs_desert");
  scripts\sp\utility::_id_16EB("c12_arm_dismember_hint", &"TITAN_DESTROY_C12_ARM");
}

init_flags() {
  scripts\engine\utility::flag_init("squeeze_through_briefing_start");
  scripts\engine\utility::flag_init("player_bypassed_vista_scene");
  scripts\engine\utility::flag_init("stealth_buddy_door_clear");
  scripts\engine\utility::flag_init("stealth_squeeze_through_complete");
  scripts\engine\utility::flag_init("player_dropship_dismounted");
  scripts\engine\utility::flag_init("building1_buddy_door_complete");
  scripts\engine\utility::flag_init("eyes_on_second_encounter");
  scripts\engine\utility::flag_init("player_locked_in_dropship");
  scripts\engine\utility::flag_init("show_player_jackal");
  scripts\engine\utility::flag_init("do_wall_scene");
  scripts\engine\utility::flag_init("wall_scene_complete");
  scripts\engine\utility::flag_init("pause_reveal_walk_n_talk");
  scripts\engine\utility::flag_init("player_exited_armory");
  scripts\engine\utility::flag_init("freefall_start");
  scripts\engine\utility::flag_init("freefall_vo_complete");
  scripts\engine\utility::flag_init("dropship_fly_sfx");
  scripts\engine\utility::flag_init("dropship_land_sfx");
  scripts\engine\utility::flag_init("vista_scene_started");
  scripts\engine\utility::flag_init("first_enemies_dead");
  scripts\engine\utility::flag_init("building1_exit");
  scripts\engine\utility::flag_init("streets1_begin");
  scripts\engine\utility::flag_init("storm_building_event");
  scripts\engine\utility::flag_init("dropships_inbound");
  scripts\engine\utility::flag_init("player_unloaded");
  scripts\engine\utility::flag_init("free_fall_done");
  scripts\engine\utility::flag_init("begin_intro_unload");
  scripts\engine\utility::flag_init("bink_done");
  scripts\engine\utility::flag_init("squad_unloaded");
  scripts\engine\utility::flag_init("player_did_not_look_at_sign");
  scripts\engine\utility::flag_init("second_encounter_enemies_dead");
  scripts\engine\utility::flag_init("buddy_door_opened");
  scripts\engine\utility::flag_init("drop_pod_landed");
  scripts\engine\utility::flag_init("base_sign_lookat");
  scripts\engine\utility::flag_init("gate_destroyed");
  scripts\engine\utility::flag_init("base_alerted");
  scripts\engine\utility::flag_init("mons_chase");
  scripts\engine\utility::flag_init("retribution_go");
  scripts\engine\utility::flag_init("tp_spawners_1");
  scripts\engine\utility::flag_init("tp_spawners_2");
  scripts\engine\utility::flag_init("tp_spawners_3");
  scripts\engine\utility::flag_init("stop_speed_check");
  scripts\engine\utility::flag_init("jackals_scatter");
  scripts\engine\utility::flag_init("bunker_door_opened");
  scripts\engine\utility::flag_init("inside_bunker_done");
  scripts\engine\utility::flag_init("apc_attack_done");
  scripts\engine\utility::flag_init("apc_gate_crash_1");
  scripts\engine\utility::flag_init("mons_scene_done");
  scripts\engine\utility::flag_init("gate_crash_2");
  scripts\engine\utility::flag_init("apc_dropship_landed");
  scripts\engine\utility::flag_init("apc_dropship_takeoff");
  scripts\engine\utility::flag_init("apc_main_gate_down");
  scripts\engine\utility::flag_init("crush_main_gate");
  scripts\engine\utility::flag_init("front_jeep_spawned");
  scripts\engine\utility::flag_init("fallback_to_mid");
  scripts\engine\utility::flag_init("fallback_to_mid_2");
  scripts\engine\utility::flag_init("init_dropship_seq");
  scripts\engine\utility::flag_init("init_front_left_flank");
  scripts\engine\utility::flag_init("init_front_left_building");
  scripts\engine\utility::flag_init("init_mid_lower");
  scripts\engine\utility::flag_init("init_mid_jeep");
  scripts\engine\utility::flag_init("init_mid_jeep2");
  scripts\engine\utility::flag_init("init_mid_balcony");
  scripts\engine\utility::flag_init("init_front_right_upper");
  scripts\engine\utility::flag_init("init_front_right_lower");
  scripts\engine\utility::flag_init("init_rear_left_bridge");
  scripts\engine\utility::flag_init("init_rear_right_backup");
  scripts\engine\utility::flag_init("init_rear_right_front");
  scripts\engine\utility::flag_init("init_rear_right_top");
  scripts\engine\utility::flag_init("init_pipe_squads");
  scripts\engine\utility::flag_init("init_arena_squads");
  scripts\engine\utility::flag_init("init_pipes_jeeps");
  scripts\engine\utility::flag_init("init_c12_retreat_1");
  scripts\engine\utility::flag_init("init_c12_retreat_2");
  scripts\engine\utility::flag_init("fallback_to_final");
  scripts\engine\utility::flag_init("fallback_transition");
  scripts\engine\utility::flag_init("crossroads_passed");
  scripts\engine\utility::flag_init("dropship_apc_1");
  scripts\engine\utility::flag_init("dropship_apc_2");
  scripts\engine\utility::flag_init("apc_move_up_1");
  scripts\engine\utility::flag_init("apc_move_up_2");
  scripts\engine\utility::flag_init("apc_move_up_3");
  scripts\engine\utility::flag_init("apc_move_up_4");
  scripts\engine\utility::flag_init("apc_move_up_5");
  scripts\engine\utility::flag_init("dropship_1_cleared");
  scripts\engine\utility::flag_init("dropship_2_cleared");
  scripts\engine\utility::flag_init("acp2_stop");
  scripts\engine\utility::flag_init("apc_crossing");
  scripts\engine\utility::flag_init("mons_player_squeeze");
  scripts\engine\utility::flag_init("mons_event_started");
  scripts\engine\utility::flag_init("refinery_intro_done");
  scripts\engine\utility::flag_init("mons_jackal_blow");
  scripts\engine\utility::flag_init("c12fight_apc_turnpoint");
  scripts\engine\utility::flag_init("jeep_1_arrived");
  scripts\engine\utility::flag_init("jeep_2_arrived");
  scripts\engine\utility::flag_init("midway_through_canyon");
  scripts\engine\utility::flag_init("ow_enemy_ds_takeoff");
  scripts\engine\utility::flag_init("player_in_control");
  scripts\engine\utility::flag_init("ally_ow_ds_takeoff");
  scripts\engine\utility::flag_init("jeep_at_final_location");
  scripts\engine\utility::flag_init("player_opened_ow_door");
  scripts\engine\utility::flag_init("mco_nagging_beacon");
  scripts\engine\utility::flag_init("beacon_scene_over");
  scripts\engine\utility::flag_init("turbine_jackal_dead");
  scripts\engine\utility::flag_init("dropship_landing");
  scripts\engine\utility::flag_init("c12_friendly_activate");
  scripts\engine\utility::flag_init("c12_fight_turn_off_eye_spotlight");
  scripts\engine\utility::flag_init("c12_fight_turn_on_eye_spotlight");
  scripts\engine\utility::flag_init("canyon_begin");
  scripts\engine\utility::flag_init("bunker_elevator_nag");
  scripts\engine\utility::flag_init("send_ow_allies");
  scripts\engine\utility::flag_init("dialogue_multiple_contacts");
  scripts\engine\utility::flag_init("ok_to_ow_jump");
  scripts\engine\utility::flag_init("jeeps_screech");
  scripts\engine\utility::flag_init("jeep_1_screech");
  scripts\engine\utility::flag_init("jeep_2_screech");
  scripts\engine\utility::flag_init("jeep_destroyed");
  scripts\engine\utility::flag_init("player_attacked_street_dropship");
  scripts\engine\utility::flag_init("dropship_passed");
  scripts\engine\utility::flag_init("dropship_door_flyby");
  scripts\engine\utility::flag_init("dropship_door_flyby_complete");
  scripts\engine\utility::flag_init("dropship_spotted_player");
  scripts\engine\utility::flag_init("street_building1_enter");
  scripts\engine\utility::flag_init("apc_blocker_moveup");
  scripts\engine\utility::flag_init("building3_safe_to_cross");
  scripts\engine\utility::flag_init("driveway_clear");
  scripts\engine\utility::flag_init("driveway_jeep_exits");
  scripts\engine\utility::flag_init("stealth_street_jeep_passed");
  scripts\engine\utility::flag_init("stealth_street_3_clear");
  scripts\engine\utility::flag_init("streets3_catwalk_clear");
  scripts\engine\utility::flag_init("streets3_pod_clear");
  scripts\engine\utility::flag_init("streets3_jeep_open_gate");
  scripts\engine\utility::flag_init("driveway_jeep_end_path");
  scripts\engine\utility::flag_init("do_wall_scene_poster");
  scripts\engine\utility::flag_init("jackal_mount_complete");
  scripts\engine\utility::flag_init("grenade_gag_in_position");
  scripts\engine\utility::flag_init("buddy_door_streets3_complete");
  scripts\engine\utility::flag_init("squeeze_through_omar_middle");
  scripts\engine\utility::flag_init("squeeze_through_allow_input");
  scripts\engine\utility::flag_init("squeeze_through_end");
  scripts\engine\utility::flag_init("omar_streets2_roof_gesture");
  scripts\engine\utility::flag_init("omar_streets2_roof_go");
  scripts\engine\utility::flag_init("omar_streets3_roof_gesture");
  scripts\engine\utility::flag_init("atom_takedown");
  scripts\engine\utility::flag_init("streets1_closed");
  scripts\engine\utility::flag_init("building1_exit_clear");
  scripts\engine\utility::flag_init("stealth_street_entered");
  scripts\engine\utility::flag_init("omar_fence_crawl_complete");
  scripts\engine\utility::flag_init("building1_searcher_kill_flag");
  scripts\engine\utility::flag_init("street_c12_is_near");
  scripts\engine\utility::flag_init("omar_knife_is_attached");
  scripts\engine\utility::flag_init("c12_skip_node");
  scripts\engine\utility::flag_init("ethan_start_group_split");
  scripts\engine\utility::flag_init("ethan_takedown_skipped");
  scripts\engine\utility::flag_init("hl_move_mons");
  scripts\engine\utility::flag_init("hl_mons_flak");
  scripts\engine\utility::flag_init("hl_mons_heavy_flak");
  scripts\engine\utility::flag_init("hl_mons_salvo_fire_bink");
  scripts\engine\utility::flag_init("hl_mons_flak_right_cleanup");
  scripts\engine\utility::flag_init("ow_earthquake");
  scripts\engine\utility::flag_init("c12_fight_ally");
  scripts\engine\utility::flag_init("refinery_reinforce");
  scripts\engine\utility::flag_init("jeep_1_arrived");
  scripts\engine\utility::flag_init("jeep_2_arrived");
  scripts\engine\utility::flag_init("jeep_mid_arrived");
  scripts\engine\utility::flag_init("canyon_tp_1");
  scripts\engine\utility::flag_init("canyon_tp_2");
  scripts\engine\utility::flag_init("canyon_tp_3");
  scripts\engine\utility::flag_init("canyon_tp_4");
  scripts\engine\utility::flag_init("canyon_tp_5");
  scripts\engine\utility::flag_init("canyon_tp_6");
  scripts\engine\utility::flag_init("canyon_tp_7");
  scripts\engine\utility::flag_init("canyon_tp_8");
  scripts\engine\utility::flag_init("beacon_omar_in_pos");
  scripts\engine\utility::flag_init("beacon_ethan_in_pos");
  scripts\engine\utility::flag_init("c12_is_dead");
  scripts\engine\utility::flag_init("c12_fork");
  scripts\engine\utility::flag_init("tp_spawners_2");
  scripts\engine\utility::flag_init("kill_apc_anim_thread");
  scripts\engine\utility::flag_init("enable_c12_kill_reaction_vo");
  scripts\engine\utility::flag_init("kill_charge_anim_thread");
  scripts\engine\utility::flag_init("player_rodeo_enabled");
  scripts\engine\utility::flag_init("c12_rocket_alive");
  scripts\engine\utility::flag_init("obj_flag_heavy_weapon");
  scripts\engine\utility::flag_init("dropship1_nav_block_on");
  scripts\engine\utility::flag_init("dropship2_nav_block_on");
  scripts\engine\utility::flag_init("dropship1_nav_block_off");
  scripts\engine\utility::flag_init("dropship2_nav_block_off");
  scripts\engine\utility::flag_init("flying_docking");
  scripts\engine\utility::flag_init("ship_delay_over");
  scripts\engine\utility::flag_init("init_right_side_reinforcements");
  scripts\engine\utility::flag_init("init_left_side_reinforcements");
  scripts\engine\utility::flag_init("init_rear_2_support");
  scripts\engine\utility::flag_init("fallback_to_rear_3");
  scripts\engine\utility::flag_init("player_has_td");
  scripts\engine\utility::flag_init("player_ret_unlink");
  scripts\engine\utility::flag_init("flag_ow_player_through_door");
  scripts\engine\utility::flag_init("ethan_cliffside_chat");
  scripts\engine\utility::flag_init("player_launched_assault");
  var_0 = ["titan_base_tr", "titan_flyin_art_tr", "titan_first_steps_tr", "titan_first_canyon_tr", "titan_building1_tr", "titan_stealth_street1_tr", "titan_stealth_street2_tr", "titan_stealth_street3_tr", "titan_canyon_a_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_refinery_interior_tr", "titan_jackal_tr", "titan_canyon_card_tr", "titan_unloaded_tr", "titan_stealth_street3_road_tr"];

  foreach(var_2 in var_0) {
    scripts\engine\utility::flag_init(var_2 + "_loaded");
    scripts\engine\utility::flag_init(var_2 + "_unloaded");
  }
}

_id_13482() {
  level.player setOrigin((-31186, -9503.5, 81.5));
  var_0 = ["titan_medium_fog", "titan_heavy_fog", "titan_stealth2", "titan_chasm", "titan_jackal"];
  level.player notifyonplayercommand("toggle_vision", "+breath_sprint");

  for(;;) {
    foreach(var_2 in var_0) {
      level.player waittill("toggle_vision");
    }
  }

  wait 0.05;
}

_id_ABE0() {
  _id_96A5();
  _id_F4A8("OBJECTIVE_LZ", "dropships_inbound");
  _id_F4A8("OBJECTIVE_REFINERY", "mi_ethan_pickup_done");
  _id_F4A8("OBJECTIVE_OLYMPUS", "obj_flag_heavy_weapon");
  _id_F4A8("OBJECTIVE_HEAVY", "ok_to_ow_jump");
}

_id_96A5() {
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_LZ"), &"TITAN_OBJECTIVE_LANDING_ZONE");
  scripts\sp\utility::_id_C264("OBJECTIVE_LZ");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_REFINERY"), &"TITAN_OBJECTIVE_REFINERY");
  scripts\sp\utility::_id_C264("OBJECTIVE_REFINERY");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_OLYMPUS"), &"TITAN_OBJECTIVE_OLYMPUS_MONS");
  scripts\sp\utility::_id_C264("OBJECTIVE_OLYMPUS");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_HEAVY"), &"TITAN_OBJECTIVE_HEAVY_WEAPON");
  scripts\sp\utility::_id_C264("OBJECTIVE_HEAVY");
}

_id_F4A8(var_0, var_1) {
  objective_add(scripts\sp\utility::_id_C264(var_0), "current");

  if(isDefined(var_1)) {
    scripts\engine\utility::flag_wait(var_1);
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_0));
  }
}

_id_11983() {
  wait 2;
  level.player _meth_80CB(1);
  level._id_470F = 1;

  for(;;) {
    if(level.player.health < 25) {
      level.player _meth_80D1();

      while(level.player.health < 40) {
        wait 0.3;
      }

      level.player _meth_80A1();
    }

    wait 1;
  }
}