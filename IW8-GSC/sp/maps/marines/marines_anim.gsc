/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_anim.gsc
***********************************************/

main() {
  player_anims();
  generic_human_anims();
  vehicles();
  script_models();
  fake_actor_anims();
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  level.scr_anim["player_rig"]["vig_acquire_takedown_right"] = % mar_hos_wolfroom_breach_takedown_plr;
  level.scr_anim["player_rig"]["introSequence"] = % mar_intro_010_dropoff_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_scale_factor_override", ::intro_remove_fov_scale_factor_override, "introSequence");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "air_vehicles_distant", scripts\sp\maps\marines\marines_background.gsc::air_vehicles_distant, "introSequence");
}

#using_animtree("generic_human");

fake_actor_anims() {
  level.scr_anim["generic"]["hm_grnd_yel_patrol_idle_scan_guncheck01_ar"][0] = % hm_grnd_yel_patrol_idle_scan_guncheck01_ar;
  level.scr_anim["generic"]["hm_grnd_yel_patrol_idle_radio01_ar"][0] = % hm_grnd_yel_patrol_idle_radio01_ar;
}

generic_human_anims() {
  level.scr_anim["window_civ"]["windowOpen1"] = % mar_con_windowpeek_open_civ01;
  level.scr_anim["window_civ"]["windowIdle1"][0] = % mar_con_windowpeek_idle_civ01;
  level.scr_anim["window_civ"]["windowClose1"] = % mar_con_windowpeek_close_civ01;
  level.scr_anim["window_civ"]["windowOpen2"] = % mar_con_windowpeek_open_civ02;
  level.scr_anim["window_civ"]["windowIdle2"][0] = % mar_con_windowpeek_idle_civ02;
  level.scr_anim["window_civ"]["windowClose2"] = % mar_con_windowpeek_close_civ02;
  level.scr_anim["window_civ"]["windowOpen3"] = % mar_con_windowpeek_open_civ03;
  level.scr_anim["window_civ"]["windowIdle3"][0] = % mar_con_windowpeek_idle_civ03;
  level.scr_anim["window_civ"]["windowClose3"] = % mar_con_windowpeek_close_civ03;
  level.scr_anim["roof_civ"]["roofLeanEnter"] = % est_ma_030_window_enter_enemy01;
  level.scr_anim["roof_civ"]["roofLeanIdle"][0] = % est_ma_030_window_idle_enemy01;
  level.scr_anim["roof_civ"]["roofLeanExit"] = % est_ma_030_window_exit_enemy01;
  level.scr_anim["phone_civ0"]["phoneEnter"] = % mar_amb_intro_cellphone_talk_01_civ01;
  level.scr_anim["phone_civ0"]["phoneIdle"][0] = % mar_amb_intro_cellphone_recording_idle_01_civ01;
  level.scr_anim["phone_civ0"]["phoneExit"] = % mar_amb_intro_cellphone_back_away_01_civ01;
  level.scr_anim["phone_civ1"]["phoneEnter"] = % mar_amb_intro_cellphone_talk_02_civ01;
  level.scr_anim["phone_civ1"]["phoneIdle"][0] = % mar_amb_intro_cellphone_recording_idle_02_civ01;
  level.scr_anim["phone_civ1"]["phoneExit"] = % mar_amb_intro_cellphone_back_away_02_civ01;
  level.scr_anim["fake_player"]["MAR_intro_010_dropoff_alex"] = % mar_intro_010_dropoff_alex;
  level.scr_anim["farah"]["introSequence"] = % mar_intro_010_dropoff_farah;
  level.scr_anim["hadir"]["introSequence"] = % mar_intro_010_dropoff_hadir;
  level.scr_anim["driver"]["introSequence"] = % mar_intro_010_dropoff_driver;
  level.scr_anim["marine05"]["introSequence"] = % mar_intro_010_dropoff_marine1;
  level.scr_anim["marine06"]["introSequence"] = % mar_intro_010_dropoff_marine2;
  level.scr_anim["marine03"]["introSequence"] = % mar_intro_010_dropoff_marine3;
  level.scr_anim["gateGuy"]["introSequence"] = % mar_intro_010_dropoff_gateguy;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %mar_intro_010_dropoff_farah_face, "introSequence");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %mar_intro_010_dropoff_farah_face, "introSequence");
  scripts\common\anim::addnotetrack_mayhemstart("hadir", "mayhem_start", %mar_intro_010_dropoff_hadir_face, "introSequence");
  scripts\common\anim::addnotetrack_mayhemend("hadir", "mayhem_end", %mar_intro_010_dropoff_hadir_face, "introSequence");
  scripts\common\anim::addnotetrack_mayhemstart("fake_player", "mayhem_start", %mar_intro_010_dropoff_alex_face, "introSequence");
  scripts\common\anim::addnotetrack_mayhemend("fake_player", "mayhem_end", %mar_intro_010_dropoff_alex_face, "introSequence");
  level.scr_anim["marine_scout01"]["rooftop_idle"][0] = % hod_assassinate_rooftop_idle_scout01;
  level.scr_anim["marine_scout02"]["rooftop_idle"][0] = % hod_assassinate_rooftop_idle_scout02;
  level.scr_anim["intro_marine"]["convoy_advance"] = % hm_grnd_yel_patrol_idle_radio01_ar;
  level.scr_anim["intro_marine"]["convoy_idle"][0] = % hm_grnd_yel_patrol_idle04_ar;
  level.scr_face["griggs"]["dx_vom_grg_intro_street_10"] = % dx_vom_grg_intro_street_10_face;
  level.scr_face["griggs"]["dx_vom_grg_igc_intro_200"] = % dx_vom_grg_igc_intro_200_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_street_50"] = % dx_vom_grg_intro_street_50_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_tripwires_40"] = % dx_vom_grg_intro_tripwires_40_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_tripwires_30"] = % dx_vom_grg_intro_tripwires_30_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_tripwires_20"] = % dx_vom_grg_intro_tripwires_20_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_street_11"] = % dx_vom_grg_intro_street_11_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_street_30"] = % dx_vom_grg_intro_street_30_face;
  level.scr_face["griggs"]["dx_vom_grg_intro_street_11"] = % dx_vom_grg_intro_street_11_face;
  level.scr_face["griggs"]["dx_vom_grg_retreat_hospital_90"] = % dx_vom_grg_retreat_hospital_90_face;
  level.scr_face["griggs"]["dx_vom_grg_lobby_entrance_40"] = % dx_vom_grg_lobby_entrance_40_face;
  level.scr_face["griggs"]["dx_vom_grg_retreat_helos_40"] = % dx_vom_grg_retreat_helos_40_face;
  level.scr_face["griggs"]["dx_vom_grg_retreat_helos_60"] = % dx_vom_grg_retreat_helos_60_face;
  level.scr_face["griggs"]["dx_vom_grg_groundfloor_door_30"] = % dx_vom_grg_groundfloor_door_30_face;
  level.scr_face["griggs"]["dx_vom_grg_civ_ambush_save_10"] = % dx_vom_grg_civ_ambush_save_10_face;
  level.scr_face["griggs"]["dx_vom_grg_mg_hall_tripwires_20"] = % dx_vom_grg_mg_hall_tripwires_20_face;
  level.scr_face["griggs"]["dx_vom_grg_mg_hall_assault_10"] = % dx_vom_grg_mg_hall_assault_10_face;
  level.scr_face["griggs"]["dx_vom_grg_civ_ambush_triage_60"] = % dx_vom_grg_civ_ambush_triage_60_face;
  level.scr_face["griggs"]["dx_vom_grg_civ_ambush_corridor_60"] = % dx_vom_grg_civ_ambush_corridor_60_face;
  level.scr_face["griggs"]["dx_vom_grg_wolf_capture_20"] = % dx_vom_grg_wolf_capture_20_face;
  level.scr_anim["convoy_runner_relaxed"]["runner_idle"][0] = % hm_grnd_yel_patrol_idle04_ar;
  level.scr_anim["convoy_runner_lookaround"]["runner_idle"][0] = % mar_amb_exposed_idle_lookaround_upwards;
  level.scr_anim["convoy_runner_relaxed"]["runner_death_back"] = % death_explosion_run_b_v2;
  level.scr_anim["convoy_runner_lookaround"]["runner_death_back"] = % death_explosion_run_b_v2;
  level.scr_anim["convoy_runner_relaxed"]["runner_death_right"] = % death_explosion_run_r_v1;
  level.scr_anim["convoy_runner_lookaround"]["runner_death_right"] = % death_explosion_run_r_v1;
  level.scr_anim["griggs"]["introSequence"] = % mar_intro_010_dropoff_griggs;
  scripts\common\anim::addnotetrack_flag("griggs", "griggs_nag_spoken", "griggs_vo_line_spoken", "introSequence");
  level.scr_anim["marine02"]["ambush_ied"] = % mar_con_010_ambush_ied_pinned_marine02;
  level.scr_anim["marine02"]["ambush_ied_idle"][0] = % mar_con_010_ambush_ied_idle_pinned_marine02;
  level.scr_anim["griggs"]["blindfire"] = % sdr_com_cover_left_couch_blindfire02;
  level.scr_anim["react_marine_01"]["mg_react"] = % mar_hos_010_mg_react04_marine;
  level.scr_anim["react_marine_02"]["mg_react"] = % mar_hos_010_mg_react02_marine;
  level.scr_anim["react_marine_03"]["mg_react"] = % mar_hos_010_mg_react03_marine;
  level.scr_anim["dead_body"]["generic_dead_wall_lean_civ_03"] = % generic_dead_wall_lean_civ_03;
  level.scr_anim["dead_body"]["generic_dead_civ_fem_03"] = % generic_dead_civ_fem_03;
  level.scr_anim["kitchen_aq"]["kitchen_ambush"] = % hm_grnd_org_cover_left_crouch_blindfire01_ar;
  scripts\common\anim::addnotetrack_customfunction("wounded_drag_enemy_1", "start_shooting", ::wounded_drag_shoot, "wounded_drag_hit");
  scripts\common\anim::addnotetrack_customfunction("wounded_drag_enemy_1", "draw_pistol", ::wounded_drag_pistol_swap, "wounded_drag");
  level.scr_anim["aq_ambusher"]["hallway_ambush"] = % corner_standl_rambo_set;
  level.scr_anim["dead_body"]["corner_standr_death_grenade_explode"] = % corner_standr_death_grenade_explode;
  level.scr_anim["dead_body"]["europa_storage_room_sdf_crawl_01_death"] = % europa_storage_room_sdf_crawl_01_death;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim_Child4"] = % htf_esc_010_gasvictim_child4;
  level.scr_anim["dead_body"]["mar_hos_bed_laying_idle_civ02"] = % mar_hos_bed_laying_idle_civ02;
  level.scr_anim["dead_body"]["mar_hos_bed_laying_idle_civ01"] = % mar_hos_bed_laying_idle_civ01;
  level.scr_anim["dead_body"]["mar_hos_bed_laying_idle_civ03"] = % mar_hos_bed_laying_idle_civ03;
  level.scr_anim["bed_decoy"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_decoy01;
  level.scr_anim["bed_decoy"]["bed_gungrab"] = % mar_hos_bed_gungrab_decoy01;
  level.scr_anim["bed_decoy"]["bed_gungrab_idle"][0] = % mar_hos_bed_gungrab_idle_decoy01;
  level.scr_anim["bed_decoy"]["bed_death"] = % mar_hos_bed_death_decoy01;
  level.scr_anim["bed_decoy"]["bed_death_b"] = % mar_hos_bed_death_b_decoy01;
  var_0 = 0.2;
  level.scr_goaltime["bed_decoy"]["bed_laying_idle"] = var_0;
  level.scr_goaltime["bed_decoy"]["bed_gungrab"] = var_0;
  level.scr_goaltime["bed_decoy"]["bed_gungrab_idle"] = var_0;
  level.scr_goaltime["bed_decoy"]["bed_death"] = var_0;
  level.scr_goaltime["bed_decoy"]["bed_death_b"] = var_0;
  level.scr_anim["generic"]["rpg_stand_death"] = % rpg_stand_death;
  level.scr_face["griggs"]["dx_vom_grg_hospital_regroup_10_face"] = % dx_vom_grg_hospital_regroup_10_face;
  level.scr_anim["bed_civ_1"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ01;
  level.scr_anim["bed_civ_1"]["bed_laying_flinch"] = % mar_hos_bed_laying_flinch_civ01;
  level.scr_anim["bed_civ_1"]["bed_handsup"] = % mar_hos_bed_handsup_civ01;
  level.scr_anim["bed_civ_1"]["bed_handsup_idle"][0] = % mar_hos_bed_handsup_idle_civ01;
  level.scr_anim["bed_civ_1"]["bed_handsup_flinch_a"] = % mar_hos_bed_handsup_flinch_a_civ01;
  level.scr_anim["bed_civ_1"]["bed_handsup_flinch_b"] = % mar_hos_bed_handsup_flinch_b_civ01;
  level.scr_anim["bed_civ_1"]["bed_death"] = % mar_hos_bed_handsup_death_civ01;
  level.scr_anim["bed_civ_1"]["bed_handsup2laying"] = % mar_hos_bed_handsup2laying_civ01;
  level.scr_anim["bed_civ_2"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ02;
  level.scr_anim["bed_civ_2"]["bed_laying_flinch"] = % mar_hos_bed_laying_flinch_civ02;
  level.scr_anim["bed_civ_2"]["bed_handsup"] = % mar_hos_bed_handsup_civ02;
  level.scr_anim["bed_civ_2"]["bed_handsup_idle"][0] = % mar_hos_bed_handsup_idle_civ02;
  level.scr_anim["bed_civ_2"]["bed_handsup_flinch_a"] = % mar_hos_bed_handsup_flinch_a_civ02;
  level.scr_anim["bed_civ_2"]["bed_handsup_flinch_b"] = % mar_hos_bed_handsup_flinch_b_civ02;
  level.scr_anim["bed_civ_2"]["bed_death"] = % mar_hos_bed_handsup_death_civ02;
  level.scr_anim["bed_civ_2"]["bed_handsup2laying"] = % mar_hos_bed_handsup2laying_civ02;
  level.scr_anim["bed_civ_3"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ03;
  level.scr_anim["bed_civ_3"]["bed_laying_flinch"] = % mar_hos_bed_laying_flinch_civ03;
  level.scr_anim["bed_civ_3"]["bed_handsup"] = % mar_hos_bed_handsup_civ03;
  level.scr_anim["bed_civ_3"]["bed_handsup_idle"][0] = % mar_hos_bed_handsup_idle_civ03;
  level.scr_anim["bed_civ_3"]["bed_handsup_flinch_a"] = % mar_hos_bed_handsup_flinch_a_civ03;
  level.scr_anim["bed_civ_3"]["bed_handsup_flinch_b"] = % mar_hos_bed_handsup_flinch_b_civ03;
  level.scr_anim["bed_civ_3"]["bed_death"] = % mar_hos_bed_handsup_death_civ03;
  level.scr_anim["bed_civ_3"]["bed_handsup2laying"] = % mar_hos_bed_handsup2laying_civ03;
  level.scr_anim["bed_civ_4"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ04;
  level.scr_anim["bed_civ_4"]["bed_laying_flinch_a"] = % mar_hos_bed_laying_flinch_a_civ04;
  level.scr_anim["bed_civ_4"]["bed_laying_flinch_b"] = % mar_hos_bed_laying_flinch_b_civ04;
  level.scr_anim["bed_civ_4"]["bed_death"] = % mar_hos_bed_laying_death_civ04;
  level.scr_anim["bed_civ_5"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ05;
  level.scr_anim["bed_civ_5"]["bed_laying_flinch_a"] = % mar_hos_bed_laying_flinch_a_civ05;
  level.scr_anim["bed_civ_5"]["bed_laying_flinch_b"] = % mar_hos_bed_laying_flinch_b_civ05;
  level.scr_anim["bed_civ_5"]["bed_death"] = % mar_hos_bed_laying_death_civ05;
  level.scr_anim["bed_civ_6"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ06;
  level.scr_anim["bed_civ_6"]["bed_laying_flinch_a"] = % mar_hos_bed_laying_flinch_a_civ06;
  level.scr_anim["bed_civ_6"]["bed_laying_flinch_b"] = % mar_hos_bed_laying_flinch_b_civ06;
  level.scr_anim["bed_civ_6"]["bed_death"] = % mar_hos_bed_laying_death_civ06;
  level.scr_anim["bed_civ_7"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ07;
  level.scr_anim["bed_civ_7"]["bed_laying_flinch_a"] = % mar_hos_bed_laying_flinch_a_civ07;
  level.scr_anim["bed_civ_7"]["bed_laying_flinch_b"] = % mar_hos_bed_laying_flinch_b_civ07;
  level.scr_anim["bed_civ_7"]["bed_death"] = % mar_hos_bed_laying_death_civ07;
  level.scr_anim["bed_civ_8"]["bed_laying_idle"][0] = % mar_hos_bed_laying_idle_civ08;
  scripts\common\anim::addnotetrack_customfunction("bed_decoy", "decoy_death_b", ::set_deathanim_bed_death, "bed_gungrab");
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim1"] = % htf_esc_010_gasvictim1;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim2"] = % htf_esc_010_gasvictim2;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim3"] = % htf_esc_010_gasvictim3;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim4"] = % htf_esc_010_gasvictim4;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim5"] = % htf_esc_010_gasvictim5;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim_Child11"] = % htf_esc_010_gasvictim_child11;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim_Child1"] = % htf_esc_010_gasvictim_child1;
  level.scr_anim["dead_body"]["mar_hos_bed_laying_idle_civ04"] = % mar_hos_bed_laying_idle_civ04;
  level.scr_anim["dead_body"]["mar_hos_bed_laying_idle_civ08"] = % mar_hos_bed_laying_idle_civ08;
  level.scr_anim["generic"]["civ_stl_exposed_crouch_hide_idle03"][0] = % civ_stl_exposed_crouch_hide_idle03;
  level.scr_anim["dead_body"]["generic_dead_wall_lean_civ_03"] = % generic_dead_wall_lean_civ_03;
  var_1 = 0.1;
  level.scr_goaltime["generic"]["mar_hos_mg_hall_crouch_exit_04_aq"] = var_1;
  level.scr_anim["generic"]["mar_hos_mg_hall_crouch_exit_04_aq"] = % mar_hos_mg_hall_crouch_exit_04_aq;
  level.scr_goaltime["generic"]["mar_hos_mg_hall_crouch_exit_06_aq"] = var_1;
  level.scr_anim["generic"]["mar_hos_mg_hall_crouch_exit_06_aq"] = % mar_hos_mg_hall_crouch_exit_06_aq;
  level.scr_anim["generic"]["mar_hos_mg_hall_crouch_idle_02_aq"][0] = % mar_hos_mg_hall_crouch_idle_02_aq;
  level.scr_anim["snakecam03"]["wolf_room_snakecam_enter"] = % mar_hos_wolf_room_snakecam_setup_ally03;
  level.scr_anim["snakecam03"]["wolf_room_snakecam_enter_idle"][0] = % mar_hos_wolf_room_snakecam_setup_idle_ally03;
  level.scr_anim["snakecam03"]["wolf_room_snakecam_exit"] = % mar_hos_wolf_room_snakecam_putaway_ally03;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorPreBreach"][0] = % mar_hos_wolf_room_pre_breach_idle01_ally03;
  level.scr_goaltime["introDoorBreachMarine_01"]["sledgeDoorPreBreach"] = 0.8;
  level.scr_anim["introDoorBreachMarine_02"]["sledgeDoorPreBreach"][0] = % zd30c_000_infil_lbirds_idle_ally13;
  level.scr_goaltime["introDoorBreachMarine_02"]["sledgeDoorPreBreach"] = 0.8;
  level.scr_anim["introDoorBreachMarine_03"]["sledgeDoorPreBreach"][0] = % mar_hos_wolf_room_pre_breach_idle01_ally04;
  level.scr_goaltime["introDoorBreachMarine_03"]["sledgeDoorPreBreach"] = 0.8;
  level.scr_anim["introDoorBreachMarine_04"]["sledgeDoorPreBreach"][0] = % mar_hos_wolf_room_pre_breach_idle01_ally05;
  level.scr_goaltime["introDoorBreachMarine_04"]["sledgeDoorPreBreach"] = 0.8;
  level.scr_anim["introDoorBreachMarine_02"]["sledgeBreach"] = % zd30c_000_infil_lbirds_sledge_ally13_temp;
  level.scr_goaltime["introDoorBreachMarine_02"]["sledgeBreach"] = 0.8;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorPostBreach"][0] = % hm_grnd_yel_patrol_idle04_ar;
  level.scr_anim["introDoorBreachMarine_02"]["sledgeDoorPostBreach"][0] = % hm_grnd_yel_patrol_idle02_ar;
  level.scr_anim["introDoorBreachMarine_03"]["sledgeDoorPostBreach"][0] = % est_search_desk_terry_idle;
  level.scr_anim["introDoorBreachMarine_04"]["sledgeDoorPostBreach"][0] = % hm_grnd_yel_patrol_idle02_ar;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorBreachA"] = % sdr_cqb_shuffle_turn_l_4;
  level.scr_goaltime["introDoorBreachMarine_01"]["sledgeDoorBreachA"] = 0.8;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorBreachB"] = % hm_grnd_cqb_turn_r_4;
  level.scr_goaltime["introDoorBreachMarine_01"]["sledgeDoorBreachB"] = 0.8;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorBreachC"] = % hm_grnd_cqb_stand_to_yel_casual;
  level.scr_goaltime["introDoorBreachMarine_01"]["sledgeDoorBreachC"] = 0.8;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorPostBreachAlt"][0] = % hm_grnd_yel_patrol_idle02_ar;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorPostBreachAlt"][1] = % hm_grnd_yel_patrol_idle04_ar;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorPostBreachAlt"][2] = % hm_grnd_yel_patrol_idle_radio01_ar;
  level.scr_anim["introDoorBreachMarine_01"]["sledgeDoorPostBreachAlt"][3] = % hm_grnd_yel_patrol_idle_scan_guncheck01_ar;
  level.scr_anim["introDoorBreachMarine_04"]["sledgeDoorBreachA"] = % sdr_cqb_shuffle_turn_l_6;
  level.scr_goaltime["introDoorBreachMarine_04"]["sledgeDoorBreachA"] = 0.8;
  level.scr_anim["introDoorBreachMarine_04"]["sledgeDoorBreachB"] = % hm_grnd_cqb_turn_r_6;
  level.scr_goaltime["introDoorBreachMarine_04"]["sledgeDoorBreachB"] = 0.8;
  level.scr_anim["draggedMarine"]["injuredMarineDrag"] = % mar_buddy_down_c_usmc02;
  level.scr_anim["draggingMarine"]["injuredMarineDrag"] = % mar_buddy_down_c_usmc01;
  level.scr_anim["draggedMarine"]["injuredMarineDragIdle"][0] = % thd_3f_020_buddy_down_c_idle_sas02;
  level.scr_anim["draggingMarine"]["injuredMarineDragIdle"][0] = % thd_3f_020_buddy_down_c_idle_sas01;
  var_2 = 0.2;
  level.scr_goaltime["draggedMarine"]["injuredMarineDrag"] = var_2;
  level.scr_goaltime["draggingMarine"]["injuredMarineDrag"] = var_2;
  level.scr_goaltime["draggedMarine"]["injuredMarineDragIdle"] = var_2;
  level.scr_goaltime["draggingMarine"]["injuredMarineDragIdle"] = var_2;
  level.scr_anim["shelfMarine"]["shelfPrePushIdle"][0] = % mar_breach_window_exit_shelf_idle_marine01;
  level.scr_anim["shelfMarine"]["shelfPush"] = % mar_breach_window_exit_shelf_push_marine01;
  level.scr_anim["shelfMarine"]["postPushIdle"][0] = % mar_breach_window_exit_wait_idle_marine01;
  level.scr_anim["shelfMarine"]["windowExitAdvance"] = % mar_breach_window_exit_mantel_marine01;
  level.scr_anim["nonShelfMarineFront"]["shelfPrePushIdle"][0] = % mar_breach_window_exit_wait_idle_marine03;
  level.scr_anim["nonShelfMarineFront"]["twoMarinesWindowExit"] = % mar_breach_window_exit_mantel_marine03;
  level.scr_anim["nonShelfMarineFront"]["twoMarinesWindowOutsideIdle"][0] = % mar_breach_window_exit_cover_idle_marine03;
  level.scr_anim["nonShelfMarineFront"]["windowExitAdvance"] = % mar_breach_window_exit_advance_corner_marine03;
  level.scr_anim["nonShelfMarineBack"]["shelfPrePushIdle"][0] = % mar_breach_window_exit_wait_idle_marine02;
  level.scr_anim["nonShelfMarineBack"]["twoMarinesWindowExit"] = % mar_breach_window_exit_mantel_marine02;
  level.scr_anim["nonShelfMarineBack"]["twoMarinesWindowOutsideIdle"][0] = % mar_breach_window_exit_cover_idle_marine02;
  level.scr_anim["nonShelfMarineBack"]["windowExitAdvance"] = % mar_breach_window_exit_advance_corner_marine02;
  level.scr_anim["wolfProxy"]["preBreachSpeechIdle"] = % mar_hos_wolfroom_pre_breach_speach_idle_wolf;
  scripts\common\anim::addnotetrack_customfunction("wolfProxy", "wolf_nag_spoken", ::wolf_nag_counter, "preBreachSpeechIdle");
  level.scr_anim["hostage01Proxy"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_idle_marine_hos_01;
  level.scr_anim["hostage02Proxy"]["preBreachIdle1Pass"] = % mar_hos_wolfroom_pre_breach_start_marine_hos_02;
  level.scr_anim["hostage02Proxy"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_idle_marine_hos_02;
  level.scr_anim["hostage03Proxy"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_idle_marine_hos_03;
  level.scr_anim["aq01Proxy"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_idle_aq_01;
  level.scr_anim["executionerProxy"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_idle_executioner;
  level.scr_anim["executionerProxy"]["preBreachIdle1Pass"] = % mar_hos_wolfroom_pre_breach_start_executioner;
  level.scr_anim["cameramanProxy"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_recording_idle_cameraman;
  level.scr_anim["hostage02Proxy"]["preBreachSlump"] = % mar_hos_wolfroom_pre_breach_slumps_marine_hos_02;
  level.scr_anim["executionerProxy"]["preBreachHostageGrab"] = % mar_hos_wolfroom_pre_breach_grabs_hos02_executioner;
  level.scr_anim["wolfProxy"]["preBreachHostageGrab"] = % mar_hos_wolfroom_pre_breach_grabs_hostage_wolf;
  scripts\common\anim::addnotetrack_customfunction("wolfProxy", "wolf_nag_spoken", ::wolf_nag_counter, "preBreachHostageGrab");
  level.scr_anim["hostage01Proxy"]["preBreachKick"] = % mar_hos_wolfroom_pre_breach_kicked_grabbed_marine_hos_01;
  scripts\common\anim::addnotetrack_customfunction("hostage01Proxy", "knocked_over", ::hostage_kicked_react, "preBreachKick");
  level.scr_anim["executionerProxy"]["preBreachKick"] = % mar_hos_wolfroom_pre_breach_kicks_hostage_executioner;
  level.scr_anim["wolfProxy"]["preBreachHostageGrabIdle"] = % mar_hos_wolfroom_pre_breach_grab_hostage_idle_wolf;
  level.scr_anim["wolfProxy"]["preBreachHostageGrabIdle2"][0] = % mar_hos_wolfroom_pre_breach_grab_hostage_idle2_wolf;
  level.scr_anim["hostage01Proxy"]["preBreachKickedGrab"][0] = % mar_hos_wolfroom_pre_breach_kicked_grabbed_idle_marine_hos_01;
  level.scr_anim["cameramanProxy"]["preBreachCameraAdjust"] = % mar_hos_wolfroom_pre_breach_adjust_cam_cameraman;
  level.scr_anim["cameramanProxy"]["preBreachCameraPeek"] = % mar_hos_wolfroom_pre_breach_peek_cameraman;
  level.scr_anim["aq01Proxy"]["preBreachIdleInterrupt"] = % mar_hos_wolfroom_pre_breach_idle_interrupt_aq_01;
  level.scr_anim["hostage03Proxy"]["preBreachIdleInterrupt"] = % mar_hos_wolfroom_pre_breach_idle_interrupt_marine_hos_03;
  level.scr_anim["wolfProxy"]["preBreachRaiseMachete"] = % mar_hos_wolfroom_post_breach_raising_wolf;
  level.scr_anim["wolfProxy"]["preBreachMacheteSlash"] = % mar_hos_wolfroom_pre_breach_stroke_wolf;
  level.scr_anim["hostage01Proxy"]["preBreachRaiseMachete"] = % mar_hos_wolfroom_post_breach_raising_mar_victim;
  level.scr_anim["hostage01Proxy"]["preBreachMacheteSlash"] = % mar_hos_wolfroom_post_breach_death_mar_victim;
  level.scr_anim["wolfProxy"]["preBreachExecute"] = % mar_hos_wolfroom_post_breach_cutthroat_wolf;
  level.scr_anim["hostage01Proxy"]["preBreachExecute"] = % mar_hos_wolfroom_post_breach_cutthroat_mar_victim;
  var_3 = 0.2;
  level.scr_goaltime["wolfProxy"]["preBreachIdle"] = var_3;
  level.scr_goaltime["wolfProxy"]["preBreachHostageGrab"] = var_3;
  level.scr_goaltime["wolfProxy"]["preBreachHostageGrabIdle"] = var_3;
  level.scr_goaltime["wolfProxy"]["postBreachRaiseMachete"] = var_3;
  level.scr_goaltime["wolfProxy"]["postBreachRaiseMacheteIdle"] = var_3;
  level.scr_goaltime["wolfProxy"]["postBreachMacheteSlash"] = var_3;
  level.scr_goaltime["wolfProxy"]["postBreachIdle"] = var_3;
  level.scr_goaltime["wolfProxy"]["postBreachFlinch"] = var_3;
  level.scr_goaltime["wolfProxy"]["postBreachWolfDeath"] = var_3;
  level.scr_goaltime["wolfProxy"]["preBreachRaiseMachete"] = var_3;
  level.scr_goaltime["wolfProxy"]["preBreachMacheteSlash"] = var_3;
  level.scr_face["wolfProxy"]["dx_vom_wolf_wolf_capture_401"] = % dx_vom_wolf_wolf_capture_401_face;
  level.scr_face["wolfProxy"]["dx_vom_wolf_wolf_capture_91"] = % dx_vom_wolf_wolf_capture_91_face;
  level.scr_face["wolfProxy"]["dx_vom_wolf_wolf_capture_92"] = % dx_vom_wolf_wolf_capture_92_face;
  level.scr_anim["hostage01"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_mar_victim;
  level.scr_anim["hostage01"]["postBreachRaiseMachete"] = % mar_hos_wolfroom_post_breach_raising_mar_victim;
  level.scr_anim["hostage01"]["postBreachDeath"] = % mar_hos_wolfroom_post_breach_death_mar_victim;
  level.scr_anim["hostage01"]["postBreachMacheteIdle"][0] = % mar_hos_wolfroom_post_breach_raised_idle_mar_victim;
  level.scr_anim["hostage01"]["postBreachFlinch"] = % mar_hos_wolfroom_post_breach_react_mar_victim;
  level.scr_anim["wolf"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_wolf;
  level.scr_anim["wolf"]["postBreachRaiseMachete"] = % mar_hos_wolfroom_post_breach_raising_wolf;
  level.scr_anim["wolf"]["postBreachMacheteIdle"][0] = % mar_hos_wolfroom_post_breach_raised_idle_wolf;
  level.scr_anim["wolf"]["postBreachMacheteSlash"] = % mar_hos_wolfroom_post_breach_stroke_wolf;
  level.scr_anim["wolf"]["vig_acquire_takedown_right"] = % mar_hos_wolfroom_breach_takedown_wolf;
  level.scr_anim["wolf"]["postBreachFlinch"] = % mar_hos_wolfroom_post_breach_react2player_wolf;
  level.scr_anim["wolf"]["postBreachWolfDeath"] = % mar_hos_wolfroom_post_breach_death_wolf;
  level.scr_anim["hostage02"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_mar_wounded;
  level.scr_anim["hostage02"]["postBreachHostageDeath"] = % mar_hos_wolfroom_post_breach_react2victim_mar_wounded;
  level.scr_anim["hostage02"]["postBreachDeath"] = % mar_hos_wolfroom_post_breach_death_mar_wounded;
  level.scr_anim["hostage03"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_mar_background;
  level.scr_anim["hostage03"]["postBreachHostageDeath"] = % mar_hos_wolfroom_post_breach_react2victim_mar_background;
  level.scr_anim["hostage03"]["postBreachDeath"] = % mar_hos_wolfroom_post_breach_death_mar_background;
  level.scr_anim["aq01"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_aq_guard;
  level.scr_anim["aq01"]["postBreachDeath"] = % mar_hos_wolfroom_post_breach_idle2death_aq_guard;
  level.scr_anim["aq01"]["postBreachHostageDeath"] = % mar_hos_wolfroom_post_breach_celebrate_aq_guard;
  level.scr_anim["aq01"]["postBreachFlinch"] = % mar_hos_wolfroom_post_breach_react2player_aq_guard;
  level.scr_anim["executioner"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_aq_doorway;
  level.scr_anim["executioner"]["postBreachHostageDeath"] = % mar_hos_wolfroom_post_breach_celebrate_aq_doorway;
  level.scr_anim["executioner"]["postBreachFlinch"] = % mar_hos_wolfroom_post_breach_react2player_aq_doorway;
  level.scr_anim["executioner"]["postBreachDeath"] = % mar_hos_wolfroom_post_breach_player2death_aq_doorway;
  level.scr_anim["cameraman"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_aq_cameraman;
  level.scr_anim["cameraman"]["postBreachFlinch"] = % mar_hos_wolfroom_post_breach_react2player_aq_cameraman;
  level.scr_anim["cameraman"]["postBreachDeath"] = % mar_hos_wolfroom_post_breach_player2death_aq_cameraman;
  level.scr_anim["aq01"]["takedown"] = % mar_hos_wolfroom_breach_takedown_executioner;
  level.scr_anim["cameraman"]["takedown"] = % mar_hos_wolfroom_breach_takedown_cameraman;
  level.scr_anim["executioner"]["takedown"] = % mar_hos_wolfroom_breach_takedown_aq_01;
  level.scr_anim["hostage01"]["takedown"] = % mar_hos_wolfroom_breach_takedown_hos_01;
  level.scr_anim["hostage02"]["takedown"] = % mar_hos_wolfroom_breach_takedown_hos_02;
  level.scr_anim["hostage03"]["takedown"] = % mar_hos_wolfroom_breach_takedown_hos_03;
  level.scr_anim["marine01"]["takedown"] = % mar_hos_wolfroom_breach_takedown_mar_01;
  level.scr_anim["marine02"]["takedown"] = % mar_hos_wolfroom_breach_takedown_mar_02;
  level.scr_anim["griggs"]["takedown"] = % mar_hos_wolfroom_breach_takedown_mar_03;
  level.scr_goaltime["hostage01"]["postBreachIdle"] = var_3;
  level.scr_goaltime["hostage01"]["postBreachRaiseMachete"] = var_3;
  level.scr_goaltime["hostage01"]["postBreachDeath"] = var_3;
  level.scr_goaltime["hostage01"]["postBreachMacheteIdle"] = var_3;
  level.scr_goaltime["hostage01"]["postBreachFlinch"] = var_3;
  level.scr_goaltime["hostage01"]["takedown"] = var_3;
  level.scr_goaltime["wolf"]["postBreachIdle"] = var_3;
  level.scr_goaltime["wolf"]["postBreachRaiseMachete"] = var_3;
  level.scr_goaltime["wolf"]["postBreachMacheteIdle"] = var_3;
  level.scr_goaltime["wolf"]["postBreachMacheteSlash"] = var_3;
  level.scr_goaltime["wolf"]["vig_acquire_takedown_right"] = var_3;
  level.scr_goaltime["wolf"]["hostage_knees_idle"] = var_3;
  level.scr_goaltime["wolf"]["postBreachFlinch"] = var_3;
  level.scr_goaltime["wolf"]["postBreachWolfDeath"] = var_3;
  scripts\common\anim::addnotetrack_mayhemstart("wolf", "mayhem_partA_start", %mar_hos_wolfroom_breach_takedown_wolf_parta_face, "vig_acquire_takedown_right");
  scripts\common\anim::addnotetrack_mayhemend("wolf", "mayhem_partA_end", %mar_hos_wolfroom_breach_takedown_wolf_parta_face, "vig_acquire_takedown_right");
  scripts\common\anim::addnotetrack_mayhemstart("wolf", "mayhem_partB_start", %mar_hos_wolfroom_breach_takedown_wolf_partb_face, "vig_acquire_takedown_right");
  scripts\common\anim::addnotetrack_mayhemend("wolf", "mayhem_partB_end", %mar_hos_wolfroom_breach_takedown_wolf_partb_face, "vig_acquire_takedown_right");
  scripts\common\anim::addnotetrack_mayhemstart("griggs", "mayhem_part_A_start", %mar_hos_wolfroom_breach_takedown_mar_03_part_a_face, "takedown");
  scripts\common\anim::addnotetrack_mayhemend("griggs", "mayhem_part_A_end", %mar_hos_wolfroom_breach_takedown_mar_03_part_a_face, "takedown");
  scripts\common\anim::addnotetrack_mayhemstart("griggs", "mayhem_part_B_start", %mar_hos_wolfroom_breach_takedown_mar_03_part_b_face, "takedown");
  scripts\common\anim::addnotetrack_mayhemend("griggs", "mayhem_part_B_end", %mar_hos_wolfroom_breach_takedown_mar_03_part_b_face, "takedown");
  level.scr_goaltime["griggs"]["rally_retreat"] = 0.2;
  level.scr_anim["griggs"]["rally_retreat"] = % mar_mh_exit_rally_griggs;
  level.scr_anim["rallyMarine1"]["rally_retreat"] = % mar_mh_exit_rally_usmc1;
  level.scr_anim["rallyMarine2"]["rally_retreat"] = % mar_mh_exit_rally_usmc2;
  level.scr_anim["rallyMarine3"]["rally_retreat"] = % mar_mh_exit_rally_usmc3;
  level.scr_anim["civ_crutch"]["crutch_runaway"] = % mar_hos_groundfloor_runaway_wounded_civ;
  level.scr_anim["civ_crutch_helper"]["crutch_runaway"] = % mar_hos_groundfloor_runaway_civ;
}

hostage_kicked_react(var_0) {
  scripts\engine\utility::flag_set("flag_snakecam_hostage_kicked");
}

set_deathanim_bed_death(var_0) {
  var_0 scripts\engine\sp\utility::set_deathanim("bed_death");
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["veh01"] = #animtree;
  level.scr_animtree["veh02"] = #animtree;
  level.scr_animtree["veh03"] = #animtree;
  level.scr_anim["veh01"]["ambush_ied"] = % mar_con_010_ambush_ied_veh01;
  level.scr_animtree["introTruck"] = #animtree;
  level.scr_anim["introTruck"]["introSequence"] = % mar_intro_010_dropoff_truck;
  level.scr_animtree["alleyTruck"] = #animtree;
  level.scr_anim["alleyTruck"]["truckDropOff"] = % mar_alley_vehicle_stop_a;
  level.scr_animtree["alleyTruck2"] = #animtree;
  level.scr_anim["alleyTruck2"]["truckDropOff"] = % mar_alley_vehicle_stop_b;
  scripts\common\anim::addnotetrack_customfunction("veh01", "IED", ::veh01_ied, "ambush_ied");
  level.scr_animtree["retreat_tank"] = #animtree;
  level.scr_anim["retreat_tank"]["retreat_assault_vehicle_destroyed"] = % mar_retreat_010_aq_fight_death_tank;
  level.scr_goaltime["retreat_tank"]["retreat_assault_vehicle_destroyed"] = 0.0;
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["a10"] = #animtree;
  level.scr_model["a10"] = "veh8_mil_air_alfa10";
  level.scr_anim["a10"]["precision_airstrike"] = % mp_alfa10_flyin;
  level.scr_animtree["LWindow"] = #animtree;
  level.scr_model["LWindow"] = "windowpeek_window_l";
  level.scr_anim["LWindow"]["windowOpen1"] = % mar_con_windowpeek_open_window01;
  level.scr_anim["LWindow"]["windowIdle1"][0] = % mar_con_windowpeek_idle_window01;
  level.scr_anim["LWindow"]["windowClose1"] = % mar_con_windowpeek_close_window1;
  level.scr_animtree["RWindow"] = #animtree;
  level.scr_model["RWindow"] = "windowpeek_window_r";
  level.scr_anim["RWindow"]["windowOpen2"] = % mar_con_windowpeek_open_window02;
  level.scr_anim["RWindow"]["windowIdle2"][0] = % mar_con_windowpeek_idle_window02;
  level.scr_anim["RWindow"]["windowClose2"] = % mar_con_windowpeek_close_window02;
  level.scr_anim["RWindow"]["windowOpen3"] = % mar_con_windowpeek_open_window03;
  level.scr_anim["RWindow"]["windowIdle3"][0] = % mar_con_windowpeek_idle_window03;
  level.scr_anim["RWindow"]["windowClose3"] = % mar_con_windowpeek_close_window03;
  level.scr_animtree["sledgeDoor"] = #animtree;
  level.scr_model["sledgeDoor"] = "door_wooden_hollow_rl_01";
  level.scr_anim["sledgeDoor"]["sledgeBreach"] = % zd30c_000_infil_lbirds_sledge_door;
  level.scr_animtree["shelf"] = #animtree;
  level.scr_anim["shelf"]["shelfPush"] = % mar_breach_window_exit_shelf_push_shelf;
  level.scr_animtree["introGate"] = #animtree;
  level.scr_model["introGate"] = "cp_disco_chainlink_fence";
  level.scr_anim["introGate"]["introSequence"] = % mar_intro_010_dropoff_gate;
  level.scr_animtree["snakecam"] = #animtree;
  level.scr_model["snakecam"] = "prop_military_snake_camera_01";
  level.scr_anim["snakecam"]["wolf_room_snakecam_enter"] = % mar_hos_wolf_room_snakecam_setup_snakecam;
  level.scr_anim["snakecam"]["wolf_room_snakecam_enter_idle"][0] = % mar_hos_wolf_room_snakecam_setup_idle_snakecam;
  level.scr_anim["snakecam"]["wolf_room_snakecam_exit"] = % mar_hos_wolf_room_snakecam_putaway_snakecam;
  level.scr_animtree["machete"] = #animtree;
  level.scr_model["machete"] = "me_military_machete_01";
  level.scr_anim["machete"]["preBreachIdle"][0] = % mar_hos_wolfroom_pre_breach_table_idle_machete;
  level.scr_anim["machete"]["preBreachHostageGrab"] = % mar_hos_wolfroom_pre_breach_table_grabbed_machete;
  level.scr_anim["machete"]["preBreachHostageGrabIdle"][0] = % mar_hos_wolfroom_pre_breach_table_grabbed_idle_machete;
  level.scr_anim["machete"]["postBreachRaiseMachete"] = % mar_hos_wolfroom_post_breach_raising_machete;
  level.scr_anim["machete"]["postBreachMacheteIdle"][0] = % mar_hos_wolfroom_post_breach_raised_idle_machete;
  level.scr_anim["machete"]["postBreachMacheteSlash"] = % mar_hos_wolfroom_post_breach_stroke_machete;
  level.scr_anim["machete"]["postBreachIdle"][0] = % mar_hos_wolfroom_post_breach_idle_wolf_machete;
  level.scr_anim["machete"]["postBreachFlinch"] = % mar_hos_wolfroom_post_breach_react2player_machete;
  level.scr_anim["machete"]["postBreachWolfDeath"] = % mar_hos_wolfroom_post_breach_death_machete;
  level.scr_anim["machete"]["preBreachRaiseMachete"] = % mar_hos_wolfroom_post_breach_raising_machete;
  level.scr_anim["machete"]["preBreachMacheteSlash"] = % mar_hos_wolfroom_post_breach_stroke_machete;
  var_0 = 0.2;
  level.scr_goaltime["machete"]["preBreachIdle"] = var_0;
  level.scr_goaltime["machete"]["preBreachHostageGrab"] = var_0;
  level.scr_goaltime["machete"]["preBreachHostageGrabIdle"] = var_0;
  level.scr_goaltime["machete"]["postBreachRaiseMachete"] = var_0;
  level.scr_goaltime["machete"]["postBreachRaiseMacheteIdle"] = var_0;
  level.scr_goaltime["machete"]["postBreachMacheteSlash"] = var_0;
  level.scr_goaltime["machete"]["postBreachIdle"] = var_0;
  level.scr_goaltime["machete"]["postBreachFlinch"] = var_0;
  level.scr_goaltime["machete"]["postBreachWolfDeath"] = var_0;
  level.scr_goaltime["machete"]["preBreachRaiseMachete"] = var_0;
  level.scr_goaltime["machete"]["preBreachMacheteSlash"] = var_0;
  level.scr_animtree["crutch"] = #animtree;
  level.scr_model["crutch"] = "prop_medical_crutch_01";
  level.scr_anim["crutch"]["crutch_runaway"] = % mar_hos_groundfloor_runaway_wounded_civ_crutch;
  level.scr_animtree["shadowCaster"] = #animtree;
  level.scr_model["shadowCaster"] = "viewhands_alex_fullbody";
  level.scr_anim["shadowCaster"]["vig_acquire_takedown_right"] = % mar_hos_wolfroom_breach_takedown_plr_shadow;
}

wounded_drag_shoot(var_0) {
  var_1 = scripts\engine\utility::getStruct("wounded_drag_shooter", "targetname");
  var_1.groundorigin = scripts\engine\utility::drop_to_ground(var_1.origin, 0, -100);
  var_2 = 100;
  var_3 = 0.5;
  var_4 = var_3 * 20;
  var_5 = var_4 * 0.5;

  for(var_6 = 0; var_6 < var_4; var_6++) {
    if(var_6 < var_5) {
      var_7 = var_6 / var_5;
      var_7 = 1 - var_7;
      var_8 = vectorNormalize(var_1.groundorigin - var_0.origin);
      var_9 = var_0.origin + var_8 * (var_2 * var_7);
    } else {
      var_7 = (var_6 - var_5) / var_4;
      var_10 = var_0.origin + (0, 0, 52);
      var_8 = vectorNormalize(var_10 - var_0.origin);
      var_9 = var_0.origin + var_8 * (var_2 * var_7);
    }

    magicbullet("iw8_ar_akilo47", var_1.origin, var_9);
    waitframe();
  }
}

wounded_drag_pistol_swap(var_0) {}

veh01_ied(var_0) {
  scripts\engine\utility::flag_set("play_IED_explosion");
}

intro_remove_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(1, 1.5);
}

wolf_nag_counter(var_0) {
  level.wolf_nag_count++;
}