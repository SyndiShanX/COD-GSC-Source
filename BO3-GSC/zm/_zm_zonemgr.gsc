/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_zonemgr.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm_utility;
#using scripts\zm\gametypes\_zm_gametype;
#namespace zm_zonemgr;

function autoexec __init__sytem__() {
  system::register("zm_zonemgr", &__init__, undefined, undefined);
}

function __init__() {
  println("");
  level flag::init("zones_initialized");
  level.zones = [];
  level.zone_flags = [];
  level.zone_scanning_active = 0;
  level.str_zone_mgr_mode = "occupied_and_adjacent";
  level.create_spawner_list_func = &create_spawner_list;
}

function zone_is_enabled(zone_name) {
  if(!isDefined(level.zones) || !isDefined(level.zones[zone_name]) || !level.zones[zone_name].is_enabled) {
    return false;
  }
  return true;
}

function zone_wait_till_enabled(zone_name) {
  if(!zone_is_enabled(zone_name)) {
    level waittill(zone_name);
  }
}

function get_player_zone() {
  return zm_utility::get_current_zone();
}

function get_zone_from_position(v_pos, ignore_enabled_check) {
  zone = undefined;
  scr_org = spawn("script_origin", v_pos);
  keys = getarraykeys(level.zones);
  for(i = 0; i < keys.size; i++) {
    if(scr_org entity_in_zone(keys[i], ignore_enabled_check)) {
      zone = keys[i];
      break;
    }
  }
  scr_org delete();
  return zone;
}

function get_zone_magic_boxes(zone_name) {
  if(isDefined(zone_name) && !zone_is_enabled(zone_name)) {
    return undefined;
  }
  zone = level.zones[zone_name];
  assert(isDefined(zone_name));
  return zone.magic_boxes;
}

function get_zone_zbarriers(zone_name) {
  if(isDefined(zone_name) && !zone_is_enabled(zone_name)) {
    return undefined;
  }
  zone = level.zones[zone_name];
  assert(isDefined(zone_name));
  return zone.zbarriers;
}

function get_players_in_zone(zone_name, return_players) {
  wait_zone_flags_updating();
  if(!zone_is_enabled(zone_name)) {
    return 0;
  }
  zone = level.zones[zone_name];
  num_in_zone = 0;
  players_in_zone = [];
  players = getplayers();
  for(i = 0; i < zone.volumes.size; i++) {
    for(j = 0; j < players.size; j++) {
      if(players[j] istouching(zone.volumes[i])) {
        num_in_zone++;
        players_in_zone[players_in_zone.size] = players[j];
      }
    }
  }
  if(isDefined(return_players)) {
    return players_in_zone;
  }
  return num_in_zone;
}

function any_player_in_zone(zone_name) {
  if(!zone_is_enabled(zone_name)) {
    return false;
  }
  zone = level.zones[zone_name];
  for(i = 0; i < zone.volumes.size; i++) {
    players = getplayers();
    for(j = 0; j < players.size; j++) {
      if(players[j] istouching(zone.volumes[i]) && !players[j].sessionstate == "spectator") {
        return true;
      }
    }
  }
  return false;
}

function entity_in_zone(zone_name, ignore_enabled_check = 0) {
  if(isplayer(self) && self.sessionstate == "spectator") {
    return false;
  }
  if(!zone_is_enabled(zone_name) && !ignore_enabled_check) {
    return false;
  }
  zone = level.zones[zone_name];
  foreach(e_volume in zone.volumes) {
    if(self istouching(e_volume)) {
      return true;
    }
  }
  return false;
}

function entity_in_active_zone(ignore_enabled_check = 0) {
  if(isplayer(self) && self.sessionstate == "spectator") {
    return false;
  }
  foreach(str_adj_zone in level.active_zone_names) {
    b_in_zone = entity_in_zone(str_adj_zone, ignore_enabled_check);
    if(b_in_zone) {
      return true;
    }
  }
  return false;
}

