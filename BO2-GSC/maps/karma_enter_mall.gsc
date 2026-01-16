/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_enter_mall.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_objectives;
#include maps\_anim;
#include maps\karma_util;
#include maps\_dialog;
#include maps\karma_little_bird;
#include maps\karma_exit_club;
#include maps\createart\karma_2_art;
#include maps\_audio;
#include maps\_metal_storm;
#include maps\_glasses;
#include maps\_vehicle;

init_flags() {
  flag_init("store_explosion_dialog");
  flag_init("friendly_asd_activated");
  flag_init("event8_exit_door_opening");
  flag_init("e8_complete");
  flag_init("entering_sundeck");
  flag_init("intro_hero_dialogue_finished");
  flag_init("explosion_hero_dialogue_finished");
  flag_init("aqua_hero_dialogue_finished");
  flag_init("scene_event8_door_breach_done");
}

init_spawn_funcs() {
  getent("terrorist_rappel_left1", "targetname") add_spawn_function(::pmc_rappeling);
}

skipto_mall() {
  skipto_teleport("skipto_enter_mall");
  level.ai_harper = init_hero_startstruct("harper", "e8_harper_start");
  level.ai_salazar = init_hero_startstruct("salazar", "e8_salazar_start");
  level.ai_karma = undefined;
  level.ai_defalco = undefined;
  level.player set_temp_stat(1, 1);
  flag_set("intro_explosion_dialog");
  flag_set("e7_pip_defalco_in_mall");
  level thread get_array_of_closets_test();
}

get_array_of_closets_test() {
  array = [];
  array["one"] = (1, 0, 0);
  array[2] = vectorscale((1, 0, 0), 2.0);
  array["three"] = vectorscale((1, 0, 0), 3.0);
  array["four"] = undefined;
  array["five"] = undefined;
  array["six"] = vectorscale((1, 0, 0), 4.0);
  array["seven"] = undefined;
  array2 = get_array_of_closest((0, 0, 0), array);
}

main() {
  iprintln("Exit Club");

  set_level_goal("ref_delete_mall");
  add_trigger_function("e8_civs_trapped_staircase_trigger", ::cleanup_ents, "e8_sniper_castle");
  spawn_funcs();
  maps\karma_little_bird::karma_init_rusher_distances();
  level.ai_harper set_force_color("g");
  level.ai_salazar set_force_color("g");
  mall_ambient_effects();
  flag_set("draw_weapons");
  level thread maps\karma_exit_club::exit_club_clean_up();
  level thread visionset_change();
  level thread e8_wave_spawning();
  level thread enter_mall_objectives();
  level thread fxanim_aquarium_explosion();
  level thread sec_chatter_dialog();
  level thread pmc_chatter_dialog();
  level thread e8_enter_mall_vo();
  flag_wait("entering_sundeck");
}

visionset_change() {
  trigger_wait("mall_visionset");
  level.player thread maps\createart\karma_2_art::vision_set_change("sp_karma2_mall_interior");
}

spawn_funcs() {
}

mall_ambient_effects() {
  exploder(331);
  exploder(801);
}

enter_mall_objectives() {
  trigger_wait("e8_aqua_room_trigger");
  level notify("e8_thread_a1");
  level notify("e8_thread_a2");
  level notify("e8_str_cleanup_civs_groupa");
  simple_spawn("e8_end_room_friendly_spawner");
  simple_spawn("e8_end_room_enemy_spawner");
  simple_spawn("e8_rpg_killer_1");
  level thread aqua_door_dialogue();
  salazar_door_breach_event();
  wait 0.05;
  cleanup_ents("e8_wave_1");
  wait 0.05;
  cleanup_ents("e8_wave_2");
  wait 0.05;
  cleanup_ents("e8_aqua_guards");
}

mall_save_point(save_point_number) {
  switch (save_point_number) {
    case 1:
      if(!isDefined(level.mall_save_1)) {
        autosave_by_name("karma_mall_1");
        level.mall_save_1 = 1;
      }

      break;
    case 2:
      if(!isDefined(level.mall_save_2)) {
        autosave_by_name("karma_mall_2");
        level.mall_save_2 = 1;
      }

      break;
    case 3:
      if(!isDefined(level.mall_save_3)) {
        autosave_by_name("karma_mall_3");
        level.mall_save_3 = 1;
      }

      break;
    case 4:
      if(!isDefined(level.mall_save_4)) {
        autosave_by_name("karma_mall_4");
        level.mall_save_4 = 1;
      }

      break;
    default:

      assertmsg("Unknown Autosave in Mall");

      break;
  }
}

fxanim_mall_explosion() {
  a_ents = getentarray("pokee_destruction", "targetname");

  foreach(ent in a_ents)
  ent hide();

  trigger_wait("pokee_store_explosion", "targetname");
  flag_set("store_explosion_dialog");
  level notify("fxanim_store_bomb_01_start");

  foreach(ent in a_ents)
  ent show();
}

e8_wave_spawning() {
  level thread aqua_explosion();
  str_category = "e8_wave_1";
  spawn_time = undefined;
  str_thread_cleanup = "e8_thread_a1";
  str_category = "e8_wave_1";
  str_sniper_category = "e8_sniper_castle";
  level thread e8_enter_mall_trigger(str_category);
  level thread e8_enter_mall_part2_trigger(str_category);
  level thread e8_mall_upper_left_wave1_trigger(str_category, str_thread_cleanup);
  level thread e8_mall_upper_right_wave1_trigger(str_category, str_thread_cleanup);
  level thread e8_mall_upper_right_wave2_trigger(str_category, str_thread_cleanup);
  level thread e8_start_left_staircase_trigger(str_category, str_thread_cleanup);
  level thread e8_start_right_staircase_trigger(str_category, str_thread_cleanup);
  str_category = "e8_wave_2";
  str_thread_cleanup = "e8_thread_a2";
  level thread e8_mall_ul_mid_point_trigger(4, str_category, str_thread_cleanup);
  level thread e8_mall_ul_staircase_trigger(5, str_category, str_thread_cleanup);
  level thread e8_mall_ur_mid_point_trigger(4, str_category, str_thread_cleanup);
  level thread e8_mall_ur_approach_castle_trigger(4.5, str_category, str_thread_cleanup);
  level thread e8_start_bridge_left_trigger(str_category, str_thread_cleanup);
  level thread e8_start_bridge_right_trigger(str_category, str_thread_cleanup);
  level thread e8_mall_low_left_mid_trigger(6, str_category, str_thread_cleanup);
  level thread e8_mall_low_right_mid_trigger(6, str_category, str_thread_cleanup);
  str_category = "e8_wave_3";
  str_thread_cleanup = "e8_thread_a3";
  level thread e8_mall_ul_reached_staircase_trigger(10, str_category, str_thread_cleanup);
  level thread e8_mall_ul_approach_aqua_trigger(15, str_category, str_thread_cleanup);
  level thread e8_mall_ur_reached_sniper_castle_trigger(10, str_category, str_thread_cleanup);
  level thread e8_mall_ur_approach_aqua_trigger(15, str_category, str_thread_cleanup);
  level thread e8_mall_low_left_at_castle_trigger(10, str_category, str_thread_cleanup);
  level thread e8_mall_low_right_at_castle_trigger(15, str_category, str_thread_cleanup);
  level thread e8_mall_rappel_guys_on_bridge_trigger(1, str_category, str_thread_cleanup);
  str_aquaroom_friendly_category = "e8_aqua_guards";
  str_category = "e8_wave_4";
  level thread e8_the_end_enemy_spawners(25, str_category);
}

