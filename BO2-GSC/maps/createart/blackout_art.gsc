/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\blackout_art.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\blackout_server_room;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 5);
  visionsetnaked("sp_blackout_default", 2);
}

vision_set_default() {
  visionsetnaked("sp_blackout_default", 2);
}

vision_set_interrogation() {
  visionsetnaked("sp_blackout_interrogation", 1.0);
  setdvar("r_rimIntensity", 2);
}

vision_set_hallway() {
  visionsetnaked("sp_blackout_hallway", 3.0);
}

vision_set_exterior_01() {
  visionsetnaked("sp_blackout_exterior_01", 3.0);
}

vision_set_bridge() {
  visionsetnaked("sp_blackout_bridge", 3.0);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
}

vision_set_catwalk() {
  visionsetnaked("sp_blackout_catwalk", 3.0);
}

vision_set_lowerlevel() {
  visionsetnaked("sp_blackout_lowerlevel", 3.0);
}

vision_set_sensitive_room() {
  visionsetnaked("sp_blackout_sensitive_room", 3.0);
}

vision_set_vent() {
  visionsetnaked("sp_blackout_vent", 0.0);
}

vision_set_menendez() {
  visionsetnaked("messiah_mode", 5.0);
  setdvar("r_rimIntensity", 1);
}

vision_set_mason_serverroom() {
  visionsetnaked("sp_blackout_mason_serverroom", 3.0);
  setdvar("r_rimIntensity", 1);
}

vision_set_hanger() {
  visionsetnaked("sp_blackout_hanger", 1.0);
}

vision_set_hanger_elevator() {
  visionsetnaked("sp_blackout_hanger_elevator", 0.5);
}

vision_set_deck() {
  visionsetnaked("sp_blackout_deck", 0.0);
}

vision_superkill() {
  visionsetnaked("sp_blackout_superkill", 0);
}

notetrack_intro_dof_eye_scan(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_eye_scan");

  level.player depth_of_field_tween(0, 5, 20, 100, 4, 1, 0.2);
}

notetrack_intro_dof_open_door(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_open_door");

  level.player depth_of_field_tween(0, 20, 30, 100, 4, 1, 0.2);
}

