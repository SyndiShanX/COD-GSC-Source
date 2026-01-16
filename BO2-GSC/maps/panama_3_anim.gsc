/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_3_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_scene;
#include maps\_music;
#include common_scripts\utility;
#include maps\voice\voice_panama_3;
#include maps\panama_3_amb;
#include maps\panama_building;
#include maps\createart\panama3_art;

main() {
  maps\voice\voice_panama_3::init_voice();
  building_anims();
  chase_anims();
  docks_anims();
  precache_assets();
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

building_anims() {
  add_scene("dead_nurse_1", undefined, 0, 0, 1, 1);
  add_actor_model_anim("dead_nurse_1", % ch_gen_m_floor_armup_legaskew_onfront_faceright_deathpose);
  add_scene("dead_nurse_2", undefined, 0, 0, 1, 1);
  add_actor_model_anim("dead_nurse_2", % ch_gen_m_floor_armdown_onfront_deathpose);
  add_scene("dead_nurse_3", undefined, 0, 0, 1, 1);
  add_actor_model_anim("dead_nurse_3", % ch_gen_m_wall_armopen_leanright_deathpose);
  add_scene("dead_doctor_1", undefined, 0, 0, 1, 1);
  add_actor_model_anim("dead_doctor_1", % ch_gen_f_floor_onfront_armdown_legstraight_deathpose);
  add_scene("clinic_walk_start_idle", "clinic_entrance", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_startidl);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_startidl);
  add_scene("clinic_walk_door_to_idle", "clinic_entrance");
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_door2_idl1);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_door2_idl1);
  add_scene("clinic_walk_idle_1", "clinic_entrance", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_idl1);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_idl1);
  add_scene("clinic_walk_move_to_idle2", "clinic_entrance");
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_move2_idl2);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_move2_idl2);
  add_scene("clinic_walk_idle_2", "clinic_entrance", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_idl2);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_idl2);
  add_scene("clinic_walk_path_v1", "clinic_entrance");
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_path_v1);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_path_v1);
  add_scene("clinic_walk_end_idle_v1", "clinic_entrance", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_endidl_v1);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_endidl_v1);
  add_scene("crying_woman_idle", "tackle_sequence", 0, 0, 1);
  add_actor_model_anim("crying_woman", % ch_pan_06_03_crying_woman_woman);
  add_scene("digbat_tackle", "tackle_sequence");
  add_actor_anim("tackle_digbat", % ch_pan_06_04_digbat_tackle_digbat, 1, 0);
  add_actor_anim("mason", % ch_pan_06_04_digbat_tackle_mason);
  add_actor_anim("noriega", % ch_pan_06_04_digbat_tackle_noriega);
  add_player_anim("player_body", % p_pan_06_04_digbat_tackle_player);
  add_notetrack_fx_on_tag("tackle_digbat", "shot_hit", "digbat_doubletap", "j_neck");
  add_notetrack_custom_function("tackle_digbat", "shot_hit", maps\panama_3_amb::dingbat_shot_sound);
  add_notetrack_custom_function("tackle_digbat", "break_wall", maps\panama_building::digbat_tackle_wall);
  add_scene("digbat_tackle_body", "player_tackle_sequence");
  add_player_anim("player_body", % int_digbat_tackle_combat_idle, 0, undefined, "tag_origin", 1, 1, 35, 35, 10, 10, 1, 0);
  add_scene("player_digbat_idle", "player_tackle_sequence");
  add_player_anim("player_body", % int_digbat_tackle_combat_idle, 1, undefined, "tag_origin", 1, 1, 35, 35, 10, 10, 1, 0);
  add_scene("digbat_gauntlet_1", "tackle_sequence");
  add_actor_anim("digbat_1", % ch_pan_06_05_digbat_defense_digbat01);
  add_scene("digbat_gauntlet_2", "tackle_sequence");
  add_actor_anim("digbat_2", % ch_pan_06_05_digbat_defense_digbat02);
  add_scene("digbat_gauntlet_3", "tackle_sequence");
  add_actor_anim("digbat_3", % ch_pan_06_05_digbat_defense_digbat03);
  add_scene("digbat_gauntlet_4", "tackle_sequence");
  add_actor_anim("digbat_4", % ch_pan_06_05_digbat_defense_digbat04);
  add_scene("digbat_gauntlet_5", "tackle_sequence");
  add_actor_anim("digbat_5", % ch_pan_06_05_digbat_defense_digbat05);
  add_scene("digbat_gauntlet_6", "tackle_sequence");
  add_actor_anim("digbat_6", % ch_pan_06_05_digbat_defense_digbat06);
  add_scene("digbat_gauntlet_7", "tackle_sequence");
  add_actor_anim("digbat_7", % ch_pan_06_05_digbat_defense_digbat07);
  add_scene("tackle_recover_woman", "tackle_sequence");
  add_actor_model_anim("crying_woman", % ch_pan_06_06_digbat_defend_recover_woman);
  add_scene("tackle_recover_player", "tackle_sequence");
  add_player_anim("player_body", % int_digbat_tackle_getup, 1);
  add_scene("hallway_flashlights_enter", "soldier_flashlights");
  add_prop_anim("hall_flashlight_1", % o_pan_06_07_hallway_flashlight1_enter, "tag_origin_animate", 1);
  add_prop_anim("hall_flashlight_2", % o_pan_06_07_hallway_flashlight2_enter, "tag_origin_animate", 1);
  add_scene("hallway_flashlights_loop", "soldier_flashlights", 0, 0, 1);
  add_prop_anim("hall_flashlight_1", % o_pan_06_07_hallway_flashlight1_searchloop, "tag_origin_animate", 1);
  add_prop_anim("hall_flashlight_2", % o_pan_06_07_hallway_flashlight2_searchloop, "tag_origin_animate", 1);
  add_scene("stairwell_enter_normal", "soldier_flashlights");
  add_actor_anim("mason", % ch_pan_06_08_stairwell_mason_enter_normal);
  add_scene("stairwell_enter_under_fire", "soldier_flashlights");
  add_actor_anim("mason", % ch_pan_06_08_stairwell_mason_under_fire);
  add_scene("stairwell_end_idle", "soldier_flashlights", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_06_08_stairwell_mason_endidl);
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

