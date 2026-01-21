/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_anim.gsc
*****************************************************/

main() {
  maps\_hand_signals::inithandsignals();
  maps\_patrol_anims::main();
  generic_human_anims();
  player_anims();
  dog_anims();
  script_model_anims();
  deer_anims();
  flare_rig_anims();
  thread vehicles_anim();
  thread process_intro_notetracks();
}

process_intro_notetracks() {
  while(!isDefined(level.flag))
    wait 0.25;

  common_scripts\utility::flag_wait("deer_hunt_intro_tr_loaded");
  maps\_anim::addnotetrack_sound("generic", "start", "curtain_cut_in", "scn_deer_cut_screen");
  maps\_anim::addnotetrack_customfunction("generic", "kick", ::door_kick_func, "door_kick");
  maps\_anim::addnotetrack_customfunction("generic", "kick", ::wall_kick_func, "wall_kick");
  maps\_anim::addnotetrack_customfunction("ai_enemy", "knife out", ::gasstation_takedown_knife_notetrack_func);
  maps\_anim::addnotetrack_customfunction("guard", "fire", ::bully_shoots, "bully_kick");
  maps\_anim::addnotetrack_customfunction("civ", "kill", ::gasstation_takedown_knife_notetrack_func, "bully_kick");
  maps\_anim::addnotetrack_customfunction("curtain", "curtain_start", ::curtain_fx, "curtain_cut_in");
  maps\_anim::addnotetrack_attach("generic", "knife_out", "weapon_parabolic_knife", "tag_inhand", "curtain_cut_in");
  maps\_anim::addnotetrack_detach("generic", "knife_in", "weapon_parabolic_knife", "TAG_INHAND", "curtain_cut_in");
  maps\_anim::addnotetrack_customfunction("generic", "knife_out", ::curtain_dust, "curtain_cut_in");
}

curtain_dust(var_0) {
  wait 1;
  playFXOnTag(common_scripts\utility::getfx("vfx_hand_dust"), var_0, "tag_inhand");
  wait 2.5;
  stopFXOnTag(common_scripts\utility::getfx("vfx_hand_dust"), var_0, "tag_inhand");
}

process_beach_notetracks() {}

#using_animtree("generic_human");

