/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zod\cp_zod_hub_spawning.gsc
**********************************************************/

main() {
  _id_06CB::_id_0FA4("start_hub_zombie_spawning", ::start_hub_zombie_spawning);
  _id_06CB::_id_0FA4("cleanup_hub_spawned_zombies", ::cleanup_hub_spawned_zombies);
  level.hub_max_zombies_per_zone = 2;
  level.hub_max_active_zombies = 10;
  level.zombies_spawned_before_screamer = 0;
  level.zombies_to_spawn_before_screamer = randomintrange(4, 8);
  var_0 = scripts\engine\utility::getstruct("hub_fob_spawn_zones", "targetname");

  if(isDefined(var_0)) {
    level.a_hub_fob_spawn_zones = var_0 scripts\engine\utility::_id_67A9();
  }

  var_1 = scripts\engine\utility::getstruct("hub_theater_spawn_zones", "targetname");

  if(isDefined(var_1)) {
    level.a_hub_theater_spawn_zones = var_1 scripts\engine\utility::_id_67A9();
  }

  var_2 = scripts\engine\utility::getstruct("hub_basement_spawn_zones", "targetname");

  if(isDefined(var_2)) {
    level.a_hub_basement_spawn_zones = var_2 scripts\engine\utility::_id_67A9();
  }

  var_3 = scripts\engine\utility::getstruct("aprtment_first_floor_spawn_zones", "targetname");

  if(isDefined(var_3)) {
    level.a_apartment_first_floor_spawners_spawners = var_3 scripts\engine\utility::_id_67A9();
  }

  var_4 = scripts\engine\utility::getstruct("aprtment_second_floor_spawn_zones", "targetname");

  if(isDefined(var_4)) {
    level.a_apartment_second_floor_spawners_spawners = var_4 scripts\engine\utility::_id_67A9();
  }
}

start_hub_zombie_spawning(var_0) {
  setdvarifuninitialized("#x3f2912c14601909d7", -1);
  level.hub_spawned_zombies = 0;

  if(!isDefined(level._id_11049)) {
    level._id_11049 = 1;
  }

  set_zombie_numbers_for_hub_spawning();

  if(getdvarint("#x3f2912c14601909d7") != 1) {
    wait(var_0._id_4649);
    level.hub_total_spawned_zombies = 0;
    get_array_of_hub_spawning_zones();

    if(isDefined(var_0._id_A8C7)) {
      spawn_ai_at_portal_location(var_0);
    }

    if(isDefined(var_0._id_0DF5)) {
      foreach(var_2 in var_0._id_0DF5) {
        var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");
        var_3 = scripts\engine\utility::array_randomize(var_3);
        spawn_hub_zombies_at_locs(var_3, var_2);
        level.a_hub_spawning_zones = scripts\engine\utility::array_remove(level.a_hub_spawning_zones, var_2);
      }
    }

    if(isDefined(level.a_hub_spawning_zones) && level.a_hub_spawning_zones.size >= 1) {
      var_5 = validate_spawn_locs(1000000, 6250000);

      for(var_6 = 0; level.hub_total_spawned_zombies < level.hub_max_active_zombies; var_6 = var_6 + 1) {
        if(var_6 >= var_5.size) {
          var_6 = 0;
          var_5 = validate_spawn_locs(6250001, 25000000);
        }

        var_7 = var_5[var_6];
        var_2 = getent(var_7._id_0481, "target");
        var_8 = "enemy_base_zombie_cp";
        var_9 = spawn_zombie(var_8, var_7.origin, var_7.angles, var_7, var_2);
        var_9 scripts\aitypes\zombie_common\awareness::set_unaware();
        var_9 thread set_zombie_movement_speed();
        level.hub_total_spawned_zombies = level.hub_total_spawned_zombies + 1;
        level.hub_spawned_zombies = level.hub_spawned_zombies + 1;
        level.zombies_spawned_before_screamer = level.zombies_spawned_before_screamer + 1;
      }
    }

    level thread maintain_active_zombie_count();
  }
}

