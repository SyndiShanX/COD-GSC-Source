/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phparade\phparade_anim.gsc
******************************************************/

main() {
  _id_91DC();
  _id_3353();
  player();
  _id_13267();
  script_model();
  _id_A056();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["extra1"]["ending_scene"] = % ep_ending_ally01_scene;
  level._id_EC85["extra2"]["ending_scene"] = % ep_ending_ally02_scene_fem;
  level._id_EC85["extra3"]["ending_scene"] = % ep_ending_ally03_scene;
  level._id_EC85["extra4"]["ending_scene"] = % ep_ending_ally04_scene_fem;
  level._id_EC85["extra5"]["ending_scene"] = % ep_ending_ally05_scene;
  level._id_EC85["extra6"]["ending_scene"] = % ep_ending_ally06_scene;
  level._id_EC85["extra7"]["ending_scene"] = % ep_ending_ally07_scene_fem;
  level._id_EC85["extra8"]["ending_scene"] = % ep_ending_ally08_scene;
  level._id_EC85["extra9"]["ending_scene"] = % ep_ending_ally09_scene_fem;
  level._id_EC85["salter"]["ending_scene"] = % ep_ending_xo_scene;
  level._id_EC85["salter"]["open_newoffice_door"] = % ph_parade_1_3_4_start_xo;
  level._id_EC85["salter"]["memorial_wall_salter"] = % ph_1_6_hallway_salter;
  level._id_EC89["salter"]["memorial_wall_salter"] = 0.7;
  level._id_EC85["salter"]["open_exterior_door"] = % ph_1_7_door_salter;
  level._id_EC85["salter"]["checkpoint_intro"] = % ph_parade_1_9_check_xo_intro;
  level._id_EC85["salter"]["checkpoint_idle"][0] = % ph_parade_1_9_check_xo_idle;
  level._id_EC85["salter"]["checkpoint_open_intro"] = % ph_parade_1_9_check_xo_passes_cp_intro;
  level._id_EC85["salter"]["checkpoint_open"] = % ph_parade_1_9_check_xo_passes_cp;
  level._id_EC85["checkpoint_guard_1"]["checkpoint_idle"][0] = % ph_parade_1_9_check_ally01_cp_block_idle;
  level._id_EC85["checkpoint_guard_2"]["checkpoint_idle"][0] = % ph_parade_1_9_check_ally02_cp_block_idle;
  level._id_EC85["checkpoint_crowd_1"]["checkpoint_idle"][0] = % ph_parade_1_9_check_ally03_cp_block_idle;
  level._id_EC85["checkpoint_crowd_2"]["checkpoint_idle"][0] = % ph_parade_1_9_check_ally04_cp_block_idle;
  level._id_EC85["checkpoint_crowd_3"]["checkpoint_idle"][0] = % ph_parade_1_9_check_ally05_cp_block_idle;
  level._id_EC85["checkpoint_crowd_4"]["checkpoint_idle"][0] = % ph_parade_1_9_check_ally06_cp_block_idle;
  level._id_EC85["checkpoint_guard_1"]["checkpoint_open"] = % ph_parade_1_9_check_ally01_cp_open_path;
  level._id_EC85["checkpoint_guard_2"]["checkpoint_open"] = % ph_parade_1_9_check_ally02_cp_open_path;
  level._id_EC85["checkpoint_crowd_1"]["checkpoint_open"] = % ph_parade_1_9_check_ally03_cp_open_path;
  level._id_EC85["checkpoint_crowd_2"]["checkpoint_open"] = % ph_parade_1_9_check_ally04_cp_open_path;
  level._id_EC85["checkpoint_crowd_3"]["checkpoint_open"] = % ph_parade_1_9_check_ally05_cp_open_path;
  level._id_EC85["checkpoint_crowd_4"]["checkpoint_open"] = % ph_parade_1_9_check_ally06_cp_open_path;
  level._id_EC85["checkpoint_guard_1"]["checkpoint_open_idle"][0] = % ph_parade_1_9_check_ally01_cp_open_path_idle;
  level._id_EC85["checkpoint_guard_2"]["checkpoint_open_idle"][0] = % ph_parade_1_9_check_ally02_cp_open_path_idle;
  level._id_EC85["checkpoint_crowd_1"]["checkpoint_open_idle"][0] = % ph_parade_1_9_check_ally03_cp_open_path_idle;
  level._id_EC85["checkpoint_crowd_2"]["checkpoint_open_idle"][0] = % ph_parade_1_9_check_ally04_cp_open_path_idle;
  level._id_EC85["checkpoint_crowd_3"]["checkpoint_open_idle"][0] = % ph_parade_1_9_check_ally05_cp_open_path_idle;
  level._id_EC85["checkpoint_crowd_4"]["checkpoint_open_idle"][0] = % ph_parade_1_9_check_ally06_cp_open_path_idle;
  level._id_EC85["checkpoint_guard_1"]["checkpoint_close"] = % ph_parade_1_9_check_ally01_cp_close_path;
  level._id_EC85["checkpoint_guard_2"]["checkpoint_close"] = % ph_parade_1_9_check_ally02_cp_close_path;
  level._id_EC85["checkpoint_crowd_1"]["checkpoint_close"] = % ph_parade_1_9_check_ally03_cp_close_path;
  level._id_EC85["checkpoint_crowd_2"]["checkpoint_close"] = % ph_parade_1_9_check_ally04_cp_close_path;
  level._id_EC85["checkpoint_crowd_3"]["checkpoint_close"] = % ph_parade_1_9_check_ally05_cp_close_path;
  level._id_EC85["checkpoint_crowd_4"]["checkpoint_close"] = % ph_parade_1_9_check_ally06_cp_close_path;
  level._id_EC85["admiral"]["dropship_entrance"] = % ph_parade_1_11_raven_adm;
  level._id_EC89["admiral"]["dropship_entrance"] = 0.7;
  level._id_EC85["salter"]["dropship_entrance"] = % ph_parade_1_11_raven_xo;
  level._id_EC85["pilot"]["dropship_entrance"] = % ph_parade_1_11_raven_pilot;
  level._id_EC85["eth3n"]["dropship_entrance"] = % ph_parade_1_11_raven_c6i;
  level._id_EC85["salter"]["dropship_idle"][0] = % ph_parade_1_11_raven_xo_idle;
  level._id_EC85["admiral"]["dropship_idle"][0] = % ph_parade_1_11_raven_adm_idle;
  level._id_EC85["pilot"]["dropship_idle"][0] = % ph_parade_1_11_raven_pilot_idle;
  level._id_EC85["eth3n"]["dropship_idle"][0] = % ph_parade_1_11_raven_c6i_idle;
  level._id_EC85["salter"]["flyover"] = % ph_parade_1_12_flyover_xo;
  level._id_EC85["admiral"]["flyover"] = % ph_parade_1_12_flyover_adm;
  level._id_EC85["eth3n"]["flyover"] = % ph_parade_1_12_flyover_c6i;
  level._id_EC89["salter"]["flyover"] = 0.7;
  level._id_EC89["admiral"]["flyover"] = 0.7;
  level._id_EC89["eth3n"]["flyover"] = 0.7;
  level._id_EC85["generic"]["vh_org_dropship_idle_copilot"][0] = % vh_org_dropship_idle_copilot;
  level._id_EC88["salter"]["phparade_slt_readyweremissin"] = % phparade_slt_readyweremissin_face;
  level._id_EC88["salter"]["phparade_slt_homesweethome"] = % phparade_slt_homesweethome_face;
  level._id_EC88["salter"]["phparade_slt_youknowimmoreco"] = % phparade_slt_youknowimmoreco_face;
  level._id_EC88["salter"]["phparade_slt_negativerainman"] = % phparade_slt_negativerainman_face;
  level._id_EC88["salter"]["phparade_slt_nevertohisface"] = % phparade_slt_nevertohisface_face;
  level._id_EC88["salter"]["phparade_slt_letsgetairborne"] = % phparade_slt_letsgetairborne_face;
  level._id_EC88["salter"]["phparade_plr_heartsandmindss"] = % phparade_plr_heartsandmindss_face;
  level._id_EC88["salter"]["phparade_plr_ourhandsaretied"] = % phparade_plr_ourhandsaretied_face;
  level._id_EC88["salter"]["phparade_plr_tryandenjoyyour"] = % phparade_plr_tryandenjoyyour_face;
  level._id_EC88["salter"]["phparade_slt_gotmetheresir"] = % phparade_slt_gotmetheresir_face;
  level._id_EC85["generic"]["shipcrib_inspection_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["shipcrib_inspection_90_low_idle"][0] = % shipcrib_inspection_90_low_idle;
  level._id_EC85["generic"]["shipcrib_inspection_90_high_idle"][0] = % shipcrib_inspection_90_high_idle;
  level._id_EC85["generic"]["ph_parade_landpad_railing_idle_01"][0] = % ph_parade_landpad_railing_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_salute_idle_02"][0] = % shipcrib_stand_salute_idle_02;
  level._id_EC85["generic"]["shipcrib_console_serv_01_A"][0] = % shipcrib_console_serv_01_a;
  level._id_EC85["generic"]["shipcrib_console_serv_01_B"][0] = % shipcrib_console_serv_01_b;
  level._id_EC85["crate_mover_guyA"]["crate_move_pre_idle"][0] = % shipcrib_hangar_crate_move02_idle01_guya;
  level._id_EC85["crate_mover_guyA"]["crate_move"] = % shipcrib_hangar_crate_move02_walk_guya;
  level._id_EC85["crate_mover_guyA"]["crate_move_post_idle"][0] = % shipcrib_hangar_crate_move02_idle02_guya;
  level._id_EC85["crate_mover_guyB"]["crate_move_pre_idle"][0] = % shipcrib_hangar_crate_move02_idle01_guyb;
  level._id_EC85["crate_mover_guyB"]["crate_move"] = % shipcrib_hangar_crate_move02_walk_guyb;
  level._id_EC85["crate_mover_guyB"]["crate_move_post_idle"][0] = % shipcrib_hangar_crate_move02_idle02_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_1_guyA"][0] = % shipcrib_upper_catwalk_seca_1_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_1_guyB"][0] = % shipcrib_upper_catwalk_seca_1_guyb;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_flat_guyA_01"][0] = % shipcrib_hangar_catwalk_flat_guya_01;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_flat_guyB_01"][0] = % shipcrib_hangar_catwalk_flat_guyb_01;
  level._id_EC85["generic"]["ph_parade_catwalk_flat_guyA_01"][0] = % ph_parade_catwalk_flat_guya_01;
  level._id_EC85["generic"]["ph_parade_catwalk_flat_guyB_01"][0] = % ph_parade_catwalk_flat_guyb_01;
  level._id_EC85["generic"]["sh_5_4_grav_off_limits_reactionset_idle"][0] = % sh_5_4_grav_off_limits_reactionset_idle;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_01"][0] = % shipcrib_hangar_stand_lean_idle_01;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_vig_idle_01_guyA"][0] = % shipcrib_armory_catwalk_vig_idle_01_guya_rooftop;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_vig_idle_01_guyB"][0] = % shipcrib_armory_catwalk_vig_idle_01_guyb_rooftop;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_01"][0] = % shipcrib_stand_stationary_talk_idle_01;
  level._id_EC85["generic"]["shipcrib_return_deck_catwalk_idle01"][0] = % shipcrib_return_deck_catwalk_idle01;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_02"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["shipcrib_stand_idle02_arrival"] = % shipcrib_stand_idle02_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle02_exit"] = % shipcrib_stand_idle02_exit;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_03"][0] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["generic"]["shipcrib_stand_idle03_arrival"] = % shipcrib_stand_idle03_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle03_exit"] = % shipcrib_stand_idle03_exit;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_04"][0] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EC85["generic"]["shipcrib_stand_idle04_arrival"] = % shipcrib_stand_idle04_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle04_exit"] = % shipcrib_stand_idle04_exit;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_05"][0] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EC85["generic"]["shipcrib_stand_idle05_arrival"] = % shipcrib_stand_idle05_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle05_exit"] = % shipcrib_stand_idle05_exit;
  level._id_EC85["generic"]["shipcrib_stand_idle01_vig_01"][0] = % shipcrib_stand_idle01_vig_01;
  level._id_EC85["generic"]["shipcrib_stand_idle01_vig_01"][1] = % shipcrib_stand_idle01_vig_02;
  level._id_EC85["generic"]["shipcrib_stand_idle01_vig_01"][2] = % shipcrib_stand_idle01_vig_03;
  level._id_EC85["generic"]["shipcrib_stand_idle01_vig_01"][3] = % shipcrib_stand_idle01_vig_04;
  level._id_EC85["generic"]["shipcrib_stand_idle02_vig_01"][0] = % shipcrib_stand_idle02_vig_01;
  level._id_EC85["generic"]["shipcrib_stand_idle02_vig_01"][1] = % shipcrib_stand_idle02_vig_02;
  level._id_EC85["generic"]["shipcrib_stand_idle02_vig_01"][2] = % shipcrib_stand_idle02_vig_03;
  level._id_EC85["generic"]["shipcrib_stand_idle02_vig_01"][3] = % shipcrib_stand_idle02_vig_04;
  level._id_EC85["generic"]["shipcrib_stand_idle03_vig_01"][0] = % shipcrib_stand_idle03_vig_01;
  level._id_EC85["generic"]["shipcrib_stand_idle03_vig_01"][1] = % shipcrib_stand_idle03_vig_02;
  level._id_EC85["generic"]["shipcrib_stand_idle03_vig_01"][2] = % shipcrib_stand_idle03_vig_03;
  level._id_EC85["generic"]["shipcrib_stand_idle03_vig_01"][3] = % shipcrib_stand_idle03_vig_04;
  level._id_EC85["generic"]["shipcrib_stand_idle04_vig_01"][0] = % shipcrib_stand_idle04_vig_01;
  level._id_EC85["generic"]["shipcrib_stand_idle04_vig_01"][1] = % shipcrib_stand_idle04_vig_02;
  level._id_EC85["generic"]["shipcrib_stand_idle04_vig_01"][2] = % shipcrib_stand_idle04_vig_03;
  level._id_EC85["generic"]["shipcrib_stand_idle04_vig_01"][3] = % shipcrib_stand_idle04_vig_04;
  level._id_EC85["generic"]["shipcrib_stand_idle04_vig_01"][4] = % shipcrib_stand_idle04_vig_05;
  level._id_EC85["generic"]["shipcrib_stand_idle05_vig_01"][0] = % shipcrib_stand_idle05_vig_01;
  level._id_EC85["generic"]["shipcrib_stand_idle05_vig_01"][1] = % shipcrib_stand_idle05_vig_02;
  level._id_EC85["generic"]["shipcrib_stand_idle05_vig_01"][2] = % shipcrib_stand_idle05_vig_03;
  level._id_EC85["generic"]["shipcrib_stand_idle05_vig_01"][3] = % shipcrib_stand_idle05_vig_04;
  level._id_EC85["generic"]["shipcrib_stand_idle05_vig_01"][4] = % shipcrib_stand_idle05_vig_05;
  level._id_EC85["section1_guyA"]["jackal_land_entrance_idle"][0] = % shipcrib_jackal_serv_seca_enter_idle_guya;
  level._id_EC85["section1_guyB"]["jackal_land_entrance_idle"][0] = % shipcrib_jackal_serv_seca_enter_idle_guyb;
  level._id_EC85["section2_guyA"]["jackal_land_entrance_idle"][0] = % shipcrib_jackal_serv_secb_enter_idle_guya;
  level._id_EC85["section2_guyB"]["jackal_land_entrance_idle"][0] = % shipcrib_jackal_serv_secb_enter_idle_guyb;
  level._id_EC85["section3_guyA"]["jackal_land_entrance_idle"][0] = % shipcrib_jackal_serv_secc_enter_idle_guya;
  level._id_EC85["section3_guyB"]["jackal_land_entrance_idle"][0] = % shipcrib_jackal_serv_secc_enter_idle_guyb;
  level._id_EC85["section1_guyA"]["jackal_land_entrance"] = % shipcrib_jackal_serv_seca_enter_guya;
  level._id_EC85["section1_guyB"]["jackal_land_entrance"] = % shipcrib_jackal_serv_seca_enter_guyb;
  level._id_EC85["section2_guyA"]["jackal_land_entrance"] = % shipcrib_jackal_serv_secb_enter_guya;
  level._id_EC85["section2_guyB"]["jackal_land_entrance"] = % shipcrib_jackal_serv_secb_enter_guyb;
  level._id_EC85["section3_guyA"]["jackal_land_entrance"] = % shipcrib_jackal_serv_secc_enter_guya;
  level._id_EC85["section3_guyB"]["jackal_land_entrance"] = % shipcrib_jackal_serv_secc_enter_guyb;
  level._id_EC85["section1_guyA"]["jackal_maintenance_idle"][0] = % shipcrib_jackal_serv_seca_idle_guyb;
  level._id_EC85["section1_guyB"]["jackal_maintenance_idle"][0] = % shipcrib_jackal_serv_seca_idle_guya;
  level._id_EC85["section2_guyA"]["jackal_maintenance_idle"][0] = % shipcrib_jackal_serv_secb_idle_guya;
  level._id_EC85["section2_guyB"]["jackal_maintenance_idle"][0] = % shipcrib_jackal_serv_secb_idle_guyb;
  level._id_EC85["section3_guyA"]["jackal_maintenance_idle"][0] = % shipcrib_jackal_serv_secc_loop1_guya;
  level._id_EC85["section3_guyB"]["jackal_maintenance_idle"][0] = % shipcrib_jackal_serv_secc_loop1_guyb;
  level._id_EC85["waverA"]["jackal_land_entrance_idle"][0] = % jackala_service_idle_wait_guya;
  level._id_EC85["waverB"]["jackal_land_entrance_idle"][0] = % jackala_service_enter_idle_guyb;
  level._id_EC85["waverA"]["jackal_land_entrance"] = % jackala_service_enter_guya;
  level._id_EC85["waverB"]["jackal_land_entrance"] = % jackala_service_enter_guyb;
  level._id_EC85["waverA"]["jackal_maintenance_idle"][0] = % jackala_service_idle_guya;
  level._id_EC85["waverB"]["jackal_maintenance_idle"][0] = % jackala_service_idle_guyb;
  level._id_EC85["generic"]["shipcrib_inspection_90_high_idle"][0] = % shipcrib_inspection_90_high_idle;
  level._id_EC85["generic"]["jackal_wave_wait"][0] = % jackala_service_idle_wait_guya;
  level._id_EC85["jackal_pilot"]["pilot_idle"][0] = % shipcrib_jackal_salter_idle;
  level._id_EC85["jackal_a_wave1"]["shipcrib_inspection_90_high_idle"][0] = % shipcrib_inspection_90_high_idle;
  level._id_EC89["jackal_a_wave1"]["shipcrib_inspection_90_high_idle"] = 2;
  level._id_EC85["jackal_a_wave1"]["jackal_wave_wait"][0] = % jackala_service_idle_wait_guya;
  level._id_EC85["jackal_a_wave1"]["jackal_wave_enter"] = % jackala_service_enter_guya;
  level._id_EC85["jackal_a_wave2"]["jackal_wave_enter"] = % jackala_service_enter_guyb;
  level._id_EC85["jackal_a_wave1"]["jackal_wave_idle"][0] = % jackala_service_idle_guya;
  level._id_EC85["jackal_a_wave2"]["jackal_wave_idle"][0] = % jackala_service_idle_guyb;
}

