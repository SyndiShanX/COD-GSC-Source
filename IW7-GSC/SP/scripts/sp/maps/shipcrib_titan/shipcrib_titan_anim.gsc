/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_titan\shipcrib_titan_anim.gsc
******************************************************************/

main() {
  _id_775D();
  _id_EE1D();
  scripts\engine\utility::flag_wait("shipcrib_titan_prime_tr_loaded");
  _id_CF63();
  _id_775E();
  _id_EE1E();
  vehicle_becomes_crashable();
}

#using_animtree("player");

_id_CF63() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["titan_armory_enter"] = % shipcrib_titan_armory_plr_pcap_enter_cam;
  level._id_EC85["player_rig"]["titan_armory_exit"] = % sh4_6_1_ttn_arm_elev_plr;
  level._id_EC85["player_rig"]["shipcrib_plr_opsmap_grab"] = % shipcrib_plr_opsmap_grab;
  level._id_EC85["player_rig"]["plr_enter_seat"] = % shipcrib_titan_10_plr_enter_seat_visorup;
  level._id_EC85["player_rig"]["plr_seat_look"] = % shipcrib_titan_10_plr_takeoff_into_titan;
  scripts\sp\anim::_id_17F6("player_rig", "trigger_takeoff_seq", scripts\sp\maps\shipcrib_titan\shipcrib_titan::_id_5E89, "plr_enter_seat");
  scripts\sp\anim::_id_17F6("player_rig", "trigger_gun_stow", ::_id_110C7, "plr_enter_seat");
  scripts\sp\anim::_id_17F6("player_rig", "helmet_on_visor_up_no_audio", ::_id_8DE2, "plr_enter_seat");
  level._id_EC85["player_rig"]["intro_dropoff_scene"] = % titan_dropship_plr_exit;
  level._id_EC89["player_rig"]["intro_dropoff_scene"] = 3;
  level._id_EC85["player_rig"]["SH4_2_3_SH_TTN_BR_OPS_PLR_ftl"] = % sh4_2_3_sh_ttn_br_ops_plr_ftl;
  level._id_EC87["fake_player_rig"] = #animtree;
  level._id_EC8C["fake_player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["fake_player_rig"]["intro_dropoff_scene"] = % titan_dropship_plr_exit;
  level._id_EC89["fake_player_rig"]["intro_dropoff_scene"] = 3;
}

#using_animtree("generic_human");