chase_anims() {
  add_scene("noriega_fight_first", "save_noriega");
  add_actor_anim("noriega", % ch_pan_07_01_fight_noriega);
  add_scene("noriega_fight", "save_noriega");
  add_actor_anim("noriega", % ch_pan_07_01_fight_noriega);
  add_notetrack_flag("noriega", "wall_contact", "clinic_wall_contact");
  add_actor_anim("marine_struggler1", % ch_pan_07_01_fight_soldier1, 0, 0, 1, 1);
  add_actor_anim("marine_struggler2", % ch_pan_07_01_fight_soldier2, 0, 0, 0, 1);
  add_notetrack_flag("marine_struggler1", "wall_contact", "clinic_break_window");
  add_scene("noriega_fight_mason", "save_noriega");
  add_actor_anim("mason", % ch_pan_07_01_fight_mason);
  add_scene("noriega_hanging", "save_noriega", 0, 0, 1);
  add_actor_anim("noriega", % ch_pan_07_02_rescue_noriega_hangidl, 0, 1, 0, 1);
  add_scene("dead_soldier_fell", "save_noriega", 0, 0, 1);
  add_actor_anim("marine_struggler1", % ch_pan_07_02_rescue_soldier1_deadloop, 0, 0, 1, 1);
  add_scene("dead_soldier_fell_2", "save_noriega", 0, 0, 1);
  add_actor_anim("marine_struggler2", % ch_pan_07_01_fight_soldier2_dead_loop, 0, 0, 1, 1);
  add_scene("noriega_saved_noriega", "save_noriega");
  add_actor_anim("noriega", % ch_pan_07_01_help_noriega_noriega, 0, 1, 0, 1);
  add_scene("noriega_saved_player", "save_noriega");
  add_player_anim("player_body", % ch_pan_07_01_help_noriega_player, 1, 0, undefined, 0, 0, 30, 30, 30, 0);
  add_notetrack_custom_function("player_body", "sndChangeMusicState", ::sndchangetoapachemusicstate);
  add_scene("noriega_saved_mason", "save_noriega");
  add_actor_anim("mason", % ch_pan_07_01_help_noriega_mason, 0, 1, 0, 1);
  add_scene("noriega_saved_marine", "save_noriega");
  add_actor_anim("marine_searcher1", % ch_pan_07_01_help_noriega_guy01, 0, 0, 1, 0);
  add_actor_anim("marine_searcher2", % ch_pan_07_01_help_noriega_guy02, 0, 0, 1, 0);
  add_scene("noriega_saved_irstrobe", "save_noriega");
  add_prop_anim("ir_strobe", % o_pan_07_01_help_noriega_strobe, "t6_wpn_ir_strobe_world", 1, 1);
  add_scene("marine_search_party", "save_noriega");
  add_actor_anim("marine_searcher1", % ch_pan_07_01_help_noriega_guy01_wait, 0, 0, 1, 0);
  add_actor_anim("marine_searcher2", % ch_pan_07_01_help_noriega_guy02_wait, 0, 0, 1, 0);
  add_scene("noriega_falls", "save_noriega");
  add_actor_anim("noriega", % ch_pan_07_01_help_noriega_noriega_wait, 0, 1, 0, 1);
  add_scene("noriega_balcony_idle", "save_noriega", 0, 0, 1);
  add_actor_anim("noriega", % ch_pan_07_01_help_noriega_noriega_idle, 0, 1, 0, 1);
  add_scene("mason_waits_for_jump", "save_noriega", 1, 0, 1);
  add_actor_anim("mason", % ch_pan_07_01_help_noriega_mason_wait, 0, 1, 0, 1);
  add_scene("mason_noreiga_wall_hug", "wallhug_align_node");
  add_actor_anim("mason", % ch_pan_07_03_wall_hug_guy_02);
  add_actor_anim("noriega", % ch_pan_07_03_wall_hug_guy_01);
  add_scene("noriega_balcony_jump", "save_noriega", 1);
  add_actor_anim("noriega", % ch_pan_07_04_jump_noriega_jump, 0, 1, 0, 1);
  add_scene("player_jump_landing", "building_jump");
  add_player_anim("player_body", % p_pan_07_04_jump_player, 1);
  add_notetrack_custom_function("player_body", "dof_mason_jump", maps\createart\panama3_art::dof_mason_jump);
  add_notetrack_custom_function("player_body", "dof_get_up", maps\createart\panama3_art::dof_get_up);
  add_scene("mason_balcony_jump", "building_jump");
  add_actor_anim("mason", % ch_pan_07_04_jump_mason_jump);
  add_actor_anim("noriega", % ch_pan_07_04_jump_noriega_run2door);
  add_scene("checkpoint_start_idle_guards", "slums_checkpoint", 0, 0, 1);
  add_actor_anim("checkpoint_guard1", % ch_pan_07_09_slums_checkpoint_guard_loop);
  add_scene("checkpoint_ally_walkout", "slums_checkpoint", 1);
  add_actor_anim("mason", % ch_pan_07_09_slums_checkpoint_mason, 0, 0, 1);
  add_actor_anim("noriega", % ch_pan_07_09_slums_checkpoint_noriega, 1, 1);
  add_notetrack_flag("mason", "start_fade", "checkpoint_fade_now");
  add_actor_anim("checkpoint_guard1", % ch_pan_07_09_slums_checkpoint_guard);
  add_scene("checkpoint_ally_walkout_noreach", "slums_checkpoint", 1);
  add_actor_anim("mason", % ch_pan_07_09_slums_checkpoint_mason, 0, 0, 1);
  add_actor_anim("noriega", % ch_pan_07_09_slums_checkpoint_noriega, 1, 1);
  add_notetrack_flag("mason", "start_fade", "checkpoint_fade_now");
  add_actor_anim("checkpoint_guard1", % ch_pan_07_09_slums_checkpoint_guard);
  add_scene("checkpoint_player_walkout", "slums_checkpoint");
  add_player_anim("player_body", % ch_pan_07_09_slums_checkpoint_player, 1);
  add_notetrack_custom_function("player_body", "dof_chopper", maps\createart\panama3_art::dof_chopper);
  add_notetrack_custom_function("player_body", "dof_noriega", maps\createart\panama3_art::dof_noriega);
  add_scene("checkpoint_advance_guard2", "slums_checkpoint");
  add_actor_anim("checkpoint_guard2", % ch_pan_07_09_checkpoint_guard2_advance, 0, 0, 1, 1);
  add_scene("checkpoint_cleared_guard2", "slums_checkpoint");
  add_actor_anim("checkpoint_guard2", % ch_pan_07_09_checkpoint_guard2_cleared, 0, 0, 0, 1);
  add_scene("checkpoint_end_idle_guard2", "slums_checkpoint", 0, 0, 1);
  add_actor_anim("checkpoint_guard2", % ch_pan_07_09_checkpoint_guard2_endidl, 0, 0, 1, 1);
  add_scene("gate2_guards", "slums_checkpoint", 0, 0, 1);
  add_actor_anim("checkpoint_guard3", % ch_pan_07_09_checkpoint_gateb_guard1, 0, 0, 1, 1);
  add_actor_model_anim("checkpoint_guard4", % ch_pan_07_09_checkpoint_gateb_guard2, undefined, 1);
  add_actor_model_anim("checkpoint_guard5", % ch_pan_07_09_checkpoint_gateb_guard3, undefined, 1);
  add_scene("checkpoint_triage", "slums_checkpoint", 0, 0, 1);
  add_actor_anim("checkpoint_medic1", % ch_pan_07_09_checkpoint_medical_guy1, 1, 0, 1, 1);
  add_actor_model_anim("checkpoint_patient1", % ch_pan_07_09_checkpoint_medical_guy2, undefined, 1);
  add_actor_model_anim("checkpoint_patient2", % ch_pan_07_09_checkpoint_medical_guy3, undefined, 1);
  add_actor_anim("checkpoint_medic2", % ch_pan_07_09_checkpoint_medical_guy4, 1, 0, 1, 1);
  add_scene("checkpoint_patrol1", "slums_checkpoint");
  add_actor_anim("checkpoint_patroller1", % ch_pan_07_09_checkpoint_patrol_soldier1, 0, 0, 1, 1);
  add_scene("checkpoint_patrol2", "slums_checkpoint");
  add_actor_anim("checkpoint_patroller2", % ch_pan_07_09_checkpoint_patrol_soldier2, 0, 0, 1, 1);
  add_scene("checkpoint_patrol3", "slums_checkpoint");
  add_actor_anim("checkpoint_patroller3", % ch_pan_07_09_checkpoint_patrol_soldier3, 0, 0, 0, 1);
  add_scene("checkpoint_patrol3_idle", "slums_checkpoint", 0, 0, 1);
  add_actor_anim("checkpoint_patroller3", % ch_pan_07_09_checkpoint_patrol_soldier3_idl, 0, 0, 1, 1);
  add_scene("checkpoint_sitgroup", "slums_checkpoint", 0, 0, 1);
  add_actor_model_anim("checkpoint_civ_female3", % ch_pan_07_09_checkpoint_sitgroup_girl1, undefined, 1);
  add_actor_model_anim("checkpoint_civ_female4", % ch_pan_07_09_checkpoint_sitgroup_girl2, undefined, 1);
  add_actor_model_anim("checkpoint_civ_male3", % ch_pan_07_09_checkpoint_sitgroup_guy1, undefined, 1);
  add_actor_model_anim("checkpoint_civ_male4", % ch_pan_07_09_checkpoint_sitgroup_guy2, undefined, 1);
  add_actor_model_anim("checkpoint_civ_male5", % ch_pan_07_09_checkpoint_sitgroup_guy3, undefined, 1);
  add_actor_model_anim("checkpoint_medic3", % ch_pan_07_09_checkpoint_sitgroup_soldier1, undefined, 1);
  add_scene("checkpoint_soldiers_resting", "slums_checkpoint", 0, 0, 1);
  add_actor_model_anim("checkpoint_soldier3", % ch_pan_07_09_checkpoint_soldiers_rest_1, undefined, 1);
  add_actor_model_anim("checkpoint_soldier4", % ch_pan_07_09_checkpoint_soldiers_rest_2, undefined, 1);
  add_actor_model_anim("checkpoint_soldier5", % ch_pan_07_09_checkpoint_soldiers_rest_3, undefined, 1);
  add_actor_model_anim("checkpoint_soldier6", % ch_pan_07_09_checkpoint_soldiers_rest_4, undefined, 1);
  add_scene("checkpoint_tieup", "slums_checkpoint");
  add_actor_anim("checkpoint_soldier8", % ch_pan_07_09_checkpoint_tieup_soldier2, 0, 0, 1, 1);
  add_scene("checkpoint_tieup_soldier3", "slums_checkpoint");
  add_actor_anim("checkpoint_soldier9", % ch_pan_07_09_checkpoint_tieup_soldier3, 0, 0, 1, 1);
  add_scene("mason_noreiga_wall_hug_loop", "wallhug_align_node", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_07_03_wall_hug_guy_02_loop);
  add_actor_anim("noriega", % ch_pan_07_03_wall_hug_guy_01_loop);
}

