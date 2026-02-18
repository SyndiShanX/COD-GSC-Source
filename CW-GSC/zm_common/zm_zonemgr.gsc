/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_zonemgr.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_utility;
#namespace zm_zonemgr;

function private autoexec __init__system__() {
  system::register(#"zm_zonemgr", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  println("<dev string:x38>");
  level flag::init("zones_initialized");
  level.zones = [];
  level.zone_flags = [];
  level.zone_paths = [];
  level.var_e046d333 = [];
  level.zone_nodes = [];
  level.var_541a988b = [];
  level.zone_scanning_active = 0;
  level.str_zone_mgr_mode = "occupied_and_adjacent";
  level.create_spawner_list_func = &create_spawner_list;
  level thread function_228ae7e();

  level thread function_74a20786();
}

function zone_is_enabled(zone_name) {
  return is_true(level.zones[zone_name].is_enabled);
}

function zone_wait_till_enabled(zone_name) {
  if(!zone_is_enabled(zone_name)) {
    level waittill(zone_name);
  }
}

function function_8caa21df(a_str_zone_names) {
  if(!isDefined(a_str_zone_names)) {
    a_str_zone_names = [];
  } else if(!isarray(a_str_zone_names)) {
    a_str_zone_names = array(a_str_zone_names);
  }

  foreach(str_zone_name in a_str_zone_names) {
    if(zone_is_enabled(str_zone_name)) {
      return str_zone_name;
    }
  }

  return level waittill(a_str_zone_names);
}

function function_28cabfbf(a_str_zone_names) {
  if(!isDefined(a_str_zone_names)) {
    a_str_zone_names = [];
  } else if(!isarray(a_str_zone_names)) {
    a_str_zone_names = array(a_str_zone_names);
  }

  for(i = 0; i < a_str_zone_names.size; i++) {
    str_zone_name = a_str_zone_names[i];

    if(!zone_is_enabled(str_zone_name)) {
      level waittill(str_zone_name);
      i = -1;
    }
  }
}

function get_player_zone() {
  return zm_utility::get_current_zone();
}

function get_zone_from_position(v_pos, ignore_enabled_check = 0, registerchaos_round_end_vo_done_wait_ = 0) {
  if(zm_utility::function_21f4ac36()) {
    node = function_52c1730(v_pos, level.zone_nodes, 500);

    if(isDefined(node)) {
      if(registerchaos_round_end_vo_done_wait_ && !isDefined(getnoderegion(node))) {
        return undefined;
      }

      if(ignore_enabled_check || zone_is_enabled(node.targetname)) {
        return node.targetname;
      }
    }
  }

  return undefined;
}

function function_49d8d29f(v_pos, ignore_enabled_check) {
  zone = undefined;
  keys = getarraykeys(level.zones);

  for(i = 0; i < keys.size; i++) {
    if(function_adc70eee(v_pos, keys[i], ignore_enabled_check)) {
      zone = keys[i];
      break;
    }
  }

  return zone;
}

function function_66bf6a43(v_pos, ignore_enabled_check) {
  keys = getarraykeys(level.zones);

  for(i = 0; i < keys.size; i++) {
    if(function_adc70eee(v_pos, keys[i], ignore_enabled_check)) {
      return true;
    }
  }

  return false;
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
    if(is_true(return_players)) {
      return [];
    }

    return 0;
  }

  zone = level.zones[zone_name];
  players_in_zone = [];
  players = getplayers();

  if(zm_utility::function_c85ebbbc()) {
    foreach(player in players) {
      var_12ed21a1 = function_72d3bca6(zone.volumes, player.origin, undefined, undefined, level.var_603981f1);

      foreach(area in var_12ed21a1) {
        if(player istouching(area)) {
          if(!isDefined(players_in_zone)) {
            players_in_zone = [];
          } else if(!isarray(players_in_zone)) {
            players_in_zone = array(players_in_zone);
          }

          if(!isinarray(players_in_zone, player)) {
            players_in_zone[players_in_zone.size] = player;
          }

          break;
        }
      }
    }
  }

  if(zm_utility::function_21f4ac36()) {
    foreach(player in players) {
      node = function_52c1730(player.origin, zone.nodes, 500);

      if(isDefined(node)) {
        if(!isDefined(players_in_zone)) {
          players_in_zone = [];
        } else if(!isarray(players_in_zone)) {
          players_in_zone = array(players_in_zone);
        }

        if(!isinarray(players_in_zone, player)) {
          players_in_zone[players_in_zone.size] = player;
        }
      }
    }
  }

  if(is_true(return_players)) {
    return players_in_zone;
  }

  return players_in_zone.size;
}

