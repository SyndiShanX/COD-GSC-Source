/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\af_caves_anim.gsc
********************************************************/

#include maps\_anim;
#include maps\_props;
#include maps\_utility;
#include maps\af_caves_code;

main() {
  anims();
  dialog();
  dog();
  script_models();
  player_animations();
  animated_model_setup();
}

#using_animtree("generic_human");
anims() {
  level.scr_anim["price"]["launchfacility_a_c4_plant_short"] = % launchfacility_a_c4_plant_short;
  level.scr_anim["price"]["favela_run_and_wave"] = % favela_run_and_wave;
  level.scr_anim["price"]["laptop_stand_idle_start"] = % laptop_stand_idle_focused;
  level.scr_anim["price"]["laptop_stand_idle"][0] = % laptop_stand_idle_focused;
  level.scr_anim["price"]["laptop_stand_yell"] = % laptop_stand_lookaway;

  level.scr_anim["price"]["invasion_vehicle_cover_dialogue_guy2"] = % invasion_vehicle_cover_dialogue_guy2;

  level.scr_anim["generic"]["civilian_crawl_1"] = % civilian_crawl_1;
  level.scr_anim["generic"]["civilian_crawl_2"] = % civilian_crawl_2;
  level.scr_anim["generic"]["civilian_leaning_death"] = % civilian_leaning_death;
  level.scr_anim["generic"]["civilian_leaning_death_death"] = % civilian_leaning_death_shot;
  level.scr_anim["generic"]["hunted_dazed_walk_C_limp"] = % hunted_dazed_walk_C_limp;
  level.scr_anim["generic"]["hunted_dazed_walk_C_limp_death"] = % exposed_death_falltoknees;
  level.scr_anim["generic"]["hunted_dazed_walk_B_blind"] = % hunted_dazed_walk_B_blind;

  level.scr_anim["generic"]["cqb_stand_idle_scan"] = % patrol_bored_react_look_v1;
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

  add_sit_load_ak_notetracks("generic");
  level.scr_anim["generic"]["sit_load_ak_idle"][0] = % sitting_guard_loadAK_idle;
  level.scr_anim["generic"]["sit_load_ak_react"] = % sitting_guard_loadAK_react1;

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

  level.scr_anim["generic"]["_stealth_behavior_whizby_0"] = % exposed_idle_reactA;
  level.scr_anim["generic"]["_stealth_behavior_whizby_1"] = % exposed_idle_reactB;
  level.scr_anim["generic"]["_stealth_behavior_whizby_2"] = % exposed_idle_twitch;
  level.scr_anim["generic"]["_stealth_behavior_whizby_3"] = % exposed_idle_twitch_v4;
  level.scr_anim["generic"]["_stealth_behavior_whizby_4"] = % run_pain_stumble;

  level.scr_anim["generic"]["_stealth_behavior_spotted_short"] = % exposed_idle_twitch_v4;
  level.scr_anim["generic"]["_stealth_behavior_spotted_long"] = % exposed_idle_twitch_v4;
  level.scr_anim["generic"]["_stealth_behavior_heard_scream"] = % exposed_idle_twitch_v4;

  level.scr_anim["generic"]["combat_jog"] = % combat_jog;

  level.scr_anim["generic"]["smoking_reach"] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["generic"]["smoking"][0] = % parabolic_leaning_guy_smoking_idle;
  level.scr_anim["generic"]["smoking"][1] = % parabolic_leaning_guy_smoking_twitch;
  level.scr_anim["generic"]["smoking_react"] = % parabolic_leaning_guy_react;

  level.scr_anim["generic"]["sit_idle"][0] = % breach_chair_idle_v2;
  level.scr_anim["generic"]["sit_react"] = % breach_chair_reaction_v2;

  level.scr_anim["generic"]["fridge_idle"][0] = % arcadia_fridge_idle;
  level.scr_anim["generic"]["fridge_react"] = % arcadia_fridge_react;

  level.scr_anim["generic"]["sleep_idle1"][0] = % afgan_caves_sleeping_guard_idle;
  level.scr_anim["generic"]["sleep_death1"] = % cargoship_sleeping_guy_death_1;
  level.scr_anim["generic"]["sleep_alert1"] = % afgan_caves_sleeping_guard_scramble;

  level.scr_anim["generic"]["chess_surprise_1"] = % parabolic_chessgame_surprise_a;
  level.scr_anim["generic"]["chess_surprise_2"] = % parabolic_chessgame_surprise_b;
  level.scr_anim["generic"]["chess_idle_1"][0] = % parabolic_chessgame_idle_a;
  level.scr_anim["generic"]["chess_idle_2"][0] = % parabolic_chessgame_idle_b;
  level.scr_anim["chess_guy1"]["chess_death_1"] = % parabolic_chessgame_death_a;
  level.scr_anim["chess_guy2"]["chess_death_2"] = % parabolic_chessgame_death_b;

  level.scr_anim["generic"]["signal_moveout_cqb"] = % CQB_stand_signal_move_out;
  level.scr_anim["generic"]["signal_moveup_cqb"] = % CQB_stand_signal_move_up;
  level.scr_anim["generic"]["signal_go_cqb"] = % CQB_stand_wave_go_v1;
  level.scr_anim["generic"]["signal_stop_cqb"] = % CQB_stand_signal_stop;
  level.scr_anim["generic"]["signal_onme_cqb"] = % CQB_stand_wave_on_me;

  level.scr_anim["price"]["intro_stop"] = % afgan_caves_intro_stop;

  level.scr_anim["generic"]["run_2_crouch_f"] = % run_2_crouch_f;
  level.scr_anim["generic"]["crouch_fastwalk_f"] = % crouch_fastwalk_F;
  level.scr_anim["generic"]["crouch_talk"] = % casual_crouch_V2_talk;
  level.scr_anim["generic"]["crouch_idle"] = % casual_crouch_idle;

  level.scr_anim["generic"]["look_up_stand"] = % coverstand_look_moveup;
  level.scr_anim["generic"]["look_idle_stand"][0] = % coverstand_look_idle;
  level.scr_anim["generic"]["look_down_stand"] = % coverstand_look_movedown;

  level.scr_anim["price"]["rise_up"] = % scout_sniper_price_prone_opening;
  level.scr_anim["price"]["price_slide"] = % afgan_caves_price_slide;

  level.scr_anim["price"]["rappel"] = % afgan_caves_price_rappel_animatic;
  level.scr_anim["price"]["pri_rappel_setup"] = % afgan_caves_price_rappel_setup;
  level.scr_anim["price"]["pri_rappel_idle"][0] = % afgan_caves_price_rappel_idle;
  addNotetrack_customFunction("price", "rope", maps\af_caves::price_rope_hookup, "pri_rappel_setup");

  level.scr_anim["price"]["pri_rappel_jump"] = % afgan_caves_price_rappel_jump;
  addNotetrack_attach("price", "knife", "weapon_parabolic_knife", "TAG_INHAND", "pri_rappel_jump");

  level.scr_anim["price"]["pri_hanging_idle"][0] = % afgan_caves_Price_hanging_idle;

  level.scr_anim["price"]["pri_rappel_kill"] = % afgan_caves_Price_rappel_kill;
  addNotetrack_detach("price", "knife", "weapon_parabolic_knife", "TAG_INHAND", "pri_rappel_kill");

  level.scr_anim["guard_2"]["flick"] = % cliff_guardA_flick;
  level.scr_anim["guard_2"]["guardB_idle"][0] = % cliff_guardB_idle;
  level.scr_anim["guard_2"]["guardB_react"] = % cliff_guardB_react;
  level.scr_anim["guard_2"]["guard_2_death"] = % afgan_caves_guard_2_death;

  level.scr_anim["guard_1"]["rappel_kill"] = % afgan_caves_guard_1_death;
  level.scr_anim["guard_1"]["guardA_idle"][0] = % cliff_guardA_idle;
  level.scr_anim["guard_1"]["guardA_react"] = % cliff_guardA_react;

  addNotetrack_customFunction("guard_1", "kill", ::kill_me);
  addNotetrack_customFunction("guard_1", "death_gurgle", ::rappel_guard1_deathgurgle, "rappel_kill");

  level.scr_anim["guard_2"]["rappel"] = % afgan_caves_guard_2_animatic;

  level.scr_anim["generic"]["steamroom_knifekill_price"] = % parabolic_knifekill_mark;
  level.scr_anim["generic"]["steamroom_knifekill_guard"] = % parabolic_knifekill_phoneguy;
  level.scr_anim["generic"]["steamroom_knifekill_guard_idle"][0] = % parabolic_phoneguy_idle;
  level.scr_anim["generic"]["steamroom_knifekill_guard_reaction"] = % parabolic_phoneguy_reaction;

  level.scr_anim["price"]["pri_dive"] = % hunted_dive_2_pronehide_v1;
  level.scr_anim["price"]["pri_prone_stand"] = % hunted_pronehide_2_stand_v1;

  level.scr_anim["price"]["pri_bridge_jump"] = % jump_across_100_stumble;
  addNotetrack_flag("price", "footstep_right_large", "price_jumping", "pri_bridge_jump");
  addNotetrack_flag("price", "footstep_left_large", "price_jumped", "pri_bridge_jump");

  level.scr_anim["destroyer"]["shoot_bridge"] = % corner_standL_trans_A_2_B_v2;

  level.scr_anim["generic"]["killhouse_sas_price_idle"][0] = % killhouse_sas_price_idle;
  level.scr_anim["generic"]["look_idle_cornerR"][0] = % corner_standr_look_idle;
  level.scr_anim["generic"]["alert2look_cornerR"] = % corner_standr_alert_2_look;

  level.scr_anim["generic"]["patrol_bored_react_walkstop"] = % patrol_bored_react_walkstop;
  level.scr_anim["generic"]["breach_react_push_guy2"] = % breach_react_push_guy2;
  level.scr_anim["generic"]["breach_react_push_guy1"] = % breach_react_push_guy1;
  level.scr_anim["generic"]["breach_react_guntoss_v2_guy1"] = % breach_react_guntoss_v2_guy1;
  level.scr_anim["generic"]["breach_react_guntoss_v2_guy2"] = % breach_react_guntoss_v2_guy2;
  level.scr_anim["generic"]["breach_react_knife_charge"] = % breach_react_knife_charge;
  level.scr_anim["generic"]["breach_react_knife_charge_death"] = % death_shotgun_back_v1;

  level.scr_anim["nade_tosser"]["cqb_nade_throw"] = % CQB_stand_grenade_throw;
  addNotetrack_flag("nade_tosser", "grenade_throw", "nade_tossed", "cqb_nade_throw");
}

