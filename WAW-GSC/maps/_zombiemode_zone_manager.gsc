/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_zone_manager.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;

player_in_zone(zone_name) {
  if(!isDefined(level.zones[zone_name])) {
    return false;
  }
  zone = level.zones[zone_name];

  players = get_players();
  {
    for(i = 0; i < zone.volumes.size; i++) {
      for(j = 0; j < players.size; j++) {
        if(players[j] IsTouching(zone.volumes[i])) {
          return true;
        }
      }
    }
  }
  return false;
}
deactivate_initial_barrier_goals() {
  special_goals = getStructArray("exterior_goal", "targetname");
  for(i = 0; i < special_goals.size; i++) {
    if(isDefined(special_goals[i].script_noteworthy)) {
      special_goals[i].is_active = undefined;
      special_goals[i] trigger_off();
    }
  }
}
activate_barrier_goals(barrier_name, key) {
  entry_points = getStructArray(barrier_name, key);

  for(i = 0; i < entry_points.size; i++) {
    entry_points[i].is_active = 1;
    entry_points[i] trigger_on();
  }
}
zone_init(zone_name) {
  if(isDefined(level.zones[zone_name])) {
    return;
  }

  level.zones[zone_name] = spawnStruct();
  level.zones[zone_name].is_enabled = false;
  level.zones[zone_name].is_occupied = false;
  level.zones[zone_name].is_active = false;
  level.zones[zone_name].adjacent_zones = [];
  level.zones[zone_name].volumes = getEntArray(zone_name, "targetname");

  assertEx(isDefined(level.zones[zone_name].volumes[0]), "zone_init: No volumes found for zone: " + zone_name);

  if(isDefined(level.zones[zone_name].volumes[0].target)) {
    level.zones[zone_name].spawners = [];
    level.zones[zone_name].dog_spawners = [];

    spawners = getEntArray(level.zones[zone_name].volumes[0].target, "targetname");
    for(i = 0; i < spawners.size; i++) {
      if(issubstr(spawners[i].classname, "dog")) {
        level.zones[zone_name].dog_spawners = add_to_array(level.zones[zone_name].dog_spawners, spawners[i]);
      } else {
        level.zones[zone_name].spawners = add_to_array(level.zones[zone_name].spawners, spawners[i]);
      }
    }

    level.zones[zone_name].dog_locations = getStructArray(level.zones[zone_name].volumes[0].target + "_dog", "targetname");

    level.zones[zone_name].rise_locations = getStructArray(level.zones[zone_name].volumes[0].target + "_rise", "targetname");
  }
}
enable_zone(zone_name) {
  level.zones[zone_name].is_enabled = true;

  spawn_points = getStructArray("player_respawn_point", "targetname");
  for(i = 0; i < spawn_points.size; i++) {
    if(spawn_points[i].script_noteworthy == zone_name) {
      spawn_points[i].locked = false;
    }
  }

  activate_barrier_goals(zone_name + "_barriers", "script_noteworthy");
}
add_adjacent_zone(zone_name_a, zone_name_b, flag_name, one_way) {
  if(!isDefined(one_way)) {
    one_way = false;
  }

  zone_init(zone_name_a);
  zone_init(zone_name_b);

  if(!isDefined(level.zones[zone_name_a].adjacent_zones[zone_name_b])) {
    level.zones[zone_name_a].adjacent_zones[zone_name_b] = spawnStruct();
    level.zones[zone_name_a].adjacent_zones[zone_name_b].is_connected = false;
    level.zones[zone_name_a].adjacent_zones[zone_name_b].flags_do_or_check = false;
    if(IsArray(flag_name)) {
      level.zones[zone_name_a].adjacent_zones[zone_name_b].flags = flag_name;
    } else {
      level.zones[zone_name_a].adjacent_zones[zone_name_b].flags[0] = flag_name;
    }
  } else {
    assertEx(!IsArray(flag_name), "add_adjacent_zone: can't mix single and arrays of flags");
    size = level.zones[zone_name_a].adjacent_zones[zone_name_b].flags.size;
    level.zones[zone_name_a].adjacent_zones[zone_name_b].flags[size] = flag_name;
    level.zones[zone_name_a].adjacent_zones[zone_name_b].flags_do_or_check = true;
  }

  if(!one_way) {
    if(!isDefined(level.zones[zone_name_b].adjacent_zones[zone_name_a])) {
      level.zones[zone_name_b].adjacent_zones[zone_name_a] = spawnStruct();
      level.zones[zone_name_b].adjacent_zones[zone_name_a].is_connected = false;
      level.zones[zone_name_b].adjacent_zones[zone_name_a].flags_do_or_check = false;
      if(IsArray(flag_name)) {
        level.zones[zone_name_b].adjacent_zones[zone_name_a].flags = flag_name;
      } else {
        level.zones[zone_name_b].adjacent_zones[zone_name_a].flags[0] = flag_name;
      }
    } else {
      assertEx(!IsArray(flag_name), "add_adjacent_zone: can't mix single and arrays of flags");
      size = level.zones[zone_name_b].adjacent_zones[zone_name_a].flags.size;
      level.zones[zone_name_b].adjacent_zones[zone_name_a].flags[size] = flag_name;
      level.zones[zone_name_b].adjacent_zones[zone_name_a].flags_do_or_check = true;
    }
  }
}
setup_zone_flag_waits() {
  flags = [];
  for(z = 0; z < level.zones.size; z++) {
    zkeys = GetArrayKeys(level.zones);
    for(az = 0; az < level.zones[zkeys[z]].adjacent_zones.size; az++) {
      azkeys = GetArrayKeys(level.zones[zkeys[z]].adjacent_zones);
      for(f = 0; f < level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags.size; f++) {
        no_dupes = array_check_for_dupes(flags, level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags[f]);
        if(no_dupes) {
          flags = add_to_array(flags, level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags[f]);
        }
      }
    }
  }

  for(i = 0; i < flags.size; i++) {
    level thread zone_flag_wait(flags[i]);
  }
}
zone_flag_wait(flag_name) {
  if(!isDefined(level.flag[flag_name])) {
    flag_init(flag_name);
  }
  flag_wait(flag_name);

  for(z = 0; z < level.zones.size; z++) {
    zkeys = GetArrayKeys(level.zones);
    for(az = 0; az < level.zones[zkeys[z]].adjacent_zones.size; az++) {
      azkeys = GetArrayKeys(level.zones[zkeys[z]].adjacent_zones);

      if(!level.zones[zkeys[z]].adjacent_zones[azkeys[az]].is_connected) {
        if(level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags_do_or_check) {
          flags_set = false;
          for(f = 0; f < level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags.size; f++) {
            if(flag(level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags[f])) {
              flags_set = true;
              break;
            }
          }
          if(flags_set) {
            level.zones[zkeys[z]].adjacent_zones[azkeys[az]].is_connected = true;
            if(!level.zones[azkeys[az]].is_enabled) {
              enable_zone(azkeys[az]);
            }
          }
        } else {
          flags_set = true;
          for(f = 0; f < level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags.size; f++) {
            if(!flag(level.zones[zkeys[z]].adjacent_zones[azkeys[az]].flags[f])) {
              flags_set = false;
            }
          }
          if(flags_set) {
            level.zones[zkeys[z]].adjacent_zones[azkeys[az]].is_connected = true;
            if(!level.zones[azkeys[az]].is_enabled) {
              enable_zone(azkeys[az]);
            }
          }
        }
      }
    }
  }
}
connect_zones(zone_name_a, zone_name_b, one_way) {
  if(!isDefined(one_way)) {
    one_way = false;
  }

  zone_init(zone_name_a);
  zone_init(zone_name_b);

  enable_zone(zone_name_a);
  enable_zone(zone_name_b);

  if(!isDefined(level.zones[zone_name_a].adjacent_zones[zone_name_b])) {
    level.zones[zone_name_a].adjacent_zones[zone_name_b] = spawnStruct();
    level.zones[zone_name_a].adjacent_zones[zone_name_b].is_connected = true;
  }

  if(!one_way) {
    if(!isDefined(level.zones[zone_name_b].adjacent_zones[zone_name_a])) {
      level.zones[zone_name_b].adjacent_zones[zone_name_a] = spawnStruct();
      level.zones[zone_name_b].adjacent_zones[zone_name_a].is_connected = true;
    }
  }
}
manage_zones(initial_zone) {
  assertEx(isDefined(initial_zone), "You must specify an initial zone to manage");

  deactivate_initial_barrier_goals();

  level.zones = [];
  if(isDefined(level.zone_manager_init_func)) {
    [[level.zone_manager_init_func]]();
  }

  if(IsArray(initial_zone)) {
    for(i = 0; i < initial_zone.size; i++) {
      zone_init(initial_zone[i]);
      enable_zone(initial_zone[i]);
    }
  } else {
    zone_init(initial_zone);
    enable_zone(initial_zone);
  }

  setup_zone_flag_waits();

  while(getdvarint("noclip") == 0 || getdvarint("notarget") != 0) {
    zkeys = GetArrayKeys(level.zones);

    for(z = 0; z < zkeys.size; z++) {
      level.zones[zkeys[z]].is_active = false;
      level.zones[zkeys[z]].is_occupied = false;
    }

    a_zone_is_active = false;
    for(z = 0; z < zkeys.size; z++) {
      if(!level.zones[zkeys[z]].is_enabled) {
        continue;
      }

      level.zones[zkeys[z]].is_occupied = player_in_zone(zkeys[z]);
      if(level.zones[zkeys[z]].is_occupied) {
        level.zones[zkeys[z]].is_active = true;
        a_zone_is_active = true;
        for(az = 0; az < level.zones[zkeys[z]].adjacent_zones.size; az++) {
          azkeys = GetArrayKeys(level.zones[zkeys[z]].adjacent_zones);
          if(level.zones[zkeys[z]].adjacent_zones[azkeys[az]].is_connected) {
            level.zones[azkeys[az]].is_active = true;
          }
        }
      }
    }

    if(!a_zone_is_active) {
      level.zones["receiver_zone"].is_active = true;
      level.zones["receiver_zone"].is_occupied = true;
    }

    for(z = 0; z < zkeys.size; z++) {
      zone_name = zkeys[z];

      if(!level.zones[zkeys[z]].is_enabled) {
        continue;
      }

      if(level.zones[zone_name].is_active) {
        if(level.zones[zone_name].spawners.size > 0) {
          no_dupes = array_check_for_dupes(level.enemy_spawns, level.zones[zone_name].spawners[0]);
          if(no_dupes) {
            for(x = 0; x < level.zones[zone_name].spawners.size; x++) {
              level.zones[zone_name].spawners[x].locked_spawner = false;
              level.enemy_spawns = add_to_array(level.enemy_spawns, level.zones[zone_name].spawners[x]);
            }
          }
        }

        if(level.zones[zone_name].dog_spawners.size > 0) {
          no_dupes = array_check_for_dupes(level.enemy_dog_spawns, level.zones[zone_name].dog_spawners[0]);
          if(no_dupes) {
            for(x = 0; x < level.zones[zone_name].dog_spawners.size; x++) {
              level.enemy_dog_spawns = add_to_array(level.enemy_dog_spawns, level.zones[zone_name].dog_spawners[x]);
            }
          }
        }

        if(level.zones[zone_name].dog_locations.size > 0) {
          no_dupes = array_check_for_dupes(level.enemy_dog_locations, level.zones[zone_name].dog_locations[0]);
          if(no_dupes) {
            for(x = 0; x < level.zones[zone_name].dog_locations.size; x++) {
              level.zones[zone_name].dog_locations[x].locked_spawner = false;
              level.enemy_dog_locations = add_to_array(level.enemy_dog_locations, level.zones[zone_name].dog_locations[x]);
            }
          }
        }

        if(level.zones[zone_name].rise_locations.size > 0) {
          no_dupes = array_check_for_dupes(level.zombie_rise_spawners, level.zones[zone_name].rise_locations[0]);
          if(no_dupes) {
            for(x = 0; x < level.zones[zone_name].rise_locations.size; x++) {
              level.zones[zone_name].rise_locations[x].locked_spawner = false;
              level.zombie_rise_spawners = add_to_array(level.zombie_rise_spawners, level.zones[zone_name].rise_locations[x]);
            }
          }
        }
      } else {
        if(level.zones[zone_name].spawners.size > 0) {
          no_dupes = array_check_for_dupes(level.enemy_spawns, level.zones[zone_name].spawners[0]);
          if(!no_dupes) {
            for(x = 0; x < level.zones[zone_name].spawners.size; x++) {
              level.zones[zone_name].spawners[x].locked_spawner = true;
              level.enemy_spawns = array_remove_nokeys(level.enemy_spawns, level.zones[zone_name].spawners[x]);
            }
          }
        }

        if(level.zones[zone_name].dog_spawners.size > 0) {
          no_dupes = array_check_for_dupes(level.enemy_dog_spawns, level.zones[zone_name].dog_spawners[0]);
          if(!no_dupes) {
            for(x = 0; x < level.zones[zone_name].dog_spawners.size; x++) {
              level.enemy_dog_spawns = array_remove_nokeys(level.enemy_dog_spawns, level.zones[zone_name].dog_spawners[x]);
            }
          }
        }

        if(level.zones[zone_name].dog_locations.size > 0) {
          no_dupes = array_check_for_dupes(level.enemy_dog_locations, level.zones[zone_name].dog_locations[0]);
          if(!no_dupes) {
            for(x = 0; x < level.zones[zone_name].dog_locations.size; x++) {
              level.zones[zone_name].dog_locations[x].locked_spawner = false;
              level.enemy_dog_locations = array_remove_nokeys(level.enemy_dog_locations, level.zones[zone_name].dog_locations[x]);
            }
          }
        }

        if(level.zones[zone_name].rise_locations.size > 0) {
          no_dupes = array_check_for_dupes(level.zombie_rise_spawners, level.zones[zone_name].rise_locations[0]);
          if(!no_dupes) {
            for(x = 0; x < level.zones[zone_name].rise_locations.size; x++) {
              level.zones[zone_name].rise_locations[x].locked_spawner = false;
              level.zombie_rise_spawners = array_remove_nokeys(level.zombie_rise_spawners, level.zones[zone_name].rise_locations[x]);
            }
          }
        }
      }
    }

    wait(1);
  }
}