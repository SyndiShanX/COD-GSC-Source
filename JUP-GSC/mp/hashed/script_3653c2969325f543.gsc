/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3653c2969325f543.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\utility\player;
#namespace namespace_5e37f681245edd90;

function function_9c1b71b6f81d3121() {
  game["dialog"]["obj1_nag_def_launchfacility"] = "dx_mp_mwm1_mode_spet_ondg";
  game["dialog"]["obj1_nag_atk_launchfacility"] = "dx_mp_mwm1_mode_t141_onat";
  game["dialog"]["obj1_atk_win_launchfacility"] = "dx_mp_mwm1_mode_t141_owak";
  game["dialog"]["obj1_def_lost_launchfacility"] = "dx_mp_mwm1_mode_spet_owin";
  game["dialog"]["obj1_atk_lost_launchfacility"] = "dx_mp_mwm1_mode_t141_ofai";
  game["dialog"]["obj1_def_win_launchfacility"] = "dx_mp_mwm1_mode_spet_ofae";
  game["dialog"]["obj1_securing_a_atk"] = "dx_mp_mwm1_mode_t141_ostk";
  game["dialog"]["obj1_captured_a_atk"] = "dx_mp_mwm1_mode_t141_octk";
  game["dialog"]["obj1_losing_a_def"] = "dx_mp_mwm1_mode_spet_olad";
  game["dialog"]["obj1_lost_a_def"] = "dx_mp_mwm1_mode_spet_olde";
  game["dialog"]["obj1_securing_b_atk"] = "dx_mp_mwm1_mode_t141_osbk";
  game["dialog"]["obj1_captured_b_atk"] = "dx_mp_mwm1_mode_t141_ocbk";
  game["dialog"]["obj1_losing_b_def"] = "dx_mp_mwm1_mode_spet_olbd";
  game["dialog"]["obj1_lost_b_def"] = "dx_mp_mwm1_mode_spet_olbf";
  game["dialog"]["obj1_missile_launch_atk"] = "dx_mp_mwm1_mode_t141_omla";
  game["dialog"]["obj1_atk_overtime_launchfacility"] = "dx_mp_mwm1_mode_t141_ooao";
  game["dialog"]["obj1_def_overtime_launchfacility"] = "dx_mp_mwm1_mode_spet_oode";
  game["dialog"]["obj2_atk_start_launchfacility"] = "dx_mp_mwm1_mode_t141_obeg";
  game["dialog"]["obj2_def_start_launchfacility"] = "dx_mp_mwm1_mode_spet_obgi";
  game["dialog"]["obj2_nag_atk_launchfacility"] = "dx_mp_mwm1_mode_t141_ontk";
  game["dialog"]["obj2_nag_def_launchfacility"] = "dx_mp_mwm1_mode_spet_ondf";
  game["dialog"]["obj2_atk_win_launchfacility"] = "dx_mp_mwm1_mode_t141_owtk";
  game["dialog"]["obj2_def_lost_launchfacility"] = "dx_mp_mwm1_mode_spet_owdf";
  game["dialog"]["obj2_atk_lost_launchfacility"] = "dx_mp_mwm1_mode_t141_oftk";
  game["dialog"]["obj2_def_win_launchfacility"] = "dx_mp_mwm1_mode_spet_ofdf";
  game["dialog"]["obj2_atk_tank_contested_launchfacility"] = "dx_mp_mwm1_mode_t141_otck";
  game["dialog"]["obj2_def_tank_contested_launchfacility"] = "dx_mp_mwm1_mode_spet_otcd";
  game["dialog"]["obj2_atk_tank_damaged_launchfacility"] = "dx_mp_mwm1_mode_t141_otdk";
  game["dialog"]["obj2_def_tank_damaged_launchfacility"] = "dx_mp_mwm1_mode_spet_otdf";
  game["dialog"]["obj2_atk_tank_repaired_launchfacility"] = "dx_mp_mwm1_mode_t141_otra";
  game["dialog"]["obj2_def_tank_repaired_launchfacility"] = "dx_mp_mwm1_mode_spet_otrd";
  game["dialog"]["obj2_atk_overtime_launchfacility"] = "dx_mp_mwm1_mode_t141_ootk";
  game["dialog"]["obj2_def_overtime_launchfacility"] = "dx_mp_mwm1_mode_spet_oodf";
  game["dialog"]["obj3_atk_start_launchfacility"] = "dx_mp_mwm1_mode_t141_obtk";
  game["dialog"]["obj3_def_start_launchfacility"] = "dx_mp_mwm1_mode_spet_obdf";
  game["dialog"]["obj3_nag_atk_launchfacility"] = "dx_mp_mwm1_mode_t141_onak";
  game["dialog"]["obj3_nag_def_launchfacility"] = "dx_mp_mwm1_mode_spet_onde";
  game["dialog"]["obj3_atk_upload_start_launchfacility"] = "dx_mp_mwm1_mode_t141_oipk";
  game["dialog"]["obj3_def_upload_start_launchfacility"] = "dx_mp_mwm1_mode_spet_oipd";
  game["dialog"]["obj3_atk_upload_complete_launchfacility"] = "dx_mp_mwm1_mode_t141_ohpk";
  game["dialog"]["obj3_def_upload_complete_launchfacility"] = "dx_mp_mwm1_mode_spet_ohpd";
  game["dialog"]["obj3_atk_win_launchfacility"] = "dx_mp_mwm1_mode_t141_owat";
  game["dialog"]["obj3_def_lost_launchfacility"] = "dx_mp_mwm1_mode_spet_owde";
  game["dialog"]["obj3_atk_lost_launchfacility"] = "dx_mp_mwm1_mode_t141_ofat";
  game["dialog"]["obj3_def_win_launchfacility"] = "dx_mp_mwm1_mode_spet_ofad";
  game["dialog"]["obj3_missile_launch_atk"] = "dx_mp_mwm1_mode_t141_omlk";
  game["dialog"]["obj3_atk_overtime_launchfacility"] = "dx_mp_mwm1_mode_t141_over";
  game["dialog"]["obj3_def_overtime_launchfacility"] = "dx_mp_mwm1_mode_spet_oota";
  game["dialog"]["obj1_nag_atk_skydiving"] = "dx_mp_skyd_game_seal_onat";
  game["dialog"]["obj1_nag_def_skydiving"] = "dx_mp_skyd_game_spet_ondg";
  game["dialog"]["obj1_atk_activation_start_skydiving"] = "dx_mp_skyd_game_seal_o1aa";
  game["dialog"]["obj1_def_activation_start_skydiving"] = "dx_mp_skyd_game_spet_o1ad";
  game["dialog"]["obj1_atk_activation_restored_skydiving"] = "dx_mp_skyd_game_seal_o1ra";
  game["dialog"]["obj1_def_activation_restored_skydiving"] = "dx_mp_skyd_game_spet_o1rd";
  game["dialog"]["obj1_atk_first_complete_skydiving"] = "dx_mp_skyd_game_seal_o1fa";
  game["dialog"]["obj1_def_first_complete_skydiving"] = "dx_mp_skyd_game_spet_o1fd";
  game["dialog"]["obj1_atk_second_complete_skydiving"] = "dx_mp_skyd_game_seal_o1st";
  game["dialog"]["obj1_def_second_complete_skydiving"] = "dx_mp_skyd_game_spet_o1sf";
  game["dialog"]["obj1_atk_bomb_planted_skydiving"] = "dx_mp_skyd_game_seal_o1pt";
  game["dialog"]["obj1_def_bomb_planted_skydiving"] = "dx_mp_skyd_game_spet_o1pd";
  game["dialog"]["obj1_atk_bomb_defused_skydiving"] = "dx_mp_skyd_game_seal_o1da";
  game["dialog"]["obj1_def_bomb_defused_skydiving"] = "dx_mp_skyd_game_spet_o1bd";
  game["dialog"]["obj1_atk_win_skydiving"] = "dx_mp_skyd_game_seal_owak";
  game["dialog"]["obj1_def_lost_skydiving"] = "dx_mp_skyd_game_spet_owin";
  game["dialog"]["obj1_atk_lost_skydiving"] = "dx_mp_skyd_game_seal_ofai";
  game["dialog"]["obj1_def_win_skydiving"] = "dx_mp_skyd_game_spet_ofae";
  game["dialog"]["obj1_atk_overtime_skydiving"] = "dx_mp_skyd_game_seal_ooao";
  game["dialog"]["obj1_def_overtime_skydiving"] = "dx_mp_skyd_game_spet_oode";
  game["dialog"]["obj2_atk_start_skydiving"] = "dx_mp_skyd_game_seal_obeg";
  game["dialog"]["obj2_def_start_skydiving"] = "dx_mp_skyd_game_spet_obgi";
  game["dialog"]["obj2_nag_atk_skydiving"] = "dx_mp_skyd_game_seal_ontk";
  game["dialog"]["obj2_nag_def_skydiving"] = "dx_mp_skyd_game_spet_ondf";
  game["dialog"]["obj2_atk_wheelson_contested_skydiving"] = "dx_mp_skyd_game_seal_o2ca";
  game["dialog"]["obj2_def_wheelson_contested_skydiving"] = "dx_mp_skyd_game_spet_o2cd";
  game["dialog"]["obj2_atk_wheelson_blocked_skydiving"] = "dx_mp_skyd_game_seal_o2wb";
  game["dialog"]["obj2_def_wheelson_blocked_skydiving"] = "dx_mp_skyd_game_spet_o2bd";
  game["dialog"]["obj2_atk_server1_hacking_skydiving"] = "dx_mp_skyd_game_seal_o1sa";
  game["dialog"]["obj2_def_server1_hacking_skydiving"] = "dx_mp_skyd_game_spet_o1sd";
  game["dialog"]["obj2_atk_server1_hacked_skydiving"] = "dx_mp_skyd_game_seal_o1ht";
  game["dialog"]["obj2_def_server1_hacked_skydiving"] = "dx_mp_skyd_game_spet_o1hd";
  game["dialog"]["obj2_atk_server2_hacking_skydiving"] = "dx_mp_skyd_game_seal_o2sa";
  game["dialog"]["obj2_def_server2_hacking_skydiving"] = "dx_mp_skyd_game_spet_o2sd";
  game["dialog"]["obj2_atk_gas_spreading_skydiving"] = "dx_mp_skyd_game_seal_o2gt";
  game["dialog"]["obj2_def_gas_spreading_skydiving"] = "dx_mp_skyd_game_spet_o2gd";
  game["dialog"]["obj2_atk_zombie_spawned_skydiving"] = "dx_mp_skyd_game_seal_o2za";
  game["dialog"]["obj2_atk_gas_spreading_fast_skydiving"] = "dx_mp_skyd_game_seal_o2ga";
  game["dialog"]["obj2_atk_win_skydiving"] = "dx_mp_skyd_game_seal_owtk";
  game["dialog"]["obj2_def_lost_skydiving"] = "dx_mp_skyd_game_spet_owdf";
  game["dialog"]["obj2_atk_lost_skydiving"] = "dx_mp_skyd_game_seal_oftk";
  game["dialog"]["obj2_def_win_skydiving"] = "dx_mp_skyd_game_spet_ofdf";
  game["dialog"]["obj2_atk_overtime_skydiving"] = "dx_mp_skyd_game_seal_ootk";
  game["dialog"]["obj2_def_overtime_skydiving"] = "dx_mp_skyd_game_spet_oodf";
  game["dialog"]["obj3_atk_start_skydiving"] = "dx_mp_skyd_game_seal_obtk";
  game["dialog"]["obj3_def_start_skydiving"] = "dx_mp_skyd_game_spet_obdf";
  game["dialog"]["obj3_nag_atk_skydiving"] = "dx_mp_skyd_game_seal_onak";
  game["dialog"]["obj3_nag_def_skydiving"] = "dx_mp_skyd_game_spet_onde";
  game["dialog"]["obj3_atk_pick_up_skydiving"] = "dx_mp_skyd_game_seal_o3pa";
  game["dialog"]["obj3_def_pick_up_skydiving"] = "dx_mp_skyd_game_spet_o3pd";
  game["dialog"]["obj3_atk_item_drop_skydiving"] = "dx_mp_skyd_game_seal_o3ia";
  game["dialog"]["obj3_def_item_drop_skydiving"] = "dx_mp_skyd_game_spet_o3id";
  game["dialog"]["obj3_atk_pds_installed_skydiving"] = "dx_mp_skyd_game_seal_o3la";
  game["dialog"]["obj3_def_pds_installed_skydiving"] = "dx_mp_skyd_game_spet_o3ld";
  game["dialog"]["obj3_atk_hold_ground_skydiving"] = "dx_mp_skyd_game_seal_o3hg";
  game["dialog"]["obj3_def_hold_ground_skydiving"] = "dx_mp_skyd_game_spet_o3hd";
  game["dialog"]["obj3_atk_zombie_swarm_skydiving"] = "dx_mp_skyd_game_seal_o3za";
  game["dialog"]["obj3_def_zombie_swarm_skydiving"] = "dx_mp_skyd_game_spet_o3zd";
  game["dialog"]["obj3_atk_win_skydiving"] = "dx_mp_skyd_game_seal_owat";
  game["dialog"]["obj3_def_lost_skydiving"] = "dx_mp_skyd_game_spet_owde";
  game["dialog"]["obj3_atk_lost_skydiving"] = "dx_mp_skyd_game_seal_ofat";
  game["dialog"]["obj3_def_win_skydiving"] = "dx_mp_skyd_game_spet_ofad";
  game["dialog"]["obj3_atk_overtime_skydiving"] = "dx_mp_skyd_game_seal_over";
  game["dialog"]["obj3_def_overtime_skydiving"] = "dx_mp_skyd_game_spet_oota";
  function_e4285658260d1bfa(1, &function_44819d78b997c07e);
  function_e4285658260d1bfa(2, &function_8d2572177b9f2ca8);
  function_e4285658260d1bfa(5, &function_bbecb13e462544f7);
  function_e4285658260d1bfa(3, &function_736687f240844467);
  function_e4285658260d1bfa(6, &function_2aa22d9aa822ab01);
  function_e4285658260d1bfa(9, &function_67d7919e13e0ac64);
  function_e4285658260d1bfa(10, &function_2b07c5a3c08bba8e);
  function_e4285658260d1bfa(11, &function_e50e4c55aec1de36);
  function_e4285658260d1bfa(12, &function_8227a04fff6a005d);
  function_86e5700d7971e414(1, "attackers_lost_zone");
  function_86e5700d7971e414(2, "attackers_lost_bomb_objective");
  function_86e5700d7971e414(5, "attackers_lost_sam_site");
  function_86e5700d7971e414(3, "attackers_lost_hostages");
  function_86e5700d7971e414(6, "attackers_lost_tank_objective");
  function_86e5700d7971e414(9, "obj3_atk_lost_launchfacility");
  function_86e5700d7971e414(10, "obj1_atk_lost_skydiving");
  function_86e5700d7971e414(11, "obj2_atk_lost_skydiving");
  function_86e5700d7971e414(12, "obj3_atk_lost_skydiving");
  function_5580ef2fc74eb79c(9, "obj3_def_win_launchfacility");
  function_5580ef2fc74eb79c(10, "obj1_def_win_skydiving");
  function_5580ef2fc74eb79c(11, "obj2_def_win_skydiving");
  function_5580ef2fc74eb79c(12, "obj3_def_win_skydiving");
  function_8ee1bbc9a60b0b00(2, "attackers_bomb_start", "defenders_bomb_start");
  function_8ee1bbc9a60b0b00(5, "attackers_sam_start", "defenders_sam_start");
  function_8ee1bbc9a60b0b00(6, "attackers_tank_escort_start", "defenders_tank_escort_start");
  function_8ee1bbc9a60b0b00(9, "obj3_atk_start_launchfacility", "obj3_def_start_launchfacility");
  function_8ee1bbc9a60b0b00(11, "obj2_atk_start_skydiving", "obj2_def_start_skydiving");
  function_8ee1bbc9a60b0b00(12, "obj3_atk_start_skydiving", "obj3_def_start_skydiving");
}