generic_human_anims() {
  level.scr_anim["generic"]["shop_door_idle"][0] = % hunted_open_barndoor_idle;
  level.scr_anim["generic"]["shop_door_open"] = % hunted_open_barndoor_flathand;
  level.scr_anim["generic"]["jungle_ghost_patrol_meeting_idle_guy1"][0] = % jungle_ghost_patrol_meeting_idle_guy1;
  level.scr_anim["generic"]["jungle_ghost_patrol_meeting_idle_guy2"][0] = % jungle_ghost_patrol_meeting_idle_guy2;
  level.scr_anim["generic"]["jungle_ghost_patrol_meeting_idle_guy3"][0] = % jungle_ghost_patrol_meeting_idle_guy3;
  level.scr_anim["generic"]["360"] = % combatwalk_f_spin;
  level.scr_anim["generic"]["patrol_idle_meeting"][0] = % jungle_ghost_patrol_meeting_idle_guy3;
  level.scr_anim["generic"]["door_kick"] = % doorkick_2_cqbwalk;
  level.scr_anim["generic"]["wall_kick"] = % door_kick_in;
  level.scr_anim["generic"]["clockwork_checkpoint_tapglass_enemy_a"] = % clockwork_checkpoint_tapglass_enemy_a;
  level.scr_anim["generic"]["flood_convoy_checkpoint_opfor02"] = % flood_convoy_checkpoint_opfor02;
  level.scr_anim["generic"]["flood_convoy_checkpoint_opfor01"] = % flood_convoy_checkpoint_opfor01;
  level.scr_anim["generic"]["clockwork_checkpoint_shoetie_enemy"] = % clockwork_checkpoint_shoetie_enemy;
  level.scr_anim["generic"]["training_pit_stand_idle"] = % training_pit_stand_idle;
  level.scr_anim["generic"]["patrol_jog_orders_once"] = % patrol_jog_orders_once;
  level.scr_anim["generic"]["patrol_jog"] = % patrol_jog;
  level.scr_anim["generic"]["training_humvee_repair"][0] = % training_humvee_repair;
  level.scr_anim["generic"]["civilian_directions_1_A"][0] = % civilian_directions_1_a_once;
  level.scr_anim["generic"]["civilian_directions_2_B"][0] = % civilian_directions_2_b_once;
  level.scr_anim["generic"]["roadkill_opening_sheperd"] = % roadkill_opening_shepherd;
  level.scr_anim["generic"]["run_gun_up"] = % run_casual_gun_up;
  level.scr_anim["generic"]["dh_food_server"][0] = % dh_food_server;
  level.scr_anim["generic"]["dh_outpost_talker_A"] = % dh_outpost_talker_a;
  level.scr_anim["generic"]["dh_outpost_talker_B"] = % dh_outpost_talker_b;
  level.scr_anim["generic"]["creepwalk_duck"] = % creepwalk_traverse_under;
  level.scr_anim["victim"]["dog_kill_long"] = % iw6_dog_kill_back_long_guy_1;
  level.scr_anim["generic"]["knees_idle"][0] = % hostage_knees_idle;
  level.scr_anim["generic"]["knees_idle2"][0] = % coup_civilians_interrogated_civilian_v3;
  level.scr_anim["guard"]["bully_kick"] = % prague_bully_a_kick;
  level.scr_anim["civ"]["bully_kick"] = % prague_bully_civ_kick;
  level.scr_anim["generic"]["curtain_cut_in"] = % dh_curtain_cut_in;
  level.scr_anim["generic"]["curtain_cut_idle"][0] = % dh_curtain_cut_idle;
  level.scr_anim["generic"]["curtain_cut_out"] = % dh_curtain_cut_out;
  level.scr_anim["generic"]["intro1"] = % dh_intro1_guy;
  level.scr_anim["generic"]["affection1"] = % iw6_dog_affection_guy_1;
  level.scr_anim["generic"]["affection"] = % iw6_dog_affection_guy_2;
  level.scr_anim["generic"]["dog_drag_3"] = % iw6_dog_drag_corner_guy_3;
  level.scr_anim["generic"]["london_civ_idle_lookover"][0] = % london_civ_idle_lookover;
  level.scr_anim["generic"]["london_civ_idle_lookbehind"][0] = % london_civ_idle_lookbehind;
  level.scr_anim["generic"]["london_civ_idle_wave"][0] = % london_civ_idle_wave;
  level.scr_anim["generic"]["london_civ_idle_foldarms_scratchass"][0] = % london_civ_idle_foldarms_scratchass;
  level.scr_anim["generic"]["london_civ_idle_scratchnose"][0] = % london_civ_idle_scratchnose;
  level.scr_anim["generic"]["london_civ_idle_foldarms2"][0] = % london_civ_idle_foldarms2;
  level.scr_anim["generic"]["london_inspector_walk"][0] = % london_inspector_walk;
  level.scr_anim["generic"]["london_dock_soldier_walk"][0] = % london_dock_soldier_walk;
  level.scr_anim["generic"]["civilian_walk_cool"][0] = % civilian_walk_cool;
  level.scr_anim["generic"]["dh_outpost_talker_A"] = % dh_outpost_talker_a;
  level.scr_anim["generic"]["dh_outpost_talker_B"] = % dh_outpost_talker_b;
  level.scr_anim["generic"]["quick_affection"] = % iw6_dog_affection_quick_guy_2;
  level.scr_anim["generic"]["cornered_junction_elevator_keypad_loop_hesh"][0] = % cornered_junction_elevator_keypad_loop_hesh;
  level.scr_anim["generic"]["laptop_sit_idle_calm"][0] = % laptop_sit_idle_calm;
  level.scr_anim["generic"]["laptop_sit_idle_active"][0] = % laptop_sit_idle_active;
  level.scr_anim["generic"]["laptop_stand_idle"][0] = % laptop_stand_idle;
  level.scr_anim["generic"]["london_station_civ2_idle"][0] = % london_station_civ2_idle;
  level.scr_anim["generic"]["london_station_civ1_idle"][0] = % london_station_civ1_idle;
  level.scr_anim["generic"]["meetup"] = % dh_ally_meetup_a;
  level.scr_anim["guy2"]["meetup"] = % dh_ally_meetup_b;
  level.scr_anim["hesh"]["2nd_floor"] = % dh_ending_hesh_a;
  level.scr_anim["elias"]["2nd_floor"] = % dh_ending_elias_a;
  level.scr_anim["brian"]["2nd_floor"] = % dh_ending_brian_a;
  level.scr_anim["brian"]["2nd_floor_idle"][0] = % dh_ending_brian_idle_start_a;
  level.scr_anim["elias"]["2nd_floor_idle"][0] = % dh_ending_elias_idle_a;
  level.scr_anim["brian"]["2nd_floor_idle_end"][0] = % dh_ending_brian_idle_end_a;
  level.scr_anim["hesh"]["2nd_floor_stairs"] = % dh_hesh_stair_sequence;
  level.scr_anim["hesh"]["3rd_floor_start"] = % dh_ending_hesh_b;
  level.scr_anim["elias"]["3rd_floor_start"] = % dh_ending_elias_b;
  level.scr_anim["hesh"]["3rd_floor_idle"][0] = % dh_ending_hesh_idle_b;
  level.scr_anim["elias"]["3rd_floor_idle"][0] = % dh_ending_elias_idle_b;
  level.scr_anim["hesh"]["3rd_floor_end"] = % dh_ending_hesh_end_b;
  level.scr_anim["elias"]["3rd_floor_end"] = % dh_ending_elias_end_b;
}