_id_775D() {
  level._id_EC85["generic"]["stand_idle"][0] = % shipcrib_bridge_door_officer_idle_01;
  level._id_EC85["generic"]["stand_idle_4"][0] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EC85["generic"]["stand_idle_2"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["salter"]["jackal_idle"][0] = % shipcrib_jackal_salter_idle;
  level._id_EC85["salter"]["jackal_exit"] = % shipcrib_jackal_salter_exit;
  level._id_EC85["kloos"]["jackal_dismount"] = % sh4_3_2_ttn_land_klo_pull;
  level._id_EC85["kloos"]["jackal_dismount_idle"][0] = % sh4_3_2_ttn_land_klo_end_idle;
  level._id_EC85["gibson"]["elevator_depart"] = % sh4_3_3_ttn_return_air_exit;
  level._id_EC85["gibson"]["stand_hands_tied_idle"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["salter"]["stand_hands_tied_idle"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["salter"]["return_elevator_performance"] = % sh4_4_ttn_deck2_xo_pcap;
  level._id_EC85["generic"]["fspar_dismissed_01"] = % sh4_3_3_ttn_return_pu_dismissed_01;
  level._id_EC85["generic"]["fspar_dismissed_02"] = % sh4_3_3_ttn_return_pu_dismissed_02;
  level._id_EC85["generic"]["fspar_dismissed_03"] = % sh4_3_3_ttn_return_pu_dismissed_03;
  level._id_EC85["generic"]["fspar_dismissed_04"] = % sh4_3_3_ttn_return_pu_dismissed_04;
  level._id_EC85["generic"]["fspar_inspect_01"][0] = % shipcrib_inspection_90_low_idle;
  level._id_EC85["generic"]["fspar_inspect_02"][0] = % shipcrib_hangar_fod_walk_manager02;
  level._id_EC85["generic"]["service_jackal_enter_left"] = % jackala_service_enter_guyb;
  level._id_EC85["generic"]["service_jackal_idle_left"][0] = % jackala_service_idle_guyb;
  level._id_EC85["generic"]["service_jackal_enter_right"] = % jackala_service_enter_guyb;
  level._id_EC85["generic"]["service_jackal_idle_right"][0] = % jackala_service_idle_guyb;
  level._id_EC85["generic"]["salter_jackal_exit"] = % shipcrib_1_1_salter_jackal_exit;
  level._id_EC85["generic"]["shipcrib_crouch_point_idle_01"][0] = % shipcrib_crouch_point_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_02"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["shipcrib_stand_idle02_arrival"] = % shipcrib_stand_idle02_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle02_exit"] = % shipcrib_stand_idle02_exit;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_03"][0] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["generic"]["shipcrib_stand_idle03_arrival"] = % shipcrib_stand_idle03_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle03_exit"] = % shipcrib_stand_idle03_exit;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_04"][0] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EC85["generic"]["shipcrib_stand_idle04_arrival"] = % shipcrib_stand_idle04_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle04_exit"] = % shipcrib_stand_idle04_exit;
  level._id_EC89["generic"]["shipcrib_stand_idle04_exit"] = 0.5;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_05"][0] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EC85["generic"]["shipcrib_stand_idle05_arrival"] = % shipcrib_stand_idle05_arrival;
  level._id_EC85["generic"]["shipcrib_stand_idle05_exit"] = % shipcrib_stand_idle05_exit;
  level._id_EC88["salter"]["sc_titan_slt_illhangbacknon"] = % sh4_4_ttn_hallway_xo_face_01;
  level._id_EC88["salter"]["shipcrib_slt_letskeepthisonatight"] = % sh_ttn_4_5_hallway_xo_face_01;
  level._id_EC85["newsGuy1"]["newsguy_idle"][0] = % sh4_5_1_ttn_hallway_ally01_idle;
  level._id_EC85["newsGuy1"]["newsguy_performance"] = % sh4_5_1_ttn_hallway_ally01_scene;
  level._id_EC85["newsGuy2"]["newsguy_idle"][0] = % sh4_5_1_ttn_hallway_ally02_idle;
  level._id_EC85["newsGuy2"]["newsguy_performance"] = % sh4_5_1_ttn_hallway_ally02_scene;
  level._id_EC85["generic"]["hallway_hustle"][0] = % shipcrib_hangar_guy_hustle_idle_kneel;
  level._id_EC85["salter"]["SH4_2_1_SH_TTN_BR_PRE_XO_intro"] = % sh4_2_1_sh_ttn_br_pre_xo_intro;
  level._id_EC88["salter"]["sc_titan_slt_whereareweaimin"] = % sh4_2_1_sh_ttn_br_pre_xo_face;
  level._id_EC85["gator"]["SH4_2_1_SH_TTN_BR_PRE_NAV_steeldrag_idle"][0] = % sh4_2_1_sh_ttn_br_pre_nav_steeldrag_idle;
  level._id_EC85["gator"]["SH4_2_1_SH_TTN_BR_PRE_NAV_intro"] = % sh4_2_1_sh_ttn_br_pre_nav_intro;
  level._id_EC85["drop_officer"]["SH4_2_1_SH_TTN_BR_PRE_DO_steeldrag_idle"][0] = % sh4_2_1_sh_ttn_br_pre_do_steeldrag_idle;
  level._id_EC85["drop_officer"]["SH4_2_1_SH_TTN_BR_PRE_DO_intro"] = % sh4_2_1_sh_ttn_br_pre_do_intro;
  level._id_EC85["sotomura"]["SH4_2_1_SH_TTN_BR_PRE_BSN_monitor_idle"][0] = % sh4_2_1_sh_ttn_br_pre_bsn_monitor_idle;
  level._id_EC85["sotomura"]["SH4_2_1_SH_TTN_BR_PRE_BSN_intro"] = % sh4_2_1_sh_ttn_br_pre_bsn_intro;
  level._id_EC85["gator"]["SH4_2_2a_SH_TTN_BR_BRIEF_NAV_intro"] = % sh4_2_2a_sh_ttn_br_brief_nav_intro;
  level._id_EC85["gator"]["SH4_2_2a_SH_TTN_BR_BRIEF_NAV_outro"] = % sh4_2_2a_sh_ttn_br_brief_nav_outro;
  level._id_EC85["drop_officer"]["SH4_2_2a_SH_TTN_BR_BRIEF_DO_intro"] = % sh4_2_2a_sh_ttn_br_brief_do_intro;
  level._id_EC85["salter"]["shipcrib_stand_idle05_exit"] = % shipcrib_stand_idle05_exit;
  level._id_EC85["salter"]["shipcrib_stand_idle05_vig_02"] = % shipcrib_stand_idle05_vig_02;
  level._id_EC85["salter"]["SH4_2_2a_SH_TTN_BR_BRIEF_XO_intro"] = % sh4_2_2a_sh_ttn_br_brief_xo_intro;
  level._id_EC85["salter"]["SH4_2_2a_SH_TTN_BR_BRIEF_XO_screen_idle"][0] = % sh4_2_2a_sh_ttn_br_brief_xo_screen_idle;
  level._id_EC85["salter"]["SH4_2_2a_SH_TTN_BR_BRIEF_XO_screen_01"] = % sh4_2_2a_sh_ttn_br_brief_xo_screen_01;
  level._id_EC85["salter"]["SH4_2_2a_SH_TTN_BR_BRIEF_XO_screen_02"] = % sh4_2_2a_sh_ttn_br_brief_xo_screen_02;
  level._id_EC85["salter"]["SH4_2_2a_SH_TTN_BR_BRIEF_XO_cic_idle"][0] = % sh4_2_2a_sh_ttn_br_brief_xo_cic_idle;
  level._id_EC85["salter"]["SH4_2_2a_SH_TTN_BR_BRIEF_XO_cic_01"] = % sh4_2_2a_sh_ttn_br_brief_xo_cic_01;
  level._id_EC89["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_screen_arrive"] = 0.0;
  level._id_EC85["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_screen_arrive"] = % sh4_2_2a_sh_ttn_br_brief_adm_screen_arrive;
  level._id_EC89["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_screen_01"] = 0.0;
  level._id_EC85["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_screen_01"] = % sh4_2_2a_sh_ttn_br_brief_adm_screen_01;
  level._id_EC85["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_cic_01"] = % sh4_2_2a_sh_ttn_br_brief_adm_cic_01;
  level._id_EC85["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_screen_idle"][0] = % sh4_2_2a_sh_ttn_br_brief_adm_screen_idle;
  level._id_EC85["sotomura"]["SH4_2_2a_SH_TTN_BR_BRIEF_BSN_station_respond"] = % sh4_2_2a_sh_ttn_br_brief_bsn_station_respond;
  level._id_EC85["sotomura"]["SH4_2_2a_SH_TTN_BR_BRIEF_BSN_cic_arrive"] = % sh4_2_2a_sh_ttn_br_brief_bsn_cic_arrive;
  level._id_EC85["sotomura"]["SH4_2_2a_SH_TTN_BR_BRIEF_BSN_cic_01"] = % sh4_2_2a_sh_ttn_br_brief_bsn_cic_01;
  level._id_EC85["comms"]["SH4_2_2a_SH_TTN_BR_BRIEF_COMM_station_respond"] = % sh4_2_2a_sh_ttn_br_brief_comm_station_respond;
  level._id_EC85["salter"]["SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop"] = % sh4_2_3_sh_ttn_br_ops_xo_ftl_drop;
  level._id_EC85["salter"]["SH4_2_3_SH_TTN_BR_OPS_XO_to_plr_ops"] = % sh4_2_3_sh_ttn_br_ops_xo_to_plr_ops;
  level._id_EC85["salter"]["SH4_2_3_SH_TTN_BR_OPS_XO_plr_ops_idle"][0] = % sh4_2_3_sh_ttn_br_ops_xo_plr_ops_idle;
  level._id_EC88["salter"]["sc_titan_slt_alwaysboatstake"] = % sh4_2_3_sh_ttn_br_ops_xo_face_01;
  level._id_EC88["salter"]["sc_titan_slt_notgonnaleta"] = % sh4_2_3_sh_ttn_br_ops_xo_face_02;
  level._id_EC85["gator"]["SH4_2_3_SH_TTN_BR_OPS_NAV_ftl_drop"] = % sh4_2_3_sh_ttn_br_ops_nav_ftl_drop;
  level._id_EC85["drop_officer"]["SH4_2_3_SH_TTN_BR_OPS_DO_ftl_drop"] = % sh4_2_3_sh_ttn_br_ops_do_ftl_drop;
  level._id_EC85["sotomura"]["SH4_2_3_SH_TTN_BR_OPS_BSN_ftl_drop"] = % sh4_2_3_sh_ttn_br_ops_bsn_ftl_drop;
  level._id_EC88["sotomura"]["sc_titan_us1_sergeantomarssetup"] = % sh4_2_3_sh_ttn_br_ops_bsn_face_01;
  level._id_EC88["gator"]["titan_sc_nav_LeaveittoMaCallum"] = % sh4_2_4_sh_ttn_br_branch_nav_face_01;
  level._id_EC88["gator"]["titan_sc_nav_SteelDragon"] = % sh4_2_4_sh_ttn_br_branch_nav_face_02;
  level._id_EC88["gator"]["titan_sc_nav_Iwonderwhather"] = % sh4_2_4_sh_ttn_br_branch_nav_face_03;
  level._id_EC88["gator"]["titan_sc_nav_Imlookingforwardto"] = % sh4_2_5_sh_ttn_br_branch_nav_face_01;
  level._id_EC88["salter"]["titan_sc_slt_Youshouldhaveseen"] = % sh4_2_5_sh_ttn_br_branch_xo_face_01;
  level._id_EC88["drop_officer"]["titan_sc_un2_telemetryislookinggood"] = % sh4_2_8_sh_ttn_br_branch_do_face_01;
  level._id_EC88["sotomura"]["titan_sc_un4_Payloadshouldinthe"] = % sh4_2_9_sh_ttn_br_branch_bsn_face_01;
  level._id_EC88["sotomura"]["sc_titan_abn_threedecadessinceweve"] = % sh4_2_10_sh_ttn_br_elev_bsn_01_face_01;
  level._id_EC85["generic"]["shipcrib_brdg_door1_salute_01"] = % shipcrib_brdg_door1_salute_01;
  level._id_EC85["generic"]["shipcrib_brdg_srvr1_salute_01"] = % shipcrib_brdg_srvr1_salute_01;
  level._id_EC85["generic"]["shipcrib_brdg_srvr2_salute_01"] = % shipcrib_brdg_srvr2_salute_01;
  level._id_EC85["generic"]["shipcrib_brdg_sys3_salute"] = % shipcrib_salute_reaction_l90_01;
  level._id_EC85["generic"]["shipcrib_brdg_tac3_salute"] = % shipcrib_salute_reaction_l00_01;
  level._id_EC85["generic"]["shipcrib_brdg_tac3_salute_idle"][0] = % shipcrib_salute_reaction_idle_01;
  level._id_EC85["generic"]["shipcrib_salute_reaction_idle_01"][0] = % shipcrib_salute_reaction_idle_01;
  level._id_EC85["generic"]["shipcrib_salute_reaction_r30_01"] = % shipcrib_salute_reaction_r30_01;
  level._id_EC85["generic"]["shipcrib_stand_salute_l00_01"] = % shipcrib_stand_salute_l00_01;
  level._id_EC85["generic"]["shipcrib_stand_salute_idle_02"][0] = % shipcrib_stand_salute_idle_02;
  level._id_EC85["generic"]["shipcrib_guard_reaction_idle_01"][0] = % shipcrib_guard_reaction_idle_01;
}

