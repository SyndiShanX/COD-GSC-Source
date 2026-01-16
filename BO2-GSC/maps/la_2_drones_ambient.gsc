/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_drones_ambient.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_2_fly;
#include maps\la_utility;

main() {
  wait_for_first_player();
  _init_aerial_vehicles();
  level thread vehicle_clear_corpses();
}

vehicle_clear_corpses() {
  n_delete_wait_max_ms = 15 * 1000;
  n_delete_wait_ms = 4 * 1000;
  b_do_trace = 1;
  n_distance_auto_delete_sq = 20000 * 20000;

  while(true) {
    a_corpses = get_ent_array("script_vehicle_corpse", "classname");

    for(i = 0; i < a_corpses.size; i++) {
      n_time_current = gettime();
      e_temp = a_corpses[i];

      if(!isDefined(e_temp.death_time))
        e_temp.death_time = n_time_current;

      n_time_since_death_ms = n_time_current - e_temp.death_time;
      b_can_free = !isDefined(e_temp.dontfreeme);
      b_time_to_delete = b_can_free && n_time_since_death_ms > n_delete_wait_ms;

      if(b_time_to_delete) {
        b_can_player_see_corpse = level.player is_looking_at(e_temp.origin, 0.5, b_do_trace);
        n_distance = distancesquared(e_temp.origin, level.player.origin);
        b_corpse_out_of_range = n_distance > n_distance_auto_delete_sq;
        b_max_corpse_time_elapsed = n_delete_wait_max_ms < n_time_since_death_ms;

        if(!b_can_player_see_corpse && (b_corpse_out_of_range || b_max_corpse_time_elapsed)) {
          if(isDefined(e_temp.deathmodel_pieces)) {
            array_delete(e_temp.deathmodel_pieces);
            e_temp.deathmodel_pieces = undefined;
          }

          if(isDefined(e_temp.trailer_model))
            e_temp.trailer_model delete();

          e_temp delete();
        }
      }
    }

    n_wait = randomfloatrange(4, 6);
    wait(n_wait);
  }
}

crash_landing_fx() {
  self endon("death");
  self waittill("veh_collision");

  if(!isDefined(level.green_zone_volume))
    level.green_zone_volume = get_ent("green_zone_volume", "targetname", 1);

  b_is_in_playable_space = self istouching(level.green_zone_volume);
  b_hit_building_wrap = self _did_drone_hit_building_wrap();

  if(b_is_in_playable_space) {
    v_forward = anglestoforward(self.angles);
    n_scale = 1000;
    v_trace_pos = self.origin + v_forward * n_scale;
    a_trace = bullettrace(self.origin, v_trace_pos, 0, self);
    str_surface = a_trace["surfacetype"];
    v_normal = a_trace["normal"] * -1;
    b_hit_glass = issubstr(str_surface, "ice");
    n_fx_id = level._effect["plane_crash_smoke_concrete"];
    n_fx_id_papers = level._effect["drone_building_impact_paper_concrete"];

    if(b_hit_glass) {
      n_fx_id = level._effect["plane_crash_smoke_glass"];
      n_fx_id_papers = level._effect["drone_building_impact_paper_glass"];
    }

    if(b_hit_building_wrap)
      n_fx_id_papers = level._effect["building_wrap_impact_sparks"];

    if(!isDefined(level.persistent_fires))
      level.persistent_fires = [];

    e_temp = spawn("script_model", self.origin);
    e_temp setmodel("tag_origin");
    n_time = gettime();
    e_temp.fx_start_time = n_time;
    playfxontag(n_fx_id, e_temp, "tag_origin");
    playfx(n_fx_id_papers, e_temp.origin, v_forward);

    if(level.persistent_fires.size > level.persistent_fires_max) {
      e_fire = _get_random_element_player_cant_see(level.persistent_fires);
      arrayremovevalue(level.persistent_fires, e_fire);

      if(isDefined(e_fire))
        e_fire delete();
    }

    level.persistent_fires[level.persistent_fires.size] = e_temp;

    println("persistent fires = " + level.persistent_fires.size);

  } else {
    n_fx_id = level._effect["plane_crash_smoke_distant"];
    playfx(n_fx_id, self.origin);
  }
}

