/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\spawners\zone_spawner.gsc
*************************************************/

init_zone_spawner() {
  scripts\cp\spawners\agent_spawner::register_spawner("zone", ::_id_E0AC);
  level.spawner_zone_map = [];
  level.zone_spawn_locations = scripts\engine\utility::getstructarray("zone_agent_spawn", "targetname");

  if(level.zone_spawn_locations.size > 0) {
    foreach(var_1 in level.zone_spawn_locations) {
      var_1.zone_name = var_1.target;

      if(isDefined(var_1._id_039B)) {
        var_1._id_12FA = strtok(var_1._id_039B, "|");
      }

      level.spawner_zone_map[var_1.zone_name] = ::scripts\engine\utility::_id_1B8D(level.spawner_zone_map[var_1.zone_name], var_1);
    }
  } else {
    level.zone_spawn_locations = [];

    foreach(var_5, var_4 in scripts\cp\zone_manager::get_all_zones()) {
      var_1 = spawnStruct();
      var_1.origin = scripts\common\utility::groundpos(var_4.origin);
      var_1.zone_name = var_5;
      level.zone_spawn_locations = scripts\engine\utility::array_add(level.zone_spawn_locations, var_1);
      level.spawner_zone_map[var_1.zone_name] = ::scripts\engine\utility::_id_1B8D(level.spawner_zone_map[var_1.zone_name], var_1);
    }
  }
}

_id_E0AC(var_0) {
  var_1 = select_spawn_loc(var_0);
  var_2 = var_1.origin;
  var_3 = scripts\cp\utility::_id_459B(var_1.angles, (0, 0, 0));
  var_4 = _id_09A4::_id_110AD(var_0, var_2, var_3, var_1);

  if(isDefined(var_4)) {
    var_1._id_8F5E = gettime();
    var_4.spawn_loc = var_1;
  }

  return var_4;
}

get_spawn_locs_in_zones(var_0, var_1) {
  var_2 = [];

  if(isDefined(level.zone_spawn_locations) && var_0.size > 0) {
    foreach(var_4 in level.zone_spawn_locations) {
      if(isDefined(var_1) && isDefined(var_4._id_12FA) && !scripts\engine\utility::array_contains(var_4._id_12FA, var_1)) {
        continue;
      }
      foreach(var_6 in var_0) {
        if(var_4.zone_name == var_6.script_zone_name) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
          break;
        }
      }
    }
  }

  return var_2;
}

select_spawn_loc(var_0) {
  var_1 = select_zones();
  var_2 = [];
  var_3 = [];

  foreach(var_8 in var_1) {
    var_9 = level.spawner_zone_map[var_8.script_zone_name];

    if(isDefined(var_9)) {
      foreach(var_5 in var_9) {
        if(isDefined(var_5._id_12FA) && !scripts\engine\utility::array_contains(var_5._id_12FA, var_0)) {
          continue;
        }
        var_3 = scripts\engine\utility::array_add(var_3, var_5);

        if(isDefined(var_5._id_8F5E) && gettime() < var_5._id_8F5E + 3000) {
          continue;
        }
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
      }
    }
  }

  if(var_2.size > 0) {
    return scripts\engine\utility::array_random(var_2);
  } else if(var_3.size > 0) {
    return scripts\engine\utility::array_random(var_3);
  }

  return scripts\engine\utility::array_random(level.zone_spawn_locations);
}

select_zones() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!scripts\cp\utility::_id_8677(var_2)) {
      continue;
    }
    var_3 = var_2 scripts\cp\zone_manager::_id_642F();

    if(isDefined(var_3)) {
      var_4 = spawnStruct();
      var_4.player = var_2;
      var_4.num_zombies = 0;
      var_4._id_110CF = var_3;
      var_0[var_2 getentitynumber()] = var_4;
    }
  }

  var_6 = _func_0070(level._id_11056);

  foreach(var_8 in var_6) {
    if(!isDefined(var_8) || !isalive(var_8)) {
      continue;
    }
    if(isDefined(var_8._id_0192)) {
      var_9 = var_8._id_0192 getentitynumber();

      if(isDefined(var_0[var_9])) {
        var_0[var_9].num_zombies++;
      }

      continue;
    }

    var_10 = var_8 scripts\cp\zone_manager::_id_642F();

    if(!isDefined(var_10) && isDefined(var_8.spawn_loc) && isDefined(var_8.spawn_loc.zone_name)) {
      var_10 = scripts\cp\zone_manager::get_zone_struct(var_8.spawn_loc.zone_name);
    }

    if(!isDefined(var_10)) {
      continue;
    }
    foreach(var_4 in var_0) {
      if(var_4._id_110CF == var_10) {
        var_4.num_zombies++;
      }
    }
  }

  var_14 = undefined;

  foreach(var_4 in var_0) {
    if(!isDefined(var_14) || var_4.num_zombies < var_14.num_zombies) {
      var_14 = var_4;
    }
  }

  var_17 = [];

  if(isDefined(var_14) && isDefined(var_14._id_110CF)) {
    var_17 = scripts\engine\utility::array_add(var_17, var_14._id_110CF);
    var_18 = var_14._id_110CF scripts\cp\zone_manager::get_adjacent_zones(1, 1);
    var_17 = scripts\engine\utility::array_combine(var_17, var_18);
  }

  return var_17;
}