e8_enter_mall_trigger(str_category) {
  a_spawners = getentarray("e8_enter_mall_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  a_holders = getentarray("e8_enter_mall_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);

  level.ai_redshirt1 = simple_spawn_single("redshirt1", ::spawn_fn_ai_run_to_holding_node, 0);
  level.ai_redshirt1 set_force_color("r");
  level.ai_redshirt1.goalradius = 64;
  level.ai_redshirt1 thread magic_bullet_shield();
  level.ai_redshirt2 = simple_spawn_single("redshirt2", ::spawn_fn_ai_run_to_holding_node, 0);
  level.ai_redshirt2 set_force_color("r");
  level.ai_redshirt2.goalradius = 64;
  level.ai_redshirt2 thread magic_bullet_shield();
  spawn_ai_battle("e8_friendly_enter_mall_spawner_scapegoat0", "e8_enter_mall_spawner_killer0", undefined, undefined, 0, 1, 0.1, 0.8);
  sp_friendly2 = getent("e8_friendly_enter_mall_spawner_scapegoat1", "targetname");
  ai_friendly2 = simple_spawn_single(sp_friendly2, ::spawn_fn_ai_run_to_holding_node, 0, str_category);
  level thread fxanim_mall_explosion();
}

e8_enter_mall_part2_trigger(str_category) {
  trigger_wait("e8_enter_mall_part2_trigger", "targetname");
  a_spawners = getentarray("e8_enter_mall_part2_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  a_spawners = getentarray("e8_enter_mall_part2_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);

  a_jumpers = getentarray("e8_enter_mall_part2_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 420);
}

e8_mall_upper_left_wave1_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  trigger_wait("e8_mall_upper_left_wave1_trigger");
  mall_save_point(1);
  sp_rusher = getent("e8_mall_upper_left_wave1_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_spawners = getentarray("e8_mall_upper_left_wave1_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  level thread e9_civ_left_wave1_trigger();
}

e8_mall_upper_right_wave1_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  trigger_wait("e8_mall_upper_right_wave1_trigger", "targetname");
  a_spawners = getentarray("e8_mall_upper_right_wave1_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  a_spawners = getentarray("e8_mall_upper_right_wave1_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  a_holders = getentarray("e8_mall_upper_right_wave1_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);
}

e8_mall_upper_right_wave2_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  trigger_wait("e8_mall_upper_right_wave2_trigger");
  mall_save_point(1);
  level thread e9_civ_right_wave2_trigger();
}

e8_start_left_staircase_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  trigger_wait("e8_start_left_staircase_trigger", "targetname");
  mall_save_point(1);
  a_spawners = getentarray("e8_start_left_staircase_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  sp_rusher = getent("e8_start_left_staircase_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, e_ai.script_delay, level.player_rusher_fight_dist, 0.02, 0.1, 1);
}

e8_start_right_staircase_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  trigger_wait("e8_start_right_staircase_trigger", "targetname");
  mall_save_point(1);
  a_spawners = getentarray("e8_start_right_staircase_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  sp_rusher = getent("e8_start_right_staircase_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, e_ai.script_delay, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_holders = getentarray("e8_start_right_staircase_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);
}

e8_mall_ul_mid_point_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ul_mid_point_trigger", "targetname");
  a_spawners = getentarray("e8_mall_ul_mid_point_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  sp_rusher = getent("e8_mall_ul_mid_point_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);
}

e8_mall_ul_staircase_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ul_mid_point_trigger", "targetname");
  a_spawners = getentarray("e8_mall_ul_staircase_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 0, str_category, 1, 0, 0);
}

