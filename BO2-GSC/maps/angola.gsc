/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\angola_utility;
#include maps\angola_fx;
#include maps\_load;
#include maps\_drones;
#include maps\_mortarteam;
#include maps\angola_amb;
#include maps\angola_anim;
#include maps\_mpla_unita;
#include maps\createart\angola_art;
#include maps\angola_savannah;
#include maps\angola_riverbed;

main() {
  maps\angola_fx::main();
  setup_objectives();
  melee_mpla_init();
  level_precache();
  level_init_flags();
  setup_skipto();
  level.custom_introscreen = ::angola_custom_introscreen;
  maps\_load::main();
  maps\_drones::init();
  maps\_mortarteam::main();
  maps\angola_amb::main();
  maps\angola_anim::main();
  onplayerconnect_callback(::on_player_connect);
  array_thread(getspawnerarray(), ::add_spawn_function, maps\_mpla_unita::setup_mpla);
  level thread maps\_objectives::objectives();
  level thread maps\createart\angola_art::main();
  level thread setup_challenges();
  level.callbackactorkilled = ::angola_challenge_actor_killed_callback;
  level.num_heli_runs = 0;
  level.tank_kill_count = 0;
  level.mortar_kills = 0;
  level.drones.death_func = ::drone_savannahdeath;
  setsaveddvar("cg_aggressiveCullRadius", "100");
  setsaveddvar("ragdoll_reactivation_cutoff", "0");
  setsaveddvar("disable_drone_footsteps", "1");
  drones_set_max_ragdolls(0);
  riverbed_blocker = getent("riverbed_blocker", "targetname");
  riverbed_blocker notsolid();
  level thread maps\angola_savannah::show_savannah_rocks();
}

on_player_connect() {
  setsaveddvar("aim_target_fixed_actor_size", 1);
}

setup_skipto() {
  add_skipto("riverbed_intro", maps\angola_riverbed::skipto_riverbed_intro, "Riverbed Intro", maps\angola_riverbed::riverbed_intro);
  add_skipto("riverbed", maps\angola_riverbed::skipto_riverbed, "Riverbed", maps\angola_riverbed::riverbed);
  add_skipto("savannah_start", maps\angola_savannah::skipto_savannah_start, "Savannah Start", maps\angola_savannah::savannah_start);
  add_skipto("savannah_hill", maps\angola_savannah::skipto_savannah_hill, "Savannah Hill", maps\angola_savannah::savannah_hill);
  add_skipto("savannah_finish", maps\angola_savannah::skipto_savannah_finish, "Savannah Finish", maps\angola_savannah::savannah_finish);
  add_skipto("river", ::angola_2_skipto);
  add_skipto("heli_jump", ::angola_2_skipto);
  add_skipto("barge_defend", ::angola_2_skipto);
  add_skipto("container", ::angola_2_skipto);
  add_skipto("jungle_stealth", ::angola_2_skipto);
  add_skipto("jungle_stealth_log", ::angola_2_skipto);
  add_skipto("jungle_stealth_house", ::angola_2_skipto);
  add_skipto("village", ::angola_2_skipto);
  add_skipto("jungle_escape", ::angola_2_skipto);
  add_skipto("jungle_ending", ::angola_2_skipto);
  default_skipto("riverbed_intro");
  set_skipto_cleanup_func(maps\angola_utility::skipto_setup);
}

angola_2_skipto() {
  changelevel("angola_2", 1);
}

level_precache() {
  precachemodel("t6_wpn_mortar_shell_prop_view");
  precachemodel("t6_wpn_launch_mm1_world");
  precachemodel("t6_wpn_ar_fal_prop_world");
  precachemodel("p6_tool_shovel");
  precachemodel("veh_t6_mil_buffelapc_windshield_cracked01");
  precachemodel("veh_t6_mil_buffelapc_windshield_cracked02");
  precachemodel("veh_t6_mil_buffelapc_windshield_cracked03");
  precachemodel("veh_t6_mil_buffelapc_windshield_cracked04");
  precachemodel("veh_t6_mil_buffelapc_windshield_cracked05");
  precachemodel("anim_jun_radio_headset_b");
  precachemodel("t6_wpn_machete_prop");
  precachemodel("t6_wpn_ar_ak47_prop");
  precachemodel("fxanim_angola_heli_gear_mod");
  precachemodel("mil_ammo_case_anim_1");
  precachemodel("veh_t6_mil_gaz66_cargo_door_left");
  precachemodel("veh_t6_mil_gaz66_cargo_door_right");
  precacheitem("mgl_sp");
  precacheitem("mortar_shell_dpad_sp");
  precacheitem("air_support_radio_sp");
  precacheitem("rpg_player_sp");
  precacherumble("damage_light");
  precacherumble("damage_heavy");
  precacherumble("angola_hind_ride");
}

angola_custom_introscreen(level_prefix, number_of_lines, totaltime, text_color) {
  introblack = newhudelem();
  introblack.x = 0;
  introblack.y = 0;
  introblack.horzalign = "fullscreen";
  introblack.vertalign = "fullscreen";
  introblack.foreground = 1;
  introblack setshader("black", 640, 480);
  flag_wait("all_players_connected");
  wait 0.2;
  introblack fadeovertime(0.5);
  introblack.alpha = 0;
  wait 0.5;
  introblack destroy();
  flag_wait("show_introscreen_title");
  luinotifyevent(&"hud_add_title_line", 4, level_prefix, number_of_lines, totaltime, text_color);
  waittill_textures_loaded();
  wait 2.5;
  level notify("introscreen_done");
}