function deactivate_initial_barrier_goals() {
  special_goals = struct::get_array("exterior_goal", "targetname");
  for(i = 0; i < special_goals.size; i++) {
    if(isDefined(special_goals[i].script_noteworthy)) {
      special_goals[i].is_active = 0;
      special_goals[i] triggerenable(0);
    }
  }
}

function zone_init(zone_name, zone_tag) {
  if(isDefined(level.zones[zone_name])) {
    return;
  }
  println("" + zone_name);
  level.zones[zone_name] = spawnStruct();
  zone = level.zones[zone_name];
  zone.is_enabled = 0;
  zone.is_occupied = 0;
  zone.is_active = 0;
  zone.adjacent_zones = [];
  zone.is_spawning_allowed = 0;
  if(isDefined(zone_tag)) {
    zone_name_tokens = strtok(zone_name, "_");
    zone.district = zone_name_tokens[1];
    zone.area = zone_tag;
  }
  zone.volumes = [];
  volumes = getEntArray(zone_name, "targetname");
  println("" + volumes.size);
  for(i = 0; i < volumes.size; i++) {
    if(volumes[i].classname == "info_volume") {
      zone.volumes[zone.volumes.size] = volumes[i];
    }
  }
  assert(isDefined(zone.volumes[0]), "" + zone_name);
  zone.total_spawn_count = 0;
  zone.round_spawn_count = 0;
  zone.a_loc_types = [];
  zone.a_loc_types["zombie_location"] = [];
  zone.zbarriers = [];
  zone.magic_boxes = [];
  if(isDefined(zone.volumes[0].target)) {
    spots = struct::get_array(zone.volumes[0].target, "targetname");
    barricades = struct::get_array("exterior_goal", "targetname");
    box_locs = struct::get_array("treasure_chest_use", "targetname");
    foreach(spot in spots) {
      spot.zone_name = zone_name;
      if(!(isDefined(spot.is_blocked) && spot.is_blocked)) {
        spot.is_enabled = 1;
      } else {
        spot.is_enabled = 0;
      }
      tokens = strtok(spot.script_noteworthy, " ");
      foreach(token in tokens) {
        switch (token) {
          case "custom_spawner_entry":
          case "faller_location":
          case "riser_location":
          case "spawn_location": {
            if(!isDefined(zone.a_loc_types["zombie_location"])) {
              zone.a_loc_types["zombie_location"] = [];
            } else if(!isarray(zone.a_loc_types["zombie_location"])) {
              zone.a_loc_types["zombie_location"] = array(zone.a_loc_types["zombie_location"]);
            }
            zone.a_loc_types["zombie_location"][zone.a_loc_types["zombie_location"].size] = spot;
            break;
          }
          default: {
            if(!isDefined(zone.a_loc_types[token])) {
              zone.a_loc_types[token] = [];
            }
            if(!isDefined(zone.a_loc_types[token])) {
              zone.a_loc_types[token] = [];
            } else if(!isarray(zone.a_loc_types[token])) {
              zone.a_loc_types[token] = array(zone.a_loc_types[token]);
            }
            zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
          }
        }
      }
      if(isDefined(spot.script_string)) {
        barricade_id = spot.script_string;
        for(k = 0; k < barricades.size; k++) {
          if(isDefined(barricades[k].script_string) && barricades[k].script_string == barricade_id) {
            nodes = getnodearray(barricades[k].target, "targetname");
            for(j = 0; j < nodes.size; j++) {
              if(isDefined(nodes[j].type) && nodes[j].type == "Begin") {
                spot.target = nodes[j].targetname;
              }
            }
          }
        }
      }
    }
    for(i = 0; i < barricades.size; i++) {
      targets = getEntArray(barricades[i].target, "targetname");
      for(j = 0; j < targets.size; j++) {
        if(targets[j] iszbarrier() && isDefined(targets[j].script_string) && targets[j].script_string == zone_name) {
          if(!isDefined(zone.zbarriers)) {
            zone.zbarriers = [];
          } else if(!isarray(zone.zbarriers)) {
            zone.zbarriers = array(zone.zbarriers);
          }
          zone.zbarriers[zone.zbarriers.size] = targets[j];
        }
      }
    }
    for(i = 0; i < box_locs.size; i++) {
      chest_ent = getent(box_locs[i].script_noteworthy + "_zbarrier", "script_noteworthy");
      if(chest_ent entity_in_zone(zone_name, 1)) {
        if(!isDefined(zone.magic_boxes)) {
          zone.magic_boxes = [];
        } else if(!isarray(zone.magic_boxes)) {
          zone.magic_boxes = array(zone.magic_boxes);
        }
        zone.magic_boxes[zone.magic_boxes.size] = box_locs[i];
      }
    }
  }
}

