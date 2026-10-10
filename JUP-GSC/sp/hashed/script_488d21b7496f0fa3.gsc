/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_488d21b7496f0fa3.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace namespace_7a3aed3d9ea64352;

function main() {
  anim_precache();
  player();
  humans();
  script_models();
}

function anim_precache() {
  precachemodel("body_c_jup_sp_enemy_kastovsoldier_03");
  precachemodel("body_c_jup_sp_enemy_kastovsoldier_02");
  precachemodel("body_c_jup_sp_enemy_kastovsoldier_01");
  precachemodel("parts_jup_holster_plastichigh");
  precachemodel("un_office_computer_monitor_03_lit");
  precachemodel("head_sc_m_ramirez_no_hair");
}

#using_animtree("player");

function player() {
  rig = "player_rig";
  level.scr_animtree[rig] = #animtree;
  level.scr_model[rig] = "vm_c_jup_sp_hero_laswell_bdu";
  level.scr_anim[rig]["keycard_interact"] = % jup_milbase_vm_keycard_plr;
  level.scr_anim[rig]["hat_removal"] = % gesture_remove_cap_player;
}

#using_animtree("generic_human");

function humans() {
  level.scr_animtree["prisoner01"] = #animtree;
  level.scr_model["prisoner01"] = "body_c_jup_sp_enemy_kastovsoldier_03";
  level.scr_animtree["prisoner05"] = #animtree;
  level.scr_model["prisoner05"] = "body_c_jup_sp_enemy_kastovsoldier_02";
  level.scr_animtree["prisoner09"] = #animtree;
  level.scr_model["prisoner09"] = "body_c_jup_sp_enemy_kastovsoldier_01";
  level.scr_anim["prisoner01"]["deadciv_scene_idle_01"] = % cap_bnk_010_prisoners_idle_civ01;
  level.scr_anim["prisoner01"]["deadciv_scene_dead_01"] = % cap_bnk_010_prisoners_dead_civ01;
  level.scr_anim["prisoner01"]["deadciv_scene_run_death_short_01"] = % jup_che_run_pain_death_short_1;
  level.scr_anim["prisoner01"]["deadciv_scene_run_death_short_02"] = % jup_che_run_pain_death_short_2;
  level.scr_anim["prisoner01"]["deadciv_scene_run_death_short_03"] = % jup_che_run_pain_death_short_3;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_01"] = % jup_che_stand_pain_death_01;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_02"] = % jup_che_stand_pain_death_02;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_03"] = % jup_che_stand_pain_death_03;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_04"] = % jup_che_stand_pain_death_04;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_05"] = % jup_che_stand_pain_death_05;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_06"] = % jup_che_stand_pain_death_06;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_07"] = % jup_che_stand_pain_death_07;
  level.scr_anim["prisoner01"]["deadciv_scene_stand_death_short_08"] = % jup_che_stand_pain_death_08;
  level.scr_anim["prisoner01"]["civ_pnc_run_moving_death01"] = % civ_pnc_run_moving_death01;
  level.scr_anim["prisoner01"]["civ_pnc_run_moving_death02"] = % civ_pnc_run_moving_death02;
  level.scr_anim["prisoner01"]["zom_core_death_run_1"] = % zom_core_death_run_1;
  level.scr_anim["prisoner01"]["zom_core_death_run_5"] = % zom_core_death_run_5;
  level.scr_anim["prisoner01"]["deadciv_scene_run_death_long_02"] = % jup_che_run_pain_death_long_2;
  level.scr_anim["prisoner01"]["deadciv_scene_run_death_long_03"] = % jup_che_run_pain_death_long_3;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_a_in_1"] = % jup_che_door_panic_death_a_in_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_a_in_3"] = % jup_che_door_panic_death_a_in_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_a_loop_1"] = % jup_che_door_panic_death_a_loop_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_a_loop_3"] = % jup_che_door_panic_death_a_loop_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_a_out_1"] = % jup_che_door_panic_death_a_out_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_a_out_3"] = % jup_che_door_panic_death_a_out_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_in_1"] = % jup_che_door_panic_death_b_in_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_in_2"] = % jup_che_door_panic_death_b_in_02;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_in_3"] = % jup_che_door_panic_death_b_in_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_loop_1"] = % jup_che_door_panic_death_b_loop_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_loop_2"] = % jup_che_door_panic_death_b_loop_02;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_loop_3"] = % jup_che_door_panic_death_b_loop_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_out_1"] = % jup_che_door_panic_death_b_out_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_out_2"] = % jup_che_door_panic_death_b_out_02;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_door_panic_death_b_out_3"] = % jup_che_door_panic_death_b_out_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_react_canister_fall_death_01"] = % jup_che_react_canister_fall_death_01;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_react_canister_fall_death_02"] = % jup_che_react_canister_fall_death_02;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_react_canister_fall_death_03"] = % jup_che_react_canister_fall_death_03;
  level.scr_anim["prisoner01"]["deadciv_scene_jup_che_react_canister_fall_death_04"] = % jup_che_react_canister_fall_death_04;
  level.scr_anim["prisoner05"]["deadciv_scene_idle_05"] = % cap_bnk_010_prisoners_idle_civ05;
  level.scr_anim["prisoner05"]["deadciv_scene_dead_05"] = % cap_bnk_010_prisoners_dead_civ05;
  level.scr_anim["prisoner09"]["deadciv_scene_idle_09"] = % cap_bnk_010_prisoners_idle_civ09;
  level.scr_anim["prisoner09"]["deadciv_scene_dead_09"] = % cap_bnk_010_prisoners_dead_civ09;
  level.scr_anim["prisoner01"]["jup_interaction_patrol_door_turn_knob_start"] = % jup_interaction_patrol_door_turn_knob_start;
  level.scr_anim["prisoner01"]["jup_interaction_patrol_door_turn_knob_loop"] = % jup_interaction_patrol_door_turn_knob_loop;
  level.scr_anim["prisoner01"]["jup_interaction_patrol_door_turn_knob_end"] = % jup_interaction_patrol_door_turn_knob_end;
  level.scr_anim["prisoner01"]["iw9_mp_veh_jltv_seat_0_idle"] = % iw9_mp_veh_jltv_seat_0_idle;
  level.scr_anim["prisoner01"]["iw9_veh_heli_medium_seat_0_idle_search01"] = % iw9_veh_heli_medium_seat_0_idle_search01;
  level.scr_anim["prisoner01"]["iw9_veh_heli_medium_seat_1_idle_search01"] = % iw9_veh_heli_medium_seat_1_idle_search01;
  level.scr_anim["prisoner01"]["jup_interaction_patrol_tablet_inventory_loop_01"][0] = % jup_interaction_patrol_tablet_inventory_loop_01;
  level.scr_anim["prisoner01"]["jup_interaction_patrol_tablet_inventory_loop_02"][0] = % jup_interaction_patrol_tablet_inventory_loop_02;
  level.scr_anim["prisoner01"]["jup_interaction_patrol_tablet_inventory_loop_03"][0] = % jup_interaction_patrol_tablet_inventory_loop_03;
  level.scr_face["soldier"]["dx_sp_flas_infs_pric_itsonthethirdfloorle"] = % dx_sp_flas_infs_pric_itsonthethirdfloorle_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_eta"] = % dx_sp_jmlb_icdm_offc_eta_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_isthesupplyshipmenta"] = % dx_sp_jmlb_icdm_offc_isthesupplyshipmenta_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_affirmative"] = % dx_sp_jmlb_icdm_ru01_affirmative_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_weshouldseethembysun"] = % dx_sp_jmlb_icdm_ru01_weshouldseethembysun_face;
  level.scr_face["soldier"]["dx_sp_jmlb_card_offc_statusupdateonthecom"] = % dx_sp_jmlb_card_offc_statusupdateonthecom_face;
  level.scr_face["soldier"]["dx_sp_jmlb_card_offc_whenwillitbereadyfor"] = % dx_sp_jmlb_card_offc_whenwillitbereadyfor_face;
  level.scr_face["soldier"]["dx_sp_jmlb_card_ru01_endofday"] = % dx_sp_jmlb_card_ru01_endofday_face;
  level.scr_face["soldier"]["dx_sp_jmlb_card_ru01_upgradesarecurrently"] = % dx_sp_jmlb_card_ru01_upgradesarecurrently_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_fillmeinsoldier"] = % dx_sp_jmlb_icdm_offc_fillmeinsoldier_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_goodkeeponschedule"] = % dx_sp_jmlb_icdm_offc_goodkeeponschedule_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_goodkeepthemomentumg"] = % dx_sp_jmlb_icdm_offc_goodkeepthemomentumg_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_iwantastatusupdate"] = % dx_sp_jmlb_icdm_offc_iwantastatusupdate_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_whatsthelatest"] = % dx_sp_jmlb_icdm_offc_whatsthelatest_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_offc_whenshouldiexpectit"] = % dx_sp_jmlb_icdm_offc_whenshouldiexpectit_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_betterbeimnotcarryin"] = % dx_sp_jmlb_icdm_rf01_betterbeimnotcarryin_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_gotmorehelosin"] = % dx_sp_jmlb_icdm_rf01_gotmorehelosin_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_howisthereportcoming"] = % dx_sp_jmlb_icdm_rf01_howisthereportcoming_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_thatsnotanexcusewhen"] = % dx_sp_jmlb_icdm_rf01_thatsnotanexcusewhen_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_thepaperworkneedstob"] = % dx_sp_jmlb_icdm_rf01_thepaperworkneedstob_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_whatstakingsolong"] = % dx_sp_jmlb_icdm_rf01_whatstakingsolong_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_wouldntcountonit"] = % dx_sp_jmlb_icdm_rf01_wouldntcountonit_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_yestheywerequietplea"] = % dx_sp_jmlb_icdm_rf01_yestheywerequietplea_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_yougoodonwater"] = % dx_sp_jmlb_icdm_rf01_yougoodonwater_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf01_youshouldgrabsomemor"] = % dx_sp_jmlb_icdm_rf01_youshouldgrabsomemor_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_hearanythingaboutthe"] = % dx_sp_jmlb_icdm_rf02_hearanythingaboutthe_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_howlongdoyouthinkthi"] = % dx_sp_jmlb_icdm_rf02_howlongdoyouthinkthi_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_imokay"] = % dx_sp_jmlb_icdm_rf02_imokay_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_ineedthemtoreviewthe"] = % dx_sp_jmlb_icdm_rf02_ineedthemtoreviewthe_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_inspectionscompletew"] = % dx_sp_jmlb_icdm_rf02_inspectionscompletew_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_niceandbcompany"] = % dx_sp_jmlb_icdm_rf02_niceandbcompany_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_runninglowtodaysmarc"] = % dx_sp_jmlb_icdm_rf02_runninglowtodaysmarc_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_thatllbetheday"] = % dx_sp_jmlb_icdm_rf02_thatllbetheday_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_thiscouldbeagreatopp"] = % dx_sp_jmlb_icdm_rf02_thiscouldbeagreatopp_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_trainingisbrutal"] = % dx_sp_jmlb_icdm_rf02_trainingisbrutal_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_whatdidtheythinkofth"] = % dx_sp_jmlb_icdm_rf02_whatdidtheythinkofth_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_yesicantmoveforwardw"] = % dx_sp_jmlb_icdm_rf02_yesicantmoveforwardw_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_rf02_yessir"] = % dx_sp_jmlb_icdm_rf02_yessir_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_1900atthelatest"] = % dx_sp_jmlb_icdm_ru01_1900atthelatest_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_agreed"] = % dx_sp_jmlb_icdm_ru01_agreed_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_allisquiet"] = % dx_sp_jmlb_icdm_ru01_allisquiet_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_alreadydone"] = % dx_sp_jmlb_icdm_ru01_alreadydone_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_andyoufinishedthepap"] = % dx_sp_jmlb_icdm_ru01_andyoufinishedthepap_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_anything"] = % dx_sp_jmlb_icdm_ru01_anything_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_arklovrunslikeclockw"] = % dx_sp_jmlb_icdm_ru01_arklovrunslikeclockw_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_bringitbymyofficeand"] = % dx_sp_jmlb_icdm_ru01_bringitbymyofficeand_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_everyoneisexceptiona"] = % dx_sp_jmlb_icdm_ru01_everyoneisexceptiona_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_everyonesheldupwitht"] = % dx_sp_jmlb_icdm_ru01_everyonesheldupwitht_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_feelliketheyvebeengo"] = % dx_sp_jmlb_icdm_ru01_feelliketheyvebeengo_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_finishingupsoon"] = % dx_sp_jmlb_icdm_ru01_finishingupsoon_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_gotanupdatedcompanys"] = % dx_sp_jmlb_icdm_ru01_gotanupdatedcompanys_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_guesswellcheckwithth"] = % dx_sp_jmlb_icdm_ru01_guesswellcheckwithth_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_howwedoingonscheduli"] = % dx_sp_jmlb_icdm_ru01_howwedoingonscheduli_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_isawjustyesterday"] = % dx_sp_jmlb_icdm_ru01_isawjustyesterday_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_notcurrentlybutberea"] = % dx_sp_jmlb_icdm_ru01_notcurrentlybutberea_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_notyetitsmeanttobeco"] = % dx_sp_jmlb_icdm_ru01_notyetitsmeanttobeco_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_stillworkingonit"] = % dx_sp_jmlb_icdm_ru01_stillworkingonit_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_thatsgoodtohear"] = % dx_sp_jmlb_icdm_ru01_thatsgoodtohear_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_tomorrowmorningatthe"] = % dx_sp_jmlb_icdm_ru01_tomorrowmorningatthe_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_wellcheckwithyouonth"] = % dx_sp_jmlb_icdm_ru01_wellcheckwithyouonth_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_wellfindoutsoon"] = % dx_sp_jmlb_icdm_ru01_wellfindoutsoon_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_wevebeeninconstantco"] = % dx_sp_jmlb_icdm_ru01_wevebeeninconstantco_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_yeahtheyrebusywithth"] = % dx_sp_jmlb_icdm_ru01_yeahtheyrebusywithth_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru01_yestheyaremeetingwit"] = % dx_sp_jmlb_icdm_ru01_yestheyaremeetingwit_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_0400tomorrow"] = % dx_sp_jmlb_icdm_ru02_0400tomorrow_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_copy"] = % dx_sp_jmlb_icdm_ru02_copy_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_coupleofhoursperhaps"] = % dx_sp_jmlb_icdm_ru02_coupleofhoursperhaps_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_doescommandneedassis"] = % dx_sp_jmlb_icdm_ru02_doescommandneedassis_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_everythingslockedin"] = % dx_sp_jmlb_icdm_ru02_everythingslockedin_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_hasthedelegationarri"] = % dx_sp_jmlb_icdm_ru02_hasthedelegationarri_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_havetomakeagoodimpre"] = % dx_sp_jmlb_icdm_ru02_havetomakeagoodimpre_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_hopefullywehearbackb"] = % dx_sp_jmlb_icdm_ru02_hopefullywehearbackb_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_itsmeanttobe"] = % dx_sp_jmlb_icdm_ru02_itsmeanttobe_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_iwouldexpectnothingl"] = % dx_sp_jmlb_icdm_ru02_iwouldexpectnothingl_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_justmomentsago"] = % dx_sp_jmlb_icdm_ru02_justmomentsago_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_lookforwardtoseeingt"] = % dx_sp_jmlb_icdm_ru02_lookforwardtoseeingt_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_negative"] = % dx_sp_jmlb_icdm_ru02_negative_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_ofcourse"] = % dx_sp_jmlb_icdm_ru02_ofcourse_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_oneneverknowswithour"] = % dx_sp_jmlb_icdm_ru02_oneneverknowswithour_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_seeanything"] = % dx_sp_jmlb_icdm_ru02_seeanything_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_shalliaskthemtomeetw"] = % dx_sp_jmlb_icdm_ru02_shalliaskthemtomeetw_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_thatmightbetoolate"] = % dx_sp_jmlb_icdm_ru02_thatmightbetoolate_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_thegeneralgreenlitou"] = % dx_sp_jmlb_icdm_ru02_thegeneralgreenlitou_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_tobeexpectedwehaveim"] = % dx_sp_jmlb_icdm_ru02_tobeexpectedwehaveim_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_understood"] = % dx_sp_jmlb_icdm_ru02_understood_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_weretheypresentedtoo"] = % dx_sp_jmlb_icdm_ru02_weretheypresentedtoo_face;
  level.scr_face["soldier"]["dx_sp_jmlb_icdm_ru02_willdo"] = % dx_sp_jmlb_icdm_ru02_willdo_face;
}

#using_animtree("script_model");

function script_models() {
  heli = "heli_nik";
  level.scr_animtree[heli] = #animtree;
  level.scr_model[heli] = "veh9_mil_air_heli_blima";
  level.scr_anim[heli]["heli_exfil_land"][0] = % jup_milbase_exfil_veh_in;
  level.scr_anim[heli]["heli_exfil_loop"][0] = % jup_milbase_exfil_veh_loop;
}