_id_775E() {
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["generic"]["stand_stationary"] = % shipcrib_stand_stationary_idle_01;
  level._id_EC85["generic"]["stand_stationary_idle"][0] = % shipcrib_stand_stationary_idle_01;
  level._id_EC85["generic"]["stand_hands_tied_idle"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["generic"]["sceneblock_reach"] = % shipcrib_bridge_door_officer_idle_01;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_01"][0] = % shipcrib_jackal_serv_top_01;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_02"][0] = % shipcrib_jackal_serv_top_02;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_03"][0] = % shipcrib_jackal_serv_top_03;
  level._id_EC85["generic"]["hm_grnd_grn_kneel_idle_01"][0] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["sahora"]["hm_grnd_grn_kneel_idle_01"][0] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["generic"]["hm_grnd_grn_kneel_reaction_l00_01"] = % hm_grnd_grn_kneel_reaction_l00_01;
  level._id_EC85["generic"]["shipcrib_tg_highfive_01"] = % shipcrib_tg_highfive_01;
  level._id_EC85["generic"]["shipcrib_tg_highfive_02"] = % shipcrib_tg_highfive_02;
  level._id_EC85["generic"]["shipcrib_lounge_reaction_c_idle"][0] = % shipcrib_lounge_reaction_c_idle;
  level._id_EC85["generic"]["shipcrib_lounge_reaction_c_walk"] = % shipcrib_lounge_reaction_c_walk;
  level._id_EC85["generic"]["shipcrib_vr_loop_01"][0] = % shipcrib_vr_loop_01;
  level._id_EC85["generic"]["shipcrib_lounge_vrA_01"] = % shipcrib_titan_lounge_entera_02;
  level._id_EC85["generic"]["shipcrib_lounge_vrA_02"] = % shipcrib_titan_lounge_entera_01;
  level._id_EC85["generic"]["shipcrib_lounge_stool_idle_02"][0] = % shipcrib_lounge_stool_idle_02;
  level._id_EC85["generic"]["shipcrib_lounge_stool_idle_01"][0] = % shipcrib_lounge_stool_idle_01;
  level._id_EC85["generic"]["shipcrib_lounge_counter_idle_01"][0] = % shipcrib_lounge_counter_idle_01;
  level._id_EC85["generic"]["shipcrib_lounge_counter_idle_02"][0] = % shipcrib_lounge_counter_idle_02;
  level._id_EC85["generic"]["shipcrib_lounge_couch_idleA_01"][0] = % shipcrib_lounge_couch_idlea_01;
  level._id_EC85["generic"]["shipcrib_lounge_couch_idleA_02"][0] = % shipcrib_lounge_couch_idlea_02;
  level._id_EC85["generic"]["shipcrib_lounge_chess_idleA_01"][0] = % shipcrib_lounge_chess_idlea_01;
  level._id_EC85["generic"]["shipcrib_lounge_chess_idleA_02"][0] = % shipcrib_lounge_chess_idlea_02;
  level._id_EC85["generic"]["shipcrib_attn_point_idle_01"][0] = % shipcrib_attn_point_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleC_01"][0] = % shipcrib_hangar_crate_idlec_01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_01"][0] = % shipcrib_hangar_crate_idlea_01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_02"][0] = % shipcrib_hangar_crate_idlea_02;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_03"][0] = % shipcrib_hangar_crate_idlea_03;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleB_01"][0] = % shipcrib_hangar_crate_idleb_01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleB_02"][0] = % shipcrib_hangar_crate_idleb_02;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleB_03"][0] = % shipcrib_hangar_crate_idleb_03;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleB_05"][0] = % shipcrib_hangar_crate_idleb_05;
  level._id_EC85["generic"]["shipcrib_drill_sargent_02"][0] = % shipcrib_drill_sargent_02;
  level._id_EC85["generic"]["shipcrib_drill_sargent_01"][0] = % shipcrib_drill_sargent_01;
  level._id_EC85["sys2"]["shipcrib_bridge_hustle_elv_to_cms_trav_01"] = % shipcrib_bridge_hustle_elv_to_cms_trav_01;
  level._id_EC85["sys2"]["shipcrib_bridge_hustle_elv_to_cms_idle_01"][0] = % shipcrib_bridge_hustle_elv_to_cms_idle_01;
  level._id_EC85["sys1"]["shipcrib_bridge_hustle_grs_to_rad_trav_02"] = % shipcrib_bridge_hustle_grs_to_rad_trav_02;
  level._id_EC85["sys1"]["shipcrib_bridge_hustle_grs_to_rad_idle_01"][0] = % shipcrib_bridge_hustle_grs_to_rad_idle_01;
  level._id_EC85["sys1"]["shipcrib_bridge_hustle_grs_to_rad_idle_02"][0] = % shipcrib_bridge_hustle_grs_to_rad_idle_02;
  level._id_EC85["sys3"]["shipcrib_bridge_hustle_elv_to_sys_trav_01"] = % shipcrib_bridge_hustle_elv_to_sys_trav_01;
  level._id_EC85["sotomura"]["shipcrib_stand_stationary_talk_idle_05"][0] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EC89["sotomura"]["shipcrib_stand_stationary_talk_idle_05"] = 2.0;
  level._id_EC85["sotomura"]["leave_elevator_performance"] = % sh4_2_10_sh_ttn_br_elev_bsn_01_pcap;
  level._id_EC8A["sotomura"]["leave_elevator_performance"] = % sh4_2_10_sh_ttn_br_elev_bsn_01_pcap_head;
  level._id_EC85["sotomura"]["shipcrib_bridge_stand_console_transition_out"] = % shipcrib_bridge_stand_console_transition_out;
  level._id_EC88["sotomura"]["sc_titan_abn_threedecadessinceweve"] = % sh4_2_10_sh_ttn_br_elev_bsn_01_face_01;
  level._id_EC88["sotomura"]["sc_titan_abn_followmeifyou"] = % sh4_2_10_sh_ttn_br_elev_bsn_01_face_02;
  level._id_EC88["sotomura"]["sc_titan_abn_sergeantomarshouldbe"] = % sh4_2_10_sh_ttn_br_elev_bsn_01_face_03;
  level._id_EC85["hero_char"]["titan_armory_enter"] = % shipcrib_titan_armory_plr_pcap_enter;
  level._id_EC85["griff"]["titan_armory_enter"] = % shipcrib_titan_armory_arm_pcap_intro;
  level._id_EC85["omar"]["titan_armory_enter"] = % shipcrib_titan_armory_mco_pcap_intro;
  level._id_EC85["crew_1"]["titan_armory_enter"] = % shipcrib_titan_armory_mr1_pcap_intro;
  level._id_EC85["crew_2"]["titan_armory_enter"] = % shipcrib_titan_armory_mr2_pcap_intro;
  level._id_EC85["griff"]["terminal_intro"] = % sa_griff_arm_scene;
  level._id_EC88["griff"]["titan_sc_amo_primedsomechoicehardware"] = % sh_ttn_4_2_12_lo_arm_face_01;
  scripts\sp\anim::_id_17F6("generic", "titan_sc_amo_fullcomplimentofweapons", scripts\sp\maps\shipcrib_titan\shipcrib_titan::_id_11993);
  level._id_EC85["generic"]["armory_officer_intro_idle"][0] = % shipcrib_armory_idlea_01;
  level._id_EC85["generic"]["armory_officer_terminal_idle"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["omar"]["mco_console_exit"] = % shipcrib_titan_armory_mco_exit_console;
  level._id_EC85["omar"]["shipcrib_titan_armory_booth_mco_enter"] = % shipcrib_titan_armory_booth_mco_enter;
  level._id_EC85["omar"]["shipcrib_titan_armory_booth_mco_idle"][0] = % shipcrib_titan_armory_booth_mco_idle;
  level._id_EC85["griff"]["armory_ambient_idle"][0] = % shipcrib_armory_idlea_01;
  level._id_EC85["griff"]["armory_ambient_vig_1"] = % shipcrib_armory_idlea_vig_01;
  level._id_EC85["griff"]["armory_ambient_vig_2"] = % shipcrib_armory_idlea_vig_02;
  level._id_EC85["griff"]["armory_ambient_vig_3"] = % shipcrib_armory_idlea_vig_03;
  level._id_EC85["griff"]["armory_ambient_vig_4"] = % shipcrib_armory_idlea_vig_04;
  level._id_EC85["griff"]["armory_ambient_vig_5"] = % shipcrib_armory_idlea_vig_05;
  level._id_EC85["griff"]["armory_ambient_vig_6"] = % shipcrib_armory_idlea_vig_06;
  level._id_EC85["griff"]["armory_ambient_vig_7"] = % shipcrib_armory_idlea_vig_07;
  level._id_EC85["griff"]["armory_ambient_vig_8"] = % shipcrib_armory_idlea_vig_08;
  level._id_EC85["omar"]["airboss_elevator"] = % sh4_6_1_ttn_arm_elev_mco_scene01;
  level._id_EC85["gibson"]["airboss_elevator"] = % sh4_6_1_ttn_arm_elev_air_scene01;
  level._id_EC85["sahora"]["airboss_elevator"] = % sh4_6_1_ttn_arm_elev_rig1_scene01;
  level._id_EC85["gibson"]["airboss_elevator_exit"] = % shipcrib_titan_elevator_exit_airboss;
  level._id_EC85["generic"]["shipcrib_hangar_apc_direct_loop_01"][0] = % shipcrib_hangar_apc_direct_loop_01;
  level._id_EC85["brooks"]["dropship_start_idle"][0] = % titan_dropship_ally01_idle;
  level._id_EC85["brooks"]["dropship_enter"] = % titan_dropship_ally01_exit;
  level._id_EC85["brooks"]["dropship_idle"][0] = % shipcrib_titan_10_brooks_boardship_idle;
  level._id_EC85["brooks"]["dropship_player_enter"] = % shipcrib_titan_10_brooks_sitting_down_reaction_01;
  level._id_EC85["brooks"]["dropship_idle2"][0] = % shipcrib_titan_10_brooks_sitting_down_idle;
  level._id_EC85["brooks"]["dropship_takeoff"] = % shipcrib_titan_10_brooks_takeoff_into_titan;
  scripts\sp\anim::_id_17F6("brooks", "trigger_gun_stow", ::_id_110C7, "dropship_enter");
  scripts\sp\anim::_id_17F6("brooks", "trigger_helmet_on", ::_id_8E05, "dropship_player_enter");
  scripts\sp\anim::_id_17F6("brooks", "trigger_helmet_grab", ::_id_8DE6, "dropship_player_enter");
  level._id_EC85["kash"]["dropship_start_idle"][0] = % titan_dropship_ally02_idle;
  level._id_EC85["kash"]["dropship_enter"] = % titan_dropship_ally02_exit;
  level._id_EC85["kash"]["dropship_idle"][0] = % shipcrib_titan_10_kash_boardship_idle;
  level._id_EC85["kash"]["dropship_player_enter"] = % shipcrib_titan_10_kash_sitting_down_reaction_01;
  level._id_EC85["kash"]["dropship_player_nag"] = % shipcrib_titan_10_kash_sitting_down_reaction_02;
  level._id_EC85["kash"]["dropship_idle2"][0] = % shipcrib_titan_10_kash_sitting_down_idle;
  level._id_EC85["kash"]["dropship_takeoff"] = % shipcrib_titan_10_kash_takeoff_into_titan;
  scripts\sp\anim::_id_17F6("kash", "trigger_gun_stow", ::_id_110C7, "dropship_player_enter");
  scripts\sp\anim::_id_17F6("kash", "trigger_helmet_on", ::_id_8E05, "dropship_player_enter");
  scripts\sp\anim::_id_17F6("kash", "trigger_helmet_grab", ::_id_8DE7, "dropship_player_enter");
  level._id_EC85["boggs"]["dropship_start_idle"][0] = % shipcrib_titan_10_boggs_boardship_idle;
  level._id_EC85["boggs"]["dropship_board"] = % shipcrib_titan_10_boggs_boardship_intro;
  level._id_EC85["boggs"]["dropship_idle"][0] = % shipcrib_titan_10_boggs_seated_idle;
  level._id_EC85["generic"]["dropship_walk_up_ramp"] = % titan_dropship_ally03_intro;
  level._id_EC85["omar"]["dropship_walk_up_ramp"] = % titan_dropship_ally03_intro;
  level._id_EC85["omar"]["dropship_ramp_idle"][0] = % titan_dropship_ally03_idle;
  level._id_EC85["omar"]["dropship_takeoff"] = % shipcrib_titan_10_mco_takeoff_into_titan;
  scripts\sp\anim::_id_17F6("omar", "trigger_gun_stow", ::_id_110C7, "dropship_takeoff");
  scripts\sp\anim::_id_17F6("omar", "trigger_helmet_on", ::_id_8E05, "dropship_takeoff");
  scripts\sp\anim::_id_17F6("omar", "trigger_helmet_grab", ::_id_8DE8, "dropship_takeoff");
  level._id_EC88["omar"]["sc_titan_usf_FormupLetsgo"] = % sc_titan_usf_formupletsgo_face;
  level._id_EC88["omar"]["sc_titan_usf_KeepittightKashima"] = % sc_titan_usf_keepittightkashima_face;
  level._id_EC88["omar"]["sc_titan_usf_Noshameliberatingsome"] = % sc_titan_usf_noshameliberatingsome_face;
  level._id_EC85["ethan"]["dropship_takeoff"] = % shipcrib_titan_10_eth3n_takeoff_into_titan;
  scripts\sp\anim::_id_17F6("ethan", "trigger_gun_stow", ::_id_110C7, "dropship_takeoff");
  level._id_EC85["generic"]["shipcrib_hangar_welding_low_idle"][0] = % shipcrib_hangar_welding_low_idle;
  level._id_EC85["generic"]["shipcrib_hangar_welding_medium_idle"][0] = % shipcrib_hangar_welding_medium_idle;
  level._id_EC85["generic"]["shipcrib_hangar_welding_high_idle"][0] = % shipcrib_hangar_welding_high_idle;
}

