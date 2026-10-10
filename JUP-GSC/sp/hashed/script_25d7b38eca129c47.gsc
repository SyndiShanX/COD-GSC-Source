/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_25d7b38eca129c47.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace namespace_69b39d9c0dcbae56;

function main() {
  player();
  generic_human();
  scriptmodels();
  rappel_rig();
}

#using_animtree("player");

function player() {
  var_de3cd0960c122123 = utility::function_ea3248e9abe4700a();
  level.scr_model[var_de3cd0960c122123] = "viewmodel_fullbody_sp_soap_nightwar";
  level.scr_anim["player_rig"]["rappel1_enter"] = % twr_0100_rooftop_rappel_scene_plr;
  level.scr_anim["player_rig"]["rappel_exit_down"] = % twr_global_rappel_td_exit01_plr;
  level.scr_anim["player_rig"]["rappel_exit_up"] = % twr_global_rappel_tu_exit01_plr;
  addnotetrack_customfunction("player_rig", "dt_misc_coiled_rope,tag_accessory_left", &function_3a0d948c3bc05c29, "rappel1_enter");
}

#using_animtree("generic_human");

function generic_human() {
  level.scr_anim["guy"]["IW7_cp_minicrab_stand_melee_l"] = % iw7_cp_minicrab_stand_melee_l;
  level.scr_anim["guy"]["IW7_cp_minicrab_stand_melee_r"] = % iw7_cp_minicrab_stand_melee_r;
  level.scr_anim["guy"]["IW7_cp_sasquatch_stand_melee_01"] = % iw7_cp_sasquatch_stand_melee_01;
  level.scr_anim["guy"]["IW7_cp_sasquatch_stand_melee_02"] = % iw7_cp_sasquatch_stand_melee_02;
  level.scr_anim["guy"]["vip_0000_riot_temp_melee_loop_01"] = % vip_0000_riot_temp_melee_loop_01;
  level.scr_anim["guy"]["vip_0000_riot_temp_melee_loop_02"] = % vip_0000_riot_temp_melee_loop_02;
  level.scr_anim["guy"]["vip_0000_riot_temp_melee_loop_01_loop"][0] = % vip_0000_riot_temp_melee_loop_01;
  level.scr_anim["guy"]["emb_oc_020_doorkick_alq_idle"] = % emb_oc_020_doorkick_alq_idle;
  level.scr_anim["guy"]["ph_parade_un_cheering_04"] = % ph_parade_un_cheering_04;
  level.scr_anim["guy"]["ph_parade_un_cheering_06"] = % ph_parade_un_cheering_06;
  level.scr_anim["guy"]["ph_parade_un_cheering_07"] = % ph_parade_un_cheering_07;
  level.scr_anim["Makarov"]["slide_makarov"] = % vip_exfil_slide_01;
  level.scr_anim["ally1"]["slide_ivan"] = % vip_exfil_slide_02;
  level.scr_anim["guard"]["makarov_flashbang_idle"][0] = % emb_oc_020_doorkick_alq_idle;
  level.scr_anim["prisoner"]["makarov_flashbang_idle"][0] = % civ_cap_cower03_prone_exposed_idle @1;
  level.scr_anim["generic"]["civ_vip_interaction_baton_grapple_a_guard"][0] = % civ_vip_interaction_baton_grapple_a_guard @1;
  level.scr_anim["generic"]["civ_vip_interaction_baton_grapple_a_prisoner"][0] = % civ_vip_interaction_baton_grapple_a_prisoner @1;
  level.scr_anim["generic"]["civ_vip_interaction_baton_grapple_b_guard"][0] = % civ_vip_interaction_baton_grapple_b_guard @1;
  level.scr_anim["generic"]["civ_vip_interaction_baton_grapple_b_prisoner"][0] = % civ_vip_interaction_baton_grapple_b_prisoner @1;
  level.scr_anim["guy"]["civ_cap_cower03_prone_exposed_idle"][0] = % civ_cap_cower03_prone_exposed_idle @1;
  level.scr_anim["searchlights_officer"]["alarmed_signal"] = % est_cy_enemy_alarmed02;
  level.scr_anim["patrol_idle"]["conversation01"]["intro"] = % sdr_stl_patrol_stand_conversation01_start;
  level.scr_anim["patrol_idle"]["conversation01"]["loop"] = % sdr_stl_patrol_stand_conversation01_idle;
  level.scr_anim["patrol_idle"]["conversation01"]["exit"] = % sdr_stl_patrol_stand_conversation01_end;
  level.scr_anim["patrol_idle"]["conversation01"]["react"] = 0;
  level.scr_anim["patrol_idle"]["conversation02"]["intro"] = % sdr_stl_patrol_stand_conversation02_start;
  level.scr_anim["patrol_idle"]["conversation02"]["loop"] = % sdr_stl_patrol_stand_conversation02_idle;
  level.scr_anim["patrol_idle"]["conversation02"]["exit"] = % sdr_stl_patrol_stand_conversation02_end;
  level.scr_anim["patrol_idle"]["conversation02"]["react"] = 0;
  level.scr_anim["patrol_idle"]["smoking_01"]["intro"] = % grd_stl_patrol_stand_smoking_start;
  level.scr_anim["patrol_idle"]["smoking_01"]["loop"] = % grd_stl_patrol_stand_smoking_idle;
  level.scr_anim["patrol_idle"]["smoking_01"]["exit"] = % grd_stl_patrol_stand_smoking_end;
  level.scr_anim["patrol_idle"]["smoking_01"]["react"] = 0;
  level.scr_anim["patrol_idle"]["device_medium"]["intro"] = % jup_interaction_patrol_device_medium_right_start;
  level.scr_anim["patrol_idle"]["device_medium"]["loop"] = % jup_interaction_patrol_device_medium_right_loop;
  level.scr_anim["patrol_idle"]["device_medium"]["exit"] = % jup_interaction_patrol_device_medium_right_end;
  level.scr_anim["patrol_idle"]["device_medium"]["react"] = 0;
  level.scr_anim["patrol_idle"]["device_laptop"]["intro"] = % jup_ranch_pmc_investigating_blackbox_start;
  level.scr_anim["patrol_idle"]["device_laptop"]["loop"] = % jup_ranch_pmc_investigating_blackbox_loop;
  level.scr_anim["patrol_idle"]["device_laptop"]["exit"] = % jup_ranch_pmc_investigating_blackbox_end;
  level.scr_anim["patrol_idle"]["device_laptop"]["react"] = 0;
  level.scr_anim["patrol_idle"]["wall_lean"]["intro"] = % sdr_stl_patrol_stand_wall_lean01_start;
  level.scr_anim["patrol_idle"]["wall_lean"]["loop"] = % sdr_stl_patrol_stand_wall_lean01_idle;
  level.scr_anim["patrol_idle"]["wall_lean"]["exit"] = % sdr_stl_patrol_stand_wall_lean01_end;
  level.scr_anim["patrol_idle"]["wall_lean"]["react"] = 0;
  level.scr_anim["patrol_idle"]["distance_look"]["intro"] = % grd_stl_patrol_stand_distance_look01_start;
  level.scr_anim["patrol_idle"]["distance_look"]["loop"] = % grd_stl_patrol_stand_distance_look01_idle;
  level.scr_anim["patrol_idle"]["distance_look"]["exit"] = % grd_stl_patrol_stand_distance_look01_end;
  level.scr_anim["patrol_idle"]["distance_look"]["react"] = 0;
  level.scr_anim["patrol_idle"]["rail_lean"]["intro"] = % sdr_stl_patrol_stand_rail_lean01_start;
  level.scr_anim["patrol_idle"]["rail_lean"]["loop"] = % sdr_stl_patrol_stand_rail_lean01_idle;
  level.scr_anim["patrol_idle"]["rail_lean"]["exit"] = % sdr_stl_patrol_stand_rail_lean01_end;
  level.scr_anim["patrol_idle"]["rail_lean"]["react"] = 0;
  level.scr_anim["patrol_idle"]["rail_look_over"]["intro"] = % sdr_stl_patrol_stand_rail_look_over01_start;
  level.scr_anim["patrol_idle"]["rail_look_over"]["loop"] = % sdr_stl_patrol_stand_rail_look_over01_idle;
  level.scr_anim["patrol_idle"]["rail_look_over"]["exit"] = % sdr_stl_patrol_stand_rail_look_over01_end;
  level.scr_anim["patrol_idle"]["rail_look_over"]["react"] = 0;
  level.scr_anim["patrol_idle"]["humming"]["intro"] = % sdr_stl_patrol_stand_humming01_start;
  level.scr_anim["patrol_idle"]["humming"]["loop"] = % sdr_stl_patrol_stand_humming01_idle;
  level.scr_anim["patrol_idle"]["humming"]["exit"] = % sdr_stl_patrol_stand_humming01_end;
  level.scr_anim["patrol_idle"]["humming"]["react"] = 0;
  level.scr_anim["patrol_idle"]["radio"]["intro"] = % sdr_stl_patrol_stand_radio01_start;
  level.scr_anim["patrol_idle"]["radio"]["loop"] = % sdr_stl_patrol_stand_radio01_idle;
  level.scr_anim["patrol_idle"]["radio"]["exit"] = % sdr_stl_patrol_stand_radio01_end;
  level.scr_anim["patrol_idle"]["radio"]["react"] = 0;
  level.scr_anim["patrol_idle"]["kneel"]["intro"] = % hm_grnd_grn_kneel_idle_01;
  level.scr_anim["patrol_idle"]["kneel"]["loop"] = % hm_grnd_grn_kneel_idle_01;
  level.scr_anim["patrol_idle"]["kneel"]["exit"] = % hm_grnd_grn_kneel_idle_01;
  level.scr_anim["patrol_idle"]["kneel"]["react"] = 0;
  level.scr_anim["patrol_idle"]["point_test"]["intro"] = % hm_grnd_org_gest_run_point_center;
  level.scr_anim["patrol_idle"]["point_test"]["loop"] = % hm_grnd_org_gest_run_point_center;
  level.scr_anim["patrol_idle"]["point_test"]["exit"] = % hm_grnd_org_gest_run_point_center;
  level.scr_anim["patrol_idle"]["point_test"]["react"] = 0;
  level.scr_anim["patrol_idle"]["alert_to_threat"]["intro"] = % grd_stl_hunt_stand_distance_look_start;
  level.scr_anim["patrol_idle"]["alert_to_threat"]["loop"] = % grd_stl_hunt_stand_distance_look_idle01;
  level.scr_anim["patrol_idle"]["alert_to_threat"]["exit"] = % grd_stl_hunt_stand_distance_look_end;
  level.scr_anim["patrol_idle"]["alert_to_threat"]["react"] = 0;
  level.scr_anim["patrol_idle"]["alert_to_threat_2"]["intro"] = % grd_stl_hunt_stand_distance_look_start;
  level.scr_anim["patrol_idle"]["alert_to_threat_2"]["loop"] = % grd_stl_hunt_stand_distance_look_idle03;
  level.scr_anim["patrol_idle"]["alert_to_threat_2"]["exit"] = % grd_stl_hunt_stand_distance_look_end;
  level.scr_anim["patrol_idle"]["alert_to_threat_2"]["react"] = 0;
  level.scr_anim["patrol_idle"]["alert_to_threat_look_down"]["intro"] = % grd_stl_hunt_stand_look_into_water_start;
  level.scr_anim["patrol_idle"]["alert_to_threat_look_down"]["loop"] = % grd_stl_hunt_stand_look_into_water_idle01;
  level.scr_anim["patrol_idle"]["alert_to_threat_look_down"]["exit"] = % grd_stl_hunt_stand_look_into_water_end;
  level.scr_anim["patrol_idle"]["alert_to_threat_look_down"]["react"] = 0;
  level.scr_anim["patrol_idle"]["calm_down"]["intro"] = % london_police_wave_1;
  level.scr_anim["patrol_idle"]["calm_down"]["loop"] = % london_police_wave_1;
  level.scr_anim["patrol_idle"]["calm_down"]["exit"] = % london_police_wave_1;
  level.scr_anim["patrol_idle"]["calm_down"]["react"] = 0;
  level.scr_anim["patrol_idle"]["alarmed_radio"]["intro"] = % est_cy_enemy_alarmed01;
  level.scr_anim["patrol_idle"]["alarmed_radio"]["loop"] = % est_cy_enemy_alarmed01;
  level.scr_anim["patrol_idle"]["alarmed_radio"]["exit"] = % est_cy_enemy_alarmed01;
  level.scr_anim["patrol_idle"]["alarmed_radio"]["react"] = 0;
  level.scr_anim["patrol_idle"]["alarmed_talk"]["intro"] = % est_cy_enemy_alarmed02;
  level.scr_anim["patrol_idle"]["alarmed_talk"]["loop"] = % est_cy_enemy_alarmed02;
  level.scr_anim["patrol_idle"]["alarmed_talk"]["exit"] = % est_cy_enemy_alarmed02;
  level.scr_anim["patrol_idle"]["alarmed_talk"]["react"] = 0;
  level.scr_anim["patrol_idle"]["alarmed_order"]["intro"] = % est_cy_enemy_alarmed03;
  level.scr_anim["patrol_idle"]["alarmed_order"]["loop"] = % est_cy_enemy_alarmed03;
  level.scr_anim["patrol_idle"]["alarmed_order"]["exit"] = % est_cy_enemy_alarmed03;
  level.scr_anim["patrol_idle"]["alarmed_order"]["react"] = 0;
  level.scr_anim["patrol_idle"]["binoc_search"]["intro"] = % t10_xtr_rooftop_fidget_searching_guard02;
  level.scr_anim["patrol_idle"]["binoc_search"]["loop"] = % t10_xtr_rooftop_fidget_searching_guard02;
  level.scr_anim["patrol_idle"]["binoc_search"]["exit"] = % t10_xtr_rooftop_fidget_searching_guard02;
  level.scr_anim["patrol_idle"]["binoc_search"]["react"] = 0;
  level.scr_anim["generic"]["nvg_on"] = % sdr_ges_nvg_lower;
  level.scr_anim["generic"]["nvg_off"] = % sdr_ges_nvg_raise;
  level.scr_anim["patrol_idle"]["scared_guard_cower"]["intro"] = % civ_cap_panic03_stand_exposed_to_cower04 @1;
  level.scr_anim["patrol_idle"]["scared_guard_cower"]["loop"] = % civ_cap_cower04_prone_exposed_idle @1;
  level.scr_anim["patrol_idle"]["scared_guard_cower"]["exit"] = % civ_cap_cower04_prone_exposed_idle @1;
  level.scr_anim["patrol_idle"]["scared_guard_cower"]["react"] = 0;
  level.scr_anim["patrol_idle"]["scared_guard_kneel"]["intro"] = % civ_cap_group01_guy01_relax_exposed_stand_to_panic_8 @1;
  level.scr_anim["patrol_idle"]["scared_guard_kneel"]["loop"] = % civ_cap_group01_guy01_stand_panic_idle_8 @1;
  level.scr_anim["patrol_idle"]["scared_guard_kneel"]["exit"] = % civ_cap_group01_guy01_stand_panic_idle_8 @1;
  level.scr_anim["patrol_idle"]["scared_guard_kneel"]["react"] = 0;
  level.scr_anim["patrol_idle"]["scared_guard_stand"]["intro"] = % civ_cap_curious01_stand_exposed_to_panic01 @1;
  level.scr_anim["patrol_idle"]["scared_guard_stand"]["loop"] = % civ_cap_panic01_stand_exposed_idle @1;
  level.scr_anim["patrol_idle"]["scared_guard_stand"]["exit"] = % civ_cap_panic01_stand_exposed_idle @1;
  level.scr_anim["patrol_idle"]["scared_guard_stand"]["react"] = 0;
  level.scr_anim["guy"]["prisoner_truck_idle"][0] = % sh_pri_7_1_return_male_a_idle;
  level.scr_anim["guy"]["prisoner_kneel_idle"][0] = % estate_prisoner_tied_idle02;
  level.scr_anim["guy"]["grd_stl_patrol_stand_smoking_idle01"][0] = % grd_stl_patrol_stand_smoking_idle01;
  level.scr_anim["guy"]["grd_stl_patrol_stand_radio01_idle"][0] = % grd_stl_patrol_stand_radio01_idle;
  level.scr_anim["guy"]["sdr_hostage_holdup03_guard_idle"][0] = % sdr_hostage_holdup03_guard_idle;
  level.scr_anim["guy"]["sdr_hostage_holdup01_guard_idle"][0] = % sdr_hostage_holdup01_guard_idle;
  level.scr_anim["guy"]["hm_grnd_yel_patrol_repairwallunit_loop"][0] = % hm_grnd_yel_patrol_repairwallunit_loop;
  level.scr_anim["guy"]["reb_smtobj_look_high_loop_alt"][0] = % reb_smtobj_look_high_loop_alt;
  level.scr_anim["guy"]["emb_truck_010_attack_react_ally02"] = % emb_truck_010_attack_react_ally02;
  level.scr_anim["guy"]["est_cy_enemy_alarmed01"] = % est_cy_enemy_alarmed01;
  level.scr_anim["guy"]["est_cy_enemy_alarmed02"] = % est_cy_enemy_alarmed02;
  level.scr_anim["guy"]["sdr_hostage_holdup01_guard_idle"][0] = % sdr_hostage_holdup01_guard_idle;
  level.scr_anim["guy"]["reb_stl_patrol_flash_idle_react_lg_up"] = % reb_stl_patrol_flash_idle_react_lg_up;
  level.scr_anim["guy"]["grd_stl_patrol_stand_radio01_idle"][0] = % grd_stl_patrol_stand_radio01_idle;
  level.scr_anim["guy"]["emb_truck_010_attack_react_ally01"] = % emb_truck_010_attack_react_ally01;
  level.scr_anim["guy"]["sdr_com_cover_right_crouch_to_exposed_stand01_6"] = % sdr_com_cover_right_crouch_to_exposed_stand01_6;
  level.scr_anim["guy"]["reb_stl_patrol_flash_idle_react_lg_8"] = % reb_stl_patrol_flash_idle_react_lg_8;
  level.scr_anim["guy"]["iw9_veh_bed_lowcrouch_reaction_friendlyfire_6"] = % iw9_veh_bed_lowcrouch_reaction_friendlyfire_6;
  level.scr_anim["guy"]["enemy_truck_idle"][0] = % reb_vh_techo_bed_guy1_idle_search01;
  level.scr_anim["guy"]["enemy_truck_idle"][0] = % reb_vh_techo_bed_guy1_idle_search02;
  level.scr_anim["guy"]["enemy_truck_idle"][0] = % reb_vh_techo_bed_guy1_idle_search03;
  level.scr_anim["ally1"]["ally_smoke_grenade_throw"] = % sdr_com_cover_right_crouch_hide_grenade_flash;
  level.scr_anim["ally2"]["ally_smoke_grenade_throw"] = % sdr_com_cover_right_crouch_hide_grenade_flash;
  level.scr_anim["guy"]["courtyard_prisoner_runner_stumble_01"] = % sdr_com_strafe_run_stumble_veerright01;
  level.scr_anim["guy"]["courtyard_prisoner_runner_stumble_02"] = % sdr_com_strafe_run_stumble_veerright02;
  level.scr_anim["guy"]["courtyard_prisoner_runner_stumble_03"] = % sdr_com_strafe_run_stumble_veerright03;
  level.scr_anim["guy"]["courtyard_prisoner_runner_stumble_04"] = % sdr_com_strafe_run_stumble_veerleft01;
  level.scr_anim["guy"]["courtyard_prisoner_runner_stumble_05"] = % sdr_com_strafe_run_stumble_veerleft02;
  level.scr_anim["guy"]["courtyard_prisoner_runner_stumble_06"] = % sdr_com_strafe_run_stumble_veerleft03;
  level.scr_anim["guy"]["courtyard_prisoner_weapon_grab"] = % prn_1100_2nd_cell_breach_male05;
  level.scr_anim["guy"]["shipcrib_moon_injured_drag03_guyb_idle_01"][0] = % shipcrib_moon_injured_drag03_guyb_idle_01;
  level.scr_anim["guy"]["twr_dead_civ_male_prone_02"][0] = % twr_dead_civ_male_prone_02;
  level.scr_anim["guy"]["bdr_2200_stash_migrants_dead_idle_guy01"][0] = % bdr_2200_stash_migrants_dead_idle_guy01;
  level.scr_anim["guy"]["shipcrib_moon_injured_drag01_guyc_idle_01"][0] = % shipcrib_moon_injured_drag01_guyc_idle_01;
  level.scr_anim["guy"]["courtyard_arrive_scene_protector_idle"][0] = % est_cy_enemy_alarmed02;
  level.scr_anim["guy"]["courtyard_arrive_scene_protector_death"] = % hm_grnd_red_exposed_death_shoulder_falls_2_ar;
  level.scr_anim["guy"]["courtyard_arrive_scene_medic"][0] = % nwr_0500_heli_rescue_intro_idle_medic;
  level.scr_anim["Makarov"]["exposed_enter"] = % jup_vip_mak_stand_exposed_enter;
  level.scr_anim["Makarov"]["exposed_exit"] = % jup_vip_mak_stand_exposed_exit;
  level.scr_anim["Makarov"]["exposed_combat"] = % jup_vip_mak_stand_exposed_to_combat;
  level.scr_anim["Makarov"]["exposed_idle"][0] = % jup_vip_mak_stand_exposed_idle;
  level.scr_anim["Makarov"]["exposed_idle1"] = % jup_vip_mak_stand_exposed_twitch_a;
  level.scr_anim["Makarov"]["exposed_idle2"] = % jup_vip_mak_stand_exposed_twitch_b;
  level.scr_anim["Makarov"]["exposed_idle3"] = % jup_vip_mak_stand_exposed_twitch_c;
  level.scr_anim["Makarov"]["exposed_idle4"] = % jup_vip_mak_stand_exposed_twitch_d;
  level.scr_anim["Makarov"]["exposed_idle5"] = % jup_vip_mak_stand_exposed_twitch_e;
  level.scr_anim["Makarov"]["exposed_idle6"] = % jup_vip_mak_stand_exposed_twitch_f;
  level.scr_anim["Makarov"]["exposed_idle7"] = % jup_vip_mak_stand_exposed_twitch_g;
  level.scr_anim["Makarov"]["exposed_idle8"] = % jup_vip_mak_stand_exposed_twitch_h;
  level.scr_anim["Makarov"]["exposed_idle9"] = % jup_vip_mak_stand_exposed_twitch_i;
  level.scr_anim["Makarov"]["exposed_idle10"] = % jup_vip_mak_stand_exposed_twitch_j;
  level.scr_anim["Makarov"]["exposed_idle11"] = % jup_vip_mak_stand_exposed_twitch_k;
  level.scr_anim["ally1"]["elevator_nag_1"] = % vip_1300_elevator_makarov_nag1_ivan_face;
  level.scr_anim["ally1"]["elevator_nag_2"] = % vip_1300_elevator_makarov_nag2_ivan_face;
  level.scr_anim["ally1"]["elevator_nag_3"] = % vip_1300_elevator_makarov_nag3_ivan_face;
  level.scr_anim["ally1"]["elevator_nag_4"] = % vip_1300_elevator_makarov_nag4_ivan_face;
  level.scr_animtree["pilot"] = #animtree;
  level.scr_model["pilot"] = "fullbody_sp_ally_pilot_western_vm";
  level.scr_anim["pilot"]["reb_vh_palfa_driver_idle_search01"][0] = % reb_vh_palfa_driver_idle_search01;
}