#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");

docks_anims() {
  add_scene("docks_drive", "docks_car_path");
  add_vehicle_anim("blackops_jeep_docks", % v_pan_08_01_gate_crash_jeep, 0);
  add_scene("player_jeep_rail_jeep", "dock_rail");
  add_prop_anim("player_jeep", % v_pan_08_01_jeepride_jeep);
  add_scene("player_jeep_rail", "player_jeep");
  add_player_anim("player_body", % p_pan_08_01_jeepride, 0, 0, "tag_origin");
  add_actor_anim("noriega", % ch_pan_08_01_jeepride_guy01, 0, 0, 0, 1, "tag_origin");
  add_notetrack_level_notify("player_body", "Give_Weapon", "attach_weapon");
  add_notetrack_level_notify("player_body", "Bullet_Time_Start", "viewmodel_on");
  add_notetrack_level_notify("player_body", "Bullet_Time_End", "viewmodel_off");
  add_scene_loop("player_jeep_idle_loop", "player_jeep");
  add_actor_anim("noriega", % ch_pan_08_01_jeepride_guy01_cycle, 0, 0, 0, 1, "tag_origin");
  add_player_anim("player_body", % p_pan_08_01_jeepride_cycle, 0);
  add_scene_loop("player_jeep_jeep_idle", "dock_rail");
  add_prop_anim("player_jeep", % v_pan_08_01_jeepride_jeep_cycle);
  add_scene("player_jeep_idle_end", "player_jeep");
  add_actor_anim("noriega", % ch_pan_08_01_jeepride_guy01_end, 0, 0, 0, 1, "tag_origin");
  add_player_anim("player_body", % p_pan_08_01_jeepride_end, 1);
  add_scene("player_jeep_jeep_idle_end", "dock_rail");
  add_prop_anim("player_jeep", % v_pan_08_01_jeepride_jeep_end);
  add_scene("elevator_bottom_open", "elevator_ride");
  add_prop_anim("docks_elevator", % o_pan_08_05_elevator_defend_elevator_opendoors);
  add_scene("elevator_bottom_open_idle", "elevator_ride", 0, 0, 1);
  add_prop_anim("docks_elevator", % o_pan_08_05_elevator_defend_elevator_openidl);
  add_scene("elevator_bottom_close", "elevator_ride");
  add_prop_anim("docks_elevator", % o_pan_08_05_elevator_defend_elevator_closedoors);
  add_scene("elevator_top_open", "elevator_ride");
  add_prop_anim("docks_elevator", % o_pan_08_06_elevator_ride_elevator_opendoors);
  add_scene("elevator_top_close", "elevator_ride");
  add_prop_anim("docks_elevator", % o_pan_08_06_elevator_ride_elevator_closedoors);
  add_scene("noriega_walk_to_elevator", "elevator_bottom_align", 1);
  add_actor_anim("noriega", % ch_pan_08_06_elevator_approach_noriega);
  add_scene("noriega_enter_elevator", "elevator_bottom_align", 1);
  add_actor_anim("noriega", % ch_pan_08_06_elevator_enter_noriega);
  add_scene_loop("noriega_idle_elevator", "docks_elevator");
  add_actor_anim("noriega", % ch_pan_08_06_elevator_idle_noriega, 0, 1, 0, 1, "tag_origin");
  add_scene("noriega_exit_elevator", "take_the_shot");
  add_actor_anim("noriega", % ch_pan_08_06_elevator_exit_noriega);
  add_scene_loop("noriega_idle_sniper_door", "take_the_shot");
  add_actor_anim("noriega", % ch_pan_08_06_take_the_shot_noriega_wait);
  add_scene_loop("sniper_idle_door", "take_the_shot");
  add_actor_anim("end_roof_sniper", % ch_pan_08_06_take_the_shot_guy01_idle, 0, 0, 0, 1);
  add_scene("noriega_kill_guard_give_sniper", "take_the_shot");
  add_actor_anim("noriega", % ch_pan_08_06_take_the_shot_noriega, undefined, undefined, 0, 1);
  add_player_anim("player_body", % ch_pan_08_06_take_the_shot_player, 1, 0, undefined, 1, 0, 30, 30, 30, 0);
  add_notetrack_custom_function("player_body", "dof_noriega_shoots", maps\createart\panama3_art::dof_noriega_shoots);
  add_notetrack_custom_function("player_body", "dof_take_gun", maps\createart\panama3_art::dof_take_gun);
  add_notetrack_custom_function("player_body", "dof_throw_gun", maps\createart\panama3_art::dof_throw_gun);
  add_actor_anim("end_roof_sniper", % ch_pan_08_06_take_the_shot_guy01, 0, 0, 0, 1);
  add_scene_loop("noriega_idle_woods_snipe", "take_the_shot");
  add_actor_anim("noriega", % ch_pan_08_06_take_the_shot_noriega_loop02, 1, 1, 0, 1);
  add_scene("noriega_idle_woods_snipe_take_the_shot", "take_the_shot");
  add_actor_anim("noriega", % ch_pan_08_06_take_the_shot_noriega_loop04, 1, 1, 0, 1);
  add_scene("noriega_idle_woods_snipe_bring_him_out", "take_the_shot");
  add_actor_anim("noriega", % ch_pan_08_06_take_the_shot_noriega_loop03, 1, 1, 0, 1);
  add_scene("sniper_walk", "bag_on_head");
  add_actor_anim("sniper_guard1_ai", % ch_pan_08_07_sniper_guard1_walk);
  add_actor_anim("sniper_guard2_ai", % ch_pan_08_07_sniper_guard2_walk);
  add_actor_anim("mason_prisoner_ai", % ch_pan_08_07_sniper_mason_walk, 1, 0);
  add_notetrack_flag("mason_prisoner_ai", "start_shoot", "sniper_start_timer");
  add_notetrack_flag("mason_prisoner_ai", "stop_shoot", "sniper_stop_timer");
  add_scene("sniper_start_idle", "bag_on_head", 0, 0, 1);
  add_actor_anim("sniper_guard1_ai", % ch_pan_08_07_sniper_loop_mason);
  add_actor_anim("sniper_guard2_ai", % ch_pan_08_07_sniper_loop_guard2);
  add_actor_anim("mason_prisoner_ai", % ch_pan_08_07_sniper_loop_guard1, 1, 0);
  add_scene("sniper_shot", "bag_on_head");
  add_actor_anim("sniper_guard1_ai", % ch_pan_08_07_sniper_guard1_shot);
  add_actor_anim("sniper_guard2_ai", % ch_pan_08_07_sniper_guard2_shot);
  add_actor_anim("mason_prisoner_ai", % ch_pan_08_07_sniper_mason_shot, 1, 0);
  add_scene("sniper_injured_shot", "bag_on_head");
  add_actor_anim("sniper_guard1_ai", % ch_pan_08_07_sniper_guard1_injured_shot);
  add_actor_anim("sniper_guard2_ai", % ch_pan_08_07_sniper_guard2_injured_shot);
  add_actor_anim("mason_prisoner_ai", % ch_pan_08_07_sniper_mason_injured_shot, 1, 0);
  add_scene("sniper_shot_idle", "bag_on_head", 0, 0, 1);
  add_actor_anim("sniper_guard1_ai", % ch_pan_08_07_sniper_guard1_secondidl);
  add_actor_anim("sniper_guard2_ai", % ch_pan_08_07_sniper_guard2_secondidl);
  add_actor_anim("mason_prisoner_ai", % ch_pan_08_07_sniper_mason_secondidl, 1, 0);
  add_scene("sniper_injured_last_shot", "bag_on_head");
  add_actor_anim("sniper_guard1_ai", % ch_pan_08_07_sniper_guard1_injured_last_shot);
  add_actor_anim("sniper_guard2_ai", % ch_pan_08_07_sniper_guard2_injured_last_shot);
  add_actor_anim("mason_prisoner_ai", % ch_pan_08_07_sniper_mason_injured_last_shot, 1, 0);
  add_scene("betrayed", "walk_align");
  add_actor_anim("noriega", % ch_pan_09_01_betrayed_1_noriega, 1, 0);
  add_actor_anim("menendez", % ch_pan_09_01_betrayed_1_menendez, 1, 0);
  add_prop_anim("right_door", % o_pan_09_01_betrayed_1_rightdoor, "p_pent_double_doors", 0, 1);
  add_prop_anim("left_door", % o_pan_09_01_betrayed_1_leftdoor, "p_pent_double_doors_left", 0, 1);
  add_player_anim("player_body", % p_pan_09_01_betrayed_1_player, 0, 0, undefined, 1, 0, 10, 10, 10, 10);
  add_actor_anim("mason_prisoner_ai", % ch_pan_09_01_betrayed_1_mason, 1, 0);
  add_notetrack_custom_function("player_body", "dof noriega 1", maps\createart\panama3_art::dof_noriega_look_1);
  add_notetrack_custom_function("player_body", "dof fwd 1", maps\createart\panama3_art::dof_fwd_look_1);
  add_notetrack_custom_function("player_body", "dof noriega 2", maps\createart\panama3_art::dof_noriega_look_2);
  add_notetrack_custom_function("player_body", "dof fwd 2", maps\createart\panama3_art::dof_fwd_look_2);
  add_notetrack_custom_function("player_body", "dof noriega 3", maps\createart\panama3_art::dof_noriega_look_3);
  add_notetrack_custom_function("player_body", "dof fwd 3", maps\createart\panama3_art::dof_fwd_look_3);
  add_scene("betrayed_2", "walk_align");
  add_actor_anim("menendez", % ch_pan_09_01_betrayed_2_menendez, 1, 0);
  add_actor_anim("noriega", % ch_pan_09_01_betrayed_2_noriega, 1, 0, 1);
  add_prop_anim("right_door", % o_pan_09_01_betrayed_2_rightdoor, "p_pent_double_doors", 0, 1);
  add_prop_anim("left_door", % o_pan_09_01_betrayed_2_leftdoor, "p_pent_double_doors_left", 0, 1);
  add_player_anim("player_body", % p_pan_09_01_betrayed_2_player, 0, 0, undefined, 1, 0, 10, 10, 10, 10);
  add_actor_anim("mason_prisoner_ai", % ch_pan_09_01_betrayed_2_mason, 1, 0);
  add_notetrack_custom_function("menendez", "fire", ::kneecap_woods);
  add_notetrack_custom_function("player_body", "dof mason", maps\createart\panama3_art::dof_mason_look);
  add_notetrack_custom_function("player_body", "dof noriega 4", maps\createart\panama3_art::dof_noriega_look_4);
  add_notetrack_custom_function("player_body", "dof gun 1", maps\createart\panama3_art::dof_gun_look_1);
  add_notetrack_custom_function("player_body", "dof leg", maps\createart\panama3_art::dof_leg_look);
  add_notetrack_custom_function("player_body", "dof arm", maps\createart\panama3_art::dof_arm_look);
  add_notetrack_custom_function("player_body", "dof menendez 1", maps\createart\panama3_art::dof_menendez_look_1);
  add_notetrack_custom_function("player_body", "dof gun 2", maps\createart\panama3_art::dof_gun_look_2);
  add_notetrack_custom_function("player_body", "dof menendez 2", maps\createart\panama3_art::dof_menendez_look_2);
  add_notetrack_custom_function("player_body", "dof hold shotgun", maps\createart\panama3_art::dof_shotgun_look_2);
  add_notetrack_custom_function("player_body", "dof shoot leg", maps\createart\panama3_art::dof_shoot_leg);
  add_notetrack_custom_function("player_body", "dof gun 3", maps\createart\panama3_art::dof_gun_look_3);
  add_notetrack_custom_function("player_body", "dof shoe", maps\createart\panama3_art::dof_shoe_look);
  add_notetrack_custom_function("player_body", "dof menendez 3", maps\createart\panama3_art::dof_menendez_look_3);
  add_scene("betrayed_shotgun_1", "menendez_ai");
  add_prop_anim("menendez_gun", % o_pan_09_01_betrayed_1_shotgun, "t6_wpn_shotty_spas_prop_world", 0, 0, undefined, "TAG_WEAPON_RIGHT");
  add_scene("betrayed_shotgun_2", "menendez_ai");
  add_prop_anim("menendez_betrayal_shotgun", % o_pan_09_01_betrayed_2_shotgun, "t6_wpn_shotty_spas_prop_world", 1, 0, undefined, "TAG_WEAPON_RIGHT");
  add_scene("betrayed_weapon_1", "bag_on_head");
  add_prop_anim("wood_gun", % o_pan_09_01_betrayed_1_woodsgun, "t6_wpn_pistol_m1911_world", 0, 1);
  add_scene("betrayed_weapon_2", "bag_on_head");
  add_prop_anim("wood_gun", % o_pan_09_01_betrayed_2_woodsgun, "t6_wpn_pistol_m1911_world", 1, 1);
  add_scene("ending_bare_room_1_shotgun", "menendez_ai");
  add_prop_anim("menendez_gun", % o_pan_10_01_end_1_shotgun, "t6_wpn_shotty_spas_prop_world", 1, 0, undefined, "TAG_WEAPON_RIGHT");
  add_scene("ending_bare_room_2_shotgun", "menendez_ai");
  add_prop_anim("menendez_gun", % o_pan_10_01_end_2_shotgun, "t6_wpn_shotty_spas_prop_world", 0, 0, undefined, "TAG_WEAPON_RIGHT");
  add_scene("ending_bare_room_3_shotgun", "menendez_ai");
  add_prop_anim("menendez_gun", % o_pan_10_01_end_3_shotgun, "t6_wpn_shotty_spas_prop_world", 0, 0, undefined, "TAG_WEAPON_RIGHT");
  add_scene("menedez_necklace", "align_bareroom");
  add_prop_anim("necklace", % fxanim_panama_necklace_anim, "fxanim_panama_necklace_mod", 1);
  add_scene("ending_bare_room_1", "align_bareroom");
  add_actor_anim("hudson", % ch_pan_10_01_end_1_hudson, 1, 0);
  add_actor_anim("mason_prisoner_ai", % ch_pan_10_01_end_1_masonsr, 1, 0);
  add_actor_anim("masonjr", % ch_pan_10_01_end_1_masonjr, 1, 0);
  add_actor_anim("menendez", % ch_pan_10_01_end_1_menendez, 1, 0);
  add_prop_anim("chair", % o_pan_10_01_end_1_chair, "p6_wooden_chair_02_anim");
  add_player_anim("player_body", % ch_pan_10_01_end_1_woods, 0, 0, undefined, 1, 0, 15, 15, 15, 5);
  add_notetrack_custom_function("menendez", "fire 1", ::menendez_caps_hudsons_right_knee);
  add_notetrack_custom_function("menendez", "fire 2", ::menendez_caps_hudsons_left_knee);
  add_notetrack_custom_function("menendez", "pendant switch", ::menendez_pendant_switch);
  add_scene("ending_bare_room_2", "align_bareroom");
  add_actor_anim("hudson", % ch_pan_10_01_end_2_hudson, 1, 0);
  add_actor_anim("mason_prisoner_ai", % ch_pan_10_01_end_2_masonsr, 1, 0);
  add_actor_anim("masonjr", % ch_pan_10_01_end_2_masonjr, 1, 0);
  add_actor_anim("menendez", % ch_pan_10_01_end_2_menendez, 1, 0);
  add_prop_anim("chair", % o_pan_10_01_end_2_chair, "p6_wooden_chair_02_anim");
  add_player_anim("player_body", % ch_pan_10_01_end_2_woods, 0, 0, undefined, 1, 0, 15, 15, 15, 5);
  add_notetrack_custom_function("hudson", "throat slit", ::menendez_slits_hudsons_throat);
  add_notetrack_custom_function("hudson", "head_hits_ground_3", ::hudson_blood_pool);
  add_scene("ending_bare_room_3", "align_bareroom");
  add_actor_anim("hudson", % ch_pan_10_01_end_3_hudson, 1, 0);
  add_actor_anim("mason_prisoner_ai", % ch_pan_10_01_end_3_masonsr, 1, 0);
  add_actor_anim("masonjr", % ch_pan_10_01_end_3_masonjr, 1, 0);
  add_actor_anim("menendez", % ch_pan_10_01_end_3_menendez, 1, 0);
  add_prop_anim("chair", % o_pan_10_01_end_3_chair, "p6_wooden_chair_02_anim");
  add_player_anim("player_body", % ch_pan_10_01_end_3_woods, 0, 0, undefined, 1, 0, 15, 15, 15, 5);
  add_notetrack_custom_function("player_body", "fade_out", ::end_level_fade_out);
  add_scene("ending_bare_room_1_mason_alive", "align_bareroom");
  add_actor_anim("hudson", % ch_pan_10_01_end_1_hudson, 1, 0);
  add_actor_anim("mason_prisoner_ai", % ch_pan_10_01_end_1_masonsr_alive, 1, 0);
  add_actor_anim("masonjr", % ch_pan_10_01_end_1_masonjr, 1, 0);
  add_actor_anim("menendez", % ch_pan_10_01_end_1_menendez, 1, 0);
  add_prop_anim("chair", % o_pan_10_01_end_1_chair, "p6_wooden_chair_02_anim");
  add_player_anim("player_body", % ch_pan_10_01_end_1_woods, 0, 0, undefined, 1, 0, 15, 15, 15, 5);
  add_notetrack_custom_function("menendez", "fire 1", ::menendez_caps_hudsons_right_knee);
  add_notetrack_custom_function("menendez", "fire 2", ::menendez_caps_hudsons_left_knee);
  add_notetrack_custom_function("menendez", "pendant switch", ::menendez_pendant_switch);
  add_scene("ending_bare_room_2_mason_alive", "align_bareroom");
  add_actor_anim("hudson", % ch_pan_10_01_end_2_hudson, 1, 0);
  add_actor_anim("mason_prisoner_ai", % ch_pan_10_01_end_2_masonsr_alive, 1, 0);
  add_actor_anim("masonjr", % ch_pan_10_01_end_2_masonjr, 1, 0);
  add_actor_anim("menendez", % ch_pan_10_01_end_2_menendez, 1, 0);
  add_prop_anim("chair", % o_pan_10_01_end_2_chair, "p6_wooden_chair_02_anim");
  add_player_anim("player_body", % ch_pan_10_01_end_2_woods, 0, 0, undefined, 1, 0, 15, 15, 15, 5);
  add_notetrack_custom_function("hudson", "throat slit", ::menendez_slits_hudsons_throat);
  add_notetrack_custom_function("hudson", "head_hits_ground_3", ::hudson_blood_pool);
  add_scene("ending_bare_room_3_mason_alive", "align_bareroom");
  add_actor_anim("hudson", % ch_pan_10_01_end_3_hudson, 1, 0);
  add_actor_anim("mason_prisoner_ai", % ch_pan_10_01_end_3_masonsr_alive, 1, 0);
  add_actor_anim("masonjr", % ch_pan_10_01_end_3_masonjr, 1, 0);
  add_actor_anim("menendez", % ch_pan_10_01_end_3_menendez, 1, 0);
  add_prop_anim("chair", % o_pan_10_01_end_3_chair, "p6_wooden_chair_02_anim");
  add_player_anim("player_body", % ch_pan_10_01_end_3_woods, 0, 0, undefined, 1, 0, 15, 15, 15, 5);
  add_notetrack_custom_function("player_body", "fade_out", ::end_level_fade_out);
}

