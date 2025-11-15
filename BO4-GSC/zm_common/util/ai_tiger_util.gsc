/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\util\ai_tiger_util.gsc
***********************************************/

#include scripts\core_common\ai\archetype_tiger;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\ai\zm_ai_tiger;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\trials\zm_trial_add_special;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zombie_tiger_util;

autoexec __init__system__() {
  system::register(#"zombie_tiger_util", &__init__, &__main__, #"zm_ai_tiger");
}

__init__() {
  level.var_4ead8122 = getEntArray("zombie_tiger_spawner", "script_noteworthy");

  if(level.var_4ead8122.size == 0) {
    assertmsg("<dev string:x38>");
    return;
  }

  zm_round_spawning::register_archetype(#"tiger", &function_235d0eb6, &round_spawn, &spawn_single, 25);
}

__main__() {
  zm_score::function_e5d6e6dd(#"tiger", level.var_4ead8122[0] ai::function_9139c839().var_7a715ab5);
  spawner::add_archetype_spawn_function(#"tiger", &function_fe4c8547);
}

function_fe4c8547() {
  self thread function_94c9b195();
  var_1751372a = zm_ai_utility::function_8d44707e(0);
  var_1751372a *= isDefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1;
  var_1751372a = int(var_1751372a);
  self.health = var_1751372a;
  self.maxhealth = var_1751372a;
  self zm_score::function_82732ced();
}

spawn_single(b_force_spawn = 0, var_eb3a8721) {
  if(!b_force_spawn && !function_66cfd7d()) {
    return undefined;
  }

  players = getplayers();

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.var_fcde6b4)) {
    s_spawn_loc = [[level.var_fcde6b4]]();
  } else if(level.zm_loc_types[#"tiger_location"].size > 0) {
    s_spawn_loc = array::random(level.zm_loc_types[#"tiger_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  ai = zombie_utility::spawn_zombie(level.var_4ead8122[0], "tiger");

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);

    if(isDefined(level.tiger_on_spawned)) {
      ai thread[[level.tiger_on_spawned]](s_spawn_loc);
    }
  }

  return ai;
}

function_66cfd7d() {
  var_6ecc1639 = function_ba8172ca();
  var_b3c0e90e = function_cbfb0da4();

  if(var_6ecc1639 >= var_b3c0e90e || !level flag::get("spawn_zombies") || isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return false;
  }

  return true;
}

function_cbfb0da4() {
  n_player_count = zm_utility::function_a2541519(getplayers().size);

  switch (n_player_count) {
    case 1:
      var_ed61bfaa = 3;
      break;
    case 2:
      var_ed61bfaa = 5;
      break;
    case 3:
      var_ed61bfaa = 7;
      break;
    default:
      var_ed61bfaa = 10;
      break;
  }

  if(zm_trial_add_special::is_active(#"tiger")) {
    var_ed61bfaa *= 4;
  }

  return var_ed61bfaa;
}

function_ba8172ca() {
  var_cf9c1780 = getaiarchetypearray(#"tiger");
  var_6ecc1639 = var_cf9c1780.size;

  foreach(ai_tiger in var_cf9c1780) {
    if(!isalive(ai_tiger)) {
      var_6ecc1639--;
    }
  }

  return var_6ecc1639;
}

function_ffa01525() {
  n_player_count = zm_utility::function_a2541519(level.players.size);

  switch (n_player_count) {
    case 1:
      n_default_wait = 1;
      break;
    case 2:
      n_default_wait = 0.75;
      break;
    case 3:
      n_default_wait = 0.5;
      break;
    default:
      n_default_wait = 0.25;
      break;
  }

  wait n_default_wait;
}

function_94c9b195() {
  self endon(#"death");

  if(level flag::get("special_round")) {
    self ai::set_behavior_attribute("sprint", 1);
  }
}

function_235d0eb6(var_dbce0c44) {
  if(isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return 0;
  }

  var_8cf00d40 = int(floor(var_dbce0c44 / 25));
  var_a1737466 = randomfloatrange(0.08, 0.12);
  return min(var_8cf00d40, int(level.zombie_total * var_a1737466));
}

round_spawn() {
  ai = spawn_single();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}