function function_44819d78b997c07e(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "defenders", "nag_defend_objective", &function_b908e49a52805716, 20, 8);
  function_1e87a912abc079e4(zone, "attackers", "nag_take_objective", &function_c6d032c5630b1779, 20, 8);
  function_266f0d24f28fc974(zone);
}

function function_8d2572177b9f2ca8(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "defenders", "nag_protect_bombs", undefined, 20, 8);
  function_1e87a912abc079e4(zone, "attackers", "nag_defuse_bombs", &function_7a35c8c10abd7cfb, 20, 8);
  function_1e87a912abc079e4(zone, "defenders", "alert_enemy_defusing_bombs", "began_defusing_bomb", 2);
  function_1e87a912abc079e4(zone, "attackers", "alert_team_defusing_bombs", "began_defusing_bomb", 2);
  function_266f0d24f28fc974(zone);
}

function function_bbecb13e462544f7(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "defenders", "nag_defend_sam_site", undefined, 14, 8);
  function_1e87a912abc079e4(zone, "attackers", "nag_plant_c4", undefined, 14, 8);
  function_1e87a912abc079e4(zone, "defenders", "alert_enemy_planted_c4", "planted_bomb_on_sam_site", 2);
  function_1e87a912abc079e4(zone, "attackers", "alert_team_planted_c4", "planted_bomb_on_sam_site", 2);
  function_1e87a912abc079e4(zone, "defenders", "alert_team_defused_c4", "defused_bomb_on_sam_site", 2);
  function_1e87a912abc079e4(zone, "attackers", "alert_team_defused_c4", "defused_bomb_on_sam_site", 2);
  function_266f0d24f28fc974(zone);
}