function reinit_zone_spawners() {
  zkeys = getarraykeys(level.zones);
  for(i = 0; i < level.zones.size; i++) {
    zone = level.zones[zkeys[i]];
    zone.a_loc_types = [];
    zone.a_loc_types["zombie_location"] = [];
    if(isDefined(zone.volumes[0].target)) {
      spots = struct::get_array(zone.volumes[0].target, "targetname");
      foreach(n_index, spot in spots) {
        spot.zone_name = zkeys[n_index];
        if(!(isDefined(spot.is_blocked) && spot.is_blocked)) {
          spot.is_enabled = 1;
        } else {
          spot.is_enabled = 0;
        }
        tokens = strtok(spot.script_noteworthy, " ");
        foreach(token in tokens) {
          switch (token) {
            case "custom_spawner_entry":
            case "faller_location":
            case "riser_location":
            case "spawn_location":
            case "spawner_location": {
              if(!isDefined(zone.a_loc_types["zombie_location"])) {
                zone.a_loc_types["zombie_location"] = [];
              } else if(!isarray(zone.a_loc_types["zombie_location"])) {
                zone.a_loc_types["zombie_location"] = array(zone.a_loc_types["zombie_location"]);
              }
              zone.a_loc_types["zombie_location"][zone.a_loc_types["zombie_location"].size] = spot;
              break;
            }
            default: {
              if(!isDefined(zone.a_a_locs[token])) {
                zone.a_loc_types[token] = [];
              }
              if(!isDefined(zone.a_loc_types[token])) {
                zone.a_loc_types[token] = [];
              } else if(!isarray(zone.a_loc_types[token])) {
                zone.a_loc_types[token] = array(zone.a_loc_types[token]);
              }
              zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
            }
          }
        }
      }
    }
  }
}

function enable_zone(zone_name) {
  assert(isDefined(level.zones) && isDefined(level.zones[zone_name]), "");
  if(level.zones[zone_name].is_enabled) {
    return;
  }
  level.zones[zone_name].is_enabled = 1;
  level.zones[zone_name].is_spawning_allowed = 1;
  level notify(zone_name);
  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  for(i = 0; i < spawn_points.size; i++) {
    if(spawn_points[i].script_noteworthy == zone_name) {
      spawn_points[i].locked = 0;
    }
  }
  entry_points = struct::get_array(zone_name + "_barriers", "script_noteworthy");
  for(i = 0; i < entry_points.size; i++) {
    entry_points[i].is_active = 1;
    entry_points[i] triggerenable(1);
  }
  bb::logroundevent("zone_enable_" + zone_name);
}

