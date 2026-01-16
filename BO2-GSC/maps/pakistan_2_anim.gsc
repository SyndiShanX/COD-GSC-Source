/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_2_anim.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\pakistan_util;
#include maps\pakistan_roof_meeting;
#include maps\pakistan_claw;
#include maps\voice\voice_pakistan_2;
#include maps\createart\pakistan_2_art;
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

main() {
  add_scene("anthem_grapple_setup", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_1_grapple_device_harper_setup);
  add_scene("anthem_grapple_player_setup", "anthem_grappel");
  add_player_anim("player_body", % p_pakistan_5_1_grapple_device_player_setup, 0, undefined, undefined, 1, 1, 20, 20, 50, 40, 1, 1, 1, 1);
  add_scene("anthem_grapple_idle", "anthem_grappel", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_1_grapple_device_harper_idle);
  add_scene("anthem_grapple_idle_body", "anthem_grappel", 0, 0, 1);
  add_player_anim("player_body", % p_pakistan_5_1_grapple_device_player_idle, 0, undefined, undefined, 1, 1, 20, 20, 50, 40, 1, 0, 1, 1);
  add_scene("anthem_grapple", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_1_grapple_device_harper);
  add_notetrack_flag("harper", "rope_detach", "delete_rope_harper");
  add_scene("anthem_player_grapple", "anthem_grappel");
  add_player_anim("player_body", % p_pakistan_5_1_grapple_device_player, 1, undefined, undefined, 1, 1, 20, 20, 50, 40, 1, 1, 1, 1);
  add_notetrack_flag("player_body", "rope_detach", "delete_rope_player");
  add_notetrack_flag("player_body", "start_patrol", "spawn_rooftop_guard");
  add_scene("id_melee", "id_melee_guard_ai");
  add_actor_anim("id_melee_guard", % ai_contextual_melee_pakistan_neckstab);
  add_player_anim("player_body", % int_contextual_melee_pakistan_neckstab, 1);
  add_prop_anim("knife", % o_contextual_melee_pakistan_neckstab_knife, "t6_wpn_knife_base_prop", 1);
  add_notetrack_custom_function("id_melee_guard", "blood_fx", ::rooftop_melee_bloodfx);
  add_notetrack_custom_function("player_body", "knife_out", ::rooftop_melee_knifeout);
  add_scene("tower_melee_guard_idle", "tower_melee_chair", 0, 0, 1);
  add_actor_anim("tower_guard", % ai_contextual_melee_garrotesit_idle, 1, 0, 0, 1);
  add_scene("courtyard_btr_director", "anthem_gate_align", 0, 0, 1);
  add_actor_anim("anthem_btr_guy2", % ch_pakistan_5_3_activity_below_btr_gate_entrance_idle_guy02, 0, 0, 0, 1);
  add_scene("courtyard_btr_entrance", "anthem_gate_align");
  add_actor_anim("anthem_btr_guy1", % ch_pakistan_5_3_activity_below_btr_gate_entrance_guy01, 0, 0, 0, 1);
  add_actor_anim("anthem_btr_guy2", % ch_pakistan_5_3_activity_below_btr_gate_entrance_guy02, 0, 0, 0, 1);
  add_actor_anim("anthem_btr_guy3", % ch_pakistan_5_3_activity_below_btr_gate_entrance_guy03, 0, 0, 0, 1);
  add_actor_anim("anthem_btr_guy4", % ch_pakistan_5_3_activity_below_btr_gate_entrance_guy04, 0, 0, 0, 1);
  add_actor_anim("anthem_btr_guy5", % ch_pakistan_5_3_activity_below_btr_gate_entrance_guy05, 0, 0, 0, 1);
  add_prop_anim("anthem_cin_btr", % v_pakistan_5_3_activity_below_btr_gate_entrance_btr, undefined, 0);
  add_scene("courtyard_crates_1", "anthem_stairs_align", 0, 0, 1);
  add_actor_anim("crates_guy_1", % ch_pakistan_5_3_activity_below_crates_guy01, 1);
  add_actor_anim("crates_guy_2", % ch_pakistan_5_3_activity_below_crates_guy02, 1);
  add_scene("courtyard_crates_2", "anthem_stairs_align", 0, 0, 1);
  add_actor_anim("crates_guy_3", % ch_pakistan_5_3_activity_below_crates_guy03);
  add_actor_anim("crates_guy_4", % ch_pakistan_5_3_activity_below_crates_guy04);
  add_scene("storage_room_1", "anthem_gate_align", 0, 0, 1);
  add_actor_model_anim("storage_guy_1", % ch_pakistan_5_3_activity_below_storage_guy01, undefined, 0, undefined, undefined, "courtyard_activity_guy");
  add_actor_model_anim("storage_guy_2", % ch_pakistan_5_3_activity_below_storage_guy02, undefined, 0, undefined, undefined, "courtyard_activity_guy");
  add_scene("storage_room_2", "anthem_gate_align", 0, 0, 1);
  add_actor_model_anim("storage_guy_3", % ch_pakistan_5_3_activity_below_storage_guy03, undefined, 0, undefined, undefined, "courtyard_activity_guy");
  add_actor_model_anim("storage_guy_4", % ch_pakistan_5_3_activity_below_storage_guy04, undefined, 0, undefined, undefined, "courtyard_activity_guy");
  add_scene("tower_room", "tower_align", 0, 0, 1);
  add_actor_model_anim("tower_guy_1", % ch_pakistan_5_3_activity_below_tower_guy01, undefined, 0, undefined, undefined, "courtyard_activity_guy");
  add_actor_model_anim("tower_guy_2", % ch_pakistan_5_3_activity_below_tower_guy02, undefined, 0, undefined, undefined, "courtyard_activity_guy");
  add_scene("menendez_walk", undefined, 0, 0, 0, 1);
  add_actor_anim("menendez", % ch_pakistan_5_4_menendez_walk, 1);
  add_scene("militia_leader_walk", undefined, 0, 0, 0, 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_4_leader_walk, 1);

  if(randomint(3) == 0) {
    str_idle_pos = "menendez_startpos_1";
    level.str_align_menendez = "menendez_align_1";
  } else if(randomint(3) == 1) {
    str_idle_pos = "menendez_startpos_2";
    level.str_align_menendez = "menendez_align_2";
  } else {
    str_idle_pos = "menendez_startpos_3";
    level.str_align_menendez = "menendez_align_3";
  }

  add_scene("menendez_idle", str_idle_pos, 0, 0, 1);
  add_actor_anim("menendez", % ch_pakistan_5_4_confirm_menendez_idle_menendez, 1, 0, 0, 1);
  add_scene("militia_idle", str_idle_pos, 0, 0, 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_4_confirm_menendez_idle_leader, 1, 0, 0, 1);
  add_scene("confirm_menendez_crew_idle", level.str_align_menendez, 1, 0, 1);
  add_actor_anim("menendez", % ch_pakistan_5_4_confirm_menendez_idle_menendez, 1, 0, 0, 1);
  add_scene("confirm_menendez_militia_idle", level.str_align_menendez, 1, 0, 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_4_confirm_menendez_idle_leader, 1, 0, 0, 1);
  add_scene("confirm_menendez_crew", level.str_align_menendez);
  add_actor_anim("menendez", % ch_pakistan_5_4_confirm_menendez_menendez, 1, 0, 0, 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_4_confirm_menendez_leader, 1, 0, 0, 1);
  add_scene("menendez_path3", "anthem_bridge_align", 1);
  add_actor_anim("menendez", % ch_pakistan_5_5_menendez_path_3_menendez, 1, 0, 0, 1);
  add_scene("militia_leader_path3", "anthem_bridge_align", 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_5_menendez_path_3_letleader, 1, 0, 0, 1);
  add_notetrack_custom_function("militia_leader", "vox#isi3_could_they_know_you_0", ::stat_vo_check_1);
  add_scene("id_melee_approach_harper", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_4_patrol_guard_kill_approach_harper, 0, 0, 0, 1);
  add_scene("id_melee_approach_guard", "anthem_grappel");
  add_actor_anim("id_melee_guard", % ch_pakistan_5_4_patrol_guard_kill_approach_guard, 0, 0, 0, 0);
  add_actor_anim("id_melee_guard2", % ch_pakistan_5_4_patrol_guard_kill_approach_guard2, 0, 0, 0, 0);
  add_scene("id_melee_approach_idle_harper", "anthem_grappel", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_4_patrol_guard_kill_idle_harper, 0, 0, 0, 1);
  add_scene("id_melee_approach_idle_guard", "anthem_grappel", 0, 0, 1);
  add_actor_anim("id_melee_guard", % ch_pakistan_5_4_patrol_guard_kill_idle_guard, 0, 0, 0, 0);
  add_actor_anim("id_melee_guard2", % ch_pakistan_5_4_patrol_guard_kill_idle_guard2, 0, 0, 0, 0);
  add_scene("id_melee_success", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_4_patrol_guard_kill_success_harper, 0, 0, 0, 1);
  add_actor_anim("id_melee_guard2", % ch_pakistan_5_4_patrol_guard_kill_success_guard2, 0, 0, 0, 0);
  add_scene("confirm_menendez", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_4_confirm_menendez_harper, 0, 0, 0, 1);
  add_notetrack_flag("harper", "vox#harp_no_shortage_of_suspe_0", "surv_ready");
  add_scene("confirm_menendez_reach", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_4_patrol_guard_kill_success_alt_harper, 0, 0, 0, 1);
  add_scene("confirm_menendez_idle", "anthem_grappel", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_4_confirm_menendez_idle_harper, 0, 0, 0, 1);
  add_scene("confirm_menendez_exit", "anthem_grappel");
  add_actor_anim("harper", % ch_pakistan_5_4_confirm_menendez_exit_harper, 0, 0, 0, 1);
  add_scene("harper_path1", "anthem_grappel", 1);
  add_actor_anim("harper", % ch_pakistan_5_4_drop_down_stealth_harper, 0, 0, 0, 1);
  add_scene("harper_path2", "roof_station", 1);
  add_actor_anim("harper", % ch_pakistan_5_4_slide_to_balcony_harper, 0, 0, 0, 1);
  add_scene("harper_path2_idle", "roof_station", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_4_balcony_crouch_idle_harper, 0, 0, 0, 1);
  add_scene("harper_path2_crawl", "roof_station");
  add_actor_anim("harper", % ch_pakistan_5_4_balcony_crawl_harper, 0, 0, 0, 1);
  add_scene("harper_path2_prone", "roof_station", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_4_balcony_prone_harper, 0, 0, 0, 1);
  add_scene("harper_path2_climb", "roof_station");
  add_actor_anim("harper", % ch_pakistan_5_4_balcony_climb_harper, 0, 0, 0, 1);
  add_scene("harper_path3", "roof_station", 1);
  add_actor_anim("harper", % ch_pakistan_5_4_station_approach_harper, 0, 0, 0, 1);
  add_scene("harper_rooftop_door_idle", "roof_station", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_4_station_wait_harper, 0, 0, 0, 1);
  add_scene("harper_rooftop_door_close", "roof_station");
  add_actor_anim("harper", % ch_pakistan_5_4_station_doorclose_harper, 0, 0, 0, 1);
  add_actor_anim("tower_guard", % ch_pakistan_5_4_station_react_guard, 1, 0, 0, 0);
  add_prop_anim("guard_entrance", % o_pakistan_5_4_station_wait_door1, undefined, 0, 1);
  add_notetrack_custom_function("tower_guard", "blood", ::tower_guard_bloodfx);
  add_scene("tower_chair", "roof_station", 0, 0, 1);
  add_prop_anim("tower_melee_chair", % o_pakistan_5_4_station_idle_chair);
  add_scene("rooftop_entrance_open", "roof_station");
  add_prop_anim("guard_entrance", % o_pakistan_5_4_station_approach_door1, undefined, 0, 1);
  add_scene("rooftop_entrance_close", "roof_station");
  add_prop_anim("guard_entrance", % o_pakistan_5_4_station_doorclose_door1, undefined, 0, 1);
  add_scene("rooftop_exit_open", "roof_station");
  add_prop_anim("guard_exit", % o_pakistan_5_4_station_exit_door2, undefined, 0, 1);
  add_scene("rooftop_meeting_idle", "roof_scene", 0, 0, 1);
  add_actor_anim("defalco", % ch_pakistan_5_7_meeting_idle_defalco, 1, 0, 1, 1);
  add_actor_anim("rooftop_meeting_soldier1", % ch_pakistan_5_7_meeting_idle_soldier01, 0, 0, 0, 1);
  add_scene("rooftop_meeting", "roof_scene");
  add_actor_anim("menendez", % ch_pakistan_5_7_meeting_menendez, 1, 0, 0, 1);
  add_notetrack_flag("menendez", "start_defalco", "start_defalco_helipad");
  add_notetrack_custom_function("menendez", "start_talking_guys", maps\pakistan_roof_meeting::go_helipad_guys);
  add_notetrack_custom_function("menendez", "start_ramp_guys", ::start_vtol_guys);
  add_notetrack_custom_function("menendez", "vox#mene_has_the_location_for_0", ::stat_vo_check_2a);
  add_notetrack_flag("menendez", "vox#mene_good_karma_defalco_0", "meeting_over");
  add_scene("rooftop_meeting_militia", "roof_scene");
  add_actor_anim("militia_leader", % ch_pakistan_5_7_meeting_leader, 1, 0, 0, 1);
  add_scene("rooftop_meeting_defalco", "roof_scene");
  add_actor_anim("defalco", % ch_pakistan_5_7_meeting_defalco, 1, 0, 0, 1);
  add_notetrack_custom_function("defalco", "vox#defa_indeed_he_will_meet_0", ::stat_vo_check_2b);
  add_scene("rooftop_meeting_talkers_idle", "roof_scene", 0, 0, 1);
  add_actor_anim("rooftop_talker1", % ch_pakistan_5_7_meeting_idle_talking01, 0, 0, 0, 1);
  add_actor_anim("rooftop_talker2", % ch_pakistan_5_7_meeting_idle_talking02, 0, 0, 0, 1);
  add_actor_anim("rooftop_talker3", % ch_pakistan_5_7_meeting_idle_talking03, 0, 0, 0, 1);
  add_scene("rooftop_meeting_talkers", "roof_scene");
  add_actor_anim("rooftop_talker1", % ch_pakistan_5_7_meeting_talking01, 0, 0, 0, 1);
  add_actor_anim("rooftop_talker2", % ch_pakistan_5_7_meeting_talking02, 0, 0, 0, 1);
  add_actor_anim("rooftop_talker3", % ch_pakistan_5_7_meeting_talking03, 0, 0, 0, 1);
  add_scene("rooftop_meeting_soldier1", "roof_scene");
  add_actor_anim("rooftop_meeting_soldier1", % ch_pakistan_5_7_meeting_soldier01, 0, 0, 0, 1);
  add_scene("rooftop_meeting_soldiers2_idle", "roof_scene", 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier2", % ch_pakistan_5_7_meeting_idle_soldier02, 0, 0, 0, 1);
  add_scene("rooftop_meeting_soldiers3_idle", "roof_scene", 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier3", % ch_pakistan_5_7_meeting_idle_soldier03, 0, 0, 0, 1);
  add_scene("rooftop_meeting_soldiers45_idle", "roof_scene", 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier4", % ch_pakistan_5_7_meeting_idle_soldier04, 1, 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier5", % ch_pakistan_5_7_meeting_idle_soldier05, 1, 0, 0, 1);
  add_scene("rooftop_meeting_soldiers45", "roof_scene");
  add_actor_anim("rooftop_meeting_soldier4", % ch_pakistan_5_7_meeting_exit_soldier04, 0, 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier5", % ch_pakistan_5_7_meeting_exit_soldier05, 0, 0, 0, 1);
  add_scene("rooftop_meeting_soldiers67_idle", "roof_scene", 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier6", % ch_pakistan_5_7_meeting_idle_soldier06, 0, 0, 0, 1);
  add_actor_anim("rooftop_meeting_soldier7", % ch_pakistan_5_7_meeting_idle_soldier07, 0, 0, 0, 1);
  add_scene("rooftop_meeting_vtol", "roof_scene");
  add_vehicle_anim("vtol_helipad", % o_pakistan_5_7_meeting_defalco);
  add_scene("harper_path3_idle", "roof_station", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_4_station_idle_harper, 0, 0, 0, 1);
  add_scene("harper_path4", "roof_station");
  add_actor_anim("harper", % ch_pakistan_5_4_station_exit_harper, 0, 0, 0, 1);
  add_scene("harper_path4_hide", "pipe_slide2_old", 1);
  add_actor_anim("harper", % ch_pakistan_5_8_drone_hide_arrival_harper, 0, 0, 0, 1);
  add_scene("harper_path4_hide_idle", "pipe_slide2_old", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_8_drone_hide_idle_harper, 0, 0, 0, 1);
  add_scene("harper_path4_hide_exit", "pipe_slide2_old");
  add_actor_anim("harper", % ch_pakistan_5_8_drone_hide_exit_harper, 0, 0, 0, 1);
  add_scene("trainyard_melee_harper_cross_bridge", "bridge_crossing", 1);
  add_actor_anim("harper", % ch_pakistan_5_10_cross_bridge_harper, 0, 0, 0, 1);
  add_scene("trainyard_melee_tigr_idle", "drone_scene", 0, 0, 1);
  add_prop_anim("melee_tigr", % v_pakistan_5_11_contextual_melee_tigr);
  add_scene("jump_down_approach_harper", "mantle_roof_melee", 1);
  add_actor_anim("harper", % ch_pakistan_5_11_contextual_melee_approach_harper, 0, 0, 0, 1);
  add_scene("jump_down_preidle_harper", "mantle_roof_melee");
  add_actor_anim("harper", % ch_pakistan_5_11_in_our_way_harper, 0, 0, 0, 1);
  add_scene("jump_down_idle_harper", "mantle_roof_melee", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_11_contextual_melee_idle_harper, 0, 0, 0, 1);
  add_scene("jump_down_signal_harper", "mantle_roof_melee");
  add_actor_anim("harper", % ch_pakistan_5_11_contextual_melee_signal_harper, 0, 0, 0, 1);
  add_scene("jump_down_player", "mantle_roof_melee");
  add_player_anim("player_body", % p_pakistan_5_11_jump_down_attack_player_mantle, 1, undefined, undefined, 1, 1, 20, 10, 20, 0, 1, 1, 1);
  add_scene("jump_down_harper", "mantle_roof_melee");
  add_actor_anim("harper", % ch_pakistan_5_11_jump_down_attack_harper_approach, 0, 0, 0, 1);
  add_scene("jump_down_gaz", "mantle_roof_melee");
  add_vehicle_anim("gaz_tiger", % v_pakistan_5_11_jump_down_attack_gaz_approach);
  add_scene("jump_down_attack_harper_idle", "mantle_roof_melee", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_11_jump_down_attack_harper_idle, 0, 0, 0, 1);
  add_scene("jump_down_attack_gaz_idle", "mantle_roof_melee", 0, 0, 1);
  add_actor_anim("gaz_guy_1", % ch_pakistan_5_11_jump_down_attack_enemy_h_idle, 1, 1);
  add_vehicle_anim("gaz_tiger", % v_pakistan_5_11_jump_down_attack_gaz_idle);
  add_scene("jump_down_attack_gaz_guard_idle", "mantle_roof_melee", 0, 0, 1);
  add_actor_anim("gaz_guy_2", % ch_pakistan_5_11_jump_down_attack_enemy_p_idle, 1, 1);
  add_scene("jump_down_attack_harper", "mantle_roof_melee");
  add_actor_anim("harper", % ch_pakistan_5_11_jump_down_attack_harper_kill, 0, 0, 0, 1);
  add_actor_anim("gaz_guy_1", % ch_pakistan_5_11_jump_down_attack_enemy_h_kill, 1, 0, 1, 1);
  add_vehicle_anim("gaz_tiger", % v_pakistan_5_11_jump_down_attack_gaz_kill);
  add_notetrack_stop_exploder("gaz_tiger", "door_shut", 820);
  add_notetrack_custom_function("gaz_tiger", "door_shut", ::door_shut_rumble);
  add_notetrack_custom_function("gaz_guy_1", "sndStopGazAudio", ::sndstopgazaudio);
  add_scene("jump_down_attack_player", "mantle_roof_melee");
  add_player_anim("player_body", % p_pakistan_5_11_jump_down_attack_player_kill, 1, undefined, undefined, 1, 1, 10, 0, 20, 20, 1, 1, 1);
  add_actor_anim("gaz_guy_2", % ch_pakistan_5_11_jump_down_attack_enemy_p_kill, 1, 0, 1, 1);
  add_scene("jump_down_gaz_idle", "mantle_roof_melee", 0, 0, 1);
  add_vehicle_anim("gaz_tiger", % v_pakistan_5_11_jump_down_attack_gaz_end);
  add_scene("trainyard_melee_harper_door_open", "drone_scene", 1);
  add_actor_anim("harper", % ch_pakistan_5_11_approach_door_harper, 0, 0, 0, 1);
  add_scene("trainyard_melee_door_door_open", "drone_scene");
  add_prop_anim("drone_entrance", % o_pakistan_5_11_approach_door_door);
  add_scene("trainyard_melee_harper_door_idle", "drone_scene", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_11_idle_door_harper, 0, 0, 0, 1);
  add_scene("trainyard_melee_harper_door_close", "drone_scene");
  add_actor_anim("harper", % ch_pakistan_5_11_close_door_harper, 0, 0, 0, 1);
  add_prop_anim("drone_entrance", % o_pakistan_5_11_close_door_door);
  add_scene("trainyard_worker1", "align_worker1", 0, 0, 1, 1);
  add_actor_anim("trainyard_worker1", % ch_karma_2_1_tarmac_worker_03_idle, 1, 0, 0, 1);
  add_scene("trainyard_worker2", "align_worker2", 0, 0, 1, 1);
  add_actor_anim("trainyard_worker2", % ch_karma_2_1_tarmac_worker_idle_01, 1, 0, 0, 1);
  add_scene("trainyard_worker3", "align_worker3", 0, 0, 1, 1);
  add_actor_anim("trainyard_worker3", % ch_af_02_01_stingers_muj1_endidl, 1, 0, 0, 1);
  add_scene("trainyard_worker4", "align_worker4", 0, 0, 1, 1);
  add_actor_anim("trainyard_worker4", % ch_af_02_01_tank_ruin_muj2_startidl, 1, 0, 0, 1);
  add_scene("trainyard_worker5", "align_worker5", 0, 0, 1, 1);
  add_actor_anim("trainyard_worker5", % ch_pakistan_5_3_activity_below_btr_carport_guy01, 1, 0, 0, 1);
  add_scene("trainyard_worker6", "align_worker6", 0, 0, 1, 1);
  add_actor_anim("trainyard_worker6", % ch_pakistan_5_3_activity_below_btr_carport_guy02, 1, 0, 0, 1);
  level.scr_anim["generic"]["combat_jog"] = % patrol_jog;
  add_scene("trainyard_drone_meeting_harper_approach", "drone_scene", 1);
  add_actor_anim("harper", % ch_pakistan_5_13_get_closer_arrival_harper, 0, 0, 0, 1);
  add_scene("trainyard_drone_meeting_harper_approach_idle", "drone_scene", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_13_get_closer_idle_harper, 0, 0, 0, 1);
  add_scene("trainyard_drone_meeting_harper_exit", "drone_scene");
  add_actor_anim("harper", % ch_pakistan_5_13_get_closer_exit_harper, 0, 0, 0, 1);
  add_scene("trainyard_drone_meeting_cart_exit", "drone_scene");
  add_prop_anim("av_cart", % o_pakistan_5_13_get_closer_avcart);
  add_prop_anim("industrial_cart", % o_pakistan_5_13_get_closer_cart);
  add_scene("trainyard_drone_meeting", "drone_scene");
  add_actor_anim("menendez", % ch_pakistan_5_13_get_closer_menendez, 1, 0, 0, 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_13_get_closer_defalco, 1, 0, 0, 1);
  add_notetrack_flag("menendez", "start_train", "railyard_train_enter");
  add_notetrack_custom_function("menendez", "vox#mene_the_meeting_on_june_0", ::stat_vo_check_3);
  add_scene("trainyard_drone_meeting_gantry", "drone_scene");
  add_prop_anim("drone_gantry", % v_pakistan_5_13_get_closer_gantry, undefined, 0);
  add_prop_anim("dead_drone", % v_pakistan_5_13_get_closer_drone, undefined, 0);
  add_scene("trainyard_millibar_meeting_harper_approach", "drone_scene", 1);
  add_actor_anim("harper", % ch_pakistan_5_14_millibar_swim_harper, 0, 0, 0, 1);
  add_scene("trainyard_millibar_meeting_harper_idle", "drone_scene", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_5_14_millibar_swim_wait_harper, 0, 1, 0, 1);
  add_scene("trainyard_millibar_meeting_player_approach", "elevator_node");
  add_player_anim("player_body", % p_pakistan_5_14_millibar_approach_player, 1);
  add_scene("trainyard_millibar_meeting_enemy_idle", "elevator_node", 0, 0, 1);
  add_actor_anim("menendez", % ch_pakistan_5_14_millibar_menendez, 1, 0, 0, 1);
  add_actor_anim("militia_leader", % ch_pakistan_5_14_millibar_defalco, 1, 0, 0, 1);
  add_scene("trainyard_millibar_meeting_soldiers_idle", "elevator_node", 0, 0, 1);
  add_actor_anim("millibar_soldier1", % ch_pakistan_6_1_grenades_idle_soldier01, 0, 0, 0, 1);
  add_actor_anim("millibar_soldier2", % ch_pakistan_6_1_grenades_idle_soldier02, 0, 0, 0, 1);
  add_actor_anim("millibar_soldier3", % ch_pakistan_6_1_grenades_idle_soldier03, 0, 0, 0, 1);
  add_actor_anim("millibar_soldier4", % ch_pakistan_6_1_grenades_idle_soldier04, 0, 0, 0, 1);
  add_scene("trainyard_harper_millibar_grenades", "elevator_node");
  add_actor_anim("harper", % ch_pakistan_6_1_grenades_harper, 0, 1, 0, 1);
  add_notetrack_flag("harper", "vox#harp_he_s_on_to_us_secti_0", "dive");
  add_notetrack_level_notify("harper", "knife_cut", "play_blood_fx");
  add_scene("trainyard_harper_millibar_grenades_warp", "elevator_node_after");
  add_actor_anim("harper", % ch_pakistan_6_1_grenades_b_harper, 0, 1, 0, 1);
  add_scene("trainyard_millibar_grenades", "elevator_node");
  add_player_anim("player_body", % p_pakistan_6_1_grenades_player, 1, undefined, undefined, 1, 1, 10, 10, 5, 20, 1, 1, 1, 0);
  add_notetrack_custom_function("player_body", "explosion", ::incendiary_grenade_explosion);
  add_notetrack_flag("player_body", "start_millibar", "millibar_activate");
  add_notetrack_level_notify("player_body", "fov_10", "millibar_zoom");
  add_notetrack_level_notify("player_body", "stop_millibar", "millibar_stop");
  add_notetrack_level_notify("player_body", "jamming", "grenade_jamming");
  add_notetrack_level_notify("player_body", "delete_grates", "delete_grates");
  add_notetrack_flag("player_body", "surface_break", "firewater_surface");
  add_notetrack_level_notify("player_body", "vox#sect_okay_let_s_try_th_0", "activate_millibar");
  add_scene("trainyard_millibar_grenades_warp", "elevator_node_after");
  add_player_anim("player_body", % p_pakistan_6_1_grenades_b_player, 1, undefined, undefined, 1, 1, 20, 20, 20, 20, 1, 1, 1, 0);
  add_scene("trainyard_millibar_grenades_enemy_heroes", "elevator_node");
  add_actor_anim("menendez", % ch_pakistan_6_1_grenades_menendez, 1, 0, 1, 1);
  add_actor_anim("militia_leader", % ch_pakistan_6_1_grenades_defalco, 1, 0, 1, 1);
  add_scene("trainyard_millibar_grenades_enemies", "elevator_node");
  add_actor_anim("millibar_soldier1", % ch_pakistan_6_1_grenades_soldier01, 0, 0, 1, 1);
  add_actor_anim("millibar_soldier2", % ch_pakistan_6_1_grenades_soldier02, 0, 0, 1, 1);
  add_actor_anim("millibar_soldier3", % ch_pakistan_6_1_grenades_soldier03, 0, 0, 1, 1);
  add_actor_anim("millibar_soldier4", % ch_pakistan_6_1_grenades_soldier04, 0, 0, 1, 1);
  add_actor_anim("millibar_soldier5", % ch_pakistan_6_1_grenades_soldier05, 0, 0, 1, 1);
  add_actor_anim("millibar_soldier6", % ch_pakistan_6_1_grenades_soldier06, 0, 0, 1, 1);
  add_scene("trainyard_millibar_grenades_fire_grate", "elevator_node");
  add_prop_anim("gernade_grate_1", % o_pakistan_6_1_grenades_door1, "ny_harbor_tunnel_grate", 1);
  add_prop_anim("grenade_grate_2", % o_pakistan_6_1_grenades_door2, "ny_harbor_tunnel_grate", 1);
  add_scene("trainyard_millibar_grenades_fire", "elevator_node");
  add_prop_anim("incendiary1", % o_pakistan_6_1_grenades_grenade_01, "t6_wpn_grenade_incendiary_prop", 1);
  add_prop_anim("incendiary2", % o_pakistan_6_1_grenades_grenade_02, "t6_wpn_grenade_incendiary_prop", 1);
  add_scene("claw_garage_defend_harper_start", "jiffy_garage_align", 1);
  add_actor_anim("harper", % ch_pakistan_6_5_defend_area_harper, 0, 0, 0, 1);
  add_prop_anim("garage_entrance", % o_pakistan_6_5_defend_area_door);
  add_notetrack_custom_function("harper", "helo_fire", ::drone_fire_at_jiffylube);
  add_scene("claw_garage_defend_door_start", "jiffy_garage_align");
  add_prop_anim("garage_entrance", % o_pakistan_6_5_defend_area_door);
  add_scene("claw_start_player", undefined, 0, 0, 0, 1);
  add_player_anim("player_body", % p_pakistan_1_2_lockbreaker_player, 1);
  add_notetrack_custom_function("player_body", "screen_tap", maps\pakistan_util::datapad_rumble);
  add_notetrack_custom_function("player_body", "start", ::claw_data_glove_on);
  add_scene("garage_exit_harper", "jiffy_garage_align", 1);
  add_actor_anim("harper", % ch_pakistan_6_9_climb_out_harper);
  add_prop_anim("garage_entrance", % o_pakistan_6_9_climb_out_door);
  add_scene("dormant_claw_1", "claw_intro_align");
  add_actor_anim("claw_enemy_1", % ch_pakistan_6_5_dormant_claw_guy01);
  add_scene("dormant_claw_2", "claw_intro_align");
  add_actor_anim("claw_enemy_2", % ch_pakistan_6_5_dormant_claw_guy02);
  add_scene("dormant_claw_3", "claw_intro_align");
  add_actor_anim("claw_enemy_3", % ch_pakistan_6_5_dormant_claw_guy03);
  add_scene("dormant_claw_4", "claw_intro_align");
  add_actor_anim("claw_enemy_4", % ch_pakistan_6_5_dormant_claw_guy04);
  add_scene("garage_breacher", "garage_breacher_align");
  add_actor_anim("garage_breacher_kicker", % ch_pan_02_09_door_kick_mason);
  add_notetrack_flag("garage_breacher_kicker", "door_hit", "open_garage_door");
  add_scene("mount_soct_harper", "claw_player_soct", 1);
  add_actor_anim("harper", % ch_pakistan_6_11_mount_soct_harper);
  add_scene("mount_soct_harper_idle", "claw_player_soct", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_6_11_mount_soct_harper_idle);
  add_scene("mount_soct_redshirt", "claw_salazar_soct", 1);
  add_actor_anim("crosby", % ch_pakistan_6_11_mount_soct_harper);
  add_scene("mount_soct_salazar", "claw_salazar_soct");
  add_actor_anim("salazar_soct", % ch_pakistan_6_11_mount_soct_salazar);
  add_scene("mount_soct_player", "claw_player_soct");
  add_player_anim("player_body", % p_pakistan_6_11_mount_soct_player, 0, undefined, undefined, 1, 1, 20, 20, 50, 40, 1, 1, 1, 0);
  add_notetrack_custom_function("player_body", "start", ::frontend_data_glove_on);
  add_notetrack_custom_function("player_body", "start", maps\pakistan_claw::mount_soct_player_rumble);
  add_scene("exit_soct_driver");
  add_actor_anim("soct_driver", % ch_pakistan_6_11_dismount_soct_driver);
  add_scene("exit_soct_gunner");
  add_actor_anim("soct_gunner", % ch_pakistan_6_11_dismount_soct_gunner);
  precache_assets();
  maps\voice\voice_pakistan_2::init_voice();
}

start_vtol_guys(guy) {
  level thread run_scene("rooftop_meeting_soldiers45");
}

stat_vo_check_1(isi_leader) {
  level endon("stat_vo_check_1_failed");
  wait 0.5;

  while(isDefined(isi_leader.is_talking)) {
    if(level.str_hud_current_state != "recording") {
      wait 1;

      if(level.str_hud_current_state != "recording")
        level notify("stat_vo_check_1_failed");
    }

    wait 0.05;
  }

  level.stat_vo_check_1 = 1;
  level.info_recorded++;
  set_objective(level.obj_info1);
  set_objective(level.obj_info1, undefined, "done", undefined, 0);
  set_objective(level.obj_info1, undefined, "delete");
}

stat_vo_check_2a(menendez) {
  level endon("stat_vo_check_2a_failed");
  wait 0.5;

  while(isDefined(menendez.is_talking)) {
    if(level.str_hud_current_state != "recording")
      level notify("stat_vo_check_2a_failed");

    wait 0.05;
  }

  level.stat_vo_check_2a = 1;
}

stat_vo_check_2b(defalco) {
  level endon("stat_vo_check_2b_failed");
  wait 0.5;

  while(isDefined(defalco.is_talking)) {
    if(level.str_hud_current_state != "recording")
      level notify("stat_vo_check_2b_failed");

    wait 0.05;
  }

  level.stat_vo_check_2b = 1;

  if(level.stat_vo_check_2a) {
    set_objective(level.obj_info2);
    set_objective(level.obj_info2, undefined, "done", undefined, 0);
    level.info_recorded++;
    set_objective(level.obj_info2, undefined, "delete");
  }
}

stat_vo_check_3(menendez) {
  level endon("stat_vo_check_3_failed");
  wait 0.5;

  while(isDefined(menendez.is_talking)) {
    if(level.str_hud_current_state != "recording")
      level notify("stat_vo_check_3_failed");

    wait 0.05;
  }

  level.stat_vo_check_3 = 1;
  level.info_recorded++;
  set_objective(level.obj_info3);
  set_objective(level.obj_info3, undefined, "done", undefined, 0);
  set_objective(level.obj_info3, undefined, "delete");
}

door_shut_rumble(truck) {
  level.player playrumbleonentity("damage_heavy");
}

rooftop_melee_bloodfx(guard) {
  playfxontag(getfx("melee_knife_blood_player"), guard, "J_Head");
  level.player playrumbleonentity("grenade_rumble");
  wait 1;
  playfxontag(getfx("melee_knife_blood_player"), guard, "J_NECK");
  level waittill("knife_pullout");
  playfxontag(getfx("melee_knife_blood_player"), guard, "J_NECK");
}

rooftop_melee_knifeout(player) {
  level notify("knife_pullout");
  level.player playrumbleonentity("damage_heavy");
}

tower_guard_bloodfx(guard) {
  playfxontag(getfx("melee_knife_blood_player"), guard, "J_Head");
}

incendiary_grenade_explosion(e_temp) {
  wait 0.5;
  level.player playrumbleonentity("explosion_generic");
  level.player shellshock("default", 3);
  earthquake(1.0, 3.0, level.player.origin, 100);
  e_fire_water = getent("firewater", "targetname");
  e_fire_water setclientflag(5);
  e_fire_after = getent("firewater_after", "targetname");
  e_fire_after setclientflag(5);
  level thread firewater_visionset();
  exploder(700);
  wait 0.5;
  flag_wait("firewater_surface");
  stop_exploder(700);
  level.player playrumbleonentity("reload_small");
  level.player shellshock("default", 2);
  earthquake(0.5, 2.0, level.player.origin, 100);
  level.player setwatersheeting(1, 4);
  level.player setwaterdrops(100);
  exploder(610);
  level thread maps\createart\pakistan_2_art::above_water_fire_vision();
}

firewater_visionset() {
  level thread maps\createart\pakistan_2_art::vision_underwater_explosion();
  wait 1.25;
  clientnotify("fog_bank_3");
  level thread firewater_exposure();
  wait 3.5;
  clientnotify("fog_bank_1");
  level thread maps\createart\pakistan_2_art::underground_fire_fx_vision();
}

firewater_exposure() {
  setsaveddvar("r_exposureTweak", 1);
  wait 1.5;
  setsaveddvar("r_exposureValue", 3.2);
  wait 2.0;
  i = 3.2;

  while(i < 4) {
    setsaveddvar("r_exposureValue", i);
    i = i + 0.1;
    wait 0.25;
  }

  setsaveddvar("r_exposureValue", 4);
  flag_wait("firewater_surface");
  i = 4;

  while(i > 2.8) {
    setsaveddvar("r_exposureValue", i);
    i = i - 0.1;
    wait 0.1;
  }

  setsaveddvar("r_exposureValue", 2.8);
  wait 0.5;
  i = 2.8;

  while(i < 4) {
    setsaveddvar("r_exposureValue", i);
    i = i + 0.1;
    wait 0.1;
  }

  setsaveddvar("r_exposureValue", 4);
  wait 0.1;
  setsaveddvar("r_exposureTweak", 0);
}

claw_data_glove_on(m_player_body) {
  e_hint = createstreamerhint(level.player.origin, 1.0);
  e_hint linkto(m_player_body, "tag_origin", vectorscale((0, 0, 1), 8.0));
  m_player_body attach("c_usa_cia_claw_viewbody_vson", "J_WristTwist_LE");
  wait 5;
  e_hint delete();
}

frontend_data_glove_on(m_player_body) {
  e_hint = createstreamerhint(level.player.origin, 1.0);
  e_hint linkto(m_player_body, "tag_origin");
  m_player_body attach("c_usa_cia_frnd_viewbody_vson", "J_WristTwist_LE");
  wait 12;
  e_hint delete();
}

drone_fire_at_jiffylube(ai_harper) {
  level notify("intro_drone_shooting_started");
}

sndstopgazaudio(guy) {
  level clientnotify("sndShutOffGaz");
}