function function_736687f240844467(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "defenders", "nag_defend_hostages", undefined, 14, 8);
  function_1e87a912abc079e4(zone, "attackers", "nag_rescue_hostages", undefined, 14, 8);
  function_266f0d24f28fc974(zone);
}

function function_2aa22d9aa822ab01(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "defenders", "nag_defenders_defend_tank", undefined, 14, 8);
  function_1e87a912abc079e4(zone, "attackers", "nag_attackers_escort_tank", undefined, 14, 8);
  function_266f0d24f28fc974(zone);
}

function function_67d7919e13e0ac64(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "defenders", "obj3_nag_def_launchfacility", undefined, 14, 8);
  function_1e87a912abc079e4(zone, "attackers", "obj3_nag_atk_launchfacility", undefined, 14, 8);
  function_1e87a912abc079e4(zone, "attackers", "obj3_missile_launch_atk", "zone_3_missile_launched");
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_overtime_launchfacility", "obj_type_9_overtime_mp_jup_launchfacility");
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_overtime_launchfacility", "obj_type_9_overtime_mp_jup_launchfacility");
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_upload_start_launchfacility", "hack_zone_upload_start");
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_upload_start_launchfacility", "hack_zone_upload_start");
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_upload_complete_launchfacility", "hack_zone_upload_complete");
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_upload_complete_launchfacility", "hack_zone_upload_complete");
  function_266f0d24f28fc974(zone);
}