function make_zone_adjacent(main_zone_name, adj_zone_name, flag_name) {
  main_zone = level.zones[main_zone_name];
  if(!isDefined(main_zone.adjacent_zones[adj_zone_name])) {
    main_zone.adjacent_zones[adj_zone_name] = spawnStruct();
    adj_zone = main_zone.adjacent_zones[adj_zone_name];
    adj_zone.is_connected = 0;
    adj_zone.flags_do_or_check = 0;
    if(isarray(flag_name)) {
      adj_zone.flags = flag_name;
    } else {
      adj_zone.flags[0] = flag_name;
    }
  } else {
    assert(!isarray(flag_name), "");
    adj_zone = main_zone.adjacent_zones[adj_zone_name];
    size = adj_zone.flags.size;
    adj_zone.flags_do_or_check = 1;
    adj_zone.flags[size] = flag_name;
  }
}

function add_zone_flags(wait_flag, add_flags) {
  if(!isarray(add_flags)) {
    temp = add_flags;
    add_flags = [];
    add_flags[0] = temp;
  }
  keys = getarraykeys(level.zone_flags);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == wait_flag) {
      level.zone_flags[keys[i]] = arraycombine(level.zone_flags[keys[i]], add_flags, 1, 0);
      return;
    }
  }
  level.zone_flags[wait_flag] = add_flags;
}

function add_adjacent_zone(zone_name_a, zone_name_b, flag_name, one_way = 0, zone_tag_a, zone_tag_b) {
  if(!isDefined(level.flag[flag_name])) {
    level flag::init(flag_name);
  }
  zone_init(zone_name_a, zone_tag_a);
  zone_init(zone_name_b, zone_tag_b);
  make_zone_adjacent(zone_name_a, zone_name_b, flag_name);
  if(!one_way) {
    make_zone_adjacent(zone_name_b, zone_name_a, flag_name);
  }
}

function setup_zone_flag_waits() {
  flags = [];
  zkeys = getarraykeys(level.zones);
  for(z = 0; z < level.zones.size; z++) {
    zone = level.zones[zkeys[z]];
    azkeys = getarraykeys(zone.adjacent_zones);
    for(az = 0; az < zone.adjacent_zones.size; az++) {
      azone = zone.adjacent_zones[azkeys[az]];
      for(f = 0; f < azone.flags.size; f++) {
        array::add(flags, azone.flags[f], 0);
      }
    }
  }
  for(i = 0; i < flags.size; i++) {
    level thread zone_flag_wait(flags[i]);
  }
}

function wait_zone_flags_updating() {
  if(!isDefined(level.zone_flags_updating)) {
    level.zone_flags_updating = 0;
  }
  while(level.zone_flags_updating > 0) {
    wait(0.05);
  }
}

function zone_flag_wait_throttle() {
  if(!isDefined(level.zone_flag_wait_throttle)) {
    level.zone_flag_wait_throttle = 0;
  }
  level.zone_flag_wait_throttle++;
  if(level.zone_flag_wait_throttle > 3) {
    level.zone_flag_wait_throttle = 0;
    wait(0.05);
  }
}

function zone_flag_wait(flag_name) {
  if(!isDefined(level.flag[flag_name])) {
    level flag::init(flag_name);
  }
  level flag::wait_till(flag_name);
  if(!isDefined(level.zone_flags_updating)) {
    level.zone_flags_updating = 0;
  }
  level.zone_flags_updating++;
  flags_set = 0;
  for(z = 0; z < level.zones.size; z++) {
    zkeys = getarraykeys(level.zones);
    zone = level.zones[zkeys[z]];
    for(az = 0; az < zone.adjacent_zones.size; az++) {
      azkeys = getarraykeys(zone.adjacent_zones);
      azone = zone.adjacent_zones[azkeys[az]];
      if(!azone.is_connected) {
        if(azone.flags_do_or_check) {
          flags_set = 0;
          for(f = 0; f < azone.flags.size; f++) {
            if(level flag::get(azone.flags[f])) {
              flags_set = 1;
              break;
            }
          }
        } else {
          flags_set = 1;
          for(f = 0; f < azone.flags.size; f++) {
            if(!level flag::get(azone.flags[f])) {
              flags_set = 0;
            }
          }
        }
        if(flags_set) {
          enable_zone(zkeys[z]);
          azone.is_connected = 1;
          if(!level.zones[azkeys[az]].is_enabled) {
            enable_zone(azkeys[az]);
          }
          if(level flag::get("door_can_close")) {
            azone thread door_close_disconnect(flag_name);
          }
        }
      }
    }
    zone_flag_wait_throttle();
  }
  keys = getarraykeys(level.zone_flags);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == flag_name) {
      check_flag = level.zone_flags[keys[i]];
      for(k = 0; k < check_flag.size; k++) {
        level flag::set(check_flag[k]);
      }
      break;
    }
    zone_flag_wait_throttle();
  }
  level.zone_flags_updating--;
}

