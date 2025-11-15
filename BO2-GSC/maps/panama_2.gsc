/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_2.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\panama_utility;
#include maps\yemen_wounded;
#include maps\panama_2_fx;
#include maps\_hiding_door;
#include maps\_load;
#include maps\panama_2_amb;
#include maps\panama_2_anim;
#include maps\createart\panama_art;
#include animscripts\dog_init;
#include maps\_digbats;
#include maps\_drones;
#include maps\_civilians;
#include maps\_objectives;
#include maps\_mig17;
#include maps\panama_slums;
#include maps\_challenges_sp;

main() {
  maps\panama_2_fx::main();
  level_precache();
  level_init_flags();
  setup_skiptos();
  level.overrideactordamage = ::actor_ac130_damage_override;
  maps\_hiding_door::door_main();
  maps\_hiding_door::window_main();
  level.supportspistolanimations = 1;
  maps\_load::main();
  maps\panama_2_amb::main();
  maps\panama_2_anim::main();
  level.spawn_manager_max_ai = 30;
  onplayerconnect_callback(::on_player_connect);
  maps\createart\panama_art::main();
  animscripts\dog_init::initdoganimations();
  maps\_digbats::melee_digbat_init();
  maps\_drones::init();
  maps\_civilians::init_civilians();
  array_thread(getspawnerarray(), ::add_spawn_function, maps\_digbats::setup_digbat);
  level thread setup_global_challenges();
  level thread setup_objectives();
  level thread maps\_objectives::objectives();
  level._vehicle_load_lights = 1;
}

on_player_connect() {
  setup_section_challenges();
}

level_precache() {
  precacheitem("ac130_vulcan_minigun");
  precacheitem("ac130_howitzer_minigun");
  precacheitem("rpg_magic_bullet_sp");
  precacheitem("rpg_player_sp");
  precacheitem("irstrobe_dpad_sp");
  precacheitem("nightingale_dpad_sp");
  precacheitem("ak47_gl_sp");
  precacheitem("gl_ak47_sp");
  precacheitem("rpg_sp");
  precacheitem("napalmblob_sp");
  precachemodel("t6_wpn_molotov_cocktail_prop_world");
  precachemodel("t6_wpn_crowbar_prop");
  precachemodel("c_pan_noriega_sack");
  precachemodel("c_pan_noriega_cap");
  precachemodel("c_pan_noriega_head_sack");
  precacheshader("cinematic2d");
  maps\_mig17::mig_setup_bombs("plane_mig23");
}

setup_skiptos() {
  add_skipto("house", ::skipto_panama, "House");
  add_skipto("zodiac", ::skipto_panama, "Zodiac Approach");
  add_skipto("beach", ::skipto_panama, "Beach");
  add_skipto("runway", ::skipto_panama, "Runway Standoff");
  add_skipto("learjet", ::skipto_panama, "Lear Jet");
  add_skipto("motel", ::skipto_panama, "Motel");
  add_skipto("slums_intro", maps\panama_slums::skipto_slums_intro, "Slums Intro", maps\panama_slums::intro);
  add_skipto("slums_main", maps\panama_slums::skipto_slums_main, "Slums Main", maps\panama_slums::main);
  add_skipto("building", ::skipto_panama_3, "Building");
  add_skipto("chase", ::skipto_panama_3, "Chase");
  add_skipto("checkpoint", ::skipto_panama_3, "Checkpoint");
  add_skipto("docks", ::skipto_panama_3, "Docks");
  add_skipto("sniper", ::skipto_panama_3, "Sniper");
  default_skipto("slums_intro");
  set_skipto_cleanup_func(maps\panama_utility::skipto_setup);
}

skipto_panama() {
  changelevel("panama", 1);
}

skipto_panama_3() {
  changelevel("panama_3", 1);
}

setup_section_challenges() {
  self thread maps\_challenges_sp::register_challenge("destroyzpu", maps\panama_slums::challenge_destroy_zpu);
  self thread maps\_challenges_sp::register_challenge("irstrobe", maps\panama_slums::challenge_irstrobe_kill);
}

actor_ac130_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(self.team == "axis" && sweapon == "ac130_vulcan_minigun")
    level.ac130_irstrobe_kills++;

  return idamage;
}

onplayerkilled_strobe(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(sweapon == "ac130_vulcan_minigun") {
  }
}