function function_2b07c5a3c08bba8e(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "attackers", "obj1_nag_atk_skydiving", &function_b57b0ea75269b610, 60, undefined, 18);
  function_1e87a912abc079e4(zone, "defenders", "obj1_nag_def_skydiving", &function_b57b0ea75269b610, 60, undefined, 18);
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_activation_start_skydiving", "hack_zone_upload_start");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_activation_start_skydiving", "hack_zone_upload_start");
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_activation_restored_skydiving", "hack_recovered");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_activation_restored_skydiving", "hack_recovered");
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_first_complete_skydiving", "hack_zone_upload_complete");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_first_complete_skydiving", "hack_zone_upload_complete");
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_second_complete_skydiving", "hack_zone_upload_full_complete");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_second_complete_skydiving", "hack_zone_upload_full_complete");
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_bomb_planted_skydiving", "hack_bomb_planted");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_bomb_planted_skydiving", "hack_bomb_planted");
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_bomb_defused_skydiving", "hack_bomb_defused");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_bomb_defused_skydiving", "hack_bomb_defused");
  function_1e87a912abc079e4(zone, "attackers", "obj1_atk_overtime_skydiving", "obj_type_10_overtime_mp_jup_skydiving");
  function_1e87a912abc079e4(zone, "defenders", "obj1_def_overtime_skydiving", "obj_type_10_overtime_mp_jup_skydiving");
  function_266f0d24f28fc974(zone);
}