menendez_pendant_switch(guy) {
  level thread run_scene("menedez_necklace");
  guy hidepart("J_Necklace_Root");
}

end_level_fade_out(guy) {
  level thread screen_fade_out(0.5);
}

menendez_caps_hudsons_right_knee() {
  if(is_mature()) {
    menendez_gun = get_model_or_models_from_scene("ending_bare_room_1_shotgun", "menendez_gun");
    tag_origin = menendez_gun gettagorigin("TAG_FLASH");
    tag_angles = menendez_gun gettagangles("TAG_FLASH");
    menendez_gun playsound("wpn_spas_fire_npc");
    menendez_gun play_fx("shotgun_flash", tag_origin, tag_angles, undefined, 1, "TAG_FLASH");
    hudson = getent("hudson_ai", "targetname");
    tag_origin = hudson gettagorigin("J_Knee_RI");
    tag_angles = hudson gettagangles("J_Knee_RI");
    hudson play_fx("knee_blood_hudson", tag_origin, tag_angles, undefined, 1, "J_Knee_RI");
    hudson detach("c_usa_panama_hudson_lower");
    hudson attach("c_usa_panama_hudson_lower_rknee");
  }
}

menendez_caps_hudsons_left_knee() {
  if(is_mature()) {
    menendez_gun = get_model_or_models_from_scene("ending_bare_room_1_shotgun", "menendez_gun");
    tag_origin = menendez_gun gettagorigin("TAG_FLASH");
    tag_angles = menendez_gun gettagangles("TAG_FLASH");
    menendez_gun playsound("wpn_spas_fire_npc");
    menendez_gun play_fx("shotgun_flash", tag_origin, tag_angles, undefined, 1, "TAG_FLASH");
    hudson = getent("hudson_ai", "targetname");
    tag_origin = hudson gettagorigin("J_Knee_LE");
    tag_angles = hudson gettagangles("J_Knee_LE");
    hudson play_fx("knee_2_blood_hudson", tag_origin, tag_angles, undefined, 1, "J_Knee_LE");
    hudson detach("c_usa_panama_hudson_lower_rknee");
    hudson attach("c_usa_panama_hudson_lower_bknees");
  }
}