_id_3353() {}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7_naval";
  level._id_EC85["player_rig"]["open_newoffice_door"] = % ph_parade_1_3_4_start_plr;
  level._id_EC85["player_rig"]["open_exterior_door"] = % ph_1_7_door_plr;
  level._id_EC85["player_rig"]["rooftop_idle"][0] = % ph_parade_dropship_plr_idle;
  level._id_EC89["player_rig"]["dropship_idle"] = 3;
  level._id_EC85["player_rig"]["dropship_entrance"] = % ph_parade_1_11_raven_plr;
  level._id_EC85["player_rig"]["dropship_idle"] = % ph_parade_1_11_raven_plr_idle;
  level._id_EC85["player_rig"]["ending_scene"] = % ep_ending_plr_scene;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["exterior_door_left"] = #animtree;
  level._id_EC8C["exterior_door_left"] = "door_metal_security_door_single_a01";
  level._id_EC85["exterior_door_left"]["open_exterior_door"] = % ph_1_7_door_left;
  level._id_EC85["exterior_door_left"]["open_newoffice_door"] = % ph_parade_1_3_4_start_door_left;
  level._id_EC87["exterior_door_right"] = #animtree;
  level._id_EC8C["exterior_door_right"] = "door_metal_security_door_single_a01";
  level._id_EC85["exterior_door_right"]["open_exterior_door"] = % ph_1_7_door_right;
  level._id_EC85["exterior_door_right"]["open_newoffice_door"] = % ph_parade_1_3_4_start_door_right;
  level._id_EC87["crate_move_A"] = #animtree;
  level._id_EC8C["crate_move_A"] = "crates_plastic_tech_01";
  level._id_EC85["crate_move_A"]["crate_move_pre_idle"][0] = % shipcrib_hangar_crate_move02_idle01_boxa;
  level._id_EC85["crate_move_A"]["crate_move"] = % shipcrib_hangar_crate_move02_walk_boxa;
  level._id_EC85["crate_move_A"]["crate_move_post_idle"][0] = % shipcrib_hangar_crate_move02_idle02_boxa;
  level._id_EC87["crate_move_B"] = #animtree;
  level._id_EC8C["crate_move_B"] = "crates_plastic_tech_01";
  level._id_EC85["crate_move_B"]["crate_move_pre_idle"][0] = % shipcrib_hangar_crate_move02_idle01_boxb;
  level._id_EC85["crate_move_B"]["crate_move"] = % shipcrib_hangar_crate_move02_walk_boxb;
  level._id_EC85["crate_move_B"]["crate_move_post_idle"][0] = % shipcrib_hangar_crate_move02_idle02_boxb;
  level._id_EC87["jackal_toolbox_pc"] = #animtree;
  level._id_EC8C["jackal_toolbox_pc"] = "cnd_laptop_001_jackalbay";
  level._id_EC87["jackal_toolbox_tablet"] = #animtree;
  level._id_EC8C["jackal_toolbox_tablet"] = "p7_desk_metal_military_03_tablet";
  level._id_EC87["jackal_toolbox_1"] = #animtree;
  level._id_EC8C["jackal_toolbox_1"] = "equipment_industrial_tool_caddy_01";
  level._id_EC85["jackal_toolbox_1"]["jackal_land_entrance"] = % shipcrib_jackal_serv_seca_cart;
  level._id_EC87["jackal_toolbox_2"] = #animtree;
  level._id_EC8C["jackal_toolbox_2"] = "equipment_industrial_tool_caddy_01";
  level._id_EC85["jackal_toolbox_2"]["jackal_land_entrance"] = % shipcrib_jackal_serv_secb_cart;
  level._id_EC87["jackal_toolbox_3"] = #animtree;
  level._id_EC8C["jackal_toolbox_3"] = "equipment_industrial_tool_caddy_01";
  level._id_EC85["jackal_toolbox_3"]["jackal_land_entrance"] = % shipcrib_jackal_serv_secc_cart;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["retribution"] = #animtree;
  level._id_EC85["retribution"]["fly_in"] = % ph_ret_flyby_high;
  level._id_EC85["dropship"]["dropship_landing"] = % ph_intro_dropship_landing;
  scripts\sp\anim::_id_17FC("dropship", "front_thursters_on", "dropship_side_thrusters_on", "dropship_landing");
  scripts\sp\anim::_id_17FC("dropship", "front_thursters_off", "dropship_side_thrusters_off", "dropship_landing");
  level._id_EC85["dropship"]["dropship_entrance"] = % ph_parade_1_11_raven_dropship;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC85["jackal"]["ph_parade_jackal_land"] = % ph_parade_jackal_land;
  level._id_EC85["jackal"]["ph_parade_jackal_land_idle"][0] = % ph_parade_jackal_land_idle;
}