function function_e50e4c55aec1de36(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "attackers", "obj2_nag_atk_skydiving", &function_cea536bf68cd4d66, 50, 3, 30);
  function_1e87a912abc079e4(zone, "defenders", "obj2_nag_def_skydiving", &function_942d0ced45796880, 50, 3, 30);
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_wheelson_contested_skydiving", &function_4dea6838299eb754, 20);
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_wheelson_contested_skydiving", &function_4dea6838299eb754, 20);
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_wheelson_blocked_skydiving", &function_91314f19e66f7674, 30);
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_wheelson_blocked_skydiving", &function_91314f19e66f7674, 30);
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_server1_hacking_skydiving", "wheelson_reach_hack_point");
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_server1_hacking_skydiving", "wheelson_reach_hack_point");
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_server1_hacked_skydiving", "point_1_hacked");
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_server1_hacked_skydiving", "point_1_hacked");

  if(istrue(level.enablezombie)) {
    function_1e87a912abc079e4(zone, "attackers", "obj2_atk_zombie_spawned_skydiving", "point_1_hacked", undefined, 5);
  }

  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_server2_hacking_skydiving", "wheelson_reach_hack_point_final");
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_server2_hacking_skydiving", "wheelson_reach_hack_point_final");
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_gas_spreading_skydiving", "point_1_hacked", undefined, 13);
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_gas_spreading_skydiving", "point_1_hacked", undefined, 13);
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_gas_spreading_fast_skydiving", "wheelson_reach_hack_point_final", undefined, 7);
  function_1e87a912abc079e4(zone, "attackers", "obj2_atk_overtime_skydiving", "obj_type_11_overtime_mp_jup_skydiving");
  function_1e87a912abc079e4(zone, "defenders", "obj2_def_overtime_skydiving", "obj_type_11_overtime_mp_jup_skydiving");
  function_266f0d24f28fc974(zone);
}

