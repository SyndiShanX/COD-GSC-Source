/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\panama_utility;
#include maps\panama_fx;
#include maps\_load;
#include maps\panama_amb;
#include maps\panama_anim;
#include maps\createart\panama_art;
#include maps\_stealth_logic;
#include maps\_stealth_behavior;
#include maps\_swimming;
#include maps\_objectives;
#include maps\panama_house;
#include maps\_mig17;
#include maps\panama_airfield;
#include maps\panama_motel;
#include maps\_challenges_sp;

main() {
  maps\panama_fx::main();
  level_precache();
  level_init_flags();
  setup_skiptos();
  level.custom_introscreen = ::panama_custom_introscreen;
  maps\_load::main();
  maps\panama_amb::main();
  maps\panama_anim::main();
  onplayerconnect_callback(::on_player_connect);
  maps\createart\panama_art::main();
  maps\_stealth_logic::stealth_init();
  maps\_stealth_behavior::main();
  maps\_swimming::main();
  level._vehicle_load_lights = 1;
  setsaveddvar("cg_aggressiveCullRadius", "100");
  setsaveddvar("phys_ragdoll_buoyancy", 1);
  setsaveddvar("vehicle_riding", 0);
  level thread setup_global_challenges();
  level thread setup_objectives();
  level thread maps\_objectives::objectives();
  level thread maps\panama_house::panama_wind_settings();
  add_hint_string("open_grate", & "PANAMA_OPEN_GRATE");
  add_hint_string("contextual_kill", & "PANAMA_CONTEXTUAL_KILL");
  add_hint_string("street_warning", & "PANAMA_STREET_WARNING");
  add_hint_string("hangar_warning", & "PANAMA_HANGAR_WARNING");
  add_hint_string("player_jump_hint", & "PANAMA_PLAYER_JUMP_PROMPT");
  add_hint_string("docks_warning", & "PANAMA_DOCKS_WARNING");
  setsaveddvar("vehicle_selfCollision", 0);
}

on_player_connect() {
  self thread setup_section_challenges();
  wait 0.15;
  self thread stealth_ai();
}

panama_custom_introscreen(level_prefix, number_of_lines, totaltime, text_color) {
  introblack = newhudelem();
  introblack.x = 0;
  introblack.y = 0;
  introblack.horzalign = "fullscreen";
  introblack.vertalign = "fullscreen";
  introblack.foreground = 1;
  introblack setshader("black", 640, 480);
  flag_wait("all_players_connected");
  introblack thread intro_hud_fadeout();
  flag_wait("show_introscreen_title");
  luinotifyevent(&"hud_add_title_line", 4, level_prefix, number_of_lines, totaltime, text_color);
  waittill_textures_loaded();
  wait 2.5;
  level notify("introscreen_done");
}

intro_hud_fadeout() {
  wait 0.2;
  self fadeovertime(0.5);
  self.alpha = 0;
  wait 0.5;
  self destroy();
}

level_precache() {
  precacheitem("ac130_vulcan_minigun");
  precacheitem("ac130_howitzer_minigun");
  precacheitem("rpg_magic_bullet_sp");
  precacheitem("rpg_player_sp");
  precacheitem("ak47_sp");
  precacheitem("knife_held_80s_sp");
  precacheitem("rpg_sp");
  precacheitem("m1911_sp");
  precacheitem("nightingale_dpad_sp");
  precacheitem("apache_rockets");
  precachemodel("anim_jun_ammo_box");
  precachemodel("veh_iw_hummer_win_xcam");
  precachemodel("p6_graffiti_card");
  precachemodel("p_glo_spray_can");
  precachemodel("t6_wpn_knife_sog_prop_view");
  precachemodel("c_usa_woods_panama_casual_viewbody");
  precachemodel("c_usa_milcas_woods_hair");
  precachemodel("c_usa_milcas_woods_hair_cap");
  precachemodel("p6_anim_beer_can");
  precachemodel("p6_patio_table_teak");
  precachemodel("c_usa_seal80s_skinner_fb");
  precacheshader("cinematic2d");
  precachemodel("p6_anim_cloth_pajamas");
  precachemodel("p6_anim_duffle_bag");
  precachemodel("c_usa_jungmar_pow_barnes");
  precachemodel("p6_anim_beer_pack");
  precachemodel("c_usa_jungmar_barnes_pris_body");
  precachemodel("c_usa_jungmar_barnes_pris_head");
  precachemodel("p6_anim_cocaine");
  precachemodel("t6_wpn_flare_gun_prop");
  precachemodel("veh_t6_air_private_jet");
  precachemodel("veh_t6_air_private_jet_dead");
  precachemodel("c_usa_woods_panama_lower_dmg2_viewbody");
  precachemodel("t5_weapon_sog_knife_viewmodel");
  precachemodel("p6_anim_flak_jacket");
  maps\_mig17::mig_setup_bombs("plane_mig23");
}

setup_skiptos() {
  add_skipto("house", maps\panama_house::skipto_house, "House", maps\panama_house::main);
  add_skipto("zodiac", maps\panama_airfield::skipto_zodiac, "Zodiac Approach", maps\panama_airfield::zodiac_approach_main);
  add_skipto("beach", maps\panama_airfield::skipto_beach, "Beach", maps\panama_airfield::beach_main);
  add_skipto("runway", maps\panama_airfield::skipto_runway, "Runway Standoff", maps\panama_airfield::runway_standoff_main);
  add_skipto("learjet", maps\panama_airfield::skipto_learjet, "Lear Jet", maps\panama_airfield::learjet_main);
  add_skipto("motel", maps\panama_motel::skipto_motel, "Motel", maps\panama_motel::main);
  add_skipto("slums_intro", ::skipto_panama_2, "Slums Intro");
  add_skipto("slums_main", ::skipto_panama_2, "Slums Main");
  add_skipto("building", ::skipto_panama_3, "Building");
  add_skipto("chase", ::skipto_panama_3, "Chase");
  add_skipto("checkpoint", ::skipto_panama_3, "Checkpoint");
  add_skipto("docks", ::skipto_panama_3, "Docks");
  add_skipto("sniper", ::skipto_panama_3, "Sniper");
  default_skipto("house");
  set_skipto_cleanup_func(maps\panama_utility::skipto_setup);
}

skipto_panama_2() {
  changelevel("panama_2", 1);
}

skipto_panama_3() {
  changelevel("panama_3", 1);
}

setup_section_challenges() {
  self thread maps\_challenges_sp::register_challenge("thinkfast", maps\panama_airfield::challenge_thinkfast);
  self thread maps\_challenges_sp::register_challenge("flak_jacket", maps\panama_airfield::challenge_kill_ai_with_flak_jacket);
  self thread maps\_challenges_sp::register_challenge("destroylearjet", maps\panama_airfield::challenge_destroy_learjet);
  self thread maps\_challenges_sp::register_challenge("turretkill", maps\panama_airfield::challenge_turret_kill);
}