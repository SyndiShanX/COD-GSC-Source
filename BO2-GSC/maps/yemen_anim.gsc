/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_anim.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_scene;
#include maps\_dialog;
#include maps\_anim;
#include maps\yemen_utility;
#include maps\voice\voice_yemen;
#include maps\yemen_market;
#include maps\yemen_speech;
#include maps\createart\yemen_art;
#include maps\yemen_morals;
#include maps\yemen_capture;
#include maps\yemen_morals_rail;

main() {
  level thread prop_and_vehicle_anims();
  level thread morals_rail_anims();
  level_anims();
  precache_assets();
  maps\voice\voice_yemen::init_voice();
}

#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("animated_props");

prop_and_vehicle_anims() {
  add_scene("menendez_intro_doors", "speech_stage");
  add_prop_anim("menendez_chamber_right", % o_yemen_01_02_menendez_intro_door_r, undefined, 0, 1);
  add_prop_anim("menendez_chamber_left", % o_yemen_01_02_menendez_intro_door_l, undefined, 0, 1);
  add_scene("menendez_intro_crates", "speech_stage");
  add_prop_anim("corner_crate", % o_yemen_01_02_cornerguards_carrying_crate01, "anim_jun_ammo_box", 0, 1);
  add_prop_anim("crate1", % o_yemen_01_02_saluters1_2_crate01, "anim_jun_ammo_box", 0, 1);
  add_prop_anim("crate2", % o_yemen_01_02_saluters1_2_crate02, "anim_jun_ammo_box", 0, 1);
  add_prop_anim("crate3", % o_yemen_01_02_saluters1_2_crate03, "anim_jun_ammo_box", 0, 1);
  add_scene("menendez_intro_crates_endloop", "speech_stage");
  add_prop_anim("corner_crate", % o_yemen_01_02_cornerguards_carrying_crate01_loop_end, "anim_jun_ammo_box", 0, 1);
  add_prop_anim("crate1", % o_yemen_01_02_saluters1_2_crate01_loop_end, "anim_jun_ammo_box", 0, 1);
  add_prop_anim("crate2", % o_yemen_01_02_saluters1_2_crate02_loop_end, "anim_jun_ammo_box", 0, 1);
  add_prop_anim("crate3", % o_yemen_01_02_saluters1_2_crate03_loop_end, "anim_jun_ammo_box", 0, 1);
  add_scene("speech_opendoors_doors", "speech_stage");
  add_prop_anim("menendez_exit_left", % o_yemen_01_02_menendez_intro_outside_door_left, undefined, 0, 1);
  add_prop_anim("menendez_exit_right", % o_yemen_01_02_menendez_intro_outside_door_right, undefined, 0, 1);
  add_scene("menendez_exit_doors", "speech_stage");
  add_prop_anim("menendez_exit_door", % o_yemen_01_03_menendez_speech_tower_door, undefined, 0, 1);
  add_scene("menendez_exit_doors_defalco", "speech_stage");
  add_prop_anim("menendez_exit_door", % o_yemen_01_03_menendez_speech_tower_door_defalco_alt, undefined, 0, 1);
  add_scene("market_drone_window", "market_align");
  add_vehicle_anim("market_drone_window_01", % v_yemen_02_02_drones_enter_window_drone_01);
  add_scene("morals_vtol_crashing", "morals_align");
  add_vehicle_anim("morals_vtol_1", % fxanim_yemen_vtol2_vtol_anim);
  add_notetrack_custom_function("market_vtol", undefined, ::turn_off_vehicle_exhaust);
  add_notetrack_custom_function("market_vtol", undefined, ::turn_off_vehicle_tread_fx);
  add_notetrack_custom_function("market_vtol", undefined, maps\yemen_market::market_vtol_crash_callback);
  add_scene("morals_vtol_dead", "morals_align");
  add_vehicle_anim("morals_vtol_1", % fxanim_yemen_vtol2_vtol_dead_anim);
  add_scene("market_vtol_loop", "market_vtol_align", 0, 0, 1);
  add_vehicle_anim("market_vtol", % fxanim_yemen_vtol1_veh_loop_anim, 0, undefined, undefined, 1, "heli_v78_yemen", undefined, undefined, 1);
  add_scene("market_vtol_crash", "market_vtol_align");
  add_vehicle_anim("market_vtol", % fxanim_yemen_vtol1_veh_crash_anim, 0, undefined, undefined, 1, "heli_v78_yemen", undefined, undefined, 1);
  add_notetrack_custom_function("market_vtol", undefined, ::turn_off_vehicle_exhaust);
  add_notetrack_custom_function("market_vtol", undefined, ::turn_off_vehicle_tread_fx);
  add_notetrack_custom_function("market_vtol", undefined, maps\yemen_market::market_vtol_crash_callback);
  add_notetrack_fx_on_tag("market_vtol", undefined, "explosion_midair_heli", "tag_origin");
  add_scene("speech_vtol_crash", "speech_vtol", 0, 0, 0, 1);
  add_vehicle_anim("speech_vtol", % fxanim_yemen_speech_vtol_anim, 1, undefined, undefined, 1, undefined, undefined, undefined, 1);
  add_scene("morals_mene_door", "morals_align");
  add_prop_anim("morals_door", % o_yemen_05_01_shoot_vtol_door, "p6_anim_wooden_door_slats");
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("fakeshooters");
#using_animtree("generic_human");

speech_anims() {
  add_scene("speech_menendez_intro", "speech_stage");
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez, 1, 0, 0, 1);
  add_notetrack_level_notify("menendez_speech", "start_hallway_guards", "start_hallway_guards");
  add_scene("speech_menendez_walk_hallway", "speech_stage");
  add_notetrack_custom_function("menendez_speech", "open_chamber_doors", maps\yemen_speech::menendez_intro_opendoors);
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez_hallway_walk, 1, 0, 0, 1);
  add_scene("speech_menendez_walk_hallway_defalco", "speech_stage");
  add_notetrack_custom_function("menendez_speech", "open_chamber_doors", maps\yemen_speech::menendez_intro_opendoors);
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez_hallway_walk_defalco_alt, 1, 0, 0, 1);
  add_scene("speech_player_intro", "speech_stage");
  add_player_anim("player_body", % p_yemen_01_02_menendez_intro_player, 1, 0, undefined, 1, 1, 10, 10, 10, 10);
  add_notetrack_custom_function("player_body", "give_control", maps\yemen_speech::menendez_intro_unlink_player);
  add_notetrack_custom_function("player_body", "dof_menendez", maps\createart\yemen_art::dof_menendez);
  add_notetrack_custom_function("player_body", "dof_room", maps\createart\yemen_art::dof_room);
  add_scene("speech_menendez_hallway_endidle", "speech_stage", 0, 0, 1);
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez_end_loop, 1, 0, 0, 1);
  add_scene("speech_menendez_hallway_nag_1", "speech_stage");
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez_nag_1, 1, 0, 0, 1);
  add_scene("speech_menendez_hallway_nag_2", "speech_stage");
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez_nag_2, 1, 0, 0, 1);
  add_scene("speech_menendez_hallway_nag_3", "speech_stage");
  add_actor_anim("menendez_speech", % ch_yemen_01_02_menendez_intro_menendez_nag_3, 1, 0, 0, 1);
  add_scene("speech_greeter_intro_1", "speech_stage");
  add_actor_anim("intro_salute_hug_guy", % ch_yemen_01_02_menendez_intro_greet1);
  add_scene("speech_defalco_greeter_intro_1", "speech_stage");
  add_actor_anim("defalco_speech", % ch_yemen_01_02_menendez_intro_greet1_defalco_alt);
  add_scene("speech_defalco_greeter_intro_1_endloop", "speech_stage", 0, 0, 1);
  add_actor_anim("defalco_speech", % ch_yemen_01_02_menendez_intro_greet1_endloop_defalco_alt);
  add_scene("speech_greeter_intro_2", "speech_stage");
  add_actor_anim("intro_greeter_2", % ch_yemen_01_02_menendez_intro_greet2_endloop);
  add_actor_spawner("intro_greeter_2", "intro_salute_guy");
  add_scene("speech_greeter_intro_1_endloop", "speech_stage", 0, 0, 1);
  add_actor_anim("intro_salute_hug_guy", % ch_yemen_01_02_menendez_intro_greet1_endloop, 0, 0, 1);
  add_scene("speech_greeter_intro_2_endloop", "speech_stage", 0, 0, 1);
  add_actor_anim("intro_greeter_2", % ch_yemen_01_02_menendez_intro_greet2_endloop, 0, 0, 1);
  add_scene("speech_intro_salute", "speech_stage");
  add_actor_model_anim("intro_salute_guy_1", % ch_yemen_01_02_menendez_intro_salute1, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_2", % ch_yemen_01_02_menendez_intro_salute2, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_3", % ch_yemen_01_02_menendez_intro_salute3, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_a", "speech_stage");
  add_actor_model_anim("intro_salute_guy_a", % ch_yemen_01_02_menendez_intro_salute_a, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_aa", % ch_yemen_01_02_menendez_intro_salute_aa, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_b", "speech_stage");
  add_actor_model_anim("intro_salute_guy_b", % ch_yemen_01_02_menendez_intro_salute_b, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_bb", % ch_yemen_01_02_menendez_intro_salute_bb, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_c", "speech_stage");
  add_actor_model_anim("intro_salute_guy_c", % ch_yemen_01_02_menendez_intro_salute_c, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_d", "speech_stage");
  add_actor_model_anim("intro_salute_guy_d", % ch_yemen_01_02_menendez_intro_salute_d, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_dd", % ch_yemen_01_02_menendez_intro_salute_dd, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_e", "speech_stage");
  add_actor_model_anim("intro_salute_guy_e", % ch_yemen_01_02_menendez_intro_salute_e, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_ee", % ch_yemen_01_02_menendez_intro_salute_ee, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_f", "speech_stage");
  add_actor_model_anim("intro_salute_guy_f", % ch_yemen_01_02_menendez_intro_salute_f, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_ff", % ch_yemen_01_02_menendez_intro_salute_ff, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_g", "speech_stage");
  add_actor_model_anim("intro_salute_guy_gg", % ch_yemen_01_02_menendez_intro_salute_gg, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_h", "speech_stage");
  add_actor_model_anim("intro_salute_guy_h", % ch_yemen_01_02_menendez_intro_salute_h, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_hh", % ch_yemen_01_02_menendez_intro_salute_hh, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_i", "speech_stage");
  add_actor_model_anim("intro_salute_guy_i", % ch_yemen_01_02_menendez_intro_salute_i, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_ii", % ch_yemen_01_02_menendez_intro_salute_ii, undefined, 0, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_1", % ch_yemen_01_02_menendez_intro_salute1_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_2", % ch_yemen_01_02_menendez_intro_salute2_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_3", % ch_yemen_01_02_menendez_intro_salute3_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_a_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_a", % ch_yemen_01_02_menendez_intro_salute_a_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_aa", % ch_yemen_01_02_menendez_intro_salute_aa_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_b_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_b", % ch_yemen_01_02_menendez_intro_salute_b_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_bb", % ch_yemen_01_02_menendez_intro_salute_bb_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_c_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_c", % ch_yemen_01_02_menendez_intro_salute_c_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_d_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_d", % ch_yemen_01_02_menendez_intro_salute_d_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_dd", % ch_yemen_01_02_menendez_intro_salute_dd_end_loop, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_e_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_e", % ch_yemen_01_02_menendez_intro_salute_e_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_ee", % ch_yemen_01_02_menendez_intro_salute_ee_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_f_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_f", % ch_yemen_01_02_menendez_intro_salute_f_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_ff", % ch_yemen_01_02_menendez_intro_salute_ff_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_g_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_gg", % ch_yemen_01_02_menendez_intro_salute_gg_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_h_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_h", % ch_yemen_01_02_menendez_intro_salute_h_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_hh", % ch_yemen_01_02_menendez_intro_salute_hh_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_intro_salute_i_endloop", "speech_stage", 0, 0, 1);
  add_actor_model_anim("intro_salute_guy_i", % ch_yemen_01_02_menendez_intro_salute_i_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_actor_model_anim("intro_salute_guy_ii", % ch_yemen_01_02_menendez_intro_salute_ii_loop_end, undefined, 1, undefined, undefined, "intro_salute_guy");
  add_scene("speech_walk_with_defalco", "speech_stage");
  add_actor_anim("menendez_speech", % ch_yemen_01_03_menendez_speech_menendez_walk_with_defalco, 1, 1, 0, 1);
  add_notetrack_flag("menendez_speech", "enter_vtol", "speech_start_vtol");
  add_scene("speech_walk_with_defalco_defalco", "speech_stage");
  add_actor_anim("defalco_speech", % ch_yemen_01_03_menendez_speech_defalco_walk, 1, 1, 1, 0);
  add_notetrack_custom_function("defalco_speech", "fire_rocket", ::fire_rock_at_vtol_defalco);
  add_prop_anim("vtol_rpg", % o_yemen_01_03_menendez_speech_defalco_alt_rocket_launcher, "t6_wpn_launch_fhj18_prop_world", 0, 1);
  add_scene_loop("speech_walk_stage_guards", "speech_stage");
  add_actor_model_anim("stage_guard_01", % ch_yemen_01_04_menendez_shoot_drones_guard_01_loop, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_guard_02", % ch_yemen_01_04_menendez_shoot_drones_guard_02_loop, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_guard_03", % ch_yemen_01_04_menendez_shoot_drones_guard_03_loop, undefined, 0, undefined, undefined, "court_terrorists");
  add_scene("vtols_arrive_stage_guards", "speech_stage");
  add_actor_model_anim("stage_guard_01", % ch_yemen_01_04_menendez_shoot_drones_guard_01, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_guard_02", % ch_yemen_01_04_menendez_shoot_drones_guard_02, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_guard_03", % ch_yemen_01_04_menendez_shoot_drones_guard_03, undefined, 0, undefined, undefined, "court_terrorists");
  add_notetrack_custom_function("stage_guard_01", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_guard_02", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_guard_03", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_guard_01", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_guard_02", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_guard_03", "dead", maps\yemen_speech::drone_remove_collision);
  add_scene("stage_backup_guards", "speech_stage");
  add_actor_model_anim("stage_backup_01", % ch_yemen_01_03_menendez_speech_terrorist1, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_backup_02", % ch_yemen_01_03_menendez_speech_terrorist2, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_backup_03", % ch_yemen_01_03_menendez_speech_terrorist3, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_backup_04", % ch_yemen_01_03_menendez_speech_terrorist4, undefined, 0, undefined, undefined, "court_terrorists");
  add_notetrack_custom_function("stage_backup_01", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_02", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_03", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_04", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_01", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_backup_02", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_backup_03", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_backup_04", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_backup_02", "fire_rocket", ::fire_rock_at_vtol_nodefalco);
  add_prop_anim("vtol_rpg", % o_yemen_01_03_menendez_speech_terrorist2_rocket_launcher, "t6_wpn_launch_fhj18_prop_world", 0, 1);
  add_scene("stage_backup_guards_defalco", "speech_stage");
  add_actor_model_anim("stage_backup_02", % ch_yemen_01_03_menendez_speech_terrorist1_defalco_alt, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_backup_03", % ch_yemen_01_03_menendez_speech_terrorist3, undefined, 0, undefined, undefined, "court_terrorists");
  add_actor_model_anim("stage_backup_04", % ch_yemen_01_03_menendez_speech_terrorist4, undefined, 0, undefined, undefined, "court_terrorists");
  add_notetrack_custom_function("stage_backup_02", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_03", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_04", "shoot", maps\yemen_utility::notetrack_drone_shoot);
  add_notetrack_custom_function("stage_backup_02", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_backup_03", "dead", maps\yemen_speech::drone_remove_collision);
  add_notetrack_custom_function("stage_backup_04", "dead", maps\yemen_speech::drone_remove_collision);
  add_scene("speech_walk_no_defalco_player", "speech_stage");
  add_player_anim("player_body", % p_yemen_01_03_menendez_speech_player_walk_no_defalco, 1, 0, undefined, 1, 1, 20, 20, 30, 5);
  add_notetrack_custom_function("player_body", "player_turn", maps\yemen_speech::player_turn);
  add_notetrack_custom_function("player_body", "menendez_grabs_player", maps\yemen_speech::menendez_grabs_player);
  add_notetrack_custom_function("player_body", "player_turns_back", maps\yemen_speech::player_turns_back);
  add_notetrack_custom_function("player_body", "dof_menendez_1", maps\createart\yemen_art::dof_menendez_1);
  add_notetrack_custom_function("player_body", "dof_crowd", maps\createart\yemen_art::dof_goons);
  add_notetrack_custom_function("player_body", "dof_menendez_2", maps\createart\yemen_art::dof_menendez_2);
  add_notetrack_custom_function("player_body", "dof_vtol", maps\createart\yemen_art::dof_vtol);
  add_notetrack_custom_function("player_body", "dof_menendez_3", maps\createart\yemen_art::dof_menendez_3);
  add_scene("speech_walk_no_defalco", "speech_stage");
  add_actor_anim("menendez_speech", % ch_yemen_01_03_menendez_speech_menendez_walk_no_defalco, 0, 1, 1, 0);
  add_notetrack_flag("menendez_speech", "enter_vtol", "speech_start_vtol");
  add_notetrack_custom_function("menendez_speech", "open_tower_door", maps\yemen_speech::menendez_exit_opendoors);
  add_notetrack_custom_function("menendez_speech", "open_outside_doors", maps\yemen_speech::menendez_speech_opendoors);
  add_notetrack_level_notify("menendez_speech", "start_onstage_terrorists", "speech_backup_spawn");
  add_notetrack_level_notify("menendez_speech", "fire", "menendez_fire");
  add_scene("speech_defalco_endidl", "speech_stage", 0, 0, 1);
  add_actor_anim("defalco_speech", % ch_yemen_01_03_menendez_speech_defalco_endidl);
  add_scene("vtols_arrive", "speech_stage");
  add_player_anim("player_body", % p_yemen_01_03_menendez_speech_player_vtol_react, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_actor_anim("menendez_speech", % ch_yemen_01_03_menendez_speech_vtol_react, 0);
  add_scene("vtols_arrive_defalco", "speech_stage");
  add_actor_anim("defalco_speech", % ch_yemen_01_04_defalco_vtol_leave, 0, 0, 1);
  level.scr_animtree["crowd_guy"] = #animtree;
  level.scr_anim["crowd_guy"]["speech_crowd_idle"][0] = % ch_yemen_01_03_menendez_speech_crowd_idle_01;
  level.scr_anim["crowd_guy"]["speech_crowd_cheer"][0] = % ch_yemen_01_03_menendez_speech_crowd_idle_02;
  level.drones.anims["speech_crowd_idle"][0] = % ch_yemen_01_03_menendez_speech_crowd_idle_01;
  level.drones.anims["speech_crowd_cheer"][0] = % ch_yemen_01_03_menendez_speech_crowd_idle_02;
  level.scr_anim["crowd_guy"]["speech_crowd_cheer"][0] = % ch_yemen_01_04_menendez_intro_crowd_fistpump_guy01;
  level.scr_anim["crowd_guy"]["speech_crowd_cheer"][1] = % ch_yemen_01_04_menendez_intro_crowd_fistpump_guy02;
  level.scr_anim["crowd_guy"]["speech_crowd_idle"][0] = % ch_yemen_01_04_menendez_intro_crowd_idle_guy01;
  level.scr_anim["crowd_guy"]["speech_crowd_idle"][1] = % ch_yemen_01_04_menendez_intro_crowd_idle_guy02;
  level.scr_anim["crowd_guy"]["speech_crowd_runaway"][0] = % ch_yemen_01_04_menendez_intro_crowd_runaway_guy01;
  level.scr_anim["crowd_guy"]["speech_crowd_runaway"][1] = % ch_yemen_01_04_menendez_intro_crowd_runaway_guy02;
  level.scr_anim["crowd_guy"]["speech_crowd_door"][0] = % ch_yemen_01_04_menendez_intro_crowd_cheer_guy01;
  level.scr_anim["crowd_guy"]["speech_crowd_door"][1] = % ch_yemen_01_04_menendez_intro_crowd_cheer_guy02;
  add_scene_loop("vtol_pilot", "speech_vtol");
  add_actor_anim("vtol_pilot", % ai_crew_vtol_pilot1_idle, 1, undefined, 1, 1, "tag_driver", "vtol_pilot_spawner");
  add_actor_anim("vtol_pilot2", % ai_crew_vtol_pilot1_idle, 1, undefined, 1, 1, "tag_passenger", "vtol_pilot_spawner");
  precache_assets(1);
}

fire_rock_at_vtol_defalco(guy) {
  vtol_rpg = get_model_or_models_from_scene("speech_walk_with_defalco_defalco", "vtol_rpg");
  m_rocket = spawn_model("projectile_at4", vtol_rpg.origin, vtol_rpg.angles);
  playfxontag(getfx("morals_fhj_rocket_trail"), m_rocket, "tag_fx");
  m_rocket moveto(level.veh_crashed_vtol.origin - vectorscale((0, 0, 1), 128.0), 0.5);
  m_rocket waittill("movedone");
  m_rocket delete();
}

fire_rock_at_vtol_nodefalco(guy) {
  vtol_rpg = get_model_or_models_from_scene("stage_backup_guards", "vtol_rpg");
  m_rocket = spawn_model("projectile_at4", vtol_rpg gettagorigin("tag_flash"), vtol_rpg.angles);
  playfxontag(getfx("morals_fhj_rocket_trail"), m_rocket, "tag_fx");
  m_rocket moveto(level.veh_crashed_vtol.origin - vectorscale((0, 0, 1), 128.0), 0.5);
  m_rocket waittill("movedone");
  m_rocket delete();
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

market_anims() {
  add_scene("shooting_drones_ter1", "speech_stage");
  add_actor_anim("shooting_drones_ter1", % ch_yemen_02_02_shooting_drones_ter1, 0, 0, 0, 1, undefined, "court_terrorists");
  add_scene("shooting_drones_ter2", "speech_stage");
  add_actor_anim("shooting_drones_ter2", % ch_yemen_02_02_shooting_drones_ter2, 0, 0, 0, 1, undefined, "court_terrorists");
  add_scene("shooting_drones_ter3", "speech_stage");
  add_actor_anim("shooting_drones_ter3", % ch_yemen_02_02_shooting_drones_ter3, 0, 0, 0, 1, undefined, "court_terrorists");
  add_scene("shooting_drones_ter4", "speech_stage");
  add_actor_anim("shooting_drones_ter4", % ch_yemen_02_02_shooting_drones_ter4, 0, 0, 0, 1, undefined, "court_terrorists");
  add_scene("shooting_drones_ter5", "speech_stage");
  add_actor_anim("shooting_drones_ter5", % ch_yemen_02_02_shooting_drones_ter5, 0, 0, 0, 1, undefined, "court_terrorists");
  add_scene("shooting_drones_ter6", "speech_stage");
  add_actor_anim("shooting_drones_ter6", % ch_yemen_02_02_shooting_drones_ter6, 0, 0, 0, 1, undefined, "court_terrorists");
  add_scene("market_hold_belly", "market_hold_belly_align");
  add_actor_anim("hold_belly_guy", % ch_yemen_02_02_wounded_terrorists_hold_belly);
  add_scene("car_flip", "car_flip", 1);
  add_actor_anim("car_flip_guy01", % ch_yemen_02_02_car_flip_guy01, 0, 0, 0, 1, undefined, "car_flip_guys");
  add_actor_anim("car_flip_guy02", % ch_yemen_02_02_car_flip_guy02, 0, 0, 0, 1, undefined, "car_flip_guys");
  add_prop_anim("car_flip", % v_yemen_02_02_car_flip_car, undefined, 0, 1, undefined, undefined, 1);
  add_notetrack_custom_function("car_flip", undefined, maps\yemen_market::car_flip_car);
  add_scene("melee_01", "melee_01_node", 1);
  add_actor_anim("melee_01_yemeni", % ai_melee_r_attack);
  add_actor_anim("melee_01_terrorist", % ai_melee_r_defend);
  add_scene("rolling_door", "align_rolling_door");
  add_actor_anim("rolling_door_01", % ch_pan_02_12_rolling_door_guy_1, 0, 0, 0, 0, undefined, "rolling_door_guys");
  add_notetrack_custom_function("rolling_door_01", undefined, maps\yemen_market::rolling_door1_01);
  add_actor_anim("rolling_door_02", % ch_pan_02_12_rolling_door_guy_2, 0, 0, 0, 0, undefined, "rolling_door_guys");
  add_notetrack_custom_function("rolling_door_02", undefined, maps\yemen_market::rolling_door1_02);
  add_scene("rolling_door2", "align_rolling_door2");
  add_actor_anim("rolling_door_2_01", % ch_yemen_02_02_roll_under_door_guy01, 0, 0, 0, 0, undefined, "rolling_door_guys2");
  add_notetrack_custom_function("rolling_door_2_01", undefined, maps\yemen_market::rolling_door_2_01);
  add_actor_anim("rolling_door_2_02", % ch_yemen_02_02_roll_under_door_guy02, 0, 0, 0, 0, undefined, "rolling_door_guys2");
  add_notetrack_custom_function("rolling_door_2_02", undefined, maps\yemen_market::rolling_door_2_02);
  add_scene("window_explosion_01", "align_window_explosion_01");
  add_actor_anim("window_explosion_01", % ch_gen_xplode_death_3, 1, 0, 0, 1);
  add_notetrack_exploder("window_explosion_01", undefined, 890);
  add_scene("bruteforce_perk", "bruteforce_case");
  add_player_anim("player_body", % int_specialty_yemen_bruteforce, 1);
  add_prop_anim("bruteforce_case", % o_specialty_yemen_bruteforce_cabinet);
  add_prop_anim("jaws", % o_specialty_yemen_bruteforce_jaws, "t6_wpn_jaws_of_life_prop", 1);
  add_prop_anim("sword", % o_specialty_yemen_bruteforce_sword, "t6_wpn_pulwar_sword_prop", 1);
  add_scene_loop("mvtol_pilot", "market_vtol");
  add_actor_anim("mvtol_pilot2", % ch_gen_m_wall_legin_armcraddle_hunchright_deathpose, 1, undefined, 1, 1, "tag_passenger", "vtol_pilot_spawner");
  precache_assets(1);
}

terrorist_hunt_anims() {
}

metal_storms_anims() {
  add_scene("courtyard_balcony_deaths", "metalstorms_align");
  add_actor_anim("courtyard_balcony_guy_1", % ch_yemen_04_01_xplode_death_guy1, 0, 1, 0, 0, undefined, "courtyard_balcony_guy");
  add_actor_anim("courtyard_balcony_guy_2", % ch_yemen_04_01_xplode_death_guy2, 0, 1, 0, 0, undefined, "courtyard_balcony_guy");
  add_actor_anim("courtyard_balcony_guy_3", % ch_yemen_04_01_xplode_death_guy3, 0, 1, 0, 0, undefined, "courtyard_balcony_guy");
  add_actor_anim("courtyard_balcony_guy_4", % ch_yemen_04_01_xplode_death_guy4, 0, 1, 0, 0, undefined, "courtyard_balcony_guy");
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

morals_anims() {
  add_scene("morals_shoot_vtol", "morals_align");
  add_actor_anim("menendez_morals", % ch_yemen_05_01_shoot_vtol_menendez, 1, 0, 0, 1);
  add_notetrack_custom_function("menendez_morals", "start_vtol", maps\yemen_morals::moral_vtol_crash_anim);
  add_notetrack_custom_function("menendez_morals", "fire_rocket", maps\yemen_morals::morals_shoot_vtol_fire_rocket);
  add_scene("morals_shoot_vtol_player", "morals_align");
  add_player_anim("player_body", % p_yemen_05_01_shoot_vtol_player, 0, undefined, undefined, 1, 1, 15, 10, 10, 0, 0, 0, 1);
  add_notetrack_custom_function("player_body", "dof_1", maps\createart\yemen_art::dof_shoot_vtol1);
  add_notetrack_custom_function("player_body", "dof_2", maps\createart\yemen_art::dof_shoot_vtol2);
  add_notetrack_custom_function("player_body", "sndCrowdSwell1", ::sndcrowdswell1);
  add_scene("morals_shoot_vtol_gump_transition", "morals_align");
  add_prop_anim("fhj_morals", % o_yemen_05_01_shoot_vtol_fhj18, "t6_wpn_launch_fhj18_world");
  add_scene("morals_capture_approach_player", "morals_align");
  add_player_anim("player_body", % p_yemen_05_03_capture_approach_player, 0, undefined, undefined, 1, 1, 15, 0, 15, 15);
  add_notetrack_custom_function("player_body", "dof_3", maps\createart\yemen_art::dof_shoot_vtol3);
  add_scene("morals_capture_approach", "morals_align");
  add_actor_anim("harper_morals", % ch_yemen_05_03_capture_approach_harper);
  add_actor_anim("menendez_morals", % ch_yemen_05_03_capture_approach_menendez);
  add_actor_anim("terrorist_morals_04", % ch_yemen_05_03_capture_approach_redshirt01);
  add_actor_anim("terrorist_morals_05", % ch_yemen_05_03_capture_approach_redshirt02);
  add_prop_anim("terrorist_1_moral", % ch_yemen_05_03_capture_approach_terr01);
  add_prop_anim("terrorist_2_moral", % ch_yemen_05_03_capture_approach_terr02);
  add_prop_anim("terrorist_3_moral", % ch_yemen_05_03_capture_approach_terr03);
  add_prop_anim("terrorist_4_moral", % ch_yemen_05_03_capture_approach_terr04);
  add_prop_anim("terrorist_5_moral", % ch_yemen_05_03_capture_approach_terr05);
  add_prop_anim("terrorist_6_moral", % ch_yemen_05_03_capture_approach_terr06);
  add_prop_anim("terrorist_7_moral", % ch_yemen_05_03_capture_approach_terr07);
  add_prop_anim("terrorist_8_moral", % ch_yemen_05_03_capture_approach_terr08);
  add_prop_anim("terrorist_9_moral", % ch_yemen_05_03_capture_approach_terr09);
  add_prop_anim("terrorist_10_moral", % ch_yemen_05_03_capture_approach_terr10);
  add_prop_anim("terrorist_12_moral", % ch_yemen_05_03_capture_approach_terr12);
  add_prop_anim("terrorist_13_moral", % ch_yemen_05_03_capture_approach_terr13);
  add_prop_anim("terrorist_14_moral", % ch_yemen_05_03_capture_approach_terr14);
  add_prop_anim("fhj_morals", % o_yemen_05_03_capture_approach_fhj18, "t6_wpn_launch_fhj18_world", 1);
  add_prop_anim("morals_fn57", % o_yemen_05_03_capture_approach_fn57, "t6_wpn_pistol_fiveseven_prop");
  add_scene("morals_capture_approach_defalco", "morals_align");
  add_actor_anim("defalco_speech", % ch_yemen_05_03_capture_approach_defalco);
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");

morals_rail_anims() {
  flag_wait("moral_2_animation_loading");
  add_scene("morals_capture", "morals_align");
  add_player_anim("player_body", % p_yemen_05_03_capture_player, 0, undefined, undefined, 1, 1, 10, 10, 10, 10);
  add_actor_anim("harper_morals", % ch_yemen_05_03_capture_harper);
  add_actor_anim("menendez_morals", % ch_yemen_05_03_capture_menendez);
  add_actor_anim("terrorist_morals_04", % ch_yemen_05_03_capture_redshirt01);
  add_actor_anim("terrorist_morals_05", % ch_yemen_05_03_capture_redshirt02);
  add_prop_anim("terrorist_1_moral", % ch_yemen_05_03_capture_terr01);
  add_prop_anim("terrorist_2_moral", % ch_yemen_05_03_capture_terr02);
  add_prop_anim("terrorist_3_moral", % ch_yemen_05_03_capture_terr03);
  add_prop_anim("terrorist_4_moral", % ch_yemen_05_03_capture_terr04);
  add_prop_anim("terrorist_5_moral", % ch_yemen_05_03_capture_terr05);
  add_prop_anim("terrorist_6_moral", % ch_yemen_05_03_capture_terr06);
  add_prop_anim("terrorist_7_moral", % ch_yemen_05_03_capture_terr07);
  add_prop_anim("terrorist_8_moral", % ch_yemen_05_03_capture_terr08);
  add_prop_anim("terrorist_9_moral", % ch_yemen_05_03_capture_terr09);
  add_prop_anim("terrorist_10_moral", % ch_yemen_05_03_capture_terr10);
  add_prop_anim("terrorist_12_moral", % ch_yemen_05_03_capture_terr12);
  add_prop_anim("terrorist_13_moral", % ch_yemen_05_03_capture_terr13);
  add_prop_anim("terrorist_14_moral", % ch_yemen_05_03_capture_terr14);
  add_prop_anim("morals_fn57", % o_yemen_05_03_capture_fn57);
  add_notetrack_custom_function("harper_morals", "fx_slap", maps\yemen_morals::morals_capture_punch);
  add_notetrack_custom_function("player_body", "start_choice", maps\yemen_morals::morals_capture_start_choice);
  add_notetrack_custom_function("player_body", "dof_4", maps\createart\yemen_art::dof_shoot_vtol4);
  add_notetrack_custom_function("player_body", "dof_5", maps\createart\yemen_art::dof_shoot_vtol5);
  add_notetrack_custom_function("player_body", "dof_5", maps\yemen_morals::morals_streamer_hint_on);
  add_notetrack_custom_function("player_body", "sndCrowdSwell2", ::sndcrowdswell2);
  add_scene("morals_capture_defalco", "morals_align");
  add_actor_anim("defalco_speech", % ch_yemen_05_03_capture_defalco);
  add_scene("morals_shoot_menendez", "morals_align");
  add_player_anim("player_body", % p_yemen_05_04_shoot_menendez_player, 1, undefined, undefined, 1, 1, 10, 10, 10, 10);
  add_actor_anim("harper_morals", % ch_yemen_05_04_shoot_menendez_harper, 1, 0, 1);
  add_actor_anim("menendez_morals", % ch_yemen_05_04_shoot_menendez_menendez, 0, 0, 1);
  add_actor_anim("terrorist_morals_04", % ch_yemen_05_04_shoot_menendez_redshirt01, 0, 0, 1);
  add_actor_anim("terrorist_morals_05", % ch_yemen_05_04_shoot_menendez_redshirt02, 1, 0, 1);
  add_prop_anim("morals_fn57", % o_yemen_05_04_shoot_menendez_fn57, undefined, 1);
  add_prop_anim("terrorist_1_moral", % ch_yemen_05_04_shoot_menendez_terr01, undefined, 1);
  add_prop_anim("terrorist_2_moral", % ch_yemen_05_04_shoot_menendez_terr02, undefined, 1);
  add_prop_anim("terrorist_3_moral", % ch_yemen_05_04_shoot_menendez_terr03, undefined, 1);
  add_prop_anim("terrorist_4_moral", % ch_yemen_05_04_shoot_menendez_terr04, undefined, 1);
  add_prop_anim("terrorist_5_moral", % ch_yemen_05_04_shoot_menendez_terr05, undefined, 1);
  add_prop_anim("terrorist_6_moral", % ch_yemen_05_04_shoot_menendez_terr06, undefined, 1);
  add_prop_anim("terrorist_7_moral", % ch_yemen_05_04_shoot_menendez_terr07, undefined, 1);
  add_prop_anim("terrorist_8_moral", % ch_yemen_05_04_shoot_menendez_terr08, undefined, 1);
  add_prop_anim("terrorist_9_moral", % ch_yemen_05_04_shoot_menendez_terr09, undefined, 1);
  add_prop_anim("terrorist_10_moral", % ch_yemen_05_04_shoot_menendez_terr10, undefined, 1);
  add_prop_anim("terrorist_12_moral", % ch_yemen_05_04_shoot_menendez_terr12, undefined, 1);
  add_prop_anim("terrorist_13_moral", % ch_yemen_05_04_shoot_menendez_terr13, undefined, 1);
  add_prop_anim("terrorist_14_moral", % ch_yemen_05_04_shoot_menendez_terr14, undefined, 1);
  add_notetrack_custom_function("menendez_morals", "farid_shot", maps\yemen_morals::morals_outcome_farid_shot);
  add_notetrack_level_notify("menendez_morals", "fire", "morals_shoot_menendez_fire");
  add_notetrack_custom_function("player_body", "dof_6", maps\createart\yemen_art::dof_shoot_vtol6);
  add_notetrack_custom_function("player_body", "dof_7", maps\createart\yemen_art::dof_shoot_vtol7);
  add_notetrack_custom_function("player_body", "dof_8", maps\createart\yemen_art::dof_shoot_vtol8);
  add_notetrack_custom_function("player_body", "dof_9", maps\createart\yemen_art::dof_shoot_vtol9);
  add_notetrack_custom_function("player_body", "dof_10", maps\createart\yemen_art::dof_shoot_vtol10);
  add_notetrack_custom_function("player_body", "AudioRoom", ::sndchangeaudioroom);
  add_notetrack_custom_function("player_body", "sndDuckAudio", ::sndduckaudiomorals);
  add_scene("moral_execute_pilots_in", "morals_align");
  add_actor_anim("pilot_morals", % ch_yemen_05_04_moral_pilot_killed_pilot_in, 1, 0);
  add_prop_anim("terrorist_1_capture", % ch_yemen_05_04_moral_pilot_killed_enemy_01_in, undefined);
  add_prop_anim("terrorist_2_capture", % ch_yemen_05_04_moral_pilot_killed_enemy_02_in, undefined);
  add_scene("moral_execute_pilots_kill", "morals_align");
  add_actor_anim("pilot_morals", % ch_yemen_05_04_moral_pilot_killed_pilot, 1, 0, 1);
  add_prop_anim("terrorist_1_capture", % ch_yemen_05_04_moral_pilot_killed_enemy_01, undefined, 1);
  add_prop_anim("terrorist_2_capture", % ch_yemen_05_04_moral_pilot_killed_enemy_02, undefined, 1);
  add_scene("morals_shoot_menendez_defalco", "morals_align");
  add_actor_anim("defalco_speech", % ch_yemen_05_04_shoot_menendez_defalco, 0, 0, 1);
  add_scene("morals_shoot_harper", "morals_align");
  add_player_anim("player_body", % p_yemen_05_04_shoot_harper_player, undefined, undefined, undefined, 1, 1, 10, 10, 10, 10);
  add_actor_anim("harper_morals", % ch_yemen_05_04_shoot_harper_harper);
  add_actor_anim("menendez_morals", % ch_yemen_05_04_shoot_harper_menendez, 0, 0, 1);
  add_actor_anim("mason_morals", % ch_yemen_05_04_shoot_harper_mason, 1, 1, 0);
  add_actor_anim("terrorist_morals_04", % ch_yemen_05_04_shoot_harper_redshirt01, 0, 0, 1);
  add_actor_anim("terrorist_morals_05", % ch_yemen_05_04_shoot_harper_redshirt02, 0, 0, 1);
  add_prop_anim("morals_fn57", % o_yemen_05_04_shoot_harper_fn57, undefined, 1);
  add_vehicle_anim("morals_shoot_harper_vtol", % v_yemen_05_04_shoot_harper_vtol, 1, undefined, undefined, undefined, "heli_v78_yemen_player");
  add_prop_anim("terrorist_1_moral", % ch_yemen_05_04_shoot_menendez_terr01, undefined, 1);
  add_prop_anim("terrorist_2_moral", % ch_yemen_05_04_shoot_menendez_terr02, undefined, 1);
  add_prop_anim("terrorist_3_moral", % ch_yemen_05_04_shoot_menendez_terr03, undefined, 1);
  add_prop_anim("terrorist_4_moral", % ch_yemen_05_04_shoot_menendez_terr04, undefined, 1);
  add_prop_anim("terrorist_5_moral", % ch_yemen_05_04_shoot_menendez_terr05, undefined, 1);
  add_prop_anim("terrorist_6_moral", % ch_yemen_05_04_shoot_menendez_terr06, undefined, 1);
  add_prop_anim("terrorist_7_moral", % ch_yemen_05_04_shoot_menendez_terr07, undefined, 1);
  add_prop_anim("terrorist_8_moral", % ch_yemen_05_04_shoot_menendez_terr08, undefined, 1);
  add_prop_anim("terrorist_9_moral", % ch_yemen_05_04_shoot_menendez_terr09, undefined, 1);
  add_prop_anim("terrorist_10_moral", % ch_yemen_05_04_shoot_menendez_terr10, undefined, 1);
  add_prop_anim("terrorist_12_moral", % ch_yemen_05_04_shoot_menendez_terr12, undefined, 1);
  add_prop_anim("terrorist_13_moral", % ch_yemen_05_04_shoot_menendez_terr13, undefined, 1);
  add_prop_anim("terrorist_14_moral", % ch_yemen_05_04_shoot_menendez_terr14, undefined, 1);
  add_notetrack_custom_function("player_body", "gunshots", maps\yemen_morals::morals_shoot_harper_vtol_fire);
  add_notetrack_custom_function("player_body", "explosion", maps\yemen_morals::morals_shoot_harper_explosion);
  add_notetrack_custom_function("player_body", "spawn_vtol", maps\yemen_morals::morals_shoot_harper_slowmo);
  add_notetrack_custom_function("player_body", "ramp_up", maps\yemen_morals::morals_shoot_harper_speedup);
  add_notetrack_custom_function("player_body", "dof_11", maps\createart\yemen_art::dof_shoot_vtol11);
  add_notetrack_custom_function("player_body", "dof_12", maps\createart\yemen_art::dof_shoot_vtol12);
  add_notetrack_custom_function("player_body", "dof_13", maps\createart\yemen_art::dof_shoot_vtol13);
  add_notetrack_custom_function("player_body", "dof_14", maps\createart\yemen_art::dof_shoot_vtol14);
  add_notetrack_custom_function("player_body", "dof_15", maps\createart\yemen_art::dof_shoot_vtol15);
  add_scene("morals_shoot_harper_defalco", "morals_align");
  add_actor_anim("defalco_speech", % ch_yemen_05_04_shoot_harper_defalco, 0, 0, 1);
  add_scene("morals_outcome_farid_lives", "morals_align");
  add_actor_anim("farid_morals", % ch_yemen_05_05_farid_alive_farid, 1, 0, 1);
  add_actor_anim("harper_morals", % ch_yemen_05_05_farid_alive_harper, 1, 0);
  add_actor_anim("mason_morals", % ch_yemen_05_05_farid_alive_mason, 0, 1, 1);
  add_actor_anim("morals_salazar", % ch_yemen_05_05_farid_alive_salazar, 0, 1, 1);
  add_player_anim("player_body", % p_yemen_05_05_farid_alive_player, 1, undefined, undefined, 1, 0, 10, 10, 10, 10, 0, 0);
  add_notetrack_custom_function("mason_morals", "headlook_switch_out", maps\yemen_morals::player_switch_in);
  add_notetrack_custom_function("mason_morals", "headlook_switch_in", maps\yemen_morals::player_switch_out);
  precache_assets(1);
}

#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

moral_rail_player_body_anim() {
  add_scene("mason_intro_harper_lives", "morals_align");
  add_actor_model_anim("morals_rail_harper", % ch_yemen_05_05_mason_intro_hpr_lives_harper, undefined, 1, undefined, undefined, "morals_rail_harper");
  add_actor_anim("morals_rail_salazar", % ch_yemen_05_05_mason_intro_hpr_lives_salazar, 0, 1, 0, 1);
  add_actor_model_anim("morals_rail_soldier", % ch_yemen_05_05_mason_intro_hpr_lives_soldier, undefined, 1, undefined, undefined, "capture_ally");
  add_vehicle_anim("morals_rail_vtol", % v_yemen_05_05_mason_intro_hpr_lives_vtol);
  add_player_anim("player_body_mason", % p_yemen_05_05_mason_intro_hpr_lives_mason, 1, undefined, undefined, 1, 1, 0, 0, 0, 0, 0, 0);
  add_prop_anim("morals_rail_rope", % o_yemen_05_05_mason_intro_hpr_lives_rope, "fxanim_war_sing_rappel_rope_01_mod", 1);
  add_notetrack_custom_function("morals_rail_soldier", "start", maps\yemen_capture::give_me_a_gun);
  add_notetrack_custom_function("player_body_mason", "headlook_on", maps\yemen_morals_rail::player_landed_rappel);
  add_notetrack_custom_function("player_body_mason", "rumble_on", maps\yemen_morals_rail::player_rappel_rumble_on);
  add_notetrack_custom_function("player_body_mason", "rumble_off", maps\yemen_morals_rail::player_rappel_rumble_off);
  add_scene_loop("harper_medic_loop", "morals_align");
  add_actor_model_anim("morals_rail_harper", % ch_yemen_05_05_mason_intro_hpr_lives_harper_loop, undefined, 0, undefined, undefined, "morals_rail_harper");
  add_actor_model_anim("morals_rail_soldier", % ch_yemen_05_05_mason_intro_hpr_lives_medic_loop, undefined, 0, undefined, undefined, "capture_ally");
  precache_assets(1);
}

hijacked_anims() {
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

capture_anims() {
  flag_wait("hijacked_bridge_fell");
  add_scene("surrender_menendez", "menendez_surrender");
  add_actor_model_anim("capture_menendez", % ch_yemen_08_02_surrender_men, undefined, 0, undefined, undefined, "capture_menendez");
  add_scene("surrender_menendez_player_setup", "menendez_surrender");
  add_player_anim("player_body", % p_yemen_08_02_surrender_plyr, 0, undefined, undefined, 1, 1, 0, 0, 0, 0, 0, 0);
  add_scene("surrender_menendez_player", "menendez_surrender");
  add_player_anim("player_body", % p_yemen_08_02_surrender_plyr, 0, undefined, undefined, 1, 1, 25, 25, 25, 15, 0, 0);
  add_actor_anim("end_seal_guard_2", % ch_yemen_08_02_surrender_seal02, 0, 0, 1, 1);
  add_actor_anim("end_salazar", % ch_yemen_08_02_surrender_seal01, 0, 0, 1, 1);
  add_notetrack_custom_function("player_body", "weapon_down", ::lower_weapon);
  add_notetrack_custom_function("player_body", "fade_out", maps\yemen_capture::capture_start_fadeout);
  add_notetrack_custom_function("player_body", "sndStartSnapshot", ::sndstartsnapshot);
  add_notetrack_custom_function("player_body", "sndChangeVerb", ::sndchangeverb);
  add_scene("surrender_menendez_vtol", "menendez_surrender");
  add_prop_anim("surrender_vtol", % v_yemen_08_02_surrender_vtol, "veh_t6_air_v78_vtol_no_interior");
  add_scene("surrender_menendez_idle", "menendez_surrender", 0, 0, 1);
  add_actor_model_anim("capture_menendez", % ch_yemen_08_02_surrender_men_idle, undefined, 0, undefined, undefined, "capture_menendez");
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("animated_props");

level_anims() {
  add_scene("intruder", "intruder_gate");
  add_player_anim("player_body", % int_specialty_yemen_intruder, 1);
  add_prop_anim("intruder_cutter", % o_specialty_yemen_intruder_cutter, "t6_wpn_laser_cutter_prop", 1);
  add_prop_anim("intruder_gate", % o_specialty_yemen_intruder_rightgate);
  add_notetrack_custom_function("player_body", "zap_start", ::intruder_zap_start);
  add_notetrack_custom_function("player_body", "zap_end", ::intruder_zap_end);
}

intruder_zap_start(player_body) {
  m_cutter = get_model_or_models_from_scene("intruder", "intruder_cutter");
  m_cutter play_fx("cutter_on", undefined, undefined, "stop_fx", 1, "tag_fx");
  m_cutter play_fx("cutter_spark", undefined, undefined, "stop_fx", 1, "tag_fx");
  level.player playrumblelooponentity("crash_heli_rumble");
}

intruder_zap_end(m_cutter) {
  m_cutter = get_model_or_models_from_scene("intruder", "intruder_cutter");
  m_cutter notify("stop_fx");
  level.player stoprumble("crash_heli_rumble");
}

lower_weapon(player) {
  level.player disableweapons();
  level.player hideviewmodel();
}

sndduckaudiomorals(player) {
  rpc("clientscripts/yemen_amb", "farid_shot_duck");
}

sndchangeaudioroom(player) {
  rpc("clientscripts/yemen_amb", "farid_shot_room_change");
}

sndcrowdswell1(player) {
  playsoundatposition("evt_morals_crowd_1", (-5557, -4576, 233));
}

sndcrowdswell2(player) {
  playsoundatposition("evt_morals_crowd_2", (-5557, -4576, 233));
}

sndstartsnapshot(guy) {
  rpc("clientscripts/yemen_amb", "sndStartEndSnapshot");
}

sndchangeverb(guy) {
  level clientnotify("sndVerb");
}