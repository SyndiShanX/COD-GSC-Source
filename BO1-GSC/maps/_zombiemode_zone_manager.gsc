/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_zone_manager.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  flag_init("zones_initialized");
  level.zones = [];
  level.zone_flags = [];
  if(!isDefined(level.create_spawner_list_func)) {
    level.create_spawner_list_func = ::create_spawner_list;
  }
}

zone_is_enabled(zone_name) {
  if(!isDefined(level.zones) ||
    !isDefined(level.zones[zone_name]) ||
    !level.zones[zone_name].is_enabled) {
    return false;
  }
  return true;
}

get_players_in_zone(zone_name) {
  if(!zone_is_enabled(zone_name)) {
    return false;
  }
  zone = level.zones[zone_name];
  num_in_zone = 0;
  players = get_players();
  for(i = 0; i < zone.volumes.size; i++) {
    for(j = 0; j < players.size; j++) {
      if(players[j] IsTouching(zone.volumes[i]))
        num_in_zone++;
    }
  }
  return num_in_zone;
}

player_in_zone(zone_name) {
  if(!zone_is_enabled(zone_name)) {
    return false;
  }
  zone = level.zones[zone_name];
  players = get_players();
  for(i = 0; i < zone.volumes.size; i++) {
    for(j = 0; j < players.size; j++) {
      if(players[j] IsTouching(zone.volumes[i]) && !(players[j].sessionstate == "spectator"))
        return true;
    }
  }
  return false;
}

deactivate_initial_barrier_goals() {
  special_goals = GetStructArray("exterior_goal", "targetname");
  for(i = 0; i < special_goals.size; i++) {
    if(isDefined(special_goals[i].script_noteworthy)) {
      special_goals[i].is_active = false;
      special_goals[i] trigger_off();
    }
  }
}

zone_init(zone_name) {
  if(isDefined(level.zones[zone_name])) {
    return;
  }
  level.zones[zone_name] = SpawnStruct();
  zone = level.zones[zone_name];
  zone.is_enabled = false;
  zone.is_occupied = false;
  zone.is_active = false;
  zone.adjacent_zones = [];
  zone.volumes = [];
  volumes = getEntArray(zone_name, "targetname");
  for(i = 0; i < volumes.size; i++) {
    if(volumes[i].classname == "info_volume") {
      zone.volumes[zone.volumes.size] = volumes[i];
    }
  }
  AssertEx(isDefined(zone.volumes[0]), "zone_init: No volumes found for zone: " + zone_name);
  if(isDefined(zone.volumes[0].target)) {
    zone.spawners = [];
    zone.dog_spawners = [];
    spawners = getEntArray(zone.volumes[0].target, "targetname");
    for(i = 0; i < spawners.size; i++) {
      spawner = spawners[i];
      spawner.zone_name = zone_name;
      spawner.is_enabled = true;
      if(spawner.classname == "actor_zombie_dog") {
        zone.dog_spawners[zone.dog_spawners.size] = spawner;
      } else if(isDefined(level.ignore_spawner_func)) {
        ignore = [
          [level.ignore_spawner_func]
        ](spawner);
        if(!ignore) {
          zone.spawners[zone.spawners.size] = spawner;
        }
      } else {
        zone.spawners[zone.spawners.size] = spawner;
      }
    }
    zone.dog_locations = GetStructArray(zone.volumes[0].target + "_dog", "targetname");
    for(i = 0; i < zone.dog_locations.size; i++) {
      zone.dog_locations[i].is_enabled = true;
    }
    zone.rise_locations = GetStructArray(zone.volumes[0].target + "_rise", "targetname");
    for(i = 0; i < zone.rise_locations.size; i++) {
      zone.rise_locations[i].is_enabled = true;
    }
  }
}

reinit_zone_spawners() {
  zkeys = GetArrayKeys(level.zones);
  for(i = 0; i < level.zones.size; i++) {
    zone = level.zones[zkeys[i]];
    if(isDefined(zone.volumes[0].target)) {
      zone.spawners = [];
      spawners = getEntArray(zone.volumes[0].target, "targetname");
      for(j = 0; j < spawners.size; j++) {
        spawner = spawners[j];
        if(isDefined(level.ignore_spawner_func)) {
          ignore = [
            [level.ignore_spawner_func]
          ](spawner);
          if(!ignore) {
            zone.spawners[zone.spawners.size] = spawner;
          }
        } else if(spawner.classname != "actor_zombie_dog") {
          zone.spawners[zone.spawners.size] = spawner;
        }
      }
    }
  }
}

