/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_ai_raz.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_3751b21462a54a7d;
#using script_3a88f428c6d8ef90;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_ai_raz;

function private autoexec __init__system__() {
  system::register(#"zm_ai_raz", &preinit, undefined, &function_4df027f2, undefined);
}

function private preinit() {
  spawner::add_archetype_spawn_function(#"raz", &function_3113cf8f);
  zm_round_spawning::register_archetype(#"raz", &function_d4f11e3c, &round_spawn, undefined, 25);
  zm_round_spawning::function_306ce518(#"raz", &function_f1355240);
  zm_cleanup::function_cdf5a512(#"raz", &function_54993e2);
}

function function_4df027f2() {}

function function_3113cf8f() {
  self.closest_player_override = &zm_utility::function_3d70ba7a;
  self.melee_distance_check = &namespace_e292b080::function_e8983bf3;
}

function spawn_single(b_force_spawn, var_eb3a8721 = 0, var_bc66d64b) {
  if(!var_eb3a8721 && !function_9230ac9a()) {
    return undefined;
  }

  if(isDefined(var_bc66d64b)) {
    s_spawn_loc = var_bc66d64b;
  } else if(isDefined(level.var_2e33420c)) {
    s_spawn_loc = [[level.var_2e33420c]]();
  } else if(level.zm_loc_types[# "raz_location"].size > 0) {
    s_spawn_loc = array::random(level.zm_loc_types[# "raz_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
      iprintlnbold("<dev string:x38>");
    }

    return undefined;
  }

  ai = spawnactor(#"hash_4f87aa2a203d37d0", s_spawn_loc.origin, s_spawn_loc.angles);

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
  }

  return ai;
}

function round_spawn() {
  ai = spawn_single();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function function_9230ac9a() {
  var_2c3c71f0 = function_d29d5032();
  var_ea840c7e = function_62f1faf9();

  if(!is_true(level.var_76934955) && (is_true(level.var_fe2bb2ac) || var_2c3c71f0 >= var_ea840c7e || !level flag::get("spawn_zombies"))) {
    return false;
  }

  return true;
}

function function_62f1faf9() {
  n_player_count = zm_utility::function_a2541519(getplayers().size);

  if(!isDefined(n_player_count) || n_player_count < 1) {
    n_player_count = 1;
  }

  switch (n_player_count) {
    case 1:
    default:
      return 1;
    case 2:
      return 2;
    case 3:
      return 2;
    case 4:
      return 3;
    case 5:
      return 3;
  }
}

function function_d29d5032() {
  a_ai_raz = getaiarchetypearray(#"raz");
  var_2c3c71f0 = a_ai_raz.size;

  foreach(ai_raz in a_ai_raz) {
    if(!isalive(ai_raz)) {
      var_2c3c71f0--;
    }
  }

  return var_2c3c71f0;
}

function function_d4f11e3c(var_dbce0c44) {
  if(isDefined(level.var_36678664) && level.round_number < level.var_36678664) {
    return 0;
  }

  var_8cf00d40 = int(floor(var_dbce0c44 / 25));

  if(level.round_number < 20) {
    var_74475add = 0.02;
  } else if(level.round_number < 30) {
    var_74475add = 0.03;
  } else {
    var_74475add = 0.04;
  }

  return min(var_8cf00d40, int(ceil(level.zombie_total * var_74475add)));
}

function function_f1355240(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_2f45d799)) {
    level.var_2f45d799 = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"raz")) {
      level.var_2f45d799++;
      n_player_count = zm_utility::function_a2541519(getplayers().size);

      if(n_player_count == 1) {
        level.var_2f45d799 = level.round_number + randomintrangeinclusive(2, 4);
        continue;
      }

      level.var_2f45d799 = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function function_54993e2() {
  if(isDefined(level.var_2e33420c)) {
    var_d7eff26a = [[level.var_2e33420c]]();
  } else {
    var_91562d8c = level.zm_loc_types[# "raz_location"];

    if(var_91562d8c.size) {
      var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
    }
  }

  if(!isDefined(var_d7eff26a)) {
    if(zm_devgui::any_player_in_noclip()) {}

    return false;
  }

  if(isentity(self)) {
    self zm_ai_utility::function_a8dc3363(var_d7eff26a);
    self thread function_1f9940b8();
  }

  return true;
}

function function_1f9940b8() {
  self endon(#"death");
  playFX(#"zombie/fx9_onslaught_spawn_sm", self.origin);
  playsoundatposition(#"hash_14247392847093a6", self.origin + (0, 0, 75));
  self.in_the_ground = 1;
  self ghost();
  self pathmode("dont move", 1);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  self orientmode("face default");

  if(!self isragdoll()) {
    self playSound(#"hash_4b49f05e8c054fd9");
    self animscripted("rise_anim", self.origin, self.angles, #"ai_t9_zm_zombie_base_traverse_ground_dugup", "normal");
    waitframe(1);
  }

  self show();
  self pathmode("move allowed");
  self.in_the_ground = 0;
}