_did_drone_hit_building_wrap() {
  if(!isDefined(level.building_wrap_volumes))
    level.building_wrap_volumes = get_ent_array("building_wrap_volume", "targetname", 1);

  b_hit_building_wrap = 0;

  for(i = 0; i < level.building_wrap_volumes.size; i++) {
    if(self istouching(level.building_wrap_volumes[i]))
      b_hit_building_wrap = 1;
  }

  return b_hit_building_wrap;
}

_init_aerial_vehicles() {
  if(!isDefined(level.aerial_vehicles))
    level.aerial_vehicles = spawnstruct();

  if(!isDefined(level.aerial_vehicles.count))
    level.aerial_vehicles.count = 0;

  if(!isDefined(level.aerial_vehicles.allies))
    level.aerial_vehicles.allies = [];

  if(!isDefined(level.aerial_vehicles.axis))
    level.aerial_vehicles.axis = [];

  if(!isDefined(level.aerial_vehicles.close_count))
    level.aerial_vehicles.close_count = 10;

  if(!isDefined(level.aerial_vehicles.valid_structs_medium))
    level.aerial_vehicles.valid_structs_medium = [];

  if(!isDefined(level.aerial_vehicles.circling))
    level.aerial_vehicles.circling = [];

  if(!isDefined(level.aerial_vehicles.circling_close_allowed))
    level.aerial_vehicles.circling_close_allowed = 1;

  if(!isDefined(level.aerial_vehicles.circling_max_count))
    level.aerial_vehicles.circling_max_count = 30;

  if(!isDefined(level.aerial_vehicles.dogfights))
    level.aerial_vehicles.dogfights = spawnstruct();

  if(!isDefined(level.aerial_vehicles.dogfights.waves)) {
    n_avengers = 5;
    n_pegasus = 0;
    n_heli = 0;
    _dogfights_setup_wave_parameters(n_avengers, n_pegasus, n_heli);
    n_avengers = 5;
    n_pegasus = 1;
    n_heli = 0;
    _dogfights_setup_wave_parameters(n_avengers, n_pegasus, n_heli);
    n_avengers = 5;
    n_pegasus = 2;
    n_heli = 0;
    _dogfights_setup_wave_parameters(n_avengers, n_pegasus, n_heli);
    n_avengers = 5;
    n_pegasus = 3;
    n_heli = 0;
    _dogfights_setup_wave_parameters(n_avengers, n_pegasus, n_heli);
    n_avengers = 5;
    n_pegasus = 4;
    n_heli = 0;
    _dogfights_setup_wave_parameters(n_avengers, n_pegasus, n_heli);
  }

  if(!isDefined(level.aerial_vehicles.dogfights.current_wave))
    level.aerial_vehicles.dogfights.current_wave = 0;

  if(!isDefined(level.aerial_vehicles.dogfight_targets))
    level.aerial_vehicles.dogfights.dogfight_targets = 0;

  if(!isDefined(level.aerial_vehicles.spawned_this_wave))
    level.aerial_vehicles.dogfights.spawned_this_wave = 0;

  if(!isDefined(level.aerial_vehicles.killed_this_wave))
    level.aerial_vehicles.dogfights.killed_this_wave = 0;

  if(!isDefined(level.aerial_vehicles.player_killed_total))
    level.aerial_vehicles.player_killed_total = 0;

  if(!isDefined(level.aerial_vehicles.dogfights.targets))
    level.aerial_vehicles.dogfights.targets = [];

  if(!isDefined(level.aerial_vehicles.dogfights.killed_total))
    level.aerial_vehicles.dogfights.killed_total = 0;
}

_dogfights_setup_wave_parameters(n_avenger_count, n_pegasus_count, n_heli_count) {
  if(!isDefined(level.aerial_vehicles.dogfights.waves))
    level.aerial_vehicles.dogfights.waves = [];

  a_wave = [];
  a_wave["avengers"] = n_avenger_count;
  a_wave["pegasus"] = n_pegasus_count;
  a_wave["helicopters"] = n_heli_count;
  a_wave["avengers_spawned"] = 0;
  a_wave["pegasus_spawned"] = 0;
  a_wave["helicopters_spawned"] = 0;
  a_wave["killed_this_wave"] = 0;
  level.aerial_vehicles.dogfights.waves[level.aerial_vehicles.dogfights.waves.size] = a_wave;
}