enable_zone(zone_name) {
  AssertEx(isDefined(level.zones) && isDefined(level.zones[zone_name]), "enable_zone: zone has not been initialized");
  if(level.zones[zone_name].is_enabled) {
    return;
  }
  level.zones[zone_name].is_enabled = true;
  level notify(zone_name);
  spawn_points = GetStructArray("player_respawn_point", "targetname");
  for(i = 0; i < spawn_points.size; i++) {
    if(spawn_points[i].script_noteworthy == zone_name) {
      spawn_points[i].locked = false;
    }
  }
  entry_points = GetStructArray(zone_name + "_barriers", "script_noteworthy");
  for(i = 0; i < entry_points.size; i++) {
    entry_points[i].is_active = true;
    entry_points[i] trigger_on();
  }
}

make_zone_adjacent(main_zone_name, adj_zone_name, flag_name) {
  main_zone = level.zones[main_zone_name];
  if(!isDefined(main_zone.adjacent_zones[adj_zone_name])) {
    main_zone.adjacent_zones[adj_zone_name] = SpawnStruct();
    adj_zone = main_zone.adjacent_zones[adj_zone_name];
    adj_zone.is_connected = false;
    adj_zone.flags_do_or_check = false;
    if(IsArray(flag_name)) {
      adj_zone.flags = flag_name;
    } else {
      adj_zone.flags[0] = flag_name;
    }
  } else {
    AssertEx(!IsArray(flag_name), "make_zone_adjacent: can't mix single and arrays of flags");
    adj_zone = main_zone.adjacent_zones[adj_zone_name];
    size = adj_zone.flags.size;
    adj_zone.flags_do_or_check = true;
    adj_zone.flags[size] = flag_name;
  }
}

add_zone_flags(wait_flag, add_flags) {
  if(!IsArray(add_flags)) {
    temp = add_flags;
    add_flags = [];
    add_flags[0] = temp;
  }
  keys = GetArrayKeys(level.zone_flags);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == wait_flag) {
      level.zone_flags[keys[i]] = array_combine(level.zone_flags[keys[i]], add_flags);
      return;
    }
  }
  level.zone_flags[wait_flag] = add_flags;
}

add_adjacent_zone(zone_name_a, zone_name_b, flag_name, one_way) {
  if(!isDefined(one_way)) {
    one_way = false;
  }
  if(!isDefined(level.flag[flag_name])) {
    flag_init(flag_name);
  }
  zone_init(zone_name_a);
  zone_init(zone_name_b);
  make_zone_adjacent(zone_name_a, zone_name_b, flag_name);
  if(!one_way) {
    make_zone_adjacent(zone_name_b, zone_name_a, flag_name);
  }
}

