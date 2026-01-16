/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_2_anim.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include maps\voice\voice_angola_2;
#include maps\angola_2_util;
#include maps\angola_2_amb;
#include maps\createart\angola_art;
#include maps\angola_barge;
#include maps\angola_jungle_stealth;
#include maps\angola_jungle_ending;
#include maps\angola_2;

main() {
  maps\voice\voice_angola_2::init_voice();
  level thread maps\angola_2_util::fxanim_grass();
  river_heli_attack_animation();
  river_heli_crash();
  intruder_anims();
  jungle_stealth_anims();
  village_anims();
  jungle_escape_anims();
  finding_woods_anim();
  barge_barrel_anims();
  hudson_ladders();
  barge_destroyed_anims();
  enemy_boat_ramming();
  precache_assets();
  boat_explosive_death();
  init_angola_anims();
  custom_patrol_init();
}

#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

enemy_boat_ramming() {
  barge_panel_anims();
  level.scr_anim["boarding_boat"]["enemy_boat_ram_barge_left"] = % v_ang_06_01_enemy_boat_ram_boat_left_approach;
  addnotetrack_customfunction("boarding_boat", "screen_shake", ::gunboat_left_ram_fx, "enemy_boat_ram_barge_left");
  level.scr_anim["boarding_boat"]["enemy_boat_ram_barge_right"] = % v_ang_06_01_enemy_boat_ram_boat_right_approach;
  addnotetrack_customfunction("boarding_boat", "screen_shake", ::gunboat_right_ram_fx, "enemy_boat_ram_barge_right");
  level.scr_anim["boarding_boat"]["enemy_boat_ram_barge_frontleft"] = % v_ang_06_01_enemy_boat_ram_boat_left_approach_front;
  addnotetrack_customfunction("boarding_boat", "screen_shake", ::gunboat_left_ram_fx, "enemy_boat_ram_barge_frontleft");
  level.scr_anim["boarding_boat"]["enemy_boat_ram_barge_frontright"] = % v_ang_06_01_enemy_boat_ram_boat_right_approach_front;
  addnotetrack_customfunction("boarding_boat", "screen_shake", ::gunboat_right_ram_fx, "enemy_boat_ram_barge_frontright");
  level.scr_anim["boarding_boat"]["boat_back_veer_back_left"] = % v_ang_06_01_enemy_boat_ram_boat_left_back_veer_backward;
  level.scr_anim["boarding_boat"]["boat_back_veer_back_right"] = % v_ang_06_01_enemy_boat_ram_boat_right_back_veer_backward;
  level.scr_anim["boarding_boat"]["boat_back_veer_front_right"] = % v_ang_06_01_enemy_boat_ram_boat_right_back_veer_forward;
  level.scr_anim["boarding_boat"]["boat_back_veer_front_left"] = % v_ang_06_01_enemy_boat_ram_boat_left_back_veer_forward;
  level.scr_anim["boarding_boat"]["boat_front_veer_front_right"] = % v_ang_06_01_enemy_boat_ram_boat_right_front_veer_foward;
  level.scr_anim["boarding_boat"]["boat_front_veer_front_left"] = % v_ang_06_01_enemy_boat_ram_boat_left_front_veer_forward;
  level.scr_anim["boarding_boat"]["boat_front_veer_back_right"] = % v_ang_06_01_enemy_boat_ram_boat_right_front_veer_backward;
  level.scr_anim["boarding_boat"]["boat_front_veer_back_left"] = % v_ang_06_01_enemy_boat_ram_boat_left_front_veer_backward;
  level.scr_anim["boarding_boat"]["boat_death_00"] = % fxanim_angola_boat_death_med_01_anim;
  level.scr_anim["boarding_boat"]["boat_death_01"] = % fxanim_angola_boat_death_med_02_anim;
  level.scr_anim["boarding_boat"]["boat_death_02"] = % fxanim_angola_boat_death_med_03_anim;
  level.scr_anim["boarding_boat"]["boat_death_03"] = % fxanim_angola_boat_death_med_04_anim;
  level.scr_anim["small_boat"]["boat_death_00"] = % fxanim_angola_boat_death_sml_01_anim;
  level.scr_anim["small_boat"]["boat_death_01"] = % fxanim_angola_boat_death_sml_02_anim;
  level.scr_anim["small_boat"]["boat_death_02"] = % fxanim_angola_boat_death_sml_03_anim;
  level.scr_anim["small_boat"]["boat_death_03"] = % fxanim_angola_boat_death_sml_04_anim;
  add_scene("enemy_boat_left_riders", "main_barge");
  add_actor_anim("enemy_ai_left_0", % ch_ang_06_01_enemy_boat_ram_guy01, 0, 1, 0, 0, "tag_origin");
  add_actor_anim("enemy_ai_left_1", % ch_ang_06_01_enemy_boat_ram_guy02, 0, 1, 0, 0, "tag_origin");
  add_scene_loop("enemy_boat_driver_idle", "main_barge");
  add_actor_anim("enemy_boat_guard_driver", % ch_ang_05_05_gunboat_drive_hudson, 1, 1, 0, 0, "tag_origin");
  add_scene_loop("enemy_ramming_boat_idle_frontleft", "main_barge");
  add_vehicle_anim("enemy_ramming_boat_frontleft", % v_ang_06_01_enemy_boat_ram_boat_left_idle_front);
  add_scene_loop("enemy_ramming_boat_idle_frontright", "main_barge");
  add_vehicle_anim("enemy_ramming_boat_frontright", % v_ang_06_01_enemy_boat_ram_boat_right_idle_front);
  add_scene("enemy_boat_driver_crash", "main_barge");
  add_vehicle_anim("enemy_ramming_boat_left", % v_ang_06_01_enemy_boat_ram_veer_boat);
  add_scene("enemy_boat_right_riders", "main_barge");
  add_actor_anim("enemy_ai_right_0", % ch_ang_06_01_enemy_boat_ram_guy04, 0, 1, 0, 0, "tag_origin");
  add_actor_anim("enemy_ai_right_1", % ch_ang_06_01_enemy_boat_ram_guy05, 0, 1, 0, 0, "tag_origin");
  add_scene_loop("enemy_ramming_boat_idle_right", "main_barge");
  add_vehicle_anim("enemy_ramming_boat_right", % v_ang_06_01_enemy_boat_ram_idle_rightboat);
  add_scene("s_gunboat_death_01", undefined, 0, 0, 0, 1);
  add_vehicle_anim("small_gunboat_anim", % fxanim_angola_boat_death_sml_01_anim, 1);
  add_notetrack_custom_function("small_gunboat_anim", "boat_flip_impact_01", ::play_splash_effect);
  add_scene("s_gunboat_death_02", undefined, 0, 0, 0, 1);
  add_vehicle_anim("small_gunboat_anim", % fxanim_angola_boat_death_sml_02_anim, 1);
  add_notetrack_custom_function("small_gunboat_anim", "boat_flip_impact_02", ::play_splash_effect);
  add_scene("s_gunboat_death_03", undefined, 0, 0, 0, 1);
  add_vehicle_anim("small_gunboat_anim", % fxanim_angola_boat_death_sml_03_anim, 1);
  add_notetrack_custom_function("small_gunboat_anim", "boat_flip_impact_03", ::play_splash_effect);
  add_scene("signature_gunboat_death", undefined, 0, 0, 0, 1);
  add_vehicle_anim("signature_gunboat", % fxanim_angola_boat_jump_01_anim, 1);
  add_scene("signature_small_gunboat_death", "signature_gunboat");
  add_prop_anim("small_sig_gunboat", % fxanim_angola_boat_jump_02_anim, "veh_t6_sea_gunboat_small", 1);
  add_notetrack_custom_function("small_sig_gunboat", "boat_jump_launch", ::play_signature_boat_fx_launch);
  add_notetrack_custom_function("small_sig_gunboat", "boat_jump_impact", ::play_sig_splash_effect);
  add_scene("crate_knockoff", "main_barge");
  add_actor_anim("crate_knockoff_guy", % ch_ang_06_01_crate_push_guy, 0, undefined, 1);
  add_prop_anim("crate_knockoff_crate", % o_ang_06_01_crate_push_box, undefined, 0);
  level.scr_anim["enemy_ai_left_0"]["board_idle"][0] = % ch_ang_06_01_enemy_boat_ram_left_idle_guy01;
  level.scr_anim["enemy_ai_left_1"]["board_idle"][0] = % ch_ang_06_01_enemy_boat_ram_left_idle_guy02;
  level.scr_anim["enemy_ai_right_0"]["board_idle"][0] = % ch_ang_06_01_enemy_boat_ram_right_idle_guy01;
  level.scr_anim["enemy_ai_right_1"]["board_idle"][0] = % ch_ang_06_01_enemy_boat_ram_right_idle_guy02;
  level.scr_anim["enemy_ai_left_0"]["board_barge_frontleft"] = % ch_ang_06_01_upper_deck_enemies_left_guy01;
  level.scr_anim["enemy_ai_left_1"]["board_barge_frontleft"] = % ch_ang_06_01_upper_deck_enemies_left_guy02;
  level.scr_anim["enemy_ai_right_0"]["board_barge_frontright"] = % ch_ang_06_01_upper_deck_enemies_right_guy01;
  level.scr_anim["enemy_ai_right_1"]["board_barge_frontright"] = % ch_ang_06_01_upper_deck_enemies_right_guy02;
  level.scr_anim["enemy_ai_left_0"]["board_barge_left_0"] = % ch_ang_06_01_enemy_boat_ram_left_a_guy01;
  level.scr_anim["enemy_ai_left_1"]["board_barge_left_0"] = % ch_ang_06_01_enemy_boat_ram_left_a_guy02;
  level.scr_anim["enemy_ai_left_0"]["board_barge_left_1"] = % ch_ang_06_01_enemy_boat_ram_left_b_guy01;
  level.scr_anim["enemy_ai_left_1"]["board_barge_left_1"] = % ch_ang_06_01_enemy_boat_ram_left_b_guy02;
  level.scr_anim["enemy_ai_right_0"]["board_barge_right_0"] = % ch_ang_06_01_enemy_boat_ram_right_a_guy01;
  level.scr_anim["enemy_ai_right_1"]["board_barge_right_0"] = % ch_ang_06_01_enemy_boat_ram_right_a_guy02;
  level.scr_anim["enemy_ai_right_0"]["board_barge_right_1"] = % ch_ang_06_01_enemy_boat_ram_right_b_guy01;
  level.scr_anim["enemy_ai_right_1"]["board_barge_right_1"] = % ch_ang_06_01_enemy_boat_ram_right_b_guy02;
  level.scr_anim["enemy_ai_driver"]["boat_driver_medium"][0] = % ch_ang_06_01_enemy_medium_boat_driver;
  level.scr_anim["enemy_ai_driver"]["boat_driver_small"][0] = % ch_ang_06_01_enemy_small_boat_driver;
}