function door_close_disconnect(flag_name) {
  while(level flag::get(flag_name)) {
    wait(1);
  }
  self.is_connected = 0;
  level thread zone_flag_wait(flag_name);
}

function connect_zones(zone_name_a, zone_name_b, one_way = 0) {
  zone_init(zone_name_a);
  zone_init(zone_name_b);
  enable_zone(zone_name_a);
  enable_zone(zone_name_b);
  if(!isDefined(level.zones[zone_name_a].adjacent_zones[zone_name_b])) {
    level.zones[zone_name_a].adjacent_zones[zone_name_b] = spawnStruct();
    level.zones[zone_name_a].adjacent_zones[zone_name_b].is_connected = 1;
  }
  if(!one_way) {
    if(!isDefined(level.zones[zone_name_b].adjacent_zones[zone_name_a])) {
      level.zones[zone_name_b].adjacent_zones[zone_name_a] = spawnStruct();
      level.zones[zone_name_b].adjacent_zones[zone_name_a].is_connected = 1;
    }
  }
}

function manage_zones(initial_zone) {
  assert(isDefined(initial_zone), "");
  deactivate_initial_barrier_goals();
  level.player_zone_found = 1;
  zone_choke = 0;
  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  for(i = 0; i < spawn_points.size; i++) {
    assert(isDefined(spawn_points[i].script_noteworthy), "");
    spawn_points[i].locked = 1;
  }
  if(isDefined(level.zone_manager_init_func)) {
    [[level.zone_manager_init_func]]();
  }
  println("" + initial_zone.size);
  if(isarray(initial_zone)) {
    println("" + initial_zone[0]);
    for(i = 0; i < initial_zone.size; i++) {
      zone_init(initial_zone[i]);
      enable_zone(initial_zone[i]);
    }
  } else {
    println("" + initial_zone);
    zone_init(initial_zone);
    enable_zone(initial_zone);
  }
  setup_zone_flag_waits();
  zkeys = getarraykeys(level.zones);
  level.zone_keys = zkeys;
  level.newzones = [];
  for(z = 0; z < zkeys.size; z++) {
    level.newzones[zkeys[z]] = spawnStruct();
  }
  oldzone = undefined;
  level flag::set("zones_initialized");
  level flag::wait_till("begin_spawning");
  level thread _debug_zones();
  while(getdvarint("noclip") == 0 || getdvarint("notarget") != 0) {
    wait_zone_flags_updating();
    for(z = 0; z < zkeys.size; z++) {
      level.newzones[zkeys[z]].is_active = 0;
      level.newzones[zkeys[z]].is_occupied = 0;
    }
    a_zone_is_active = 0;
    a_zone_is_spawning_allowed = 0;
    level.zone_scanning_active = 1;
    for(z = 0; z < zkeys.size; z++) {
      zone = level.zones[zkeys[z]];
      newzone = level.newzones[zkeys[z]];
      if(!zone.is_enabled) {
        continue;
      }
      if(isDefined(level.zone_occupied_func)) {
        newzone.is_occupied = [[level.zone_occupied_func]](zkeys[z]);
      } else {
        newzone.is_occupied = any_player_in_zone(zkeys[z]);
      }
      if(newzone.is_occupied) {
        newzone.is_active = 1;
        a_zone_is_active = 1;
        if(zone.is_spawning_allowed) {
          a_zone_is_spawning_allowed = 1;
        }
        if(!isDefined(oldzone) || oldzone != newzone) {
          level notify("newzoneactive", zkeys[z]);
          oldzone = newzone;
        }
        azkeys = getarraykeys(zone.adjacent_zones);
        for(az = 0; az < zone.adjacent_zones.size; az++) {
          if(zone.adjacent_zones[azkeys[az]].is_connected && level.zones[azkeys[az]].is_enabled) {
            level.newzones[azkeys[az]].is_active = 1;
            if(level.zones[azkeys[az]].is_spawning_allowed) {
              a_zone_is_spawning_allowed = 1;
            }
          }
        }
      }
      zone_choke++;
      if(zone_choke >= 3) {
        zone_choke = 0;
        wait(0.05);
        wait_zone_flags_updating();
      }
    }
    level.zone_scanning_active = 0;
    for(z = 0; z < zkeys.size; z++) {
      level.zones[zkeys[z]].is_active = level.newzones[zkeys[z]].is_active;
      level.zones[zkeys[z]].is_occupied = level.newzones[zkeys[z]].is_occupied;
    }
    if(!a_zone_is_active || !a_zone_is_spawning_allowed) {
      if(isarray(initial_zone)) {
        level.zones[initial_zone[0]].is_active = 1;
        level.zones[initial_zone[0]].is_occupied = 1;
        level.zones[initial_zone[0]].is_spawning_allowed = 1;
      } else {
        level.zones[initial_zone].is_active = 1;
        level.zones[initial_zone].is_occupied = 1;
        level.zones[initial_zone].is_spawning_allowed = 1;
      }
      level.player_zone_found = 0;
    } else {
      level.player_zone_found = 1;
    }
    [[level.create_spawner_list_func]](zkeys);
    debug_show_spawn_locations();
    level.active_zone_names = get_active_zone_names();
    wait(1);
  }
}