notetrack_intro_dof_talk_to_briggs(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_talk_to_briggs");

  n_near_start = 0;
  n_near_end = 20;
  n_far_start = 40;
  n_far_end = 75;
  n_near_blur = 4;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 3.5;

  iprintlnbold("DOF_TWEEN:notetrack_intro_dof_look_at_menendez");

  n_near_start = 0;
  n_near_end = 20;
  n_far_start = 100;
  n_far_end = 150;
  n_near_blur = 4;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

notetrack_intro_dof_look_at_menendez(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_look_at_menendez");

  n_near_start = 0;
  n_near_end = 20;
  n_far_start = 85;
  n_far_end = 140;
  n_near_blur = 4;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

notetrack_intro_dof_pick_up_chair(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_pick_up_chair");

  level.player depth_of_field_tween(0, 15, 30, 75, 4, 2, 0.2);
}

notetrack_intro_dof_look_at_menendez_2(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_look_at_menendez_2");

  level.player depth_of_field_tween(0, 20, 50, 100, 4, 2, 0.2);
}

notetrack_intro_dof_menendez_to_arm(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_menendez_to_arm");

  level.player depth_of_field_tween(0, 10, 15, 30, 8, 4, 0.2);
}

notetrack_intro_dof_arm_to_menendez(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_arm_to_menendez");

  level.player depth_of_field_tween(0, 20, 50, 100, 4, 3, 0.2);
}

notetrack_intro_dof_menendez_to_arm_2(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_menendez_to_arm_2");

  level.player depth_of_field_tween(0, 10, 20, 30, 8, 4, 0.2);
}

notetrack_intro_dof_arm_to_menendez_2(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_arm_to_menendez_2");

  n_near_start = 0;
  n_near_end = 20;
  n_far_start = 50;
  n_far_end = 100;
  n_near_blur = 4;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
  wait 1;
  n_near_start = 1;
  n_near_end = 20;
  n_far_start = 90;
  n_far_end = 125;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

notetrack_intro_dof_stand_up(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_stand_up");

  n_near_start = 0;
  n_near_end = 20;
  n_far_start = 90;
  n_far_end = 125;
  n_near_blur = 6;
  n_far_blur = 2;
  n_time = 0.2;
  level.player depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time);
}

notetrack_intro_dof_point_at_menendez(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_point_at_menendez");

  level.player depth_of_field_tween(0, 30, 65, 100, 8, 2, 0.2);
}

notetrack_intro_dof_turn_to_door(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_turn_to_door");

  level.player depth_of_field_tween(0, 20, 50, 100, 4, 2, 0.2);
}

notetrack_intro_dof_shoot_guard(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_shoot_guard");

  level.player depth_of_field_tween(0, 20, 75, 125, 8, 2, 0.2);
}

notetrack_intro_dof_look_at_menendez_3(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_look_at_menendez_3");

  level.player depth_of_field_tween(0, 20, 75, 125, 8, 2, 0.2);
}

notetrack_intro_dof_hands_up(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_hands_up");

  level.player depth_of_field_tween(0, 20, 75, 125, 8, 2, 0.2);
}

notetrack_intro_dof_place_gun_on_table(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_place_gun_on_table");

  level.player depth_of_field_tween(0, 20, 75, 115, 8, 2, 0.2);
}

notetrack_intro_dof_put_on_hand_cuffs(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_put_on_hand_cuffs");

  level.player depth_of_field_tween(0, 10, 30, 50, 8, 2, 0.2);
}

notetrack_intro_dof_look_at_menendez_4(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_look_at_menendez_4");

  level.player depth_of_field_tween(0, 20, 75, 115, 8, 2, 0.2);
}

notetrack_intro_dof_look_at_wall(m_player_body) {
  iprintlnbold("DOF:notetrack_intro_dof_look_at_wall");

  level.player depth_of_field_tween(0, 10, 50, 100, 4, 2, 0.2);
}

notetrack_intro_dof_hit_ground(m_player_body) {
  iprintlnbold("DOF:intro_dof_off");

  level.player thread depth_of_field_off(0.25);
}

notetrack_super_kill_dof_1_salazar(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 15, 100, 6, 2, 0.2);
}

notetrack_super_kill_dof_2_salazar(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_dof_3_guard01(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_dof_4_guard02(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_a_dof_5_salazar_pistol(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_a_dof_6_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_a_dof_7_farid_pistol(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_a_dof_8_defalco(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_a_dof_9_farid(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 25, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_a_dof_10_salazar(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  level thread maps\blackout_server_room::set_dead_poses_from_betrayal_anim();
}

notetrack_super_kill_alive_b_dof_5_farid(ai_salazar) {
  ai_defalco = get_ent("defalco_ai", "targetname");
  e_streamer_hint = createstreamerhint(ai_defalco gettagorigin("tag_origin"), 1.0);
  e_streamer_hint linkto(ai_defalco, "tag_origin");
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  wait 6;
  e_streamer_hint unlink();
  e_streamer_hint delete();
}

notetrack_super_kill_alive_b_dof_6_farid_pistol(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_b_dof_7_defalco(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_b_8_defalco_pistol(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_b_dof_9_farid(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_b_dof_10_farid(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_b_dof_11_salazar(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  level thread maps\blackout_server_room::set_dead_poses_from_betrayal_anim();
}

notetrack_super_kill_alive_c_dof_5_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_alive_c_dof_6_defalco(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  delay_thread(3, maps\blackout_server_room::set_dead_poses_from_betrayal_anim);
}

notetrack_super_kill_dead_a_dof_5_salazar(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_a_dof_6_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_a_dof_7_farid(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_a_8_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_a_dof_9_salazar(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_a_dof_10_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_a_dof_11_salazar(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  delay_thread(2, maps\blackout_server_room::set_dead_poses_from_betrayal_anim);
}

notetrack_super_kill_dead_b_dof_5_farid(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_b_dof_6_farid(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_b_dof_7_salazar(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  level thread maps\blackout_server_room::set_dead_poses_from_betrayal_anim();
}

notetrack_super_kill_dead_c_dof_5_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_c_dof_6_salazar(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_c_dof_7_karma(ai_salazar) {
  level.player depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
}

notetrack_super_kill_dead_c_dof_8_karma(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  level thread maps\blackout_server_room::set_dead_poses_from_betrayal_anim();
}

notetrack_super_kill_dead_d_dof_5_salazar(ai_salazar) {
  level.player thread depth_of_field_tween(0, 5, 5, 100, 6, 2, 0.2);
  level thread maps\blackout_server_room::set_dead_poses_from_betrayal_anim();
}

notetrack_meat_shield_briggs_back(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_briggs_back");

  level.player depth_of_field_tween(0, 10, 40, 125, 6, 2, 0.2);
}

notetrack_meat_shield_gun_1(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_gun_1");

  level.player depth_of_field_tween(0, 10, 55, 125, 6, 2, 0.2);
}

notetrack_meat_shield_distant_guard(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_distant_guard");

  level.player depth_of_field_tween(0, 20, 100, 200, 6, 2, 0.2);
}

notetrack_meat_shield_guard_1(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_guard_1");

  level.player depth_of_field_tween(0, 20, 100, 200, 6, 2, 0.2);
}

notetrack_meat_shield_guard_2(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_guard_2");

  level.player depth_of_field_tween(0, 20, 100, 200, 6, 2, 0.2);
}

notetrack_meat_shield_guard_3(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_guard_3");

  level.player depth_of_field_tween(0, 20, 150, 200, 6, 2, 0.2);
}

notetrack_meat_shield_guard_4(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_guard_4");

  level.player depth_of_field_tween(0, 20, 150, 250, 6, 2, 0.2);
}

notetrack_meat_shield_see_all(m_player_body) {
  iprintlnbold("DOF:notetrack_meat_shield_see_all");

  level.player depth_of_field_tween(0, 20, 270, 350, 6, 2, 0.2);
}