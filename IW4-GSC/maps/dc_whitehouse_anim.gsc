/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\dc_whitehouse_anim.gsc
********************************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;

main() {
  tunnels();
  whitehouse();
  whitehouse_script_model();
  player_animations();
  whitehouse_door();
  tunnels_door();
}

#using_animtree("generic_human");

tunnels() {
  level.scr_anim["generic"]["combatwalk_F_spin"] = % combatwalk_F_spin;

  level.scr_anim["dunn"]["hunted_woundedhostage_check"] = % hunted_woundedhostage_check_soldier;
  level.scr_anim["dunn"]["hunted_woundedhostage_check_soldier_end"] = % hunted_woundedhostage_check_soldier_end;

  level.scr_sound["dunn"]["dcemp_cpd_huah3"] = "dcemp_cpd_huah3";

  level.scr_sound["dunn"]["dcemp_cpd_westwing"] = "dcemp_cpd_westwing";

  level.scr_sound["dunn"]["dcemp_cpd_placeishistory"] = "dcemp_cpd_placeishistory";

  level.scr_sound["foley"]["dcemp_fly_cutchatter"] = "dcemp_fly_cutchatter";

  level.scr_sound["foley"]["dcemp_fly_fortourists"] = "dcemp_fly_fortourists";

  level.scr_sound["marine1"]["dcemp_ar1_feetdry"] = "dcemp_ar1_feetdry";

  level.scr_sound["generic"]["dcemp_ar2_letsgo"] = "dcemp_ar2_letsgo";

  level.scr_sound["generic"]["dcemp_ar3_hustleup"] = "dcemp_ar3_hustleup";
  level.scr_face["generic"]["dcemp_ar3_hustleup"] = % dcemp_ar3_hustleup;

  level.scr_sound["generic"]["dcemp_ar3_thisway"] = "dcemp_ar3_thisway";

  level.scr_sound["generic"]["dcemp_ar3_movemove"] = "dcemp_ar3_movemove";

  level.scr_anim["dead_guy"]["hunted_woundedhostage_check"] = % hunted_woundedhostage_check_hostage;
  level.scr_anim["dead_guy"]["hunted_woundedhostage_idle_start"][0] = % hunted_woundedhostage_idle_start;
  level.scr_anim["dead_guy"]["hunted_woundedhostage_idle_end"] = % hunted_woundedhostage_idle_end;

  level.scr_anim["generic"]["death_sitting_pose_v1"] = % death_sitting_pose_v1;

  level.scr_anim["generic"]["tunnel_door_open_guy"] = % cargoship_open_cargo_guyL;

  level.scr_anim["dunn"]["DCemp_door_sequence"] = % DCemp_door_sequence_dunn;
  level.scr_anim["foley"]["DCemp_door_sequence_foley_approch"] = % DCemp_door_sequence_foley_approch;
  level.scr_anim["foley"]["DCemp_door_sequence_foley_idle"][0] = % DCemp_door_sequence_foley_idle;
  level.scr_anim["foley"]["DCemp_door_sequence_foley_wave"] = % DCemp_door_sequence_foley_wave;

  addNotetrack_dialogue("dunn", "dcemp_cpd_westwing_ps", "DCemp_door_sequence", "dcemp_cpd_westwing");
  addNotetrack_flag("dunn", "foley_dialogue", "tunnels_foley_dialogue", "DCemp_door_sequence");

  addNotetrack_dialogue("dunn", "dcemp_cpd_placeishistory_ps", "DCemp_door_sequence", "dcemp_cpd_placeishistory");

  level.scr_anim["generic"]["wave_on"][0] = % dcemp_guard_wave;

  level.scr_sound["generic"]["gogogo"] = "dcemp_fly_gogogo";

  level.scr_sound["generic"]["keep_moving"] = "dcemp_fly_dontstop";
}

