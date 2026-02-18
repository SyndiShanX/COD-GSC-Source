/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_af_intro.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_61cfc2ab8e60625;
#using script_74940ab70a48ee4e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown;
#using scripts\cp\cp_takedown_af_hill;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace tkdn_af_intro;

function starting(var_d3440450) {
  player = getplayers()[0];

  if(!isDefined(player)) {
    iprintlnbold("<dev string:x38>");
  }

  tkdn_af_hill::function_a2015343();
  level scene::init("scene_tkd_hit3_intro");
  player freezecontrols(1);
}

function main(var_d3440450, var_50cc0d4f) {
  plane = namespace_b100dd86::function_5431431d();
  namespace_b100dd86::function_c8381339(plane, 0);
  exploder::stop_exploder("airfield_assault_lighting_noplane");
  exploder::exploder("airfield_assault_lighting");
  level thread util::screen_fade_out(0);
  level thread namespace_29a279dd::set_display(3);
  level lui::play_movie(#"hash_1b87a73f3c672bf7", "fullscreen", 1, 0, 0, #"", 20);

  for(player = getplayers()[0]; !isPlayer(player); player = getplayers()[0]) {
    waitframe(1);
  }

  player endon(#"death", #"disconnect");
  player setcharacteroutfit(7);
  player clientfield::set_to_player("force_stream_weapons", 2);
  setDvar(#"hash_76c0d7e6385ee6de", 0.05);
  setDvar(#"hash_7b06b8037c26b99b", 255);
  var_d388318 = 1;

  var_d388318 = 0;

  namespace_82bfe441::fade(1, "FadeImmediate");
  player freezecontrols(0);
  player setstance("stand");
  player val::set("af_intro", "allow_sprint", 1);
  exploder::exploder("hit3_intro_ambient");
  exploder::exploder("hit3_prop_mist");
  wait 1.25;
  level thread util::screen_fade_in(0.7);
  level thread scene::play("scene_tkd_hit3_intro", "shot 1", [level.adler, level.woods]);
  thread function_d12ea338();
  music::setmusicstate("b1.0_opening_part_2");
  snd::client_msg("af_intro_camera_whoosh");
  namespace_a052577e::evt_transition_roof_to_airfield_camera_pt2();
  wait 1.5;
  level thread function_1dee368();
  wait 2;
  thread namespace_a052577e::function_dd4c9710();
  player thread knife_rumble();
  level waittill(#"hash_1582572f4be81dc1");
  player setcharacteroutfit(9);
  level flag::set("af_fade_in_complete");
  player cp_takedown_fx::function_c8bc54e4();
  level waittill(#"hash_47b9f42b49b80814");
  player setmovespeedscale(0.3);
  namespace_b100dd86::function_5aabc3fb();

  if(isDefined(level.var_d7d201ba)) {
    player flag::clear(level.var_d7d201ba);
  }

  player tkdn::function_43593d7d();
  player enableweapons();
  player util::delay(1, undefined, &util::function_749362d7, 0);
  player setlowready(0);
  player showcrosshair(1);
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
  level.woods ai::set_behavior_attribute("demeanor", "cqb");
  level waittill(#"hash_42c2d836748c8726");
  music::function_edda155f("b1.5_airfield_reveal");
  player util::blend_movespeedscale(0.6, 2);
  namespace_82bfe441::fade(0, "FadeSlow");
  plane_flyover = vehicle::simple_spawn_and_drive("plane_flyover");
  thread namespace_a052577e::function_92a6fd6a(plane_flyover);
  level flag::wait_till("start_tarmac");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function knife_rumble() {
  level waittill(#"knife_rumble");
  self playrumbleonentity("damage_light");
}

function function_1dee368(var_54fed624) {
  player = getplayers()[0];

  if(!isPlayer(player)) {
    return;
  }

  player endon(#"death");
  namespace_29a279dd::set_display(4, #"hash_3601a56208a44de8", #"hash_6ad17ea80deca71a");
  wait 3.5;
  namespace_29a279dd::set_display(5);
  wait 3;
  namespace_29a279dd::remove();
}

function function_d12ea338() {
  level waittill(#"hash_3286e739acb53c93");
  level objectives::follow("af_follow_adler", level.adler, undefined, 0, 0);
}

function function_cc5aa221() {
  player = getplayers()[0];
  level waittill(#"hash_6682816c8cb8b60f");
}

function cleanup(name, starting, direct, player) {
  level clientfield::set("crash_models", 1);
  level clientfield::set("crash_models", 0);
}

function init_flags() {
  level flag::init("af_fade_in_complete");
}

function init_clientfields() {}

function function_22b7fffd() {}

function function_78bc26d5() {
  self vehicle::lights_on();
  self vehicle::toggle_force_driver_taillights(1);
}