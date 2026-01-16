/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_special_rounds.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\spawner_shared;
#include scripts\zm\zm_orange_util;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\trials\zm_trial_special_enemy;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_orange_special_rounds;

main() {
  zm_round_spawning::register_archetype(#"zombie_electric", &function_5df3e3dd, &function_c7e59327, &function_27695a82, 5);
  zm_score::function_e5d6e6dd(#"zombie_electric", zombie_utility::get_zombie_var(#"zombie_score_kill"));
  zm_cleanup::function_cdf5a512(#"zombie", &function_a2f2a9a3);
  level.var_621701e5 = array(getent("zombie_electric_spawner", "script_noteworthy"));
  array::thread_all(level.var_621701e5, &spawner::add_spawn_function, &zm_behavior::function_57d3b5eb);
  level.var_1c921b2b = 0;

  if(zm_utility::is_classic()) {
    if(zm_custom::function_901b751c(#"zmpopcornstate") != 0) {
      zombie_dog_util::dog_enable_rounds(0);
      level.var_2f14be05 = 15;
      zm_round_spawning::function_376e51ef(#"zombie_dog", level.var_2f14be05);
    }

    level thread function_2eb8970d();
  }

  if(zm_utility::is_trials()) {
    zm_trial_special_enemy::function_95c1dd81(#"zombie_electric", &function_c7e59327);
    zm_trial_special_enemy::function_95c1dd81(#"zombie_dog", &function_82e6d4e0);
    zm_round_spawning::function_376e51ef(#"zombie_dog", 15);
    level thread function_2eb8970d();
  }
}

function_2eb8970d() {
  level waittill(#"power_on2");

  if(zm_custom::function_901b751c(#"zmenhancedstate") != 0) {
    zm_round_spawning::function_376e51ef(#"zombie_electric", level.round_number);
  }
}

function_5df3e3dd(var_dbce0c44) {
  var_8cf00d40 = int(floor(var_dbce0c44 / 5));

  if(level.round_number < 20) {
    var_ce0732c6 = 0.1;
  } else if(level.round_number < 30) {
    var_ce0732c6 = 0.15;
  } else {
    var_ce0732c6 = 0.2;
  }

  return min(var_8cf00d40, int(ceil(level.zombie_total * var_ce0732c6)));
}

function_c6959cf1() {
  spawner = getent("zombie_electric_spawner", "script_noteworthy");
  return spawner;
}

function_27695a82() {
  spawner = function_c6959cf1();
  spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
  ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point, level.round_number + level.var_1c921b2b);

  if(isDefined(ai)) {
    ai thread zm_orange_util::function_865209df(#"electric_zombie", #"hash_73e5e9787832fc70");
  }

  return ai;
}

function_c7e59327() {
  ai = function_27695a82();

  if(isDefined(ai)) {
    if(!zm_utility::is_trials()) {
      level.zombie_total--;
    }

    return true;
  }

  return false;
}

function_82e6d4e0() {
  ai = zombie_dog_util::function_62db7b1c();

  if(isDefined(ai)) {
    return true;
  }

  return false;
}

function_a2f2a9a3() {
  if(self.subarchetype !== #"zombie_electric") {
    return false;
  }

  a_s_spawn_locs = level.zm_loc_types[#"zombie_location"];
  var_91562d8c = [];
  var_f2a95155 = [];

  foreach(s_spawn_loc in a_s_spawn_locs) {
    if(isDefined(s_spawn_loc.script_noteworthy) && (s_spawn_loc.script_noteworthy == "riser_location" || s_spawn_loc.script_noteworthy == "faller_location")) {
      continue;
    }

    if(s_spawn_loc.script_string == "find_flesh") {
      if(!isDefined(var_91562d8c)) {
        var_91562d8c = [];
      } else if(!isarray(var_91562d8c)) {
        var_91562d8c = array(var_91562d8c);
      }

      var_91562d8c[var_91562d8c.size] = s_spawn_loc;
      continue;
    }

    if(!isDefined(var_f2a95155)) {
      var_f2a95155 = [];
    } else if(!isarray(var_f2a95155)) {
      var_f2a95155 = array(var_f2a95155);
    }

    var_f2a95155[var_f2a95155.size] = s_spawn_loc;
  }

  if(var_91562d8c.size) {
    var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
  } else if(var_f2a95155.size) {
    var_d7eff26a = zm_spawner::function_20e7d186(var_f2a95155);
  } else {
    return false;
  }

  if(isDefined(self) && isentity(self)) {
    self thread clientfield::set("zm_ai/zombie_electric_fx_clientfield", 0);
    self zm_ai_utility::function_a8dc3363(var_d7eff26a);

    if(isDefined(self)) {
      self thread clientfield::set("zm_ai/zombie_electric_fx_clientfield", 1);
    }
  }

  return true;
}