function debug_show_spawn_locations() {
  if(isDefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations) {
    host_player = util::gethostplayer();
    foreach(location in level.zm_loc_types[""]) {
      distance = distance(location.origin, host_player.origin);
      color = (0, 0, 1);
      if(distance > (getdvarint("") * 12)) {
        color = (1, 0, 0);
      }
      debugstar(location.origin, getdvarint(""), color);
    }
  }
}

function old_manage_zones(initial_zone) {
  assert(isDefined(initial_zone), "");
  deactivate_initial_barrier_goals();
  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  for(i = 0; i < spawn_points.size; i++) {
    assert(isDefined(spawn_points[i].script_noteworthy), "");
    spawn_points[i].locked = 1;
  }
  if(isDefined(level.zone_manager_init_func)) {
    [[level.zone_manager_init_func]]();
  }
  println("" + initial_zone.size);
  if(isarray(initial_zone)) {
    println("" + initial_zone[0]);
    for(i = 0; i < initial_zone.size; i++) {
      zone_init(initial_zone[i]);
      enable_zone(initial_zone[i]);
    }
  } else {
    println("" + initial_zone);
    zone_init(initial_zone);
    enable_zone(initial_zone);
  }
  setup_zone_flag_waits();
  zkeys = getarraykeys(level.zones);
  level.zone_keys = zkeys;
  level flag::set("zones_initialized");
  level flag::wait_till("begin_spawning");
  level thread _debug_zones();
  while(getdvarint("noclip") == 0 || getdvarint("notarget") != 0) {
    for(z = 0; z < zkeys.size; z++) {
      level.zones[zkeys[z]].is_active = 0;
      level.zones[zkeys[z]].is_occupied = 0;
    }
    a_zone_is_active = 0;
    a_zone_is_spawning_allowed = 0;
    for(z = 0; z < zkeys.size; z++) {
      zone = level.zones[zkeys[z]];
      if(!zone.is_enabled) {
        continue;
      }
      if(isDefined(level.zone_occupied_func)) {
        zone.is_occupied = [[level.zone_occupied_func]](zkeys[z]);
      } else {
        zone.is_occupied = any_player_in_zone(zkeys[z]);
      }
      if(zone.is_occupied) {
        zone.is_active = 1;
        a_zone_is_active = 1;
        if(zone.is_spawning_allowed) {
          a_zone_is_spawning_allowed = 1;
        }
        azkeys = getarraykeys(zone.adjacent_zones);
        for(az = 0; az < zone.adjacent_zones.size; az++) {
          if(zone.adjacent_zones[azkeys[az]].is_connected && level.zones[azkeys[az]].is_enabled) {
            level.zones[azkeys[az]].is_active = 1;
            if(level.zones[azkeys[az]].is_spawning_allowed) {
              a_zone_is_spawning_allowed = 1;
            }
          }
        }
      }
    }
    if(!a_zone_is_active || !a_zone_is_spawning_allowed) {
      if(isarray(initial_zone)) {
        level.zones[initial_zone[0]].is_active = 1;
        level.zones[initial_zone[0]].is_occupied = 1;
        level.zones[initial_zone[0]].is_spawning_allowed = 1;
      } else {
        level.zones[initial_zone].is_active = 1;
        level.zones[initial_zone].is_occupied = 1;
        level.zones[initial_zone].is_spawning_allowed = 1;
      }
    }
    [[level.create_spawner_list_func]](zkeys);
    level.active_zone_names = get_active_zone_names();
    wait(1);
  }
}

