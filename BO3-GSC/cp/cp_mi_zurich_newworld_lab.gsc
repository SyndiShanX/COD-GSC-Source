/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_zurich_newworld_lab.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_load;
#using scripts\cp\_objectives;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_zurich_newworld;
#using scripts\cp\cp_mi_zurich_newworld_sound;
#using scripts\cp\cp_mi_zurich_newworld_train;
#using scripts\cp\cp_mi_zurich_newworld_util;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace newworld_lab;

function dev_lab_init(str_objective, b_starting) {
  level flag::wait_till("all_players_spawned");
  skipto::teleport("waking_up_igc");
}

function skipto_waking_up_igc_init(str_objective, b_starting) {
  if(b_starting) {
    load::function_73adcefc();
    newworld_train::function_c63fb1d();
    load::function_c32ba481();
    level thread newworld_util::function_30ec5bf7(1);
  }
  newworld_util::player_snow_fx();
  level scene::init("cin_new_17_01_wakingup_1st_reveal");
  level scene::init("p7_fxanim_cp_newworld_curtain_bundle");
  util::set_streamer_hint(10);
  newworld_util::function_83a7d040();
  util::streamer_wait();
  function_c3e8639();
  level thread namespace_e38c3c58::function_9c65cf9a();
  level thread audio::unlockfrontendmusic("mus_new_world_chase_intro");
  level thread audio::unlockfrontendmusic("mus_new_world_brave_intro");
  if(isDefined(level.bzm_newworlddialogue12callback)) {
    level thread[[level.bzm_newworlddialogue12callback]]();
  }
  scene::add_scene_func("cin_new_17_01_wakingup_1st_reveal", &function_4619fd7, "play");
  scene::add_scene_func("cin_new_17_01_wakingup_1st_reveal", &function_8247e7d3, "play");
  scene::add_scene_func("cin_new_17_01_wakingup_1st_reveal", &end_fade_out, "skip_started");
  level thread scene::play("cin_new_17_01_wakingup_1st_reveal");
  level flag::clear("infinite_white_transition");
  level waittill("hash_720ce609");
  util::clear_streamer_hint();
  skipto::objective_completed(str_objective);
}

function function_4619fd7(a_ents) {
  a_ents["player 1"] waittill("hash_bb969e7d");
  level clientfield::set("sndIGCsnapshot", 4);
  if(!scene::is_skipping_in_progress()) {
    util::screen_fade_out(0.5, "white");
  }
  level notify("hash_720ce609");
}

function function_8247e7d3(a_ents) {
  a_ents["krueger"] waittill("hash_51e02617");
  level thread scene::play("p7_fxanim_cp_newworld_curtain_bundle");
}

function end_fade_out(a_ents) {
  util::screen_fade_out(0, "black");
}

function function_c3e8639() {
  level.var_fc1953ce dialog::say("tayr_there_was_no_way_to_0", 0.5, 1);
  level.var_fc1953ce dialog::say("tayr_your_dni_may_show_yo_0", 0.5, 1);
  level.var_fc1953ce dialog::say("tayr_sometimes_you_have_0", 1, 1);
  wait(0.5);
}

function skipto_waking_up_igc_done(str_objective, b_starting, b_direct, player) {}