spawn_ai_at_portal_location(var_0) {
  var_1 = var_0._id_A8C7;
  var_2 = getEntArray("portal_spawner_zone", "script_noteworthy");
  var_3 = _func_0204(var_2, var_1);
  var_4 = var_3[0];
  var_5 = scripts\engine\utility::getstructarray(var_4.target, "targetname");
  var_5 = scripts\engine\utility::array_randomize(var_5);
  spawn_hub_zombies_at_locs(var_5, var_4);
}

get_array_of_hub_spawning_zones() {
  level.a_hub_spawning_zones = getEntArray("hub_zombie_spawning_trigger", "script_noteworthy");
  level.a_hub_spawning_zones = scripts\engine\utility::array_randomize(level.a_hub_spawning_zones);
  level.a_hub_spawning_locs = [];

  foreach(var_1 in level.a_hub_spawning_zones) {
    var_2 = scripts\engine\utility::getstructarray(var_1.target, "targetname");
    level.a_hub_spawning_locs = scripts\engine\utility::array_combine(var_2, level.a_hub_spawning_locs);
  }
}

spawn_hub_zombies_at_locs(var_0, var_1) {
  var_2 = 0;
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_4 in var_0) {
    if(var_2 < level.hub_max_zombies_per_zone && level.hub_total_spawned_zombies < level.hub_max_active_zombies) {
      var_5 = "enemy_base_zombie_cp";
      var_6 = spawn_zombie(var_5, var_4.origin, var_4.angles, var_4, var_1);
      var_6 scripts\aitypes\zombie_common\awareness::set_unaware();
      var_6 thread set_zombie_movement_speed();
      var_2 = var_2 + 1;
      level.hub_total_spawned_zombies = level.hub_total_spawned_zombies + 1;
      level.hub_spawned_zombies = level.hub_spawned_zombies + 1;
      level.zombies_spawned_before_screamer = level.zombies_spawned_before_screamer + 1;
    }
  }
}

maintain_active_zombie_count() {
  level endon("stop_hub_spawning");

  if(!isDefined(level.hub_max_spawned_zombies)) {
    level.hub_max_spawned_zombies = 30;
  }

  while(level.hub_spawned_zombies < level.hub_max_spawned_zombies) {
    var_0 = _func_0070("axis");

    if(var_0.size < level.hub_max_active_zombies) {
      var_1 = level.hub_max_active_zombies - var_0.size;

      if(level.hub_spawned_zombies + var_1 > level.hub_max_spawned_zombies) {
        var_1 = level.hub_max_spawned_zombies - level.hub_spawned_zombies;
      }

      spawn_active_zombies(var_1);
    }

    wait 0.5;
  }
}

spawn_active_zombies(var_0) {
  var_1 = validate_spawn_locs(250000, 1562500);

  for(var_2 = 1; var_2 <= var_0; var_2++) {
    if(var_2 <= var_1.size) {
      var_3 = var_1[var_2 - 1];
      var_4 = scripts\engine\utility::getstruct(var_3._id_0481, "target");
      var_5 = var_3 scripts\cp\utility::_id_63E3();
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_7 = vectornormalize(var_5.origin - var_3.origin);
        var_6 = vectortoangles(var_7);
      }

      var_8 = select_zombie_type_to_spawn();
      var_9 = spawn_zombie(var_8, var_3.origin, var_6, var_3, var_4);
      var_9 thread set_zombie_movement_speed();
      level.hub_spawned_zombies = level.hub_spawned_zombies + 1;
      level.zombies_spawned_before_screamer = level.zombies_spawned_before_screamer + 1;
      var_10 = _func_0070("axis");
      var_10 = _func_0204(var_10, var_9.origin);

      foreach(var_12 in var_10) {
        if(var_12 != var_9) {
          var_13 = distancesquared(var_12.origin, var_9.origin);

          if(var_13 <= 90000 && abs(var_12.origin[2] - var_9.origin[2]) <= 96) {
            var_12 set_zombie_to_combat(var_5);
          } else {
            break;
          }
        }
      }
    }
  }
}

spawn_zombie(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_hub_spawning");
  var_5 = _id_09A4::_id_110AD(var_0, var_1, var_2, var_3, var_4);

  while(!isDefined(var_5)) {
    waitframe();
  }

  var_5.hub_spawned = 1;
  return var_5;
}