function create_spawner_list(zkeys) {
  foreach(str_index, a_locs in level.zm_loc_types) {
    level.zm_loc_types[str_index] = [];
  }
  for(z = 0; z < zkeys.size; z++) {
    zone = level.zones[zkeys[z]];
    if(zone.is_enabled && zone.is_active && zone.is_spawning_allowed) {
      foreach(a_locs in zone.a_loc_types) {
        foreach(loc in a_locs) {
          if(isDefined(loc.is_enabled) && loc.is_enabled == 0) {
            continue;
          }
          tokens = strtok(loc.script_noteworthy, " ");
          foreach(token in tokens) {
            switch (token) {
              case "custom_spawner_entry":
              case "faller_location":
              case "riser_location":
              case "spawn_location": {
                array::add(level.zm_loc_types["zombie_location"], loc, 0);
                break;
              }
              default: {
                if(!isDefined(level.zm_loc_types[token])) {
                  level.zm_loc_types[token] = [];
                }
                array::add(level.zm_loc_types[token], loc, 0);
              }
            }
          }
        }
      }
    }
  }
}

function get_active_zone_names() {
  ret_list = [];
  if(!isDefined(level.zone_keys)) {
    return ret_list;
  }
  while(level.zone_scanning_active) {
    wait(0.05);
  }
  for(i = 0; i < level.zone_keys.size; i++) {
    if(level.zones[level.zone_keys[i]].is_active) {
      ret_list[ret_list.size] = level.zone_keys[i];
    }
  }
  return ret_list;
}

function get_active_zones_entities() {
  a_player_zones = getEntArray("player_volume", "script_noteworthy");
  a_active_zones = [];
  for(i = 0; i < a_player_zones.size; i++) {
    e_zone = a_player_zones[i];
    zone = level.zones[e_zone.targetname];
    if(isDefined(zone) && (isDefined(zone.is_enabled) && zone.is_enabled)) {
      a_active_zones[a_active_zones.size] = e_zone;
    }
  }
  return a_active_zones;
}

