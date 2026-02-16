/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_zone_manager.gsc
*****************************************************/

init() {
  level.zone_data = spawnStruct();
  level.zone_data.zones = [];
  level.zone_data.current_spawn_zones = [];
  level.zone_data.spawnfunc = ::calculaterandomspawnpoint;
}

iszoneenabled(var_0) {
  return isDefined(level.zone_data.zones) && isDefined(level.zone_data.zones[var_0]) && level.zone_data.zones[var_0].is_enabled;
}

isplayerinzone(var_0) {
  if(!iszoneenabled(var_0)) {
    return 0;
  }

  var_1 = level.zone_data.zones[var_0];

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator") {
      continue;
    }
    foreach(var_5 in var_1.volumes) {
      if(var_3 istouching(var_5)) {
        return 1;
      }
    }
  }

  return 0;
}

updateconnectiondistances() {
  level endon("game_ended");
  level notify("updating_connection_distances");
  level endon("updating_connection_distances");
  level.zone_data.connectionmap = [];

  foreach(var_1 in level.zone_data.zones) {
    foreach(var_3 in level.zone_data.zones) {
      if(var_1.zone_name == var_3.zone_name) {
        continue;
      }
      if(isDefined(level.zone_data.connectionmap[var_1.zone_name]) && isDefined(level.zone_data.connectionmap[var_1.zone_name][var_3.zone_name])) {
        continue;
      }
      getzoneconnectionlength(var_1.zone_name, var_3.zone_name);
      waitframe();
    }
  }

  if(isDefined(level.zone_is_contaminated_func)) {
    level.zone_data.infectedconnectionmap = [];

    foreach(var_1 in level.zone_data.zones) {
      foreach(var_3 in level.zone_data.zones) {
        if(var_1.zone_name == var_3.zone_name) {
          continue;
        }
        if(isDefined(level.zone_data.infectedconnectionmap[var_1.zone_name]) && isDefined(level.zone_data.infectedconnectionmap[var_1.zone_name][var_3.zone_name])) {
          continue;
        }
        getzoneinfectedconnectionlength(var_1.zone_name, var_3.zone_name);
        waitframe();
      }
    }
  }
}

registerconnectiondistance(var_0, var_1, var_2) {
  level.zone_data.connectionmap[var_0][var_1] = var_2;
  level.zone_data.connectionmap[var_1][var_0] = var_2;
}

getzoneconnectionlength(var_0, var_1) {
  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(level.zone_data.connectionmap)) {
    return -1;
  }

  if(isDefined(level.zone_data.connectionmap[var_0]) && isDefined(level.zone_data.connectionmap[var_0][var_1])) {
    return level.zone_data.connectionmap[var_0][var_1];
  }

  var_2[0]["zone"] = var_0;
  var_2[0]["distance"] = 0;

  while(var_2.size > 0) {
    var_3 = level.zone_data.zones[var_2[0]["zone"]];
    var_4 = var_2[0]["distance"];
    var_2 = maps\mp\zombies\_util::array_remove_index(var_2, 0);
    var_5[var_3.zone_name] = 1;

    foreach(var_7 in var_3.adjacent_zones) {
      if(isDefined(var_5[var_7.zone_name])) {
        continue;
      }
      if(var_7.is_connected) {
        var_8 = var_4 + 1;

        if(var_7.zone_name == var_1) {
          registerconnectiondistance(var_0, var_1, var_8);
          return var_8;
        }

        var_9 = -1;
        var_10 = -1;

        if(var_2.size == 0) {
          var_9 = 0;
        }

        for(var_11 = 0; var_11 < var_2.size; var_11++) {
          var_12 = var_2[var_11]["distance"] >= var_8;

          if(var_12 && var_9 < 0) {
            var_9 = var_11;
          }

          if(var_2[var_11]["zone"] == var_7.zone_name) {
            if(var_12) {
              var_10 = var_11;
            }

            break;
          }
        }

        if(var_10 >= 0) {
          var_2 = maps\mp\zombies\_util::array_remove_index(var_2, var_10);
        }

        if(var_11 == var_2.size && var_9 < 0) {
          var_9 = var_2.size;
        }

        if(var_9 >= 0) {
          var_13["zone"] = var_7.zone_name;
          var_13["distance"] = var_8;
          var_2 = common_scripts\utility::array_insert(var_2, var_13, var_9);
        }
      }
    }
  }

  return -1;
}