menendez_slits_hudsons_throat() {
  if(is_mature()) {
    hudson = getent("hudson_ai", "targetname");
    tag_origin = hudson gettagorigin("J_Neck");
    tag_angles = hudson gettagangles("J_Neck");
    hudson play_fx("neck_blood_hudson", tag_origin, tag_angles, undefined, 1, "J_Neck");
    hudson detach("c_usa_panama_hudson_head");
    hudson attach("c_usa_panama_hudson_head_cut");
  }
}

hudson_blood_pool() {
  if(is_mature()) {
    hudson = getent("hudson_ai", "targetname");
    tag_origin = hudson gettagorigin("J_Neck");
    tag_angles = hudson gettagangles("J_Neck");
    hudson play_fx("blood_pool", tag_origin, tag_angles, undefined, 1, "J_Neck");
  }
}

kneecap_woods() {
  if(is_mature()) {
    body = get_model_or_models_from_scene("betrayed_2", "player_body");

    if(isDefined(level.woods_kneecapped)) {
      body setmodel("c_usa_woods_panama_lower_dmg2_viewbody");
      tag_origin = body gettagorigin("J_Knee_LE");
      tag_angles = body gettagangles("J_Knee_LE");
      body play_fx("blood_woods_knee", tag_origin, tag_angles, undefined, 1, "J_Knee_LE");
    } else {
      body setmodel("c_usa_woods_panama_lower_dmg1_viewbody");
      tag_origin = body gettagorigin("J_Knee_RI");
      tag_angles = body gettagangles("J_Knee_RI");
      body play_fx("blood_woods_knee", tag_origin, tag_angles, undefined, 1, "J_Knee_RI");
    }

    level.woods_kneecapped = 1;
  }
}

sndchangetoapachemusicstate(dude) {
  setmusicstate("PANAMA_APACHE");
}

betrayal_fade_out(guy) {
}