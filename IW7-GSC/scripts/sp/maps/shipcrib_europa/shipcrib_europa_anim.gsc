/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_europa\shipcrib_europa_anim.gsc
********************************************************************/

main() {
  _id_CF61();
  _id_775D();
  _id_EE1D();
  vehicle_badplace();
}

#using_animtree("player");

_id_CF61() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7_naval";
  level._id_EC85["player_rig"]["SH3_11_EUR_SH_BR_OPS_PLR_intro"] = % sh3_11_eur_sh_br_ops_plr_intro;
  level._id_EC85["player_rig"]["SH3_13_EUR_SH_BR_JUMP_PLR_intro"] = % sh3_13_eur_sh_br_jump_plr_intro;
  level._id_EC85["player_rig"]["SH3_11B_EUR_SH_BR_OPS_PLR_scene"] = % sh3_11b_eur_sh_br_ops_plr_scene;
}

#using_animtree("generic_human");

_id_775D() {
  level._id_EC85["generic"]["jackal_pilot_idle"][0] = % shipcrib_jackal_salter_idle;
  level._id_EC85["generic"]["jackal_copilot_idle"][0] = % shipcrib_jackal_mco_idle;
  level._id_EC85["generic"]["jackal_exit"] = % shipcrib_jackal_salter_exit;
  level._id_EC85["omar"]["jackal_pip"] = % sh3_1a_eur_land_mco_pip;
  level._id_EC85["salter"]["jackal_pip"] = % sh3_1a_eur_land_xo_pip;
  level._id_EC85["ethan"]["jackal_dismount"] = % sh3_1b_eur_tablet_c6i_intro;
  level._id_EC85["omar"]["jackal_dismount"] = % sh3_1b_eur_tablet_mco_intro;
  level._id_EC85["kloos"]["jackal_dismount"] = % sh3_1b_eur_tablet_klo_intro;
  level._id_EC85["kloos"]["jackal_dismount_idle"][0] = % sh3_1b_eur_tablet_klo_idle;
  level._id_EC88["salter"]["sc_europa_slt_forcedfacetime"] = % sh3_6_eur_xo_face_01;
  level._id_EC88["salter"]["sc_europa_slt_illtakeethan"] = % sh3_6_eur_xo_face_02;
  level._id_EC85["gibson"]["enemyairship_idle"][0] = % sh3_6_2_eur_gibson_air_idle;
  level._id_EC85["gibson"]["enemyairship_scene"] = % sh3_6_2_eur_gibson_air_scene;
  level._id_EC85["gibson"]["enemyairship_exit"] = % sh3_6_2_eur_gibson_air_exit;
  level._id_EC85["salter"]["enemyairship_scene"] = % sh3_6_2_eur_gibson_xo_scene;
  level._id_EC85["generic"]["service_jackal_enter_left"] = % jackala_service_enter_guyb;
  level._id_EC85["generic"]["service_jackal_idle_left"][0] = % jackala_service_idle_guyb;
  level._id_EC85["generic"]["service_jackal_enter_right"] = % jackala_service_enter_guyb;
  level._id_EC85["generic"]["service_jackal_idle_right"][0] = % jackala_service_idle_guyb;
  level._id_EC85["kloos"]["service_jackal_enter"] = % jackala_service_enter_guyb;
  level._id_EC85["valet_b"]["service_jackal_enter"] = % jackala_service_enter_guyb;
  level._id_EC85["kloos"]["service_jackal_idle"][0] = % jackala_service_idle_guyb;
  level._id_EC85["valet_b"]["service_jackal_idle"][0] = % jackala_service_idle_guyb;
  level._id_EC85["salter"]["return_elevator_performance"] = % sh3_7_eur_deck_elev_xo_scene_pcap;
  level._id_EC85["newsguy1"]["newsguy_performance"] = % sh3_8_eur_bridge_hall_guya_scene;
  level._id_EC85["newsguy2"]["newsguy_performance"] = % sh3_8_eur_bridge_hall_guyb_scene;
  level._id_EC85["newsguy1"]["newsguy_idle"][0] = % shipcrib_stand_stationary_talk_idle_04_jack;
  level._id_EC85["newsguy1"]["newsguy_idle_arrival"] = % shipcrib_stand_idle04_arrival_jack;
  level._id_EC85["salter"]["salter_e3_idle"][0] = % shipcrib_stand_stationary_talk_idle_02_xo;
  level._id_EC85["generic"]["shipcrib_vr_loop_01"][0] = % shipcrib_vr_loop_01;
  level._id_EC85["generic"]["shipcrib_lounge_couch_idleA_02"][0] = % shipcrib_lounge_couch_idlea_02;
  level._id_EC85["generic"]["shipcrib_lounge_chess_idleA_01"][0] = % shipcrib_lounge_chess_idlea_01;
  level._id_EC85["generic"]["shipcrib_lounge_chess_idleA_02"][0] = % shipcrib_lounge_chess_idlea_02;
  level._id_EC85["generic"]["shipcrib_lounge_reaction_c_idle"][0] = % shipcrib_lounge_reaction_c_idle;
  level._id_EC85["generic"]["shipcrib_lounge_reaction_c_walk"] = % shipcrib_lounge_reaction_c_walk;
  level._id_EC85["gator"]["SH3_10_EUR_SH_BR_PRE_NAV_ops_idle_01"][0] = % sh3_10_eur_sh_br_pre_nav_ops_idle_01;
  level._id_EC85["mac"]["SH3_10_EUR_SH_BR_PRE_ENG_idle_01"][0] = % sh3_10_eur_sh_br_pre_eng_idle_01;
  level._id_EC85["drop_officer"]["SH3_10_EUR_SH_BR_PRE_DO_idle_01"][0] = % sh3_10_eur_sh_br_pre_do_idle_01;
  level._id_EC85["gator"]["SH3_10_EUR_SH_BR_PRE_NAV_nag"] = % sh3_10_eur_sh_br_pre_nav_nag;
  level._id_EC85["salter"]["SH3_10_EUR_SH_BR_PRE_XO_intro"] = % sh3_10_eur_sh_br_pre_xo_intro;
  level._id_EC85["gator"]["SH3_10_EUR_SH_BR_PRE_NAV_intro"] = % sh3_10_eur_sh_br_pre_nav_intro;
  level._id_EC85["mac"]["SH3_10_EUR_SH_BR_PRE_ENG_intro"] = % sh3_10_eur_sh_br_pre_eng_intro;
  level._id_EC85["drop_officer"]["SH3_10_EUR_SH_BR_PRE_DO_intro"] = % sh3_10_eur_sh_br_pre_do_intro;
  level._id_EC85["salter"]["SH3_11_EUR_SH_BR_OPS_XO_idle"][0] = % sh3_11_eur_sh_br_ops_xo_idle;
  level._id_EC85["gator"]["SH3_11_EUR_SH_BR_OPS_NAV_idle"][0] = % sh3_11_eur_sh_br_ops_nav_idle;
  level._id_EC85["mac"]["SH3_11_EUR_SH_BR_OPS_ENG_idle"][0] = % sh3_11_eur_sh_br_ops_eng_idle;
  level._id_EC85["drop_officer"]["SH3_11_EUR_SH_BR_OPS_DO_idle"][0] = % sh3_11_eur_sh_br_ops_do_idle;
  level._id_EC85["salter"]["SH3_11_EUR_SH_BR_OPS_XO_intro"] = % sh3_11_eur_sh_br_ops_xo_intro;
  level._id_EC85["gator"]["SH3_11_EUR_SH_BR_OPS_NAV_intro"] = % sh3_11_eur_sh_br_ops_nav_intro;
  level._id_EC85["mac"]["SH3_11_EUR_SH_BR_OPS_ENG_intro"] = % sh3_11_eur_sh_br_ops_eng_intro;
  level._id_EC85["drop_officer"]["SH3_11_EUR_SH_BR_OPS_DO_intro"] = % sh3_11_eur_sh_br_ops_do_intro;
  level._id_EC85["drop_officer"]["shipcrib_standing_console_idle_01_DO"][0] = % shipcrib_standing_console_idle_01_do;
  level._id_EC85["gator"]["SH3_11_EUR_SH_BR_OPS_NAV_waiting_idle"][0] = % sh3_11_eur_sh_br_ops_nav_waiting_idle;
  level._id_EC85["mac"]["SH3_11_EUR_SH_BR_OPS_ENG_waiting_idle"][0] = % sh3_11_eur_sh_br_ops_eng_waiting_idle;
  level._id_EC85["gator"]["SH3_11_EUR_SH_BR_OPS_NAV_nag"] = % sh3_11_eur_sh_br_ops_nav_nag;
  level._id_EC85["mac"]["SH3_11B_EUR_SH_BR_OPS_ENG_scene"] = % sh3_11b_eur_sh_br_ops_eng_scene;
  level._id_EC85["mac"]["SH3_11_EUR_SH_BR_OPS_ENG_waiting_idle"][0] = % sh3_11_eur_sh_br_ops_eng_waiting_idle;
  level._id_EC85["salter"]["SH3_11B_EUR_SH_BR_OPS_XO_scene"] = % sh3_11b_eur_sh_br_ops_xo_scene;
  level._id_EC85["mac"]["SH3_12_EUR_SH_BR_BRIEF_ENG_ops_setup"] = % sh3_12_eur_sh_br_brief_eng_ops_setup;
  level._id_EC85["gator"]["SH3_12_EUR_SH_BR_BRIEF_NAV_checkrange"] = % sh3_12_eur_sh_br_brief_nav_checkrange;
  level._id_EC85["gator"]["SH3_12_EUR_SH_BR_BRIEF_NAV_intro"] = % sh3_12_eur_sh_br_brief_nav_intro;
  level._id_EC85["gator"]["SH3_12_EUR_SH_BR_BRIEF_NAV_nag"] = % sh3_12_eur_sh_br_brief_nav_nag;
  level._id_EC85["salter"]["SH3_12_EUR_SH_BR_BRIEF_XO_ops_arrive"] = % sh3_12_eur_sh_br_brief_xo_ops_arrive;
  level._id_EC85["salter"]["SH3_13_EUR_SH_BR_JUMP_XO_intro"] = % sh3_13_eur_sh_br_jump_xo_intro;
  level._id_EC85["mac"]["SH3_13_EUR_SH_BR_JUMP_ENG_intro"] = % sh3_13_eur_sh_br_jump_eng_intro;
  level._id_EC85["gator"]["SH3_13_EUR_SH_BR_JUMP_NAV_intro"] = % sh3_13_eur_sh_br_jump_nav_intro;
  level._id_EC85["gator"]["SH3_13_EUR_SH_BR_JUMP_NAV_idle"][0] = % sh3_13_eur_sh_br_jump_nav_idle;
  level._id_EC85["gator"]["SH3_13_EUR_SH_BR_JUMP_NAV_move_plr_station"] = % sh3_13_eur_sh_br_jump_nav_move_plr_station;
  level._id_EC85["salter"]["leave_elevator_performance"] = % sh3_14_eur_sh_elev_xo_scene;
  level._id_EC85["mac"]["leave_elevator_performance"] = % sh3_14_eur_sh_elev_eng_scene;
  level._id_EC85["griff"]["armory_officer_intro_idle"][0] = % shipcrib_armory_idlea_01;
  level._id_EC85["griff"]["armory_officer_intro"] = % shipcrib_titan_armorer_loadout_01;
  level._id_EC85["mac"]["armory_booth_enter"] = % shipcrib_titan_armory_booth_mco_enter;
  level._id_EC85["mac"]["armory_booth_idle"][0] = % shipcrib_titan_armory_booth_mco_idle;
  level._id_EC85["salter"]["armory_booth_enter"] = % shipcrib_titan_armory_booth_mco_enter;
  level._id_EC85["salter"]["armory_booth_idle"][0] = % shipcrib_titan_armory_booth_mco_idle;
  level._id_EC85["gibson"]["SH3_17A_EUR_ELEV_AIR_intro"] = % sh3_17a_eur_elev_air_intro;
  level._id_EC85["salter"]["SH3_17A_EUR_ELEV_XO_intro"] = % sh3_17a_eur_elev_xo_intro;
  level._id_EC85["mac"]["SH3_17A_EUR_ELEV_ENG_intro"] = % sh3_17a_eur_elev_eng_intro;
  level._id_EC85["gibson"]["SH3_17A_EUR_ELEV_AIR_idle"][0] = % sh3_17a_eur_elev_air_idle;
  level._id_EC85["salter"]["SH3_17A_EUR_ELEV_XO_idle"][0] = % sh3_17a_eur_elev_xo_idle;
  level._id_EC85["mac"]["SH3_17A_EUR_ELEV_ENG_idle"][0] = % sh3_17a_eur_elev_eng_idle;
  level._id_EC85["gibson"]["SH3_17A_EUR_ELEV_AIR_exit"] = % sh3_17a_eur_elev_air_exit;
  level._id_EC85["salter"]["SH3_17A_EUR_ELEV_XO_exit"] = % sh3_17a_eur_elev_xo_exit;
  level._id_EC85["mac"]["SH3_17A_EUR_ELEV_ENG_exit"] = % sh3_17a_eur_elev_eng_exit;
  level._id_EC85["kloos"]["SH3_17C_EUR_JACKAL_KLO_start_idle"][0] = % sh3_17c_eur_jackal_pu_klo_start_idle;
  level._id_EC85["kloos"]["SH3_17C_EUR_JACKAL_KLO_jump_down"] = % sh3_17c_eur_jackal_pu_klo_jump_down;
  level._id_EC85["kloos"]["SH3_17C_EUR_JACKAL_KLO_idle"][0] = % sh3_17c_eur_jackal_klo_idle;
  level._id_EC88["kloos"]["shipcrib_kls_shesallyourssir"] = % sh3_17c_eur_jackal_pu_klo_face_01;
  level._id_EC85["kloos"]["jackal_mount"] = % jackal_kloos_mount_europa;
  scripts\sp\anim::_id_17FC("kloos", "mayhem_start", "mayhem_start", "jackal_mount");
  scripts\sp\anim::_id_17FC("kloos", "mayhem_end", "mayhem_end", "jackal_mount");
  level._id_EC85["salter"]["SH3_17B_EUR_HANGAR_XO_pip"] = % sh3_17b_eur_hangar_xo_pip;
  level._id_EC85["salter"]["SH3_18_EUR_DECK_JACKAL_XO_pip01"] = % sh3_18_eur_deck_jackal_xo_pip01;
  level._id_EC85["gibson"]["SH3_18_EUR_DECK_JACKAL_AIR_pip01"] = % sh3_18_eur_deck_jackal_air_pip01;
  level._id_EC85["salter"]["jackal_getin"] = % moon_jackaltakeoff_salter_getin;
  level._id_EC85["mac"]["jackal_getin"] = % moon_jackaltakeoff_salter_getin;
  level._id_EC85["generic"]["jackal_getin"] = % moon_jackaltakeoff_salter_getin;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_a_guy01"][0] = % shipcrib_hangar_fod_walk_a_guy01;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_b_guy01"][0] = % shipcrib_hangar_fod_walk_b_guy01;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_b_guy02"][0] = % shipcrib_hangar_fod_walk_b_guy02;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_c_guy01"][0] = % shipcrib_hangar_fod_walk_c_guy01;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_c_guy02"][0] = % shipcrib_hangar_fod_walk_c_guy02;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_d_guy02"][0] = % shipcrib_hangar_fod_walk_d_guy02;
  level._id_EC85["generic"]["shipcrib_hangar_fod_walk_manager01"][0] = % shipcrib_hangar_fod_walk_manager01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_01"][0] = % shipcrib_hangar_crate_idlea_01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_03"][0] = % shipcrib_hangar_crate_idlea_03;
  level._id_EC85["generic"]["shipcrib_inspection_90_high_idle"] = % shipcrib_inspection_90_high_idle;
  level._id_EC85["generic"]["shipcrib_inspection_90_low_idle"] = % shipcrib_inspection_90_low_idle;
  level._id_EC85["generic"]["shipcrib_inspection_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["shipcrib_jackal_serv_grnd_A"]["intro_idle"][0] = % rogue_shipcrib_hangar_jackal_serv_guya_intro_idle;
  level._id_EC85["shipcrib_jackal_serv_grnd_A"]["intro"] = % rogue_shipcrib_hangar_jackal_serv_guya_intro;
  level._id_EC85["shipcrib_jackal_serv_grnd_B"]["intro_idle"][0] = % rogue_shipcrib_hangar_jackal_serv_guyb_intro_idle;
  level._id_EC85["shipcrib_jackal_serv_grnd_B"]["intro"] = % rogue_shipcrib_hangar_jackal_serv_guyb_intro;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["base_idle"] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["vig_01"] = % shipcrib_stand_idle04_vig_01;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["vig_02"] = % shipcrib_stand_idle04_vig_02;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["vig_large"] = % shipcrib_stand_idle04_vig_large;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["intro"] = % rogue_shipcrib_hangar_jackal_serv_guyc_intro;
  level._id_EC85["generic"]["shipcrib_hangar_nitro_term_serv_01_idle"][0] = % shipcrib_hangar_nitro_term_serv_01_idle;
  level._id_EC85["generic"]["shipcrib_hangar_nitro_term_serv_01_raise"] = % shipcrib_hangar_nitro_term_serv_01_raise;
  level._id_EC85["generic"]["shipcrib_hangar_nitro_term_serv_01_loop_01"] = % shipcrib_hangar_nitro_term_serv_01_loop_01;
  level._id_EC85["generic"]["shipcrib_hangar_nitro_term_serv_01_loop_02"] = % shipcrib_hangar_nitro_term_serv_01_loop_02;
  level._id_EC85["generic"]["shipcrib_hangar_ramp_agent_exit"] = % shipcrib_hangar_ramp_agent_exit;
  level._id_EC85["generic"]["shipcrib_hangar_ramp_agent_loop"][0] = % shipcrib_hangar_ramp_agent_loop;
  level._id_EC85["generic"]["shipcrib_hangar_crate_move01_idle01_guyb"][0] = % shipcrib_hangar_crate_move01_idle01_guyb;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_01_idle_01"][0] = % shipcrib_hangar_c12_event_marine_01_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_01_idle_02"][0] = % shipcrib_hangar_c12_event_marine_01_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_02_idle_01"][0] = % shipcrib_hangar_c12_event_marine_02_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_02_idle_02"][0] = % shipcrib_hangar_c12_event_marine_02_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_03_idle_02"][0] = % shipcrib_hangar_c12_event_marine_03_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_04_idle_01"][0] = % shipcrib_hangar_c12_event_marine_04_idle_01;
  level._id_EC85["generic"]["shipcrib_standing_console_idle_02"][0] = % shipcrib_standing_console_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_crane_load_B_guy02_exit"][0] = % shipcrib_hangar_crane_load_b_guy02_exit;
  level._id_EC85["generic"]["shipcrib_hangar_crane_load_C_guy01_exit"][0] = % shipcrib_hangar_crane_load_c_guy01_exit;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_spectator_06_idle_01"][0] = % shipcrib_hangar_c12_event_spectator_06_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_spectator_06_idle_02"][0] = % shipcrib_hangar_c12_event_spectator_06_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_spectator_06_reveal"] = % shipcrib_hangar_c12_event_spectator_06_reveal;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_spectator_07_idle_01"][0] = % shipcrib_hangar_c12_event_spectator_07_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_spectator_07_idle_02"][0] = % shipcrib_hangar_c12_event_spectator_07_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_spectator_07_reveal"] = % shipcrib_hangar_c12_event_spectator_07_reveal;
  level._id_EC85["generic"]["sceneblock_walk_loop"][0] = % hm_grnd_grn_walk_casual_forward01;
  level._id_EC85["generic"]["stand_idle"][0] = % shipcrib_bridge_door_officer_idle_01;
  level._id_EC85["generic"]["stand_hands_tied_idle"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["salter"]["stand_hands_tied_idle"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["gibson"]["stand_hands_tied_idle"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["generic"]["shipcrib_crouch_point_idle_01"][0] = % shipcrib_crouch_point_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_01"][0] = % shipcrib_stand_stationary_talk_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_idle01_arrival"] = % shipcrib_stand_idle01_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle01_exit"] = % shipcrib_stand_idle01_exit;
  level._id_EC89["generic"]["shipcrib_stand_idle01_arrival"] = 0.5;
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
  level._id_EC88["salter"]["shipcrib_slt_illpassnonewsis"] = % sh3_8_eur_bridge_v3_pu_facial_salter_face;
  level._id_EC88["salter"]["sc_europa_slt_sixontwelveoff"] = % sh3_8_eur_bridge_v3_facial_salter_face;
  level._id_EC88["sotomura"]["sc_europa_bts_chiefsbeenwaiting"] = % sh3_10_eur_sh_br_pre_v3_pu_facial_boats_face_01;
  level._id_EC88["salter"]["sc_europa_slt_chiefsinherelement"] = % sh3_10_11_15_eur_salter_face_01;
  level._id_EC88["salter"]["sc_europa_slt_thatintelsgonnapayoff"] = % sh3_10_11_15_eur_salter_face_02;
  level._id_EC88["salter"]["sc_europa_slt_letsgotoworkcaptainigot"] = % sh3_10_11_15_eur_salter_face_03;
  level._id_EC88["salter"]["sc_europa_slt_igotbulletsidontwant"] = % sh3_10_11_15_eur_salter_face_04;
  level._id_EC88["salter"]["sc_europa_slt_settojet"] = % sh3_10_11_15_eur_salter_face_05;
  level._id_EC88["gator"]["sc_europa_nav_sironceyouvelo"] = % sh3_11_eur_sh_br_ops_nav_face_01;
  level._id_EC88["gator"]["sc_europa_nav_nextmission"] = % sh3_11_eur_sh_br_ops_nav_face_02;
  level._id_EC88["generic"]["shipcrib_un2_yourjackalsupon"] = % shipcrib_europa_point_reaction_ling_face;
  level._id_EC88["generic"]["shipcrib_un3_captain"] = % shipcrib_europa_salute_lee_face;
  level._id_EC85["jack"]["pr_pose_hamilton_01"] = % pr_pose_hamilton_01;
}

_id_EA8E(var_0) {
  level._id_EA2C _meth_82A2(%mayhem_sh3_8_eur_bridge_hallway_pu_xo, 1.0, 0.0, 1.0);
  level._id_EA2C detach(level._id_EA2C._id_10B31);
}

_id_EA8D(var_0) {
  level._id_EA2C clearanim(%mayhem_sh3_8_eur_bridge_hallway_pu_xo, 0.0);
  level._id_EA2C attach(level._id_EA2C._id_10B31);
}

#using_animtree("script_model");

_id_EE1D() {
  level._id_EC87["door"] = #animtree;
  level._id_EC8C["door"] = "door_metal_single_hinged_right";
  level._id_EC87["jackal_helmet"] = #animtree;
  level._id_EC8C["jackal_helmet"] = "hero_jackal_helmet_a";
  level._id_EC85["jackal_helmet"]["jackal_dismount"] = % sh3_1b_eur_tablet_helm_intro;
  level._id_EC87["jackal_tablet"] = #animtree;
  level._id_EC8C["jackal_tablet"] = "p7_desk_metal_military_03_tablet_europa";
  level._id_EC85["jackal_tablet"]["jackal_dismount"] = % sh3_1b_eur_tablet_tablet_intro;
  level._id_EC85["jackal_tablet"]["jackal_dismount_idle"][0] = % sh3_1b_eur_tablet_tablet_idle;
  level._id_EC85["opsmap_phone_xo"]["SH3_12_EUR_SH_BR_BRIEF_PHONE_intro"] = % sh3_12_eur_sh_br_brief_phone_intro;
  level._id_EC85["opsmap_monitor_nav"]["SH3_12_EUR_SH_BR_BRIEF_MONITOR_intro"] = % sh3_12_eur_sh_br_brief_monitor_intro;
  level._id_EC87["fod_tablet"] = #animtree;
  level._id_EC8C["fod_tablet"] = "p7_desk_metal_military_03_tablet_europa";
  level._id_EC85["fod_tablet"]["shipcrib_hangar_fod_walk_manager01_tablet"][0] = % shipcrib_hangar_fod_walk_manager01_tablet;
  level._id_EC85["jackal_helmet"]["jackal_mount"] = % sh3_17c_eur_jackal_helm;
  level._id_EC87["ammo_crate"] = #animtree;
  level._id_EC8C["ammo_crate"] = "ammo_crate_01";
  level._id_EC85["ammo_crate"]["shipcrib_hangar_crane_load_B_box01_exit"][0] = % shipcrib_hangar_crane_load_b_box01_exit;
  level._id_EC85["ammo_crate"]["shipcrib_hangar_crane_load_B_box02_exit"][0] = % shipcrib_hangar_crane_load_b_box02_exit;
  level._id_EC85["ammo_crate"]["shipcrib_hangar_crane_load_C_box01_exit"][0] = % shipcrib_hangar_crane_load_c_box01_exit;
  level._id_EC85["ammo_crate"]["shipcrib_hangar_crane_load_C_box02_exit"][0] = % shipcrib_hangar_crane_load_c_box02_exit;
  level._id_EC87["toolbox"] = #animtree;
  level._id_EC8C["toolbox"] = "equipment_industrial_toolbox_02";
  level._id_EC85["toolbox"]["shipcrib_hangar_crane_load_B_box01_exit"] = % shipcrib_hangar_crane_load_b_box01_exit;
  level._id_EC87["do_toolbox"] = #animtree;
  level._id_EC8C["do_toolbox"] = "equipment_industrial_toolbox_02";
  level._id_EC85["do_toolbox"]["SH3_11_EUR_SH_BR_OPS_DO_idle_toolbox"] = % sh3_11_eur_sh_br_ops_do_idle_toolbox;
  level._id_EC85["do_toolbox"]["SH3_11_EUR_SH_BR_OPS_DO_intro_toolbox"] = % sh3_11_eur_sh_br_ops_do_intro_toolbox;
}

vehicle_badplace() {}

_id_1F3F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  if(isDefined(var_4)) {
    var_4 endon(var_3);
  } else {
    var_5 endon(var_3);
  }

  if(isarray(var_0)) {
    foreach(var_7 in var_0) {
      if(!isai(var_7) || isalive(var_7)) {
        var_5 thread _id_1F40(var_7, var_1, var_2, var_3, var_4);
      }
    }
  } else {
    var_7 = var_0;

    if(!isai(var_7) || isalive(var_7)) {
      var_5 thread _id_1F40(var_7, var_1, var_2, var_3, var_4);
    }
  }
}

_id_1F40(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("stop_anim_single_to_loop_solo");

  if(isai(var_0)) {
    var_0 endon("death");
  }

  var_5 = self;

  if(isDefined(var_4) && isDefined(var_3)) {
    var_4 endon(var_3);
  } else if(isDefined(var_3)) {
    var_5 endon(var_3);
  }

  if(isDefined(var_0)) {
    if(!isai(var_0) || isalive(var_0)) {
      var_5 scripts\sp\anim::_id_1F35(var_0, var_1);

      if(isDefined(var_4)) {
        var_5 = var_4;
      }

      var_5 thread scripts\sp\anim::_id_1EEA(var_0, var_2, var_3);
    }
  }
}

_id_1F3D(var_0, var_1) {
  var_2 = self;

  foreach(var_4 in var_0) {
    var_2 thread _id_1F3E(var_4, var_1);
  }
}

_id_1F3E(var_0, var_1, var_2) {
  var_3 = self;
  var_3 scripts\sp\anim::_id_1F35(var_0, var_1);
  var_0 delete();
}