registerinfectedconnectiondistance(var_0, var_1, var_2) {
  level.zone_data.infectedconnectionmap[var_0][var_1] = var_2;
  level.zone_data.infectedconnectionmap[var_1][var_0] = var_2;
}

getzoneinfectedconnectionlength(var_0, var_1) {
  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(level.zone_data.connectionmap)) {
    return -1;
  }

  if(isDefined(level.zone_data.infectedconnectionmap[var_0]) && isDefined(level.zone_data.infectedconnectionmap[var_0][var_1])) {
    return level.zone_data.infectedconnectionmap[var_0][var_1];
  }

  var_2[0]["zone"] = var_0;
  var_2[0]["distance"] = 0;

  while(var_2.size > 0) {
    var_3 = level.zone_data.zones[var_2[0]["zone"]];
    var_4 = var_2[0]["distance"];
    var_2 = maps\mp\zombies\_util::array_remove_index(var_2, 0);
    var_5[var_3.zone_name] = 1;

    foreach(var_7 in var_3.adjacent_zones) {
      if(isDefined(var_5[var_7.zone_name])) {
        continue;
      }
      if([[level.zone_is_contaminated_func]](var_7.zone_name)) {
        continue;
      }
      if(var_7.is_connected) {
        var_8 = var_4 + 1;

        if(var_7.zone_name == var_1) {
          registerinfectedconnectiondistance(var_0, var_1, var_8);
          return var_8;
        }

        var_9 = -1;
        var_10 = -1;

        if(var_2.size == 0) {
          var_9 = 0;
        }

        for(var_11 = 0; var_11 < var_2.size; var_11++) {
          var_12 = var_2[var_11]["distance"] >= var_8;

          if(var_12 && var_9 < 0) {
            var_9 = var_11;
          }

          if(var_2[var_11]["zone"] == var_7.zone_name) {
            if(var_12) {
              var_10 = var_11;
            }

            break;
          }
        }

        if(var_10 >= 0) {
          var_2 = maps\mp\zombies\_util::array_remove_index(var_2, var_10);
        }

        if(var_11 == var_2.size && var_9 < 0) {
          var_9 = var_2.size;
        }

        if(var_9 >= 0) {
          var_13["zone"] = var_7.zone_name;
          var_13["distance"] = var_8;
          var_2 = common_scripts\utility::array_insert(var_2, var_13, var_9);
        }
      }
    }
  }

  return -1;
}

getplayerzonestruct() {
  if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
    return undefined;
  }

  foreach(var_5, var_1 in level.zone_data.zones) {
    foreach(var_3 in var_1.volumes) {
      if(self istouching(var_3)) {
        return var_1;
      }
    }
  }

  return undefined;
}

getplayerzone() {
  if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
    return undefined;
  }

  foreach(var_5, var_1 in level.zone_data.zones) {
    foreach(var_3 in var_1.volumes) {
      if(self istouching(var_3)) {
        return var_5;
      }
    }
  }

  return undefined;
}

getcurrentplayeroccupiedzones() {
  var_0 = [];

  foreach(var_2 in level.zone_data.zones) {
    if(isplayerinzone(var_2.zone_name)) {
      var_0[var_0.size] = var_2.zone_name;
    }
  }

  return var_0;
}

getcurrentplayeroccupiedzonestructs() {
  var_0 = [];

  foreach(var_2 in level.zone_data.zones) {
    if(isplayerinzone(var_2.zone_name)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

iszombieinanyzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    foreach(var_4 in var_2.volumes) {
      if(var_0 istouching(var_4)) {
        return 1;
      }
    }
  }

  return 0;
}

getzombiezone() {
  foreach(var_5, var_1 in level.zone_data.zones) {
    foreach(var_3 in var_1.volumes) {
      if(self istouching(var_3)) {
        return var_5;
      }
    }
  }

  return undefined;
}

iszombieinenabledzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    if(!iszoneenabled(var_2.zone_name)) {
      continue;
    }
    foreach(var_4 in var_2.volumes) {
      if(var_0 istouching(var_4)) {
        return 1;
      }
    }
  }

  return 0;
}

ispathnodeinanyzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    foreach(var_4 in var_2.volumes) {
      if(ispointinvolume(var_0.origin, var_4)) {
        return 1;
      }

      if(ispointinvolume(var_0.origin + (0, 0, 20), var_4)) {
        return 1;
      }
    }
  }

  return 0;
}

ispathnodeinenabledzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    if(!iszoneenabled(var_2.zone_name)) {
      continue;
    }
    foreach(var_4 in var_2.volumes) {
      if(ispointinvolume(var_0.origin, var_4)) {
        return 1;
      }

      if(ispointinvolume(var_0.origin + (0, 0, 20), var_4)) {
        return 1;
      }
    }
  }

  return 0;
}

ispointinanyzone(var_0, var_1) {
  var_2 = ispointinanyzonereturn(var_0, var_1);
  return isDefined(var_2);
}

ispointinanyzonereturn(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_3 in level.zone_data.zones) {
    if(var_1 && !iszoneenabled(var_3.zone_name)) {
      continue;
    }
    foreach(var_5 in var_3.volumes) {
      if(ispointinvolume(var_0, var_5)) {
        return var_3.zone_name;
      }
    }
  }

  return;
}

getlocationzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    foreach(var_4 in var_2.volumes) {
      if(ispointinvolume(var_0, var_4)) {
        return var_2.zone_name;
      }

      if(ispointinvolume(var_0 + (0, 0, 20), var_4)) {
        return var_2.zone_name;
      }
    }
  }

  return undefined;
}

anyzombiesinzone(var_0) {
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  if(var_1.size == 0) {
    return 0;
  }

  var_2 = level.zone_data.zones[var_0];

  foreach(var_4 in var_1) {
    foreach(var_6 in var_2.volumes) {
      if(var_4 istouching(var_6)) {
        return 1;
      }
    }
  }

  return 0;
}

getnumberofplayersinzone(var_0) {
  if(!iszoneenabled(var_0)) {
    return 0;
  }

  var_1 = level.zone_data.zones[var_0];
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4.sessionstate == "spectator") {
      continue;
    }
    foreach(var_6 in var_1.volumes) {
      if(var_4 istouching(var_6)) {
        var_2++;
        break;
      }
    }
  }

  return var_2;
}

getplayersinzone(var_0, var_1) {
  var_2 = [];

  if(!iszoneenabled(var_0)) {
    return var_2;
  }

  var_3 = level.zone_data.zones[var_0];
  var_4 = var_3.volumes;

  if(var_1) {
    foreach(var_6 in var_3.adjacent_zones) {
      var_7 = level.zone_data.zones[var_6.zone_name];

      if(iszoneenabled(var_7.zone_name)) {
        var_4 = common_scripts\utility::array_combine(var_4, var_7.volumes);
      }
    }
  }

  foreach(var_10 in level.players) {
    if(var_10.sessionstate == "spectator") {
      continue;
    }
    foreach(var_12 in var_4) {
      if(var_10 istouching(var_12)) {
        var_2[var_2.size] = var_10;
      }
    }
  }

  return var_2;
}

playerisinzone(var_0, var_1) {
  if(!iszoneenabled(var_1)) {
    return 0;
  }

  if(var_0.sessionstate == "spectator") {
    return 0;
  }

  var_2 = level.zone_data.zones[var_1];
  var_3 = var_2.volumes;

  foreach(var_5 in var_3) {
    if(var_0 istouching(var_5)) {
      return 1;
    }
  }

  return 0;
}

getnumberofzombiesinzone(var_0) {
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  if(var_1.size == 0) {
    return 0;
  }

  var_2 = level.zone_data.zones[var_0];
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(var_5.team != level.enemyteam) {
      continue;
    }
    foreach(var_7 in var_2.volumes) {
      if(var_5 istouching(var_7)) {
        var_3++;
        break;
      }
    }
  }

  return var_3;
}