#using_animtree("script_model");

_id_EE1D() {
  level._id_EC87["optics"] = #animtree;
  level._id_EC8C["optics"] = "equipment_lunar_spotting_scope_03";
  level._id_EC85["optics"]["SH4_2_1_SH_TTN_BR_PRE_DO_prop_steeldrag_idle"][0] = % sh4_2_1_sh_ttn_br_pre_do_prop_steeldrag_idle;
  level._id_EC85["optics"]["SH4_2_1_SH_TTN_BR_PRE_DO_prop_intro"] = % sh4_2_1_sh_ttn_br_pre_do_prop_intro;
  level._id_EC85["optics"]["SH4_2_1_SH_TTN_BR_PRE_DO_prop_OPS_idle"][0] = % sh4_2_1_sh_ttn_br_pre_do_prop_ops_idle;
}

_id_EE1E() {
  level._id_EC87["jackal_helmet"] = #animtree;
  level._id_EC8C["jackal_helmet"] = "hero_jackal_helmet_a";
  level._id_EC85["jackal_helmet"]["jackal_dismount"] = % sh4_3_2_ttn_land_helmet_pull;
  level._id_EC85["jackal_helmet"]["jackal_dismount_idle"][0] = % sh4_3_2_ttn_land_helmet_end_idle;
  level._id_EC87["griff_weapon"] = #animtree;
  level._id_EC85["griff_weapon"]["armory_ambient_idle"][0] = % shipcrib_armory_idlea_01_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_1"] = % shipcrib_armory_idlea_vig_01_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_2"] = % shipcrib_armory_idlea_vig_02_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_3"] = % shipcrib_armory_idlea_vig_03_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_4"] = % shipcrib_armory_idlea_vig_04_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_5"] = % shipcrib_armory_idlea_vig_05_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_6"] = % shipcrib_armory_idlea_vig_06_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_7"] = % shipcrib_armory_idlea_vig_07_gun;
  level._id_EC85["griff_weapon"]["armory_ambient_vig_8"] = % shipcrib_armory_idlea_vig_08_gun;
  level._id_EC87["door"] = #animtree;
  level._id_EC8C["door"] = "door_metal_single_hinged_right";
  level._id_EC85["door"]["titan_armory_enter"] = % shipcrib_titan_armory_door_pcap_intro;
  level._id_EC85["door"]["titan_armory_exit"] = % sh4_6_1_ttn_arm_elev_door;
  level._id_EC85["dropship_seat_middle_01"]["seat_ff"] = % shipcrib_titan_10_seat01_takeoff_into_titan;
  level._id_EC85["dropship_seat_middle_01"]["dropship_takeoff"] = % shipcrib_titan_10_seat01_takeoff_into_titan;
  level._id_EC85["dropship_seat_middle_01"]["static_seat_ff"] = % shipcrib_dropship_seat_closed;
  level._id_EC85["dropship_seat_right_02"]["seat_ff"] = % shipcrib_titan_10_seat03_sitting_down_reaction_01;
  level._id_EC85["dropship_seat_right_02"]["dropship_player_enter"] = % shipcrib_titan_10_seat03_sitting_down_reaction_01;
  level._id_EC85["dropship_seat_right_02"]["static_seat_ff"] = % shipcrib_dropship_seat_closed;
  level._id_EC85["dropship_seat_right_02"]["dropship_takeoff"] = % shipcrib_titan_10_seat03_takeoff_into_titan;
  level._id_EC85["dropship_seat_middle_02"]["seat_ff"] = % shipcrib_titan_10_seat06_sitting_down_reaction_01;
  level._id_EC85["dropship_seat_middle_02"]["dropship_idle"][0] = % shipcrib_titan_10_seat06_boardship_idle;
  level._id_EC85["dropship_seat_middle_02"]["dropship_player_enter"] = % shipcrib_titan_10_seat06_sitting_down_reaction_01;
  level._id_EC85["dropship_seat_middle_02"]["static_seat_ff"] = % shipcrib_dropship_seat_closed;
  level._id_EC85["dropship_seat_middle_02"]["dropship_takeoff"] = % shipcrib_titan_10_seat06_takeoff_into_titan;
  level._id_EC85["dropship_seat_left_01"]["seat_ff"] = % shipcrib_titan_10_seat07_prep_for_takeoff;
  level._id_EC85["dropship_seat_left_01"]["dropship_board"] = % shipcrib_titan_10_seat07_prep_for_takeoff;
  level._id_EC85["dropship_seat_left_01"]["plr_enter_seat"] = % shipcrib_titan_10_seat07_enter_seat;
  level._id_EC85["dropship_seat_right_01"]["seat_ff"] = % shipcrib_titan_10_seat08_takeoff_into_titan;
  level._id_EC85["dropship_seat_right_01"]["dropship_takeoff"] = % shipcrib_titan_10_seat08_takeoff_into_titan;
  level._id_EC87["dropship_seat_mount01"] = #animtree;
  level._id_EC8C["dropship_seat_mount01"] = "equipment_industrial_weapon_mount_01";
  level._id_EC85["dropship_seat_mount01"]["seat_mount_ff"] = % titan_dropship_weapon_mount_01;
  level._id_EC87["dropship_seat_mount02"] = #animtree;
  level._id_EC8C["dropship_seat_mount02"] = "equipment_industrial_weapon_mount_01";
  level._id_EC85["dropship_seat_mount02"]["seat_mount_ff"] = % titan_dropship_weapon_mount_02;
  level._id_EC87["helmet_desert"] = #animtree;
  level._id_EC8C["helmet_desert"] = "helmet_hero_protagonist_desert";
  level._id_EC85["helmet_desert"]["player_helmet_on"] = % shipcrib_titan_helmetplr_enter_seat_visorup;
  level._id_EC87["helmet_mco"] = #animtree;
  level._id_EC8C["helmet_mco"] = "helmet_hero_mco";
  level._id_EC85["helmet_mco"]["mco_helmet_on"] = % shipcrib_titan_helmet_mco;
  level._id_EC87["helmet_brooks"] = #animtree;
  level._id_EC8C["helmet_brooks"] = "helmet_hero_marine_1";
  level._id_EC85["helmet_brooks"]["brooks_helmet_on"] = % shipcrib_titan_helmet_mr1;
  level._id_EC87["helmet_kash"] = #animtree;
  level._id_EC8C["helmet_kash"] = "helmet_hero_marine_2";
  level._id_EC85["helmet_kash"]["kash_helmet_on"] = % shipcrib_titan_helmet_mr2;
  level._id_EC87["tablet"] = #animtree;
  level._id_EC8C["tablet"] = "p7_desk_metal_military_03_tablet";
  level._id_EC85["tablet"]["dropship_start_idle"][0] = % shipcrib_titan_tablet_boardship_idle;
  level._id_EC85["tablet"]["dropship_board"] = % shipcrib_titan_tablet_boardship_intro;
  level._id_EC85["tablet"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_prop_screen_idle"][0] = % sh4_2_2a_sh_ttn_br_brief_adm_prop_screen_idle;
  level._id_EC85["tablet"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_prop_screen_arrive"] = % sh4_2_2a_sh_ttn_br_brief_adm_prop_screen_arrive;
  level._id_EC85["tablet"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_prop_screen_01"] = % sh4_2_2a_sh_ttn_br_brief_adm_prop_screen_01;
  level._id_EC85["opsmap_phone_nav"]["SH4_2_2a_SH_TTN_BR_BRIEF_NAV_phone_intro"] = % sh4_2_2a_sh_ttn_br_brief_nav_phone_intro;
  level._id_EC85["opsmap_phone_nav"]["SH4_2_3_SH_TTN_BR_OPS_NAV_phone_ftl_drop"] = % sh4_2_3_sh_ttn_br_ops_nav_phone_ftl_drop;
  level._id_EC85["opsmap_monitor_nav"]["SH4_2_2a_SH_TTN_BR_BRIEF_MONITOR_intro"] = % sh4_2_2a_sh_ttn_br_brief_monitor_intro;
  level._id_EC85["opsmap_monitor_nav"]["SH4_2_3_SH_TTN_BR_OPS_NAV_MONITOR_ftl_drop"] = % sh4_2_3_sh_ttn_br_ops_nav_monitor_ftl_drop;
  level._id_EC87["shipcrib_keycard"] = #animtree;
  level._id_EC85["shipcrib_keycard"]["SH4_2_3_SH_TTN_BR_OPS_PLR_ftl_keycard"] = % sh4_2_3_sh_ttn_br_ops_plr_ftl_keycard;
  level._id_EC87["shipcrib_cap_console"] = #animtree;
  level._id_EC85["shipcrib_cap_console"]["SH4_2_3_SH_TTN_BR_OPS_PLR_ftl_table"] = % sh4_2_3_sh_ttn_br_ops_plr_ftl_table;
}

vehicle_becomes_crashable() {}

_id_110C7(var_0) {
  if(var_0._id_1FBB == "player_rig") {
    var_1 = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));
    var_1.angles = var_0 gettagangles("tag_weapon_right");
    var_1 setModel(getweaponmodel(level.player._id_110C8));
    var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  } else {
    var_0._id_86E9 = 1;
    var_0 scripts\sp\utility::_id_86E4();
    var_1 = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));
    var_1.angles = var_0 gettagangles("tag_weapon_right");
    var_1 setModel(getweaponmodel(var_0.weapon));
    var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  }
}

_id_8E05(var_0) {
  var_0._id_8E05 = 1;
  var_0 detach(var_0.hatmodel);
  var_0 attach(var_0.hatmodel);
  var_0 _id_0EF8::_id_FE00();
  var_0.helmet delete();
}

_id_8DE6(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0.helmet, "brooks_helmet_on");
}

_id_8DE7(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0.helmet, "kash_helmet_on");
}

_id_8DE8(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0.helmet, "mco_helmet_on");
}

_id_8DE9(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0.helmet, "player_helmet_on");
}

_id_8DE2(var_0) {
  wait 0.75;
  _id_0B0A::_id_583F(0, 4096, 6, 0, 300, 3, 0.5);
  wait 1;
  _id_0B0A::_id_583F(0, 0, 0, 0, 0, 0, 1);
}