play_signature_boat_fx_launch() {
  boat = getent("small_sig_gunboat", "targetname");
  smoke_tag = spawn_model("tag_origin", boat.origin, boat.angles);
  smoke_tag linkto(boat);
  smoke_tag play_fx("small_boat_smoke_trail", smoke_tag.origin, smoke_tag.angles, undefined, 1, "tag_origin");
  wait 5;
  smoke_tag delete();
}

play_sig_splash_effect(guy) {
  boat = getent("small_sig_gunboat", "targetname");

  if(isDefined(boat))
    boat play_fx("splash_fx", boat.origin, boat.angles);
}

play_splash_effect(guy) {
  boat = getent("small_gunboat_anim", "targetname");

  if(isDefined(boat))
    boat play_fx("splash_fx", boat.origin, boat.angles);
}

hudson_ladders() {
  add_scene("hudson_ladder_down", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_01_ladder_traversal_right_down, 0, 1, 0, 1, "tag_origin");
  add_scene("hudson_ladder_up", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_01_ladder_traversal_right_up, 0, 1, 0, 1, "tag_origin");
}

gunboat_right_ram_fx(gunboat) {
  level notify("gunboat_ram_right");
  gunboat play_fx("gunboat_ram_right_splash", gunboat.origin, gunboat.angles, undefined, 1, "tag_origin");
  earthquake(0.5, 3, level.player.origin, 256, level.player);
  level.player playrumbleonentity("explosion_generic");
  level.main_barge play_fx("barge_water_right", level.main_barge.origin, level.main_barge.angles, undefined, 1, "tag_origin");

  if(isDefined(gunboat))
    physicsexplosionsphere(gunboat.origin, 3000, 1000, 0.5);
}

gunboat_left_ram_fx(gunboat) {
  level notify("gunboat_ram_left");
  gunboat play_fx("gunboat_ram_left_splash", gunboat.origin, gunboat.angles, undefined, 1, "tag_origin");
  earthquake(0.5, 3, level.player.origin, 256, level.player);
  level.player playrumbleonentity("explosion_generic");
  level.main_barge play_fx("barge_water_left", level.main_barge.origin, level.main_barge.angles, undefined, 1, "tag_origin");

  if(isDefined(gunboat))
    physicsexplosionsphere(gunboat.origin, 3000, 1000, 0.5);
}

#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("animated_props");

river_heli_crash() {
  add_scene("heli_hit_by_missile", "main_barge");
  add_vehicle_anim("river_player_heli", % v_ang_05_04_going_down_chopper_jump, 0, undefined, "tag_origin");
  add_scene("heli_hit_by_missile_player", "river_player_heli");
  add_player_anim("player_body_river", % ch_ang_05_04_going_down_player, 1, 0, "tag_origin");
  add_scene_loop("heli_hold_steady", "main_barge");
  add_vehicle_anim("river_player_heli", % v_ang_05_04_going_down_idle_chopper);
  add_scene("heli_player_machete_enter", "main_barge");
  add_actor_anim("machete_dude", % ch_ang_05_04_machete_enemy_enter, 0, 1, 0, 1);
  add_scene("player_jump_on_boat", "main_barge");
  add_player_anim("player_body_river", % ch_ang_05_04_boat_jump_player, 1, 0, "tag_origin", 0);
  add_notetrack_custom_function("player_body_river", "black_screen_start", ::machete_blackscreen_start);
  add_notetrack_custom_function("player_body_river", "black_screen_end", ::machete_blackscreen_end);
  add_notetrack_custom_function("player_body_river", "punch", ::machete_punch);
  add_scene("machete_jump", "main_barge");
  add_actor_anim("machete_dude", % ch_ang_05_04_boat_jump_enemy, 0, 0, 1, 1);
  add_actor_anim("hudson", % ch_ang_05_04_boat_jump_hudson, 0, 1, 0, 1);
  add_vehicle_anim("river_player_heli", % v_ang_05_04_boat_jump_chopper, 0, undefined, "tag_origin");
  add_notetrack_custom_function("machete_dude", "stab", ::play_blood_on_machete_dude);
  add_scene("tarp_flyoff", undefined, 0, 0, 0, 1);
  add_prop_anim("tarp_blowoff", % fxanim_angola_barge_tarp_rpg_anim);
}

machete_blackscreen_start(guy) {
  if(!is_mature()) {
    level.machete_blackscreen_on = 1;
    level screen_fade_out(0);
  }
}

machete_blackscreen_end(guy) {
  if(isDefined(level.machete_blackscreen_on))
    level screen_fade_in(0);
}

machete_punch(guy) {
  ai_guy = get_ais_from_scene("machete_jump", "machete_dude");
  playfxontag(getfx("punch_sweat"), ai_guy, "j_head");
  level.player playrumbleonentity("damage_light");
}

#using_animtree("player");

intruder_anims() {
  add_scene("intruder", "intruder_box");
  add_prop_anim("intruder_box_cutter", % o_specialty_angola_intruder_boltcutter, "t6_wpn_boltcutters_prop_view", 1);
  add_prop_anim("intruder_flak_jacket", % o_specialty_angola_intruder_vest, "p6_anim_flak_jacket", 1);
  add_prop_anim("intruder_flak_jaket_amb_1", % o_specialty_angola_intruder_vest_filler1, "p6_anim_flak_jacket");
  add_prop_anim("intruder_flak_jaket_amb_2", % o_specialty_angola_intruder_vest_filler2, "p6_anim_flak_jacket");
  add_prop_anim("intruder_flak_jaket_amb_3", % o_specialty_angola_intruder_vest_filler3, "p6_anim_flak_jacket");
  add_prop_anim("intruder_flak_jaket_amb_4", % o_specialty_angola_intruder_vest_filler4, "p6_anim_flak_jacket");
  add_prop_anim("intruder_box", % o_specialty_angola_intruder_strongbox);
  add_player_anim("player_hands", % int_specialty_angola_intruder, 1);
}

#using_animtree("generic_human");
#using_animtree("animated_props");