initializezone(var_0, var_1) {
  if(isDefined(level.zone_data.zones[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = spawnStruct();
  var_2.adjacent_zones = [];
  var_2.is_occupied = 0;
  var_2.is_enabled = var_1;
  var_2.is_active = 0;
  var_2.zone_name = var_0;
  var_2.volumes = [];
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    if(var_5.classname == "info_volume") {
      var_2.volumes[var_2.volumes.size] = var_5;
    }
  }

  common_scripts\utility::flag_init(var_2.zone_name);

  if(var_1) {
    common_scripts\utility::flag_set(var_2.zone_name);
  }

  level.zone_data.zones[var_0] = var_2;
  var_2.power_switch = getpowerswitchinzone(var_0);
  var_7 = getspawnersinzone(var_0);
  var_2.zombie_spawners = filterspawnersfromlistbytype(var_7, "zombie_spawner");

  if(!isDefined(level.zombies_spawners_zombie)) {
    level.zombies_spawners_zombie = [];
  }

  level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie, var_2.zombie_spawners);

  if(maps\mp\zombies\_util::civiliansareenabled()) {
    var_2.civilian_extracts = filterspawnersfromlistbytype(var_7, "civilian_extract");
    var_2.civilian_spawners = filterspawnersfromlistbytype(var_7, "civilian_spawner");

    if(!isDefined(level.zombies_spawners_civilians)) {
      level.zombies_spawners_civilians = [];
    }

    level.zombies_spawners_civilians = common_scripts\utility::array_combine(level.zombies_spawners_civilians, var_2.civilian_spawners);
  }
}

getpowerswitchinzone(var_0) {
  var_1 = common_scripts\utility::getStructArray("power_switch", "targetname");

  foreach(var_3 in var_1) {
    if(isswitchinzonevolumes(var_3, level.zone_data.zones[var_0].volumes)) {
      return var_3;
    }
  }

  return undefined;
}

isswitchinzonevolumes(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin, var_3)) {
      return 1;
    }
  }

  return 0;
}

getspawnersinzone(var_0) {
  var_1 = [];

  foreach(var_3 in level.zone_data.zones[var_0].volumes) {
    if(!isDefined(var_3.target)) {
      continue;
    }
    var_4 = common_scripts\utility::getStructArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      var_6.zone_name = var_0;

      if(!common_scripts\utility::array_contains(var_1, var_6)) {
        var_1[var_1.size] = var_6;
      }
    }
  }

  return var_1;
}

filterspawnersfromlistbytype(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy != var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

addadjacentzone(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(level.flag[var_2])) {
    common_scripts\utility::flag_init(var_2);
  }

  makezoneadjacent(var_0, var_1, var_2, 0);
  makezoneadjacent(var_1, var_0, var_2, var_3);
}

makezoneadjacent(var_0, var_1, var_2, var_3) {
  var_4 = level.zone_data.zones[var_0];

  if(!isDefined(var_4.adjacent_zones[var_1])) {
    var_5 = spawnStruct();
    var_5.zone_name = var_1;
    var_5.flags[0] = var_2;
    var_5.is_connected = 0;
    var_5.oneway = var_3;
    var_4.adjacent_zones[var_1] = var_5;
  } else {
    var_6 = var_4.adjacent_zones[var_1];
    var_6.flags[var_6.flags.size] = var_2;
  }
}

activate(var_0) {
  if(isDefined(var_0)) {
    level.zone_data.spawnfunc = var_0;
  }

  foreach(var_2 in level.zone_data.zones) {
    foreach(var_5, var_4 in var_2.adjacent_zones) {
      level thread zonewaitforflags(var_2, var_5);
    }
  }

  level thread monitorspawnpointupdate();
}

monitorspawnpointupdate() {
  level endon("game_ended");
  var_0 = 1.0;

  for(;;) {
    level.zone_data.spawn_points_update_requested = 1;

    while(level.zone_data.spawn_points_update_requested) {
      waitframe();
    }

    wait(var_0);
  }
}

zonewaitforflags(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in var_0.adjacent_zones[var_1].flags) {
    level thread zonewaitforspecificflag(var_0, var_3, var_1);
  }
}

zonewaitforspecificflag(var_0, var_1, var_2) {
  level endon("game_ended");
  common_scripts\utility::flag_wait(var_1);
  var_3 = level.zone_data.zones[var_2];
  var_3.is_enabled = 1;
  common_scripts\utility::flag_set(var_0.zone_name);
  var_0.adjacent_zones[var_2].is_connected = 1;
  level thread updateconnectiondistances();
}

getcivilianpoint(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = getcurrentplayeroccupiedzones();

  for(var_5 = var_4.size; var_5 > 0; var_5--) {
    var_6 = var_4[var_3];
    var_7 = level.zone_data.zones[var_6];

    if(var_0) {
      var_2 = common_scripts\utility::array_combine(var_2, var_7.civilian_spawners);
    } else {
      var_2 = common_scripts\utility::array_combine(var_2, var_7.civilian_extracts);

      foreach(var_9 in var_2) {
        if(!isDefined(var_9.script_parameters)) {
          var_2 = common_scripts\utility::array_remove(var_2, var_9);
        }
      }
    }

    if(iszoneenabled(var_7.zone_name)) {
      foreach(var_12 in var_7.adjacent_zones) {
        if(!iszoneenabled(var_12.zone_name)) {
          if(!var_0) {
            continue;
          }
          if(var_12.oneway) {
            continue;
          }
        }

        if(!common_scripts\utility::array_contains(var_4, var_12.zone_name)) {
          var_4[var_4.size] = var_12.zone_name;
          var_5++;
        }
      }
    }

    var_3++;
  }

  var_2 = sortbydistance(var_2, var_1);

  for(var_14 = var_2.size - 1; var_14 >= 0; var_14--) {
    if(!isDefined(var_2[var_14].hasbeenused)) {
      var_2[var_14].hasbeenused = 1;
      return var_2[var_14];
    }
  }

  var_2[var_2.size - 1].hasbeenused = 1;
  return var_2[var_2.size - 1];
}

