/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\util\ai_gladiator_util.gsc
************************************************/

#include script_2c5daa95f8fec03c;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\powerup\zm_powerup_nuke;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;

#namespace zombie_gladiator_util;

autoexec __init__system__() {
  system::register(#"zombie_gladiator_util", &__init__, &__main__, #"zm_ai_gladiator");
}

__init__() {
  level.var_fc0d2372 = getEntArray("zombie_gladiator_destroyer_spawner", "script_noteworthy");
  level.var_735451fc = getEntArray("zombie_gladiator_marauder_spawner", "script_noteworthy");
  level.var_4d136b9a = arraycombine(level.var_fc0d2372, level.var_735451fc, 0, 0);
  level.var_7e0bfb6 = 0;
  zm_round_spawning::register_archetype(#"gladiator_destroyer", &function_c251d29f, &function_bb067153, &function_2efc00db, 225);
  zm_round_spawning::register_archetype(#"gladiator_marauder", &function_c251d29f, &function_60e6998a, &function_c9cd31, 75);
}

__main__() {
  spawner::add_archetype_spawn_function(#"gladiator", &function_8c0ab720);
  zm_score::function_e5d6e6dd(#"gladiator", level.var_fc0d2372[0] ai::function_9139c839().var_1aa4e66a);
}

private function_8c0ab720() {
  n_hp = zm_ai_utility::function_8d44707e(1) * (isDefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1);

  if(self.subarchetype == #"gladiator_marauder") {
    n_hp *= 0.7;
    self.var_17a22c08 = 150;
    self playSound(#"zmb_ai_gladiator_spawn_mar");
  } else {
    self playSound(#"zmb_ai_gladiator_spawn_des");
  }

  self.health = int(n_hp);
  self.maxhealth = int(n_hp);
  self.should_zigzag = 1;
  self zm_powerup_nuke::function_9a79647b(0.5);
  self zm_score::function_82732ced();

  if(self.subarchetype == #"gladiator_destroyer") {
    namespace_81245006::initweakpoints(self, "c_t8_zmb_gladiator_dst_weakpoint_def");
  } else if(self.subarchetype == #"gladiator_marauder") {
    namespace_81245006::initweakpoints(self, "c_t8_zmb_gladiator_mar_weakpoint_def");
  }

  self thread vo();
}

vo() {
  self endon(#"death");
  e_enemy = undefined;
  a_vo = zm_audio::get_valid_lines(#"hash_76d06b092be0a0de");
  wait 15;

  while(true) {
    function_c03b6f46(90000, 640000);
    e_enemy = self.enemy;
    wait randomfloatrange(2, 4);
    function_c03b6f46(90000, 640000);

    if(self.enemy === e_enemy && !level.var_7e0bfb6) {
      level.var_7e0bfb6 = 1;
      line = array::random(a_vo);

      if(zm_vo::vo_say(line)) {
        arrayremovevalue(a_vo, line);

        if(!a_vo.size) {
          return;
        }
      }
    }

    wait randomfloatrange(40, 80);
    level.var_7e0bfb6 = 0;
  }
}

function_c03b6f46(var_4e77d211, var_3551e3b9) {
  self endon(#"death");

  while(true) {
    wait randomfloatrange(0.666667, 1.33333);

    if(zm_utility::is_player_valid(self.enemy)) {
      n_dist_sq = distance2dsquared(self.origin, self.enemy.origin);

      if(n_dist_sq > var_4e77d211 && n_dist_sq < var_3551e3b9) {
        break;
      }

      continue;
    }

    continue;
  }
}

function_bfa79e98(sp_spawner = level.var_4d136b9a[0], s_spot, str_type, n_round) {
  if(isDefined(str_type)) {
    switch (str_type) {
      case #"melee":
        sp_spawner = level.var_735451fc[0];
        break;
      case #"ranged":
        sp_spawner = level.var_fc0d2372[0];
        break;
    }
  }

  ai = zombie_utility::spawn_zombie(sp_spawner, "gladiator", s_spot, n_round);

  if(isDefined(ai)) {
    if(isDefined(s_spot)) {
      ai.script_string = s_spot.script_string;
      ai.find_flesh_struct_string = s_spot.find_flesh_struct_string;
    }

    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
  }

  return ai;
}

function_69f309b(n_to_spawn = 1, str_type, var_1fafa3fc, b_force_spawn = 0, var_eb3a8721 = undefined, n_round) {
  n_spawned = 0;

  if(!isDefined(str_type)) {
    var_7aad80fe = array::random(level.var_4d136b9a);
  }

  while(n_spawned < n_to_spawn) {
    if(!b_force_spawn && !function_e4d7ae2b()) {
      return n_spawned;
    }

    players = getplayers();

    if(isDefined(var_eb3a8721)) {
      s_spawn_loc = var_eb3a8721;
    } else if(isDefined(level.var_14961f90) && level flag::get("special_round")) {
      s_spawn_loc = [
        [level.var_14961f90]
      ](var_7aad80fe);
    } else if(isDefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size) {
      s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
    }

    if(!isDefined(s_spawn_loc)) {
      return 0;
    }

    ai = function_bfa79e98(var_7aad80fe, s_spawn_loc, str_type, n_round);

    if(isDefined(ai)) {
      ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
      ai.script_string = s_spawn_loc.script_string;
      ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
      n_spawned++;

      if(isDefined(var_1fafa3fc)) {
        ai thread[[var_1fafa3fc]](s_spawn_loc);
      }
    }

    function_5d0001ad();
  }

  return 1;
}

function_2efc00db(b_force_spawn = 0, var_eb3a8721) {
  if(!b_force_spawn && !function_e4d7ae2b()) {
    return undefined;
  }

  players = getplayers();

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.var_14961f90)) {
    s_spawn_loc = [[level.var_14961f90]]();
  } else if(isDefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size) {
    s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  ai = zombie_utility::spawn_zombie(level.var_fc0d2372[0], "gladiator");

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);

    if(isDefined(level.var_290ac2c3)) {
      ai thread[[level.var_290ac2c3]](s_spawn_loc);
    }
  }

  return ai;
}

function_c9cd31(b_force_spawn = 0, var_eb3a8721) {
  if(!b_force_spawn && !function_e4d7ae2b()) {
    return undefined;
  }

  players = getplayers();

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.var_14961f90)) {
    s_spawn_loc = [[level.var_14961f90]]();
  } else if(isDefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size) {
    s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  ai = zombie_utility::spawn_zombie(level.var_735451fc[0], "gladiator");

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);

    if(isDefined(level.var_290ac2c3)) {
      ai thread[[level.var_290ac2c3]](s_spawn_loc);
    }
  }

  return ai;
}

function_e4d7ae2b() {
  var_3e8b490d = function_78913059();
  var_10833f75 = function_45876e23();

  if(!(isDefined(level.var_76934955) && level.var_76934955) && (isDefined(level.var_fe2bb2ac) && level.var_fe2bb2ac || var_3e8b490d >= var_10833f75 || !level flag::get("spawn_zombies"))) {
    return false;
  }

  return true;
}

function_78913059() {
  var_80074df6 = getaiarchetypearray(#"gladiator");
  var_3e8b490d = var_80074df6.size;

  foreach(ai in var_80074df6) {
    if(!isalive(ai)) {
      var_3e8b490d--;
    }
  }

  return var_3e8b490d;
}

function_5d0001ad() {
  n_player_count = zm_utility::function_a2541519(level.players.size);

  switch (n_player_count) {
    case 1:
      n_default_wait = 8;
      break;
    case 2:
      n_default_wait = 5;
      break;
    case 3:
      n_default_wait = 3;
      break;
    default:
      n_default_wait = 1;
      break;
  }

  wait n_default_wait;
}

function_45876e23() {
  n_player_count = zm_utility::function_a2541519(level.players.size);

  switch (n_player_count) {
    case 1:
      return 3;
    case 2:
      return 4;
    case 3:
      return 5;
    default:
      return 6;
  }
}

function_c251d29f(var_dbce0c44) {
  var_8cf00d40 = int(floor(var_dbce0c44 / 225));

  if(!isDefined(level.var_15aa32df)) {
    level.var_15aa32df = 8;
  }

  n_player_count = zm_utility::function_a2541519(level.players.size);

  if(n_player_count == 1) {
    var_1797c23a = 1 + max(0, floor((level.round_number - level.var_15aa32df) / 4));
  } else {
    var_1797c23a = 1 + max(0, floor((level.round_number - level.var_15aa32df) / 3));
  }

  var_2506688 = var_1797c23a < 8 ? max(var_1797c23a - 3, 0) : var_1797c23a * 0.75;
  return randomintrangeinclusive(int(var_2506688), int(min(var_8cf00d40, var_1797c23a)));
}

function_60e6998a() {
  ai = function_c9cd31();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_bb067153() {
  ai = function_2efc00db();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}