plane_counter() {
  b_is_ally = self _increment_plane_count();
  self waittill("death");
  self _decrement_plane_count(b_is_ally);
}

_increment_plane_count() {
  level.aerial_vehicles.count++;
  b_is_ally = 0;
  b_is_axis = 0;
  str_team = self.vteam;

  if(str_team == "allies")
    b_is_ally = 1;
  else if(str_team == "axis")
    b_is_axis = 1;

  if(b_is_ally)
    level.aerial_vehicles.allies[level.aerial_vehicles.allies.size] = self;
  else if(b_is_axis)
    level.aerial_vehicles.axis[level.aerial_vehicles.axis.size] = self;
  else {
    assertmsg("vehicle team " + str_team + " is not a valid team tracked by plane_counter()!");

  }

  return b_is_ally;
}

_decrement_plane_count(b_is_ally) {
  level.aerial_vehicles.count--;

  if(b_is_ally)
    level.aerial_vehicles.allies = array_removedead(level.aerial_vehicles.allies);
  else
    level.aerial_vehicles.axis = array_removedead(level.aerial_vehicles.axis);
}

_get_random_element_player_can_see(a_elements, n_distance) {
  assert(isDefined(a_elements), "a_elements is a required parameter for _get_random_element_player_can_see");
  assert(a_elements.size > 0, "a_elements needs to contain at least one element in _get_random_element_player_can_see");
  b_found_element = 0;
  e_player = level.player;
  b_do_trace = 0;
  b_use_distance = isDefined(n_distance);
  b_distance_passed = 1;

  while(!b_found_element) {
    s_element = random(a_elements);
    b_can_player_see_point = e_player is_looking_at(s_element.origin, 0.6, b_do_trace);

    if(b_use_distance) {
      b_distance_passed = 0;
      n_distance_current = distance2d(e_player.origin, s_element.origin);

      if(n_distance_current > n_distance)
        b_distance_passed = 1;
    }

    if(b_can_player_see_point && b_distance_passed)
      b_found_element = 1;

    wait 0.1;
  }

  return s_element;
}

_get_random_element_player_cant_see(a_elements, n_distance) {
  assert(isDefined(a_elements), "a_elements is a required parameter for _get_random_element_player_cant_see");
  assert(a_elements.size > 0, "a_elements needs to contain at least one element in _get_random_element_player_cant_see");
  b_found_element = 0;
  e_player = level.player;
  b_do_trace = 0;
  b_use_distance = isDefined(n_distance);
  b_distance_passed = 1;

  while(!b_found_element) {
    s_element = random(a_elements);

    if(!isDefined(s_element)) {
      wait 0.1;
      continue;
    }

    b_can_player_see_point = e_player is_looking_at(s_element.origin, 0.3, b_do_trace);

    if(b_use_distance) {
      b_distance_passed = 0;
      n_distance_current = distance2d(e_player.origin, s_element.origin);

      if(n_distance_current > n_distance)
        b_distance_passed = 1;
    }

    if(!b_can_player_see_point && b_distance_passed)
      b_found_element = 1;

    wait 0.1;
  }

  return s_element;
}

dogfight_ambient_drone_spawn_manager() {
  level endon("kill_ambient_drone_spawn_manager");
  level.zone_drone_counts = [];
  level.zone_drone_counts["trig_ambient_east"] = 0;
  level.zone_drone_counts["trig_ambient_west"] = 0;
  level.zone_drone_counts["trig_ambient_north"] = 0;
  start_nodes_west = [];
  start_nodes_east[0] = "south_east_corner";
  start_nodes_east[1] = "north_east_loop_start";
  start_nodes_west = [];
  start_nodes_west[0] = "north_west_corner_start";
  start_nodes_west[1] = "south_west_corner_start";
  start_nodes_north = [];
  start_nodes_north[0] = "ambient_north_track_1";
  start_nodes_north[1] = "ambient_north_track_2";
  level thread zone_trigger_watch("trig_ambient_east");
  level thread zone_spawn_planes("trig_ambient_east", start_nodes_east);
  level thread zone_trigger_watch("trig_ambient_west");
  level thread zone_spawn_planes("trig_ambient_west", start_nodes_west);
  level thread zone_trigger_watch("trig_ambient_north");
  level thread zone_spawn_planes("trig_ambient_north", start_nodes_north);
}