whitehouse() {
  level.scr_sound["marshall"]["dcemp_cml_moremen"] = "dcemp_cml_moremen";

  level.scr_sound["dunn"]["dcemp_cpd_partystarted"] = "dcemp_cpd_partystarted";

  level.scr_sound["dunn"]["dcemp_cpd_radiooverhere"] = "dcemp_cpd_radiooverhere";

  level.scr_sound["dunn"]["dcemp_cpd_talkingabout"] = "dcemp_cpd_talkingabout";

  level.scr_sound["dunn"]["dcemp_cpd_happensnow"] = "dcemp_cpd_happensnow";

  level.scr_sound["foley"]["dcemp_fly_rogerstayfrosty"] = "dcemp_fly_rogerstayfrosty";

  level.scr_sound["foley"]["dcemp_fly_workyourwayleft"] = "dcemp_fly_workyourwayleft";

  level.scr_sound["foley"]["dcemp_fly_ramirezgo"] = "dcemp_fly_ramirezgo";

  level.scr_sound["foley"]["dcemp_fly_takeleftflank"] = "dcemp_fly_takeleftflank";

  level.scr_sound["foley"]["dcemp_fly_punchthrough"] = "dcemp_fly_punchthrough";

  level.scr_sound["foley"]["dcemp_fly_machineguns"] = "dcemp_fly_machineguns";

  level.scr_sound["foley"]["dcemp_fly_flattenthecity"] = "dcemp_fly_flattenthecity";

  level.scr_sound["foley"]["dcemp_fly_lessthantwomins"] = "dcemp_fly_lessthantwomins";

  level.scr_sound["foley"]["dcemp_fly_30seconds"] = "dcemp_fly_30seconds";

  level.scr_sound["foley"]["dcemp_fly_60seconds"] = "dcemp_fly_60seconds";

  level.scr_sound["foley"]["dcemp_fly_90seconds"] = "dcemp_fly_90seconds";

  level.scr_sound["foley"]["dcemp_fly_poptheflares"] = "dcemp_fly_poptheflares";

  level.scr_sound["foley"]["dcemp_fly_waraintover"] = "dcemp_fly_waraintover";

  level.scr_sound["foley"]["dcemp_fly_backdownstairs"] = "dcemp_fly_backdownstairs";

  level.scr_radio["dcemp_fp1_hammerdown"] = "dcemp_fp1_hammerdown";

  level.scr_radio["dcemp_fp1_highvalue"] = "dcemp_fp1_highvalue";

  level.scr_radio["dcemp_fp1_greenflares"] = "dcemp_fp1_greenflares";

  level.scr_radio["dcemp_fp1_willabort"] = "dcemp_fp1_willabort";

  level.scr_radio["dcemp_fp1_2minutes"] = "dcemp_fp1_2minutes";

  level.scr_radio["dcemp_fp1_90secs"] = "dcemp_fp1_90secs";

  level.scr_radio["dcemp_fp1_1minute"] = "dcemp_fp1_1minute";

  level.scr_radio["dcemp_fp1_30secs"] = "dcemp_fp1_30secs";

  level.scr_radio["dcemp_fp1_beenauthorized"] = "dcemp_fp1_beenauthorized";

  level.scr_radio["dcemp_fp1_bombsaway"] = "dcemp_fp1_bombsaway";

  level.scr_radio["dcemp_fp1_abortabort"] = "dcemp_fp1_abortabort";

  level.scr_radio["dcemp_fp1_closeone"] = "dcemp_fp1_closeone";

  level.scr_radio["dcemp_fp1_wordtohq"] = "dcemp_fp1_wordtohq";

  level.scr_radio["dcemp_fp2_abortmission"] = "dcemp_fp2_abortmission";

  level.scr_radio["dcemp_fp3_rollingout"] = "dcemp_fp3_rollingout";

  level.scr_radio["dcemp_fp4_abortingmission"] = "dcemp_fp4_abortingmission";

  level.scr_radio["dcemp_fp1_closeone2"] = "dcemp_fp1_closeone";

  level.scr_anim["rappel_guy"]["rappel_stand_idle_1"][0] = % launchfacility_a_rappel_idle_1;
  level.scr_anim["rappel_guy"]["rappel_stand_idle_2"][0] = % launchfacility_a_rappel_idle_2;
  level.scr_anim["rappel_guy"]["rappel_stand_idle_3"][0] = % launchfacility_a_rappel_idle_3;
  level.scr_anim["rappel_guy"]["rappel_drop"] = % launchfacility_a_rappel_1;

  level.scr_anim["generic"]["doorburst_wave"] = % doorburst_wave;

  level.scr_anim["flare_guy"]["dcemp_flare_reshoot_start_idle"][0] = % dcemp_flare_reshoot_start_idle;
  level.scr_anim["flare_guy"]["dcemp_flare_reshoot_start"] = % dcemp_flare_reshoot_start;
  addNotetrack_attach("flare_guy", "attach flare", "mil_emergency_flare", "tag_inhand", "dcemp_flare_reshoot_start");
  addNotetrack_customFunction("flare_guy", "start flare", maps\dc_whitehouse_code::flare_fx_start, "dcemp_flare_reshoot_start");
  addNotetrack_flag("flare_guy", "attach flare", "flareguy_flare_popped", "dcemp_flare_reshoot_start");

  level.scr_anim["flare_guy"]["dcemp_flare_reshoot_end"] = % dcemp_flare_reshoot_end;
  addNotetrack_flag("flare_guy", "detach flare", "flare_guy_drop_flares", "dcemp_flare_reshoot_end");

  level.scr_anim["flare_guy"]["dcemp_flare_reshoot_start_short"] = % dcemp_flare_reshoot_start_short;
  addNotetrack_attach("flare_guy", "attach flare", "mil_emergency_flare", "tag_inhand", "dcemp_flare_reshoot_start_short");
  addNotetrack_customFunction("flare_guy", "start flare", maps\dc_whitehouse_code::flare_fx_start, "dcemp_flare_reshoot_start_short");
  addNotetrack_flag("flare_guy", "attach flare", "flareguy_flare_popped", "dcemp_flare_reshoot_start_short");

  level.scr_anim["flare_guy"]["dcemp_flare_idle"][0] = % casual_stand_idle;
  level.scr_anim["flare_guy"]["dcemp_flare_idle"][1] = % casual_stand_idle_twitch;
  level.scr_anim["flare_guy"]["dcemp_flare_idle"][2] = % casual_stand_idle_twitchB;

  level.scr_anim["flare_guy"]["whitehouse_ending_runuphill"] = % whitehouse_ending_runuphill;

  level.scr_anim["marshall"]["DCemp_whitehouse_briefing"] = % DCemp_whitehouse_briefing_marshall;
  level.scr_anim["marshall"]["DCemp_whitehouse_briefing_idle"][0] = % DCemp_whitehouse_briefing_marshall_idle;
  level.scr_anim["foley"]["DCemp_whitehouse_briefing"] = % DCemp_whitehouse_briefing_foley;

  addNotetrack_dialogue("foley", "dcemp_fly_situationhere_ps", "DCemp_whitehouse_briefing", "dcemp_fly_situationhere");

  addNotetrack_dialogue("marshall", "dcemp_cml_highground_ps", "DCemp_whitehouse_briefing", "dcemp_cml_highground");

  addNotetrack_dialogue("marshall", "dcemp_cml_retakeit_ps", "DCemp_whitehouse_briefing", "dcemp_cml_retakeit");

  addNotetrack_dialogue("marshall", "dcemp_cml_getyoursquad_ps", "DCemp_whitehouse_briefing", "dcemp_cml_getyoursquad");

  addNotetrack_dialogue("foley", "dcemp_fly_squadoscarmike_ps", "DCemp_whitehouse_briefing", "dcemp_fly_squadoscarmike");

  addNotetrack_flag("marshall", "dcemp_cml_getyoursquad_ps", "whitehouse_moveout", "DCemp_whitehouse_briefing");
  addNotetrack_flag("marshall", "dcemp_cml_getyoursquad_ps", "music_cue", "DCemp_whitehouse_briefing");

  level.scr_anim["foley"]["dcemp_wh_radio_1"] = % dcemp_wh_radio_1;
  level.scr_anim["foley"]["dcemp_wh_radio_1_exit"] = % dcemp_wh_radio_1_exit;
  level.scr_anim["foley"]["dcemp_wh_radio_1_idle"][0] = % dcemp_wh_radio_1_idle;

  level.scr_anim["dunn"]["dcemp_wh_radio"] = % dcemp_wh_radio_2;

  addNotetrack_flag("dunn", "folley_dialog", "oval_office_foley_dialogue", "dcemp_wh_radio");
  addNotetrack_flag("dunn", "start", "oval_office_foley_react", "dcemp_wh_radio");
  addNotetrack_flag("dunn", "fire", "oval_office_door_open", "dcemp_wh_radio");

  level.scr_sound["dunn"]["dcwhite_cpd_readingthis"] = "dcwhite_cpd_readingthis";

  level.scr_sound["dunn"]["dcwhite_cpd_rogerthat"] = "dcwhite_cpd_rogerthat";

  level.scr_sound["foley"]["dcwhite_fly_dunngetdoor"] = "dcwhite_fly_dunngetdoor";

  level.scr_sound["foley"]["dcwhite_fly_dunn"] = "dcwhite_fly_dunn";

  level.scr_sound["foley"]["dcwhite_fly_thatswhy"] = "dcwhite_fly_thatswhy";

  anims = [];
  anims["death_explosion_up10"] = % death_explosion_up10;
  anims["death_explosion_left11"] = % death_explosion_left11;
  anims["death_explosion_stand_B_v2"] = % death_explosion_stand_B_v2;

  level.drone_death_anims = anims;

  level.scr_sound["foley"]["dcemp_fly_gettoroof"] = "dcemp_fly_gettoroof";

  level.scr_sound["foley"]["dcemp_fly_useyourflares"] = "dcemp_fly_useyourflares";

  level.scr_sound["flare_guy"]["dcemp_ar1_moscow"] = "dcemp_ar1_moscow";
  level.scr_face["flare_guy"]["dcemp_ar1_moscow"] = % dcemp_ar1_moscow;

  level.scr_sound["dunn"]["dcwhite_cpd_burnitdown"] = "dcwhite_cpd_burnitdown";
  level.scr_face["dunn"]["dcwhite_cpd_burnitdown"] = % dcwhite_cpd_burnitdown;

  level.scr_sound["flare_guy"]["dcwhite_ar1_huah"] = "dcwhite_ar1_huah";
  level.scr_face["flare_guy"]["dcwhite_ar1_huah"] = % dcwhite_ar1_huah;

  level.scr_sound["foley"]["dcemp_fly_timeisright"] = "dcemp_fly_timeisright";
  level.scr_face["foley"]["dcemp_fly_timeisright"] = % dcemp_fly_timeisright;
}

