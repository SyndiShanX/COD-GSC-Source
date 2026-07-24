/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrib\marscrib_anim.gsc
******************************************************/

main() {
  _id_91DC();
  _id_EE25();
  _id_13267();
  player();
  jackals();
  _id_3353();
  _id_3508();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["generic"]["walk_frantic"] = % hm_grnd_grn_walk_frantic_forward;
  level._id_EC85["generic"]["hm_grnd_grn_kneel_idle_01"][0] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC88["generic"]["marscrib_ma1_readytokicksome"] = % marscrib_un5_50_10_hr_r2;
  level._id_EC88["generic"]["marscrib_cm1_startingtothink"] = % marscrib_un6_50_30_hr_r2;
  level._id_EC88["generic"]["marscrib_ma2_setdefaintgonna"] = % marscrib_un2_50_20_hr_r2;
  level._id_EC88["generic"]["marscrib_ma4_gooddayforafigh"] = % marscrib_un4_50_60_hr_r2;
  level._id_EC88["generic"]["marscrib_cr3_theygotusgooddi"] = % marscrib_un6_50_70_hr_r2;
  level._id_EC88["generic"]["marscrib_cm2_downbutnotoutca"] = % marscrib_un7_50_40_hr_r2;
  level._id_EC88["generic"]["marscrib_cr4_captaingoodtose"] = % marscrib_un7_50_80_hr_r2;
  level._id_EC88["generic"]["marscrib_ma3_dontgoafteremwi"] = % marscrib_un3_50_50_hr_r2;
  level._id_EC85["mccallum"]["armory_idle"][0] = % mars_crib_eng_armory_idle;
  level._id_EC85["griff"]["armory_idle"][0] = % mars_crib_arm_armory_idle;
  level._id_EC85["griff"]["armory_intro"] = % mars_crib_arm_armory_intro;
  level._id_EC85["mccallum"]["armory_intro"] = % mars_crib_eng_armory_intro;
  level._id_EC85["griff"]["armory_prompt"] = % mars_crib_arm_armory_prompt;
  level._id_EC85["griff"]["armory_exit"] = % mars_crib_arm_armory_exit;
  level._id_EC88["mccallum"]["marscrib_mac_bethankfulgriffwe"] = % marscrib_mac_bethankfulgriffwe_face;
  level._id_EC88["mccallum"]["marscrib_mac_illbereadycaptain"] = % marscrib_mac_illbereadycaptain_face;
  level._id_EC88["mccallum"]["marscrib_mac_youshouldarmup"] = % marscrib_mac_youshouldarmup_face;
  level._id_EC88["griff"]["marscrib_grf_hittheterminalwhen"] = % marscrib_grf_hittheterminalwhen_face;
  level._id_EC88["griff"]["marscrib_grf_gotyourkiton"] = % marscrib_grf_gotyourkiton_face;
  level._id_EC88["griff"]["marscrib_grf_youcanpickup"] = % marscrib_grf_youcanpickup_face;
  level._id_EC85["generic"]["mars_crib_comms_bsn_inspection_idle"][0] = % mars_crib_comms_bsn_inspection_idle;
  level._id_EC85["generic"]["shipcrib_marine_idle_02_convo_02_crouch_B"][0] = % shipcrib_marine_idle_02_convo_02_crouch_b;
  level._id_EC85["generic"]["mars_crib_comms_nav_stand_lean_idle"][0] = % mars_crib_comms_nav_stand_lean_idle;
  level._id_EC85["generic"]["shipcrib_standing_console_idle_01"][0] = % shipcrib_standing_console_idle_01;
  level._id_EC88["gator"]["marscrib_gtr_captainwethoughtthe"] = % marscrib_gtr_captainwethoughtthe_face;
  level._id_EC88["gator"]["marscrib_gtr_status"] = % marscrib_gtr_status_face;
  level._id_EC88["gator"]["marscrib_gtr_thankyousirmeans"] = % marscrib_gtr_thankyousirmeans_face;
  level._id_EC88["gator"]["marscrib_nav_quiteamaneuveru"] = % marscrib_nav_quiteamaneuveru_face;
  level._id_EC88["gator"]["marscrib_nav_reportalltraffi"] = % marscrib_nav_reportalltraffi_face;
  level._id_EC88["commo"]["marscrib_cmo_werewithyoucaptain"] = % marscrib_cmo_7_100_hr_r2;
  level._id_EC88["commo"]["marscrib_cmo_radarsclearbutthey"] = % marscrib_cmo_7_20_hr_r2;
  level._id_EC88["boats"]["marscrib_bsw_youtoosir"] = % marscrib_sip_7_120_hr_r2;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secA_loop2_guyB"][0] = % shipcrib_jackal_serv_seca_loop2_guyb;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secA_idle1"][0] = % shipcrib_jackal_serv_seca_idle1;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secA_idle2"][0] = % shipcrib_jackal_serv_seca_idle2;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secA_idle3"][0] = % shipcrib_jackal_serv_seca_idle3;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secA_idle4"][0] = % shipcrib_jackal_serv_seca_idle4;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secB_idle1"][0] = % shipcrib_jackal_serv_secb_idle1;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secB_idle3"][0] = % shipcrib_jackal_serv_secb_idle3;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secC_idle2"][0] = % shipcrib_jackal_serv_secc_idle2;
  level._id_EC85["generic"]["shipcrib_jackal_serv_secC_loop2_guyB"][0] = % shipcrib_jackal_serv_secc_loop2_guyb;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_01"][0] = % shipcrib_jackal_serv_top_01;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_03"][0] = % shipcrib_jackal_serv_top_03;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_01"][0] = % shipcrib_hangar_crate_idlea_01;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_02"][0] = % shipcrib_hangar_crate_idlea_02;
  level._id_EC85["generic"]["shipcrib_hangar_crate_idleA_03"][0] = % shipcrib_hangar_crate_idlea_03;
  level._id_EC88["brooks"]["marscrib_brk_getourfkvsloaded"] = % marscrib_brk_getourfkvsloaded_face;
  level._id_EC88["brooks"]["marscrib_brk_illseeyoudown"] = % marscrib_brk_illseeyoudown_face;
  level._id_EC88["brooks"]["marscrib_brk_mymenwereable"] = % marscrib_brk_mymenwereable_face;
  level._id_EC88["brooks"]["marscrib_brk_rogerthat"] = % marscrib_brk_rogerthat_face;
  level._id_EC88["brooks"]["marscrib_brk_whatstheplancom"] = % marscrib_brk_whatstheplancom_face;
  level._id_EC85["generic"]["shipcrib_guard_reaction_idle_01"][0] = % shipcrib_guard_reaction_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_idle04"][0] = % shipcrib_stand_idle04_vig_01;
  level._id_EC85["generic"]["shipcrib_stand_idle04"][1] = % shipcrib_stand_idle04_vig_03;
  level._id_EC85["generic"]["shipcrib_stand_idle04"][2] = % shipcrib_stand_idle04_vig_04;
  level._id_EC85["generic"]["shipcrib_stand_idle04"][3] = % shipcrib_stand_idle04_vig_05;
  level._id_EC85["generic"]["shipcrib_bridge_hall_box_repair_idle_01"][0] = % shipcrib_bridge_hall_box_repair_idle_01;
  level._id_EC88["kloos"]["marscrib_kls_captainreyes"] = % marscrib_kls_4_40_hr_r2;
  level._id_EC88["kloos"]["marscrib_kls_goodtoseeyoure"] = % marscrib_kls_4_50_hr_r2;
  level._id_EC88["kloos"]["marscrib_kls_ayesir"] = % marscrib_kls_4_80_hr_r2;
  level._id_EC85["generic"]["mars_crib_un_injured_table_01_A"][0] = % mars_crib_un_injured_table_01_a;
  level._id_EC85["generic"]["mars_crib_un_injured_table_01_B"][0] = % mars_crib_un_injured_table_01_b;
  level._id_EC85["generic"]["mars_crib_un_elevator_injured_loop_01"][0] = % mars_crib_un_elevator_injured_loop_01;
  level._id_EC85["generic"]["mars_crib_un_lying_down_B"][0] = % mars_crib_un_lying_down_b;
  level._id_EC85["generic"]["mars_crib_un_wounded_guyA_set01_idle_02"][0] = % mars_crib_un_wounded_guya_set01_idle_02;
  level._id_EC85["generic"]["mars_crib_un_wounded_guyB_set01_idle_02"][0] = % mars_crib_un_wounded_guyb_set01_idle_02;
  level._id_EC85["generic"]["mars_crib_un_wounded_guyA_set03_idle_02"][0] = % mars_crib_un_wounded_guya_set03_idle_02;
  level._id_EC85["generic"]["mars_crib_un_wounded_guyB_set03_idle_02"][0] = % mars_crib_un_wounded_guyb_set03_idle_02;
  level._id_EC85["generic"]["mars_crib_un_lying_down_C"][0] = % mars_crib_un_lying_down_c;
  level._id_EC85["generic"]["mars_crib_un_elevator_injured_loop_02"][0] = % mars_crib_un_elevator_injured_loop_02;
  level._id_EC88["generic"]["marscrib_doc_yourealuckysob"] = % marscrib_un3_3_0_hr_r2;
  level._id_EC88["generic"]["marscrib_un3_justpatchmeup"] = % marscrib_un4_3_20_hr_r2;
  level._id_EC88["generic"]["marscrib_un3_notouttathefight"] = % marscrib_un3_3_30_hr_r2;
  level._id_EC85["chaplain"]["bless_idle"][0] = % mars_10_8_blessing_ally01_intro_idle;
  level._id_EC85["mourner"]["bless_idle"][0] = % mars_10_8_blessing_ally02_intro_idle;
  level._id_EC85["chaplain"]["bless_scene"] = % mars_10_8_blessing_ally01_eulogy;
  level._id_EC85["mourner"]["bless_scene"] = % mars_10_8_blessing_ally02_kneeling;
  level._id_EC85["chaplain"]["bless_end_idle"][0] = % mars_10_8_blessing_ally01_outro_idle;
  level._id_EC85["mourner"]["bless_end_idle"][0] = % mars_10_8_blessing_ally02_outro_idle;
  level._id_EC85["generic"]["mars_10_8_blessing_ally03_kneeling_idle"][0] = % mars_10_8_blessing_ally03_kneeling_idle;
  level._id_EC85["generic"]["mars_10_8_blessing_ally04_kneeling_idle"][0] = % mars_10_8_blessing_ally04_kneeling_idle;
  level._id_EC85["generic"]["mars_10_8_blessing_ally05_kneeling_idle"][0] = % mars_10_8_blessing_ally05_kneeling_idle;
  level._id_EC85["generic"]["mars_10_8_blessing_ally06_kneeling_idle"][0] = % mars_10_8_blessing_ally06_kneeling_idle;
  level._id_EC85["jack"]["jack_idle"][0] = % shipcrib_inspection_90_low_idle;
  level._id_EC88["jack"]["sc_rogue_un2_thankscaptain"] = % sc_rogue_un2_thankscaptain_face;
  level._id_EC88["jack"]["marscrib_un2_wererightbehind"] = % sc_rogue_un2_wererightbehind_face;
  level._id_EC88["jack"]["marscrib_un2_weightoftheworld"] = % sc_rogue_un2_weightoftheworld_face;
  level._id_EC85["boggs"]["dropship_idle"][0] = % vh_org_dropship_idle_pilot;
  level._id_EC85["salter"]["ramp_idle"][0] = % mars_10_14_raven_xo_ramp_idle;
  level._id_EC85["salter"]["ramp_walk"] = % mars_10_14_raven_xo_ramp_walk;
  level._id_EC85["salter"]["dropship_idle"][0] = % mars_10_14_raven_xo_dropship_idle;
  level._id_EC85["dropoff"]["dropship_idle"][0] = % mars_10_14_raven_do_dropship_idle;
  level._id_EC85["ally1"]["dropship_idle"][0] = % mars_10_14_raven_ally01_dropship_idle;
  level._id_EC85["ally2"]["dropship_idle"][0] = % mars_10_14_raven_ally02_dropship_idle;
  level._id_EC85["salter"]["dropship_scene"] = % mars_10_14_raven_xo_dropship_scene;
  level._id_EC85["dropoff"]["dropship_scene"] = % mars_10_14_raven_do_dropship_scene;
  level._id_EC85["ally1"]["dropship_scene"] = % mars_10_14_raven_ally01_dropship_scene;
  level._id_EC85["salter"]["dropship_rig_idle"][0] = % mars_10_14_raven_xo_dropship_boost_rig_idle;
  level._id_EC85["ally1"]["dropship_rig_idle"][0] = % mars_10_14_raven_ally01_dropship_boost_rig_idle;
  level._id_EC85["dropoff"]["dropship_idle_2"][0] = % mars_10_14_raven_do_dropship_idle_2;
  level._id_EC85["dropoff"]["dropship_nag"] = % mars_10_14_raven_do_dropship_nag;
  level._id_EC85["dropoff"]["dropship_rig_act"] = % mars_10_14_raven_do_boost_rig_interact;
  level._id_EC85["griff"]["dropship_rig_act"] = % mars_10_14_raven_arm_boost_rig_interact;
  level._id_EC85["ethan"]["dropship_rig_act"] = % mars_10_14_raven_eth3n_boost_rig_interact;
  level._id_EC85["gator"]["dropship_rig_act"] = % mars_10_14_raven_nav_boost_rig_interact;
  level._id_EC85["commo"]["dropship_rig_act"] = % mars_10_14_raven_comm_boost_rig_interact;
  level._id_EC85["sahora"]["dropship_rig_act"] = % mars_10_14_raven_sah_boost_rig_interact;
  level._id_EC85["ally3"]["dropship_rig_act"] = % mars_10_14_raven_ally03_boost_rig_interact;
  level._id_EC85["ally4"]["dropship_rig_act"] = % mars_10_14_raven_ally05_boost_rig_interact;
  level._id_EC85["ally5"]["dropship_rig_act"] = % mars_10_14_raven_ally07_boost_rig_interact;
  level._id_EC85["ally6"]["dropship_rig_act"] = % mars_10_14_raven_ally13_boost_rig_interact;
  level._id_EC85["ally7"]["dropship_rig_act"] = % mars_10_14_raven_ally04_boost_rig_interact;
  level._id_EC85["ally8"]["dropship_rig_act"] = % mars_10_14_raven_ally14_boost_rig_interact;
  level._id_EC85["dropoff"]["dropship_rig_idle"] = % mars_10_14_raven_do_dropship_boost_rig_idle;
  scripts\sp\anim::_id_17FC("salter", "pvo_marscrib_plr_boggsflylowtoav", "boggs_fly_low", "ramp_walk");
  level._id_EC88["salter"]["marscrib_slt_whosgotmyboostr"] = % marscrib_slt_whosgotmyboostr_face;
  level._id_EC88["ally1"]["marscrib_unm_rightheremaam"] = % marscrib_unm_rightheremaam_face;
  level._id_EC85["generic"]["hustle_stand_1"] = % shipcrib_hangar_hustle_30ft_guy_a_pt1;
  level._id_EC85["generic"]["hustle_stand_2"] = % shipcrib_hangar_hustle_30ft_guy_a_pt2;
  level._id_EC85["generic"]["hustle_kneel_1"] = % shipcrib_hangar_hustle_15ft_guy_b_pt1;
  level._id_EC85["generic"]["hustle_kneel_2"] = % shipcrib_hangar_hustle_15ft_guy_b_pt2;
  level._id_EC85["generic"]["hustle_lean_1"] = % shipcrib_hangar_hustle_30ft_guy_c_pt1;
  level._id_EC85["generic"]["hustle_lean_2"] = % shipcrib_hangar_hustle_30ft_guy_c_pt2;
  level._id_EC85["generic"]["hustle_stand_idle"] = % shipcrib_hangar_guy_hustle_idle_stand;
  level._id_EC85["generic"]["hustle_kneel_idle"] = % shipcrib_hangar_guy_hustle_idle_kneel;
  level._id_EC85["generic"]["hustle_lean_idle"] = % shipcrib_hangar_guy_hustle_idle_lean;
}