curtain_fx(var_0) {
  common_scripts\utility::flag_set("start_cut");
  common_scripts\utility::exploder("vfx_godray_curtain_stab");
  wait 0.5;
  common_scripts\utility::exploder("vfx_godray_curtain_cut");
}

bully_shoots(var_0) {
  var_0 shoot();
  wait 1;
  var_0 stopanimscripted();
  var_0 maps\_utility::enable_cqbwalk();
}

gasstation_takedown_knife_notetrack_func(var_0) {
  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0.ragdoll_immediate = 1;
  var_0.forceragdollimmediate = 1;
  var_0 kill();
  level thread maps\deer_hunt_util::ragdoll_corpses();
  common_scripts\utility::flag_set("bully_kick_victim_dead");
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_us_rangers";
  level.scr_anim["player_rig"]["intro_jeep_exit_player"] = % deerhunt_dismount_player;
  level.scr_anim["player_rig"]["matv_player_getin"] = % dh_matv_getin_player;
}

#using_animtree("dog");

dog_anims() {
  level.scr_anim["generic"]["walk"] = % iw6_dog_walk;
  level.scr_anim["generic"]["walk_slow"] = % german_shepherd_walk_slow;
  level.scr_anim["generic"]["dog_kill_long"] = % iw6_dog_kill_back_long_1;
  level.scr_anim["generic"]["sneak_idle"] = % iw6_dog_sneakidle;
  level.scr_anim["generic"]["sneak_walk"] = % iw6_dog_sneak_walk_forward;
  level.scr_anim["dog"]["intro1"] = % dh_intro1_dog;
  level.scr_anim["dog"]["affection1"] = % iw6_dog_affection_dog_1;
  level.scr_anim["dog"]["affection"] = % iw6_dog_affection_dog_2;
  level.scr_anim["generic"]["jeep_sit"] = % iw6_dog_traverse_up_70;
  level.scr_anim["dog"]["dog_drag_3"] = % iw6_dog_drag_corner_dog_3;
  level.scr_anim["dog"]["dog_drag_bark_loop"][0] = % iw6_dog_drag_bark_dog_2;
  level.scr_anim["dog"]["quick_affection"] = % iw6_dog_affection_quick_dog_2;
  level.scr_anim["dog"]["matv_enter"] = % deerhunt_dog_jump_up_in;
  level.scr_anim["dog"]["matv_idle"][0] = % deerhunt_dog_jump_up_loop;
  level.scr_anim["dog"]["matv_exit"] = % deerhunt_dog_jump_up_out;
}

#using_animtree("animals");

deer_anims() {
  level.scr_anim["deer0"]["reveal"] = % deerhunt_reveal_deer_a;
  level.scr_anim["deer1"]["reveal"] = % deerhunt_reveal_deer_b;
  level.scr_anim["deer0"]["reveal_idle"][0] = % deerhunt_reveal_deer_a_idle;
  level.scr_anim["deer1"]["reveal_idle"][0] = % deerhunt_reveal_deer_b_idle;
}

