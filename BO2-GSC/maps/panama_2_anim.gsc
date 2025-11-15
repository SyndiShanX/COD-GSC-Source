/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_2_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_scene;
#include maps\voice\voice_panama_2;
#include maps\panama_slums;

main() {
  maps\voice\voice_panama_2::init_voice();
  slums_anims();
  vehicle_prop_anims();
  precache_assets();
}

#using_animtree("animated_props");

vehicle_prop_anims() {
  add_scene("truck_hood_up");
  add_actor_anim("anim_truck_hood", % veh_anim_pickup_hood_open);
  add_scene("car_driver_door_open");
  add_actor_anim("anim_car_door", % veh_anim_80s_hatchback_door_open);
}

show_fake_clip() {
  mason = get_ais_from_scene("slums_noriega_pistol", "mason");
  mason hidepart("tag_clip");
  clip = get_model_or_models_from_scene("slums_noriega_pistol", "noriega_clip");
  clip show();
  wait 30;
  clip delete();
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

slums_anims() {
  add_scene("slums_ambulance", "slum_ambulence_scene_2");
  add_prop_anim("ambulence", % v_pan_04_02_amblulance_van);
  add_scene("slums_intro_player", "slum_ambulence_scene");
  add_player_anim("player_body", % p_pan_04_01_intro_player_approach, 1, 0, undefined, 1, 0.5, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "show_arms", maps\panama_slums::intro_show_gun);
  add_scene("slums_intro", "slum_ambulence_scene");
  add_actor_anim("mason", % ch_pan_04_01_intro_mason_approach);
  add_actor_anim("noriega", % ch_pan_04_01_intro_noriaga_approach);
  add_scene("slums_intro_loop", "slum_ambulence_scene", 0, 0, 1);
  add_actor_anim("mason", % ch_pan_04_01_intro_mason_approach_cycle);
  add_actor_anim("noriega", % ch_pan_04_01_intro_noriaga_approach_cycle);
  add_scene_loop("headsack_loop", "slum_ambulence_scene");
  add_prop_anim("fake_sack", % o_pan_05_01_noriega_pistol_sack_loop, "c_pan_noriega_sack");
  add_scene("slums_into_building", "slum_ambulence_scene");
  add_actor_anim("mason", % ch_pan_04_03_to_building_mason);
  add_actor_anim("noriega", % ch_pan_04_03_to_building_noriega);
  add_prop_anim("noriega_hat", % o_pan_04_03_to_building_hat, "c_usa_milcas_mason_cap");
  add_prop_anim("noriega_pistol", % o_pan_04_03_to_building_pistol, "t6_wpn_pistol_m1911_prop_view");
  add_scene_loop("slums_into_building_wait", "slum_ambulence_scene");
  add_actor_anim("mason", % ch_pan_04_03_to_building_mason_wait);
  add_actor_anim("noriega", % ch_pan_04_03_to_building_noriega_wait);
  add_prop_anim("noriega_hat", % o_pan_04_03_to_building_noriega_hat_wait, "c_usa_milcas_woods_cap");
  add_prop_anim("noriega_pistol", % o_pan_04_03_to_building_noriega_pistol_wait, "t6_wpn_pistol_m1911_prop_view");
  add_scene("slums_noriega_pistol", "slum_ambulence_scene");
  add_actor_anim("mason", % ch_pan_05_01_noriega_pistol_mason);
  add_actor_anim("noriega", % ch_pan_05_01_noriega_pistol_noriega);
  add_prop_anim("noriega_hat", % o_pan_05_01_noriega_pistol_hat, "c_usa_milcas_woods_cap");
  add_prop_anim("noriega_pistol", % o_pan_05_01_noriega_pistol_pistol, "t6_wpn_pistol_m1911_prop_view");
  add_prop_anim("noriega_clip", % o_pan_05_01_noriega_pistol_clip, "t6_wpn_pistol_m1911_prop_mag");
  add_notetrack_custom_function("mason", "swap_sack", ::switch_sack);
  add_notetrack_custom_function("noriega_clip", "clip_prop", ::show_fake_clip);
  add_scene_loop("slums_noriega_pistol_wait", "slum_ambulence_scene");
  add_actor_anim("mason", % ch_pan_05_01_noriega_pistol_mason_wait);
  add_actor_anim("noriega", % ch_pan_05_01_noriega_pistol_noriega_wait);
  add_prop_anim("noriega_hat", % o_pan_05_01_noriega_pistol_hat_wait, "c_usa_milcas_woods_cap", 1);
  add_prop_anim("noriega_pistol", % o_pan_05_01_noriega_pistol_pistol_wait, "t6_wpn_pistol_m1911_prop_view", 1);
  add_scene("player_door_kick", "struct_player_kick");
  add_player_anim("player_body", % int_player_kick, 1);
  add_scene("player_door_kick_door", "struct_player_door");
  add_prop_anim("player_blocker_door", % o_panama_player_kick_door, undefined, 0, 1);
  add_scene("slums_intro_ambulance_loop_1", "slum_ambulence_scene_2", 0, 0, 1);
  add_actor_anim("amb_digbat_1", % ch_pan_04_02_amblulance_digbat_1_beating);
  add_actor_anim("amb_doctor_2", % ch_pan_04_02_amblulance_doc_2_beaten, 1);
  add_scene("slums_intro_ambulance_loop_2", "slum_ambulence_scene_2", 0, 0, 1);
  add_actor_anim("amb_digbat_2", % ch_pan_04_02_amblulance_digbat_2_beating);
  add_actor_anim("amb_doctor_1", % ch_pan_04_02_amblulance_doc_1_beaten, 1);
  add_scene("slums_intro_ambulance_loop_control", "slum_ambulence_scene_2", 0, 0, 1);
  add_actor_anim("amb_digbat_3", % ch_pan_04_02_amblulance_digbat_3_beating);
  add_actor_anim("amb_nurse", % ch_pan_04_02_amblulance_nurse_beaten, 1);
  add_scene("slums_intro_civ_3_fight", "slum_ambulence_scene");
  add_actor_anim("amb_doctor_3", % ch_pan_04_01_intro_civ_fight);
  add_scene("slums_intro_civ_4_loop", "slum_ambulence_scene");
  add_actor_anim("amb_doctor_4", % ch_pan_04_01_intro_civ_2_dead_loop);
  add_scene("slums_intro_ambulance_kill", "slum_ambulence_scene_2");
  add_actor_anim("amb_digbat_1", % ch_pan_04_02_amblulance_digbat_1_killing);
  add_actor_anim("amb_digbat_2", % ch_pan_04_02_amblulance_digbat_2_killing);
  add_actor_anim("amb_digbat_3", % ch_pan_04_02_amblulance_digbat_3_killing);
  add_actor_anim("amb_doctor_1", % ch_pan_04_02_amblulance_doc_1_death, 1);
  add_actor_anim("amb_doctor_2", % ch_pan_04_02_amblulance_doc_2_death, 1);
  add_actor_anim("amb_nurse", % ch_pan_04_02_amblulance_nurse_death, 1);
  add_notetrack_flag("amb_digbat_2", "no_return", "ambulance_staff_killed");
  add_scene("slums_intro_saved_amb_doctor_1", "slum_ambulence_scene_2");
  add_actor_anim("amb_doctor_1", % ch_pan_04_02_amblulance_doc_1_saved, 1);
  add_scene("slums_intro_saved_amb_doctor_2", "slum_ambulence_scene_2");
  add_actor_anim("amb_doctor_2", % ch_pan_04_02_amblulance_doc_2_saved, 1);
  add_scene("slums_intro_saved_amb_nurse", "slum_ambulence_scene_2");
  add_actor_anim("amb_nurse", % ch_pan_04_02_amblulance_nurse_saved, 1);
  add_scene("slums_intro_saved_loop_amb_doctor_1", "slum_ambulence_scene_2", 0, 0, 1);
  add_actor_anim("amb_doctor_1", % ch_pan_04_02_amblulance_doc_1_loop, 1);
  add_scene("slums_intro_saved_loop_amb_doctor_2", "slum_ambulence_scene_2", 0, 0, 1);
  add_actor_anim("amb_doctor_2", % ch_pan_04_02_amblulance_doc_2_loop, 1);
  add_scene("slums_intro_saved_loop_amb_nurse", "slum_ambulence_scene_2", 0, 0, 1);
  add_actor_anim("amb_nurse", % ch_pan_04_02_amblulance_nurse_loop, 1);
  add_scene("slums_intro_react_amb_digbat_1", undefined, 0, 0, 0, 1);
  add_actor_anim("amb_digbat_1", % ch_pan_04_02_amblulance_digbat_1_reaction);
  add_scene("slums_intro_react_amb_digbat_2", undefined, 0, 0, 0, 1);
  add_actor_anim("amb_digbat_2", % ch_pan_04_02_amblulance_digbat_2_reaction);
  add_scene("slums_intro_react_amb_digbat_3", undefined, 0, 0, 0, 1);
  add_actor_anim("amb_digbat_3", % ch_pan_04_02_amblulance_digbat_3_reaction);
  add_scene("slums_intro_corpses", "slum_ambulence_scene_2");
  add_actor_anim("amb_corpse_1", % ch_pan_04_02_amblulance_dead_civ_1);
  add_actor_anim("amb_corpse_2", % ch_pan_04_02_amblulance_dead_civ_2);
  add_scene("civs_building_01", "collapsed_bldg");
  add_actor_anim("fire_civ_01", % ch_pan_04_02_civs_building_civ_01);
  add_scene("civs_building_02", "collapsed_bldg");
  add_actor_anim("fire_civ_02", % ch_pan_04_02_civs_building_civ_02);
  add_scene("civs_building_03", "collapsed_bldg");
  add_actor_anim("fire_civ_03", % ch_pan_04_02_civs_building_civ_03);
  add_scene("civs_building_04", "collapsed_bldg");
  add_actor_anim("fire_civ_04", % ch_pan_04_02_civs_building_civ_04);
  add_scene("civs_building_05", "collapsed_bldg");
  add_actor_anim("fire_civ_05", % ch_pan_04_02_civs_building_civ_05);
  add_scene("civs_building_06", "collapsed_bldg");
  add_actor_anim("fire_civ_06", % ch_pan_04_02_civs_building_civ_06);
  add_scene("parking_jump", "digbat_van_jump_2");
  add_actor_anim("slums_park_digbat_01", % ch_pan_05_23_parking_jump_digbat01);
  add_scene("parking_window", "digbat_van_jump");
  add_actor_anim("slums_park_digbat_02", % ch_pan_05_23_parking_jump_digbat02);
  add_scene("brute_force", "5_17_brute_force");
  add_actor_model_anim("brute_force", % ai_specialty_panama_bruteforce_deadguy, undefined, 0, undefined, undefined, "brute_force");
  add_prop_anim("brute_force_gate", % o_specialty_panama_bruteforce_gate, undefined, 0);
  add_prop_anim("brute_force_strobe", % o_specialty_panama_bruteforce_strobe, "t6_wpn_ir_strobe_world", 1);
  add_scene("brute_force_player", "5_17_brute_force");
  add_player_anim("player_body", % int_specialty_panama_bruteforce, 1);
  add_prop_anim("brute_force_crowbar", % o_specialty_panama_bruteforce_crowbar, "t6_wpn_crowbar_prop", 1);
  add_scene("slums_apt_rummage_loop", "5_21_rummage", 0, 0, 1);
  add_actor_anim("e_21_digbat_1", % ch_pan_05_21_apt_rummage_loop_digbat01);
  add_actor_anim("e_21_digbat_2", % ch_pan_05_21_apt_rummage_loop_digbat02);
  add_actor_anim("e_21_digbat_3", % ch_pan_05_21_apt_rummage_loop_digbat03);
  add_scene("slums_apt_rummage_react", "5_21_rummage");
  add_actor_anim("e_21_digbat_1", % ch_pan_05_21_apt_rummage_reaction_digbat01);
  add_actor_anim("e_21_digbat_2", % ch_pan_05_21_apt_rummage_reaction_digbat02);
  add_actor_anim("e_21_digbat_3", % ch_pan_05_21_apt_rummage_reaction_digbat03);
  add_scene("beating_loop", "digbat_beating_1", 0, 0, 1, 1);
  add_actor_anim("e_22_digbat", % ch_pan_05_22_beating_loop_digbat);
  add_scene("beating_reaction", "digbat_beating_1");
  add_actor_anim("e_22_digbat", % ch_pan_05_22_beating_reaction_digbat);
  add_scene("beating_corpse", "digbat_beating_1");
  add_actor_model_anim("e_22_corpse", % ch_pan_05_22_beaten_corpse);
  add_scene("slums_molotov_throw_left", "e_19_molotov_left");
  add_actor_anim("molotov_digbat", % ch_pan_05_19_molotov_throw_digbat);
  add_notetrack_custom_function("molotov_digbat", "attach", maps\panama_slums::e_19_attach, 1);
  add_notetrack_custom_function("molotov_digbat", "shot", maps\panama_slums::e_19_shot, 1);
  add_scene("slums_molotov_throw_right", "e_19_molotov_right");
  add_actor_anim("molotov_digbat", % ch_pan_05_19_molotov_throw_digbat);
  add_scene("slums_molotov_throw_left_alley", "e_19_molotov_alley_left");
  add_actor_anim("molotov_digbat", % ch_pan_05_19_molotov_throw_digbat);
  add_scene("slums_apc_wall_crash", "APC_StoreCrash");
  add_vehicle_anim("slums_apc_building", % fxanim_panama_laundromat_apc_anim);
  level.scr_anim["generic"]["exchange_surprise_0"] = % exposed_idle_reacta;
  level.scr_anim["generic"]["exchange_surprise_1"] = % exposed_idle_reactb;
  level.scr_anim["generic"]["exchange_surprise_2"] = % exposed_idle_twitch;
  level.scr_anim["generic"]["exchange_surprise_3"] = % exposed_idle_twitch_v4;
  level.surprise_anims = 4;
  add_scene("slums_breach_exit", "clinic_entrance");
  add_actor_anim("mason", % ch_pan_06_02_clinic_walkthru_mason_entry);
  add_actor_anim("noriega", % ch_pan_06_02_clinic_walkthru_noriega_entry);
  add_notetrack_custom_function("mason", "kick_door", maps\panama_slums::notetrack_function_end_mission);
  add_notetrack_custom_function("mason", "kick_door", ::rotate_the_clinic_door);
  add_scene("player_door_kick_clinic", "clinic_door_kick_struct");
  add_player_anim("player_body", % int_player_kick, 1, 0, undefined, 1, 1, 10, 10, 10, 10);
  add_scene("slums_critical_path_before_library", "anim_moment_4", 1);
  add_actor_anim("mason", % ch_pan_05_cover_stairs_mason);
  add_actor_anim("noriega", % ch_pan_05_cover_stairs_noriega);
  add_scene("slums_critical_path_first_car", "anim_moment_1", 1);
  add_actor_anim("mason", % ch_pan_05_cover_car_enter_mason);
  add_actor_anim("noriega", % ch_pan_05_cover_car_enter_noriega);
  add_scene_loop("slums_critical_path_first_car_idle", "anim_moment_1");
  add_actor_anim("mason", % ch_pan_05_cover_car_idle_mason);
  add_actor_anim("noriega", % ch_pan_05_cover_car_idle_noriega);
  add_scene("slums_critical_path_first_car_exit", "anim_moment_1");
  add_actor_anim("mason", % ch_pan_05_cover_car_exit_mason);
  add_actor_anim("noriega", % ch_pan_05_cover_car_exit_noriega);
  add_scene("slums_critical_path_to_barrels_from_wall_mason", "struct_start_after_barrels_noriega", 0);
  add_actor_anim("mason", % ch_pan_05_cover_barrel_mason);
  add_scene("slums_critical_path_to_barrels_from_wall_noriega", "struct_start_after_barrels_mason", 0);
  add_actor_anim("noriega", % ch_pan_05_cover_barrel_noriega);
  add_scene("slums_critical_path_along_the_wall_mason", "struct_align_wall_mason");
  add_actor_anim("mason", % ch_pan_05_cover_wall_mason);
  add_actor_anim("noriega", % ch_pan_05_cover_wall_noriega);
  add_scene("slums_critical_path_along_the_wall_noriega", "struct_align_wall_noriega", 1);
  add_actor_anim("noriega", % ch_pan_05_cover_wall_noriega);
}

rotate_the_clinic_door(guy) {
  e_door = getent("clinic_frontdoor", "targetname");
  e_rotator = getent("clinic_door_rotator", "targetname");
  e_door linkto(e_rotator);
  e_rotator rotateyaw(-110, 0.8, 0.05, 0.75);
}

switch_sack(guy) {
  level thread run_scene("headsack_loop");
  level.noriega detach("c_pan_noriega_sack", "");
}

attach_hat(m_hat) {
  level.noriega attach("c_usa_milcas_mason_cap", "tag_helmet");
  m_hat hide();
}