#using_animtree("script_model");

_id_EE25() {
  level._id_EC87["xo_boost"] = #animtree;
  level._id_EC8C["xo_boost"] = "pack_prop_female";
  level._id_EC87["plr_boost"] = #animtree;
  level._id_EC8C["plr_boost"] = "hero_boost_pack";
  level._id_EC85["xo_boost"]["dropship_idle"][0] = % mars_10_14_raven_xoboost_dropship_idle;
  level._id_EC85["plr_boost"]["dropship_idle"][0] = % mars_10_14_raven_plrboost_dropship_idle;
  level._id_EC85["xo_boost"]["dropship_scene"] = % mars_10_14_raven_xoboost_dropship_scene;
  level._id_EC85["plr_boost"]["dropship_scene"] = % mars_10_14_raven_plrboost_dropship_scene;
  level._id_EC85["plr_boost"]["dropship_idle_2"][0] = % mars_10_14_raven_plrboost_dropship_idle_2;
  level._id_EC85["plr_boost"]["dropship_nag "] = % mars_10_14_raven_plrboost_dropship_nag;
  level._id_EC85["plr_boost"]["dropship_rig_act"] = % mars_10_14_raven_plrboost_interact;
  level._id_EC87["klaxon"] = #animtree;
  level._id_EC85["klaxon"]["klaxon_spin"][0] = % claxon_spin_loop;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["forklift"] = #animtree;
  level._id_EC85["forklift"]["raise_lift"] = % vehicle_forklift_lift_raised;
  level._id_EC87["dropship"] = #animtree;
  level._id_EC85["dropship"]["dropship_enter"] = % mars_crib_armory_dropship_landing;
  scripts\sp\anim::_id_17FC("dropship", "wheels_down", "dropship_wheels_down", "dropship_enter");
}