#using_animtree("script_model");

flare_rig_anims() {
  level.scr_animtree["flare_rig"] = #animtree;
  level.scr_model["flare_rig"] = "angel_flare_rig";
  level.scr_anim["flare_rig"]["flare"][0] = % ac130_angel_flares01;
  level.scr_anim["flare_rig"]["flare"][1] = % ac130_angel_flares02;
  level.scr_anim["flare_rig"]["flare"][2] = % ac130_angel_flares03;
}

script_model_anims() {
  level.scr_animtree["intro_ball"] = #animtree;
  level.scr_model["intro_ball"] = "tennis_ball_iw6";
  level.scr_anim["intro_ball"]["intro1"] = % dh_intro1_ball;
  level.scr_animtree["chair_1"] = #animtree;
  level.scr_model["chair_1"] = "tag_origin";
  level.scr_anim["chair_1"]["reveal"] = % deerhunt_reveal_chair_1;
  level.scr_animtree["chair_2"] = #animtree;
  level.scr_model["chair_2"] = "tag_origin";
  level.scr_anim["chair_2"]["reveal"] = % deerhunt_reveal_chair_2;
  level.scr_animtree["chair_3"] = #animtree;
  level.scr_model["chair_3"] = "tag_origin";
  level.scr_anim["chair_3"]["reveal"] = % deerhunt_reveal_chair_3;
  level.scr_animtree["chair_4"] = #animtree;
  level.scr_model["chair_4"] = "tag_origin";
  level.scr_anim["chair_4"]["reveal"] = % deerhunt_reveal_chair_4;
  level.scr_animtree["curtain"] = #animtree;
  level.scr_model["curtain"] = "dh_theatre_canvas_anim";
  level.scr_anim["curtain"]["curtain_cut_in"] = % dh_curtain;
  level.scr_anim["curtain"]["curtain_cut_idle"][0] = % dh_curtain_idle;
  level.scr_anim["curtain"]["curtain_cut_out"] = % dh_curtain_out;
}

door_kick_func(var_0) {
  var_1 = getent("kicked_door", "targetname");
  var_1 rotatepitch(-110, 0.5, 0.1, 0.4);
  thread common_scripts\utility::play_sound_in_space("physics_ammobox_default", var_0.origin);
  var_1 connectpaths();
}

wall_kick_func(var_0) {
  var_1 = getEntArray("wall_rebar", "targetname");
  var_2 = getent("wall_clip", "targetname");
  var_3 = getent("player_kick_blocker", "targetname");
  var_4 = (-13707.5, 14076, -195.5);
  var_5 = (-13707.5, 14076, -223);
  physicsexplosionsphere(var_4, 50, 30, 0.5);
  physicsexplosionsphere(var_5, 50, 30, 0.3);
  playFX(common_scripts\utility::getfx("wall_kick_impact_deer_hunt"), var_4);
  common_scripts\utility::array_thread(var_1, ::rebar_rotate);
  var_2.origin = var_2.origin + (0, 0, 10000);
  var_2 connectpaths();
  var_3.origin = var_3.origin + (0, 0, 10000);
  thread common_scripts\utility::play_sound_in_space("wall_kick_impact", var_4);
  thread common_scripts\utility::play_sound_in_space("wall_kick_impact_rubble", var_5);
  wait 1;
  var_2 delete();
  var_3 delete();
}

rebar_rotate() {
  var_0 = randomfloatrange(0.2, 0.4);
  self rotateto(self.angles + (150, 0, 0), var_0, 0.1, var_0 - 0.1);
}

#using_animtree("vehicles");

vehicles_anim() {
  custom_hind_death(%battle_hind_explode_c, "battle_hind_explode_singleV3");
}

custom_hind_death(var_0, var_1) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "battle_hind");
  maps\_anim::note_track_start_sound("start", "exp_armor_vehicle", 1);
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_wing_left", "vfx/gameplay/smoke_trails/vfx_st_heli_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_tailpiece1", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_p2", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_body", "vfx/gameplay/smoke_trails/vfx_st_heli_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_expl_missile", "vfx/gameplay/explosions/vehicle/heli/vfx_exp_heli_primary");
}