river_heli_attack_animation() {
  add_scene_loop("heli_attack_player_idle", "river_player_heli");
  add_player_anim("player_body_river", % ch_ang_05_01_rundown_intro_player_idle, 0, undefined, "tag_origin", 1, 0, 30, 30, 30, 30);
  add_scene("heli_attack_player_intro", "river_player_heli");
  add_player_anim("player_body_river", % ch_ang_05_01_rundown_intro_player, 0, undefined, "tag_origin", 1, 0, 10, 10, 10, 10);
  add_notetrack_custom_function("player_body_river", "player_hit", ::hind_hit_run_scene);
  add_scene("heli_attack_player_fall", "river_player_heli");
  add_player_anim("player_body_river", % ch_ang_05_01_rundown_player_hang_on, 1, undefined, "tag_origin", 1, 0, 10, 10, 10, 10);
  add_scene_loop("heli_attack_hudson_idle", undefined, 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_05_01_rundown_hudson_idle, 1, 1, 0, 1);
  add_scene_loop("handles_loop", "river_player_heli");
  add_prop_anim("handles", % fxanim_angola_heli_gear_anim, "fxanim_angola_heli_gear_mod", 1, 0, undefined, "tag_origin");
  add_scene_loop("crane_loop_idle_1", undefined, 0, 0, 1);
  add_prop_anim("barge_crane_1", % fxanim_angola_barge_crane_idle_anim);
  add_scene_loop("crane_loop_idle_2", undefined, 0, 0, 1);
  add_prop_anim("barge_crane_2", % fxanim_angola_barge_crane_idle_anim);
  add_scene("crane_fall", undefined);
  add_prop_anim("barge_crane_2", % fxanim_angola_barge_crane_rear_fall_anim);
  add_scene("crane_fall_idle", undefined, undefined, undefined, 1);
  add_prop_anim("barge_crane_2", % fxanim_angola_barge_crane_rear_fall_idle_anim);
  add_scene("crane_sink", undefined);
  add_prop_anim("barge_crane_2", % fxanim_angola_barge_crane_rear_sink_anim);
  add_scene("crane_side_fall", undefined);
  add_prop_anim("barge_crane_1", % fxanim_angola_barge_crane_side_fall_anim);
  add_scene("crane_hit", undefined, 0, 0, 0, 1);
  add_prop_anim("barge_crane", % fxanim_angola_barge_crane_hit_anim);
}

