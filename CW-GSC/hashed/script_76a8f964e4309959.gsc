/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_76a8f964e4309959.gsc
***********************************************/

#using script_26cd04df32f6537a;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_abfee9ba;

function private autoexec __init__system__() {
  system::register(#"hash_55f568f82a7aea28", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_3220b44880f1807c", 24000, 1, "counter");
  zm_round_spawning::register_archetype(#"tormentor", &function_44d45595, &round_spawn, &function_dfa96d1f, 25);
  spawner::add_archetype_spawn_function(#"tormentor", &function_a5cd9e54);
  zm_cleanup::function_cdf5a512(#"tormentor", &function_d8461453);
}

function private postinit() {}

function function_a5cd9e54() {
  self.no_gib = 1;
  self zombie_utility::set_zombie_run_cycle(#"super_sprint");
  self.allowdeath = 1;
  self.allowpain = 0;
  self.is_zombie = 1;
  self.var_78f17f6b = 1;
  self.var_12af7864 = 1;
  self.canbetargetedbyturnedzombies = 1;
  self.var_e8920729 = 1;
  self thread function_5e09bd0f();
  aiutility::addaioverridedamagecallback(self, &function_354a904e);
  level thread zm_spawner::zombie_death_event(self);
}

function private function_354a904e(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(boneindex.archetype === # "tormentor" && boneindex.team === self.team) {
    return 0;
  }

  return modelindex;
}

function spawn_single(b_force_spawn, var_eb3a8721 = 0, var_bc66d64b) {
  if(!var_eb3a8721 && !function_e0968877()) {
    return undefined;
  }

  s_spawn_loc = var_bc66d64b;

  if(!isDefined(s_spawn_loc)) {
    if(level.zm_loc_types[# "zombie_location"].size > 0) {
      s_spawn_loc = array::random(level.zm_loc_types[# "zombie_location"]);
    } else {
      if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
        iprintlnbold("<dev string:x38>");
      }

      return undefined;
    }
  }

  ai = spawnactor(#"hash_51edd7595ecda822", s_spawn_loc.origin, s_spawn_loc.angles);

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.script_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai.ignore_enemy_count = 0;
    ai thread zm_utility::move_zombie_spawn_location(s_spawn_loc);
  }

  return ai;
}

function round_spawn() {
  ai = spawn_single();

  if(isDefined(ai)) {
    return true;
  }

  return false;
}

function function_e0968877() {
  n_alive = function_9f679c3c();
  var_12e5a581 = function_4b283bfa();

  if(n_alive >= var_12e5a581 || !level flag::get("spawn_zombies")) {
    return false;
  }

  return true;
}

function function_4b283bfa() {
  n_player_count = zm_utility::function_a2541519(getplayers().size);

  switch (n_player_count) {
    case 1:
    default:
      return 3;
    case 2:
      return 5;
    case 3:
      return 7;
    case 4:
      return 10;
  }
}

function function_9f679c3c() {
  a_ais = getaiarchetypearray(#"tormentor");
  var_d4027fe0 = a_ais.size;

  foreach(ai in a_ais) {
    if(!isalive(ai)) {
      var_d4027fe0--;
    }
  }

  return var_d4027fe0;
}

function function_5e09bd0f() {
  self endon(#"death", #"entitydeleted", #"endambientvox");
  wait 1.1;
  self playsoundontag(#"hash_65eb1e22e2f9a826", "j_head");
  wait 2;

  while(true) {
    self playsoundontag(#"hash_a3c5d5d69e0fc95", "j_head");
    wait randomfloatrange(1.9, 2.4);
  }
}

function function_44d45595(var_dbce0c44) {
  if(zm_round_spawning::function_fab464c4(level.round_number)) {
    a_e_players = getplayers();

    if(level.var_f4b9daca < 3) {
      n_max = a_e_players.size * 8;
    } else {
      n_max = a_e_players.size * 10;
    }

    return n_max;
  }

  var_8cf00d40 = int(floor(var_dbce0c44 / 25));

  if(level.round_number < 20) {
    var_a5e820a7 = 0.02;
  } else if(level.round_number < 30) {
    var_a5e820a7 = 0.03;
  } else {
    var_a5e820a7 = 0.04;
  }

  n_max = min(var_8cf00d40, int(ceil(level.zombie_total * var_a5e820a7)));
  return n_max;
}

function function_55413772(s_spawn_loc) {
  level endon(#"end_game");
  var_c0ef5a0c = util::spawn_model("tag_origin", s_spawn_loc.origin, s_spawn_loc.angles);
  var_c0ef5a0c clientfield::increment("" + # "hash_3220b44880f1807c");
  wait 5;

  if(isDefined(var_c0ef5a0c)) {
    var_c0ef5a0c delete();
  }
}

function function_dfa96d1f(var_199d73cc = undefined) {
  s_spawn_loc = function_a58fe5b7(var_199d73cc);

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  ai = function_71f8127a(s_spawn_loc);
  return ai;
}

function function_71f8127a(s_spawn_loc) {
  level thread function_55413772(s_spawn_loc);
  wait 1;
  ai = spawnactor(#"hash_51edd7595ecda822", s_spawn_loc.origin, s_spawn_loc.angles);

  if(isDefined(ai)) {
    earthquake(0.5, 0.75, ai.origin, 1000);
    ai.no_powerups = 1;

    if(isDefined(s_spawn_loc.script_string)) {
      ai.script_string = s_spawn_loc.script_string;
      ai.find_flesh_struct_string = s_spawn_loc.script_string;
    }

    return ai;
  }

  return undefined;
}

function function_a58fe5b7(var_199d73cc = undefined) {
  s_spawn_loc = undefined;

  if(function_a1ef346b().size != 0) {
    if(isDefined(var_199d73cc)) {
      var_9769213d = var_199d73cc;
    } else if(isDefined(level.var_19441a5a)) {
      var_9769213d = [[level.var_19441a5a]](function_a1ef346b());
    } else {
      var_9769213d = array::random(function_a1ef346b());
    }

    var_a2105b2a = 0;

    while(var_a2105b2a <= 20 && isDefined(var_9769213d)) {
      if(isDefined(level.var_caddca10) && ![[level.var_caddca10]](var_9769213d)) {
        return undefined;
      }

      if(var_a2105b2a < 10) {
        var_ef8e1e71 = randomintrange(400, 1000);
        var_9d7713d9 = randomintrange(400, 1000);
      } else if(var_a2105b2a < 15) {
        var_ef8e1e71 = randomintrange(400, 1000) / 2;
        var_9d7713d9 = randomintrange(400, 1000) / 2;
      } else {
        var_ef8e1e71 = randomintrange(400, 1000) / 4;
        var_9d7713d9 = randomintrange(400, 1000) / 4;
      }

      if(isDefined(var_199d73cc) && var_a2105b2a < 15) {
        var_bf1cc8e2 = var_9769213d.origin + var_ef8e1e71 * anglesToForward((0, var_199d73cc.angles[1], 0));
        var_bf1cc8e2 += var_9d7713d9 / 4 * array::random([-1, 1]) * anglestoright((0, var_199d73cc.angles[1], 0));
        traceresult = groundtrace(var_bf1cc8e2, var_bf1cc8e2 + (0, 0, -100), 0, 0);

        if(isDefined(traceresult[# "position"])) {
          var_bf1cc8e2 = traceresult[# "position"];
        }
      } else {
        if(isvec(var_9769213d.origin)) {
          var_db8ceb36 = var_9769213d.origin[0] + var_ef8e1e71 * array::random([-1, 1]);
          var_c93ec69a = var_9769213d.origin[1] + var_9d7713d9 * array::random([-1, 1]);
          var_772fa27d = var_9769213d.origin[2];
          var_bf1cc8e2 = (var_db8ceb36, var_c93ec69a, var_772fa27d);
        } else {
          var_a2105b2a++;
        }

        traceresult = groundtrace(var_bf1cc8e2, var_bf1cc8e2 + (0, 0, -100), 0, 0);

        if(isDefined(traceresult[# "position"])) {
          var_bf1cc8e2 = traceresult[# "position"];
        }
      }

      spawn_loc = getclosestpointonnavmesh(var_bf1cc8e2, 100, 15);

      if(isDefined(spawn_loc)) {
        zone = zm_zonemgr::get_zone_from_position(spawn_loc);

        if(isarray(level.var_c9350d57)) {
          if(isDefined(zone) && isinarray(level.var_c9350d57, zone)) {
            return undefined;
          }
        }

        if(isDefined(zone)) {
          iprintlnbold(zone);
        }

        if(is_true(zm_zonemgr::zone_is_enabled(zone)) && is_true(level.zones[zone].is_active) && zm_utility::check_point_in_playable_area(spawn_loc)) {
          iprintlnbold(spawn_loc[0] + "<dev string:x6d>" + spawn_loc[1] + "<dev string:x6d>" + spawn_loc[2]);

          s_spawn_loc = spawnStruct();
          s_spawn_loc.origin = spawn_loc;
          s_spawn_loc.angles = vectortoangles(var_9769213d.origin - spawn_loc);
          break;
        }
      } else {
        var_a2105b2a++;
      }

      waitframe(1);
    }
  } else {
    if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
      iprintlnbold("<dev string:x38>");
    }

    return undefined;
  }

  return s_spawn_loc;
}

function function_d8461453() {
  s_spawn_loc = function_a58fe5b7();

  if(!isDefined(s_spawn_loc)) {
    return false;
  }

  if(isDefined(self) && isentity(self)) {
    self endon(#"death");
    level thread function_55413772(s_spawn_loc);
    wait 1;
    self zm_ai_utility::function_a8dc3363(s_spawn_loc);
    earthquake(0.5, 0.75, self.origin, 1000);
    self.no_powerups = 1;

    if(isDefined(s_spawn_loc.script_string)) {
      self.script_string = s_spawn_loc.script_string;
      self.find_flesh_struct_string = s_spawn_loc.script_string;
    }
  }

  return true;
}