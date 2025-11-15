/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_shattered.gsc
**********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_audio;

skipto_mason_shattered() {
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_shattered", get_heroes());
  set_objective(level.obj_mason_find_menendez);
  e_door = getent("josephina_door", "targetname");
  e_door delete();
  exploder(101);
  exploder(590);
  level clientnotify("fr_on");
  exploder(10);
  setsaveddvar("cg_aggressiveCullRadius", "500");
  e_door1 = getent("shattered_part2_door", "targetname");
  e_door1 delete();
  e_door2 = getent("josephina_hallway_door", "targetname");
  e_door2 delete();
  model_removal_through_model_convert_system("mason_hill_1");
  model_removal_through_model_convert_system("mason_hill_2");
  model_removal_through_model_convert_system("mason_mission");
  model_removal_through_model_convert_system("mason_bunker");
  model_restore_area("mason_final_push");
}

init_flags() {
  flag_init("nicaragua_mason_shattered_compelte");
  flag_init("shattered_part_two_scene_started");
}

main() {
  load_gump("nicaragua_gump_josefina");
  init_flags();
  level thread nicaragua_mason_shattered_objectives();
  level thread maps\_audio::switch_music_wait("NIC_WOODS_FATEFUL_GRENADE", 2);
  shattered_part_two();
  flag_wait("nicaragua_mason_shattered_compelte");
}

nicaragua_mason_shattered_objectives() {
}

shattered_part_two() {
  flag_set("shattered_part_two_scene_started");
  level thread run_scene("mason_shattered_part2");
  a_ai_pdf = get_ai_group_ai("mason_finalpush_factionfight_pdf");

  foreach(guy in a_ai_pdf)
  guy delete();

  a_ai_cartel = get_ai_group_ai("mason_finalpush_factionfight_cartel");

  foreach(guy in a_ai_cartel)
  guy delete();

  scene_wait("mason_shattered_part2");
  level.player hide_hud();
  delete_scene("mason_shattered_part2");
  flag_set("nicaragua_mason_shattered_compelte");
}

woods_fires_gun(e_woods) {
  level.player thread rumble_loop(1, 0.05, "damage_light");
}

woods_headbutt(m_player_body) {
  level.player disableinvulnerability();
  level.player dodamage(80, level.woods.origin);
  earthquake(0.5, 0.75, level.player.origin, 1024);
  level.player thread rumble_loop(15, 0.05, "damage_heavy");
  level.player shellshock("mason_shattered", 2.0);
  level.player enableinvulnerability();
}

shattered_part_two_timescale_slow(m_player_body) {
  rpc("clientscripts/nicaragua_amb", "shattered2");
  settimescale(0.2);
}

shattered_part_two_timescale_normal(m_player_body) {
  settimescale(1.0);
}

shattered_part_two_headlook_off(m_player_body) {
  level.player playerlinktodelta(level.player.m_scene_model, "tag_player", 0, 0, 0, 0, 0, 0, 0);
  level.player setplayerviewratescale(1);
}

shattered_part_two_grenade_explosion(m_player_body) {
  exploder(595);
  level thread screen_fade_out(0.25, "white");
  earthquake(0.5, 0.25, level.player.origin, 1024);
  level.player thread rumble_loop(5, 0.05, "grenade_rumble");
}