getspawnpoint(var_0, var_1) {
  if(!isDefined(level.zone_data)) {
    return undefined;
  }

  if(level.zone_data.spawn_points_update_requested) {
    level.zone_data.spawn_points_update_requested = 0;
    updatespawnpoints();
  }

  return [[level.zone_data.spawnfunc]](var_0, var_1);
}

updatespawnpoints() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.zone_data.zones) {
    if(!isDefined(var_0[var_3.zone_name])) {
      var_3.is_active = 0;
    }

    if(!var_3.is_enabled) {
      continue;
    }
    if(!isplayerinzone(var_3.zone_name)) {
      continue;
    }
    if(!isDefined(var_3.disablespawns)) {
      var_1[var_1.size] = var_3.zone_name;
    }

    var_3.is_active = 1;
    var_0[var_3.zone_name] = 1;

    foreach(var_5 in var_3.adjacent_zones) {
      if(!var_5.is_connected || isDefined(var_0[var_5.zone_name])) {
        continue;
      }
      var_6 = level.zone_data.zones[var_5.zone_name];

      if(!var_6.is_enabled) {
        continue;
      }
      var_1[var_1.size] = var_5.zone_name;
      var_0[var_5.zone_name] = 1;
      var_6.is_active = 1;
    }
  }

  level.zone_data.current_spawn_zones = var_1;
}

calculaterandomspawnpoint(var_0, var_1) {
  if(isDefined(level.randomspawnpointoverride) && isDefined(level.randomspawnpointoverride[var_0])) {
    return [[level.randomspawnpointoverride[var_0]]]();
  }

  if(level.zone_data.current_spawn_zones.size == 0) {
    return undefined;
  }

  var_2 = level.zone_data.current_spawn_zones;
  var_3 = undefined;

  for(var_4 = []; var_2.size > 0; var_4 = []) {
    var_5 = randomint(var_2.size);
    var_6 = level.zone_data.zones[var_2[var_5]];
    var_2 = maps\mp\zombies\_util::array_remove_index(var_2, var_5);

    foreach(var_8 in var_6.zombie_spawners) {
      if(var_8 spawnercanbeusedfor(var_0, var_1)) {
        var_4[var_4.size] = var_8;
      }
    }

    if(var_4.size > 0) {
      break;
    }
  }

  if(var_4.size == 0) {
    var_10 = "";

    foreach(var_6 in level.zone_data.current_spawn_zones) {
      var_10 = var_10 + (var_6 + " ");
    }

    var_5 = randomint(level.zone_data.current_spawn_zones.size);
    var_13 = level.zone_data.current_spawn_zones[var_5];
    var_3 = common_scripts\utility::random(var_13.zombie_spawners);
  } else {
    var_3 = common_scripts\utility::random(var_4);
  }

  return var_3;
}

calculateweightedspawnpoint(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.zone_data.current_spawn_zones) {
    var_5 = level.zone_data.zones[var_4];
    var_2 = common_scripts\utility::array_combine(var_2, var_5.zombie_spawners);
  }

  var_7 = maps\mp\zombies\_zombies_spawnscoring::getzombiesspawnpoint_aizombies(var_2, var_0, var_1);
  var_7.lastspawntime = gettime();
  return var_7;
}

spawnercanbeusedfor(var_0, var_1) {
  if(isDefined(self.script_parameters)) {
    var_2 = strtok(self.script_parameters, " ,");
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_2) {
      if(var_6 == var_0) {
        var_3 = 1;
      }

      if(var_6 == "exclusive") {
        var_4 = 1;
      }
    }

    if(!var_3 && (var_4 || var_1)) {
      return 0;
    }
  } else if(var_1) {
    return 0;
  }

  return 1;
}