validate_spawn_locs(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.a_hub_spawning_locs) {
    var_5 = 0;
    var_6 = 0;

    foreach(var_8 in level.players) {
      var_9 = distance2dsquared(var_4.origin, var_8.origin);

      if(var_9 < 250000) {
        var_5 = 1;
        break;
      }

      var_10 = abs(var_8.origin[2] - var_4.origin[2]);

      if(var_10 > 96 || var_9 > 1562500) {
        var_6 = var_6 + 1;
      }
    }

    if(var_5 != 1 && var_6 < level.players.size) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }

    throttle_validating_spawn_locs();
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  return var_2;
}

throttle_validating_spawn_locs() {
  if(!isDefined(level.spawn_loc_throttling_iterations)) {
    level.spawn_loc_throttling_iterations = 0;
  }

  level.spawn_loc_throttling_iterations = level.spawn_loc_throttling_iterations + 1;

  if(level.spawn_loc_throttling_iterations >= 50) {
    level.spawn_loc_throttling_iterations = 0;
    waitframe();
  }
}

set_zombie_to_combat(var_0) {
  var_1 = self;
  var_1 scripts\aitypes\zombie_common\awareness::set_aware();

  if(isDefined(var_0)) {
    var_1._id_012F = var_0;
  }

  var_1._id_7D68 = 1;
}

cleanup_hub_spawned_zombies() {
  level notify("stop_hub_spawning");
  var_0 = _func_0070("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.hub_spawned) && var_2.hub_spawned == 1) {
      var_2 _meth_81FA();
    }
  }
}

set_zombie_numbers_for_hub_spawning() {
  var_0 = level.players.size;
  var_1 = level._id_11049;

  if(var_1 > 15) {
    var_1 = 15;
  }

  var_2 = var_0 * 3 - 2;
  var_3 = var_2 + 1;
  var_4 = var_2 + 2;
  level.hub_max_zombies_per_zone = int(tablelookupbyrow("cp/zombies/cp_zod_hub_spawning_numbers.csv", var_1 - 1, var_2));
  level.hub_max_active_zombies = int(tablelookupbyrow("cp/zombies/cp_zod_hub_spawning_numbers.csv", var_1 - 1, var_3));
  level.max_spawned_zombies = int(tablelookupbyrow("cp/zombies/cp_zod_hub_spawning_numbers.csv", var_1 - 1, var_4));
}

select_zombie_type_to_spawn() {
  var_0 = "enemy_base_zombie_cp";

  if(level.zombies_spawned_before_screamer >= level.zombies_to_spawn_before_screamer) {
    var_0 = "enemy_zombie_screamer_cp";
    level.zombies_spawned_before_screamer = 0;
    level.zombies_to_spawn_before_screamer = randomintrange(4, 8);
  }

  return var_0;
}

set_zombie_movement_speed() {
  var_0 = self;

  if(var_0._id_1210 == "actor_enemy_base_zombie_cp") {
    var_1 = 0;
    var_2 = 0;

    if(level._id_11049 > 1) {
      var_2 = 0.25;
    }

    if(level._id_11049 > 3) {
      var_2 = 0.5;
      var_1 = 0.1;
    }

    if(level._id_11049 > 6) {
      var_2 = 0.75;
      var_1 = 0.2;
    }

    if(level._id_11049 > 9) {
      var_2 = 1;
      var_1 = 0.33;
    }

    if(level._id_11049 > 12) {
      var_2 = 1;
      var_1 = 0.5;
    }

    if(level._id_11049 > 15) {
      var_2 = 1;
      var_1 = 0.66;
    }

    if(level._id_11049 > 18) {
      var_2 = 1;
      var_1 = 0.75;
    }

    if(level._id_11049 > 21) {
      var_2 = 1;
      var_1 = 1;
    }

    var_3 = randomfloat(1);

    if(var_1 > 0 && var_3 <= var_1) {
      var_0[[var_0._id_D603]]("sprint");
    } else if(var_2 > 0 && var_3 <= var_2) {
      var_0[[var_0._id_D603]]("run");
    } else {
      var_0[[var_0._id_D603]]("walk");
    }
  }
}