#using_animtree("script_model");

function scriptmodels() {
  short_rope = "short_rope";
  level.scr_model[short_rope] = "medium_rappel_clip_rope";
  level.scr_animtree[short_rope] = #animtree;
  level.scr_anim[short_rope]["rappel1_enter"] = % twr_0100_rooftop_rappel_scene_rope01;
  dangling_rope = "dangling_rope";
  level.scr_model[dangling_rope] = "misc_rapelling_rope_sim_fiber_short";
  level.scr_animtree[dangling_rope] = #animtree;
}

function function_3a0d948c3bc05c29(ent) {
  self.rope show();
}

#using_animtree("player_rappel_rig");

function rappel_rig() {
  anime = "rappel1_enter";
  rig = "player_rappel_rig";
  level.scr_animtree[rig] = #animtree;
  level.scr_model[rig] = "viewmodel_fullbody_sp_soap_nightwar";
  level.scr_anim[rig][anime] = % twr_0100_rooftop_rappel_scene_plr;
  addnotetrack_customfunction(rig, "dt_misc_coiled_rope,tag_accessory_left", &function_3a0d948c3bc05c29, anime);
  level.scr_anim[rig]["root"] = % root;
  anime = "toeup_idle";
  level.scr_anim[rig][anime][0] = % twr_global_rappel_tu_idle01;
  level.scr_anim[rig][anime][1] = % twr_global_rappel_tu_idle02;
  level.scr_anim[rig][anime][2] = % twr_global_rappel_tu_idle03;
  anime = "toedown_idle";
  level.scr_anim[rig][anime][0] = % twr_global_rappel_td_idle01;
  level.scr_anim[rig][anime][1] = % twr_global_rappel_td_idle02;
  level.scr_anim[rig][anime][2] = % twr_global_rappel_td_idle03;
  anime = "rappel2_enter";
  level.scr_anim[rig][anime] = % twr_0450_floor_a_rappel_scene_plr;
  anime = "toedown_turnleft";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_inplace_turn_l;
  anime = "toedown_turnright";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_inplace_turn_r;
  anime = "toeup_turnleft";
  level.scr_anim[rig][anime] = % twr_global_rappel_tu_inplace_turn_l;
  anime = "toeup_turnright";
  level.scr_anim[rig][anime] = % twr_global_rappel_tu_inplace_turn_r;
  anime = "toedown_jump";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_jump_inplace_takeoff;
  anime = "toedown_jump_inair";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_jump_inplace_air;
  anime = "toedown_jump_land";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_jump_inplace_land;
  anime = "toeup_jump";
  level.scr_anim[rig][anime] = % twr_global_rappel_tu_jump_inplace_takeoff;
  anime = "toeup_jump_inair";
  level.scr_anim[rig][anime] = % twr_global_rappel_tu_jump_inplace_air;
  anime = "toeup_jump_land";
  level.scr_anim[rig][anime] = % twr_global_rappel_tu_jump_inplace_land;
  anime = "breach_swing";
  level.scr_anim[rig][anime] = % twr_global_rappel_tu_swing_exit01_plr;
  anime = "toedown_breach_jump_left";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_jump_takeoff_l;
  anime = "toedown_breach_jump_right";
  level.scr_anim[rig][anime] = % twr_global_rappel_td_jump_takeoff_r;
}