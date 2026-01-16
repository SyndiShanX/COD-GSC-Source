/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_hallway.gsc
***********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\nicaragua_menendez_rage;
#include maps\_music;

skipto_menendez_hallway() {
  skipto_teleport_players("player_skipto_menendez_hallway");
  exploder(20);
  exploder(101);
  battlechatter_on("axis");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  model_removal_through_model_convert_system("menendez_lower_village");
  model_restore_area("menendez_execution");
  model_restore_area("menendez_stables_and_upper_village");
  model_convert("destructible_cocaine_bundles", "script_noteworthy");
  destructibles_in_area("menendez_execution");
  destructibles_in_area("menendez_stables_and_upper_village");
}

init_flags() {
  flag_init("nicaragua_hallway_complete");
}

main() {
  init_flags();
  level thread nicaragua_hallway_objectives();
  level thread nicaragua_to_misssion_animations();
  level.player thread menendez_hallway_vo();
  debug_print_line("Nicaragua Hallway");
  model_restore_area("mason_final_push");
  flag_wait("nicaragua_hallway_complete");
  kill_spawnernum(6);
  wait 3;
  level thread nicaragua_interstial_movie("nicaragua_int_1");
  flag_set("menendez_section_done");
  flag_set("menendez_section_playthrough_complete");
  model_convert_area("mason_final_push");
}

menendez_hallway_vo() {
  trigger_wait("trig_obj_save_josefina");
  rage_mode_important_vo("mene_i_m_here_josefina_0");
}

nicaragua_hallway_objectives() {
  level thread objective_breadcrumb(level.obj_menendez_save_josefina, "trig_obj_save_josefina");
  flag_wait("shattered_1_started");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  level waittill("shattered_1_done");
  set_objective(level.obj_menendez_save_josefina, undefined, "delete");
}

nicaragua_to_misssion_animations() {
  trigger_wait("rage_trigger_stairs");
  t_sanity_check = get_ent("stair_anim_sanity_check_trigger", "targetname", 1);
  a_guys_in_room = get_ai_touching_volume("axis", undefined, t_sanity_check);
  level thread load_gump("nicaragua_gump_josefina");
  m_door = getent("josephina_door", "targetname");
  m_door hide();
  trigger_wait("mansion_menendez_meets_mason_trigger", "script_noteworthy");
  exploder(590);
  setmusicstate("NIC_RAGE_OVER");
  spawn_managers_kill_all_active();
  level thread kill_all_ai(0.05, 0.5);
  flag_wait("nicaragua_gump_josefina");
  level thread run_scene("shattered_1");
  level waittill("shattered_1_done");
  screen_fade_out(0.25, "white");
  stop_exploder(20);
  stop_exploder(590);
  level.player rage_disable();
  level.player disableweapons();
  level.player.b_weapons_disabled = 1;
  level.player hide_hud();
  m_door show();
  m_door = getent("shattered_part2_door", "targetname");
  m_door.angles = (0, 0, 0);
  a_ai = getaiarray();

  foreach(ai_alive in a_ai) {
    ai_alive stop_magic_bullet_shield();
    ai_alive die();
  }

  fxanim_deconstructions_for_menendez_side();
  model_delete_area("menendez_execution");
  model_delete_area("menendez_stables_and_upper_village");
  menendez_chickens_cleanup();
  m_scorch_marks = getent("josefina_hall_scorch", "targetname");
  m_scorch_marks hide();
  m_clip = getent("traversal_to_other_side_clip", "targetname");
  m_clip connectpaths();
  wait 0.15;
  m_clip delete();
  level.player visionsetnaked("sp_nicaragua_default", 2);
  flag_set("nicaragua_hallway_complete");
}

menendez_chickens_cleanup() {
  a_chickens = getentarray("menendez_chicken", "targetname");

  foreach(m_chicken in a_chickens)
  m_chicken thread chicken_cleanup();
}

shattered_1_slow_mo_start(m_player_body) {
  rpc("clientscripts/nicaragua_amb", "hallway_fire");
  timescale_tween(1, 0.05, 0.05);
}

shattered_1_slow_mo_end(m_player_body) {
  level clientnotify("snd_shattered");
  timescale_tween(0.05, 1, 0.05);
}

shattered_1_explosion(m_player_body) {
  exploder(595);
  level.player playrumbleonentity("artillery_rumble");
  level notify("shattered_1_done");
}