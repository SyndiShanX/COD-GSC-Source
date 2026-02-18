/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_af_wreck.gsc
***********************************************/

#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_61cfc2ab8e60625;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;
#namespace tkdn_af_wreck;

function starting(var_d3440450) {
  namespace_b100dd86::function_5aabc3fb();
  flag::set("af_skid_complete");
  level.arash = spawner::simple_spawn_single("arash");
  exploder::exploder("hit3_pcrash_enginefire_end");
  exploder::exploder("airfield_crash_lighting");
  thread namespace_a052577e::function_fc52119f();
  level.var_c0c469ea = 3;
  namespace_82bfe441::fade(1, "FadeImmediate");
}

function main(var_d3440450, var_50cc0d4f) {
  if(!isalive(level.arash)) {
    level.arash = spawner::simple_spawn_single("arash");
    level.arash namespace_979752dc::function_2324f175(0);
    level.arash.ignoreall = 1;
  }

  plane = getent("cargo_plane", "targetname");
  var_853687bd = getEntArray("af_plane_triggers", "targetname");
  var_853687bd = arraycombine(var_853687bd, getEntArray("plane_floor_clip", "targetname"));
  var_853687bd = arraycombine(var_853687bd, getEntArray("plane_cargo", "targetname"));

  foreach(thing in var_853687bd) {
    thing delete();
  }

  probes = ["cargo_probe_1", "cargo_probe_2", "cargo_probe_3", "cargo_probe_4", "cargo_probe_5", "cargo_probe_6", "cargo_probe_7", "cargo_probe_8", "cargo_probe_9"];

  foreach(probe in probes) {
    probe = getent(probe, "targetname");

    if(isDefined(probe)) {
      probe unlink();
      probe.origin -= (0, 0, 10000);
    }
  }

  player = getplayers()[0];
  player setmovespeedscale(0.4);
  player util::function_749362d7(1);
  exploder::exploder("hit3_pcrash_end_embers");
  exploder::exploder("airfield_crash_lighting");
  exploder::exploder("hit3_pcrash_end_embers_02");
  level thread function_fa3409bb();
  player clientfield::set_to_player("set_player_pbg_bank", 1);
  thread namespace_a052577e::function_cbae87a2();
  arash = getactorarray("arash", "targetname")[0];
  arash.var_c681e4c1 = 1;
  music::setmusicstate("b7.0_aftermath");
  level thread scene::play("scene_tkd_hit3_outro_interrogation", [arash]);
  level thread function_ea2f2e25(var_50cc0d4f);
  level waittill(#"hash_285b0696c88c644a");
  thread namespace_a052577e::function_4788a209();
  objectives::complete("obj_arash");
  objectives::complete("send_message");
  wait 1;
  level lui::screen_fade_out(2.5);

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }

  wait 1;
  level flag::set("af_hit3_interrogation_complete");
  function_91d49d23(level.adler);
  function_91d49d23(level.woods);
  function_91d49d23(level.arash);
  guys = getaiarray();
  array::delete_all(guys);
  player val::set(#"ending", "disable_weapon_cycling", 1);
  player val::set(#"ending", "disable_weapons", 1);
  player val::set(#"ending", "allow_jump", 0);
  player val::set(#"ending", "allow_sprint", 0);
  level lui::screen_fade_out(0);
  player_decision::function_430ebd4b(3, 1);
  player_decision::function_8c0836dd(0);
  skipto::function_1c2dfc20("cp_ger_hub", "character_creation");
}

function function_fa3409bb() {
  level flag::wait_till("af_hit3_interrogation_complete");
  exploder::kill_exploder("hit3_pcrash_end_embers");
  exploder::kill_exploder("airfield_crash_lighting");
  exploder::kill_exploder("hit3_pcrash_end_embers_02");
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("af_wreck_complete");
  level flag::init("af_hit3_interrogation_complete");
}

function init_clientfields() {
  clientfield::register("world", "wreck_volume_decals", 1, 1, "int");
  clientfield::register("world", "crash_models", 1, 1, "int");
  clientfield::register("toplayer", "set_player_pbg_bank", 1, 1, "int");
  clientfield::register("toplayer", "wreck_vision", 1, 1, "int");
}

function function_22b7fffd() {}

function function_cf191fff() {}

function function_91d49d23(guy) {
  if(isDefined(guy)) {
    util::stop_magic_bullet_shield(guy);
    guy delete();
  }
}

function function_70dd6f0e() {
  wreck_models = getEntArray("wreck_models", "targetname");

  if(isDefined(wreck_models)) {
    foreach(model in wreck_models) {
      model notsolid();
      model hide();
    }
  }

  level flag::wait_till("af_skid_complete");

  if(isDefined(wreck_models)) {
    foreach(model in wreck_models) {
      model solid();
      model show();
    }
  }

  level clientfield::set("wreck_volume_decals", 1);
}

function function_ea2f2e25(var_50cc0d4f) {
  adler = getactorarray("af_adler", "targetname")[0];
  adler hide();
  player = getplayers()[0];
  setDvar(#"hash_252e699c41531f1a", 0);
  player clientfield::set_to_player("wreck_vision", 1);

  if(is_true(var_50cc0d4f)) {
    wait level.var_c0c469ea + 0.55;
  } else {
    wait 0.55;
    level lui::screen_fade_in(3);
  }

  thread namespace_a052577e::function_bee54a20();
  wait 0.5;
  level lui::screen_fade_out(3);
  adler show();
  wait 1;
  level lui::screen_fade_in(12);
}