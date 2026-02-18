/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_57d05cf093ffba5c.gsc
***********************************************/

#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\hms_util;
#namespace namespace_f6d09d1a;

function init() {
  setDvar(#"hash_76c0d7e6385ee6de", 0.3);
  setDvar(#"hash_4466b01c6d8d7307", 1.8);

  if(function_72a9e321() == 0) {
    setDvar(#"hash_528da693033482d4", 60);
  }

  level thread function_14faa6d8("t_mainstreet_keys_on", 0, "lgtexp_perf_mainstreet_keys_a");
  level thread function_14faa6d8("t_mainstreet_keys_off", 1, "lgtexp_perf_mainstreet_keys_a");
  level thread function_14faa6d8("t_townsquare_keys_on", 0, "lgtexp_perf_townsquare_keys");
  level thread function_14faa6d8("t_townsquare_keys_off", 1, "lgtexp_perf_townsquare_keys");
  thread function_3515d5cb();
  thread function_a2df4bff();
}

function function_7b9feaa3(var_8d70424c, b_play, var_ad7bbec = undefined) {
  level flag::wait_till("game_start");

  if(isDefined(var_ad7bbec)) {
    waitframe(1);

    if(b_play == 1 &flag::get(var_ad7bbec) == 0) {
      exploder::exploder(var_8d70424c);
    }

    if(b_play == 0 &flag::get(var_ad7bbec) == 0) {
      exploder::stop_exploder(var_8d70424c);
    }

    return;
  }

  waitframe(1);

  if(b_play == 1) {
    exploder::exploder(var_8d70424c);
  }

  if(b_play == 0) {
    exploder::stop_exploder(var_8d70424c);
  }
}

function function_3515d5cb() {
  trig = getent("backtrack_observation_lights_on", "targetname");

  if(isDefined(trig)) {
    trig waittill(#"trigger");
    level thread function_7b9feaa3("lgtexp_perf_observation", 0);
  }

  wait 1;
  thread function_3515d5cb();
}

function function_a2df4bff() {
  trig = getent("backtrack_observation_lights_off", "targetname");

  if(isDefined(trig)) {
    trig waittill(#"trigger");
    level thread function_7b9feaa3("lgtexp_perf_observation", 1);
  }

  wait 1;
  thread function_a2df4bff();
}

function function_bdf9ac3e() {
  var_93a64e41 = getent("t_lgt_escape", "targetname");
  var_93a64e41 trigger::wait_till();
  exploder::exploder("lgtexp_escape_facility");
  exploder::stop_exploder("lgtexp_perf_escape");
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 1);
  level flag::wait_till("flg_apc_ride_mall_blockade_smash");
  wait 1.5;
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 0);
}

function function_14faa6d8(str_trigger, b_play, var_8d70424c) {
  t_trigger = getent(str_trigger, "targetname");
  t_trigger endon(#"entitydeleted");

  while(isDefined(t_trigger)) {
    s_waitresult = t_trigger waittill(#"trigger");

    if(s_waitresult.activator === level.player) {
      if(b_play == 1) {
        exploder::exploder(var_8d70424c);
      }

      if(b_play == 0) {
        exploder::stop_exploder(var_8d70424c);
      }

      wait 1;
    }
  }
}

function function_a677563d() {
  var_d5535d9a = getvehiclearray("control_tower_elevator", "targetname")[0];
  var_d5535d9a.probe = getent("elevator_probe_dyn", "targetname");

  if(isDefined(var_d5535d9a.probe)) {
    var_d5535d9a.probe linkto(var_d5535d9a, undefined, (-3, 0, -21.5), (0, 0, 180));
  }

  light_origin = var_d5535d9a.origin + (0, 0, 32.5);
  light_angles = (90, 0, 0);
  var_d5535d9a fx::play("maps/cp_rus_amerika/fx9_amrka_lgt_elevator", light_origin, light_angles, "kill_elevator_fx_lgt", 1);
  level flag::wait_till("flg_terminal_player_interact");
  var_d5535d9a notify(#"kill_elevator_fx_lgt");
}

function function_811985a1() {
  level thread function_14faa6d8("t_rooftop_twn_keys_on", 0, "lgtexp_perf_townsquare_keys_static");
  level thread function_14faa6d8("t_rooftop_twn_keys_off", 1, "lgtexp_perf_townsquare_keys_static");
}

function function_4699a51c() {
  ai_enemy_helipad_left = getent("ai_lgt_enemy_helipad_left", "script_noteworthy", 1);
  ai_enemy_helipad_left waittill(#"death");
}