hind_hit_run_scene(guy) {
  vh_heli = getent("river_player_heli", "targetname");
  vh_heli linkto(level.main_barge);
  level.player shellshock("default", 3);
  level.player playrumbleonentity("explosion_generic");
  level.player takeallweapons();
  level.player playersetgroundreferenceent(undefined);
  level thread run_scene("heli_hit_by_missile");
  playfxontag(getfx("intro_heli_smoke"), vh_heli, "tag_origin");
  playfxontag(getfx("intro_heli_missle_exp"), vh_heli, "tag_origin");
  playfxontag(getfx("intro_heli_damage"), vh_heli, "tag_origin");
  level notify("intro_heli_hit_by_missile");
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");

boat_ramming_anim() {
  add_scene_loop("hudson_idle_wheel", "main_convoy_escort_boat_medium_1");
  add_actor_anim("hudson", % ch_ang_05_05_gunboat_drive_hudson, 0, 1, 0, 1, "tag_origin");
  add_scene_loop("hudson_idle_steering", "main_convoy_escort_boat_medium_1");
  add_actor_anim("hudson", % ch_ang_06_01_gunboat_wait_hudson, 0, 1, 0, 1, "tag_origin");
  add_scene("boat_ram_barge_player", "main_barge");
  add_player_anim("player_body_river", % ch_ang_06_01_gunboat_ram_player, 1, undefined, "tag_origin", 0, 0, 180, 180, 180, 180, undefined, undefined, 1);
  add_notetrack_custom_function("player_body_river", "boat_ram_snapshot_on", maps\angola_2_amb::sndboatramsnapshoton);
  add_notetrack_custom_function("player_body_river", "boat_ram_snapshot_off", maps\angola_2_amb::sndboatramsnapshotoff);
  add_scene("boat_ram_barge_medium_boat", "main_barge");
  add_vehicle_anim("player_gun_boat", % v_ang_06_01_gunboat_ram_boat);
  add_scene("player_jump_on_barge", "main_barge");
  add_player_anim("player_body_river", % ch_ang_06_01_gunboat_jump_player, 1, undefined, "tag_origin", 0);
  add_scene("hudson_jump_on_barge", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_01_gunboat_jump_hudson, 0, 1, 0, 1, "tag_origin");
  add_vehicle_anim("player_gun_boat", % v_ang_06_01_gunboat_jump_boat);
  add_scene("bye_bye_gun_boat", "main_barge");
  add_vehicle_anim("player_gun_boat", % v_ang_06_01_gunboat_veer_boat);
  add_scene("boat_ramming_guard_right_first", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_enemy03, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_guard_right_second", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_enemy04, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_driver_left_first", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_gunboat01_driver, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_driver_right_first", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_gunboat02_driver, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_guard_left_first", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_enemy01, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_guard_left_second", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_enemy02, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_gunner_left_first", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_gunboat01_gunner, 0, 1, 0, 0, "tag_origin");
  add_scene("boat_ramming_gunner_right_first", "main_convoy_escort_boat_medium_1");
  add_actor_anim("generic", % ch_ang_05_06_boat_battle_gunboat02_gunner, 0, 1, 0, 0, "tag_origin");
}

#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("player");

open_stinger_truck_door() {
  add_scene("player_find_truck", "main_barge");
  add_prop_anim("strella_truck", % v_ang_06_02_get_strella_cargo);
  add_player_anim("player_body_river", % ch_ang_06_02_get_strella_player, 1, undefined, "tag_origin", 0);
  add_scene("player_wheel_house_shell_shock", "main_barge");
  add_vehicle_anim("strella_truck", % v_ang_06_02_wheelhouse_hit_cargo);
  add_player_anim("player_body_river", % ch_ang_06_02_wheelhouse_hit_player, 1, undefined, "tag_origin", 0);
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

finding_woods_anim() {
  add_scene("hudson_container_approach", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_01_container_approach_hudson, 0, 0, 0, 1, "tag_origin");
  add_scene("hudson_container_loop", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_01_container_loop_hudson, 0, 0, 0, 1, "tag_origin");
  add_scene("hudson_container_loop_novo", "main_barge", 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_06_01_container_loop_hudson02, 0, 1, 0, 1, "tag_origin");
  add_scene("open_woods_container", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_02_find_woods_part1_hudson, 0, 1, 0, 1, "tag_origin");
  add_actor_anim("woods", % ch_ang_06_02_find_woods_part1_woods, 1, 1, 0, 1, "tag_origin");
  add_player_anim("player_body_river", % ch_ang_06_02_find_woods_part1_player, 0, undefined, "tag_origin", 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  add_notetrack_custom_function("player_body_river", "sndActivateSnapshot", maps\angola_2_amb::sndfindwoodssnapshot);
  add_notetrack_custom_function("player_body_river", "open_door", maps\createart\angola_art::vision_find_woods);
  add_notetrack_level_notify("player_body_river", "no_hudson", "turn_on_lighting");
  add_scene("container_bodies_body1_p1", "main_barge");
  add_prop_anim("body_1", % ch_ang_06_02_find_woods_part1_body01, "c_usa_angola_corpse2_fb", 0, 0, undefined, "tag_origin");
  add_scene("container_bodies_body2_p1", "main_barge");
  add_prop_anim("body_2", % ch_ang_06_02_find_woods_part1_body02, "c_usa_angola_corpse1_fb", 0, 0, undefined, "tag_origin");
  add_scene("container_open", "main_barge");
  add_prop_anim("woods_container", % v_ang_06_02_find_woods_part1_shipping_container);
  add_scene("open_woods_container_p2", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_02_find_woods_part2_hudson, 0, 1, 0, 1, "tag_origin");
  add_actor_anim("woods", % ch_ang_06_02_find_woods_part2_woods, 1, 1, 0, 1, "tag_origin");
  add_player_anim("player_body_river", % ch_ang_06_02_find_woods_part2_player, 1, undefined, "tag_origin", 0);
  add_notetrack_level_notify("player_body_river", "spawn_hind", "spawn_hind");
  add_notetrack_custom_function("player_body_river", "sndActivateRoom", maps\angola_2_amb::sndfindwoodsroom);
  add_notetrack_level_notify("player_body_river", "sndDeactivateSnapshot", "sndDeactivateSnapshot");
  add_notetrack_level_notify("player_body_river", "sndDeactivateRoom", "sndDeactivateRoom");
  add_notetrack_custom_function("player_body_river", "vision_set", maps\createart\angola_art::vision_leave_container);
  add_scene("container_bodies_body1_p2", "main_barge");
  add_prop_anim("body_1", % ch_ang_06_02_find_woods_part2_body01, undefined, 0, 0, undefined, "tag_origin");
  add_scene("container_bodies_body2_p2", "main_barge");
  add_prop_anim("body_2", % ch_ang_06_02_find_woods_part2_body02, undefined, 0, 0, undefined, "tag_origin");
  add_scene("container_p2", "main_barge");
  add_prop_anim("woods_container", % v_ang_06_02_find_woods_part2_shipping_container);
  add_scene_loop("container_loop", "main_barge");
  add_prop_anim("woods_container", % v_ang_06_02_find_woods_part2_shipping_container_loop);
  add_scene("hudson_carry_woods", "main_barge");
  add_actor_anim("hudson", % ch_ang_06_02_find_woods_cover_hudson, 1, 1, 0, 1, "tag_origin");
  add_actor_anim("woods", % ch_ang_06_02_find_woods_cover_woods, 1, 1, 0, 1, "tag_origin");
  add_scene_loop("woods_outside_animations", "main_barge");
  add_actor_anim("woods", % ch_ang_06_02_find_woods_cover_woods_loop, 1, 1, 0, 1, "tag_origin");
  finding_woods_lighting_anim();
}

finding_woods_lighting_anim() {
  add_scene("open_woods_container_p1_lighting", "container_lighting_align");
  add_actor_model_anim("hudson_lighting", % ch_ang_06_02_find_woods_part1_hudson, undefined, 0, undefined, undefined, "enemy_boat_gunner_1", 0);
  add_actor_model_anim("woods_lighting", % ch_ang_06_02_find_woods_part1_woods, undefined, 0, undefined, undefined, "enemy_boat_gunner_1", 0);
  add_actor_model_anim("player_lighting", % ch_ang_06_02_find_woods_part1_player, undefined, 0, undefined, undefined, "enemy_boat_gunner_1", 0);
  add_actor_model_anim("body_1_lighting", % ch_ang_06_02_find_woods_part1_body01, undefined, 0, undefined, undefined, "enemy_boat_gunner_1", 0);
  add_actor_model_anim("body_2_lighting", % ch_ang_06_02_find_woods_part1_body02, undefined, 0, undefined, undefined, "enemy_boat_gunner_1", 0);
  add_notetrack_custom_function("hudson_lighting", undefined, ::ignore_vo_notetracks);
  add_notetrack_custom_function("woods_lighting", undefined, ::ignore_vo_notetracks);
  add_notetrack_custom_function("player_lighting", undefined, ::ignore_vo_notetracks);
  add_notetrack_custom_function("body_1_lighting", undefined, ::ignore_vo_notetracks);
  add_notetrack_custom_function("body_2_lighting", undefined, ::ignore_vo_notetracks);
  add_scene("open_woods_container_p2_lighting", "container_lighting_align");
  add_actor_model_anim("hudson_lighting", % ch_ang_06_02_find_woods_part2_hudson);
  add_actor_model_anim("woods_lighting", % ch_ang_06_02_find_woods_part2_woods);
  add_actor_model_anim("player_lighting", % ch_ang_06_02_find_woods_part2_player);
  add_notetrack_custom_function("hudson_lighting", undefined, ::ignore_vo_notetracks);
  add_notetrack_custom_function("woods_lighting", undefined, ::ignore_vo_notetracks);
  add_notetrack_custom_function("player_lighting", undefined, ::ignore_vo_notetracks);
}

#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("vehicles");

barge_destroyed_anims() {
  add_scene("player_hind_shell_shock", "swim_to_shore");
  add_actor_anim("hudson", % ch_ang_06_04_hind_aftermath_hudson, 0, 1, 0, 1);
  add_actor_anim("woods", % ch_ang_06_04_hind_aftermath_woods, 1, 1, 0, 1);
  add_prop_anim("aftermath_barrel", % o_ang_06_04_hind_aftermath_barrel, "p6_industrial_barrel_02", 1, 1);
  add_scene_loop("barge_sinking_idle", "swim_to_shore");
  add_vehicle_anim("main_barge", % v_ang_06_04_hind_aftermath_barge);
  add_scene("player_barge_jump", undefined, 0, 0, 0, 1);
  add_player_anim("player_body_river", % ch_ang_06_04_hind_attacks_dive_player);
  add_scene("player_knocked_off_turret", "main_barge");
  add_player_anim("player_body_river", % p_ang_06_04_hind_aftermath_player, 1, undefined, "tag_origin", 1, 0, 10, 10, 10, 10);
  add_notetrack_custom_function("player_body_river", "before_look_sky", maps\angola_barge::hind_falling_animation);
  add_notetrack_custom_function("player_body_river", "head_under_water", ::play_bubbles);
  add_scene_loop("hudson_idle_on_shore", "swim_to_shore");
  add_actor_anim("hudson", % ch_ang_07_01_river_bank_hudson_startloop);
  add_scene("player_swim_to_shore", "swim_to_shore");
  add_player_anim("player_body_river", % p_ang_06_04_rescue_player, 0, undefined, undefined, 1, 0, 10, 10, 10, 10);
  add_notetrack_custom_function("player_body_river", "start_barge_sink", ::start_barge_sinking);
  add_notetrack_custom_function("player_body_river", "sndUWSnapshotStart", ::start_underwater_snapshot);
  add_notetrack_custom_function("player_body_river", "sndUWSnapshotEnd", ::end_underwater_snapshot);
  add_actor_anim("hudson", % ch_ang_06_04_rescue_hudson, 0, 1, 0, 1);
  add_actor_anim("woods", % ch_ang_06_04_rescue_woods, 1, 1, 0, 1);
  add_scene("player_idle_swim", "swim_start", 0, 0, 1);
  add_player_anim("player_body_river", % int_angola_rescue_swim_tread, 0, undefined, "tag_origin", 1, 1, 10, 60, 10, 10, 1, 1);
  add_actor_anim("woods", % ai_angola_rescue_swim_tread, 1, 1, 0, 1, "tag_origin");
  add_notetrack_custom_function("player_body_river", "idle_stroke", ::idle_swim_fx);
  add_scene("player_backstroke_swim", "swim_start", 0, 0, 1);
  add_player_anim("player_body_river", % int_angola_rescue_swim_backstroke, 0, undefined, "tag_origin", 1, 1, 10, 60, 10, 10, 1, 1);
  add_actor_anim("woods", % ai_angola_rescue_swim_backstroke, 1, 1, 0, 1, "tag_origin");
  add_notetrack_custom_function("player_body_river", "swim_stroke", ::backstroke_swim_fx);
  add_scene("hind_crash_on_shore", undefined, 0, 0, 0, 1);
  add_vehicle_anim("river_hind", % fxanim_angola_hind_crash_veh_anim, 1);
  add_scene("woods_truck_flip", "main_barge");
  add_prop_anim("woods_container", % fxanim_angola_barge_gaz66_anim, undefined, 0, 0, undefined, "tag_origin");
  add_scene("wheel_house_explosion", "main_barge");
  add_prop_anim("barge_wheel_house", % fxanim_angola_barge_wheelhouse_anim, undefined, 0, 0, undefined, "tag_origin");
  add_scene_loop("barge_cable_loop", "main_barge");
  add_prop_anim("barge_wheel_house_cables", % fxanim_angola_barge_cables_anim, undefined, 0, 0, undefined, "tag_origin");
  add_scene("barge_aft_explosion", "main_barge");
  add_prop_anim("barge_aft", % fxanim_angola_barge_aft_debris_anim, undefined, 0, 0, undefined, "tag_origin");
  add_scene("barge_side_explosion", "main_barge");
  add_prop_anim("barge_side_damage", % fxanim_angola_barge_side_debris_anim, undefined, 1, 0, undefined, "tag_origin");
  add_scene("barge_bodies_explosion", "main_barge");
  add_prop_anim("body_1", % ch_ang_06_03_corpses_flung_guy01, "c_usa_angola_corpse1_fb", 1, 0, undefined, "tag_origin");
  add_prop_anim("body_2", % ch_ang_06_03_corpses_flung_guy02, "c_usa_angola_corpse2_fb", 1, 0, undefined, "tag_origin");
  add_prop_anim("body_3", % ch_ang_06_03_corpses_flung_guy03, "c_usa_angola_corpse1_fb", 1, 0, undefined, "tag_origin");
  add_prop_anim("body_4", % ch_ang_06_03_corpses_flung_guy04, "c_usa_angola_corpse2_fb", 1, 0, undefined, "tag_origin");
  add_scene("barge_sinking", "swim_to_shore");
  add_vehicle_anim("main_barge", % v_ang_06_04_barge_sinking);
}

play_bubbles(ent) {
  level.player setwatersheeting(1, 3);
  level.player startcameratween(1);
  level.player shellshock("default", 2);
  earthquake(1, 2, level.player.origin, 128, level.player);
  playfxontag(getfx("water_bubbles_player"), ent, "tag_camera");
}

ignore_vo_notetracks(ent) {
  ent.ignore_vo_notetracks = 1;
}

start_underwater_snapshot(guy) {
  level clientnotify("uwsn_strt");
}

end_underwater_snapshot(guy) {
  level clientnotify("uwsn_end");
}

idle_swim_fx(guy) {
  player_model = get_model_or_models_from_scene("player_idle_swim", "player_body_river");
  player_model play_fx("player_wake_idle", player_model.origin, player_model.angles, undefined, 1, "J_Wrist_LE");
}

backstroke_swim_fx(guy) {
  player_model = get_model_or_models_from_scene("player_backstroke_swim", "player_body_river");
  player_model play_fx("player_wake_hand", player_model.origin, player_model.angles, undefined, 1, "J_Wrist_LE");
  level.player playrumbleonentity("damage_light");
}

start_barge_sinking(guy) {
  level.main_barge notify("end_rotate_barge");
  level thread run_scene("barge_sinking");
  a_cover = getentarray("barge_cover_back", "targetname");
  array_delete(a_cover);
  m_barrel_parent = spawn_model("fxanim_angola_barge_barrels_side_mod", level.main_barge.origin, level.main_barge.angles);
  m_barrel_parent linkto(level.main_barge);
  m_barrel_parent.animname = "sinking_barge_barrels";
  m_barrel_parent useanimtree(level.scr_animtree["barge_sink_fxanims"]);

  for(i = 5; i <= 7; i++) {
    str_tag = "barrel0" + i + "_jnt";
    m_barrel_parent attach("p6_industrial_barrel_02", str_tag);
  }

  m_tarp_parent = spawn_model("fxanim_angola_barge_tarp_rpg_mod", level.main_barge.origin, level.main_barge.angles);
  m_tarp_parent linkto(level.main_barge);
  m_tarp_parent.animname = "sinking_barge_tarp";
  m_tarp_parent useanimtree(level.scr_animtree["barge_sink_fxanims"]);
  a_actors = array(m_barrel_parent, m_tarp_parent);
  level.main_barge anim_first_frame(a_actors, "barge_sink_fxanims");
  level waittill("save_woods_swim_started");
  wait 1;

  foreach(m_anim_model in a_actors)
  level.main_barge thread anim_single_aligned(m_anim_model, "barge_sink_fxanims");

  n_time = getanimlength(level.scr_anim["sinking_barge_barrels"]["barge_sink_fxanims"]);
  wait 2;
  level thread run_scene("crane_side_fall");
  wait(n_time - 2);
  array_delete(a_actors);
  s_align = getstruct("swim_to_shore", "targetname");
  m_linker = spawn_model("tag_origin", s_align.origin, s_align.angles);
  scene_wait("barge_sinking");
  level.main_barge linkto(m_linker);
}

#using_animtree("generic_human");

boat_explosive_death() {
  level.scr_anim["chase_boat_gunner_front"]["front_death"] = % ai_crew_gunboat_front_gunner_death_front;
  level.scr_anim["chase_boat_gunner_back"]["back_death"] = % ai_crew_gunboat_rear_gunner_death_right;
}

play_woods_water_fx(guy) {
  playfxontag(level._effect["woods_cough_water"], guy, "j_lip_top_ri");
}

play_blood_on_machete_dude(guy) {
  playfxontag(level._effect["head_blood"], guy, "J_neck");
  level.player playrumbleonentity("angola_hind_ride");
  wait 8;
  level notify("machete_guy_dead");
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

jungle_stealth_anims() {
  add_scene("chopper_dead_body1", "swim_to_shore");
  add_actor_model_anim("chopper_dead_body1", % ch_ang_07_01_charred_bodies_guy01);
  add_scene("chopper_dead_body2", "swim_to_shore");
  add_actor_model_anim("chopper_dead_body2", % ch_ang_07_01_charred_bodies_guy02);
  add_scene("chopper_dead_body3", "swim_to_shore");
  add_actor_model_anim("chopper_dead_body3", % ch_ang_07_01_charred_bodies_guy03);
  add_scene("hudson_mantle_climb", "hudson_mantle", 1);
  add_actor_anim("hudson", % ch_ang_07_02_hudson_mantle_climb_hudson);
  add_scene("hudson_mantle_climb_loop", "hudson_mantle", 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_02_hudson_mantle_loop_hudson);
  add_scene("hudson_mantle_help", "hudson_mantle");
  add_actor_anim("hudson", % ch_ang_07_02_hudson_mantle_hudson);
  add_scene("mason_woods_mantle_help", "hudson_mantle");
  add_actor_anim("woods", % ch_ang_07_02_hudson_mantle_woods, 1);
  add_player_anim("player_body_river", % ch_ang_07_02_hudson_mantle_player, 0, undefined, undefined, 1, 0, 0, 0, 20, 10);
  add_scene("pilot_execution_pilot", "hudson_shoot_pilot");
  add_actor_model_anim("crashed_hind_pilot", % ch_ang_07_02_hind_pilot_pilot);
  add_scene("j_stealth_player_picks_up_woods", "swim_to_shore");
  add_actor_anim("woods", % ch_ang_07_01_carry_woods_woods_pickup, 1);
  add_player_anim("player_body_river", % ch_ang_07_01_carry_woods_player_pickup, 0, undefined, undefined, 1, 0, 0, 0, 20, 10);
  add_scene("j_stealth_player_puts_down_woods", "woods_cover");
  add_actor_anim("woods", % ch_ang_07_03_village_woods, 1);
  add_actor_anim("hudson", % ch_ang_07_03_village_hudson);
  add_player_anim("player_body_river", % p_ang_07_03_village, 1, undefined, undefined, 1, 0, 10, 10, 10, 10);
  add_scene("j_stealth_hudson_woods_sit_down_loop", "woods_cover", 0, 0, 1);
  add_actor_anim("woods", % ch_ang_07_03_village_woods_cycle, 1);
  add_actor_anim("hudson", % ch_ang_07_03_village_hudson_cycle);
  add_scene("j_stealth_player_picks_up_woods_hudson_watches", "swim_to_shore");
  add_actor_anim("hudson", % ch_ang_07_01_river_bank_hudson);
  add_scene("going_down_stairs_8x16_2", "stairs_8x16_2_align", 1);
  add_actor_anim("generic", % ai_staircase_run_down_8x16_2);
  add_scene("hudson_child_soldier_intro_move_to_cover", "child_soldier_intro", 1);
  add_actor_anim("hudson", % ch_ang_07_02_hiding_spot_hault_hudson);
  add_scene("hault_guy", "child_soldier_intro");
  add_actor_anim("guy_soldier", % ch_ang_07_02_hiding_spot_hault_guy);
  add_scene("wait_guy", "child_soldier_intro", 0, 0, 1);
  add_actor_anim("guy_soldier", % ch_ang_07_02_hiding_spot_wait_guy);
  add_scene("hudson_waits_in_cover_for_player_to_take_cover", "child_soldier_intro", 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_02_hiding_spot_wait_hudson);
  add_scene("hudson_rockhide_dont_move", undefined, 0, 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_03_rockhide_dont_move);
  add_scene("hudson_rockhide_on_my_lead", undefined, 0, 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_03_rockhide_on_my_lead);
  add_scene("hudson_rockhide_now", undefined, 0, 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_03_rockhide_now);
  add_scene("player_prone_watches_1st_child_soldier_encounter", "child_soldier_intro");
  add_player_anim("player_body_river", % ch_ang_07_02_hiding_spot_scene_player, 0, 0, undefined, 1, 1, 0, 0, 15, 15);
  add_notetrack_custom_function("player_body_river", "dof_start", maps\createart\angola_art::hiding_log_dof_start);
  add_notetrack_custom_function("player_body_river", "dof_end", maps\createart\angola_art::hiding_log_dof_end);
  add_notetrack_custom_function("player_body_river", "kids_enter", ::log_crows);
  add_scene("watch_1st_child_soldier_encounter", "child_soldier_intro");
  add_actor_anim("hudson", % ch_ang_07_02_hiding_spot_scene_hudson);
  add_actor_anim("woods", % ch_ang_07_02_hiding_spot_scene_woods, 1);
  add_actor_anim("guy_soldier", % ch_ang_07_02_hiding_spot_scene_guy, 0, 0, 1);
  add_notetrack_custom_function("guy_soldier", "vo_for_alerted", ::vo_for_alerted);
  add_actor_anim("child_soldier_1", % ch_ang_07_02_hiding_spot_scene_child01, 0, 0, 1);
  add_actor_anim("child_soldier_2", % ch_ang_07_02_hiding_spot_scene_child02, 0, 0, 1);
  add_actor_anim("child_soldier_3", % ch_ang_07_02_hiding_spot_scene_child03, 0, 0, 1);
  add_actor_anim("child_soldier_4", % ch_ang_07_02_hiding_spot_scene_child04, 0, 0, 1);
  add_scene("hudson_leave_stealth", "stealth_grass_1");
  add_actor_anim("hudson", % ch_ang_07_04_hudson_stealth_cover_point_02);
  add_scene("hudson_head_to_stealth", "stealth_grass_1");
  add_actor_anim("hudson", % ch_ang_07_04_hudson_stealth_cover_point_01);
  add_scene("hudson_church_loop", "stealth_grass_1", 1, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_04_hudson_stealth_loop01);
  add_scene("hudson_grass_loop", "stealth_grass_1", 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_07_04_hudson_stealth_loop02);
  add_scene("hudson_grass_facial", "stealth_grass_1");
  add_actor_anim("hudson", % ch_ang_07_04_hudson_stealth_hold_position);
  add_scene("child_guards_a", "child_soldier_anim_group_1_struct", 0, 0, 1);
  add_actor_anim("go_house_ambient_child1_spawner", % ch_ang_09_01_child_patrol_a_kid01);
  add_actor_anim("go_house_ambient_child2_spawner", % ch_ang_09_01_child_patrol_a_kid02);
  add_scene("child_guards_b", "child_soldier_anim_group_2_struct", 0, 0, 1);
  add_actor_anim("go_house_ambient_child3_spawner", % ch_ang_09_01_child_patrol_b_kid01);
  add_actor_anim("go_house_ambient_child4_spawner", % ch_ang_09_01_child_patrol_b_kid02);
  add_scene("child_guards_c", "anim_child_guards_c", 0, 0, 1);
  add_actor_anim("child_guard_c_2", % ch_ang_09_01_child_patrol_c_kid02);
  add_scene("direct_patrol", "child_soldier_intro");
  add_actor_anim("patrol_director", % ch_ang_07_02_hiding_spot_patrol01);
  add_scene("missionary_patroller", "missionary_soldier");
  add_actor_anim("house_follow_path_and_die_spawner", % ch_ang_07_03_monestary_patrol_guy01);
  add_scene("patrol_a_guy_1_loop", "stealth_grass_1", 0, 0, 1);
  add_actor_anim("patrol_a_1", % ch_ang_07_03_long_grass_patrol_a_guy01_loop);
  add_scene("patrol_a_guy_1", "stealth_grass_1");
  add_actor_anim("patrol_a_1", % ch_ang_07_03_long_grass_patrol_a_guy01);
  add_scene("perimeter_patrol", undefined, 0, 0, 1);
  add_actor_anim("generic", % patrol_bored_idle);
  add_scene("patrol_blocker", undefined, 0, 0, 1, 1);
  add_actor_anim("patrol_blocker", % patrol_bored_idle);
  add_scene("fxanim_grass", undefined, 0, 0, 0, 1);
  add_prop_anim("generic", % fxanim_gp_cattails_scaled8_walkthrough_anim);
  add_scene("fxanim_grass_idle", undefined, 0, 0, 1, 1);
  add_prop_anim("generic", % fxanim_gp_cattails_scaled8_idle_anim);
  level.scr_anim["generic"]["patrol_idle_loop"][0] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_smoke_loop"][0] = % patrol_bored_idle_smoke;
  lockbreaker_perk_anim();
  player_stealth_carry_anims();
  woods_stealth_carry_anims();
}

vo_for_alerted(guy) {
  fakeredshirt = spawn("script_origin", (-23286, -2461, 633));
  fakeredshirt say_dialog("mpl2_over_here_we_ve_fo_0", 0, 1);
  wait 2;
  fakeredshirt delete();
}

log_crows(guy) {
  level notify("fxanim_crow_log_start");
}

custom_patrol_init() {
  level.scr_anim["generic"]["patrol_walk"] = % ai_patrolwalk_angola_gunup_idle;
  level.scr_anim["generic"]["patrol_walk_twitch"] = % ai_patrolwalk_angola_gunup_twitcha;
  level.scr_anim["generic"]["patrol_stop"] = % ai_patrolwalk_angola_gunup_stop;
  level.scr_anim["generic"]["patrol_start"] = % ai_patrolwalk_angola_gunup_start;
  level.scr_anim["generic"]["patrol_idle_order_wave"] = % ch_ang_07_03_long_grass_patrol_b_guy01;
}

custom_village_patrol_init() {
  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_walk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["generic"]["patrol_stop"] = % patrol_bored_walk_2_bored;
  level.scr_anim["generic"]["patrol_start"] = % patrol_bored_2_walk;
  level.scr_anim["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;
  level.scr_anim["generic"]["patrol_idle_1"] = % patrol_bored_twitch_bug;
  level.scr_anim["generic"]["patrol_idle_2"] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_idle_3"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_4"] = % patrol_bored_twitch_stretch;
  level.scr_anim["generic"]["patrol_idle_5"] = % patrol_bored_twitch_bug;
  level.scr_anim["generic"]["patrol_idle_6"] = % patrol_bored_idle;
}

#using_animtree("animated_props");
#using_animtree("player");

lockbreaker_perk_anim() {
  add_scene("lockbreaker_door", "align_lock_breaker");
  add_prop_anim("perk_lockbreaker", % o_specialty_angola_lockbreaker_door, "p6_lockbreaker_door", 0);
  add_scene("lockbreaker", "align_lock_breaker");
  add_prop_anim("lock_breaker", % o_specialty_angola_lockbreaker_device, "t6_wpn_lock_pick_view", 1);
  add_prop_anim("beartrap_pickup", % o_specialty_angola_lockbreaker_trap, "t6_wpn_bear_trap_prop", 1);
  add_player_anim("player_body_river", % int_specialty_angola_lockbreaker, 1);
  add_notetrack_custom_function("player_body_river", "trap_pickup", maps\angola_jungle_stealth::play_sound_on_trap_pickup);
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

village_anims() {
  player_meatshield_anims();
  menendez_meatshield_anims();
  add_scene("hut_patroller", "meat_shield");
  add_actor_anim("hut_patroller", % ch_ang_08_01_hut_patroller_sentry);
  add_scene("village_guard_inspect", "meat_shield", 0, 0, 1);
  add_actor_anim("guard_inspect", % ch_ang_07_03_village_ambienta_patrol_guy01);
  add_scene("village_guard_sitting", "meat_shield", 0, 0, 1);
  add_actor_anim("guard_sitting", % ch_ang_07_03_village_ambienta_inspect_guy03);
  add_scene("idle_normal");
  add_actor_anim("generic", % patrol_bored_idle);
  add_scene("idle_bug");
  add_actor_anim("generic", % patrol_bored_twitch_bug);
  add_scene("idle_smoke");
  add_actor_anim("generic", % patrol_bored_idle_smoke);
  add_scene("idle_stretch");
  add_actor_anim("generic", % patrol_bored_twitch_stretch);
  add_scene("meatshield_idle_1", "meat_shield", 0, 0, 1);
  add_actor_model_anim("menendez", % ch_ang_08_01_meatshield_idle_01_menendez);
  add_player_anim("player_body_river", % ch_ang_08_01_meatshield_idle_01_player, 0, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_scene("meatshield_idle_1_enemy", "meat_shield", 0, 0, 1);
  add_actor_anim("meatshield_enemy_1", % ch_ang_08_01_meatshield_idle_01_enemy01);
  add_scene("meatshield_ads_1", "meat_shield");
  add_actor_anim("meatshield_enemy_1", % ch_ang_08_01_meatshield_ads_01_enemy01);
  add_actor_anim("meatshield_enemy_2", % ch_ang_08_01_meatshield_ads_01_enemy02);
  add_actor_model_anim("menendez", % ch_ang_08_01_meatshield_ads_01_menendez);
  add_player_anim("player_body_river", % ch_ang_08_01_meatshield_ads_01_player, 0, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_scene("meatshield_idle_2", "meat_shield", 0, 0, 1);
  add_actor_anim("meatshield_enemy_1", % ch_ang_08_01_meatshield_idle_02_enemy01);
  add_actor_model_anim("menendez", % ch_ang_08_01_meatshield_idle_02_menendez);
  add_player_anim("player_body_river", % ch_ang_08_01_meatshield_idle_02_player, 0, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_scene("meatshield_idle_2_enemy", "meat_shield", 0, 0, 1);
  add_actor_anim("meatshield_enemy_2", % ch_ang_08_01_meatshield_idle_02_enemy02);
  add_scene("meatshield_ads_2", "meat_shield");
  add_actor_anim("meatshield_enemy_1", % ch_ang_08_01_meatshield_ads_02_enemy01);
  add_actor_anim("meatshield_enemy_2", % ch_ang_08_01_meatshield_ads_02_enemy02);
  add_actor_model_anim("menendez", % ch_ang_08_01_meatshield_ads_02_menendez);
  add_player_anim("player_body_river", % ch_ang_08_01_meatshield_ads_02_player, 0, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_scene("meatshield_outro", "meat_shield");
  add_actor_anim("meatshield_enemy_1", % ch_ang_08_01_meatshield_outro_enemy01, 0, 0, 1);
  add_actor_anim("meatshield_enemy_2", % ch_ang_08_01_meatshield_outro_enemy02, 0, 0, 1);
  add_actor_model_anim("menendez", % ch_ang_08_01_meatshield_outro_menendez, undefined, 1);
  add_player_anim("player_body_river", % ch_ang_08_01_meatshield_outro_player, 1);
  add_scene("menendez_radio_room_idle", "meat_shield", 0, 0, 1);
  add_actor_model_anim("menendez", % ch_ang_08_01_radio_room_menendez_loop);
  add_scene("player_climb_into_radio_room", "meat_shield");
  add_actor_model_anim("menendez", % ch_ang_08_01_radio_room_part1_menendez);
  add_player_anim("player_body_river", % ch_ang_08_01_radio_room_part1_player, 0, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body_river", "dof_enter_hut", maps\createart\angola_art::angola_2_dof_enter_hut);
  add_notetrack_custom_function("player_body_river", "dof_gun_to_head", maps\createart\angola_art::angola_2_dof_gun_to_head);
  add_notetrack_custom_function("player_body_river", "dof_gun_to_head", ::sndshutoffradio);
  add_notetrack_exploder("menendez", "punch_radio", 261);
  add_scene("pistol_meatshield_part_1", "player_body_river");
  add_prop_anim("player_pistol", % o_ang_08_01_radio_room_part1_pistol, "t6_wpn_pistol_browninghp_prop_view", 0, 0, undefined, "tag_weapon");
  add_scene("player_meatshield_part_2", "meat_shield");
  add_player_anim("player_body_river", % ch_ang_08_01_radio_room_part2_player, 1, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_notetrack_level_notify("player_body_river", "explosion", "fxanim_hostage_hut_start");
  add_notetrack_custom_function("player_body_river", "shoot", ::player_shoots_menendez);
  add_notetrack_custom_function("player_body_river", "slow_mo_on", ::slow_motion_on);
  add_notetrack_custom_function("player_body_river", "slow_mo_off", ::slow_motion_off);
  add_notetrack_custom_function("player_body_river", "explosion", ::sndplayexplosionatposition);
  add_notetrack_custom_function("player_body_river", "sndSlowMoSnapshotOn", ::sndslowmosnapshoton);
  add_notetrack_custom_function("player_body_river", "sndSlowMoSnapshotOff", ::sndslowmosnapshotoff);
  add_notetrack_custom_function("player_body_river", "dof_jump_out", maps\createart\angola_art::angola_2_dof_jump_out);
  add_scene("pistol_meatshield_part_2", "player_body_river");
  add_prop_anim("player_pistol", % o_ang_08_01_radio_room_part2_pistol, undefined, 1, 0, undefined, "tag_weapon");
  add_scene("door_meatshield_part_2", "meat_shield");
  add_prop_anim("menendez_door", % o_ang_08_01_radio_room_part2_door, undefined, 0, 1);
  add_scene("grenade_meatshield_part_2", "meat_shield");
  add_prop_anim("menendez_grenade", % o_ang_08_01_radio_room_part2_grenade, "t6_wpn_grenade_m67_prop_view", 1);
  add_scene("menendez_meatshield_part_2", "meat_shield");
  add_actor_model_anim("menendez", % ch_ang_08_01_radio_room_part2_menendez, undefined, 1);
  add_scene("soldier_meatshield_part_2", "meat_shield");
  add_actor_anim("guy_soldier", % ch_ang_08_01_radio_room_part2_enemy01, 0, 0, 1);
  add_scene("soldier2_meatshield_part_2", "meat_shield");
  add_actor_anim("guy_soldier2", % ch_ang_08_01_radio_room_part2_enemy02, 0, 0, 1);
  add_scene("soldier3_meatshield_part_2", "meat_shield");
  add_actor_anim("guy_soldier3", % ch_ang_08_01_radio_room_part2_enemy03, 0, 0, 1);
  add_scene("child1_meatshield_part_2", "meat_shield");
  add_actor_anim("child_menendez_scene_1", % ch_ang_08_01_radio_room_part2_child01, 0, 0, 1);
  add_scene("child2_meatshield_part_2", "meat_shield");
  add_actor_anim("child_menendez_scene_2", % ch_ang_08_01_radio_room_part2_child02, 0, 0, 1);
  add_scene("child3_meatshield_part_2", "meat_shield");
  add_actor_anim("child_menendez_scene_3", % ch_ang_08_01_radio_room_part2_child03, 0, 0, 1);
}

player_shoots_menendez(guy) {
  pistol = get_model_or_models_from_scene("pistol_meatshield_part_2", "player_pistol");
  playfxontag(level._effect["menendez_fight_muzzle_flash"], pistol, "TAG_FX");
  angles = pistol gettagangles("TAG_FX");
  fire_from = pistol gettagorigin("TAG_FX");
  fire_at = anglestoforward(angles) * 10 + fire_from;
  magicbullet("browninghp_sp", fire_from, fire_at);

  if(is_mature()) {
    menendez_model = get_model_or_models_from_scene("menendez_meatshield_part_2", "menendez");
    menendez_model detach("c_mul_menendez_young_head");
    menendez_model attach("c_mul_menendez_young_head_shot");
  }
}

slow_motion_on(guy) {
  settimescale(0.3);
}

slow_motion_off(guy) {
  settimescale(1.0);
}

shoot_menendez_muzzle_flash(guy) {
  playfxontag(level._effect["def_muzzle_flash"], level.mason_meatshield_weapon, "tag_fx");
}

meatshield_grenade_explosion(guy) {
  level notify("meatshield_grenade_explosion");
}

guy_soldier2_meatshield_threat(guy) {
  guy.meatshield_threat = 1;
}

guy_soldier2_meatshield_not_threat(guy) {
  guy.meatshield_threat = 0;
}

guy_soldier3_meatshield_threat(guy) {
  guy.meatshield_threat = 1;
}

guy_soldier3_meatshield_not_threat(guy) {
  guy.meatshield_threat = 0;
}

guy_soldier4_meatshield_threat(guy) {
  guy.meatshield_threat = 1;
}

guy_soldier4_meatshield_not_threat(guy) {
  guy.meatshield_threat = 0;
}

#using_animtree("animated_props");

barge_panel_anims() {
  level.scr_animtree["barge_side_panel"] = #animtree;
  level.scr_anim["barge_side_panel_0"]["panel_fall_off"] = % fxanim_angola_barge_side_panel_01_anim;
  addnotetrack_customfunction("barge_side_panel_0", "impact_splash", ::panel_fall_splash, "panel_fall_off");
  level.scr_anim["barge_side_panel_1"]["panel_fall_off"] = % fxanim_angola_barge_side_panel_02_anim;
  addnotetrack_customfunction("barge_side_panel_1", "impact_splash", ::panel_fall_splash, "panel_fall_off");
  level.scr_anim["barge_side_panel_2"]["panel_fall_off"] = % fxanim_angola_barge_side_panel_03_anim;
  addnotetrack_customfunction("barge_side_panel_2", "impact_splash", ::panel_fall_splash, "panel_fall_off");
}

panel_fall_splash(m_panel) {
  playfxontag(getfx("panel_splash"), m_panel, "tag_fx_splash");
}

#using_animtree("player");

player_meatshield_anims() {
  level.scr_animtree["player_body_river"] = #animtree;
  level.scr_model["player_body_river"] = level.player_interactive_hands;
  level.scr_anim["player_body_river"]["mason_move_loop"][0] = % ch_ang_08_01_meatshield_idle_player;
}

#using_animtree("generic_human");

menendez_meatshield_anims() {
  level.scr_anim["menendez"]["walk"][0] = % ch_ang_08_01_meatshield_idle_menendez;
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("player");

jungle_escape_anims() {
  add_scene("hudson_woods_jungle_escape_begin_loop", "regroup_to_defend_1", 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_10_01_escape_hudson_cycle_bg);
  add_actor_anim("woods", % ch_ang_10_01_escape_woods_cycle_bg, 1);
  add_scene("mason_meets_hudson_and_woods_at_start", "defend_2");
  add_actor_anim("hudson", % ch_ang_10_01_escape_hudson_01);
  add_actor_anim("woods", % ch_ang_10_01_escape_woods_01, 1);
  add_scene("hudson_woods_jungle_escape_stop_01_loop", "defend_2", 0, 0, 1);
  add_actor_anim("woods", % ch_ang_10_01_escape_woods_cycle_02, 1);
  jungle_escape_beartrap_animations();
  add_scene("hudson_and_woods_jungle_escape_move_defend_2", "defend_2", 1);
  add_actor_anim("hudson", % ch_ang_10_02_escape_hudson);
  add_actor_anim("woods", % ch_ang_10_02_escape_woods, 1);
  add_scene("hudson_woods_jungle_escape_stop_02_loop", "defend_2", 0, 0, 1);
  add_actor_anim("woods", % ch_ang_10_02_escape_woods_cycle_end, 1);
  add_scene("hudson_and_woods_jungle_escape_move_defend_3", "defend_2", 1);
  add_actor_anim("hudson", % ch_ang_10_03_escape_hudson);
  add_actor_anim("woods", % ch_ang_10_03_escape_woods, 1);
  add_scene("hudson_woods_jungle_escape_stop_03_loop", "defend_2", 0, 0, 1);
  add_actor_anim("woods", % ch_ang_10_03_escape_woods_cycle_end, 1);
  add_scene("evac_to_beach_hudson", "helicopter_land", 1);
  add_actor_anim("hudson", % ch_ang_10_04_beach_hudson);
  add_scene("evac_to_beach_woods", "helicopter_land");
  add_actor_anim("woods", % ch_ang_10_04_beach_woods, 1);
  add_scene("hudson_and_woods_jungle_escape_beach_collapse", "helicopter_land", 0, 0, 1);
  add_actor_anim("hudson", % ch_ang_10_04_beach_wait_hudson);
  add_actor_anim("woods", % ch_ang_10_04_beach_wait_woods, 1);
  add_scene("fxanim_truck_explosion", undefined, 0, 0, 0, 1);
  add_prop_anim("truck_0_model", % fxanim_angola_waterfall_truck_anim);
  add_scene("hind_attack_end_scene", "helicopter_land");
  add_actor_anim("hudson", % ch_ang_10_04_chopper_hudson);
  add_actor_anim("woods", % ch_ang_10_04_chopper_woods);
  add_actor_anim("hind_dummy_pilot", % ch_ang_10_04_chopper_enemy);
  add_actor_anim("savimbi", % ch_ang_10_04_chopper_savimbi);
  add_vehicle_anim("hind_end_level", % v_ang_10_04_chopper_hind);
  add_player_anim("player_body_river", % ch_ang_10_04_chopper_player, 0, 0, undefined, 1, 1, 45, 45, 10, 10);
  add_notetrack_custom_function("hind_dummy_pilot", "fire", ::soldier_shoots_hudson);
  add_notetrack_custom_function("hind_dummy_pilot", "shot", ::woods_shoots_pistol_effect);
  add_notetrack_custom_function("hind_end_level", "fire_gun", maps\angola_jungle_ending::hind_fires_into_forest);
  add_notetrack_custom_function("hind_end_level", "jungle_explodes", maps\angola_jungle_ending::jungle_explosions);
  add_notetrack_custom_function("player_body_river", "dof_savimbi", maps\createart\angola_art::angola_2_finale_dof_hind);
  add_notetrack_custom_function("player_body_river", "dof_enemy", maps\createart\angola_art::angola_2_finale_dof_enemy);
  add_notetrack_custom_function("player_body_river", "dof_woods_gun", maps\createart\angola_art::angola2_finale_dof1);
  add_notetrack_custom_function("player_body_river", "dof_woods", maps\createart\angola_art::angola2_finale_dof2);
  add_notetrack_custom_function("player_body_river", "dof_normal", maps\createart\angola_art::angola2_finale_dof3);
  add_notetrack_custom_function("player_body_river", "dof_hudson_ground", maps\createart\angola_art::angola2_finale_hudson_ground);
  add_notetrack_custom_function("player_body_river", "woods_vo_start", maps\angola_2::level_fade_out);
  hind_interior_anims();
}

soldier_shoots_hudson(guy) {
  playfxontag(getfx("hudson_shot_tracer"), guy, "tag_flash");
}

woods_shoots_pistol_effect(guy) {
  ai = getent("hind_dummy_pilot_ai", "targetname");
  playfxontag(level._effect["fx_ango_blood_outro"], ai, "J_spineUpper");
  tag_origin = ai gettagorigin("J_spineUpper");
  tag_angles = ai gettagangles("J_spineUpper");
  ai play_fx("fx_ango_blood_outro", tag_origin, tag_angles, undefined, 1, "J_spineUpper");
}

#using_animtree("fxanim_props");

barge_barrel_anims() {
  level.scr_animtree["barrel_fxanim_parent"] = #animtree;
  level.scr_anim["barrel_fxanim_parent"]["barge_barrel_topple"] = % fxanim_angola_barge_barrels_anim;
  level.scr_animtree["barge_sink_fxanims"] = #animtree;
  level.scr_anim["sinking_barge_tarp"]["barge_sink_fxanims"] = % fxanim_angola_barge_tarp_rpg_slide_anim;
  level.scr_anim["sinking_barge_barrels"]["barge_sink_fxanims"] = % fxanim_angola_barge_barrels_side_anim;
}

#using_animtree("generic_human");

init_angola_anims() {
  level.scr_anim["misc_patrol"]["walk"] = % patrol_jog;
  level.scr_anim["alerted_patrol"]["walk"] = % patrol_jog_360;
  level.scr_anim["stand_and_look_around"]["stand"] = % patrol_bored_react_walkstop;
  level.scr_anim["hudson"]["ch_ang_10_01_smoke_throw_hudson"] = % ch_ang_10_01_smoke_throw_hudson;
}

#using_animtree("player");

player_stealth_carry_anims() {
  level.scr_animtree["player_body_river"] = #animtree;
  level.scr_model["player_body_river"] = level.player_interactive_hands;
  level.scr_anim["player_body_river"]["mason_carry_idle"][0] = % ch_ang_07_01_carry_woods_player_idle;
  level.scr_anim["player_body_river"]["mason_carry_run"][0] = % ch_ang_07_01_carry_woods_player;
  level.scr_anim["player_body_river"]["mason_carry_coughing"][0] = % ch_ang_07_01_carry_woods_player_cough;
  level.scr_anim["player_body_river"]["mason_carry_crouch_idle"][0] = % ch_ang_07_01_carry_woods_player_crouch_idle;
  level.scr_anim["player_body_river"]["mason_carry_crouch_in"] = % ch_ang_07_01_carry_woods_player_crouch_in;
  level.scr_anim["player_body_river"]["mason_carry_crouch_out"] = % ch_ang_07_01_carry_woods_player_crouch_out;
  level.scr_anim["player_body_river"]["mason_carry_crouch_walk"][0] = % ch_ang_07_01_carry_woods_player_crouch_walk;
  level.scr_anim["player_body_river"]["mortar_plant"] = % int_beartrap_mortar_plant;
}

#using_animtree("generic_human");

woods_stealth_carry_anims() {
  level.scr_anim["woods"]["mason_carry_idle"][0] = % ch_ang_07_01_carry_woods_woods_idle;
  level.scr_anim["woods"]["mason_carry_run"][0] = % ch_ang_07_01_carry_woods_woods;
  level.scr_anim["woods"]["mason_carry_coughing"][0] = % ch_ang_07_01_carry_woods_woods_cough;
  level.scr_anim["woods"]["mason_carry_crouch_idle"][0] = % ch_ang_07_01_carry_woods_woods_crouch_idle;
  level.scr_anim["woods"]["mason_carry_crouch_in"] = % ch_ang_07_01_carry_woods_woods_crouch_in;
  level.scr_anim["woods"]["mason_carry_crouch_out"] = % ch_ang_07_01_carry_woods_woods_crouch_out;
  level.scr_anim["woods"]["mason_carry_crouch_walk"][0] = % ch_ang_07_01_carry_woods_woods_crouch_walk;
  level.scr_anim["generic"]["ai_beartrap_caught"] = % ai_wounded_beartrap_hit;
  level.scr_anim["generic"]["ai_beartrap_caught_loop"][0] = % ai_wounded_beartrap_pain_idle;
}

sndplayexplosionatposition(player) {
}

sndslowmosnapshoton(player) {
  rpc("clientscripts/angola_2_amb", "sndSlowMoSnapshotOn");
}

sndslowmosnapshotoff(player) {
  level clientnotify("sndSlowMoSnapshotOff");
}

#using_animtree("animated_props");

jungle_escape_beartrap_animations() {
  level.scr_animtree["mortar"] = #animtree;
  level.scr_model["mortar"] = "t6_wpn_mortar_shell_prop_view";
  level.scr_anim["mortar"]["mortar_plant"] = % o_beartrap_mortar_plant_mortar;
  level.scr_animtree["beartrap"] = #animtree;
  level.scr_model["beartrap"] = "t6_wpn_bear_trap_world";
  level.scr_anim["beartrap"]["beartrap_snap_closed"] = % o_beartrap_snap_close;
  level.scr_anim["beartrap"]["beartrap_closed_idle"][0] = % o_beartrap_idle_closed;
}

hind_interior_anims() {
  level.scr_animtree["hind_interior"] = #animtree;
  level.scr_model["hind_interior"] = "fxanim_angola_hind_interior_mod";
  level.scr_anim["hind_interior"]["hind_interior_loop"][0] = % fxanim_angola_hind_interior_anim;
}

sndshutoffradio(guy) {
  level clientnotify("stopRadio");
}