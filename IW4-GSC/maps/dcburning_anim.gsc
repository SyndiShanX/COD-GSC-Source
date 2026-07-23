/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\dcburning_anim.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");
main() {
  anims();
  vehicle_anims();
  dialogue();
  script_model_anims();
  flag_init("roof_door_kicked");
  addNotetrack_customFunction("generic", "kick", ::notetrack_roof_door_kicked, "shotgunhinges_breach_left_stack_breach_01");
}

anims() {
  level.scr_anim["generic"]["airport_civ_dying_groupB_pull"] = % airport_civ_dying_groupB_pull;
  level.scr_anim["generic"]["airport_civ_dying_groupB_pull_death"] = % airport_civ_dying_groupB_pull_death;
  level.scr_anim["generic"]["airport_civ_dying_groupB_wounded"] = % airport_civ_dying_groupB_wounded;
  level.scr_anim["generic"]["airport_civ_dying_groupB_wounded_death"] = % airport_civ_dying_groupB_wounded_death;

  level.scr_anim["generic"]["favela_run_and_wave"] = % favela_run_and_wave;
  level.scr_anim["generic"]["civilian_run_2_crawldeath"] = % civilian_run_2_crawldeath;
  level.scr_anim["generic"]["death_explosion_run_F_v1"] = % death_explosion_run_F_v1;
  level.scr_anim["generic"]["roadkill_cover_spotter"][0] = % roadkill_cover_spotter;
  level.scr_anim["generic"]["roadkill_cover_radio_soldier3"][0] = % roadkill_cover_radio_soldier3;
  level.scr_anim["generic"]["roadkill_cover_radio_soldier2"][0] = % roadkill_cover_radio_soldier2;

  level.scr_anim["generic"]["ch46_load_1"] = % ch46_load_1;
  level.scr_anim["generic"]["ch46_load_2"] = % ch46_load_2;
  level.scr_anim["generic"]["ch46_load_3"] = % ch46_load_3;
  level.scr_anim["generic"]["ch46_load_4"] = % ch46_load_4;

  level.scr_anim["generic"]["ch46_unload_idle"][0] = % exposed_crouch_idle_alert_v1;

  level.scr_anim["generic"]["leader_blackhawk_getin"] = % blackout_bh_evac_2;
  level.scr_anim["generic"]["leader_blackhawk_idle"][0] = % blackout_bh_evac_2_idle;

  level.scr_anim["generic"]["redshirt_blackhawk_getin"] = % blackout_bh_evac_2;
  level.scr_anim["generic"]["redshirt_blackhawk_idle"][0] = % blackout_bh_evac_2_idle;

  level.scr_anim["generic"]["dcburning_elevator_corpse_trans_A_2_B"] = % dcburning_elevator_corpse_trans_A_2_B;
  level.scr_anim["generic"]["dcburning_elevator_corpse_idle_A"][0] = % dcburning_elevator_corpse_idle_A;
  level.scr_anim["generic"]["dcburning_elevator_corpse_idle_B"][0] = % dcburning_elevator_corpse_idle_B;
  level.scr_anim["generic"]["dcburning_elevator_corpse_bump_A"] = % dcburning_elevator_corpse_bump_A;
  level.scr_anim["generic"]["dcburning_elevator_corpse_bump_B"] = % dcburning_elevator_corpse_bump_B;

  level.scr_anim["operator"]["pulldown"] = % gulag_slamraam_tarp_pull_guy2_v1;
  level.scr_anim["operator"]["idle"][0] = % gulag_slamraam_tarp_idle_guy2_v1;
  level.scr_anim["puller"]["pulldown"] = % gulag_slamraam_tarp_pull_guy1_v1;

  level.scr_anim["generic"]["littlebird_rider_death"] = % fastrope_fall;

  level.scr_anim["generic"]["little_bird_death_guy1"] = % little_bird_death_guy1;
  level.scr_anim["generic"]["little_bird_death_guy2"] = % little_bird_death_guy2;
  level.scr_anim["generic"]["little_bird_death_guy3"] = % little_bird_death_guy3;

  level.scr_anim["generic"]["deathanim_mortar_00"] = % exposed_death_falltoknees;
  level.scr_anim["generic"]["deathanim_mortar_01"] = % exposed_death_blowback;

  level.scr_anim["generic"]["AT4_idle"][0] = % corner_standr_alert_idle;
  level.scr_anim["generic"]["launchfacility_a_at4_fire"] = % launchfacility_a_at4_fire;

  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_walk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["generic"]["patrol_stop"] = % patrol_bored_walk_2_bored;
  level.scr_anim["generic"]["patrol_start"] = % patrol_bored_2_walk;
  level.scr_anim["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;

  level.scr_anim["generic"]["javelin_arrival"] = % covercrouch_run_in_M;
  level.scr_anim["generic"]["javelin_idle_start"] = % javelin_idle_A;
  level.scr_anim["generic"]["javelin_idle"][0] = % javelin_idle_A;
  level.scr_anim["generic"]["javelin_fire"] = % javelin_fire_A;
  level.scr_anim["generic"]["javelin_fire_short"] = % javelin_fire_short_A;

  level.scr_anim["generic"]["javelin_react"] = % javelin_react_A;
  addNotetrack_customFunction("generic", "reload_begin", ::javelin_reload_deathanim, "javelin_fire");
  addNotetrack_customFunction("generic", "reload_end", ::javelin_reload_done_deathanim, "javelin_fire");

  level.scr_anim["generic"]["javelin_death_barrett"] = % exposed_death_blowback;

  level.scr_anim["generic"]["javelin_idle_start2"] = % javelin_idle_B;
  level.scr_anim["generic"]["javelin_idle2"][0] = % javelin_idle_B;
  level.scr_anim["generic"]["javelin_fire2"] = % javelin_fire_B;
  level.scr_anim["generic"]["javelin_react2"] = % javelin_react_B;
  addNotetrack_customFunction("generic", "reload_begin", ::javelin_reload_deathanim, "javelin_fire2");
  addNotetrack_customFunction("generic", "reload_end", ::javelin_reload_done_deathanim, "javelin_fire2");

  level.scr_anim["generic"]["javelin_death2"] = % javelin_death_1;
  level.scr_anim["generic"]["javelin_death_reloading2"] = % javelin_death_2;

  level.scr_anim["generic"]["javelin_death"] = % javelin_death_3;
  level.scr_anim["generic"]["javelin_death_reloading"] = % javelin_death_5;

  level.scr_anim["generic"]["stinger_idle_start"] = % stinger_idle;
  level.scr_anim["generic"]["stinger_idle"][0] = % stinger_idle;
  level.scr_anim["generic"]["stinger_fire"] = % stinger_fire;
  level.scr_anim["generic"]["stinger_react_stand"] = % stinger_react_stand;
  level.scr_anim["generic"]["stinger_react_crouch"] = % stinger_react_crouch;

  level.scr_anim["generic"]["enemy_spotter_crouched_idle"][0] = % hunted_spotter_idle;
  level.scr_anim["generic"]["enemy_spotter_crouched_idle"][1] = % hunted_spotter_twitch;
  level.scr_anim["generic"]["enemy_spotter_crouched_react"] = % crouch2stand;
  level.scr_anim["generic"]["enemy_spotter_crouched_death"] = % exposed_crouch_death_fetal;

  level.scr_anim["generic"]["enemy_spotter_prone_idle"][0] = % sniper_escape_spotter_idle;
  level.scr_anim["generic"]["enemy_spotter_prone_idle"][1] = % sniper_escape_spotter_wave;
  level.scr_anim["generic"]["enemy_spotter_prone_react"] = % prone_2_stand;
  level.scr_anim["generic"]["enemy_spotter_prone_death"] = % exposed_crouch_death_fetal;

  level.scr_anim["generic"]["node_elevator_cover_right"][0] = % corner_standR_alert_idle;
  level.scr_anim["generic"]["node_elevator_cover_right"][1] = % corner_standR_alert_twitch01;
  level.scr_anim["generic"]["node_elevator_cover_right"][2] = % corner_standR_alert_twitch02;
  level.scr_anim["generic"]["node_elevator_cover_right"][3] = % corner_standR_alert_twitch04;
  level.scr_anim["generic"]["node_elevator_cover_right"][4] = % corner_standR_alert_twitch05;
  level.scr_anim["generic"]["node_elevator_cover_right"][5] = % corner_standR_alert_twitch06;

  level.scr_anim["generic"]["traverse_wallhop"] = % traverse_wallhop;
  level.scr_anim["generic"]["oilrig_rappel_2_crouch"] = % oilrig_rappel_2_crouch;
  addNotetrack_customFunction("generic", "over_solid", maps\dcburning::rappel_window_exploder, "oilrig_rappel_2_crouch");

  level.scr_anim["generic"]["DC_Burning_bunker_sit_idle"][0] = % DC_Burning_bunker_sit_idle;

  level.scr_anim["generic"]["DC_Burning_bunker_stumble"] = % DC_Burning_bunker_stumble;
  level.scr_anim["generic"]["DC_Burning_bunker_stumble_idle"][0] = % DC_Burning_bunker_sit_idle;
  level.scr_anim["generic"]["DC_Burning_bunker_stumble_idle_react"] = % DC_Burning_bunker_react;

  level.scr_anim["generic"]["bunker_toss_idle_guy1"][0] = % bunker_toss_idle_guy1;
  level.scr_anim["generic"]["bunker_toss_idle_guy1_go"] = % bunker_toss_guy1;
  level.scr_anim["generic"]["bunker_toss_guy2"] = % bunker_toss_guy2;

  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v1_idle_start"] = % DC_Burning_artillery_reaction_v1_idle;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v1_idle"][0] = % DC_Burning_artillery_reaction_v1_idle;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v1_idle_react"] = % DC_Burning_artillery_reaction_v1_react_a;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v1_idle_react2"] = % DC_Burning_artillery_reaction_v1_react_b;

  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v2_idle_start"] = % DC_Burning_artillery_reaction_v2_idle;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v2_idle"][0] = % DC_Burning_artillery_reaction_v2_idle;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v2_idle_react"] = % DC_Burning_artillery_reaction_v2_react_a;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v2_idle_react2"] = % DC_Burning_artillery_reaction_v2_react_b;

  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v3_idle_start"] = % DC_Burning_artillery_reaction_v3_idle;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v3_idle"][0] = % DC_Burning_artillery_reaction_v3_idle;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v3_idle_react"] = % DC_Burning_artillery_reaction_v3_react_a;
  level.scr_anim["generic"]["DC_Burning_artillery_reaction_v3_idle_react2"] = % DC_Burning_artillery_reaction_v3_react_b;

  level.scr_anim["generic"]["unarmed_panickedrun_loop_V2"] = % unarmed_panickedrun_loop_V2;

  level.scr_anim["generic"]["DC_Burning_CPR_medic"] = % DC_Burning_CPR_medic;
  addNotetrack_attach("generic", "attach prop", "adrenaline_syringe_animated", "TAG_INHAND", "DC_Burning_CPR_medic");
  addNotetrack_detach("generic", "dettach prop", "adrenaline_syringe_animated", "TAG_INHAND", "DC_Burning_CPR_medic");

  level.scr_anim["generic"]["DC_Burning_CPR_wounded"] = % DC_Burning_CPR_wounded;
  level.scr_anim["generic"]["DC_Burning_CPR_medic_idle"][0] = % DC_Burning_CPR_medic_endidle;
  level.scr_anim["generic"]["DC_Burning_CPR_wounded_idle"][0] = % DC_Burning_CPR_wounded_endidle;

  level.scr_anim["generic"]["DC_Burning_stop_bleeding_medic"] = % DC_Burning_stop_bleeding_medic;
  addNotetrack_attach("generic", "attach prop", "clotting_powder_animated", "TAG_INHAND", "DC_Burning_stop_bleeding_medic");
  addNotetrack_detach("generic", "dettach prop", "clotting_powder_animated", "TAG_INHAND", "DC_Burning_stop_bleeding_medic");

  level.scr_anim["generic"]["DC_Burning_stop_bleeding_wounded"] = % DC_Burning_stop_bleeding_wounded;
  level.scr_anim["generic"]["DC_Burning_stop_bleeding_medic_idle"][0] = % DC_Burning_stop_bleeding_medic_endidle;
  level.scr_anim["generic"]["DC_Burning_stop_bleeding_wounded_idle"][0] = % DC_Burning_stop_bleeding_wounded_endidle;

  level.scr_anim["generic"]["cargoship_sleeping_guy_idle_2_start"] = % cargoship_sleeping_guy_idle_2;
  level.scr_anim["generic"]["cargoship_sleeping_guy_idle_1_start"] = % cargoship_sleeping_guy_idle_1;
  level.scr_anim["generic"]["cargoship_sleeping_guy_idle_2"][0] = % cargoship_sleeping_guy_idle_2;
  level.scr_anim["generic"]["cargoship_sleeping_guy_idle_1"][0] = % cargoship_sleeping_guy_idle_1;

  level.scr_anim["generic"]["afgan_caves_sleeping_guard_idle_start"] = % afgan_caves_sleeping_guard_idle;
  level.scr_anim["generic"]["afgan_caves_sleeping_guard_idle"][0] = % afgan_caves_sleeping_guard_idle;

  level.scr_anim["generic"]["laptop_sit_idle_calm_start"] = % laptop_sit_idle_calm;
  level.scr_anim["generic"]["laptop_sit_idle_calm"][0] = % laptop_sit_idle_calm;
  level.scr_anim["generic"]["laptop_sit_idle_calm"][1] = % laptop_sit_idle_active;
  level.scr_anim["generic"]["laptop_sit_idle_react"] = % laptop_sit_idle_flinch;

  level.scr_anim["generic"]["laptop_stand_idle_start"] = % laptop_stand_idle;
  level.scr_anim["generic"]["laptop_stand_idle"][0] = % laptop_stand_idle;
  level.scr_anim["generic"]["laptop_stand_idle_react"] = % laptop_stand_idle_flinch;

  level.scr_anim["generic"]["laptop_officer_idle_start"] = % laptop_officer_idle;
  level.scr_anim["generic"]["laptop_officer_idle"][0] = % laptop_officer_idle;
  level.scr_anim["generic"]["laptop_officer_idle"][1] = % laptop_officer_talk;

  level.scr_anim["generic"]["training_humvee_wounded"] = % training_humvee_wounded;
  level.scr_anim["generic"]["training_humvee_soldier"] = % training_humvee_soldier;
  level.scr_anim["generic"]["training_humvee_wounded_idle"][0] = % training_humvee_wounded_idle;
  level.scr_anim["generic"]["training_humvee_soldier_idle"][0] = % training_humvee_soldier_idle;

  level.scr_anim["generic"]["wounded_carry_fastwalk_carrier"] = % wounded_carry_fastwalk_carrier;
  level.scr_anim["generic"]["wounded_carry_fastwalk_wounded"] = % wounded_carry_fastwalk_wounded;
  level.scr_anim["generic"]["DC_Burning_wounded_carry_putdown_carrier"] = % DC_Burning_wounded_carry_putdown_carrier;
  level.scr_anim["generic"]["DC_Burning_wounded_carry_putdown_wounded"] = % DC_Burning_wounded_carry_putdown_wounded;
  level.scr_anim["generic"]["DC_Burning_wounded_carry_idle_wounded"][0] = % DC_Burning_wounded_carry_idle_wounded;
  level.scr_anim["generic"]["DC_Burning_wounded_carry_idle_carrier"][0] = % DC_Burning_wounded_carry_idle_carrier;

  level.scr_anim["generic"]["bog_radio_dialogue"] = % bog_radio_dialogue;
}

