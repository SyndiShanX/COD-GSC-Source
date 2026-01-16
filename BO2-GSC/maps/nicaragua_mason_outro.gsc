/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_outro.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_vehicle;

skipto_mason_outro() {
  level thread screen_fade_out(0, "white");
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_outro", get_heroes());
  exploder(101);
  exploder(10);
  setsaveddvar("cg_aggressiveCullRadius", "500");
  model_removal_through_model_convert_system("mason_hill_1");
  model_removal_through_model_convert_system("mason_hill_2");
  model_removal_through_model_convert_system("mason_mission");
  model_removal_through_model_convert_system("mason_bunker");
  model_restore_area("mason_final_push");
}

init_flags() {
  flag_init("begin_outro_fade_out");
}

main() {
  model_delete_area("mason_final_push");
  model_restore_area("mason_outro");
  load_gump("nicaragua_gump_outro");
  autosave_by_name("mason_outro_start");
  init_flags();
  level thread nicaragua_mason_outro_objectives();
  play_nicaragua_outro();
  level.player notify("mission_finished");
  nextmission();
}

nicaragua_mason_outro_objectives() {
  flag_wait("mason_outro_started");
  set_objective(level.obj_mason_find_menendez, undefined, "done");
}

play_nicaragua_outro() {
  level.player takeallweapons();
  level.player setmovespeedscale(0.25);
  level.player allowsprint(0);
  level.player allowjump(0);
  exploder(690);
  level clientnotify("snd_shattered_2");
  mason_outro_white_screen_vo();
  level thread screen_fade_in(3, "white");
  level.player show_hud();
  level.player shellshock("mason_outro", 15);
  level thread mason_outro_helicopter();
  level thread run_scene("mason_outro");
  flag_wait("mason_outro_started");
  level thread outro_wind_snd();
  ai_hudson = getent("hudson_ai", "targetname");
  ai_hudson detach("c_usa_nicaragua_hudson_glasses");
  flag_wait("begin_outro_fade_out");
  clientnotify("outro_fade_white");
  screen_fade_out(0.5, "white");
  wait 0.5;
}

outro_wind_snd() {
  wait 2;
  wind_ent = spawn("script_origin", (0, 0, 0));
  wind_ent playloopsound("amb_nic_outro_wind", 8);
}

mason_outro_helicopter() {
  veh_heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mason_outro_heli");
  veh_heli waittill("mason_outro_heli_fadeout");
  stop_exploder(690);
  exploder(699);
}

start_outro_fade(m_player_body) {
  flag_set("begin_outro_fade_out");
}

mason_outro_white_screen_vo() {
  e_org = getent("mason_outro_pa_voice", "targetname");
  e_org queue_dialog("pa_attention_0", 0.5);
  e_org queue_dialog("pa_this_area_is_now_und_0", 0.5);
  e_org queue_dialog("pa_any_members_of_the_c_0", 0.5);
  e_org queue_dialog("pa_this_in_your_only_wa_0", 0.5);
}

mason_outro_cleanup() {
  kill_spawnernum(19);
}