/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_3.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\panama_utility;
#include maps\panama_3_fx;
#include maps\_load;
#include maps\panama_3_amb;
#include maps\panama_3_anim;
#include maps\createart\panama3_art;
#include maps\_digbats;
#include maps\_objectives;
#include maps\_mig17;
#include maps\panama_building;
#include maps\panama_chase;
#include maps\panama_docks;
#include maps\_challenges_sp;

main() {
  maps\panama_3_fx::main();
  level_precache();
  level_init_flags();
  setup_skiptos();
  level.supportspistolanimations = 1;
  maps\_load::main();
  maps\panama_3_amb::main();
  maps\panama_3_anim::main();
  screen_fade_out(0, undefined, 1);
  onplayerconnect_callback(::on_player_connect);
  maps\createart\panama3_art::main();
  maps\_digbats::melee_digbat_init();
  array_thread(getspawnerarray(), ::add_spawn_function, maps\_digbats::setup_digbat);
  level thread setup_global_challenges();
  level thread setup_objectives();
  level thread maps\_objectives::objectives();
  level._vehicle_load_lights = 1;
  add_hint_string("player_jump_hint", & "PANAMA_PLAYER_JUMP_PROMPT");
  add_hint_string("docks_warning", & "PANAMA_DOCKS_WARNING");
}

on_player_connect() {
  self thread setup_section_challenges();
}

level_precache() {
  precacheitem("barretm82_sp");
  precacheitem("ac130_vulcan_minigun");
  precacheitem("rpg_magic_bullet_sp");
  precacheitem("m1911_1handed_sp");
  precacheitem("barretm82_highvzoom_sp");
  precacheitem("rpg_player_sp");
  precacherumble("angola_hind_ride");
  precacherumble("heartbeat");
  precacherumble("heartbeat_low");
  precachemodel("c_usa_woods_panama_lower_dmg1_viewbody");
  precachemodel("c_usa_woods_panama_lower_dmg2_viewbody");
  precachemodel("veh_iw_mh6_littlebird");
  precachemodel("t6_wpn_machete_prop");
  precachemodel("veh_iw_hummer_opentop");
  precachemodel("c_usa_captured_mason_head_normal");
  precachemodel("p6_wooden_chair_02_anim");
  precachemodel("t6_wpn_shotty_spas_prop_world");
  precachemodel("c_mul_redcross_nurse_wnded_body");
  precachemodel("c_usa_captured_mason_sack");
  precachemodel("fxanim_panama_necklace_mod");
  precachemodel("p6_anim_military_id_card");
  precachemodel("c_usa_panama_hudson_lower_rknee");
  precachemodel("c_usa_panama_hudson_lower_bknees");
  precachemodel("c_usa_panama_hudson_head_cut");
  precachemodel("c_usa_woods_panama_lower_dmg1_viewbody");
  precachemodel("c_usa_captured_mason_sack_clean");
  precachemodel("t6_wpn_ir_strobe_world");
  precacheitem("irstrobe_dpad_sp");
  precacheitem("nightingale_dpad_sp");
  precacheshader("cinematic2d");
  precacherumble("slide_rumble");
  precachestring(&"PANAMA_SNIPER_FAIL");
  maps\_mig17::mig_setup_bombs("plane_mig23");
}

setup_skiptos() {
  add_skipto("house", ::skipto_panama, "House");
  add_skipto("zodiac", ::skipto_panama, "Zodiac Approach");
  add_skipto("beach", ::skipto_panama, "Beach");
  add_skipto("runway", ::skipto_panama, "Runway Standoff");
  add_skipto("learjet", ::skipto_panama, "Lear Jet");
  add_skipto("motel", ::skipto_panama, "Motel");
  add_skipto("slums_intro", ::skipto_panama_2, "Slums Intro");
  add_skipto("slums_main", ::skipto_panama_2, "Slums Main");
  add_skipto("building", maps\panama_building::skipto_building, "Building", maps\panama_building::main);
  add_skipto("chase", maps\panama_chase::skipto_chase, "Chase", maps\panama_chase::main);
  add_skipto("checkpoint", maps\panama_chase::skipto_checkpoint, "Checkpoint", maps\panama_chase::checkpoint_event);
  add_skipto("docks", maps\panama_docks::skipto_docks, "Docks", maps\panama_docks::main);
  add_skipto("sniper", maps\panama_docks::skipto_sniper, "Sniper");
  add_skipto("Betrayal", maps\panama_docks::skipto_betrayal, "Betrayal", maps\panama_docks::kick_off_betrayal_event);
  default_skipto("building");
  set_skipto_cleanup_func(maps\panama_utility::skipto_setup);
}

skipto_panama() {
  changelevel("panama", 1);
}

skipto_panama_2() {
  changelevel("panama_2", 1);
}

setup_section_challenges() {
  self thread maps\_challenges_sp::register_challenge("clinicassault", ::challenge_docks_guards_speed_kill);
}

challenge_docks_guards_speed_kill(str_notify) {
  level.total_digbat_killed = 0;
  level waittill("end_gauntlet");

  iprintln("total digbat killed : " + level.total_digbat_killed);

  if(level.total_digbat_killed >= 8)
    self notify(str_notify);
}