#using_animtree("animated_props");
animated_model_setup() {
  level.anim_prop_models["foliage_desertbrush_1_animated"]["sway"] = % foliage_desertbrush_1_sway;
}

#using_animtree("dog");
dog() {
  level.scr_anim["generic"]["dog_idle"][0] = % german_shepherd_attackidle;
  level.scr_anim["generic"]["dog_eating"][0] = % german_shepherd_eating;
  level.scr_anim["generic"]["dog_eating_single"] = % german_shepherd_eating;
  level.scr_anim["generic"]["dog_growling"][0] = % german_shepherd_attackidle_growl;

  level.scr_anim["generic"]["dog_barking"][0] = % german_shepherd_attackidle_growl;
  level.scr_anim["generic"]["dog_barking"][1] = % german_shepherd_attackidle_bark;
  level.scr_anim["generic"]["dog_barking"][2] = % german_shepherd_attackidle_bark;
  level.scr_anim["generic"]["dog_barking"][3] = % german_shepherd_attackidle_bark;
}

#using_animtree("script_model");
script_models() {
  level.scr_model["knife"] = "weapon_parabolic_knife";

  level.scr_anim["chair"]["sleep_react"] = % parabolic_guard_sleeper_react_chair;
  level.scr_animtree["chair"] = #animtree;
  level.scr_model["chair"] = "com_folding_chair";

  level.scr_anim["chair_ak"]["sit_load_ak_react"] = % sitting_guard_loadAK_idle_chair;
  level.scr_animtree["chair_ak"] = #animtree;
  level.scr_model["chair_ak"] = "com_folding_chair";

  level.scr_anim["flashlight"]["fl_death"] = % blackout_flashlightguy_death_flashlight;
  level.scr_sound["flashlight"]["fl_death"] = "scn_blackout_drop_flashlight";

  level.scr_anim["flashlight"]["search"] = % blackout_flashlightguy_moment2death_flashlight;
  level.scr_sound["flashlight"]["search"] = "scn_blackout_drop_flashlight_draw";

  level.scr_anim["rope"]["rappel_hookup"] = % afgan_caves_player_hookup_rope;
  level.scr_model["rope"] = "weapon_carabiner_thin_rope";
  level.scr_animtree["rope"] = #animtree;

  level.scr_anim["rope_price"]["rope_hookup"] = % afgan_caves_price_hookup_rope;
  level.scr_model["rope_price"] = "weapon_carabiner_thin_rope";
  level.scr_animtree["rope_price"] = #animtree;

  level.scr_anim["rappel_rope_price"]["pri_rappel_jump"] = % afgan_caves_Price_rappel_jump_rappelRope;
  level.scr_anim["rappel_rope_price"]["pri_hanging_idle"][0] = % afgan_caves_Price_hanging_idle_rappelRope;
  level.scr_anim["rappel_rope_price"]["pri_rappel_idle"][0] = % afgan_caves_Price_rappel_idle_rappelRope;
  level.scr_model["rappel_rope_price"] = "afgan_caves_rappel_rope";
  level.scr_animtree["rappel_rope_price"] = #animtree;

  level.scr_anim["tarp"]["rise_up"] = % scout_sniper_sand_ghillie_tarp_emerge;
  level.scr_animtree["tarp"] = #animtree;
  level.scr_model["tarp"] = "scout_sniper_sand_ghillie_tarp";

  level.scr_anim["breach_door_model_caves"]["breach"] = % breach_player_door_v2;
  level.scr_animtree["breach_door_model_caves"] = #animtree;
  level.scr_model["breach_door_model_caves"] = "com_door_03_handleright";

  level.scr_anim["breach_door_hinge_caves"]["breach"] = % breach_player_door_hinge_v1;
  level.scr_animtree["breach_door_hinge_caves"] = #animtree;
  level.scr_model["breach_door_hinge_caves"] = "com_door_piece_hinge3";

  level.scr_animtree["lamp"] = #animtree;
  level.scr_model["lamp"] = "ch_industrial_light_animated_01_on";
  level.scr_anim["lamp"]["swing"] = % swinging_industrial_light_01_mild;
  level.scr_anim["lamp"]["swing_dup"] = % swinging_industrial_light_01_mild_dup;
}

#using_animtree("player");
player_animations() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_tf141";
  level.scr_anim["player_rig"]["rappel_close"] = % afgan_caves_player_rappel_close;
  level.scr_anim["player_rig"]["rappel_far"] = % afgan_caves_player_rappel_far;

  level.scr_anim["player_rig"]["rappel_close_node"] = % cave_rappel_close;
  level.scr_anim["player_rig"]["rappel_far_node"] = % cave_rappel_far;
  level.scr_anim["player_rig"]["rappel_hookup"] = % afgan_caves_player_rappel_hookup;

  level.scr_anim["player_rig"]["rappel_root"] = % cave_rappel;
  level.scr_anim["player_rig"]["rappel_kill"] = % afgan_caves_player_rappel_end_kill;

  addNotetrack_customFunction("player_rig", "start_guard", ::start_guard_anim);
}

start_guard_anim(guy) {
  self anim_single_solo(self.guard, "rappel_kill");
}

kill_me(guy) {
  guy.a.nodeath = true;
  guy.allowdeath = true;
  guy.diequietly = true;
  guy kill();
}

dialog() {
  level.scr_radio["pri_gonnagetaway"] = "afcaves_pri_gonnagetaway";
}