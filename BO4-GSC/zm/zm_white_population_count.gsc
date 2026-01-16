/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_population_count.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_white_population_count;

init() {
  if(!zm_utility::is_trials()) {
    level thread nuked_population_sign_think();
  }
}

nuked_population_sign_think() {
  level flag::init(#"hash_35762ecd1ee8f3c1");
  level endon(#"end_game", #"hash_5aa1c9627e8626e0");
  var_50f6b3f4 = getent("counter_tens", "targetname");
  var_d02e9cd = getent("counter_ones", "targetname");
  n_step = 36;
  n_ones = 0;
  n_tens = 0;
  var_aa6e55d3 = 0;
  var_50f6b3f4 rotateroll(n_step, 0.05);
  var_d02e9cd rotateroll(n_step, 0.05);
  level.population_count = 0;

  while(true) {
    if(var_aa6e55d3 < level.total_zombies_killed - level.zombie_total_subtract) {
      n_ones--;
      n_time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");

      if(n_ones < 0) {
        n_ones = 9;
        var_50f6b3f4 rotateroll(0 - n_step, n_time);
        var_50f6b3f4 playSound("zmb_counter_flip");
        n_tens--;
      }

      if(n_tens < 0) {
        n_tens = 9;
      }

      var_d02e9cd rotateroll(0 - n_step, n_time);
      var_d02e9cd playSound("zmb_counter_flip");
      var_d02e9cd waittill(#"rotatedone");
      level.population_count = n_ones + n_tens * 10;

      if(level.population_count == 0 || level.population_count == 33 || level.population_count == 66 || level.population_count == 99) {
        level notify(#"update_doomsday_clock");
      }

      var_aa6e55d3++;
    }

    if(level.population_count == 15 || level.var_20cc3d90 === level.population_count) {
      level flag::set(#"hash_35762ecd1ee8f3c1");
    } else {
      level flag::clear(#"hash_35762ecd1ee8f3c1");
    }

    wait 0.05;
  }
}

set_dvar_float_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
  }

  return getdvarfloat(dvar, 0);
}

function_3134b684() {
  level.var_20cc3d90 = level.population_count;
  level flag::set(#"hash_35762ecd1ee8f3c1");
}