function any_player_in_zone(zone_name) {
  pixbeginevent(#"");

  if(!zone_is_enabled(zone_name)) {
    pixendevent();
    return false;
  }

  zone = level.zones[zone_name];

  if(zm_utility::function_c85ebbbc()) {
    foreach(player in getplayers()) {
      if(player.sessionstate === "spectator") {
        continue;
      }

      var_12ed21a1 = function_72d3bca6(zone.volumes, player.origin, undefined, undefined, level.var_603981f1);

      foreach(area in var_12ed21a1) {
        if(player istouching(area)) {
          pixendevent();
          return true;
        }
      }
    }
  }

  if(zm_utility::function_21f4ac36()) {
    foreach(player in getplayers()) {
      if(player.sessionstate === "spectator") {
        continue;
      }

      node = function_52c1730(player.origin, zone.nodes, 500);

      if(isDefined(node)) {
        pixendevent();
        return true;
      }
    }
  }

  pixendevent();
  return false;
}

function function_74a82172(location, zone_name, ignore_enabled_check = 0) {
  if(!zone_is_enabled(zone_name) && !ignore_enabled_check) {
    return false;
  }

  zone = level.zones[zone_name];

  if(zm_utility::function_c85ebbbc()) {
    var_12ed21a1 = function_72d3bca6(zone.volumes, location, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      if(istouching(location, area)) {
        return true;
      }
    }
  }

  if(zm_utility::function_21f4ac36()) {
    node = function_52c1730(location, zone.nodes, 500);

    if(isDefined(node)) {
      return true;
    }
  }

  return false;
}

function function_adc70eee(location, zone_name, ignore_enabled_check = 0) {
  if(!zone_is_enabled(zone_name) && !ignore_enabled_check) {
    return false;
  }

  zone = level.zones[zone_name];

  if(zm_utility::function_21f4ac36()) {
    node = function_52c1730(location, zone.nodes, 500);

    if(isDefined(node)) {
      return true;
    }
  }

  return false;
}

function entity_in_zone(zone_name, ignore_enabled_check = 0) {
  if(isPlayer(self) && self.sessionstate == "spectator") {
    return false;
  }

  if(!zone_is_enabled(zone_name) && !ignore_enabled_check) {
    return false;
  }

  zone = level.zones[zone_name];

  if(zm_utility::function_c85ebbbc()) {
    var_12ed21a1 = function_72d3bca6(zone.volumes, self.origin, undefined, undefined, level.var_603981f1);

    foreach(area in var_12ed21a1) {
      if(self istouching(area)) {
        return true;
      }
    }
  }

  if(zm_utility::function_21f4ac36()) {
    node = function_52c1730(self.origin, zone.nodes, 500);

    if(isDefined(node)) {
      return true;
    }
  }

  return false;
}

function entity_in_active_zone(ignore_enabled_check = 0) {
  if(isPlayer(self) && self.sessionstate == "spectator") {
    return false;
  }

  if(isDefined(level.active_zone_names)) {
    foreach(str_adj_zone in level.active_zone_names) {
      b_in_zone = entity_in_zone(str_adj_zone, ignore_enabled_check);

      if(b_in_zone) {
        return true;
      }
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

  println("<dev string:x72>" + zone_name);
  level.zones[zone_name] = spawnStruct();
  zone = level.zones[zone_name];
  zone.name = zone_name;
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

  zone.nodes = getnodearray(zone_name, "targetname");

  var_a44786e4 = 0;

  foreach(node in zone.nodes) {
    if(node.type == "<dev string:x8c>" || !isDefined(getnoderegion(node))) {
      if(!var_a44786e4) {
        println("<dev string:x98>");
      }

      var_a44786e4 = 1;
      println("<dev string:xcc>" + zone_name + "<dev string:xea>" + node.origin[0] + "<dev string:xf3>" + node.origin[1] + "<dev string:xf3>" + node.origin[2] + "<dev string:xf8>");
    }
  }

  level.zone_nodes = arraycombine(level.zone_nodes, zone.nodes, 0, 0);
  var_34065104 = array("inner_zigzag_radius", "outer_zigzag_radius", "zigzag_distance_min", "zigzag_distance_max", "zigzag_activation_distance", "zigzag_enabled");

  foreach(node in zone.nodes) {
    foreach(override_name in var_34065104) {
      if(isDefined(node.(override_name))) {
        assert(!isDefined(zone.(override_name)), "<dev string:xfd>" + override_name + "<dev string:x112>" + zone_name);
        zone.(override_name) = node.(override_name);
      }
    }
  }

  zone.volumes = [];
  volumes = getEntArray(zone_name, "targetname");
  println("<dev string:x132>" + volumes.size + "<dev string:x15a>" + zone.nodes.size);

  if(!isDefined(level.var_603981f1)) {
    level.var_603981f1 = 0;
  }

  for(i = 0; i < volumes.size; i++) {
    if(volumes[i].classname == "info_volume" || volumes[i].classname == "trigger_box") {
      zone.volumes[zone.volumes.size] = volumes[i];
      var_3380ebc8 = volumes[i] getmaxs();
      level.var_603981f1 = max(level.var_603981f1, max(var_3380ebc8[0], max(var_3380ebc8[1], var_3380ebc8[2])));
    }
  }

  level.var_541a988b = arraycombine(level.var_541a988b, zone.volumes, 0);
  assert(isDefined(zone.volumes[0]) || isDefined(zone.nodes[0]), "<dev string:x16e>" + zone_name);

  zone.total_spawn_count = 0;
  zone.round_spawn_count = 0;

  zone.a_loc_types = [];
  zone.a_loc_types[# "zombie_location"] = [];
  zone.zbarriers = [];
  zone.magic_boxes = [];

  if(zm_utility::function_21f4ac36() && zone.nodes.size > 0) {
    zone_target = zone.nodes[0].target;
  } else if(zm_utility::function_c85ebbbc() && zone.volumes.size > 0) {
    zone_target = zone.volumes[0].target;
  }

  if(isDefined(zone_target)) {
    spots = struct::get_array(zone_target, "targetname");
    barricades = struct::get_array("exterior_goal", "targetname");

    foreach(spot in spots) {
      spot.zone_name = zone_name;

      if(!is_true(spot.is_blocked)) {
        spot.is_enabled = 1;
      } else {
        spot.is_enabled = 0;
      }

      tokens = strtok(spot.script_noteworthy, " ");

      foreach(token in tokens) {
        switch (token) {
          case # "custom_spawner_entry":
          case # "spawn_location":
          case # "riser_location":
          case # "faller_location":
            spot.spawned_timestamp = gettime();

            if(!isDefined(zone.a_loc_types[# "zombie_location"])) {
              zone.a_loc_types[# "zombie_location"] = [];
            } else if(!isarray(zone.a_loc_types[# "zombie_location"])) {
              zone.a_loc_types[# "zombie_location"] = array(zone.a_loc_types[# "zombie_location"]);
            }

            zone.a_loc_types[# "zombie_location"][zone.a_loc_types[# "zombie_location"].size] = spot;
            break;
          default:
            if(!isDefined(zone.a_loc_types[token])) {
              zone.a_loc_types[token] = [];
            }

            if(!isDefined(zone.a_loc_types[token])) {
              zone.a_loc_types[token] = [];
            } else if(!isarray(zone.a_loc_types[token])) {
              zone.a_loc_types[token] = array(zone.a_loc_types[token]);
            }

            zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
            break;
        }
      }

      if(isDefined(spot.script_string)) {
        barricade_id = spot.script_string;

        for(k = 0; k < barricades.size; k++) {
          if(isDefined(barricades[k].script_string) && barricades[k].script_string == barricade_id) {
            nodes = getnodearray(barricades[k].target, "targetname");

            for(j = 0; j < nodes.size; j++) {
              if(isDefined(nodes[j].type) && nodes[j].type == # "begin") {
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

    level thread function_4ad63e8(zone);
  }
}

function function_4ad63e8(s_zone) {
  level flag::wait_till("magicbox_initialized");

  foreach(s_chest in level.chests) {
    if(s_chest.zbarrier entity_in_zone(s_zone.name, 1)) {
      if(!isDefined(s_zone.magic_boxes)) {
        s_zone.magic_boxes = [];
      } else if(!isarray(s_zone.magic_boxes)) {
        s_zone.magic_boxes = array(s_zone.magic_boxes);
      }

      s_zone.magic_boxes[s_zone.magic_boxes.size] = s_chest;
    }
  }
}

function reinit_zone_spawners() {
  zkeys = getarraykeys(level.zones);

  for(i = 0; i < level.zones.size; i++) {
    zone = level.zones[zkeys[i]];
    zone.a_loc_types = [];
    zone.a_loc_types[# "zombie_location"] = [];

    if(zm_utility::function_21f4ac36() && zone.nodes.size > 0) {
      zone_target = zone.nodes[0].target;
    } else if(zm_utility::function_c85ebbbc() && zone.volumes[0].size > 0) {
      zone_target = zone.volumes[0].target;
    }

    if(isDefined(zone_target)) {
      spots = struct::get_array(zone_target, "targetname");

      foreach(n_index, spot in spots) {
        spot.zone_name = zkeys[n_index];

        if(!is_true(spot.is_blocked)) {
          spot.is_enabled = 1;
        } else {
          spot.is_enabled = 0;
        }

        tokens = strtok(spot.script_noteworthy, " ");

        foreach(token in tokens) {
          switch (token) {
            case # "custom_spawner_entry":
            case # "spawn_location":
            case # "riser_location":
            case # "spawner_location":
            case # "faller_location":
              if(!isDefined(zone.a_loc_types[# "zombie_location"])) {
                zone.a_loc_types[# "zombie_location"] = [];
              } else if(!isarray(zone.a_loc_types[# "zombie_location"])) {
                zone.a_loc_types[# "zombie_location"] = array(zone.a_loc_types[# "zombie_location"]);
              }

              zone.a_loc_types[# "zombie_location"][zone.a_loc_types[# "zombie_location"].size] = spot;
              break;
            default:
              if(!isDefined(zone.a_loc_types[token])) {
                zone.a_loc_types[token] = [];
              } else if(!isarray(zone.a_loc_types[token])) {
                zone.a_loc_types[token] = array(zone.a_loc_types[token]);
              }

              if(!isDefined(zone.a_loc_types[token])) {
                zone.a_loc_types[token] = [];
              } else if(!isarray(zone.a_loc_types[token])) {
                zone.a_loc_types[token] = array(zone.a_loc_types[token]);
              }

              zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
              break;
          }
        }
      }
    }
  }
}

function enable_zone(zone_name) {
  assert(isDefined(level.zones) && isDefined(level.zones[zone_name]), "<dev string:x1a3>");

  if(level.zones[zone_name].is_enabled) {
    return;
  }

  level.zones[zone_name].is_enabled = 1;
  level.zones[zone_name].is_spawning_allowed = 1;
  level notify(zone_name);
  level notify(#"hash_7f3e3ea9f03a4f3a", {
    #str_zone_name: zone_name
  });
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

  foreach(node in level.zones[zone_name].nodes) {
    if(!isDefined(level.var_e046d333)) {
      level.var_e046d333 = [];
    } else if(!isarray(level.var_e046d333)) {
      level.var_e046d333 = array(level.var_e046d333);
    }

    if(!isinarray(level.var_e046d333, getnoderegion(node))) {
      level.var_e046d333[level.var_e046d333.size] = getnoderegion(node);
    }
  }
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

    return;
  }

  assert(!isarray(flag_name), "<dev string:x1d1>");
  adj_zone = main_zone.adjacent_zones[adj_zone_name];
  size = adj_zone.flags.size;
  adj_zone.flags_do_or_check = 1;
  adj_zone.flags[size] = flag_name;
}

function add_zone_flags(wait_flag, add_flags) {
  if(!isDefined(add_flags)) {
    add_flags = [];
  } else if(!isarray(add_flags)) {
    add_flags = array(add_flags);
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

function add_adjacent_zone(zone_name_a, zone_name_b, flag_name, one_way = 1, zone_tag_a, zone_tag_b) {
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
        if(!isDefined(flags)) {
          flags = [];
        } else if(!isarray(flags)) {
          flags = array(flags);
        }

        if(!isinarray(flags, azone.flags[f])) {
          flags[flags.size] = azone.flags[f];
        }
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
    waitframe(1);
  }
}

function zone_flag_wait_throttle() {
  if(!isDefined(level.zone_flag_wait_throttle)) {
    level.zone_flag_wait_throttle = 0;
  }

  level.zone_flag_wait_throttle++;

  if(level.zone_flag_wait_throttle > 3) {
    level.zone_flag_wait_throttle = 0;
    waitframe(1);
  }
}

function zone_flag_wait(flag_name) {
  if(!isDefined(level.flag[flag_name])) {
    level flag::init(flag_name);
  }

  if(flag_name == "power_on" && zm_custom::function_901b751c(#"zmpowerdoorstate") == 2) {
    waitframe(1);
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

          if(azone.flags.size == 1 && azone.flags[0] == "power_on" && zm_custom::function_901b751c(#"zmpowerdoorstate") == 2) {
            flags_set = 1;
          } else {
            for(f = 0; f < azone.flags.size; f++) {
              if(level flag::get(azone.flags[f])) {
                flags_set = 1;
                break;
              }
            }
          }
        } else {
          flags_set = 1;

          if(azone.flags.size == 1 && azone.flags[0] == "power_on" && zm_custom::function_901b751c(#"zmpowerdoorstate") == 2) {
            flags_set = 1;
          } else {
            for(f = 0; f < azone.flags.size; f++) {
              if(!level flag::get(azone.flags[f])) {
                flags_set = 0;
              }
            }
          }
        }

        if(flags_set) {
          enable_zone(level.zones[zkeys[z]].name);
          azone.is_connected = 1;

          if(!level.zones[azkeys[az]].is_enabled) {
            enable_zone(level.zones[azkeys[az]].name);
            zone_flag_wait_throttle();
          }

          if(level flag::get("door_can_close")) {
            azone thread door_close_disconnect(flag_name);
          }
        }
      }
    }
  }

  keys = getarraykeys(level.zone_flags);

  for(i = 0; i < keys.size; i++) {
    if(keys[i] == flag_name) {
      check_flag = level.zone_flags[keys[i]];

      for(k = 0; k < check_flag.size; k++) {
        if(check_flag[k] != # "power_on") {
          if(!level flag::get(check_flag[k])) {
            level flag::set(check_flag[k]);
            zone_flag_wait_throttle();
          }
        }
      }

      break;
    }
  }

  level.zone_flag_wait_throttle = 0;
  level.zone_flags_updating--;
  function_d4cf2b9b(1);
}

function door_close_disconnect(flag_name) {
  while(level flag::get(flag_name)) {
    wait 1;
  }

  self.is_connected = 0;
  level thread zone_flag_wait(flag_name);
}

function function_8a130a46(door, player) {
  assert(isfunctionptr(level.var_27028b8e), "<dev string:x20d>");
  flag_name = door.script_flag;
  var_c6bd50df = player get_player_zone();
  var_34eb3246 = undefined;

  if(isDefined(var_c6bd50df)) {
    var_c6bd50df = hash(var_c6bd50df);
    var_4a122652 = [[level.var_27028b8e]](var_c6bd50df);
    var_35457dfd = undefined;
    var_dead3909 = [var_c6bd50df];
    zone_queue = [];

    do {
      var_34eb3246 = undefined;
      var_1534e9b7 = getarraykeys(level.zones[var_c6bd50df].adjacent_zones);

      foreach(zone_name in var_1534e9b7) {
        if(isinarray(var_dead3909, zone_name)) {
          continue;
        }

        zone = level.zones[var_c6bd50df].adjacent_zones[zone_name];

        foreach(flag in zone.flags) {
          if(flag === flag_name) {
            array::push_front(zone_queue, zone_name);
          }
        }
      }

      if(zone_queue.size > 0) {
        var_34eb3246 = array::pop_front(zone_queue);
        var_35457dfd = [[level.var_27028b8e]](var_34eb3246);

        if(var_4a122652 === var_35457dfd) {
          var_c6bd50df = var_34eb3246;

          if(!isDefined(var_dead3909)) {
            var_dead3909 = [];
          } else if(!isarray(var_dead3909)) {
            var_dead3909 = array(var_dead3909);
          }

          var_dead3909[var_dead3909.size] = var_c6bd50df;
        }
      }
    }
    while(isDefined(var_34eb3246) && var_4a122652 === var_35457dfd);
  } else {
    println("<dev string:x257>" + door.script_flag);
  }

  if(!isDefined(var_34eb3246) && isDefined(door.doors) && door.doors.size > 1) {
    var_3502a580 = undefined;
    var_265f52d9 = undefined;
    var_48029d5b = undefined;

    foreach(var_ffb371bf in door.doors) {
      if(isDefined(var_ffb371bf.mins) && isDefined(var_ffb371bf.maxs)) {
        var_eac469eb = vectorlerp(var_ffb371bf.mins, var_ffb371bf.maxs, 0.5);
        var_3b87bcd4 = distance2dsquared(player.origin, var_eac469eb);

        if(!isDefined(var_265f52d9) || var_265f52d9 < var_3b87bcd4) {
          var_265f52d9 = var_3b87bcd4;
          var_48029d5b = var_eac469eb;
          var_3502a580 = var_ffb371bf;
        }
      }
    }

    if(isDefined(var_48029d5b)) {
      var_48029d5b = getclosestpointonnavmesh(var_48029d5b, 100);

      if(isDefined(var_48029d5b)) {
        var_34eb3246 = get_zone_from_position(var_48029d5b);
      }
    }
  }

  if(isDefined(door.var_4f96681c)) {
    var_34eb3246 = door.var_4f96681c;
  }

  return var_34eb3246;
}

function manage_zones(initial_zone) {
  assert(isDefined(initial_zone), "<dev string:x29e>");
  deactivate_initial_barrier_goals();
  level.player_zone_found = 1;
  zone_choke = 0;
  spawn_points = zm_gametype::get_player_spawns_for_gametype();

  for(i = 0; i < spawn_points.size; i++) {
    assert(isDefined(spawn_points[i].script_noteworthy), "<dev string:x2cc>");
    spawn_points[i].locked = 1;
  }

  if(isDefined(level.zone_manager_init_func)) {
    [[level.zone_manager_init_func]]();
  }

  println("<dev string:x31d>" + initial_zone.size);

  if(isarray(initial_zone)) {
    println("<dev string:x34b>" + initial_zone[0]);

    for(i = 0; i < initial_zone.size; i++) {
      zone_init(initial_zone[i]);
      enable_zone(initial_zone[i]);
    }
  } else {
    println("<dev string:x379>" + initial_zone);
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

  level thread function_8a9003ae();

  while(getdvarint(#"noclip", 0) == 0 || getdvarint(#"notarget", 0) != 0) {
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

      if(isDefined(level.var_cc984236)) {
        newzone.is_occupied = [[level.var_cc984236]](zkeys[z]);
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
          level notify(#"newzoneactive", {
            #zone: zkeys[z]
          });
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

      if(zone_choke >= 2) {
        zone_choke = 0;
        waitframe(1);
        wait_zone_flags_updating();
      }
    }

    level.zone_scanning_active = 0;

    for(z = 0; z < zkeys.size; z++) {
      level.zones[zkeys[z]].is_active = level.newzones[zkeys[z]].is_active;
      level.zones[zkeys[z]].is_occupied = level.newzones[zkeys[z]].is_occupied;
    }

    if(!a_zone_is_active || !a_zone_is_spawning_allowed) {
      var_8cd03217 = 0;

      foreach(e_player in level.players) {
        if(e_player.sessionstate != "spectator" && !level flag::get("rbz_exfil_started")) {
          var_bdf9e3c2 = e_player zm_utility::get_current_zone();

          if(!isDefined(var_bdf9e3c2)) {
            continue;
          }

          s_zone = level.zones[var_bdf9e3c2];
          s_zone.is_active = 1;
          s_zone.is_occupied = 1;
          s_zone.is_spawning_allowed = 1;

          foreach(str_zone_name, var_c714ccfe in s_zone.adjacent_zones) {
            if(var_c714ccfe.is_connected && level.zones[str_zone_name].is_enabled) {
              level.zones[str_zone_name].is_active = 1;
              level.zones[str_zone_name].is_spawning_allowed = 1;
            }
          }

          var_8cd03217 = 1;
          break;
        }
      }

      if(!var_8cd03217) {
        if(level flag::get("rbz_exfil_started") && isDefined(level.var_ad5e81fe)) {
          level.zones[level.var_ad5e81fe[0]].is_active = 1;
          level.zones[level.var_ad5e81fe[0]].is_occupied = 1;
          level.zones[level.var_ad5e81fe[0]].is_spawning_allowed = 1;
        } else {
          s_zone = level.zones[isarray(initial_zone) ? initial_zone[0] : initial_zone];
          s_zone.is_active = 1;
          s_zone.is_occupied = 1;
          s_zone.is_spawning_allowed = 1;

          foreach(str_zone_name, var_c714ccfe in s_zone.adjacent_zones) {
            if(var_c714ccfe.is_connected && level.zones[str_zone_name].is_enabled) {
              level.zones[str_zone_name].is_active = 1;
              level.zones[str_zone_name].is_spawning_allowed = 1;
            }
          }
        }
      }

      level.player_zone_found = 0;
    } else {
      level.player_zone_found = 1;
    }

    waitframe(1);

    while(level.last_spawn_time == gettime()) {
      waitframe(1);
    }

    [[level.create_spawner_list_func]](zkeys);

    debug_show_spawn_locations();

    level.active_zone_names = get_active_zone_names();
    wait 1;
  }
}

function debug_show_spawn_locations() {
  if(is_true(level.toggle_show_spawn_locations)) {
    host_player = util::gethostplayer();

    foreach(location in level.zm_loc_types[# "zombie_location"]) {
      distance = distance(location.origin, host_player.origin);
      color = (0, 1, 1);

      if(distance > getdvarint(#"scr_spawner_location_distance", 0) * 12) {
        color = (1, 0, 0);
      }

      debugstar(location.origin, getdvarint(#"scr_spawner_location_time", 0), color);
    }
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

          if(!isDefined(loc.tokens)) {
            loc.tokens = strtok(loc.script_noteworthy, " ");
          }

          foreach(token in loc.tokens) {
            switch (token) {
              case # "custom_spawner_entry":
              case # "spawn_location":
              case # "riser_location":
              case # "faller_location":
                if(!isDefined(level.zm_loc_types[# "zombie_location"])) {
                  level.zm_loc_types[# "zombie_location"] = [];
                } else if(!isarray(level.zm_loc_types[# "zombie_location"])) {
                  level.zm_loc_types[# "zombie_location"] = array(level.zm_loc_types[# "zombie_location"]);
                }

                if(!isinarray(level.zm_loc_types[# "zombie_location"], loc)) {
                  level.zm_loc_types[# "zombie_location"][level.zm_loc_types[# "zombie_location"].size] = loc;
                }

                break;
              default:
                if(!isDefined(level.zm_loc_types[token])) {
                  level.zm_loc_types[token] = [];
                }

                if(!isDefined(level.zm_loc_types[token])) {
                  level.zm_loc_types[token] = [];
                } else if(!isarray(level.zm_loc_types[token])) {
                  level.zm_loc_types[token] = array(level.zm_loc_types[token]);
                }

                if(!isinarray(level.zm_loc_types[token], loc)) {
                  level.zm_loc_types[token][level.zm_loc_types[token].size] = loc;
                }

                break;
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
    waitframe(1);
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

    if(isDefined(zone) && is_true(zone.is_enabled)) {
      a_active_zones[a_active_zones.size] = e_zone;
    }
  }

  return a_active_zones;
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

  while(true) {
    wasenabled = enabled;
    enabled = getdvarint(#"zombiemode_debug_zones", 0);
    occupied_zone = undefined;
    n_spacer = 0;

    foreach(zone in level.zones) {
      if(zone.name.size > n_spacer) {
        n_spacer = zone.name.size;
      }
    }

    if(enabled) {
      n = 0;

      foreach(zone in level.zones) {
        var_28686bb1 = "";
        var_871522b2 = "";

        for(i = 0; i < n_spacer - zone.name.size; i++) {
          var_871522b2 += " ";
        }

        var_28686bb1 += zone.name + var_871522b2 + " | ";

        if(zone.is_enabled) {
          var_28686bb1 += "Enabled | ";
        } else {
          var_28686bb1 += "| ";
        }

        if(zone.is_active) {
          var_28686bb1 += "Active | ";
        } else {
          var_28686bb1 += " | ";
        }

        if(zone.is_occupied) {
          var_28686bb1 += "Occupied | ";
          occupied_zone = zone;
        } else {
          var_28686bb1 += " | ";
        }

        if(zone.is_spawning_allowed) {
          var_28686bb1 += "SpawnOK | ";
        } else {
          var_28686bb1 += "| ";
        }

        var_28686bb1 += zone.a_loc_types[# "zombie_location"].size + "<dev string:x3a1>" + zone.total_spawn_count + "<dev string:x3a1>" + zone.round_spawn_count;
        v_pos = 100 + 18 * n;
        debug2dtext((400, v_pos, 0), var_28686bb1, (1, 1, 0), undefined, (0, 0, 0), 0.75, 0.85, 2);

        n++;
      }
    }

    wait 0.1;
  }
}

function private function_74a20786() {
  adddebugcommand("<dev string:x3a8>");
  adddebugcommand("<dev string:x3dd>");
  adddebugcommand("<dev string:x40f>");
  adddebugcommand("<dev string:x44d>");
  adddebugcommand("<dev string:x4a6>");
  adddebugcommand("<dev string:x4fc>");
}

function private function_8a9003ae() {
  while(true) {
    waitframe(1);
    enabled = getdvarint(#"hash_4d21e2fbe27b37e6", 0);

    if(!enabled || !isDefined(level.zones)) {
      continue;
    }

    players = getplayers();

    if(!isDefined(players) || players.size == 0) {
      continue;
    }

    player = players[0];

    if(!isDefined(player.zone_name) || !isDefined(level.zones[player.zone_name]) || !isDefined(level.zones[player.zone_name].a_loc_types)) {
      continue;
    }

    var_5380428d = getarraykeys(level.zones[player.zone_name].a_loc_types);
    var_d580b0ec = getdvarint(#"hash_4f0caa9b1c47489c", 0);
    var_2451ad27 = math::clamp(getdvarint(#"hash_4f0caa9b1c47489c", 0), 0, var_5380428d.size - 1);

    var_4b0b7fff = function_9e72a96(var_5380428d[var_2451ad27]);

    foreach(zone in level.zones) {
      if(!isDefined(zone.a_loc_types) || !isDefined(zone.a_loc_types[var_4b0b7fff]) || zone.a_loc_types[var_4b0b7fff].size == 0) {
        continue;
      }

      var_89bea209 = getdvarint(#"hash_5731d10a0ca1d5c", 0);

      if(!var_89bea209 && !zone.is_active) {
        continue;
      }

      sphere_color = (1, 0, 0);
      line_color = (1, 0, 0);
      zone_text = zone.name + "\n" + var_4b0b7fff;

      if(isDefined(player.zone_name)) {
        var_a4808c85 = getarraykeys(zone.adjacent_zones);

        if(player.zone_name == zone.name) {
          sphere_color = (0, 1, 0);
          line_color = (1, 1, 1);
        } else if(isinarray(var_a4808c85, hash(player.zone_name))) {
          sphere_color = (1, 1, 0);
          line_color = (1, 1, 1);
        }
      }

      if(zone.is_enabled) {
        var_db6c400c = (0, 0, 0);

        for(index = 0; index < zone.a_loc_types[var_4b0b7fff].size; index++) {
          var_db6c400c += zone.a_loc_types[var_4b0b7fff][index].origin;
        }

        var_db6c400c /= zone.a_loc_types[var_4b0b7fff].size;

        print3d(var_db6c400c, zone_text, (1, 1, 1), 1, 1);

        for(index = 0; index < zone.a_loc_types[var_4b0b7fff].size; index++) {
          node = zone.a_loc_types[var_4b0b7fff][index];
          node_location = node.origin;

          line(var_db6c400c, node_location, line_color, 1, 0, 1);
          sphere(node_location, 6, sphere_color, 1, 0, 10, 1);
        }
      }
    }
  }
}

function function_54fc7938(player_ent, var_5d02daa5) {
  assert(isPlayer(player_ent));
  assert(isentity(var_5d02daa5) || ishash(var_5d02daa5) || isstring(var_5d02daa5));

  if(isPlayer(player_ent)) {
    ent_number = player_ent getentitynumber();

    if(isentity(var_5d02daa5)) {
      zone_name = var_5d02daa5 zm_utility::get_current_zone();
    } else if(ishash(var_5d02daa5) || isstring(var_5d02daa5)) {
      zone_name = var_5d02daa5;
    } else {
      return undefined;
    }

    if(isDefined(zone_name) && isDefined(level.zone_paths[ent_number]) && isDefined(level.zone_paths[ent_number][zone_name])) {
      return level.zone_paths[ent_number][zone_name];
    }
  }
}

function function_228ae7e() {
  level endon(#"game_ended");

  while(true) {
    function_d4cf2b9b();
    wait randomfloatrange(0.5, 1);
  }
}

function function_d4cf2b9b(force_update = 0) {
  if(getdvarint(#"zm_zone_pathing", 1)) {
    if(force_update) {
      level.zone_paths = [];
    }

    active_players = function_a1ef346b();
    zone_paths = [];

    foreach(player in active_players) {
      if(isDefined(level.var_aea7dde1)) {
        var_c6bd50df = [[level.var_aea7dde1]](player);
      } else {
        var_c6bd50df = player get_player_zone();
      }

      if(!isDefined(var_c6bd50df)) {
        continue;
      }

      ent_number = player getentitynumber();

      if(isDefined(level.zone_paths[ent_number]) && isDefined(level.zone_paths[ent_number][var_c6bd50df])) {
        if(level.zone_paths[ent_number][var_c6bd50df].cost == 0) {
          zone_paths[ent_number] = level.zone_paths[ent_number];
          continue;
        }
      }

      zone = level.zones[var_c6bd50df];
      var_23ca4e6e = [];
      zone_info = spawnStruct();
      zone_info.cost = 0;
      var_23ca4e6e[zone.name] = zone_info;
      var_51c813e9 = 0;
      zone_queue = [];
      zone_queue[zone_queue.size] = zone.name;

      while(zone_queue.size > var_51c813e9) {
        zone = level.zones[zone_queue[var_51c813e9]];

        if(is_true(zone.var_d68ef0f9)) {
          var_51c813e9++;
          continue;
        }

        zone_info = var_23ca4e6e[zone.name];

        foreach(var_4a52ff35, adjacent_zone in zone.adjacent_zones) {
          if(isDefined(var_23ca4e6e[var_4a52ff35]) || is_true(level.zones[var_4a52ff35].var_d68ef0f9)) {
            continue;
          }

          if(adjacent_zone.is_connected) {
            var_658cf985 = spawnStruct();
            var_658cf985.to_zone = zone.name;
            var_658cf985.cost = zone_info.cost + 1;
            var_23ca4e6e[var_4a52ff35] = var_658cf985;
            zone_queue[zone_queue.size] = var_4a52ff35;
          }
        }

        var_51c813e9++;
      }

      zone_paths[ent_number] = var_23ca4e6e;
      waitframe(1);
    }

    level.zone_paths = zone_paths;
  }
}

function function_d68ef0f9(zone_name) {
  if(isDefined(level.zones) && isDefined(level.zones[zone_name]) && !is_true(level.zones[zone_name].var_d68ef0f9)) {
    level.zones[zone_name].var_d68ef0f9 = 1;
    function_d4cf2b9b(1);
  }
}

function function_5f39d727(zone_name) {
  if(isDefined(level.zones) && isDefined(level.zones[zone_name]) && is_true(level.zones[zone_name].var_d68ef0f9)) {
    level.zones[zone_name].var_d68ef0f9 = undefined;
    function_d4cf2b9b(1);
  }
}

function function_d874116e(zone_name) {
  if(isDefined(level.zones) && isDefined(level.zones[zone_name])) {
    level.zones[zone_name].var_458fe8a = undefined;
  }
}

function function_e5eceb89(zone_name) {
  if(isDefined(level.zones) && isDefined(level.zones[zone_name])) {
    level.zones[zone_name].var_458fe8a = 1;
  }
}

function is_player_in_zone(a_str_zones, var_d309b38f = 1) {
  if(!isDefined(a_str_zones)) {
    a_str_zones = [];
  } else if(!isarray(a_str_zones)) {
    a_str_zones = array(a_str_zones);
  }

  if(var_d309b38f && is_true(self.var_16735873)) {
    return false;
  }

  str_player_zone = self get_player_zone();

  foreach(str_zone in a_str_zones) {
    if(str_player_zone === str_zone) {
      return true;
    }
  }

  return false;
}

function function_e6d10d94() {
  if(isDefined(level.var_bc71081f)) {
    player_zone = self get_player_zone();
    return [[level.var_bc71081f]](player_zone);
  }

  return undefined;
}