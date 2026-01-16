/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\util\ai_skeleton_util.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\trials\zm_trial_special_enemy;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zombie_skeleton_util;

autoexec __init__system__() {
  system::register(#"zombie_skeleton_util", &__init__, undefined, #"zm_ai_skeleton");
}

private __init__() {
  level.var_edd123b1 = &function_d325f6a4;
  zm_score::function_e5d6e6dd(#"skeleton", 60);

  if(zm_utility::is_standard()) {
    zm_round_spawning::register_archetype(#"skeleton", &function_cf877849, &round_spawn, &function_1ea880bd, 5);
  } else {
    zm_round_spawning::register_archetype(#"skeleton", &function_cf877849, &round_spawn, &function_1ea880bd, 25);
  }

  zm_cleanup::function_cdf5a512(#"skeleton", &function_ad4293a8);
  zm_trial_special_enemy::function_95c1dd81(#"skeleton", &function_8609d56e);
  level.var_5fc2833 = getEntArray("zombie_skeleton_spawner", "script_noteworthy");
  level.var_7b7fd31e = getEntArray("zombie_skeleton_spear_spawner", "script_noteworthy");
  level.var_ea48e91 = getEntArray("zombie_skeleton_helmet_spawner", "script_noteworthy");
  level.var_c34db86 = getEntArray("zombie_skeleton_helmet_spear_spawner", "script_noteworthy");
  level.var_5781a278 = arraycombine(level.var_5fc2833, level.var_7b7fd31e, 0, 0);
  level.var_5781a278 = arraycombine(level.var_5781a278, level.var_ea48e91, 0, 0);
  level.var_5781a278 = arraycombine(level.var_5781a278, level.var_c34db86, 0, 0);
}

function_cf877849(var_dbce0c44) {
  if(zm_utility::is_standard()) {
    var_8cf00d40 = int(floor(var_dbce0c44 / 25));
    var_a1737466 = randomfloatrange(0.35, 0.45);
  } else {
    var_8cf00d40 = int(floor(var_dbce0c44 / 25));
    var_a1737466 = randomfloatrange(0.08, 0.12);
  }

  return min(var_8cf00d40, int(level.zombie_total * var_a1737466));
}

round_spawn() {
  ai = function_1ea880bd();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

private function_8609d56e() {
  ai_skeleton = function_1ea880bd(1);
  return isDefined(ai_skeleton);
}

function_1ea880bd(b_force_spawn = 0, var_eb3a8721, round_number, b_spear, b_helmet) {
  if(!b_force_spawn && !function_bdd7ec59()) {
    return undefined;
  }

  players = getplayers();

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.var_edd123b1)) {
    s_spawn_loc = [[level.var_edd123b1]]();
  } else if(isarray(level.zm_loc_types) && level.zm_loc_types[#"zombie_location"].size > 0) {
    a_s_spawn_locs = function_3ce1516d(level.zm_loc_types[#"zombie_location"]);
    s_spawn_loc = array::random(a_s_spawn_locs);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  if(!isDefined(b_spear)) {
    b_spear = math::cointoss();
  }

  if(!isDefined(b_helmet)) {
    b_helmet = math::cointoss();
  }

  if(b_spear) {
    if(b_helmet) {
      var_5fc2833 = level.var_c34db86;
    } else {
      var_5fc2833 = level.var_7b7fd31e;
    }
  } else if(b_helmet) {
    var_5fc2833 = level.var_ea48e91;
  } else {
    var_5fc2833 = level.var_5fc2833;
  }

  ai = zombie_utility::spawn_zombie(array::random(var_5fc2833), undefined, undefined, round_number);

  if(isDefined(ai)) {
    if(!b_spear) {
      ai.var_4e9f7942 = 1;
    }

    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);

    if(isDefined(level.var_1a540a38)) {
      ai thread[[level.var_1a540a38]](s_spawn_loc);
    }

    var_46d2ec35 = get_favorite_enemy();

    if(isDefined(var_46d2ec35)) {
      ai.favoriteenemy = var_46d2ec35;
      ai.favoriteenemy.hunted_by++;
    }
  }

  return ai;
}

function_bdd7ec59() {
  var_14bd36c2 = function_331e9312();
  var_f11e475c = function_d3195b0c();

  if(!(isDefined(level.var_4a03b294) && level.var_4a03b294) && isDefined(level.var_5e45f817) && level.var_5e45f817 || var_14bd36c2 >= var_f11e475c || !level flag::get("spawn_zombies")) {
    return false;
  }

  return true;
}

function_d3195b0c() {
  switch (getplayers().size) {
    case 1:
      return 3;
    case 2:
      return 5;
    case 3:
      return 7;
    case 4:
      return 10;
  }
}

function_331e9312() {
  a_ai_skeletons = getaiarchetypearray(#"skeleton");
  var_14bd36c2 = a_ai_skeletons.size;

  foreach(ai_skeleton in a_ai_skeletons) {
    if(!isalive(ai_skeleton)) {
      var_14bd36c2--;
    }
  }

  return var_14bd36c2;
}

function_d325f6a4(entity) {
  if(isarray(level.zm_loc_types[#"zombie_location"]) && level.zm_loc_types[#"zombie_location"].size >= 1) {
    a_locs = function_3ce1516d(level.zm_loc_types[#"zombie_location"]);
    a_locs = array::randomize(a_locs);
  }

  if(!isDefined(a_locs) || a_locs.size == 0) {
    return;
  }

  if(isDefined(entity) && isDefined(entity.favoriteenemy) && zm_utility::is_player_valid(entity.favoriteenemy)) {
    var_46d2ec35 = entity.favoriteenemy;
  } else {
    var_46d2ec35 = get_favorite_enemy();
  }

  if(!isDefined(var_46d2ec35) || !isalive(var_46d2ec35)) {
    return array::random(a_locs);
  }

  var_ae2b4871 = 3600 * 3600;

  for(i = 0; i < a_locs.size; i++) {
    if(isDefined(level.var_445185e3) && level.var_445185e3 == a_locs[i]) {
      continue;
    }

    n_dist_squared = distancesquared(a_locs[i].origin, var_46d2ec35.origin);

    if(n_dist_squared < var_ae2b4871) {
      level.var_445185e3 = a_locs[i];
      return a_locs[i];
    }
  }

  return arraygetclosest(var_46d2ec35.origin, a_locs);
}

get_favorite_enemy() {
  var_8637c743 = getplayers();
  e_least_hunted = var_8637c743[0];

  for(i = 0; i < var_8637c743.size; i++) {
    if(!isDefined(var_8637c743[i].hunted_by)) {
      var_8637c743[i].hunted_by = 0;
    }

    if(!zm_utility::is_player_valid(var_8637c743[i])) {
      continue;
    }

    if(!zm_utility::is_player_valid(e_least_hunted)) {
      e_least_hunted = var_8637c743[i];
    }

    if(var_8637c743[i].hunted_by < e_least_hunted.hunted_by) {
      e_least_hunted = var_8637c743[i];
    }
  }

  if(!zm_utility::is_player_valid(e_least_hunted)) {
    return undefined;
  }

  e_least_hunted.hunted_by += 1;
  return e_least_hunted;
}

function_ad4293a8() {
  self endon(#"death");
  a_s_spawn_locs = function_3ce1516d(level.zm_loc_types[#"zombie_location"]);

  if(!isarray(a_s_spawn_locs) || a_s_spawn_locs.size < 1) {
    self.b_ignore_cleanup = 1;
    return true;
  }

  if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area")) {
    self.b_ignore_cleanup = 1;
    return true;
  }

  var_31f7011a = arraycopy(getplayers());
  var_31f7011a = arraysortclosest(var_31f7011a, self.origin);
  i = 0;
  var_b2aa54a9 = a_s_spawn_locs[0];
  var_56feeec4 = distancesquared(var_31f7011a[0].origin, var_b2aa54a9.origin);

  foreach(var_d7eff26a in a_s_spawn_locs) {
    if(!zm_utility::is_player_valid(var_31f7011a[i])) {
      i++;

      if(i >= var_31f7011a.size) {
        i = 0;
        util::wait_network_frame();
      }

      continue;
    }

    var_e8ab126e = distancesquared(var_31f7011a[i].origin, var_d7eff26a.origin);

    if(var_e8ab126e < var_56feeec4) {
      var_56feeec4 = var_e8ab126e;
      var_b2aa54a9 = var_d7eff26a;
    }
  }

  self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
  return true;
}

private function_3ce1516d(a_s_spawn_locs) {
  var_f74a9210 = [];

  foreach(s_spawn_loc in a_s_spawn_locs) {
    if(s_spawn_loc.script_noteworthy !== "spawn_location") {
      continue;
    } else if(s_spawn_loc.script_string !== "find_flesh") {
      continue;
    }

    if(!isDefined(var_f74a9210)) {
      var_f74a9210 = [];
    } else if(!isarray(var_f74a9210)) {
      var_f74a9210 = array(var_f74a9210);
    }

    var_f74a9210[var_f74a9210.size] = s_spawn_loc;
  }

  return var_f74a9210;
}

alloc_dynamic_buffer(origin, radius, half_height) {
  assert(self.archetype === #"skeleton", "<dev string:x38>");
  self.var_dbbbae12 = ai::t_cylinder(origin, radius, half_height);
}

function_9ac81c11() {
  assert(self.archetype === #"skeleton", "<dev string:x77>");
  self.var_dbbbae12 = undefined;
}