dialogue() {
  level.scr_sound["dcburn_gm1_keepstill"] = "dcburn_gm1_keepstill";

  level.scr_sound["dcburn_gm1_wherescanteen"] = "dcburn_gm1_wherescanteen";

  level.scr_sound["dcburn_gm2_righthere"] = "dcburn_gm2_righthere";

  level.scr_sound["dcburn_gm3_allyoursdoc"] = "dcburn_gm3_allyoursdoc";

  level.scr_sound["dcburn_gm4_2stretchers"] = "dcburn_gm4_2stretchers";

  level.scr_sound["dcburn_gm5_gotwounded"] = "dcburn_gm5_gotwounded";

  level.scr_sound["dcburn_gm6_stablefornow"] = "dcburn_gm6_stablefornow";

  level.scr_radio["dcburn_hqr_ensureweapons"] = "dcburn_hqr_ensureweapons";

  level.scr_sound["generic"]["dcburn_gr1_onyourfeet"] = "dcburn_gr1_onyourfeet";

  level.scr_sound["generic"]["dcburn_mcy_rogerout"] = "dcburn_mcy_twooneout";

  level.scr_sound["generic"]["dcburn_mcy_evachithard"] = "dcburn_mcy_buytime2";

  level.scr_sound["dcburn_hoh_1"] = "dcburn_hoh_1";

  level.scr_sound["generic"]["dcburn_cpd_stayintrench"] = "dcburn_cpd_stayintrench";

  level.scr_sound["generic"]["dcburn_cpd_staylow"] = "dcburn_cpd_staylow";

  level.scr_sound["generic"]["dcburn_cpd_backintrench"] = "dcburn_cpd_backintrench";

  level.scr_sound["generic"]["dcburn_cpd_wheregoing"] = "dcburn_cpd_wheregoing";

  level.scr_sound["dcburn_javelins_incoming_00"] = "dcburn_gm2_incoming";

  level.scr_sound["dcburn_javelins_incoming_01"] = "dcburn_gm1_takecover";

  level.scr_radio["dcburn_hqr_commerceconfirms"] = "dcburn_hqr_commerceconfirms";

  level.scr_radio["dcburn_hqr_uncoverengage"] = "dcburn_hqr_uncoverengage";

  level.scr_radio["dcburn_cpd_opticsonus"] = "dcburn_cpd_opticsonus";

  level.scr_sound["generic"]["dcburn_mcy_reqairstrike"] = "dcburn_mcy_reqairstrike";

  level.scr_radio["dcburn_hqr_alongpotomac"] = "dcburn_hqr_alongpotomac";

  level.scr_sound["generic"]["dcburn_mcy_buytime"] = "dcburn_mcy_buytime";

  level.scr_radio["dcburn_cpd_wrongway"] = "dcburn_cpd_wrongway";

  level.scr_sound["generic"]["dcburn_mcy_haulingpastus"] = "dcburn_mcy_haulingpastus";

  level.scr_radio["dcburn_mcy_copythat"] = "dcburn_mcy_copythat";

  level.scr_radio["dcburn_hqr_linkup"] = "dcburn_hqr_linkup";

  level.scr_radio["dcburn_mcy_solidcopyonall"] = "dcburn_mcy_solidcopyonall";

  level.scr_sound["generic"]["dcburn_mcy_firelow"] = "dcburn_mcy_firelow";

  level.scr_radio["dcburn_cpd_footmobiles"] = "dcburn_cpd_footmobiles";

  level.scr_sound["generic"]["dcburn_mcy_humveesupp"] = "dcburn_mcy_humveesupp";

  level.scr_sound["generic"]["dcburn_mcy_ready"] = "dcburn_mcy_ready";

  level.scr_sound["generic"]["dcburn_mcy_gomoveup"] = "dcburn_mcy_gomoveup";

  level.scr_radio["dcburn_mcy_lineoffire"] = "dcburn_mcy_lineoffire";

  level.scr_radio["dcburn_mcy_movemove"] = "dcburn_mcy_movemove";

  level.scr_radio["dcburn_mcy_50calsupp"] = "dcburn_mcy_50calsupp";

  level.scr_radio["dcburn_mcy_sittingducks"] = "dcburn_mcy_sittingducks";

  level.scr_radio["dcburn_mcy_blownoff"] = "dcburn_mcy_blownoff";

  level.scr_radio["dcburn_mcy_moveup"] = "dcburn_mcy_moveup";

  level.scr_radio["dcburn_mcy_intotargbuilding"] = "dcburn_mcy_intotargbuilding";

  level.scr_sound["generic"]["dcburn_mcy_grenadelaunch"] = "dcburn_mcy_grenadelaunch";

  level.scr_sound["generic"]["dcburn_mcy_lobby_move_nag_00"] = "dcburn_mcy_moveupgogo";

  level.scr_sound["generic"]["dcburn_mcy_lobby_move_nag_01"] = "dcburn_mcy_movein";

  level.scr_sound["generic"]["dcburn_mcy_lobby_move_nag_02"] = "dcburn_mcy_pushforward";

  level.scr_sound["generic"]["dcburn_mcy_lobby_move_nag_03"] = "dcburn_mcy_moveforward";

  level.scr_sound["generic"]["dcburn_mcy_lobby_move_nag_04"] = "dcburn_mcy_moveup2";

  level.scr_radio["dcburn_mcy_upperfloors"] = "dcburn_mcy_upperfloors";

  level.scr_radio["dcburn_hqr_copiesall"] = "dcburn_hqr_copiesall";

  level.scr_radio["dcburn_mcy_alldeadcourtyard"] = "dcburn_mcy_fireteamsupp";

  level.scr_radio["dcburn_hqr_solidcopy"] = "dcburn_hqr_solidcopy";

  level.scr_radio["dcburn_mcy_tomezzanine"] = "dcburn_mcy_mezzanine";

  level.scr_radio["dcburn_hqr_goodhunt"] = "dcburn_hqr_goodhunting";

  level.scr_radio["dcburn_mcy_alldeadmezzanine"] = "dcburn_mcy_hostsupp";

  level.scr_radio["dcburn_hqr_rogerthat"] = "dcburn_hqr_rogerthat";

  level.scr_sound["generic"]["dcburn_cpd_capitolbuild"] = "dcburn_cpd_capitolbuild";

  level.scr_radio["dcburn_mcy_droponthem"] = "dcburn_mcy_droponthem";

  level.scr_radio["dcburn_mcy_hitemfast"] = "dcburn_mcy_hitemfast";

  level.scr_radio["dcburn_mcy_whatseeing_r"] = "dcburn_mcy_whatseeing_r";

  level.scr_radio["dcburn_gm5_lzheavyfire"] = "dcburn_gm5_lzheavyfire";

  level.scr_radio["dcburn_mcy_solidcopy_r"] = "dcburn_mcy_solidcopy_r";

  level.scr_radio["dcburn_hqr_crownag"] = "dcburn_hqr_swcorn5th";

  level.scr_radio["dcburn_mcy_omwtofifth"] = "dcburn_mcy_omto5th";

  level.scr_radio["dcburn_mcy_alldeadfourth"] = "dcburn_mcy_fireteamelim";

  level.scr_radio["dcburn_hqr_copythat"] = "dcburn_hqr_copythat";

  level.scr_radio["dcburn_mcy_onfifth"] = "dcburn_mcy_swcorner";

  level.scr_radio["dcburn_hqr_copy21"] = "dcburn_hqr_copy21";

  level.scr_radio["dcburn_cdn_movement"] = "dcburn_cpd_gotmvmnt";

  level.scr_radio["dcburn_mcy_sby2engage"] = "dcburn_mcy_standbyeng";

  level.scr_radio["dcburn_mcy_watchsectors"] = "dcburn_mcy_watchsectors";

  level.scr_radio["dcburn_mcy_checkcorners"] = "dcburn_mcy_checkcorners";

  level.scr_radio["dcburn_mcy_visoncrow"] = "dcburn_mcy_viscrowsnest";

  level.scr_sound["generic"]["dcburn_mcy_seccrowsnest"] = "dcburn_mcy_seccrowsnest";

  level.scr_radio["dcburn_hqr_canyousupport"] = "dcburn_hqr_stillvuln";

  level.scr_sound["generic"]["dcburn_mcy_stockpile"] = "dcburn_mcy_stockpile";

  level.scr_radio["dcburn_evc_glassedenemieswest"] = "dcburn_evc_glassedenemieswest";

  level.scr_sound["generic"]["dcburn_mcy_sniperrifle"] = "dcburn_mcy_sniperrifle";

  level.scr_sound["generic"]["dcburn_mcy_scanfortargets"] = "dcburn_mcy_scanfortargets";

  level.scr_radio["dcburn_evc_damage_00"] = "dcburn_evc_80percenteffective";

  level.scr_radio["dcburn_evc_damage_01"] = "dcburn_evc_forceindetail";

  level.scr_radio["dcburn_evc_damage_02"] = "dcburn_evc_canttakemuchmore";

  level.scr_radio["dcburn_evc_damage_03"] = "dcburn_evc_50percenteffective";

  level.scr_radio["dcburn_evc_damage_fail"] = "dcburn_evc_civviesouttahere";

  level.scr_sound["generic"]["barret_nag_0"] = "dcburn_mcy_ww2mem";

  level.scr_sound["generic"]["barret_nag_1"] = "dcburn_mcy_getonbarrett";

  level.scr_sound["generic"]["barret_nag_2"] = "dcburn_mcy_getonrifle";

  level.scr_sound["generic"]["barret_shoot_nag_0"] = "dcburn_mcy_targetenemy";

  level.scr_sound["generic"]["barret_shoot_nag_1"] = "dcburn_mcy_targetinfantry";

  level.scr_sound["generic"]["stay_in_nest_nag_0"] = "dcburn_mcy_beforeoverrun";

  level.scr_sound["generic"]["stay_in_nest_nag_1"] = "dcburn_mcy_coverevacsite";

  level.scr_sound["generic"]["stay_in_nest_nag_2"] = "dcburn_mcy_returntopost";

  level.scr_radio["dcburn_hqr_stayfrosty"] = "dcburn_hqr_stayfrosty";

  level.scr_sound["generic"]["dcburn_cpd_inperimeter"] = "dcburn_cpd_inperimeter";

  level.scr_sound["generic"]["dcburn_cpd_hostatsix"] = "dcburn_cpd_hostatsix";

  level.scr_sound["generic"]["dcburn_cpd_takingfire"] = "dcburn_cpd_takingfire";

  level.scr_radio["dcburn_hqr_clearout"] = "dcburn_hqr_clearout";

  level.scr_sound["generic"]["dcburn_mcy_negative"] = "dcburn_mcy_negative";

  level.scr_sound["generic"]["dcburn_mcy_whatwecan"] = "dcburn_mcy_whatwecan";

  level.scr_sound["generic"]["dcburn_mcy_useordnance"] = "dcburn_mcy_useordnance";

  level.scr_sound["generic"]["rocket_nag_0"] = "dcburn_mcy_grabajavelin";

  level.scr_sound["generic"]["rocket_nag_1"] = "dcburn_mcy_heavyord";

  level.scr_sound["generic"]["rocket_nag_2"] = "dcburn_mcy_heavyweap";

  level.scr_sound["generic"]["rocket_nag_3"] = "dcburn_mcy_whateveryoufind";

  level.scr_sound["generic"]["rocket_shoot_nag_0"] = "dcburn_mcy_heavyfire";

  level.scr_sound["generic"]["rocket_shoot_nag_1"] = "dcburn_mcy_closingin";

  level.scr_sound["generic"]["rocket_shoot_nag_2"] = "dcburn_mcy_takeoutveh";

  level.scr_radio["dcburn_hqr_urgentsurgicals"] = "dcburn_hqr_urgentsurgicals";

  level.scr_radio["dcburn_ar5_triplea"] = "dcburn_ar5_triplea";

  level.scr_radio["dcburn_ar2_backinseats"] = "dcburn_ar2_backinseats";

  level.scr_radio["dcburn_ar3_gottatouchdown"] = "dcburn_ar3_gottatouchdown";

  level.scr_radio["dcburn_hqr_roofasap"] = "dcburn_hqr_roofasap";

  level.scr_sound["generic"]["dcburn_mcy_rooftop"] = "dcburn_mcy_rooftop";

  level.scr_sound["generic"]["dcburn_cpd_closingin"] = "dcburn_cpd_closingin";

  level.scr_radio["dcburn_bhp_whatsyourstatus"] = "dcburn_bhp_whatsyourstatus";

  level.scr_sound["generic"]["dcburn_mcy_hostilesclose"] = "dcburn_mcy_hostilesclose";

  level.scr_sound["generic"]["dcburn_mcy_notime"] = "dcburn_mcy_notime";

  level.scr_sound["generic"]["dcburn_mcy_keepmoving"] = "dcburn_mcy_keepmoving";

  level.scr_sound["generic"]["dcburn_mcy_overrun"] = "dcburn_mcy_overrun";

  level.scr_sound["generic"]["dcburn_mcy_outoftimego"] = "dcburn_mcy_outoftimego";

  level.scr_sound["generic"]["dcburn_mcy_rvwithseals"] = "dcburn_mcy_rvwithseals";

  level.scr_sound["generic"]["dcburn_mcy_crawlin"] = "dcburn_mcy_crawlin";

  level.scr_sound["generic"]["dcburn_mcy_letsmoveout"] = "dcburn_mcy_letsmoveout";

  level.scr_sound["generic"]["dcburn_mcy_gettoroofnow"] = "dcburn_mcy_gettoroofnow";

  level.scr_sound["generic"]["dcburn_mcy_overrunningpos"] = "dcburn_mcy_overrunningpos";

  level.scr_sound["generic"]["dcburn_mcy_outnumbered"] = "dcburn_mcy_outnumbered";

  level.scr_sound["generic"]["dcburn_mcy_upthestairsgo"] = "dcburn_mcy_upthestairsgo";

  level.scr_sound["generic"]["dcburn_mcy_waitallday"] = "dcburn_mcy_waitallday";

  level.scr_sound["generic"]["dcburn_mcy_gettingoverrun"] = "dcburn_mcy_gettingoverrun";

  level.scr_sound["generic"]["dcburn_mcy_getonminigun"] = "dcburn_mcy_getonminigun";

  level.scr_sound["generic"]["dcburn_mcy_moveminigun"] = "dcburn_mcy_moveminigun";

  level.scr_sound["generic"]["dcburn_mcy_getinchopper"] = "dcburn_mcy_getinchopper";

  level.scr_sound["generic"]["dcburn_mcy_wayoutnumbered"] = "dcburn_mcy_wayoutnumbered";

  level.scr_sound["generic"]["dcburn_mcy_forgetaboutit"] = "dcburn_mcy_forgetaboutit";

  level.scr_sound["generic"]["dcburn_mcy_brassontitanic"] = "dcburn_mcy_brassontitanic";

  level.scr_radio["dcburn_hqr_firstwave"] = "dcburn_hqr_firstwave";

  level.scr_radio["dcburn_hqr_fallbacknow"] = "dcburn_hqr_fallbacknow";

  level.scr_radio["dcburn_ar2_leavebehind"] = "dcburn_ar2_leavebehind";

  level.scr_radio["dcburn_ar2_hydraulicfluid"] = "dcburn_ar2_hydraulicfluid";

  level.scr_radio["dcburn_ar4_wearegoingdown"] = "dcburn_ar4_wearegoingdown";

  level.scr_radio["dcburn_hqr_orderirene"] = "dcburn_hqr_orderirene";

  level.scr_radio["dcburn_ar1_weareleaving"] = "dcburn_ar1_weareleaving";

  level.scr_radio["dcburn_mcy_hitgoingdown"] = "dcburn_mcy_hitgoingdown";

  level.scr_radio["dcburn_bhp_incoming"] = "dcburn_bhp_incoming";

  level.scr_radio["dcburn_mcy_stillintheair"] = "dcburn_mcy_stillintheair";

  level.scr_radio["dcburn_bhp_rpgteams"] = "dcburn_bhp_rpgteams";

  level.scr_radio["dcburn_bhp_attitudecontrol"] = "dcburn_bhp_attitudecontrol";

  level.scr_radio["dcburn_mcy_takeusup"] = "dcburn_mcy_takeusup";

  level.scr_radio["dcburn_bhp_fireteams"] = "dcburn_bhp_fireteams";

  level.scr_radio["dcburn_mcy_bunkerevac"] = "dcburn_mcy_bunkerevac";

  level.scr_radio["dcburn_hqr_stillpinned"] = "dcburn_hqr_stillpinned";

  level.scr_radio["dcburn_mcy_fromtheair"] = "dcburn_mcy_fromtheair";

  level.scr_radio["dcburn_mcy_permission"] = "dcburn_mcy_permission";

  level.scr_radio["dcburn_hqr_clearedhot"] = "dcburn_hqr_clearedhot";

  level.scr_radio["dcburn_mcy_onewaytrip"] = "dcburn_mcy_onewaytrip";

  level.scr_radio["dcburn_sll_withyou"] = "dcburn_sll_withyou";

  level.scr_radio["dcburn_cpd_leadtheway"] = "dcburn_cpd_leadtheway";

  level.scr_radio["dcburn_mcy_alltheway"] = "dcburn_mcy_alltheway";

  level.scr_radio["dcburn_lbp1_breakleftbreakleft"] = "dcburn_lbp1_breakleftbreakleft";

  level.scr_radio["dcburn_lbp1_clearedhot"] = "dcburn_lbp1_clearedhot";

  level.scr_radio["dcburn_mcy_spinherup"] = "dcburn_mcy_spinherup";

  level.scr_radio["dcburn_lbp1_gunshipliftingoff"] = "dcburn_lbp1_gunshipliftingoff";

  level.scr_radio["dcburn_lbp1_armorrollingin"] = "dcburn_lbp1_armorrollingin";

  level.scr_radio["dcburn_lbp1_footmobiles"] = "dcburn_lbp1_footmobiles";

  level.scr_radio["dcburn_evc_mainroad"] = "dcburn_evc_mainroad";

  level.scr_radio["dcburn_lbp1_wereonit"] = "dcburn_lbp1_wereonit";

  level.scr_radio["dcburn_lbp1_takenheatoff"] = "dcburn_lbp1_takenheatoff";

  level.scr_radio["dcburn_lbp1_22and23aredown"] = "dcburn_lbp1_22and23aredown";

  level.scr_radio["dcburn_bhp_dontgetup"] = "dcburn_bhp_dontgetup";

  level.scr_radio["dcburn_lbp1_samlaunch"] = "dcburn_lbp1_samlaunch";

  level.scr_sound["dcburn_lbp1_maydaymayday"] = "dcburn_lbp1_maydaymayday";

  level.scr_radio["dcburn_lbp1_braceforimpact"] = "dcburn_lbp1_braceforimpact";
}

#using_animtree("script_model");
script_model_anims() {
  level.scr_animtree["tarp"] = #animtree;
  level.scr_anim["tarp"]["pulldown"] = % gulag_slamraam_tarp_simulation;
  level.scr_model["tarp"] = "slamraam_tarp";
}

#using_animtree("vehicles");
vehicle_anims() {
  level.scr_anim["seaknight"]["sniper_escape_ch46_take_off"] = % sniper_escape_ch46_take_off;
  level.scr_anim["seaknight"]["sniper_escape_ch46_take_off_idle"][0] = % sniper_escape_ch46_idle;
  level.scr_anim["seaknight"]["rotors"] = % sniper_escape_ch46_rotors;
  level.scr_animtree["seaknight"] = #animtree;
}

notetrack_roof_door_kicked(guy) {
  flag_set("roof_door_kicked");
}

javelin_reload_deathanim(guy) {
  guy.deathanim = guy.deathanimReload;
  guy notify("reload_begin");
}

javelin_reload_done_deathanim(guy) {
  guy.deathanim = guy.deathanimIdle;
}