#using_animtree("script_model");
whitehouse_script_model() {
  level.scr_animtree["rope"] = #animtree;
  level.scr_model["rope"] = "rappelrope100_ri";

  level.scr_anim["rope"]["rappel_stand_idle_1"][0] = % launchfacility_a_rappel_idle_1_100ft_rope;
  level.scr_anim["rope"]["rappel_stand_idle_2"][0] = % launchfacility_a_rappel_idle_2_100ft_rope;
  level.scr_anim["rope"]["rappel_stand_idle_3"][0] = % launchfacility_a_rappel_idle_3_100ft_rope;
  level.scr_anim["rope"]["rappel_drop"] = % launchfacility_a_rappel_1_100ft_rope;

  level.scr_animtree["painting"] = #animtree;
  level.scr_model["painting"] = "picture_frame_07_animated";
  level.scr_anim["painting"]["dcemp_wh_radio"] = % dcemp_wh_painting;
}

tunnels_door() {
  level.scr_animtree["tunnel_door"] = #animtree;
  level.scr_model["tunnel_door"] = "tag_origin";
  level.scr_anim["tunnel_door"]["DCemp_door_sequence"] = % DCemp_door_sequence_door;
}

#using_animtree("player");
player_animations() {
  level.scr_animtree["flare_rig"] = #animtree;
  level.scr_model["flare_rig"] = "viewhands_player_us_army";
  level.scr_anim["flare_rig"]["flare"] = % DCemp_player_flare_wave;
  addNotetrack_flag("flare_rig", "fx", "flare_start_fx", "flare");
  addNotetrack_flag("flare_rig", "fx", "whitehouse_hammerdown_jets_safe", "flare");

  level.scr_animtree["iss_rig"] = #animtree;
  level.scr_model["iss_rig"] = "viewhands_player_iss";
  level.scr_anim["iss_rig"]["ISS_animation"] = % ISS_player_rotate;
  level.scr_anim["iss_rig"]["ISS_float_away"] = % ISS_player_float_away;
}

#using_animtree("door");
whitehouse_door() {
  level.scr_animtree["door"] = #animtree;
  level.scr_model["door"] = "com_door_01_handleleft2";
  level.scr_anim["door"]["shotgunbreach_door_immediate"] = % shotgunbreach_door_immediate;
}