e8_mall_ur_mid_point_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ur_mid_point_trigger", "targetname");
  a_spawners = getentarray("e8_mall_ur_mid_point_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 0, str_category, 1, 0, 0);

  sp_rusher = getent("e8_mall_ur_mid_point_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);
}

e8_mall_ur_approach_castle_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ur_approach_castle_trigger", "targetname");
  a_jumpers = getentarray("e8_mall_ur_approach_castle_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn_script_delay(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 336);

  a_spawners = getentarray("e8_mall_ur_approach_castle_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 0, str_category, 1, 0, 0);

  a_holders = getentarray("e8_mall_ur_approach_castle_holder_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);

  a_spawners = getentarray("e8_mall_ur_approach_castle_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);
}

e8_start_bridge_left_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  e_trigger = getent("e8_start_bridge_left_trigger", "targetname");
  e_trigger endon("death");
  e_trigger trigger_wait();
  t_opposite = getent(e_trigger.target, "targetname");

  if(isDefined(t_opposite))
    t_opposite delete();

  a_spawners = getentarray("e8_start_bridge_left_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  sp_rusher = getent("e8_start_bridge_left_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);
}

e8_start_bridge_right_trigger(str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);
  e_trigger = getent("e8_start_bridge_right_trigger", "targetname");
  e_trigger endon("death");
  e_trigger trigger_wait();
  t_opposite = getent(e_trigger.target, "targetname");

  if(isDefined(t_opposite))
    t_opposite delete();

  a_spawners = getentarray("e8_start_bridge_right_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  sp_rusher = getent("e8_start_bridge_right_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);
}

e8_mall_low_left_mid_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_low_left_mid_trigger", "targetname");
  mall_save_point(2);
  a_spawners = getentarray("e8_mall_low_left_mid_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  a_spawners = getentarray("e8_mall_low_left_mid_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  sp_rusher = getent("e8_mall_low_left_mid_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);
}

e8_mall_low_right_mid_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_low_right_mid_trigger", "targetname");
  mall_save_point(2);
  a_spawners = getentarray("e8_mall_low_right_mid_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  a_spawners = getentarray("e8_mall_low_right_mid_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  sp_rusher = getent("e8_mall_low_right_mid_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_jumpers = getentarray("e8_mall_low_right_mid_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 420);
}

e8_mall_ul_reached_staircase_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ul_reached_staircase_trigger", "targetname");
  mall_save_point(2);
  sp_rusher = getent("e8_mall_ul_reached_staircase_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_holders = getentarray("e8_mall_ul_reached_staircase_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);

  a_spawners = getentarray("e8_mall_ul_reached_staircase_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  a_jumpers = getentarray("e8_mall_ul_reached_staircase_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn_script_delay(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 336);

  a_spawners = getentarray("e8_mall_ul_reached_staircase_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);
}

e8_mall_ul_approach_aqua_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ul_approach_aqua_trigger", "targetname");
  sp_rusher = getent("e8_mall_ul_approach_aqua_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_spawners = getentarray("e8_mall_ul_approach_aqua_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  a_jumpers = getentarray("e8_mall_ul_approach_aqua_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn_script_delay(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 336);

  a_spawners = getentarray("e8_mall_ul_approach_aqua_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);
}

e8_mall_ur_reached_sniper_castle_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ur_reached_sniper_castle_trigger", "targetname");
  mall_save_point(2);
  sp_rusher = getent("e8_mall_ur_reached_sniper_castle_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_spawners = getentarray("e8_mall_ur_reached_sniper_castle_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  a_spawners = getentarray("e8_mall_ur_reached_sniper_castle_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);
}

e8_mall_ur_approach_aqua_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_ur_approach_aqua_trigger", "targetname");
  sp_rusher = getent("e8_mall_ur_approach_aqua_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_fight_dist, 0.02, 0.1, 1);

  a_holders = getentarray("e8_mall_ur_approach_aqua_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);

  a_spawners = getentarray("e8_mall_ur_approach_aqua_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);
}

e8_mall_rappel_guys_on_bridge_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_rappel_guys_on_bridge");
  level thread run_scene_and_delete("terrorist_rappel_left1");
  level thread run_scene_and_delete("terrorist_rappel_left2");
}

e8_mall_low_left_at_castle_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_low_left_at_castle_trigger", "targetname");
  mall_save_point(2);
  sp_rusher = getent("e8_mall_low_left_at_castle_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_player_busy_dist, 0.02, 0.1, 1);

  a_spawners = getentarray("e8_mall_low_left_at_castle_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  a_spawners = getentarray("e8_mall_low_left_at_castle_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  a_holders = getentarray("e8_mall_low_left_at_castle_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);

  a_jumpers = getentarray("e8_mall_low_left_at_castle_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn_script_delay(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 336);
}

e8_mall_low_right_at_castle_trigger(delay, str_category, str_thread_cleanup) {
  level endon(str_thread_cleanup);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  trigger_wait("e8_mall_low_right_at_castle_trigger", "targetname");
  mall_save_point(2);
  sp_rusher = getent("e8_mall_low_right_at_castle_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, level.player_rusher_player_busy_dist, 0.02, 0.1, 1);

  a_spawners = getentarray("e8_mall_low_right_at_castle_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);

  a_spawners = getentarray("e8_mall_low_right_at_castle_ignore_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 1);

  a_holders = getentarray("e8_mall_low_right_at_castle_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 1, 0);

  a_jumpers = getentarray("e8_mall_low_right_at_castle_jumper_spawner", "targetname");

  if(isDefined(a_jumpers))
    simple_spawn_script_delay(a_jumpers, ::spawn_fn_ai_run_to_jumper_node, 1, str_category, 0, 0, 336);
}

e8_intro_civilians(delay, str_scene_name, a_ent_names) {
  if(isDefined(delay))
    wait(delay);

  run_scene_and_delete(str_scene_name);

  if(isDefined(a_ent_names)) {
    for(i = 0; i < a_ent_names.size; i++) {
      e_ent = getent(a_ent_names[i], "targetname");

      if(isDefined(e_ent))
        e_ent delete();
    }
  }
}

e8_startup_civ_anims(spawn_time) {
  a_ent_names = [];
  a_ent_names[a_ent_names.size] = "e7_wounded_man_1_ai";
  a_ent_names[a_ent_names.size] = "e7_wounded_woman_1_ai";
  level thread e8_intro_civilians(spawn_time, "scene_e8_intro_civ_couple_1", a_ent_names);
  a_ent_names = [];
  a_ent_names[a_ent_names.size] = "e7_wounded_man_2_ai";
  a_ent_names[a_ent_names.size] = "e7_wounded_woman_2_ai";
  level thread e8_intro_civilians(spawn_time, "scene_e8_intro_civ_couple_2", a_ent_names);
  a_ent_names = [];
  a_ent_names[a_ent_names.size] = "e7_wounded_man_3_ai";
  level thread e8_intro_civilians(spawn_time, "scene_e8_intro_civ_single_1", a_ent_names);
  a_ent_names = [];
  a_ent_names[a_ent_names.size] = "e7_wounded_woman_4_ai";
  level thread e8_intro_civilians(spawn_time, "scene_e8_intro_civ_single_2", a_ent_names);
  a_ent_names = [];
  a_ent_names[a_ent_names.size] = "e7_wounded_man_4_ai";
  level thread e8_intro_civilians(spawn_time, "scene_e8_intro_civ_single_3", a_ent_names);
}

e8_intro_guard_anims(delay, str_category) {
  if(isDefined(delay))
    wait(delay);

  wait 1.0;
  a_guards = [];
  a_guards[a_guards.size] = "scene_e8_intro_guard1";
  a_guards[a_guards.size] = "scene_e8_intro_guard2";
  a_guards[a_guards.size] = "scene_e8_intro_guard3";
  a_guards[a_guards.size] = "scene_e8_intro_guard4";

  for(i = 0; i < a_guards.size; i++)
    level thread run_scene_and_delete(a_guards[i]);

  wait 1;

  for(i = 0; i < a_guards.size; i++) {
    str_name = "e8_start_anim_guard" + (i + 1) + "_ai";
    e_ent = getent(str_name, "targetname");

    if(isDefined(e_ent))
      e_ent add_cleanup_ent(str_category);
  }
}

e9_civ_left_wave1_trigger() {
  ai_civ = simple_spawn_single("e8_mall_left_wave1_civ1");

  if(isalive(ai_civ))
    ai_civ thread fleeing_civ_goto();

  ai_civ = simple_spawn_single("e8_mall_left_wave1_civ2");

  if(isalive(ai_civ))
    ai_civ thread fleeing_civ_goto(2.0);

  ai_civ = simple_spawn_single("e8_mall_left_wave1_civ3");

  if(isalive(ai_civ))
    ai_civ thread fleeing_civ_goto(4.0);
}

e9_civ_right_wave2_trigger() {
  ai_civ = simple_spawn_single("e8_mall_right_wave2_civ1");

  if(isalive(ai_civ))
    ai_civ thread fleeing_civ_goto();

  ai_civ = simple_spawn_single("e8_mall_right_wave2_civ2");

  if(isalive(ai_civ))
    ai_civ thread fleeing_civ_goto(2.0);
}

fleeing_civ_goto(n_delay) {
  if(!isDefined(n_delay))
    n_delay = 0.0;

  self endon("death");
  wait(n_delay);
  s_pos = getstruct(self.target, "targetname");
  self set_goalradius(8);
  self setgoalpos(s_pos.origin);
  self waittill("goal");
  self thread civ_idle();

  while(true) {
    level.player waittill_player_not_looking_at(self.origin, 0.5, 0);

    if(distancesquared(level.player.origin, self.origin) >= 1048576)
      self delete();

    wait 0.05;
  }
}

ai_rappel_run_to_target(str_category, ignoreme) {
  self endon("death");
  self.b_rappelling = 1;
  self waittill("rappel_done");
  self.b_rappelling = undefined;

  if(isDefined(ignoreme))
    self.ignoreme = 1;

  self thread spawn_fn_ai_run_to_target(1, str_category, undefined, undefined, undefined);
}

aqua_explosion() {
  level waittill("aqua_explosion_trigger");
  playsoundatposition("exp_veh_large", (-1335, -2942, -2780));
  level clientnotify("aqb");
  exploder(750);
  level notify("fxanim_aquarium_pillar_start");
  m_aquarium = getent("aquarium", "targetname");

  if(isDefined(m_aquarium))
    m_aquarium setmodel("dest_aquarium_glass_karma");

  stop_exploder(750);
}

fxanim_aquarium_explosion() {
  a_ents = getentarray("aquarium_bomb", "targetname");

  foreach(ent in a_ents)
  ent hide();

  level waittill("fxanim_aquarium_pillar_start");
  a_ents[0] playrumbleonentity("artillery_rumble");
  earthquake(0.3, 3, a_ents[0].origin, 1500);
  wait 3;
  a_ents[0] playrumbleonentity("artillery_rumble");
  earthquake(0.3, 3, a_ents[0].origin, 1500);
  wait 1;

  foreach(ent in a_ents)
  ent show();
}

e8_enter_mall_vo() {
  level endon("e8_complete");
  dialog_start_convo("e7_pip_defalco_in_mall");
  level thread pip_karma_event("pip_security_feed");
  level.player priority_dialog("sect_there_he_s_in_the_0", 1, "glasses_bink_playing");
  level thread defalco_marker_think();
  level.player priority_dialog("sect_let_s_go_1");
  dialog_end_convo();
  level.ai_harper queue_dialog("harp_they_really_want_thi_0");
  flag_set("intro_hero_dialogue_finished");
  dialog_start_convo("store_explosion_dialog");
  level.player priority_dialog("sect_farid_defalco_s_bl_0", 2);
  level.ai_harper priority_dialog("harp_is_the_son_of_a_bitc_0");
  level.player priority_dialog("fari_i_m_not_sure_i_ca_0");
  level.ai_harper priority_dialog("harp_we_can_t_let_that_ba_0");
  dialog_end_convo();
  flag_set("explosion_hero_dialogue_finished");
  level thread nag_move_foward("aqua_explosion_trigger", 20.0, 30.0);
  level thread sec_rocket_launchers();
  level waittill("aqua_explosion_trigger");
  dialog_start_convo();
  level thread pip_karma_event("pip_exiting_the_mall");
  level.player priority_dialog("fari_i_have_him_exiting_0", 1, "glasses_bink_playing");
  level.ai_harper priority_dialog("harp_this_bastard_s_reall_0");
  level.player priority_dialog("sect_farid_you_have_to_0");
  level.player priority_dialog("fari_i_m_working_on_it_0");
  dialog_end_convo();
  flag_set("aqua_hero_dialogue_finished");
  flag_wait("start_gatepull");
  level.player say_dialog("sect_get_it_open_0");
  level thread maps\_audio::switch_music_wait("KARMA_POST_MALL", 5);
}

nag_move_foward(str_end_flag, n_wait_min, n_wait_max) {
  level endon(str_end_flag);
  a_harper_nag = [];
  a_harper_nag[0] = "harp_we_can_t_let_that_ba_0";
  a_harper_nag[1] = "harp_dammit_we_gotta_pi_0";
  a_harper_nag[2] = "harp_push_through_before_0";
  a_harper_nag[3] = "harp_shit_man_he_s_getti_0";
  a_salazar_nag = [];
  a_salazar_nag[0] = "sala_where_the_hell_is_he_0";
  a_salazar_nag[1] = "sala_we_re_going_to_lose_0";
  a_salazar_nag[2] = "sala_defalco_s_getting_aw_0";
  wait 7;

  while(!flag(str_end_flag)) {
    if(cointoss())
      level.ai_harper say_dialog(a_harper_nag[randomint(a_harper_nag.size)]);
    else
      level.ai_salazar say_dialog(a_salazar_nag[randomint(a_salazar_nag.size)]);

    wait(randomfloatrange(n_wait_min, n_wait_max));
  }
}

brute_force_perk() {
  run_scene_first_frame("brute_doors");
  level endon("e8_complete");
  level.vh_friendly_asd = spawn_vehicle_from_targetname("specialty_asd");
  level.vh_friendly_asd thread friendly_asd_think();
  getent("t_brute_force_use", "targetname") trigger_off();
  flag_wait("level.player");
  level.player waittill_player_has_brute_force_perk();
  s_brute = getstruct("brute_force_use_pos", "targetname");
  set_objective(level.obj_brute, s_brute.origin, "interact");
  getent("t_brute_force_use", "targetname") sethintstring(&"SCRIPT_HINT_BRUTE_FORCE");
  getent("t_brute_force_use", "targetname") trigger_on();
  trigger_wait("t_brute_force_use");
  t_brute_use = getent("t_brute_force_use", "targetname");
  t_brute_use delete();
  e_blockage_clip = getent("brute_force_blocker_clip", "targetname");
  e_blockage_clip delete();
  run_scene_and_delete("brute");
  set_objective(level.obj_brute, s_brute, "remove");
  level.player thread brute_force_dialog();
}

brute_force_dialog() {
  dialog_start_convo();
  self priority_dialog("sect_farid_we_ve_got_an_0");
  self priority_dialog("fari_station_55_55_0");
  self priority_dialog("fari_set_parameters_id_0");
  flag_set("friendly_asd_activated");
  dialog_end_convo();
}

friendly_asd_think() {
  self endon("death");
  self setthreatbiasgroup("allies");
  self thread maps\_metal_storm::metalstorm_set_team("allies");
  self maps\_metal_storm::metalstorm_off();
  self.takedamage = 0;
  flag_wait("friendly_asd_activated");
  maps\_glasses::add_visor_text("KARMA_MSG_ASD_SYNC", 10, "orange", "medium", 1, 0.5, 1);
  self thread maps\_metal_storm::metalstorm_on();
  self thread maps\_vehicle::defend(self.origin, 20);
  self.takedamage = 1;
  self.health = 5000;
  scene_wait("scene_event8_door_breach");

  while(true) {
    n_dist = distancesquared(self.origin, level.player.origin);

    if(n_dist > 250000) {
      self thread maps\_vehicle::defend(level.player.origin, 144);
      self setspeed(15, 5, 5);
    }

    wait 0.05;
  }
}

salazar_door_breach_anim() {
  level endon("scene_event8_door_breach_started");
  run_scene_and_delete("scene_event8_door_breach_salazar");
  level thread run_scene_and_delete("scene_event8_door_breach_salazar_idle");
}

salazar_door_breach_event() {
  set_objective(level.obj_stop_defalco);
  set_objective(level.obj_salazar_unlock_door, level.ai_salazar);
  level thread salazar_door_breach_anim();
  flag_wait("scene_event8_door_breach_ready");
  level clientnotify("pod");
  flag_wait("player_at_gate");
  end_scene("scene_event8_door_breach_salazar");
  end_scene("scene_event8_door_breach_salazar_idle");
  set_objective(level.obj_salazar_unlock_door, undefined, "delete");
  set_objective(level.obj_stop_defalco, level.fake_defalco);
  door_collision = getent("e7_door_clip", "targetname");
  door_collision linkto(getent("security_gate", "targetname"), "tag_animate");
  door_collision connectpaths();
  exploder(999);
  level thread sec_evacuate();
  level thread run_scene_and_delete("scene_event8_door_breach");
  auto_ai_cleanup();
  flag_set("entering_sundeck");
  level thread karma_9_1_gate_lift_hero_run_to_path("harper_exit_gate_node", "scene_event8_door_breach_harper");
  level thread karma_9_1_gate_lift_hero_run_to_path("salazar_exit_gate_node", "scene_event8_door_breach_salazar_end");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape1");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape2");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape3");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape4");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape5");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape6");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape7");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape8");
  level thread karma_9_1_gate_lift_civ_run_to_path("civ_exit_node1", "scene_event8_civ_escape9");
  scene_wait("scene_event8_door_breach");
  trigger_use("trig_spawn_wounded_after_gate");
  door_collision disconnectpaths();
  e_trigger = getent("e8_color_11", "targetname");
  e_trigger activate_trigger();
  autosave_by_name("mall_gate");
}

karma_9_1_gate_lift_hero_run_to_path(run_to, str_scene_name, delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread run_scene(str_scene_name);
  wait 1;
  a_ai = get_ais_from_scene(str_scene_name);
  scene_wait(str_scene_name);
  n_node = getnode(run_to, "targetname");

  for(i = 0; i < a_ai.size; i++) {
    a_ai[i].goalradius = 48;
    a_ai[i] setgoalnode(n_node);
    a_ai[i] waittill("goal");
  }
}

e8_aquarium_rpg_killers_trigger(delay, str_category) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level waittill("e8_civs_staircase_triggered");
  level thread salazar_get_into_door_open_position(10);
  a_spawners = getentarray("e8_end_room_enemy_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 1, 0, 0);
}

e8_end_rpg_killer(delay, str_targetname, str_category) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  sp_guy = getent(str_targetname, "targetname");
  e_ai_rpg = simple_spawn_single(sp_guy);
  e_ai_rpg spawn_fn_ai_run_to_target(0, str_category, 1, 1, 0);
  e_ai_rpg endon("death");
  e_ai_rpg.script_accuracy = 0.9;
  start_time = gettime();
  fire_time = 15;
  alive_time = 20;
  str_targetname = "e8_end_room_friendly_spawner_ai";

  while(true) {
    a_targets = getentarray(str_targetname, "targetname");

    if(!isDefined(a_targets) || a_targets.size == 0) {
      break;
    }

    time = gettime();
    total_time = (time - start_time) / 1000;

    if(total_time >= fire_time) {
      break;
    }

    index = randomint(a_targets.size);
    ai_target = a_targets[index];
    e_ai_rpg thread shoot_at_target(ai_target);
    fire_wait = randomintrange(2, 4);
    wait(fire_wait);
  }

  while(true) {
    time = gettime();
    total_time = (time - start_time) / 1000;

    if(isalive(e_ai_rpg) && total_time >= alive_time) {
      pos = e_ai_rpg.origin;
      dir = anglestoforward(e_ai_rpg.angles);
      pos = pos + dir * 21.0;
      playfx(level._effect["def_explosion"], pos);
      e_ai_rpg dodamage(1000, e_ai_rpg.origin);
      break;
    }

    wait 0.1;
  }
}

e8_kill_all_enemy_at_end_of_mall(delay, str_objective_notify) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  a_volume = getentarray("e8_aquarium_enemy_kill_volume", "targetname");

  while(true) {
    a_enemy = getaiarray("axis");

    if(!isDefined(a_enemy) || a_enemy.size == 0) {
      break;
    }

    ai_inside = 0;

    for(i = 0; i < a_enemy.size; i++) {
      for(vol_num = 0; vol_num < a_volume.size; vol_num++) {
        if(a_enemy[i] istouching(a_volume[vol_num])) {
          ai_inside++;
          break;
        }
      }
    }

    if(ai_inside <= 0) {
      break;
    }

    wait 1;
  }

  wait 0.01;
  level notify("e8_thread_a3");
  wait 0.01;
  level notify(str_objective_notify);
}

salazar_get_into_door_open_position(delay) {
  wait(delay);
  nd_target = getnode("e8_salazar_door_wait_position", "targetname");
  level.ai_salazar.goalradius = 48;
  level.ai_salazar setgoalnode(nd_target);
}

e8_the_end_enemy_spawners(delay, str_category) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  flag_wait("scene_event8_door_breach_done");
  level thread trigger_event9_timer(12);
}

trigger_event9_timer(delay) {
  wait(delay);
  e_trigger = getent("trigger_end_event8_2", "targetname");

  if(isDefined(e_trigger))
    e_trigger activate_trigger();
}

karma_9_1_gate_lift_civ_run_to_path(run_to, str_scene_name) {
  flag_wait("start_gatepull");
  run_scene(str_scene_name);
  n_node = getnode(run_to, "targetname");
  a_ai = get_ais_from_scene(str_scene_name);
  array_thread(a_ai, ::run_to_node_and_die, n_node);
}

sec_mall_explosion() {
  queue_dialog_ally("sec0_get_the_hell_out_of_0");
  queue_dialog_ally("sec0_it_s_going_to_blow_0");
  wait 1.0;
  queue_dialog_ally("sec0_another_bomb_just_we_0");
  queue_dialog_ally("sec0_there_may_be_more_bo_0", 0.25);
  wait 2.0;
}

sec_rocket_launchers() {
  wait 1.0;
  queue_dialog_ally("sec0_dammit_they_have_r_0");
  queue_dialog_ally("sec0_find_cover_0");
}

pmc_rappeling() {
  self say_dialog("pmc0_repel_down_go_go_0");
}

sec_rappeling() {
  queue_dialog_ally("sec0_we_got_more_repellin_0");
  queue_dialog_ally("sec0_it_s_a_terrorist_att_0");
  queue_dialog_ally("sec0_no_they_re_private_0");
}

aqua_door_dialogue() {
  queue_dialog_enemy("pmc0_they_re_moving_up_0");
  queue_dialog_enemy("pmc0_don_t_let_them_leave_0");
  queue_dialog_enemy("pmc0_hold_them_at_the_aqu_0");
  flag_wait("aqua_hero_dialogue_finished");
  queue_dialog_ally("sec0_they_re_sealing_the_0");
  queue_dialog_ally("sec0_they_re_still_passen_0");
}

sec_chatter_dialog() {
  a_chatter = [];
  a_chatter[a_chatter.size] = "sec0_we_re_under_attack_0";
  a_chatter[a_chatter.size] = "sec0_they_just_set_off_an_0";
  a_chatter[a_chatter.size] = "sec0_get_the_passengers_o_0";
  a_chatter[a_chatter.size] = "sec0_we_need_to_evacuate_0";
  a_chatter[a_chatter.size] = "sec0_get_to_the_lifeboats_0";
  a_chatter[a_chatter.size] = "sec0_keep_moving_0";
  a_chatter[a_chatter.size] = "sec0_there_may_be_more_bo_0";
  a_chatter[a_chatter.size] = "sec0_everyone_get_out_o_0";
  a_chatter[a_chatter.size] = "sec0_run_do_not_slow_do_0";
  a_chatter[a_chatter.size] = "sec0_return_fire_0";
  a_chatter[a_chatter.size] = "sec0_too_many_of_them_0";
  a_chatter[a_chatter.size] = "sec0_we_don_t_stand_a_cha_0";
  a_chatter[a_chatter.size] = "sec0_they_re_on_the_upper_0";
  a_chatter[a_chatter.size] = "sec0_more_below_0";
  a_chatter[a_chatter.size] = "sec0_we_got_more_repellin_0";
  a_chatter[a_chatter.size] = "sec0_we_re_being_overrun_0";
  a_chatter[a_chatter.size] = "sec0_dammit_they_have_r_0";
  a_chatter[a_chatter.size] = "sec0_find_cover_0";
  a_chatter[a_chatter.size] = "sec0_where_the_hell_are_o_0";
  a_chatter[a_chatter.size] = "sec0_they_re_everywhere_0";
  a_chatter[a_chatter.size] = "sec0_what_the_hell_can_we_0";
  a_chatter[a_chatter.size] = "sec0_we_ll_all_be_killed_0";
  a_chatter[a_chatter.size] = "sec0_this_can_t_be_happen_0";
  a_chatter[a_chatter.size] = "sec0_we_re_out_of_options_0";
  a_chatter[a_chatter.size] = "sec0_another_bomb_just_we_0";
  a_chatter[a_chatter.size] = "sec0_stay_behind_the_pill_0";
  a_chatter[a_chatter.size] = "sec0_we_have_to_get_this_0";
  a_chatter[a_chatter.size] = "sec0_keep_firing_0";
  a_chatter[a_chatter.size] = "sec0_push_them_back_0";
  a_chatter[a_chatter.size] = "sec0_call_the_damn_milita_0";
  a_chatter[a_chatter.size] = "sec0_we_re_not_equipped_t_0";
  a_chatter[a_chatter.size] = "sec0_they_re_sealing_the_0";
  a_chatter[a_chatter.size] = "sec0_they_re_still_passen_0";
  a_chatter[a_chatter.size] = "sec0_the_asds_are_out_of_0";
  a_chatter[a_chatter.size] = "sec0_they_re_firing_on_us_0";
  a_chatter[a_chatter.size] = "sec0_get_the_hell_out_of_0";
  a_chatter[a_chatter.size] = "sec0_it_s_going_to_blow_0";
  a_chatter[a_chatter.size] = "sec0_it_s_coming_down_0";
  a_chatter[a_chatter.size] = "sec0_look_out_they_re_o_0";
  a_chatter[a_chatter.size] = "sec0_they_re_behind_the_r_0";
  a_chatter[a_chatter.size] = "sec0_they_re_everywhere_1";
  a_chatter[a_chatter.size] = "sec0_i_m_hit_0";
  a_chatter[a_chatter.size] = "sec0_i_m_bleeding_i_m_b_0";
  a_chatter[a_chatter.size] = "sec0_help_me_please_0";
  a_chatter[a_chatter.size] = "sec1_we_re_under_attack_0";
  a_chatter[a_chatter.size] = "sec1_they_just_set_off_an_0";
  a_chatter[a_chatter.size] = "sec1_get_the_passengers_o_0";
  a_chatter[a_chatter.size] = "sec1_we_need_to_evacuate_0";
  a_chatter[a_chatter.size] = "sec1_get_to_the_lifeboats_0";
  a_chatter[a_chatter.size] = "sec1_keep_moving_0";
  a_chatter[a_chatter.size] = "sec1_there_may_be_more_bo_0";
  a_chatter[a_chatter.size] = "sec1_everyone_get_out_o_0";
  a_chatter[a_chatter.size] = "sec1_run_do_not_slow_do_0";
  a_chatter[a_chatter.size] = "sec1_return_fire_0";
  a_chatter[a_chatter.size] = "sec1_too_many_of_them_0";
  a_chatter[a_chatter.size] = "sec1_we_don_t_stand_a_cha_0";
  a_chatter[a_chatter.size] = "sec1_they_re_on_the_upper_0";
  a_chatter[a_chatter.size] = "sec1_more_below_0";
  a_chatter[a_chatter.size] = "sec1_we_got_more_repellin_0";
  a_chatter[a_chatter.size] = "sec1_we_re_being_overrun_0";
  a_chatter[a_chatter.size] = "sec1_dammit_they_have_r_0";
  a_chatter[a_chatter.size] = "sec1_find_cover_0";
  a_chatter[a_chatter.size] = "sec1_where_the_hell_are_o_0";
  a_chatter[a_chatter.size] = "sec1_they_re_everywhere_0";
  a_chatter[a_chatter.size] = "sec1_what_the_hell_can_we_0";
  a_chatter[a_chatter.size] = "sec1_we_ll_all_be_killed_0";
  a_chatter[a_chatter.size] = "sec1_this_can_t_be_happen_0";
  a_chatter[a_chatter.size] = "sec1_we_re_out_of_options_0";
  a_chatter[a_chatter.size] = "sec1_another_bomb_just_we_0";
  a_chatter[a_chatter.size] = "sec1_stay_behind_the_pill_0";
  a_chatter[a_chatter.size] = "sec1_we_have_to_get_this_0";
  a_chatter[a_chatter.size] = "sec1_keep_firing_0";
  a_chatter[a_chatter.size] = "sec1_push_them_back_0";
  a_chatter[a_chatter.size] = "sec1_call_the_damn_milita_0";
  a_chatter[a_chatter.size] = "sec1_we_re_not_equipped_t_0";
  a_chatter[a_chatter.size] = "sec1_they_re_sealing_the_0";
  a_chatter[a_chatter.size] = "sec1_they_re_still_passen_0";
  a_chatter[a_chatter.size] = "sec1_the_asds_are_out_of_0";
  a_chatter[a_chatter.size] = "sec1_they_re_firing_on_us_0";
  a_chatter[a_chatter.size] = "sec1_get_the_hell_out_of_0";
  a_chatter[a_chatter.size] = "sec1_it_s_going_to_blow_0";
  a_chatter[a_chatter.size] = "sec1_it_s_coming_down_0";
  a_chatter[a_chatter.size] = "sec1_look_out_they_re_o_0";
  a_chatter[a_chatter.size] = "sec1_they_re_behind_the_r_0";
  a_chatter[a_chatter.size] = "sec1_they_re_everywhere_1";
  a_chatter[a_chatter.size] = "sec1_i_m_hit_0";
  a_chatter[a_chatter.size] = "sec1_i_m_bleeding_i_m_b_0";
  a_chatter[a_chatter.size] = "sec1_help_me_please_0";
  a_chatter[a_chatter.size] = "sec2_we_re_under_attack_0";
  a_chatter[a_chatter.size] = "sec2_they_just_set_off_an_0";
  a_chatter[a_chatter.size] = "sec2_get_the_passengers_o_0";
  a_chatter[a_chatter.size] = "sec2_we_need_to_evacuate_0";
  a_chatter[a_chatter.size] = "sec2_get_to_the_lifeboats_0";
  a_chatter[a_chatter.size] = "sec2_keep_moving_0";
  a_chatter[a_chatter.size] = "sec2_there_may_be_more_bo_0";
  a_chatter[a_chatter.size] = "sec2_everyone_get_out_o_0";
  a_chatter[a_chatter.size] = "sec2_run_do_not_slow_do_0";
  a_chatter[a_chatter.size] = "sec2_return_fire_0";
  a_chatter[a_chatter.size] = "sec2_too_many_of_them_0";
  a_chatter[a_chatter.size] = "sec2_we_don_t_stand_a_cha_0";
  a_chatter[a_chatter.size] = "sec2_they_re_on_the_upper_0";
  a_chatter[a_chatter.size] = "sec2_more_below_0";
  a_chatter[a_chatter.size] = "sec2_we_got_more_repellin_0";
  a_chatter[a_chatter.size] = "sec2_we_re_being_overrun_0";
  a_chatter[a_chatter.size] = "sec2_dammit_they_have_r_0";
  a_chatter[a_chatter.size] = "sec2_find_cover_0";
  a_chatter[a_chatter.size] = "sec2_where_the_hell_are_o_0";
  a_chatter[a_chatter.size] = "sec2_they_re_everywhere_0";
  a_chatter[a_chatter.size] = "sec2_what_the_hell_can_we_0";
  a_chatter[a_chatter.size] = "sec2_we_ll_all_be_killed_0";
  a_chatter[a_chatter.size] = "sec2_this_can_t_be_happen_0";
  a_chatter[a_chatter.size] = "sec2_we_re_out_of_options_0";
  a_chatter[a_chatter.size] = "sec2_another_bomb_just_we_0";
  a_chatter[a_chatter.size] = "sec2_stay_behind_the_pill_0";
  a_chatter[a_chatter.size] = "sec2_we_have_to_get_this_0";
  a_chatter[a_chatter.size] = "sec2_keep_firing_0";
  a_chatter[a_chatter.size] = "sec2_push_them_back_0";
  a_chatter[a_chatter.size] = "sec2_call_the_damn_milita_0";
  a_chatter[a_chatter.size] = "sec2_we_re_not_equipped_t_0";
  a_chatter[a_chatter.size] = "sec2_they_re_sealing_the_0";
  a_chatter[a_chatter.size] = "sec2_they_re_still_passen_0";
  a_chatter[a_chatter.size] = "sec2_the_asds_are_out_of_0";
  a_chatter[a_chatter.size] = "sec2_they_re_firing_on_us_0";
  a_chatter[a_chatter.size] = "sec2_get_the_hell_out_of_0";
  a_chatter[a_chatter.size] = "sec2_it_s_going_to_blow_0";
  a_chatter[a_chatter.size] = "sec2_it_s_coming_down_0";
  a_chatter[a_chatter.size] = "sec2_look_out_they_re_o_0";
  a_chatter[a_chatter.size] = "sec2_they_re_behind_the_r_0";
  a_chatter[a_chatter.size] = "sec2_they_re_everywhere_1";
  a_chatter[a_chatter.size] = "sec2_i_m_hit_0";
  a_chatter[a_chatter.size] = "sec2_i_m_bleeding_i_m_b_0";
  a_chatter[a_chatter.size] = "sec2_help_me_please_0";

  while(a_chatter.size > 0) {
    str_line = random(a_chatter);
    arrayremovevalue(a_chatter, str_line);
    queue_dialog_ally(str_line, 0, undefined, undefined, 0);
    wait(randomfloatrange(3, 10));
  }

  level thread sec_chatter_dialog();
}

pmc_chatter_dialog() {
  a_chatter = [];
  a_chatter[a_chatter.size] = "pmc0_take_them_out_0";
  a_chatter[a_chatter.size] = "pmc0_we_have_orders_do_0";
  a_chatter[a_chatter.size] = "pmc0_stay_clear_of_the_bl_0";
  a_chatter[a_chatter.size] = "pmc0_defalco_has_begun_th_0";
  a_chatter[a_chatter.size] = "pmc0_fall_back_fall_bac_0";
  a_chatter[a_chatter.size] = "pmc0_keep_them_pinned_dow_0";
  a_chatter[a_chatter.size] = "pmc0_they_re_moving_up_0";
  a_chatter[a_chatter.size] = "pmc0_they_re_splitting_in_0";
  a_chatter[a_chatter.size] = "pmc0_bring_in_reinforceme_0";
  a_chatter[a_chatter.size] = "pmc0_chopper_s_inbound_0";
  a_chatter[a_chatter.size] = "pmc0_hold_the_high_ground_0";
  a_chatter[a_chatter.size] = "pmc0_stay_above_them_0";
  a_chatter[a_chatter.size] = "pmc0_prep_more_rpg_units_0";
  a_chatter[a_chatter.size] = "pmc0_flank_around_0";
  a_chatter[a_chatter.size] = "pmc0_draw_them_into_the_c_0";
  a_chatter[a_chatter.size] = "pmc0_stay_in_cover_0";
  a_chatter[a_chatter.size] = "pmc0_secure_the_upper_lev_0";
  a_chatter[a_chatter.size] = "pmc0_hold_this_line_0";
  a_chatter[a_chatter.size] = "pmc0_taking_fire_0";
  a_chatter[a_chatter.size] = "pmc0_man_down_0";
  a_chatter[a_chatter.size] = "pmc0_clear_the_area_0";
  a_chatter[a_chatter.size] = "pmc0_fall_back_to_the_eva_0";
  a_chatter[a_chatter.size] = "pmc0_ensure_defalco_gets_0";
  a_chatter[a_chatter.size] = "pmc0_they_re_not_slowing_0";
  a_chatter[a_chatter.size] = "pmc0_get_men_on_all_the_b_0";
  a_chatter[a_chatter.size] = "pmc0_we_need_to_halt_thei_0";
  a_chatter[a_chatter.size] = "pmc0_get_more_rpg_fire_on_0";
  a_chatter[a_chatter.size] = "pmc0_we_re_losing_too_man_0";
  a_chatter[a_chatter.size] = "pmc0_call_in_the_chopper_0";
  a_chatter[a_chatter.size] = "pmc0_prepare_for_emergenc_0";
  a_chatter[a_chatter.size] = "pmc0_taking_fire_1";
  a_chatter[a_chatter.size] = "pmc1_take_them_out_0";
  a_chatter[a_chatter.size] = "pmc1_we_have_orders_do_0";
  a_chatter[a_chatter.size] = "pmc1_stay_clear_of_the_bl_0";
  a_chatter[a_chatter.size] = "pmc1_defalco_has_begun_th_0";
  a_chatter[a_chatter.size] = "pmc1_fall_back_fall_bac_0";
  a_chatter[a_chatter.size] = "pmc1_keep_them_pinned_dow_0";
  a_chatter[a_chatter.size] = "pmc1_they_re_moving_up_0";
  a_chatter[a_chatter.size] = "pmc1_they_re_splitting_in_0";
  a_chatter[a_chatter.size] = "pmc1_bring_in_reinforceme_0";
  a_chatter[a_chatter.size] = "pmc1_chopper_s_inbound_0";
  a_chatter[a_chatter.size] = "pmc1_hold_the_high_ground_0";
  a_chatter[a_chatter.size] = "pmc1_stay_above_them_0";
  a_chatter[a_chatter.size] = "pmc1_prep_more_rpg_units_0";
  a_chatter[a_chatter.size] = "pmc1_flank_around_0";
  a_chatter[a_chatter.size] = "pmc1_draw_them_into_the_c_1";
  a_chatter[a_chatter.size] = "pmc1_stay_in_cover_0";
  a_chatter[a_chatter.size] = "pmc1_secure_the_upper_lev_0";
  a_chatter[a_chatter.size] = "pmc1_hold_this_line_0";
  a_chatter[a_chatter.size] = "pmc1_taking_fire_0";
  a_chatter[a_chatter.size] = "pmc1_man_down_0";
  a_chatter[a_chatter.size] = "pmc1_clear_the_area_0";
  a_chatter[a_chatter.size] = "pmc1_fall_back_to_the_eva_0";
  a_chatter[a_chatter.size] = "pmc1_ensure_defalco_gets_0";
  a_chatter[a_chatter.size] = "pmc1_they_re_not_slowing_0";
  a_chatter[a_chatter.size] = "pmc1_get_men_on_all_the_b_0";
  a_chatter[a_chatter.size] = "pmc1_we_need_to_halt_thei_0";
  a_chatter[a_chatter.size] = "pmc1_get_more_rpg_fire_on_0";
  a_chatter[a_chatter.size] = "pmc1_we_re_losing_too_man_0";
  a_chatter[a_chatter.size] = "pmc1_call_in_the_chopper_0";
  a_chatter[a_chatter.size] = "pmc1_prepare_for_emergenc_0";
  a_chatter[a_chatter.size] = "pmc1_taking_fire_1";
  a_chatter[a_chatter.size] = "pmc2_take_them_out_0";
  a_chatter[a_chatter.size] = "pmc2_we_have_orders_do_0";
  a_chatter[a_chatter.size] = "pmc2_stay_clear_of_the_bl_0";
  a_chatter[a_chatter.size] = "pmc2_defalco_has_begun_th_0";
  a_chatter[a_chatter.size] = "pmc2_fall_back_fall_bac_0";
  a_chatter[a_chatter.size] = "pmc2_keep_them_pinned_dow_0";
  a_chatter[a_chatter.size] = "pmc2_they_re_moving_up_0";
  a_chatter[a_chatter.size] = "pmc2_they_re_splitting_in_0";
  a_chatter[a_chatter.size] = "pmc2_bring_in_reinforceme_0";
  a_chatter[a_chatter.size] = "pmc2_chopper_s_inbound_0";
  a_chatter[a_chatter.size] = "pmc2_hold_the_high_ground_0";
  a_chatter[a_chatter.size] = "pmc2_stay_above_them_0";
  a_chatter[a_chatter.size] = "pmc2_prep_more_rpg_units_0";
  a_chatter[a_chatter.size] = "pmc2_flank_around_0";
  a_chatter[a_chatter.size] = "pmc2_draw_them_into_the_c_0";
  a_chatter[a_chatter.size] = "pmc2_stay_in_cover_0";
  a_chatter[a_chatter.size] = "pmc2_secure_the_upper_lev_0";
  a_chatter[a_chatter.size] = "pmc2_hold_this_line_0";
  a_chatter[a_chatter.size] = "pmc2_taking_fire_0";
  a_chatter[a_chatter.size] = "pmc2_man_down_0";
  a_chatter[a_chatter.size] = "pmc2_clear_the_area_0";
  a_chatter[a_chatter.size] = "pmc2_fall_back_to_the_eva_0";
  a_chatter[a_chatter.size] = "pmc2_ensure_defalco_gets_0";
  a_chatter[a_chatter.size] = "pmc2_they_re_not_slowing_0";
  a_chatter[a_chatter.size] = "pmc2_get_men_on_all_the_b_0";
  a_chatter[a_chatter.size] = "pmc2_we_need_to_halt_thei_0";
  a_chatter[a_chatter.size] = "pmc2_get_more_rpg_fire_on_0";
  a_chatter[a_chatter.size] = "pmc2_we_re_losing_too_man_0";
  a_chatter[a_chatter.size] = "pmc2_call_in_the_chopper_0";
  a_chatter[a_chatter.size] = "pmc2_prepare_for_emergenc_0";
  a_chatter[a_chatter.size] = "pmc2_taking_fire_1";

  while(a_chatter.size > 0) {
    str_line = random(a_chatter);
    arrayremovevalue(a_chatter, str_line);
    queue_dialog_enemy(str_line, 0, undefined, undefined, 0);
    wait(randomfloatrange(3, 10));
  }

  level thread pmc_chatter_dialog();
}

sec_evacuate() {
  wait 8.0;
  queue_dialog_ally("sec0_get_the_passengers_o_0");
  queue_dialog_ally("sec0_we_need_to_evacuate_0");
  queue_dialog_ally("sec0_keep_moving_0");
  queue_dialog_ally("sec0_run_do_not_slow_do_0");
  queue_dialog_ally("sec0_everyone_get_out_o_0");
  queue_dialog_ally("sec0_get_to_the_lifeboats_0");
}