function function_8227a04fff6a005d(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  function_1e87a912abc079e4(zone, "attackers", "obj3_nag_atk_skydiving", &function_88cb5e18754f7caf, 60, undefined, 30);
  function_1e87a912abc079e4(zone, "defenders", "obj3_nag_def_skydiving", &function_88cb5e18754f7caf, 60, undefined, 30);
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_pick_up_skydiving", "filter_picked_up", 10);
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_pick_up_skydiving", "filter_picked_up", 10);
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_item_drop_skydiving", "filter_drop", 10);
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_item_drop_skydiving", "filter_drop", 10);
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_pds_installed_skydiving", "captureflag_device_deployed");
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_pds_installed_skydiving", "captureflag_device_deployed");
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_hold_ground_skydiving", "captureflag_device_deployed", undefined, 5);
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_hold_ground_skydiving", "captureflag_device_deployed", undefined, 5);

  if(istrue(level.enablezombie)) {
    function_1e87a912abc079e4(zone, "attackers", "obj3_atk_zombie_swarm_skydiving", "captureflag_device_deployed", undefined, 12);
  }

  function_1e87a912abc079e4(zone, "defenders", "obj3_def_zombie_swarm_skydiving", "captureflag_device_deployed", undefined, 12);
  function_1e87a912abc079e4(zone, "attackers", "obj3_atk_overtime_skydiving", "obj_type_12_overtime_mp_jup_skydiving");
  function_1e87a912abc079e4(zone, "defenders", "obj3_def_overtime_skydiving", "obj_type_12_overtime_mp_jup_skydiving");
  function_266f0d24f28fc974(zone);
}