jackals() {}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["jump_down"] = % mars_crib_plr_jump_down;
  level._id_EC85["player_rig"]["player_armory_use"] = % mars_crib_armory_plr_broken_terminal_exit;
  level._id_EC85["player_rig"]["player_armory_use_turn"] = % player_sleeve_pose;
  level._id_EC85["player_rig"]["plr_grab_ar57"] = % mars_crib_armory_player_camo_ar57;
  level._id_EC85["player_rig"]["plr_grab_ake"] = % mars_crib_armory_player_camo_eak47;
  level._id_EC85["player_rig"]["plr_grab_m4"] = % mars_crib_armory_player_camo_kbm4;
  level._id_EC85["player_rig"]["plr_grab_sdfar"] = % mars_crib_armory_player_camo_sdfar;
  level._id_EC85["player_rig"]["plr_grab_fmg"] = % mars_crib_armory_player_camo_fmg;
  level._id_EC85["player_rig"]["plr_grab_sdflmg"] = % mars_crib_armory_player_camo_sdflmg;
  level._id_EC85["player_rig"]["plr_grab_mauler"] = % mars_crib_armory_player_camo_lmgturret;
  level._id_EC85["player_rig"]["plr_grab_m1"] = % mars_crib_armory_player_camo_m1;
  level._id_EC85["player_rig"]["plr_grab_kbs"] = % mars_crib_armory_player_camo_kbs;
  level._id_EC85["player_rig"]["plr_grab_m8"] = % mars_crib_armory_player_camo_m8;
  level._id_EC85["player_rig"]["player_armory_look"] = % mars_crib_armory_plr_lookat_dropship_flyin;
  scripts\sp\anim::_id_17FC("player_rig", "gun_attach", "gun_attach");
  level._id_EC85["player_rig"]["dropship_rig_act"] = % mars_10_14_raven_plr_boost_rig_interact;
  scripts\sp\anim::_id_17FC("player_rig", "close_door", "dropship_close_door", "dropship_rig_act");
  scripts\sp\anim::_id_17FC("player_rig", "vo_marsbase_bgs_upin321", "dropship_takeoff", "dropship_rig_act");
  scripts\sp\anim::_id_17FC("player_rig", "pvo_marsbase_plr_goodluckillsee", "good_luck", "dropship_rig_act");
}

#using_animtree("c6");

_id_3353() {
  level._id_EC87["ally_c6"] = #animtree;
  level._id_EC85["ally_c6"]["c6_idle_1"][0] = % c6_grnd_red_exposed_casual_idle_ar;
}

#using_animtree("c12");

_id_3508() {
  level._id_EC87["ally_c12"] = #animtree;
  level._id_EC85["ally_c12"]["c12_grnd_org_exposed_idle_alert02"][0] = % c12_grnd_org_exposed_idle_alert02;
  level._id_EC85["ally_c12"]["c12_grnd_org_exposed_idle_alert03"][0] = % c12_grnd_org_exposed_idle_alert03;
}