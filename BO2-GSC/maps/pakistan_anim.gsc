/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include common_scripts\utility;
#include maps\pakistan_util;
#include maps\_music;
#include maps\_anim;
#include maps\_glasses;
#include maps\voice\voice_pakistan;
#include maps\pakistan_market;
#include maps\pakistan_street;
#include maps\pakistan_anthem_approach;

main() {
  intro();
  claw_grenade_launch();
  car_corner_crash();
  car_smash();
  car_smash_car_idle();
  bus_smash();
  brute_force_arrive();
  brute_force_idle();
  brute_force_exit();
  brute_force_unlock();
  brute_force_bypass();
  frogger_debris();
  frogger_ai_entries();
  bus_dam_anims();
  slum_alley_initial();
  slum_alley_corner();
  slum_alley_dog();
  alley_civilians();
  corpse_alley();
  stealth();
  stealth_corpses();
  fallen_building();
  sewer_entry();
  intruder_perk();
  sewer_slide();
  sewer_exit();
  fxanim_misc();
  precache_assets();
  maps\voice\voice_pakistan::init_voice();
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("bigdog");
#using_animtree("generic_human");

intro() {
  add_scene("intro_anim_loop", "pakistan_intro_2", 0, 0, 1, 0);
  add_actor_anim("harper", % ch_pakistan_1_1_market_intro_loop_harper, 0, 1, 0, 1, undefined);
  add_actor_anim("salazar", % ch_pakistan_1_1_market_intro_loop_salazar, 0, 1, 0, 1, undefined);
  add_player_anim("player_body", % p_pakistan_1_1_market_intro_loop_player_1stperson, 1);
  add_actor_anim("mason_fullbody", % p_pakistan_1_1_market_intro_loop_player_3rdperson, 1, 0, 1, 1);
  add_scene("intro_anim", "pakistan_intro_2");
  add_actor_anim("harper", % ch_pakistan_1_1_market_intro_harper, 0, 1, 0, 1, undefined);
  add_notetrack_custom_function("harper", "kick", maps\pakistan_market::intro_harper_kick_rumble);
  add_actor_anim("salazar", % ch_pakistan_1_1_market_intro_salazar, 0, 1, 0, 1, undefined);
  add_player_anim("player_body", % p_pakistan_1_1_market_intro_player_1stperson, 1, undefined, undefined, 0, 1, 20, 20, 50, 30, 1, 1, 1, 0);
  add_notetrack_custom_function("player_body", "persp_switch", maps\pakistan_market::_intro_extra_cam);
  add_notetrack_custom_function("player_body", "grenade_explosion", maps\pakistan_market::market_doors_explosion);
  add_notetrack_custom_function("player_body", "start", maps\pakistan_market::intro_player_scene_logic);
  add_actor_anim("mason_fullbody", % p_pakistan_1_1_market_intro_player_3rdperson, 1, 0, 1, 1);
  add_prop_anim("market_doors", % o_pakistan_1_1_market_intro_doors, undefined, 1);
  add_scene("intro_anim_claw", "pakistan_intro_2");
  add_actor_anim("claw_1", % v_pakistan_1_1_market_intro_claw, 0, 0, 0, 1, undefined);
  add_notetrack_custom_function("claw_1", "start", maps\pakistan_market::_intro_claw_turret_control);
  add_notetrack_custom_function("claw_1", "spin_up", maps\pakistan_market::_intro_claw_turret_spin);
  add_notetrack_custom_function("claw_1", "start_fire", maps\pakistan_market::_intro_claw_turret_fire);
  add_notetrack_custom_function("claw_1", "rumble_step", ::claw_rumble);
  addnotetrack_fxontag("claw_1", "intro_anim_claw", "fx_getup", "claw_bootup", "tag_body_animate");
  addnotetrack_fxontag("claw_1", "intro_anim_claw", "fx_getup", "claw_bootup_leg", "jnt_f_l_balljoint");
  addnotetrack_fxontag("claw_1", "intro_anim_claw", "fx_getup", "claw_bootup_leg", "jnt_r_l_balljoint");
  addnotetrack_exploder("claw_1", "fx_getup", 103, "intro_anim_claw");
  add_scene("intro_anim_enemy", "pakistan_intro_2");
  add_actor_anim("enemy1", % ch_pakistan_1_1_market_intro_enemy1);
  add_actor_anim("enemy2", % ch_pakistan_1_1_market_intro_enemy2);
  add_actor_anim("enemy3", % ch_pakistan_1_1_market_intro_enemy3);
  add_actor_anim("enemy4", % ch_pakistan_1_1_market_intro_enemy4);
}

claw_rumble(claw) {
  level.player playrumbleonentity("damage_heavy");
}

hide_player_body_in_intro(e_body) {
  e_body hide();
}

_plant_flamethrower_dongle(e_player_body) {
  e_dongle = get_ent("claw_flamethrower_dongle", "targetname", 1);
  ai_claw = get_ent("claw_1_ai", "targetname", 1);
  e_dongle linkto(ai_claw);
}

#using_animtree("bigdog");

claw_grenade_launch() {
  add_scene("claw_grenade_launch", "pakistan_market", 1, 0, 0, 0);
  add_actor_anim("claw_grenade_guy", % ch_pakistan_1_5_grenade_launch_guy_01, 0, 1, 0, 1, undefined);
  add_notetrack_custom_function("claw_grenade_guy", "hit_pillar", ::claw_grenade_launch_pillar_hit);
  add_actor_anim("claw_2", % v_pakistan_1_5_grenade_launch_claw, 0, 0, 0, 1, undefined);
  add_notetrack_custom_function("claw_2", "grenade_launch", maps\pakistan_market::_claw_launches_grenade_at_guy);
}

claw_grenade_launch_pillar_hit(e_guy) {
  debug_print_line("claw_grenade_launch: hit_pillar");
}

fxanim_misc() {
  add_notetrack_custom_function("fxanim_props", "shelves_destroy", ::shelving_physics_explosion, 1);
}

shelving_physics_explosion(e_shelf) {
  debug_print_line("shelf collapse");
  v_origin = e_shelf.origin;
  n_z_offset_base = 14;
  n_z_offset = 28;

  for(i = 0; i < 4; i++) {
    v_explosion_origin = v_origin + (0, 0, i * n_z_offset + n_z_offset_base);
    physicsexplosionsphere(v_explosion_origin, 80, 0, 1.0);
    wait 0.05;
  }
}

#using_animtree("animated_props");

car_corner_crash() {
  add_scene("car_corner_crash_loop", "car_corner_crash_vehicle", 0, 0, 1, 0);
  add_prop_anim("car_corner_crash_vehicle", % fxanim_pak_car_corner_veh_loop_anim, undefined, 0, 0);
  add_scene("car_corner_crash", undefined, 0, 0, 0, 1);
  add_prop_anim("car_corner_crash_vehicle", % fxanim_pak_car_corner_veh_crash_anim, undefined, 0, 0);
  add_notetrack_custom_function("car_corner_crash_vehicle", "start", maps\pakistan_street::car_corner_crash_think);
}

#using_animtree("generic_human");

car_smash() {
  add_scene("car_smash", "car_smash_car", 0, 0, 0, 0);
  add_prop_anim("car_smash_car", % fxanim_pak_market_car_crash_car_anim, undefined, 0, 0, undefined, undefined);
  add_notetrack_custom_function("car_smash_car", "exploder 10150 #car_smash", ::_car_smashes_into_market, 0);
  add_scene("car_smash_guys", "pakistan_market", 0, 0, 0, 0);
  add_cheap_actor_model_anim("car_smash_guy_1", % ch_pakistan_1_5_car_smash_guy01, undefined, 0, undefined, undefined, "pakistan_isi_assualt_guy");
  add_cheap_actor_model_anim("car_smash_guy_2", % ch_pakistan_1_5_car_smash_guy02, undefined, 0, undefined, undefined, "pakistan_isi_assualt_guy");
}

#using_animtree("animated_props");
#using_animtree("generic_human");

car_smash_car_idle() {
  add_scene("car_smash_car_idle", "car_smash_car", 0, 0, 1, 0);
  add_prop_anim("car_smash_car", % fxanim_pak_market_car_crash_idle_anim, undefined, 0, 0, undefined, undefined);
  add_scene("car_smash_ai_idle", "pakistan_market", 0, 0, 1, 0);
  add_cheap_actor_model_anim("car_smash_guy_1", % ch_pakistan_1_5_car_smash_death_guy01, undefined, 0, undefined, undefined, "pakistan_isi_assualt_guy");
}

#using_animtree("animated_props");
#using_animtree("generic_human");

bus_smash() {
  add_scene("bus_smash", "pakistan_market", 0, 0, 0, 1);
  add_prop_anim("car_smash_bus", % fxanim_pak_market_bus_crash_bus_anim, undefined, 0, 0, undefined, undefined);
  add_notetrack_custom_function("car_smash_bus", "bus_impact", ::bus_smash_bus_impact, 0);
  add_notetrack_custom_function("car_smash_bus", "car_hit", maps\pakistan_market::bus_smash_car_hit, 0);
  add_notetrack_custom_function("car_smash_bus", "shelf_01_destroy", ::bus_smash_shelf_fall_1, 0);
  add_notetrack_custom_function("car_smash_bus", "shelf_02_destroy", ::bus_smash_shelf_fall_2, 0);
  add_notetrack_custom_function("car_smash_bus", "shelf_03_destroy", ::bus_smash_shelf_fall_3, 0);
  add_notetrack_custom_function("car_smash_bus", "shelf_04_destroy", ::bus_smash_shelf_fall_4, 0);
  add_scene("bus_smash_damage", "car_smash_car", 0, 0, 0, 0);
  add_prop_anim("car_smash_car", % fxanim_pak_market_bus_crash_car_anim, undefined, 0, 0, undefined, undefined);
  add_scene("bus_smash_damage_ai", "pakistan_market", 0, 0, 0, 0);
  add_cheap_actor_model_anim("car_smash_guy_1", % ch_pakistan_1_5_bus_smash_guy01, undefined, 1, undefined, undefined, "pakistan_isi_assualt_guy");
}

bus_smash_shelf_fall_1(e_bus) {
  level notify("fxanim_market_bus_shelf_01_start");
}

bus_smash_shelf_fall_2(e_bus) {
  level notify("fxanim_market_bus_shelf_02_start");
}

bus_smash_shelf_fall_3(e_bus) {
  level notify("fxanim_market_bus_shelf_03_start");
}

bus_smash_shelf_fall_4(e_bus) {
  level notify("fxanim_market_bus_shelf_04_start");
}

bus_smash_bus_impact(e_bus) {
  level notify("fxanim_market_bus_crash_start");
  flag_set("bus_crash_drone");
  earthquake(0.5, 5.0, level.player.origin, 100);
}

_car_smashes_into_market(e_car) {
  level notify("fxanim_market_car_crash_start");
  level.harper queue_dialog("harp_damn_0");
  s_start = get_struct("car_smash_window_shatter_struct", "targetname", 1);
  s_target = get_struct(s_start.target, "targetname", 1);

  for(i = 0; i < 1; i++) {
    magicbullet("defaultweapon_invisible_sp", s_start.origin, s_target.origin, e_car);
    wait 0.05;
  }
}

_shatter_market_window() {
  s_target = get_struct("bus_smash_window_shatter_struct", "targetname", 1);
  v_start = self.origin;
  radiusdamage(s_target.origin, 96, 500, 500);
  physicsexplosionsphere(s_target.origin, 96, 0, 2);
}

brute_force_arrive() {
  add_scene("brute_force_arrive", "brute_force", 1, 0, 0, 0);
  add_actor_anim("salazar", % ch_pakistan_1_6_brute_force_arrive_salazar, 0, 1, 0, 1, undefined);
}

brute_force_idle() {
  add_scene("brute_force_idle", "brute_force", 0, 0, 1);
  add_actor_anim("salazar", % ch_pakistan_1_6_brute_force_idle_salazar, 0, 1, 0, 1, undefined);
}

brute_force_exit() {
  add_scene("brute_force_exit", "brute_force", 1, 0, 0, 0);
  add_actor_anim("salazar", % ch_pakistan_1_6_brute_force_exit_salazar, 0, 1, 0, 1, undefined);
}

#using_animtree("bigdog");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");

brute_force_unlock() {
  add_scene("brute_force_unlock", "brute_force", 0, 0, 0, 0);
  add_actor_anim("salazar", % ch_pakistan_1_6_brute_force_salazar, 0, 1, 0, 1, undefined);
  add_actor_anim("claw_1", % v_pakistan_1_6_brute_force_claw01, 0, 0, 0, 1, undefined);
  add_actor_anim("claw_2", % v_pakistan_1_6_brute_force_claw02, 0, 0, 0, 1, undefined);
  add_prop_anim("brute_force_door", % o_pakistan_1_6_brute_force_gate, undefined, 0, 0);
  add_notetrack_custom_function("brute_force_door", "start", ::crosby_enter_elevator_room);
  add_notetrack_custom_function("brute_force_door", "start", ::force_harper_to_frogger_start);
  add_scene("brute_force_unlock_player", "brute_force", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_1_6_brute_force_player, 1);
  add_prop_anim("brute_force_prop", % o_specialty_pakistan_brute_force_jaws, "t6_wpn_jaws_of_life_prop", 1, 0);
  add_prop_anim("brute_force_box", % o_specialty_pakistan_brute_force_fusebox);
}

#using_animtree("generic_human");
#using_animtree("bigdog");
#using_animtree("generic_human");

brute_force_bypass() {
  add_scene("brute_force_bypass_salazar", "align_noaccess_perk", 1, 0, 0, 0);
  add_actor_anim("salazar", % ch_pakistan_1_6_brute_force_noaccess_soldier, 0, 1, 0, 1, undefined);
  add_scene("brute_force_bypass_brutus", "align_noaccess_perk", 1, 0, 0, 0);
  add_actor_anim("claw_1", % v_pakistan_1_6_brute_force_noaccess_claw, 0, 0, 0, 1, undefined);
  add_scene("brute_force_bypass_maximus", "align_noaccess_perk", 1, 0, 0, 0);
  add_actor_anim("claw_2", % v_pakistan_1_6_brute_force_noaccess_claw, 0, 0, 0, 1, undefined);
  add_scene("brute_force_bypass_crosby", "align_noaccess_perk", 1, 0, 0, 0);
  add_actor_anim("crosby", % ch_pakistan_1_6_brute_force_noaccess_soldier, 0, 1, 0, 1, undefined);
}

#using_animtree("animated_props");

frogger_debris() {
  level.scr_animtree["frogger_debris"] = #animtree;
  level.scr_model["frogger_debris"] = "tag_origin_animate";
  level.scr_anim["frogger_debris"]["frogger_debris_bob"] = % o_pakistan_3_1_floating_debris;
}

#using_animtree("generic_human");

frogger_ai_entries() {
  bm_door_1 = get_ent("frogger_door_kick_1_door", "targetname", 1);
  bm_door_2 = get_ent("frogger_door_kick_2_door", "targetname", 1);
  bm_door_1 rotateyaw(-90, 1);
  bm_door_2 rotateyaw(90, 1);
  add_scene("frogger_door_kick_1", "frogger_door_kick_1", 0, 0, 0, 0);
  add_actor_anim("frogger_door_kick_1_guy", % ai_doorbreach_kick, 0, 1, 0, 0, undefined);
  add_notetrack_custom_function("frogger_door_kick_1_guy", "door_open", ::frogger_door_kick_1_func, 0);
  add_scene("frogger_door_kick_2", "frogger_door_kick_2", 0, 0, 0, 0);
  add_actor_anim("frogger_door_kick_2_guy", % ai_doorbreach_kick, 0, 1, 0, 0, undefined);
  add_notetrack_custom_function("frogger_door_kick_2_guy", "door_open", ::frogger_door_kick_2_func, 0);
}

frogger_door_kick_1_func(ai_guy) {
  bm_door = get_ent("frogger_door_kick_1_door", "targetname", 1);
  bm_door rotateyaw(90, 0.15, 0.05);
  maps\_scene::run_scene("frogger_door_kick_2");
}

frogger_door_kick_2_func(ai_guy) {
  bm_door = get_ent("frogger_door_kick_2_door", "targetname", 1);
  bm_door rotateyaw(-120, 0.25, 0.1);
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

bus_dam_anims() {
  add_scene("bus_dam_start", "bus_dam_bus", 0, 0, 0, 1);
  add_prop_anim("dam_bus", % fxanim_pak_bus_dam_enter_bus_anim, undefined, 0, 0, undefined, undefined);
  add_notetrack_custom_function("dam_bus", "1st_hit_start", ::bus_first_impact, 0);
  add_notetrack_custom_function("dam_bus", "2nd_hit_start", ::bus_second_impact, 0);
  add_notetrack_custom_function("dam_bus", "wedge_balc_start", ::bus_wedge_balcony, 0);
  add_notetrack_custom_function("dam_bus", "wedge_wall_start", ::bus_wedge_wall, 0);
  add_notetrack_fx_on_tag("dam_bus", undefined, "civ_bus_headlights", "tag_origin");
  add_scene("bus_dam_runners", "bus_dam", 0, 0, 0, 0);
  add_actor_anim("bus_runner_1", % ch_pakistan_2_3_bus_dam_enemy01, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_notetrack_custom_function("bus_runner_1", "start_bus", maps\pakistan_street::start_bus, 0);
  add_actor_anim("bus_runner_2", % ch_pakistan_2_3_bus_dam_enemy02, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_actor_anim("bus_runner_3", % ch_pakistan_2_3_bus_dam_enemy03, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_actor_anim("bus_runner_4", % ch_pakistan_2_3_bus_dam_enemy04, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_actor_anim("bus_runner_5", % ch_pakistan_2_3_bus_dam_enemy05, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_actor_anim("bus_runner_6", % ch_pakistan_2_3_bus_dam_enemy06, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_actor_anim("bus_runner_7", % ch_pakistan_2_3_bus_dam_enemy07, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  add_actor_anim("bus_runner_8", % ch_pakistan_2_3_bus_dam_enemy08, 0, 1, 1, 0, undefined, "pakistan_isi_assualt_guy");
  level.scr_anim["generic"]["bus_wave_death_1"] = % ch_pakistan_2_3_bus_dam_enemy09;
  level.scr_anim["generic"]["bus_wave_death_2"] = % ch_pakistan_2_3_bus_dam_enemy10;
  add_scene("bus_dam_idle", "bus_dam_bus", 0, 0, 1, 0);
  add_prop_anim("dam_bus", % fxanim_pak_bus_dam_idle_bus_anim, undefined, 0, 0, undefined, undefined);
  add_scene("bus_dam_exit", "bus_dam_bus", 0, 0, 0, 0);
  add_prop_anim("dam_bus", % fxanim_pak_bus_dam_exit_bus_anim, undefined, 0, 0, undefined, undefined);
  add_notetrack_custom_function("dam_bus", "break_balc_start", ::bus_break_balcony, 0);
  add_notetrack_custom_function("dam_bus", "break_wall_start", ::bus_break_wall, 0);
  add_notetrack_stop_exploder("dam_bus", "exploder 10187 #dam_break", 10178);
  add_scene("bus_dam_wave_push", "bus_dam_temp", 0, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_2_3_bus_dam_pushed_harper, 0, 1, 0, 1, undefined);
  add_scene("bus_dam_harper_arrival", "bus_dam_temp", 1, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_2_3_bus_dam_arrival_harper, 0, 0, 0, 1, undefined);
  add_notetrack_flag("harper", "vox#harp_section_1", "allow_gate_push");
  add_scene("bus_dam_harper_gate_idle", "bus_dam_temp", 0, 0, 1, 0);
  add_actor_anim("harper", % ch_pakistan_2_3_bus_dam_pushed_idle_harper, 0, 0, 0, 1, undefined);
  add_scene("bus_dam_wave_push_player", undefined, 0, 0, 0, 1);
  add_player_anim("player_body", % p_pakistan_2_3_bus_dam_pushed_player, 1);
  add_scene("bus_dam_gate_push_setup", "bus_dam_temp", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_2_3_gate_push_setup_player, 0);
  add_notetrack_flag("player_body", "start_harper", "harper_to_gate");
  add_scene("bus_dam_gate_push_setup_harper", "bus_dam_temp", 0, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_2_3_gate_push_setup_harper, 0, 0, 0, 1, undefined);
  add_scene("bus_dam_gate_push_test", "bus_dam_temp", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_2_3_gate_push_player, 0, undefined, undefined, 1, 1, 30, 30, 80, 40, 1, 1, 1, 0);
  add_actor_anim("harper", % ch_pakistan_2_3_gate_push_harper, 0, 0, 0, 1, undefined);
  add_prop_anim("bus_dam_door_left", % o_pakistan_2_3_gate_push_left_door, undefined, 0, 1);
  add_prop_anim("bus_dam_door_right", % o_pakistan_2_3_gate_push_right_door, undefined, 0, 1);
  add_scene("bus_dam_gate_success", "bus_dam_temp", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_2_3_gate_push_success_player, 1);
  add_prop_anim("bus_dam_door_left", % o_pakistan_2_3_gate_push_success_left_door, undefined, 0, 1);
  add_prop_anim("bus_dam_door_right", % o_pakistan_2_3_gate_push_success_right_door, undefined, 0, 1);
  add_scene("bus_dam_gate_success_harper", "bus_dam_temp");
  add_actor_anim("harper", % ch_pakistan_2_3_gate_push_success_harper, 0, 0, 0, 1, undefined);
  add_scene("bus_dam_gate_failure", "bus_dam_temp", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_2_3_gate_push_failure_player, 1);
  add_actor_anim("harper", % ch_pakistan_2_3_gate_push_failure_harper, 0, 0, 0, 1, undefined);
}

bus_first_impact(e_bus) {
  debug_print_line("1st_hit_start");
  level notify("fxanim_bus_dam_1st_hit_start");
}

bus_second_impact(e_bus) {
  debug_print_line("2nd_hit_start");
  level notify("fxanim_bus_dam_2nd_hit_start");
}

bus_wedge_balcony(e_bus) {
  debug_print_line("bus_wedge_balcony");
  level notify("fxanim_bus_dam_wedge_balc_start");
}

bus_wedge_wall(e_bus) {
  debug_print_line("wedge_wall_start");
  level notify("fxanim_bus_dam_wedge_wall_start");
}

bus_break_balcony(e_bus) {
  debug_print_line("break_balc_start");
  level notify("fxanim_bus_dam_break_balc_start");
}

bus_break_wall(e_bus) {
  debug_print_line("break_wall_start");
  level notify("fxanim_bus_dam_break_wall_start");
  exploder(123123);
}

#using_animtree("animated_props");
#using_animtree("generic_human");

slum_alley_initial() {
  add_scene("slum_alley_initial", "pakistan_alley", 0, 0, 0, 0);
  add_prop_anim("alley_rat_2", % ch_pakistan_3_1_slum_alley_rat02, "sewer_rat", 1, 0);
  add_prop_anim("alley_dog_1", % ch_pakistan_3_1_slum_alley_dog01, "german_shepherd", 1, 0);
  add_scene("alley_harper", "pakistan_alley", 1);
  add_actor_anim("harper", % ch_pakistan_3_1_alley_harper, 0, 0, 0, 1, undefined);
}

#using_animtree("animated_props");

slum_alley_corner() {
  add_scene("slum_alley_corner", "pakistan_alley", 0, 0, 0, 0);
  add_prop_anim("alley_rat_3", % ch_pakistan_3_1_slum_alley_rat03, "sewer_rat", 1, 0);
}

slum_alley_dog() {
  add_scene("slum_alley_dog_rummage", undefined, 0, 0, 1);
  add_prop_anim("alley_dog_2", % german_shepherd_attackidle, "german_shepherd", 0, 0);
  add_scene("slum_alley_dog_transition", "pakistan_alley", 0, 0, 0, 0);
  add_prop_anim("alley_dog_2", % ch_pakistan_3_1_slum_alley_dog02_transition, "german_shepherd", 0, 0);
  add_scene("slum_alley_dog_growl", "pakistan_alley", 0, 0, 1, 0);
  add_prop_anim("alley_dog_2", % ch_pakistan_3_1_slum_alley_dog02_growl_loop, "german_shepherd", 0, 0);
  add_scene("slum_alley_dog_growl_loop", undefined, 0, 0, 1);
  add_prop_anim("alley_dog_2", % german_shepherd_attackidle_growl, "german_shepherd", 0, 0);
  add_scene("slum_alley_dog_bark_loop", undefined, 0, 0, 1);
  add_prop_anim("alley_dog_2", % german_shepherd_attackidle_bark, "german_shepherd", 0, 0);
  add_scene("slum_alley_dog_exit", "pakistan_alley", 0, 0, 0, 0);
  add_prop_anim("alley_dog_2", % ch_pakistan_3_1_slum_alley_dog02_run_away, "german_shepherd", 1, 0);
}

#using_animtree("generic_human");
#using_animtree("animated_props");

alley_civilians() {
  add_scene("alley_civilian_1", "pakistan_alley", 0, 0, 1, 0);
  add_actor_anim("alley_civilian_1", % ch_pakistan_3_1_ambient_civilians_civ01_loop, 1, 0, 0, 0, undefined);
  add_scene("alley_civilian_2", "pakistan_alley", 0, 0, 1, 0);
  add_actor_anim("alley_civilian_2", % ch_pakistan_3_1_ambient_civilians_civ02_loop, 1, 0, 0, 0, undefined);
  add_scene("alley_civilian_1_react", "pakistan_alley", 0, 0, 0, 0);
  add_actor_anim("alley_civilian_1", % ch_pakistan_3_1_ambient_civilians_civ01, 1, 0, 0, 0, undefined);
  add_scene("alley_civilian_2_react", "pakistan_alley", 0, 0, 0, 0);
  add_actor_anim("alley_civilian_2", % ch_pakistan_3_1_ambient_civilians_civ02, 1, 0, 0, 0, undefined);
  add_scene("alley_civilian_3", "pakistan_alley", 0, 0, 1, 0);
  add_actor_anim("alley_civilian_3", % ch_pakistan_3_1_ambient_civilians_civ03, 1, 0, 0, 0, undefined);
  add_scene("alley_civilian_door_react", "pakistan_alley", 0, 0, 0, 0);
  add_actor_anim("alley_civilian_4", % ch_pakistan_3_1_ambient_civilians_civ04, 1, 0, 1, 0, undefined);
  add_actor_anim("alley_civilian_5", % ch_pakistan_3_1_ambient_civilians_civ05, 1, 0, 1, 0, undefined);
  add_prop_anim("pakistan_alley_door", % o_pakistan_3_1_ambient_civilians_door);
}

#using_animtree("player");
#using_animtree("generic_human");

corpse_alley() {
  add_scene("corpse_alley_player", "pakistan_alley_exit", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_3_1_corpse_alley_player_jump, 1);
  add_notetrack_custom_function("player_body", "start", maps\pakistan_anthem_approach::corpse_alley_player_jump_rumble);
  add_scene("corpse_alley_harper", "pakistan_alley_exit", 0, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_1_corpse_alley_harper, 0, 1, 0, 1, undefined);
  add_scene("corpse_alley_wait_harper", "pakistan_alley_exit", 0, 0, 1, 0);
  add_actor_anim("harper", % ch_pakistan_3_1_corpse_alley_wait_harper, 0, 1, 0, 1, undefined);
  add_scene("corpse_alley_exit_harper", "pakistan_alley_exit", 0, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_1_corpse_alley_exit_harper, 0, 1, 0, 1, undefined);
  add_scene("corpse_alley_runner", "pakistan_alley_exit", 0, 0, 0, 0);
  add_actor_anim("corpse_alley_runner", % ch_pakistan_3_1_corpse_alley_civilian, 1, 0, 0, 1, undefined);
  add_notetrack_custom_function("corpse_alley_runner", "get_detected", maps\pakistan_anthem_approach::civ_get_detected);
}

stealth() {
  add_scene("hand_signals_a", "harper_stealth_node_1", 1);
  add_actor_anim("harper", % ch_pakistan_3_3_hand_signals_a_harper, 0, 0, 0, 1, undefined);
  add_scene("hand_signals_b", "harper_stealth_node_2", 1);
  add_actor_anim("harper", % ch_pakistan_3_3_hand_signals_b_harper, 0, 0, 0, 1, undefined);
  add_scene("hand_signals_c", "harper_stealth_node_4", 1);
  add_actor_anim("harper", % ch_pakistan_3_3_hand_signals_c_harper, 0, 0, 0, 1, undefined);
  add_scene("hand_signals_d", "harper_stealth_node_5", 1);
  add_actor_anim("harper", % ch_pakistan_3_3_hand_signals_d_harper, 0, 0, 0, 1, undefined);
  add_scene("hand_signals_e", "harper_stealth_node_6", 1);
  add_actor_anim("harper", % ch_pakistan_3_3_hand_signals_e_harper, 0, 0, 0, 1, undefined);
}

stealth_corpses() {
  a_str_corpses = array("c_pak_civ_male_corpse1_fb", "c_pak_civ_male_corpse2_fb");
  add_scene("death_pose_1", "death_pose_1_align");
  add_actor_model_anim("death_pose_1", % ch_gen_m_floor_armdown_legspread_onback_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_2", "death_pose_2_align");
  add_actor_model_anim("death_pose_2", % ch_gen_m_wall_legspread_armdown_leanright_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_3", "death_pose_3_align");
  add_actor_model_anim("death_pose_3", % ch_gen_m_floor_armdown_onfront_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_4", "death_pose_4_align");
  add_actor_model_anim("death_pose_4", % ch_gen_m_armover_onrightside_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_5", "death_pose_5_align");
  add_actor_model_anim("death_pose_5", % ch_gen_m_vehicle_armup_leanright_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_6", "death_pose_6_align");
  add_actor_model_anim("death_pose_6", % ch_gen_m_floor_armsopen_onback_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_7", "death_pose_7_align");
  add_actor_model_anim("death_pose_7", % ch_gen_m_floor_armspread_legaskew_onback_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_8", "death_pose_8_align");
  add_actor_model_anim("death_pose_8", % ch_gen_m_floor_armspreadwide_legspread_onback_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_9", "death_pose_9_align");
  add_actor_model_anim("death_pose_9", % ch_gen_m_floor_armstomach_onback_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_10", "death_pose_10_align");
  add_actor_model_anim("death_pose_10", % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_11", "death_pose_11_align");
  add_actor_model_anim("death_pose_11", % ch_gen_m_floor_armup_legaskew_onfront_faceright_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_12", "death_pose_12_align");
  add_actor_model_anim("death_pose_12", % ch_gen_m_floor_armup_onfront_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_13", "death_pose_13_align");
  add_actor_model_anim("death_pose_13", % ch_gen_m_ledge_armhanging_facedown_onfront_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_14", "death_pose_14_align");
  add_actor_model_anim("death_pose_14", % ch_gen_m_ledge_armhanging_faceright_onfront_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_15", "death_pose_15_align");
  add_actor_model_anim("death_pose_15", % ch_gen_m_ledge_armspread_faceleft_onfront_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_16", "death_pose_16_align");
  add_actor_model_anim("death_pose_16", % ch_gen_m_ledge_armspread_faceright_onfront_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_17", "death_pose_17_align");
  add_actor_model_anim("death_pose_17", % ch_gen_m_vehicle_armup_leanright_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_18", "death_pose_18_align");
  add_actor_model_anim("death_pose_18", % ch_gen_m_vehicle_armdown_leanright_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_19", "death_pose_19_align");
  add_actor_model_anim("death_pose_19", % ch_gen_f_floor_onback_armup_legcurled_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
  add_scene("death_pose_20", "death_pose_20_align");
  add_actor_model_anim("death_pose_20", % ch_gen_m_floor_armspread_legaskew_onback_deathpose, random(a_str_corpses), 1, undefined, undefined, undefined, 0);
}

fallen_building() {
  add_scene("sideways_building_harper_climb", "pakistan_bank", 1, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_2_fallen_building_harper_climb, 0, 1, 0, 1, undefined);
  add_scene("sideways_building_harper_idle_1", "pakistan_bank", 0, 0, 1, 0);
  add_actor_anim("harper", % ch_pakistan_3_2_fallen_building_harper_idle, 0, 1, 0, 1, undefined);
  add_scene("sideways_building_harper_move", "pakistan_bank", 0, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_2_fallen_building_harper_move, 0, 1, 0, 1, undefined);
  add_scene("sideways_building_harper_idle_2", "pakistan_bank", 0, 0, 1, 0);
  add_actor_anim("harper", % ch_pakistan_3_2_fallen_building_harper_idle02, 0, 1, 0, 1, undefined);
  add_scene("sideways_building_harper_exit", "pakistan_bank", 0, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_2_fallen_building_harper_exit, 0, 1, 0, 1, undefined);
}

#using_animtree("animated_props");

sewer_entry() {
  add_scene("sewer_entry", "align_sewer_entrance", 1, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_5_sewer_entry_harper, 0, 1, 0, 1, undefined);
  add_prop_anim("sewer_entry_device", % o_pakistan_3_5_sewer_entry_lockbreaker, undefined, 1, 0);
  add_prop_anim("sewer_entry_gate", % o_pakistan_3_5_sewer_entry_sewer_gate, undefined, 0, 0);
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

intruder_perk() {
  add_scene("perk_intruder_unlock", "intruder_perk_door", 0, 0, 0, 0);
  add_player_anim("player_body", % int_specialty_pakistan_intruder, 1, 0, "tag_origin");
  add_prop_anim("intruder_device", % o_specialty_pakistan_intruder_cutter, undefined, 1, 0, undefined, "tag_origin");
  add_notetrack_fx_on_tag("intruder_device", "zap_start", "cutter_spark", "tag_fx");
  add_notetrack_fx_on_tag("intruder_device", "zap_end", "cutter_on", "tag_fx");
  add_prop_anim("intruder_perk_door", % o_specialty_pakistan_intruder_door, undefined, 0, 0, undefined, "tag_origin");
  add_notetrack_level_notify("intruder_perk_door", "lock_hit_ground", "fxanim_rat_room_start");
  add_scene("perk_intruder_guy1", undefined, 0, 0, 1);
  add_actor_anim("intruder_guy1", % casual_stand_v2_idle, 0, 1, 0, 0);
  add_scene("perk_intruder_guy2", undefined, 0, 0, 1);
  add_actor_anim("intruder_guy2", % casual_stand_v2_twitch_talk, 0, 1, 0, 0);
}

sewer_slide() {
  add_scene("sewer_slide", "sewer_slide", 1, 0, 0, 0);
  add_actor_anim("harper", % ch_pakistan_3_5_sewer_slide_harper, 0, 1, 0, 1);
}

#using_animtree("player");
#using_animtree("animated_props");

sewer_exit() {
  add_scene("sewer_exit", "pakistan_sewer_exit_temp", 0, 0, 0, 0);
  add_player_anim("player_body", % p_pakistan_3_5_manhole_cover_player, 0);
  add_prop_anim("sewer_exit_cover", % o_pakistan_3_5_manhole_cover_manhole, undefined, 0, 1);
}

vo_market_enter() {
  level.harper queue_dialog("harp_start_marking_target_0");
  level.salazar queue_dialog("sala_more_hostiles_coming_0");
  level.harper queue_dialog("harp_let_the_claws_take_p_0");
}

vo_drone_market() {
  level.salazar queue_dialog("sala_they_ve_brought_in_d_0", 1);
  level.harper queue_dialog("harp_take_down_that_drone_0", 1);
}

vo_fire_directed() {
  level.harper queue_dialog("harp_fuck_yeah_0");
}

vo_market_done() {
  level.harper queue_dialog("harp_anthem_s_2_klicks_so_0");
  level.player queue_dialog("sect_the_claws_are_buggin_0", 1, undefined, "vo_street_killzone");
}

vo_bus_smash() {
  level.harper say_dialog("harp_get_back_section_0", 2);
}

claw_nag_vo_setup() {
  e_harper = get_ent("harper_ai", "targetname", 1);
  add_vo_to_nag_group("claw_target_nag", e_harper, "harp_call_em_in_section_0");
  add_vo_to_nag_group("claw_target_nag", e_harper, "harp_mark_the_target_for_0");
  add_vo_to_nag_group("claw_target_nag", e_harper, "harp_hit_em_section_1");
}

claw_nag_filter() {
  b_is_available = level._fire_direction.hint_active;
  b_harper_speaking = isDefined(self.is_talking);
  b_should_nag = b_is_available && !b_harper_speaking;
  return false;
}

vo_frogger() {
  trigger_wait("frogger_first_wave_spawn_trigger");
  level.harper queue_dialog("harp_isi_troops_are_takin_0", 1);
  level.harper queue_dialog("harp_watch_it_section_u_0", 3);
  level.harper queue_dialog("harp_find_cover_0", 2);
}

vo_frogger_support() {
  level.player queue_dialog("sala_section_brutus_and_0");
  level.harper queue_dialog("harp_call_em_in_section_0", 1);
  level.harper queue_dialog("harp_mark_the_target_for_0", 1);
  level.harper queue_dialog("harp_shop_front_right_si_0", 1);
  level.harper queue_dialog("harp_alright_0", 1);
}

vo_claws_leaving() {
  level.player queue_dialog("sala_section_you_re_mov_0");
  level.player queue_dialog("sect_roger_that_salazar_0", 0.5);
}

vo_bus_dam() {
  flag_wait("approach_bus_dam");
  level.harper say_dialog("harp_more_isi_headed_ri_0");
  flag_wait("vo_bus_dam");
  wait 0.5;
  level.harper say_dialog("harp_what_s_the_hell_is_t_0", 1);
  setmusicstate("PAK_RIVER_BUS_START");
  wait 2;
  level.harper queue_dialog("harp_get_off_the_street_0", 0, undefined, "player_at_bus_gate");
  setmusicstate("PAK_RIVER_BUS_HIT");
}

vo_call_to_gate() {
  level endon("player_at_bus_gate");
  wait 1;
  level.harper say_dialog("harp_hurry_up_section_0", 0);
  wait 1;
  level.harper say_dialog("harp_come_on_section_l_0", 0);
  wait 1;
  level.harper say_dialog("harp_let_s_move_section_0", 0);
}

vo_alley() {
  level endon("corpse_alley_started");
  level.harper queue_dialog("harp_anthem_s_just_ahead_0");
  level.harper queue_dialog("harp_what_a_fucking_mess_0");
  level.harper queue_dialog("harp_poor_bastards_weren_0", 1);
  level.player queue_dialog("sect_they_ve_pretty_much_0");
}

vo_corpse_alley() {
  level.harper queue_dialog("harp_shit_look_must_0", 1);
}

vo_avoid_spotlight_detected() {
}

vo_sewer_exterior() {
  if(!flag("drone_intro_attack") && !flag("drone_searcher_attack") && !flag("drone_bank_attack")) {
    flag_wait("sewer_guards_go");
    level.harper say_dialog("harp_hold_up_beat_we_g_0");
    flag_wait("tandem_kill_vo");
  }

  flag_wait("tandem_kill_vo");
  level.harper thread harper_awareness();

  if(!flag("drone_intro_attack") && !flag("drone_searcher_attack") && !flag("drone_bank_attack")) {
    if(!flag("sewer_guards_alerted") && !flag("sewer_guards_cleared")) {
      level.harper say_dialog("harp_take_the_fucker_on_t_0", 1);
      level thread wait_for_player_kill();
    }
  }

  flag_wait_any("sewer_guards_cleared", "harper_kills_two");
  wait 0.5;

  if(flag("harper_kills_two"))
    level.harper say_dialog("harp_thanks_for_nothing_0", 0.5);

  flag_wait("drones_gone");
  level.harper say_dialog("harp_we_re_clear_move_u_0", 0.5);
  flag_wait("sewer_entry_started");
  level.harper say_dialog("harp_these_sewers_run_rig_0", 1);
  flag_wait("sewer_gate_open");
  level.harper say_dialog("harp_talk_about_dirty_job_0", 0.5);
  flag_wait("sewer_entered");
  level.player say_dialog("sala_section_we_re_in_p_0");
  level.player say_dialog("sect_monitor_the_area_k_0", 1);

  if(level.player hasperk("specialty_intruder")) {
    flag_wait("conversation_overheard");
    level thread vo_fake_guards();
    level.harper say_dialog("harp_you_hear_that_0", 1);
  }
}

wait_for_player_kill() {
  level endon("sewer_guards_cleared");
  level endon("sewer_guards_alerted");
  wait 6;
  level.harper say_dialog("harp_waitin_on_you_budd_0");
}

vo_fake_guards() {
  e_fake_guard = getent("fake_guard_vo", "targetname");
  e_fake_guard say_dialog("isi1_you_going_to_be_much_0", 0, 1);
  e_fake_guard say_dialog("isi2_nearly_done_what_s_0", 1, 1);
  e_fake_guard delete();
}

vo_sewer_perk_dialog_exchange() {
  ai_guard_1 = getent("intruder_guy1_ai", "targetname");
  ai_guard_2 = getent("intruder_guy2_ai", "targetname");
  ai_guard_1 thread say_dialog("isi1_we_just_got_the_word_0", 0);
  ai_guard_1 setgoalnode(getnode("node_guy_1", "targetname"));
  wait 0.2;
  ai_guard_2 setgoalnode(getnode("node_guy_2", "targetname"));
  level thread vo_sewer_perk_success();
  ai_guard_2 say_dialog("isi2_what_s_the_payload_t_0", 3);
  ai_guard_1 say_dialog("isi1_not_this_time_we_0", 0.5);
  ai_guard_2 say_dialog("isi2_are_they_an_improvem_0", 0.5);
  ai_guard_1 say_dialog("isi1_bigger_engines_toug_0", 0.5);
  ai_guard_2 thread say_dialog("isi1_anyway_they_re_bein_0", 0.5);
  wait 5;
  ai_guard_1 delete();
  ai_guard_2 delete();
}

perk_guy1_anim() {
  self waittill("goal");
  level thread run_scene("perk_intruder_guy1");
}

perk_guy2_anim() {
  self waittill("goal");
  level thread run_scene("perk_intruder_guy2");
}

vo_sewer_perk_success() {
  level.harper queue_dialog("harp_something_about_soc_0", 1);
  level thread visor_update_soct();
  level.harper queue_dialog("harp_we_d_better_keep_mov_0", 1);
  level.player queue_dialog("sect_salazar_the_isi_ha_0", 0.5);
  level.player queue_dialog("sect_salazar_the_isi_ha_0", 1);
  level.player queue_dialog("sala_understood_2", 1);
}

visor_update_soct() {
  wait 2;

  for(i = 0; i < 8; i++) {
    add_visor_text("PAKISTAN_SHARED_SOCT_INFO", 0, "orange");
    wait 2;
    remove_visor_text("PAKISTAN_SHARED_SOCT_INFO");
    wait 0.5;
  }
}

vo_change_level() {
  flag_wait("approach_exit");
  level.player notify("slow_down");
  level.player setmovespeedscale(0.6);
  level.player queue_dialog("sala_menendez_is_here_0", 0.5);
  level.player queue_dialog("sect_update_briggs_let_0", 1);
  wait 0.5;
  level.player giveweapon("data_glove_sp");
  level.player disableweaponcycling();
  level.player disableweaponfire();
  level.player disableoffhandweapons();
  level.player setlowready(0);
  level.player switchtoweapon("data_glove_sp");
  level.player waittill("weapon_change_complete");
  wait 1;
  level.player forceviewmodelanimation("data_glove_sp", "fire");
  add_visor_text("PAKISTAN_SHARED_COMMS", 5);
  wait 2;
  level thread maps\pakistan_anthem_approach::transition_to_section_2();
}