function function_7a35c8c10abd7cfb(zone) {
  foreach(player in level.players) {
    if(isreallyalive(player) && istrue(player.isplanting)) {
      return false;
    }
  }

  return true;
}

function function_b908e49a52805716(zone) {
  foreach(capture_zone in zone.capture_zones) {
    if(isDefined(capture_zone.claimplayer) && !istrue(capture_zone.stalemate)) {
      return true;
    }
  }

  return false;
}

function function_c6d032c5630b1779(zone) {
  foreach(capture_zone in zone.capture_zones) {
    if(capture_zone.touchlist[game["attackers"]].size > 0) {
      return false;
    }
  }

  return true;
}

function function_620b653076493779(zone) {
  if(is_equal(zone.objectivetype, 6)) {
    return istrue(level.escortvehicles[0].contested);
  }

  return false;
}

function function_4dea6838299eb754(zone) {
  if(!isDefined(level.escortvehicles[0])) {
    level waittill("wheelson_spawn");
  }

  if(is_equal(zone.objectivetype, 11)) {
    return istrue(level.escortvehicles[0].contested);
  }

  return false;
}

function function_91314f19e66f7674(zone) {
  if(!isDefined(level.escortvehicles[0])) {
    level waittill("wheelson_spawn");
  }

  if(is_equal(zone.objectivetype, 11)) {
    return istrue(level.escortvehicles[0].var_5b67ad6d3409a341);
  }

  return false;
}

function function_cea536bf68cd4d66(zone) {
  if(!isDefined(level.escortvehicles[0])) {
    level waittill("wheelson_spawn");
  }

  if(isDefined(level.escortvehicles[0].var_95f2a51e7b487eb2)) {
    if(is_equal(zone.objectivetype, 11) && is_equal(level.escortvehicles[0].var_95f2a51e7b487eb2.size, 0) && !istrue(level.escortvehicles[0].var_65ab8f532ca7195)) {
      return 1;
    }

    return 0;
  }
}

function function_942d0ced45796880(zone) {
  if(!isDefined(level.escortvehicles[0])) {
    level waittill("wheelson_spawn");
  }

  if(isDefined(level.escortvehicles[0].var_95f2a51e7b487eb2)) {
    if(is_equal(zone.objectivetype, 11) && !is_equal(level.escortvehicles[0].var_95f2a51e7b487eb2.size, 0) && !istrue(level.escortvehicles[0].var_65ab8f532ca7195)) {
      return 1;
    }

    return 0;
  }
}

function function_b57b0ea75269b610(zone) {
  if(is_equal(zone.currentphase, "hack")) {
    foreach(hackzone in zone.hackzones) {
      if(istrue(hackzone.ishacking) || istrue(hackzone.var_9832d5270deb1889)) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function function_88cb5e18754f7caf(zone) {
  if(is_equal(zone.currentphase, "capture_flag")) {
    return true;
  }

  return false;
}