zone_trigger_watch(zone_name) {
  trigger = getent(zone_name, "targetname");

  while(true) {
    trigger waittill("trigger");
    trig_origin = (trigger.origin[0], trigger.origin[1], 0);
    player_origin = (level.player.origin[0], level.player.origin[1], 0);
    player_forward = isDefined(level.player.viewlockedentity) ? anglestoforward(level.player.viewlockedentity.angles) : anglestoforward(level.player.angles);
    dir = trig_origin - player_origin;
    dot = vectordot(dir, player_forward);
    trigger.triggered = 1;
  }
}

zone_spawn_planes(zone_name, start_nodes) {
  level endon("kill_ambient_drone_spawn_manager");
  trigger = getent(zone_name, "targetname");
  n_spawn_count_axis = 5;
  n_spawn_count_allies = 2;
  current_track = 0;
  total = n_spawn_count_axis + n_spawn_count_allies;

  while(true) {
    if(is_true(trigger.triggered)) {
      vehicle_count = getvehiclearray().size;

      if(vehicle_count > 50) {
        deleted = level cleanup_ambient_drones(n_spawn_count_axis + n_spawn_count_allies, 50000);

        if(deleted < n_spawn_count_axis + n_spawn_count_allies) {
          trigger.triggered = 0;
          continue;
        }
      }

      if(level.zone_drone_counts[zone_name] + total <= 7) {
        if(level.aerial_vehicles.count + n_spawn_count_axis + n_spawn_count_allies > 50) {
          deleted = level cleanup_ambient_drones((n_spawn_count_axis + n_spawn_count_allies) * 4, 50000);

          if(deleted >= n_spawn_count_axis + n_spawn_count_allies) {
            n_spawned = level thread spawn_plane_group(zone_name, start_nodes[current_track], n_spawn_count_axis, "pegasus_ground_ambient_flyby_2", "f38_ground_ambient_flyby_2");
            level waittill(start_nodes[current_track]);
            level.zone_drone_counts[zone_name] = level.zone_drone_counts[zone_name] + (n_spawn_count_axis + n_spawn_count_allies);
          } else {
            trigger.triggered = 0;
            continue;
          }
        } else {
          n_spawned = level thread spawn_plane_group(zone_name, start_nodes[current_track], n_spawn_count_axis, "pegasus_ground_ambient_flyby_2", "f38_ground_ambient_flyby_2");
          level waittill(start_nodes[current_track]);
          level.zone_drone_counts[zone_name] = level.zone_drone_counts[zone_name] + (n_spawn_count_axis + n_spawn_count_allies);
        }

        current_track++;

        if(current_track >= start_nodes.size)
          current_track = 0;

        wait 2;
      }
    }

    trigger.triggered = 0;
    wait 0.05;
  }
}

