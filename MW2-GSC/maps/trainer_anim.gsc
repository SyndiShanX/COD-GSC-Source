/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\trainer_anim.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");
main() {
  anims();
  dialogue();
  vehicles();
  basketball_anims();
  model_anims();
}

anims() {
  maps\_props::add_smoking_notetracks("generic");

  level.scr_anim["foley"]["training_intro_begining"] = % training_intro_foley_begining;

  addNotetrack_flag("foley", "ps_train_fly_welcome", "ps_train_fly_welcome", "training_intro_begining");
  addNotetrack_flag("foley", "ps_train_fly_demonstration", "ps_train_fly_demonstration", "training_intro_begining");
  addNotetrack_flag("foley", "ps_train_fly_nooffense", "ps_train_fly_nooffense", "training_intro_begining");
  addNotetrack_flag("foley", "ps_train_fly_makesyoulook", "ps_train_fly_makesyoulook", "training_intro_begining");
  addNotetrack_flag("foley", "ps_train_fly_showem", "ps_train_fly_showem", "training_intro_begining");
  addNotetrack_flag("foley", "pickup", "foley_anim_pickup_weapon", "training_intro_begining");

  level.scr_anim["translator"]["training_intro_begining_start"] = % training_intro_translator_begining;
  level.scr_anim["translator"]["training_intro_begining"][0] = % training_intro_translator_begining;
  level.scr_anim["trainee_01"]["training_intro_begining_start"] = % training_intro_trainee_1_begining;
  level.scr_anim["trainee_01"]["training_intro_begining"][0] = % training_intro_trainee_1_begining;

  level.scr_anim["foley"]["training_intro_idle"][0] = % training_intro_foley_idle_1;
  level.scr_anim["translator"]["training_intro_idle"][0] = % training_intro_translator_idle;
  level.scr_anim["trainee_01"]["training_intro_idle"][0] = % training_intro_trainee_1_transition_idle;

  level.scr_anim["foley"]["training_intro_foley_turnaround_1"] = % training_intro_foley_turnaround_1;
  level.scr_anim["foley"]["training_intro_foley_turnaround_2"] = % training_intro_foley_turnaround_2;

  level.scr_anim["foley"]["training_intro_foley_idle_talk_1"] = % training_intro_foley_idle_talk_1;
  level.scr_anim["foley"]["training_intro_foley_idle_talk_2"] = % training_intro_foley_idle_talk_2;

  level.scr_anim["foley"]["training_intro_end"] = % training_intro_foley_end;
  addNotetrack_flag("foley", "dialog_1", "notetrack_dialogue_foley_thanks_for_help", "training_intro_end");
  addNotetrack_flag("foley", "dialog_2", "notetrack_dialogue_foley_who_go_first", "training_intro_end");

  level.scr_anim["translator"]["training_intro_end"] = % training_intro_translator_end;
  level.scr_anim["trainee_01"]["training_intro_end"] = % training_intro_trainee_1_end;

  level.scr_anim["foley"]["training_intro_end_idle"][0] = % training_intro_foley_end_idle;
  level.scr_anim["translator"]["training_intro_end_idle"][0] = % training_intro_translator_end_idle;
  level.scr_anim["trainee_01"]["training_intro_end_idle"][0] = % training_intro_trainee_1_end_idle;
  addNotetrack_customFunction("trainee_01", "fire_spray", ::trainee_fire_weapon);

  level.scr_anim["soldier_wounded"]["hummer_sequence"] = % training_humvee_wounded;
  level.scr_anim["soldier_door"]["hummer_sequence"] = % training_humvee_soldier;

  level.scr_anim["generic"]["training_locals_groupA_guy1"][0] = % training_locals_groupA_guy1;
  level.scr_anim["generic"]["training_locals_groupA_guy2"][0] = % training_locals_groupA_guy2;
  level.scr_anim["generic"]["training_locals_groupB_guy1"][0] = % training_locals_groupB_guy1;
  level.scr_anim["generic"]["training_locals_groupB_guy2"][0] = % training_locals_groupB_guy2;
  level.scr_anim["generic"]["training_locals_sit"][0] = % training_locals_sit;
  level.scr_anim["generic"]["training_locals_kneel"][0] = % training_locals_kneel;

  level.scr_anim["generic"]["smoke_idle"][0] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["smoke_reach"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["smoke"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["smoke_react"] = % patrol_bored_react_look_advance;

  level.scr_anim["generic"]["lean_smoke_idle"][0] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["generic"]["lean_smoke_idle"][1] = % parabolic_leaning_guy_smoking_twitch;
  level.scr_anim["generic"]["lean_smoke_react"] = % parabolic_leaning_guy_react;

  level.scr_anim["lean_smoker"]["lean_smoke_idle"][0] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["lean_smoker"]["lean_smoke_idle"][1] = % parabolic_leaning_guy_smoking_twitch;
  level.scr_anim["lean_smoker"]["lean_smoke_react"] = % parabolic_leaning_guy_react;

  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_walk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["generic"]["patrol_stop"] = % patrol_bored_walk_2_bored;
  level.scr_anim["generic"]["patrol_start"] = % patrol_bored_2_walk;
  level.scr_anim["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;

  level.scr_anim["generic"]["patrol_idle_1"] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_idle_2"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_3"] = % patrol_bored_idle_cellphone;
  level.scr_anim["generic"]["patrol_idle_4"] = % patrol_bored_twitch_bug;
  level.scr_anim["generic"]["patrol_idle_5"] = % patrol_bored_twitch_checkphone;
  level.scr_anim["generic"]["patrol_idle_6"] = % patrol_bored_twitch_stretch;

  level.scr_anim["generic"]["patrol_idle_smoke"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_checkphone"] = % patrol_bored_twitch_checkphone;
  level.scr_anim["generic"]["patrol_idle_stretch"] = % patrol_bored_twitch_stretch;
  level.scr_anim["generic"]["patrol_idle_phone"] = % patrol_bored_idle_cellphone;

  level.scr_anim["generic"]["combat_jog"] = % combat_jog;

  level.scr_anim["generic"]["smoking_reach"] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["generic"]["smoking"][0] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["generic"]["smoking"][1] = % parabolic_leaning_guy_smoking_twitch;
  level.scr_anim["generic"]["smoking_react"] = % parabolic_leaning_guy_react;

  level.scr_anim["generic"]["training_jog_guy1"] = % training_jog_guy1;
  level.scr_anim["generic"]["training_jog_guy2"] = % training_jog_guy2;
  level.scr_anim["generic"]["casual_killer_jog_A"] = % casual_killer_jog_A;
  level.scr_anim["generic"]["casual_killer_jog_B"] = % casual_killer_jog_B;
  level.scr_anim["generic"]["freerunnerA_loop"] = % freerunnerA_loop;
  level.scr_anim["generic"]["freerunnerB_loop"] = % freerunnerB_loop;
  level.scr_anim["generic"]["huntedrun_1_idle"] = % huntedrun_1_idle;

  level.scr_anim["generic"]["training_sleeping_in_chair"][0] = % training_sleeping_in_chair;
  level.scr_anim["generic"]["training_basketball_rest"][0] = % training_basketball_rest;

  level.scr_anim["generic"]["training_basketball_guy1"][0] = % training_basketball_guy1;
  level.scr_anim["generic"]["training_basketball_guy2"][0] = % training_basketball_guy2;
  level.scr_anim["generic"]["training_humvee_repair"][0] = % training_humvee_repair;

  level.scr_anim["generic"]["training_pushups_guy1"][0] = % training_pushups_guy1;

  level.scr_anim["generic"]["training_pushups_guy2"][0] = % training_pushups_guy2;

  level.scr_anim["generic"]["training_humvee_repair"][0] = % training_humvee_repair;
  level.scr_anim["generic"]["killhouse_laptop_idle"][0] = % killhouse_laptop_idle;
  level.scr_anim["generic"]["killhouse_laptop_idle"][1] = % killhouse_laptop_lookup;
  level.scr_anim["generic"]["killhouse_laptop_idle"][2] = % killhouse_laptop_twitch;
  level.scr_anim["generic"]["cliffhanger_welder_wing"][0] = % cliffhanger_welder_wing;

  level.scr_anim["generic"]["cliffhanger_welder_engine"][0] = % cliffhanger_welder_engine;
  level.scr_anim["generic"]["patrolstand_idle"][0] = % patrolstand_idle;
  level.scr_anim["generic"]["parabolic_guard_sleeper_idle"][0] = % parabolic_guard_sleeper_idle;
  level.scr_anim["generic"]["roadkill_cover_spotter_idle"][0] = % roadkill_cover_spotter_idle;
  level.scr_anim["generic"]["oilrig_balcony_smoke_idle"][0] = % oilrig_balcony_smoke_idle;
  level.scr_anim["generic"]["killhouse_gaz_idleB"][0] = % killhouse_gaz_idleB;
  level.scr_anim["generic"]["civilian_sitting_talking_A_2"][0] = % civilian_sitting_talking_A_2;
  level.scr_anim["generic"]["parabolic_leaning_guy_smoking_idle"][0] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["generic"]["parabolic_leaning_guy_idle"][0] = % parabolic_leaning_guy_idle;
  level.scr_anim["generic"]["parabolic_leaning_guy_idle_training"][0] = % parabolic_leaning_guy_idle_training;
  level.scr_anim["generic"]["civilian_texting_sitting"][0] = % civilian_texting_sitting;
  level.scr_anim["generic"]["sitting_guard_loadAK_idle"][0] = % sitting_guard_loadAK_idle;
  level.scr_anim["generic"]["afgan_caves_sleeping_guard_idle"][0] = % afgan_caves_sleeping_guard_idle;
  level.scr_anim["generic"]["cargoship_sleeping_guy_idle_2"][0] = % cargoship_sleeping_guy_idle_2;
  level.scr_anim["generic"]["civilian_sitting_talking_A_1"][0] = % civilian_sitting_talking_A_1;
  level.scr_anim["generic"]["bunker_toss_idle_guy1"][0] = % bunker_toss_idle_guy1;
  level.scr_anim["generic"]["roadkill_cover_radio_soldier3"][0] = % roadkill_cover_radio_soldier3;
  level.scr_anim["generic"]["civilian_sitting_talking_B_1"][0] = % civilian_sitting_talking_B_1;
  level.scr_anim["generic"]["civilian_smoking_A"][0] = % civilian_smoking_A;
  level.scr_anim["generic"]["civilian_reader_1"][0] = % civilian_reader_1;
  level.scr_anim["generic"]["civilian_reader_2"][0] = % civilian_reader_2;

  level.scr_anim["generic"]["guardA_sit_sleeper_sleep_idle"] = % guardA_sit_sleeper_sleep_idle;
  level.scr_anim["generic"]["roadkill_humvee_map_sequence_quiet_idle"][0] = % roadkill_humvee_map_sequence_quiet_idle;
  level.scr_anim["generic"]["guardB_sit_drinker_idle"][0] = % guardB_sit_drinker_idle;
  level.scr_anim["generic"]["guardB_standing_cold_idle"][0] = % guardB_standing_cold_idle;
  level.scr_anim["generic"]["civilian_texting_standing"][0] = % civilian_texting_standing;
  level.scr_anim["generic"]["killhouse_sas_2_idle"][0] = % killhouse_sas_2_idle;
  level.scr_anim["generic"]["killhouse_sas_3_idle"][0] = % killhouse_sas_3_idle;
  level.scr_anim["generic"]["killhouse_sas_price_idle"][0] = % killhouse_sas_price_idle;
  level.scr_anim["generic"]["killhouse_sas_1_idle"][0] = % killhouse_sas_1_idle;
  level.scr_anim["generic"]["little_bird_casual_idle_guy1"][0] = % little_bird_casual_idle_guy1;
  level.scr_anim["generic"]["sniper_escape_spotter_idle"][0] = % sniper_escape_spotter_idle;
  level.scr_anim["generic"]["patrol_bored_idle"][0] = % patrol_bored_idle;

  level.scr_anim["generic"]["training_woundedwalk_soldier_1"] = % training_woundedwalk_soldier_1;
  level.scr_anim["generic"]["training_woundedwalk_soldier_2"] = % training_woundedwalk_soldier_2;

  level.scr_anim["generic"]["hostage_pickup_runout_guy1"] = % hostage_pickup_runout_guy1;
  level.scr_anim["generic"]["hostage_pickup_runout_guy2"] = % hostage_pickup_runout_guy2;

  level.scr_anim["generic"]["DC_Burning_stop_bleeding_medic"] = % DC_Burning_stop_bleeding_medic;
  addNotetrack_attach("generic", "attach prop", "clotting_powder_animated", "TAG_INHAND", "DC_Burning_stop_bleeding_medic");
  addNotetrack_detach("generic", "dettach prop", "clotting_powder_animated", "TAG_INHAND", "DC_Burning_stop_bleeding_medic");

  level.scr_anim["generic"]["DC_Burning_stop_bleeding_wounded"] = % DC_Burning_stop_bleeding_wounded;
  level.scr_anim["generic"]["DC_Burning_stop_bleeding_medic_idle"][0] = % DC_Burning_stop_bleeding_medic_endidle;
  level.scr_anim["generic"]["DC_Burning_stop_bleeding_wounded_idle"][0] = % DC_Burning_stop_bleeding_wounded_endidle;

  level.scr_anim["carrier"]["wounded_pickup"] = % wounded_pickup_carrierguy;
  level.scr_anim["carried"]["wounded_pickup"] = % wounded_pickup_carriedguy;

  level.scr_anim["carrier"]["wounded_carry"] = % wounded_carry_fastwalk_carrier;
  level.scr_anim["carried"]["wounded_carry"] = % wounded_carry_fastwalk_wounded;

  level.scr_anim["generic"]["cliff_guardA_flick"] = % cliff_guardA_flick;

  level.scr_anim["generic"]["unarmed_climb_wall"] = % unarmed_climb_wall;

  level.scr_anim["generic"]["civilian_walk_coffee"][0] = % civilian_walk_coffee;
  level.scr_anim["generic"]["civilian_walk_cool"][0] = % civilian_walk_cool;
  level.scr_anim["generic"]["patrol_bored_patrolwalk"][0] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrolwalk_swagger"][0] = % patrolwalk_swagger;
  level.scr_anim["generic"]["civilian_walk_hurried_1"][0] = % civilian_walk_hurried_1;
  level.scr_anim["generic"]["civilian_crowd_behavior_A"][0] = % civilian_crowd_behavior_A;
  level.scr_anim["generic"]["civilian_crazywalker_loop"][0] = % civilian_crazywalker_loop;
  level.scr_anim["generic"]["civilian_cellphonewalk"][0] = % civilian_cellphonewalk;
  level.scr_anim["generic"]["civilian_briefcase_walk_shoelace"][0] = % civilian_briefcase_walk_shoelace;
  level.scr_anim["generic"]["civilian_sodawalk"][0] = % civilian_sodawalk;

  addNotetrack_customFunction("generic", "footstep_right_large", ::bounce_fx);
  addNotetrack_customFunction("generic", "footstep_left_large", ::bounce_fx);
  addNotetrack_customFunction("generic", "footstep_right_small", ::bounce_fx);
  addNotetrack_customFunction("generic", "footstep_left_small", ::bounce_fx);

  level.scr_anim["dunn"]["training_pit_sitting_welcome"] = % training_pit_sitting_welcome;
  level.scr_anim["dunn"]["training_pit_sitting_idle"][0] = % training_pit_sitting_idle;

  level.scr_anim["dunn"]["training_pit_stand_idle"][0] = % training_pit_stand_idle;

  level.scr_anim["dunn"]["training_pit_open_case"] = % training_pit_open_case;

  addNotetrack_customFunction("dunn", "dialog", ::notetrack_dunn_welcome_dialogue_01, "training_pit_sitting_welcome");
  addNotetrack_customFunction("dunn", "dialog2", ::notetrack_dunn_welcome_dialogue_02, "training_pit_sitting_welcome");
  addNotetrack_customFunction("dunn", "case_flip_01", ::notetrack_dunn_case_flip_01, "training_pit_open_case");
  addNotetrack_customFunction("dunn", "case_flip_02", ::notetrack_dunn_case_flip_02, "training_pit_open_case");
  addNotetrack_customFunction("dunn", "button_press", ::notetrack_dunn_button_press, "training_pit_open_case");
  addNotetrack_flag("dunn", "dialog", "dunn_notetrack_open_case_dialogue", "training_pit_open_case");
}

notetrack_dunn_welcome_dialogue_01(guy) {
  flag_set("dunn_dialogue_welcome_01");
}

notetrack_dunn_welcome_dialogue_02(guy) {
  flag_set("dunn_dialogue_welcome_02");
}

notetrack_dunn_case_flip_01(guy) {
  flag_set("case_flip_01");
}

notetrack_dunn_case_flip_02(guy) {
  flag_set("case_flip_02");
}

notetrack_dunn_button_press(guy) {
  flag_set("button_press");
  self thread play_sound_in_space("scn_training_fence_button");
}

dialogue() {
  level.scr_sound["court_nag_00"] = "train_ar2_getoffcourt";

  level.scr_sound["court_nag_01"] = "train_ar2_waityourturn";

  level.scr_sound["court_nag_02"] = "train_ar2_allenwhatthe";

  level.scr_sound["foley"]["train_fly_welcome"] = "train_fly_welcome";

  level.scr_sound["translator"]["train_fly_welcome"] = "train_aft_welcome";

  level.scr_sound["foley"]["train_fly_demonstration"] = "train_fly_demonstration";

  level.scr_sound["translator"]["train_fly_demonstration"] = "train_aft_demonstration";

  level.scr_sound["foley"]["train_fly_nooffense"] = "train_fly_nooffense";

  level.scr_sound["translator"]["train_fly_nooffense"] = "train_aft_nooffense";

  level.scr_sound["foley"]["train_fly_makesyoulook"] = "train_fly_makesyoulook";

  level.scr_sound["translator"]["train_fly_makesyoulook"] = "train_aft_makesyoulook";

  level.scr_sound["foley"]["train_fly_showem"] = "train_fly_showem";

  level.scr_sound["foley"]["train_fly_fireattargets"] = "train_fly_fireattargets";
  level.scr_face["foley"]["train_fly_fireattargets"] = % train_fly_fireattargets;

  level.scr_sound["foley"]["train_fly_turnaround"] = "train_fly_turnaround";
  level.scr_face["foley"]["train_fly_turnaround"] = % train_fly_turnaround;

  level.scr_sound["foley"]["nag_rifle_pickup_01"] = "train_fly_grabthatweapon";

  level.scr_sound["foley"]["nag_rifle_pickup_02"] = "train_fly_comeonallen";

  level.scr_sound["foley"]["nag_hip_fire_01"] = "train_fly_dontaimdown";

  level.scr_sound["foley"]["nag_hip_fire_02"] = "train_fly_firefromthehip";

  level.scr_sound["foley"]["train_fly_tryafew"] = "train_fly_tryafew";

  level.scr_sound["foley"]["train_fly_sprayedbullets"] = "train_fly_sprayedbullets";

  level.scr_sound["translator"]["train_fly_sprayedbullets"] = "train_aft_sprayedbullets";

  level.scr_sound["foley"]["train_fly_pickyourtargets"] = "train_fly_pickyourtargets";

  level.scr_sound["translator"]["train_fly_pickyourtargets"] = "train_aft_pickyourtargets";

  level.scr_sound["foley"]["train_fly_howtherangers"] = "train_fly_howtherangers";
  level.scr_face["foley"]["train_fly_howtherangers"] = % train_fly_howtherangers;

  level.scr_sound["translator"]["train_fly_howtherangers"] = "train_aft_howtherangers";

  level.scr_sound["foley"]["train_fly_crouchfirst"] = "train_fly_crouchfirst";

  level.scr_sound["translator"]["train_fly_crouchfirst"] = "train_aft_crouchfirst";

  level.scr_sound["foley"]["nag_ads_fire_01"] = "train_fly_beforeengaging";

  level.scr_sound["foley"]["nag_ads_fire_02"] = "train_fly_dontforget";

  level.scr_sound["foley"]["nag_crouch_fire_01"] = "train_fly_crouchingstance";

  level.scr_sound["foley"]["nag_crouch_fire_02"] = "train_fly_crouched";

  level.scr_sound["foley"]["train_fly_howyoudoit"] = "train_fly_howyoudoit";

  level.scr_sound["foley"]["train_fly_gottaaim"] = "train_fly_gottaaim";

  level.scr_sound["translator"]["train_fly_gottaaim"] = "train_aft_gottaaim";

  level.scr_sound["foley"]["train_fly_switching"] = "train_fly_switching";

  level.scr_sound["translator"]["train_fly_switching"] = "train_aft_switching";

  level.scr_sound["foley"]["train_fly_popinandout"] = "train_fly_popinandout";
  level.scr_face["foley"]["train_fly_popinandout"] = % train_fly_popinandout;

  level.scr_sound["translator"]["train_fly_popinandout"] = "train_aft_popinandout";

  level.scr_sound["foley"]["train_fly_showemprivate"] = "train_fly_showemprivate";
  level.scr_face["foley"]["train_fly_showemprivate"] = % train_fly_showemprivate;

  level.scr_sound["foley"]["train_fly_iftargetclose"] = "train_fly_iftargetclose";

  level.scr_sound["translator"]["train_fly_iftargetclose"] = "train_aft_iftargetclose";

  level.scr_sound["foley"]["timed_ads_too_slow_00"] = "train_fly_tooslow";

  level.scr_sound["foley"]["timed_ads_too_slow_01"] = "train_fly_acquirenew";

  level.scr_sound["foley"]["timed_ads_too_slow_02"] = "train_fly_poppinginandout";

  level.scr_sound["foley"]["timed_ads_not_snapping_00"] = "train_fly_speeditup";

  level.scr_sound["foley"]["timed_ads_not_snapping_01"] = "train_fly_notsnapping";

  level.scr_sound["foley"]["timed_ads_not_snapping_02"] = "train_fly_doingitwrong";

  level.scr_sound["foley"]["nag_ads_snap_01"] = "train_fly_aimtosnap";

  level.scr_sound["foley"]["nag_ads_snap_02"] = "train_fly_forgettoaim";

  level.scr_sound["foley"]["nag_ads_snap_03"] = "train_fly_fromthehip";

  level.scr_sound["foley"]["nag_ads_snap_04"] = "train_fly_notaimingprop";

  level.scr_sound["foley"]["train_fly_lightcover"] = "train_fly_lightcover";
  level.scr_face["foley"]["train_fly_lightcover"] = % train_fly_lightcover;

  level.scr_sound["translator"]["train_fly_lightcover"] = "train_aft_lightcover";

  level.scr_sound["foley"]["train_fly_theprivatehere"] = "train_fly_theprivatehere";
  level.scr_face["foley"]["train_fly_theprivatehere"] = % train_fly_theprivatehere;

  level.scr_sound["translator"]["train_fly_theprivatehere"] = "train_aft_theprivatehere";

  level.scr_sound["foley"]["nag_penetration_fire_01"] = "train_fly_woodpanel";
  level.scr_face["foley"]["nag_penetration_fire_01"] = % train_fly_woodpanel;

  level.scr_sound["foley"]["nag_penetration_fire_02"] = "train_fly_allenwoodpanel";

  level.scr_sound["foley"]["train_fly_tossafrag"] = "train_fly_tossafrag";

  level.scr_sound["translator"]["train_fly_tossafrag"] = "train_aft_tossafrag";

  level.scr_sound["foley"]["train_fly_pickupfrag"] = "train_fly_pickupfrag";
  level.scr_face["foley"]["train_fly_pickupfrag"] = % train_fly_pickupfrag;

  level.scr_sound["foley"]["train_fly_grenadedownrange"] = "train_fly_grenadedownrange";
  level.scr_face["foley"]["train_fly_grenadedownrange"] = % train_fly_grenadedownrange;

  level.scr_sound["foley"]["train_fly_fragstendtoroll"] = "train_fly_fragstendtoroll";
  level.scr_face["foley"]["train_fly_fragstendtoroll"] = % train_fly_fragstendtoroll;

  level.scr_sound["translator"]["train_fly_fragstendtoroll"] = "train_aft_fragstendtoroll";

  level.scr_sound["translator"]["train_fly_grenadedownrange"] = "train_aft_grenadedownrange";

  level.scr_sound["foley"]["frag_nag_00"] = "train_fly_throwagrenade";

  level.scr_sound["foley"]["frag_nag_01"] = "train_fly_letsgothrow";

  level.scr_sound["foley"]["frag_nag_02"] = "train_fly_grenadedownrange";

  level.scr_sound["foley"]["train_fly_good"] = "train_fly_good";

  level.scr_sound["foley"]["train_fly_thanksforhelp"] = "train_fly_thanksforhelp";

  level.scr_sound["foley"]["train_fly_gofirst"] = "train_fly_gofirst";

  level.scr_sound["translator"]["train_fly_gofirst"] = "train_aft_gofirst";

  level.scr_sound["dunn"]["train_cpd_welcomeback"] = "train_cpd_welcomeback";

  level.scr_sound["dunn"]["train_cpd_specialop"] = "train_cpd_specialop";

  level.scr_sound["dunn"]["train_cpd_grabapistol"] = "train_cpd_grabapistol";
  level.scr_face["dunn"]["train_cpd_grabapistol"] = % train_cpd_grabapistol;

  level.scr_sound["dunn"]["train_cpd_alreadyhave"] = "train_cpd_alreadyhave";

  level.scr_sound["dunn"]["train_cpd_switchtorifle"] = "train_cpd_switchtorifle";
  level.scr_face["dunn"]["train_cpd_switchtorifle"] = % train_cpd_switchtorifle;

  level.scr_sound["dunn"]["train_cpd_switchtosidearm"] = "train_cpd_switchtosidearm";
  level.scr_face["dunn"]["train_cpd_switchtosidearm"] = % train_cpd_switchtosidearm;

  level.scr_sound["dunn"]["train_cpd_tryswitching"] = "train_cpd_tryswitching";

  level.scr_sound["dunn"]["train_cpd_alwaysfaster"] = "train_cpd_alwaysfaster";
  level.scr_face["dunn"]["train_cpd_alwaysfaster"] = % train_cpd_alwaysfaster;

  level.scr_sound["dunn"]["train_cpd_smileforcameras"] = "train_cpd_smileforcameras";

  level.scr_sound["dunn"]["train_cpd_timerstarts"] = "train_cpd_timerstarts";
  level.scr_face["dunn"]["train_cpd_timerstarts"] = % train_cpd_timerstarts;

  level.scr_sound["dunn"]["train_cpd_donthaveallday"] = "train_cpd_donthaveallday";
  level.scr_face["dunn"]["train_cpd_donthaveallday"] = % train_cpd_donthaveallday;

  level.scr_sound["dunn"]["train_cpd_bothintrouble"] = "train_cpd_bothintrouble";

  level.scr_sound["dunn"]["train_cpd_putusin"] = "train_cpd_putusin";
  level.scr_face["dunn"]["train_cpd_putusin"] = % train_cpd_putusin;

  level.scr_sound["dunn"]["train_cpd_socombrass"] = "train_cpd_socombrass";
  level.scr_face["dunn"]["train_cpd_socombrass"] = % train_cpd_socombrass;

  level.scr_sound["dunn"]["train_cpd_realaction"] = "train_cpd_realaction";
  level.scr_face["dunn"]["train_cpd_realaction"] = % train_cpd_realaction;

  level.scr_sound["dunn"]["train_cpd_sigh"] = "train_cpd_sigh";

  level.scr_radio["train_cpd_clearthearea"] = "train_cpd_clearthearea";

  level.scr_radio["train_cpd_clearfirstgogogo"] = "train_cpd_clearfirstgogogo";

  level.scr_radio["train_cpd_areacleared"] = "train_cpd_areacleared";

  level.scr_radio["train_cpd_upthestairs"] = "train_cpd_upthestairs";

  level.scr_radio["train_cpd_lastareamove"] = "train_cpd_lastareamove";

  level.scr_radio["train_cpd_justswitch"] = "train_cpd_justswitch";

  level.scr_radio["train_cpd_missedsome"] = "train_cpd_missedsome";

  level.scr_radio["train_cpd_lefttargets"] = "train_cpd_lefttargets";

  level.scr_radio["train_cpd_watchout"] = "train_cpd_watchout";

  level.scr_radio["train_cpd_awwkilled"] = "train_cpd_awwkilled";

  level.scr_radio["train_cpd_acivilian"] = "train_cpd_acivilian";

  level.scr_radio["train_cpd_melee"] = "train_cpd_melee";

  level.scr_radio["train_cpd_jumpdown"] = "train_cpd_jumpdown";

  level.scr_radio["train_cpd_sprint"] = "train_cpd_sprint";

  level.scr_radio["melee_nag_00"] = "train_cpd_melee";

  level.scr_radio["melee_nag_01"] = "train_cpd_needtouseknife";

  level.scr_radio["melee_nag_02"] = "train_cpd_nobullets";

  level.scr_radio["melee_nag_03"] = "train_cpd_meleethattarget";

  level.scr_radio["melee_nag_04"] = "train_cpd_useyourknife";

  level.scr_radio["pit_ads_nag_00"] = "train_cpd_stopfiringfromhip";

  level.scr_radio["pit_ads_nag_01"] = "train_cpd_aimsightsprivate";

  level.scr_radio["pit_ads_nag_02"] = "train_cpd_needtoaim";

  level.scr_radio["nag_hurry_00"] = "train_cpd_timedcourse";

  level.scr_radio["nag_hurry_01"] = "train_cpd_movingforward";

  level.scr_radio["nag_hurry_02"] = "train_cpd_movingforwardgo";

  level.scr_radio["nag_hurry_03"] = "train_cpd_runningoutoftime";

  level.scr_radio["nag_hurry_04"] = "train_cpd_timedcourse2";

  level.scr_radio["nag_didnt_sprint_00"] = "train_cpd_needtosprint";

  level.scr_radio["nag_didnt_sprint_01"] = "train_cpd_didntsprint";

  level.scr_radio["nag_didnt_sprint_02"] = "train_cpd_gobackandsprint";

  level.scr_radio["nag_didnt_sprint_03"] = "train_cpd_cantfinishsprint";

  level.scr_radio["nag_sprint_00"] = "train_cpd_sprinttoexit";

  level.scr_radio["nag_sprint_01"] = "train_cpd_movesprint";

  level.scr_radio["nag_sprint_02"] = "train_cpd_sprintallengogogo";

  level.scr_radio["nag_sprint_03"] = "train_cpd_nowsprint";

  level.scr_sound["dunn"]["train_cpd_targetswithknife"] = "train_cpd_targetswithknife";

  level.scr_sound["dunn"]["train_cpd_longandcivilians"] = "train_cpd_longandcivilians";

  level.scr_sound["dunn"]["train_cpd_longandtargets"] = "train_cpd_longandtargets";

  level.scr_sound["dunn"]["train_cpd_targets"] = "train_cpd_targets";

  level.scr_sound["dunn"]["train_cpd_civilians"] = "train_cpd_civilians";

  level.scr_sound["dunn"]["train_cpd_needtorunagain"] = "train_cpd_needtorunagain";

  level.scr_sound["dunn"]["train_cpd_anothergo"] = "train_cpd_anothergo";
  level.scr_face["dunn"]["train_cpd_anothergo"] = % train_cpd_anothergo;

  level.scr_sound["dunn"]["train_cpd_headupstairs"] = "train_cpd_headupstairs";
  level.scr_face["dunn"]["train_cpd_headupstairs"] = % train_cpd_headupstairs;

  level.scr_sound["dunn"]["train_cpd_runagain"] = "train_cpd_runagain";
  level.scr_face["dunn"]["train_cpd_runagain"] = % train_cpd_runagain;

  level.scr_sound["dunn"]["end_of_course_easy_01"] = "train_cpd_sloppy";
  level.scr_face["dunn"]["train_cpd_sloppy"] = % train_cpd_sloppy;

  level.scr_sound["dunn"]["end_of_course_easy_02"] = "train_cpd_alrgihtiguess";
  level.scr_face["dunn"]["end_of_course_easy_02"] = % train_cpd_alrgihtiguess;

  level.scr_sound["dunn"]["end_of_course_easy_03"] = "train_cpd_goodenough";
  level.scr_face["dunn"]["end_of_course_easy_03"] = % train_cpd_goodenough;

  level.scr_sound["dunn"]["end_of_course_reg_01"] = "train_cpd_roughedges";
  level.scr_face["dunn"]["end_of_course_reg_01"] = % train_cpd_roughedges;

  level.scr_sound["dunn"]["end_of_course_reg_02"] = "train_cpd_wasnthorrible";
  level.scr_face["dunn"]["end_of_course_reg_02"] = % train_cpd_wasnthorrible;

  level.scr_sound["dunn"]["end_of_course_reg_03"] = "train_cpd_lookok";
  level.scr_face["dunn"]["end_of_course_reg_03"] = % train_cpd_lookok;

  level.scr_sound["dunn"]["end_of_course_hard_01"] = "train_cpd_stillgotit";
  level.scr_face["dunn"]["end_of_course_hard_01"] = % train_cpd_stillgotit;

  level.scr_sound["dunn"]["end_of_course_hard_02"] = "train_cpd_prettygood";
  level.scr_face["dunn"]["end_of_course_hard_02"] = % train_cpd_prettygood;

  level.scr_sound["dunn"]["end_of_course_hard_03"] = "train_cpd_verynice";
  level.scr_face["dunn"]["end_of_course_hard_03"] = % train_cpd_verynice;

  level.scr_sound["dunn"]["end_of_course_vet_01"] = "train_cpd_veryimpressive";
  level.scr_face["dunn"]["end_of_course_vet_01"] = % train_cpd_veryimpressive;

  level.scr_sound["dunn"]["end_of_course_vet_02"] = "train_cpd_amazingwork";
  level.scr_face["dunn"]["end_of_course_vet_02"] = % train_cpd_amazingwork;

  level.scr_radio["train_hqr_headedout"] = "train_hqr_headedout";

  level.scr_sound["foley"]["train_fly_movingout"] = "train_fly_movingout";

  level.scr_sound["generic"]["train_ar2_blewthebridge"] = "train_ar2_blewthebridge";

  level.scr_sound["generic"]["train_ar1_trapped"] = "train_ar1_trapped";

  level.scr_sound["conversation_01"][0] = "train_ar3_boonbugged";

  level.scr_sound["conversation_01"][1] = "train_ar4_awol";

  level.scr_sound["conversation_01"][2] = "train_ar2_getthoseletters";

  level.scr_sound["conversation_01"][3] = "train_ar5_wordcame";

  level.scr_sound["conversation_01"][4] = "train_ar2_camelspiders";

  level.scr_sound["conversation_01"][5] = "train_ar1_somebatteries";

  level.scr_sound["conversation_01"][6] = "train_ar2_0800";

  level.scr_sound["conversation_01"][7] = "train_ar1_pushourluck";

  level.scr_sound["conversation_01"][8] = "train_ar4_likeagirl";

  level.scr_sound["conversation_01"][9] = "train_ar4_holdgun";

  level.scr_sound["conversation_01"][10] = "train_ar2_secureturret";

  level.scr_sound["conversation_01"][11] = "train_ar3_sarmajor";

  level.scr_sound["conversation_01"][12] = "train_ar2_nowomen";

  level.scr_sound["conversation_01"][13] = "train_ar2_watchtonight";

  level.scr_sound["conversation_01"][14] = "train_ar5_rolledout";

  level.scr_sound["conversation_01"][15] = "train_ar1_alltheaction";

  level.scr_sound["conversation_01"][16] = "train_ar2_icantsleep";

  level.scr_sound["conversation_01"][17] = "train_ar2_newplugs";

  level.scr_sound["conversation_01"][18] = "train_ar3_getthat";

  level.scr_sound["conversation_01"][19] = "train_ar3_toyourself";

  level.scr_sound["conversation_01"][20] = "train_ar2_combatjack";

  level.scr_sound["conversation_01"][21] = "train_ar2_twomanjob";

  level.scr_sound["conversation_01"][22] = "train_ar5_laugh1";

  level.scr_sound["conversation_01"][23] = "train_ar4_traincops";

  level.scr_sound["conversation_01"][24] = "train_ar4_tracksuits";

  level.scr_sound["conversation_01"][25] = "train_ar4_ridiculous";

  level.scr_sound["conversation_02"][0] = "train_ar1_noammo";

  level.scr_sound["conversation_02"][1] = "train_ar2_coldblooded";

  level.scr_sound["conversation_02"][2] = "train_ar4_monkey";

  level.scr_sound["conversation_02"][3] = "train_ar5_laugh1";

  level.scr_sound["conversation_02"][4] = "train_ar2_wannagohome";

  level.scr_sound["conversation_02"][5] = "train_ar1_motorpool";

  level.scr_sound["conversation_02"][6] = "train_ar2_getpaid";

  level.scr_sound["conversation_02"][7] = "train_ar3_checkmate";

  level.scr_sound["conversation_02"][8] = "train_ar4_weakman";

  level.scr_sound["conversation_02"][9] = "train_ar5_deltateam";

  level.scr_sound["conversation_02"][10] = "train_ar1_dontthink";

  level.scr_sound["conversation_02"][11] = "train_ar2_freakymask";

  level.scr_sound["conversation_02"][12] = "train_ar2_seenmyduffel";

  level.scr_sound["conversation_02"][13] = "train_ar3_nonregulation";

  level.scr_sound["conversation_02"][14] = "train_ar4_yathink";

  level.scr_sound["conversation_02"][15] = "train_ar5_bendersays";

  level.scr_sound["conversation_02"][16] = "train_ar1_nobody";

  level.scr_sound["conversation_02"][17] = "train_ar2_tellinya";

  level.scr_sound["conversation_02"][18] = "train_ar3_bendersaysalot";

  level.scr_sound["conversation_02"][19] = "train_ar2_whateverjerk";

  level.scr_sound["conversation_02"][20] = "train_ar4_raisins";

  level.scr_sound["conversation_02"][21] = "train_ar5_yeah";

  level.scr_sound["conversation_02"][22] = "train_ar1_forkemover";

  level.scr_sound["conversation_02"][23] = "train_ar2_thanksman";

  level.scr_sound["conversation_02"][24] = "train_ar2_howsyourfamily";

  level.scr_sound["conversation_02"][25] = "train_ar3_bloodtype";

  level.scr_sound["conversation_02"][26] = "train_ar4_dboysdo";

  level.scr_sound["conversation_02"][27] = "train_ar2_boxoftracers";

  level.scr_sound["conversation_02"][28] = "train_ar2_sleepsometime";

  level.scr_sound["conversation_02"][29] = "train_ar4_tasteofsand";

  level.scr_sound["conversation_02"][30] = "train_ar4_sandyorafice";

  level.scr_sound["conversation_02"][31] = "train_ar4_crapsand";

  level.scr_sound["conversation_03"][0] = "train_ar5_fixturret";

  level.scr_sound["conversation_03"][1] = "train_ar3_bct1";

  level.scr_sound["conversation_03"][2] = "train_ar4_packasmokes";

  level.scr_sound["conversation_03"][3] = "train_ar2_stufffrommom";

  level.scr_sound["conversation_03"][4] = "train_ar5_laugh3";

  level.scr_sound["conversation_03"][5] = "train_ar3_onetracer";

  level.scr_sound["conversation_03"][6] = "train_ar4_coolidea";

  level.scr_sound["conversation_03"][7] = "train_ar4_oldlady";

  level.scr_sound["conversation_03"][8] = "train_ar4_dontwish";

  level.scr_sound["conversation_03"][9] = "train_ar2_tookmywater";

  level.scr_sound["conversation_03"][10] = "train_ar1_extramag";

  level.scr_sound["conversation_03"][11] = "train_ar2_gotfive";

  level.scr_sound["conversation_03"][12] = "train_ar5_wannalive";

  level.scr_sound["conversation_03"][13] = "train_ar1_huah";

  level.scr_sound["conversation_03"][14] = "train_ar2_givemeahand";

  level.scr_sound["conversation_03"][15] = "train_ar4_grownman";

  level.scr_sound["conversation_03"][16] = "train_ar5_laugh2";

  level.scr_sound["conversation_03"][17] = "train_ar1_carefulbooker";

  level.scr_sound["conversation_03"][18] = "train_ar2_tightschedule";

  level.scr_sound["conversation_03"][19] = "train_ar3_tooslow";

  level.scr_sound["conversation_03"][20] = "train_ar4_swimming";

  level.scr_sound["conversation_03"][21] = "train_ar2_seedeltaguys";

  level.scr_sound["conversation_03"][22] = "train_ar2_shewashot";

  level.scr_sound["conversation_03"][23] = "train_ar4_stillgay";

  level.scr_sound["conversation_03"][24] = "train_ar4_kidding";

  level.scr_sound["conversation_03"][25] = "train_ar4_dontaskdonttell";
}

#using_animtree("vehicles");
vehicles() {
  level.scr_anim["bridge_layer_bridge"]["bridge_lower"] = % roadkill_M60A1_bridge_lower;
  level.scr_anim["bridge_layer_bridge"]["bridge_raise"] = % M60A1_bridge_raise;

  level.scr_anim["bridge_layer"]["bridge_lower"] = % roadkill_M60A1_tank_lower;
  level.scr_anim["bridge_layer"]["bridge_raise"] = % M60A1_tank_raise;

  level.scr_anim["bridge_layer"]["bridge_arm_lower"] = % roadkill_M60A1_arm_lower;

  level.scr_animtree["bridge_layer_bridge"] = #animtree;
  level.scr_animtree["bridge_layer"] = #animtree;

  level.scr_anim["hummer"]["hummer_sequence"] = % training_humvee_door;
  level.scr_animtree["hummer"] = #animtree;
}

#using_animtree("script_model");
model_anims() {
  level.scr_anim["pit_gun"]["training_pit_sitting_welcome"] = % training_pit_sitting_welcome_gun;
  level.scr_anim["pit_gun"]["training_pit_sitting_idle"][0] = % training_pit_sitting_idle_gun;
  level.scr_anim["pit_gun"]["training_pit_stand_idle"][0] = % training_pit_stand_idle_gun;
  level.scr_anim["pit_gun"]["training_pit_open_case"] = % training_pit_open_case_gun;

  level.scr_animtree["pit_gun"] = #animtree;

  level.scr_anim["training_case_01"]["training_pit_open_case"] = % training_pit_case_1;
  level.scr_anim["training_case_02"]["training_pit_open_case"] = % training_pit_case_2;

  level.scr_animtree["training_case_01"] = #animtree;
  level.scr_animtree["training_case_02"] = #animtree;

  level.scr_anim["tarp"]["training_camo_tarp_wind"][0] = % training_camo_tarp_wind;
  level.scr_animtree["tarp"] = #animtree;

  tarps = getEntArray("tarps", "targetname");
  foreach(tarp in tarps) {
    tarp.animent = spawn("script_origin", (0, 0, 0));
    tarp.animent.origin = tarp.origin;
    tarp.animent.angles = tarp.angles;
    tarp.animname = "tarp";
    tarp assign_animtree();
    tarp.animent thread anim_loop_solo(tarp, "training_camo_tarp_wind", "stop_loop");
  }
}

#using_animtree("animated_props");
basketball_anims() {
  level.scr_anim["basketball"]["training_basketball_loop"][0] = % training_basketball_ball;
  level.scr_animtree["basketball"] = #animtree;

  addNotetrack_customFunction("basketball", "ps_scn_trainer_bball_dribble", ::bounce_fx);
  addNotetrack_customFunction("basketball", "ps_scn_trainer_bball_bounce_pass", ::bounce_fx);
}

bounce_fx(basketball) {
  playFXOnTag(getfx("ball_bounce_dust_runner"), basketball, "tag_origin");
}

trainee_fire_weapon(guy) {
  if(!flag("player_near_range"))
    return;
  guy playSound("drone_m4carbine_fire_npc");
  playFXOnTag(getfx("m16_muzzleflash"), guy, "tag_flash");
}