setup_zone_flag_waits() {
  flags = [];
  zkeys = GetArrayKeys(level.zones);
  for(z = 0; z < level.zones.size; z++) {
    zone = level.zones[zkeys[z]];
    azkeys = GetArrayKeys(zone.adjacent_zones);
    for(az = 0; az < zone.adjacent_zones.size; az++) {
      azone = zone.adjacent_zones[azkeys[az]];
      for(f = 0; f < azone.flags.size; f++) {
        flags = add_to_array(flags, azone.flags[f], false);
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
  flags_set = false;
  for(z = 0; z < level.zones.size; z++) {
    zkeys = GetArrayKeys(level.zones);
    zone = level.zones[zkeys[z]];
    for(az = 0; az < zone.adjacent_zones.size; az++) {
      azkeys = GetArrayKeys(zone.adjacent_zones);
      azone = zone.adjacent_zones[azkeys[az]];
      if(!azone.is_connected) {
        if(azone.flags_do_or_check) {
          flags_set = false;
          for(f = 0; f < azone.flags.size; f++) {
            if(flag(azone.flags[f])) {
              flags_set = true;
              break;
            }
          }
        } else {
          flags_set = true;
          for(f = 0; f < azone.flags.size; f++) {
            if(!flag(azone.flags[f])) {
              flags_set = false;
            }
          }
        }
        if(flags_set) {
          enable_zone(zkeys[z]);
          azone.is_connected = true;
          if(!level.zones[azkeys[az]].is_enabled) {
            enable_zone(azkeys[az]);
          }
        }
      }
    }
  }
  keys = GetArrayKeys(level.zone_flags);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == flag_name) {
      check_flag = level.zone_flags[keys[i]];
      for(k = 0; k < check_flag.size; k++) {
        flag_set(check_flag[k]);
      }
      break;
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
    level.zones[zone_name_a].adjacent_zones[zone_name_b] = SpawnStruct();
    level.zones[zone_name_a].adjacent_zones[zone_name_b].is_connected = true;
  }
  if(!one_way) {
    if(!isDefined(level.zones[zone_name_b].adjacent_zones[zone_name_a])) {
      level.zones[zone_name_b].adjacent_zones[zone_name_a] = SpawnStruct();
      level.zones[zone_name_b].adjacent_zones[zone_name_a].is_connected = true;
    }
  }
}

manage_zones(initial_zone) {
  AssertEx(isDefined(initial_zone), "You must specify an initial zone to manage");
  deactivate_initial_barrier_goals();
  spawn_points = GetStructArray("player_respawn_point", "targetname");
  for(i = 0; i < spawn_points.size; i++) {
    AssertEx(isDefined(spawn_points[i].script_noteworthy), "player_respawn_point: You must specify a script noteworthy with the zone name");
    spawn_points[i].locked = true;
  }
  if(isDefined(level.zone_manager_init_func)) {
    [
      [level.zone_manager_init_func]
    ]();
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
  flag_set("zones_initialized");
  flag_wait("begin_spawning");
  zkeys = GetArrayKeys(level.zones);
  while(GetDvarInt(#"noclip") == 0 || GetDvarInt(#"notarget") != 0) {
    for(z = 0; z < zkeys.size; z++) {
      level.zones[zkeys[z]].is_active = false;
      level.zones[zkeys[z]].is_occupied = false;
    }
    a_zone_is_active = false;
    for(z = 0; z < zkeys.size; z++) {
      zone = level.zones[zkeys[z]];
      if(!zone.is_enabled) {
        continue;
      }
      zone.is_occupied = player_in_zone(zkeys[z]);
      if(zone.is_occupied) {
        zone.is_active = true;
        a_zone_is_active = true;
        azkeys = GetArrayKeys(zone.adjacent_zones);
        for(az = 0; az < zone.adjacent_zones.size; az++) {
          if(zone.adjacent_zones[azkeys[az]].is_connected &&
            level.zones[azkeys[az]].is_enabled) {
            level.zones[azkeys[az]].is_active = true;
          }
        }
      }
    }
    if(!a_zone_is_active) {
      if(IsArray(initial_zone)) {
        level.zones[initial_zone[0]].is_active = true;
        level.zones[initial_zone[0]].is_occupied = true;
      } else {
        level.zones[initial_zone].is_active = true;
        level.zones[initial_zone].is_occupied = true;
      }
    }
    [
      [level.create_spawner_list_func]
    ](zkeys);
    wait(1);
  }
}

create_spawner_list(zkeys) {
  level.enemy_spawns = [];
  level.enemy_dog_locations = [];
  level.zombie_rise_spawners = [];
  for(z = 0; z < zkeys.size; z++) {
    zone = level.zones[zkeys[z]];
    if(zone.is_enabled && zone.is_active) {
      if(isDefined(level.random_spawners) && level.random_spawners == true) {
        if(isDefined(zone.num_spawners) && zone.spawners.size > zone.num_spawners) {
          while(zone.spawners.size > zone.num_spawners) {
            i = RandomIntRange(0, zone.spawners.size);
            zone.spawners = array_remove(zone.spawners, zone.spawners[i]);
          }
        }
      }
      for(x = 0; x < zone.spawners.size; x++) {
        if(zone.spawners[x].is_enabled) {
          level.enemy_spawns[level.enemy_spawns.size] = zone.spawners[x];
        }
      }
      for(x = 0; x < zone.dog_locations.size; x++) {
        if(zone.dog_locations[x].is_enabled) {
          level.enemy_dog_locations[level.enemy_dog_locations.size] = zone.dog_locations[x];
        }
      }
      for(x = 0; x < zone.rise_locations.size; x++) {
        if(zone.rise_locations[x].is_enabled) {
          level.zombie_rise_spawners[level.zombie_rise_spawners.size] = zone.rise_locations[x];
        }
      }
    }
  }
}