cleanup_ambient_drones(desired_delete_count, delete_dist, min_dot) {
  if(!isDefined(min_dot))
    min_dot = 0.5;

  potential_deletes = [];
  player_forward = isDefined(level.player.viewlockedentity) ? anglestoforward(level.player.viewlockedentity.angles) : anglestoforward(level.player.angles);

  for(i = 0; i < level.aerial_vehicles.axis.size; i++) {
    if(isDefined(level.aerial_vehicles.axis[i]) && !isDefined(level.aerial_vehicles.axis[i].is_convoy_plane)) {
      dot = vectordot(vectornormalize(level.aerial_vehicles.axis[i].origin - level.player.origin), player_forward);

      if(dot < -0.5) {
        potential_deletes[potential_deletes.size] = level.aerial_vehicles.axis[i];
        continue;
      }

      if(min_dot < 0.5) {
        dist = distance2d(level.aerial_vehicles.axis[i].origin, level.player.origin);

        if(dist > delete_dist)
          potential_deletes[potential_deletes.size] = level.aerial_vehicles.axis[i];
      }
    }
  }

  for(i = 0; i < level.aerial_vehicles.allies.size; i++) {
    if(isDefined(level.aerial_vehicles.allies[i]) && !isDefined(level.aerial_vehicles.allies[i].is_convoy_plane)) {
      dot = vectordot(vectornormalize(level.aerial_vehicles.allies[i].origin - level.player.origin), player_forward);

      if(dot < -0.5) {
        potential_deletes[potential_deletes.size] = level.aerial_vehicles.allies[i];
        continue;
      }

      if(min_dot < 0.5) {
        dist = distance2d(level.aerial_vehicles.allies[i].origin, level.player.origin);

        if(dist > delete_dist)
          potential_deletes[potential_deletes.size] = level.aerial_vehicles.allies[i];
      }
    }
  }

  n_deletes = desired_delete_count < potential_deletes.size ? desired_delete_count : potential_deletes.size;

  for(i = 0; i < n_deletes; i++) {
    if(isDefined(potential_deletes[i])) {
      level.zone_drone_counts[potential_deletes[i].zone_name]--;
      potential_deletes[i] delete();
    }
  }

  return n_deletes;
}

get_best_spline_node(node_start) {
  player_forward = isDefined(level.player.viewlockedentity) ? anglestoforward(level.player.viewlockedentity.angles) : anglestoforward(level.player.angles);
  current_node = getvehiclenode(node_start, "targetname");
  next_node = getvehiclenode(current_node.target, "targetname");
  closest_node = undefined;
  closest_dist = 999999;

  while(next_node.target != node_start) {
    delta = current_node.origin - level.player.origin;
    dist = length(delta);

    if(dist < closest_dist) {
      dot = vectordot(vectornormalize(delta), player_forward);

      if(dot > 0) {
        closest_node = current_node;
        closest_dist = dist;
      }
    }

    current_node = next_node;
    next_node = getvehiclenode(current_node.target, "targetname");
  }

  if(isDefined(closest_node))
    circle(closest_node.origin, 1024, (1, 1, 1), 0, 1);

  return closest_node;
}

spawn_plane_group(zone_name, initial_path, n_count, str_spawner, str_allies_spawner, delay) {
  level endon("kill_ambient_drone_spawn_manager");

  if(isDefined(delay))
    wait(delay);

  a_planes = [];
  level.vh_lead_plane = undefined;

  for(i = 0; i < n_count; i++) {
    vh_plane = plane_spawn(str_spawner, ::plane_drive_highway, initial_path, level.vh_lead_plane, i - 1);
    vh_plane.transfer_route = 1;
    vh_plane setspeedimmediate(600, 300);
    vh_plane thread ambient_drone_die();
    vh_plane thread death_watcher();
    vh_plane.zone_name = zone_name;

    if(!isDefined(level.vh_lead_plane))
      level.vh_lead_plane = vh_plane;

    a_planes[a_planes.size] = vh_plane;
    wait 0.25;
  }

  level.vh_lead_plane = undefined;

  for(i = 0; i < 2; i++) {
    vh_plane = plane_spawn(str_allies_spawner, ::plane_drive_highway, initial_path, level.vh_lead_plane, i - 1);
    vh_plane.transfer_route = 1;
    vh_plane.drone_targets = a_planes;
    vh_plane setspeedimmediate(600, 300);
    vh_plane thread ambient_air_allies_weapon_think();
    vh_plane thread death_watcher();
    vh_plane.zone_name = zone_name;

    if(!isDefined(level.vh_lead_plane))
      level.vh_lead_plane = vh_plane;

    wait 0.05;
  }

  level notify(initial_path);
}

ambient_air_allies_weapon_think() {
  wait 2;
  self thread ambient_allies_weapons_think(10);
}

death_watcher() {
  self waittill("death");

  if(isDefined(self.zone_name))
    level.zone_drone_counts[self.zone_name]--;
}