function _init_debug_zones() {
  level.last_debug_zone_index = 0;
  current_y = 30;
  current_x = 20;
  xloc = [];
  xloc[0] = 50;
  xloc[1] = 60;
  xloc[2] = 100;
  xloc[3] = 130;
  xloc[4] = 170;
  xloc[5] = 220;
  zkeys = getarraykeys(level.zones);
  for(i = 0; i < zkeys.size; i++) {
    zonename = zkeys[i];
    zone = level.zones[zonename];
    zone.debug_hud = [];
    for(j = 0; j < 6; j++) {
      zone.debug_hud[j] = newdebughudelem();
      if(!j) {
        zone.debug_hud[j].alignx = "";
      } else {
        zone.debug_hud[j].alignx = "";
      }
      zone.debug_hud[j].x = xloc[j];
      zone.debug_hud[j].y = current_y;
    }
    if(i == 40) {
      for(x = 0; x < xloc.size; x++) {
        xloc[x] = xloc[x] + 350;
      }
      current_y = 30;
    } else {
      current_y = current_y + 10;
    }
    zone.debug_hud[0] settext(zonename);
  }
}

function _destroy_debug_zones() {
  level.last_debug_zone_index = undefined;
  zkeys = getarraykeys(level.zones);
  for(i = 0; i < zkeys.size; i++) {
    zonename = zkeys[i];
    zone = level.zones[zonename];
    for(j = 0; j < 6; j++) {
      zone.debug_hud[j] destroy();
      zone.debug_hud[j] = undefined;
    }
  }
}

function _debug_show_zone(zone, color, alpha) {
  if(isDefined(zone)) {
    foreach(volume in zone.volumes) {
      if(!isDefined(color) || !isDefined(alpha)) {
        showinfovolume(volume getentitynumber(), (0.2, 0.5, 0), 0.05);
        continue;
      }
      showinfovolume(volume getentitynumber(), color, alpha);
    }
  }
}

function _debug_zones() {
  enabled = 0;
  if(getdvarstring("zombiemode_debug_zones") == "") {
    setdvar("zombiemode_debug_zones", "0");
  }
  infovolumedebuginit();
  zkeys = getarraykeys(level.zones);
  for(i = 0; i < zkeys.size; i++) {
    zonename = zkeys[i];
    zone = level.zones[zonename];
    _debug_show_zone(zone, (randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1)), 0.2);
  }
  while(true) {
    wasenabled = enabled;
    enabled = getdvarint("zombiemode_debug_zones");
    if(enabled && !wasenabled) {
      _init_debug_zones();
    } else if(!enabled && wasenabled) {
      _destroy_debug_zones();
    }
    occupied_zone = undefined;
    if(enabled) {
      zkeys = getarraykeys(level.zones);
      for(i = 0; i < zkeys.size; i++) {
        zonename = zkeys[i];
        zone = level.zones[zonename];
        text = zonename;
        zone.debug_hud[0] settext(text);
        if(zone.is_enabled) {
          text = text + " Enabled";
          zone.debug_hud[1] settext("Enabled");
        } else {
          zone.debug_hud[1] settext("");
        }
        if(zone.is_active) {
          text = text + " Active";
          zone.debug_hud[2] settext("Active");
        } else {
          zone.debug_hud[2] settext("");
        }
        if(zone.is_occupied) {
          text = text + " Occupied";
          zone.debug_hud[3] settext("Occupied");
          occupied_zone = zone;
        } else {
          zone.debug_hud[3] settext("");
        }
        if(zone.is_spawning_allowed) {
          text = text + " SpawnOK";
          zone.debug_hud[4] settext("SpawnOK");
        } else {
          zone.debug_hud[4] settext("");
        }
        text = text + (zone.a_loc_types[""].size + "");
        zone.debug_hud[5] settext((((zone.a_loc_types[""].size + "") + zone.total_spawn_count) + "") + zone.round_spawn_count);
      }
    }
    wait(0.1);
  }
}