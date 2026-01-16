/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_fly.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_dialog;
#include maps\la_utility;
#include maps\_music;
#include maps\la_2_convoy;
#include maps\_lockonmissileturret;
#include maps\la_2_ground;
#include maps\la_2_anim;
#include maps\la_2;
#include maps\_turret;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\la_2_drones_ambient;
#include maps\createart\la_2_art;

f35_dogfights() {
  b_safe = 0;

  while(!b_safe) {
    if(distance2d(level.player.origin, level.convoy.vh_potus.origin) < 10000) {
      dir = vectornormalize(level.convoy.vh_potus.origin - level.player.origin);
      start = level.player.origin;
      end = start + dir * 2000;

      if(bullettracepassed(start, end, 0, level.f35, level.convoy.vh_potus)) {
        line(start, end, (0, 0, 1), 1, 0, 1000000000);

        b_safe = 1;
      } else {
        line(start, end, (1, 0, 0), 1, 0, 1);

      }
    }

    wait 0.05;
  }

  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_dogfight_stop_trigger", "convoy_continue");
  level delay_thread(4, ::flag_set, "convoy_continue");
  level delay_thread(3.5, ::flag_set, "convoy_at_dogfight");
  level.b_pip_5_played = 0;
  level.b_pip_6_played = 0;
  level.b_pip_7_played = 0;
  maps\_lockonmissileturret::enablelockon();
  level thread maps\la_2_ground::convoy_blocked_by_debris();
  flag_set("no_fail_from_distance");
  flag_set("convoy_nag_override");
  level thread dogfights_monitor_warning_distance();
  dogfights_monitor_failure_distance();
  level thread queue_checkpoint_save();
  level.f35 notify("update_plane_damage_state");

  if(level.skipto_point != "f35_dogfights")
    trigger_wait("trig_dogfights_start", "targetname");

  level notify("end_ambient_drones");
  playsoundatposition("evt_pack_flyby", (-2213, 5513, 2346));
  clientnotify("dfs_go");
  setculldist(0);
  level clientnotify("set_jet_fog_banks");
  level.player setclientdvar("cg_tracerSpeed", 25000);
  level.player playsound("evt_air_to_air");
  setmusicstate("LA_2_DOGFIGHT");
  level thread maps\la_2_anim::vo_ground_air_transition();
  level thread dogfight_event_logic();
  level thread dogfight_ambient_building_explosions();
  level notify("start_dogfight_event");
  wait 0.05;
  level notify("stop_dogfight_shake");
  level thread _gentle_shake(2.0);
  level.f35 thread maps\la_2_anim::vo_dogfight_f35();
  wait 3;
  level.f35 setvehicletype("plane_f35_player_vtol_fast_spline");
  level.f35 thread f35_give_player_control();
  level.f35 setpathtransitiontime(2);
  level.f35 thread go_path(getvehiclenode("path_player_start_dogfight", "targetname"));
  flag_set("dogfights_story_done");
  setsaveddvar("waypointOffscreenPadLeft", 220);
  setsaveddvar("waypointOffscreenPadRight", 220);
  setsaveddvar("waypointOffscreenPadTop", 80);
  setsaveddvar("waypointOffscreenPadBottom", 140);
  level.f35 setheliheightlock(0);
  setsaveddvar("vehPlaneConventionalFlight", "1");
  exploder(700);
  level thread change_dogfights_fog_based_on_height();
  scale_model_lods(1, 1);
  flag_wait("dogfight_done");
  flag_clear("convoy_nag_override");
  level notify("dogfights_done");
}

f35_give_player_control() {
  self endon("death");
  self waittill("player_go");
  self getoffpath();
}

_autosave_after_bink() {
  flag_waitopen("pip_playing");
  autosave_by_name("la_2_after_bink");
}

_gentle_shake(n_time) {
  n_shake_value = 0.2;
  n_loops = n_time / 0.05;
  n_shake_decrement = n_shake_value / n_loops;

  while(n_shake_value > 0) {
    earthquake(n_shake_value, 0.05, level.player.origin, 10000, level.player);
    n_shake_value = n_shake_value - n_shake_decrement;
    wait 0.05;
  }
}

_blast_off_sequence(n_time) {
  level endon("stop_dogfight_shake");
  n_count = int(n_time / 0.25);
  level thread maps\la_2_anim::vo_ground_air_transition();
  level.player thread rumble_loop(n_count, 0.25, "damage_heavy");

  while(true) {
    earthquake(0.25, 0.15, level.player.origin, 10000, level.player);
    wait 0.05;
  }
}

mark_targetted_enemies_as_targets() {
  while(!flag("dogfight_done")) {
    a_closest_drones = get_array_of_closest(level.player.origin, level.aerial_vehicles.axis, undefined, 10, 35000);
    forward = anglestoforward(level.player getplayerangles());
    bestdot = -999;
    chosenindex = -1;
    fov = getdvarfloat(#"cg_fov");
    weaponname = level.player getturretweaponname();
    radius = weaponlockonradius(weaponname) + 10;

    for(i = 0; i < a_closest_drones.size; i++) {
      if(target_isincircle(a_closest_drones[i], level.player, fov, radius)) {
        chosenindex = i;
        break;
      }
    }

    if(chosenindex > -1) {
      player_target = a_closest_drones[chosenindex];
      target_set(player_target);
    } else
      player_target = self;

    a_temp = target_getarray();

    for(i = 0; i < a_temp.size; i++) {
      if(isDefined(a_temp[i].objective_target) && a_temp[i].objective_target || player_target == a_temp[i]) {
        continue;
      }
      target_remove(a_temp[i]);
    }

    wait 0.15;
  }
}

dogfights_monitor_warning_distance() {
  level endon("player_failed");
  level endon("dogfight_done");
  a_warning_triggers = get_ent_array("air_warning_trigger", "targetname", 1);
  showing_warning = 0;

  while(true) {
    touching = 0;

    foreach(trigger in a_warning_triggers) {
      if(level.player istouching(trigger))
        touching = 1;
    }

    if(touching) {
      if(!showing_warning) {
        showing_warning = 1;
        screen_message_create(&"LA_SHARED_LEAVING_COMBAT");
        level.cansave = 0;
      }
    } else if(showing_warning) {
      showing_warning = 0;
      screen_message_delete();
      level.cansave = 1;
    }

    wait 0.05;
  }
}

_dogfights_warning_distance_check() {
  n_warning_frequency_ms = 4 * 1000;

  while(true) {
    self waittill("trigger", e_triggered);
    e_triggered.dogfight_warning = 1;
    n_time = gettime();

    if(!isDefined(e_triggered.dogfight_warning_time_last))
      e_triggered.dogfight_warning_time_last = 0;

    b_should_warn = 0;

    if(n_time - e_triggered.dogfight_warning_time_last > n_warning_frequency_ms)
      b_should_warn = 1;

    if(b_should_warn)
      e_triggered.dogfight_warning_time_last = n_time;

    n_wait_time = randomfloatrange(0.8, 1.5);
    wait(n_wait_time);
  }
}

dogfights_monitor_failure_distance() {
  a_failure_triggers = get_ent_array("air_failure_trigger", "targetname", 1);
  array_thread(a_failure_triggers, ::_dogfights_failure_distance_check);
}

_dogfights_failure_distance_check() {
  level endon("dogfight_done");
  n_wait_min = 0.8;
  n_wait_max = 1.5;

  while(true) {
    self waittill("trigger", e_triggered);

    if(isplayer(e_triggered) && !isgodmode(e_triggered)) {
      level notify("player_failed");
      screen_message_delete();
      setdvar("ui_deadquote", & "LA_SHARED_LEFT_COMBAT");
      missionfailed();
    }
  }
}

_shake_in_jetwash() {
  self endon("death");
  level endon("dogfight_done");

  while(true) {
    if(getdvar(#"vehPlaneAssistedFlying") == "1") {
      if(isDefined(level.player.missileturrettarget)) {
        if(distancesquared(level.player.missileturrettarget.origin, level.f35.origin) < 25000000) {
          earthquake(0.05, 0.15, level.player.origin, 10000, level.player);
          level.player playrumbleonentity("damage_light");
        } else if(distancesquared(level.player.missileturrettarget.origin, level.f35.origin) < 6250000) {
          earthquake(0.15, 0.15, level.player.origin, 10000, level.player);
          level.player playrumbleonentity("damage_light");
        }
      }
    }

    wait 0.15;
  }
}

dogfight_event_logic() {
  define_air_to_air_offsets();
  _setup_deathblossom_offsets("temp_drone", "deathblossom_special");
  level waittill("start_dogfight_event");
  level.f35 thread _shake_in_jetwash();
  level thread _dogfight_track_kills_for_vo();
  level thread maps\la_2_anim::vo_player_strafed();
  level.f35 thread maps\la_2_anim::vo_f38_target_lock_on_and_off();
  level thread maps\la_2_anim::vo_f38_shot_down_drone();
  level thread maps\la_2_anim::vo_player_shot_down_drone();
  level thread maps\la_2_anim::vo_f38_fired_cannons();
  level thread maps\la_2_anim::vo_f38_fired_missile();
  level thread dogfights_manage_wave_count();
  level thread dogfight_ambient_drone_spawn_manager();
  level.b_should_match_speed = 0;
  level.b_should_exceed_speed = 0;
  level thread dogfight_friendly_vo_callouts();
  level thread convoy_strafing_fail_watcher();
  flag_set("dogfight_wave_1");
  level thread spawn_convoy_f35_allies("start_flyby_to_convoy", 2, 1);
  spawn_convoy_strafing_wave("start_flyby_to_convoy", 5, 1);
  level.f35 notify("update_plane_damage_state");
  level thread queue_checkpoint_save();
  wait_until_convoy_can_move("convoy_moveto_second_position");
  flag_set("dogfight_wave_2");
  level.n_safe_strafes = 1;
  maps\la_2::convoy_move_to_position("convoy_moveto_second_position");
  level notify("drone_wave_complete");
  level thread spawn_convoy_f35_allies("start_flyby_to_convoy", 2, 2);
  level thread queue_checkpoint_save();
  spawn_convoy_strafing_wave("start_flyby_to_convoy", 6, 2);
  level.f35 notify("update_plane_damage_state");
  wait_until_convoy_can_move("convoy_moveto_final_position");
  maps\la_2::convoy_move_to_position("convoy_moveto_final_position");
  level notify("drone_wave_complete");
  level thread spawn_convoy_f35_allies("start_flyby_to_convoy", 2, 3);
  flag_set("dogfight_wave_3");
  level.n_safe_strafes = 1;
  spawn_convoy_strafing_wave("start_flyby_to_convoy", 8, 3);
  level thread queue_checkpoint_save();
  level notify("kill_flybys_remotely");
  level notify("drone_wave_complete");
  wait_until_convoy_can_move("convoy_moveto_eject_sequence");
  maps\la_2::convoy_move_to_position("convoy_moveto_eject_sequence");
  flag_set("dogfight_done");
  delay_thread(0.1, ::screen_message_delete);
  level.f35 notify("update_plane_damage_state");
}

queue_checkpoint_save() {
  level notify("queue_checkpoint_save");
  level endon("queue_checkpoint_save");
  level waittill("safe_save");

  if(level.f35.health <= 0) {
    return;
  }
  autosave_now("strafe_wave_complete");
}

dogfight_friendly_vo_callouts() {
  a_general_vo = array("convoy_tracking_si_019", "tracking_target_h_039", "target_lock_veloci_040", "maintaining_curren_041", "altitude_locked_042");
  flag_wait("dogfights_story_done");
  wait 5;

  while(!flag("dogfight_done")) {
    line = random(a_general_vo);
    level.player say_dialog(line);
    wait(randomfloatrange(5, 7));
  }
}

define_air_to_air_offsets() {
  level.a_air_to_air_offsets = [];
  level.a_air_to_air_offsets["convoy"] = [];
  level.a_air_to_air_offsets["convoy"][0] = vectorscale((1, 1, 0), 1000.0);
  level.a_air_to_air_offsets["convoy"][1] = (-100, 1000, 0);
  level.a_air_to_air_offsets["convoy"][2] = vectorscale((1, -1, 0), 1000.0);
  level.a_air_to_air_offsets["convoy"][3] = (-100, -1000, 0);
  level.a_air_to_air_offsets["player"] = [];
  level.a_air_to_air_offsets["player"][0] = vectorscale((1, 1, 0), 1000.0);
  level.a_air_to_air_offsets["player"][1] = vectorscale((-1, 1, 0), 1000.0);
  level.a_air_to_air_offsets["player"][2] = vectorscale((1, -1, 0), 1000.0);
  level.a_air_to_air_offsets["player"][3] = vectorscale((-1, -1, 0), 1000.0);
  level.a_air_to_air_offsets["allies"] = [];
  level.a_air_to_air_offsets["allies"][0] = (1650, -1500, 400);
  level.a_air_to_air_offsets["allies"][1] = (1650, 1500, -250);
  level.a_air_to_air_offsets["allies"][2] = (2500, -1500, 1500);
  level.a_air_to_air_offsets["allies"][3] = (2500, 1500, 1500);
  level.a_air_to_air_offsets["axis"] = [];
  level.a_air_to_air_offsets["axis"][0] = (1500, -3000, 0);
  level.a_air_to_air_offsets["axis"][1] = (1500, 3000, 1500);
  level.a_air_to_air_offsets["axis"][2] = (-1500, -3000, -1500);
  level.a_air_to_air_offsets["axis"][3] = (-1500, 5000, 1000);
  level.a_air_to_air_offsets["axis"][4] = (1500, -5000, -1000);
  level.a_air_to_air_offsets["axis"][5] = (1500, 1750, -3000);
  level.a_air_to_air_offsets["axis"][6] = (-1500, -1750, 3000);
  level.a_air_to_air_offsets["axis"][7] = (-1500, 1750, 0);
  level.a_air_to_air_offsets["axis"][8] = (1500, -1750, 0);
  level.a_air_to_air_offsets["axis"][9] = (1500, 1750, 0);
  level.a_air_to_air_offsets["axis"][10] = (-1500, -1750, 0);
  level.a_air_to_air_offsets["axis"][11] = (-1500, 1750, 0);
  level.highway_routes = [];
  level.highway_routes[0] = [];
  level.highway_routes[0][0] = "north_east_to_north_west_transfer";
  level.highway_routes[0][1] = "north_east_to_south_east_transfer";
  level.highway_routes[0][2] = "north_east_to_south_west_transfer";
  level.highway_routes[1] = [];
  level.highway_routes[1][0] = "south_east_to_north_east_transfer";
  level.highway_routes[1][1] = "south_east_to_south_west_transfer";
  level.highway_routes[1][2] = "south_east_to_north_west_transfer";
  level.highway_routes[2] = [];
  level.highway_routes[2][0] = "south_west_to_north_east_transfer";
  level.highway_routes[2][1] = "south_west_to_south_east_transfer";
  level.highway_routes[2][2] = "south_west_to_north_east_transfer";
  level.plane_radii = [];
  level.plane_radii["allies"] = 500;
  level.plane_radii["axis"] = 500;
}

spawn_eject_friendly_follow_plane() {
  define_air_to_air_offsets();
  level thread spawn_convoy_f35_allies("start_flyby_for_eject", 1, 4, undefined, 1, 0);
  level thread spawn_convoy_strafing_wave("start_flyby_for_eject", 4, 4);
  wait 1;
  a_enemy_planes = getentarray("convoy_strafing_plane", "targetname");

  foreach(vh_plane in a_enemy_planes) {
    vh_plane veh_magic_bullet_shield(1);
    vh_plane thread remove_magic_bullet_shield_when_player_close();
    vh_plane thread reinforce_wave();
  }
}

remove_magic_bullet_shield_when_player_close() {
  self endon("death");
  level endon("dogfights_done");

  while(isDefined(level.f35)) {
    dist = distance2d(level.f35.origin, self.origin);

    if(dist < 10000) {
      self veh_magic_bullet_shield(0);
      return;
    }

    wait 0.05;
  }
}

reinforce_wave() {
  self waittill("death");
  level endon("dogfights_done");

  if(isDefined(self.currentnode)) {
    vh_plane = spawn_vehicle_from_targetname("pegasus_fast_la2_dogfights");
    vh_plane.is_dogfight_plane = 1;
    vh_plane.n_wave_num = self.n_wave_num;
    vh_plane.targetname = "convoy_strafing_plane";
    vh_plane.default_path_variable_offset = vectorscale((1, 1, 1), 2000.0);
    vh_plane setspeedimmediate(400, 10);
    vh_plane thread _set_strafing_run_objective_on_plane(self.objective_index);
    vh_plane thread _dogfight_fire_on_command("convoy");
    vh_plane thread _dogfight_drone_attack_missile_fire();
    vh_plane init_chaff();
    vh_plane thread dogfight_countermeasures_think();
    vh_plane thread _dogfight_speed_monitor("convoy", self.objective_index - 1, 7000, 600, 0.9);
    vh_plane thread _plane_drive_highway_internal();
    vh_plane thread dogfight_drone_evade();
    vh_plane thread f35_target_death_watcher();
    vh_plane.is_convoy_plane = 1;
    vh_plane thread go_path(self.currentnode);
    vh_plane thread reinforce_wave();
  }
}

spawn_end_helis() {
  trigger_use("trig_end_helis");
  wait 0.15;
  helis = getentarray("end_heli", "targetname");
}

wait_until_convoy_can_move(str_structs_name) {
  a_moveto_structs = getstructarray(str_structs_name, "targetname");
  a_vehicles = level.convoy.vehicles;
  can_move = 0;

  while(!can_move) {
    can_see_convoy = level.player is_player_looking_at(a_vehicles[0].origin, 0.7, 0);
    can_see_moveto = level.player is_player_looking_at(a_moveto_structs[0].origin, 0.7, 0);

    if(!can_see_convoy && !can_see_moveto)
      can_move = 1;

    wait 0.25;
  }
}

dogfights_manage_wave_count() {
  level endon("dogfight_done");
  level.n_current_strafing_wave = 1;

  while(true) {
    level waittill("drone_wave_complete");
    level.n_current_strafing_wave++;
  }
}

pip_dogfights_1() {
}

_setup_deathblossom_offsets(str_temp_planes, str_veh_pathnode) {
  level.a_death_blossom_offsets = [];
  a_planes = getentarray(str_temp_planes, "targetname");
  veh_node = getvehiclenode(str_veh_pathnode, "targetname");

  foreach(e_plane in a_planes)
  level.a_death_blossom_offsets[level.a_death_blossom_offsets.size] = e_plane.origin - veh_node.origin;

  array_delete(a_planes);
}

_set_direction_on_nodes(str_node_targetname) {
  nd_node_a = getvehiclenode(str_node_targetname, "targetname");

  for(nd_node_b = getvehiclenode(nd_node_a.target, "targetname"); !isDefined(nd_node_a.script_dir); nd_node_b = getvehiclenode(nd_node_a.target, "targetname")) {
    nd_node_c = getvehiclenode(nd_node_b.target, "targetname");
    v_b_to_c = nd_node_c.origin - nd_node_b.origin;
    temp_pos = nd_node_b.origin + v_b_to_c / 4;
    nd_node_a.script_dir = vectornormalize(temp_pos - nd_node_a.origin);
    nd_node_a = nd_node_b;
  }
}

_set_strafing_run_objective_on_plane(n_index) {
  if(!isDefined(level.dogfights_objective_strafe_marker_active)) {
    level.dogfights_objective_strafe_marker_active = 1;
    objective_add(level.obj_dogfights_strafe, "current");
    objective_set3d(level.obj_dogfights_strafe, 1, "red");
  }

  self.objective_target = 1;
  self.objective_index = n_index;
  target_set(self);
  is_objective_on = 1;
  objective_additionalposition(level.obj_dogfights_strafe, n_index, self);

  while(isalive(self)) {
    wait 1;

    if(!isalive(self)) {
      objective_additionalposition(level.obj_dogfights_strafe, n_index, (0, 0, 0));
      return;
    }

    can_see = level.player is_player_looking_at(self.origin, 0.7, 0);
    n_dist = distancesquared(level.player.origin, self.origin);

    if(is_objective_on && can_see) {
      is_objective_on = 0;
      objective_additionalposition(level.obj_dogfights_strafe, n_index, (0, 0, 0));
    } else if(!is_objective_on && !can_see) {
      is_objective_on = 1;
      objective_additionalposition(level.obj_dogfights_strafe, n_index, self);
    }
  }

  objective_additionalposition(level.obj_dogfights_strafe, n_index, (0, 0, 0));
  level.aerial_vehicles.dogfights.killed_total++;
  dogfights_objective_update_counter();
}

play_specialized_shot_audio() {
  level.player waittill("missile_fire", missile);
  clientnotify("gnses");
  setmusicstate("LA_2_END");
  level.player playsound("wpn_f35_rocket_fire_green");
}

waitfor_leadplane_death(plane, array) {
  plane waittill("death");
  origin = plane.origin;
  playsoundatposition("exp_f35_missile_explo_green", origin);

  for(i = 0; i < 7; i++) {
    playsoundatposition("wpn_death_blossom_fire_green", origin);
    wait(randomfloatrange(0, 0.1));
  }
}

spawn_player_strafing_wave(n_scripted_count) {
  level endon("dogfight_done");

  if(isDefined(n_scripted_count))
    n_flyby_count = n_scripted_count;
  else
    n_flyby_count = 2;

  flag_clear("force_flybys_available");
  flag_set("strafing_run_active");
  a_planes = [];
  vh_lead_plane = undefined;
  luinotifyevent(&"hud_missile_incoming", 1, 1);
  level thread _pulse_hud_circle();

  for(i = 0; i < 6; i++) {
    level thread player_strafe_burst_firing();
    wait 0.5;
  }

  for(i = 0; i < n_flyby_count; i++) {
    vh_plane = plane_spawn("avenger_fast_la2");
    vh_plane init_chaff();
    vh_plane thread dogfight_countermeasures_think();
    vh_plane thread _dogfight_speed_monitor("player", i - 1);

    while(!vh_plane dogfight_player_strafe(vh_lead_plane, i - 1))
      wait 0.05;

    vh_plane thread _dogfight_fire_on_command("player");
    vh_plane _setup_plane_firing_by_type();
    vh_plane thread _set_strafing_run_objective_on_plane(i);

    if(!isDefined(vh_lead_plane))
      vh_lead_plane = vh_plane;

    a_planes[a_planes.size] = vh_plane;
    wait 0.25;
  }

  level thread wave_speed_monitor(a_planes);
  level notify("stop_circle_pulse");
  luinotifyevent(&"hud_missile_incoming", 1, 0);
  array_wait(a_planes, "death");
  flag_clear("strafing_run_active");
}

_pulse_hud_circle() {
  level endon("stop_circle_pulse");
  n_current = 1000;

  while(true) {
    luinotifyevent(&"hud_missile_incoming_dist", 2, int(n_current / 12), int(1000 / 12));
    n_current = n_current - 40;

    if(n_current <= 100)
      n_current = 1000;

    wait 0.05;
  }
}

spawn_convoy_strafing_wave(initial_path, n_count, n_wave_num) {
  level endon("dogfight_done");

  if(!isDefined(n_count))
    n_flyby_count = 2;
  else
    n_flyby_count = n_count;

  flag_clear("force_flybys_available");
  flag_set("strafing_run_active");

  if(!isDefined(level.a_convoy_planes))
    level.a_convoy_planes = [];
  else
    arrayremovevalue(level.a_convoy_planes, undefined);

  vh_lead_plane = undefined;
  level thread convoy_strafing_exploders(n_wave_num);

  for(i = 0; i < n_flyby_count; i++) {
    vh_plane = plane_spawn("pegasus_fast_la2_dogfights", ::dogfight_convoy_strafe, initial_path, vh_lead_plane, i - 1);
    vh_plane.is_dogfight_plane = 1;
    vh_plane.n_wave_num = n_wave_num;
    vh_plane.targetname = "convoy_strafing_plane";
    vh_plane setspeedimmediate(400, 10);
    vh_plane thread _set_strafing_run_objective_on_plane(i);
    vh_plane thread _dogfight_fire_on_command("convoy");
    vh_plane thread _dogfight_drone_attack_missile_fire();
    vh_plane init_chaff();
    vh_plane thread dogfight_countermeasures_think();
    vh_plane thread _dogfight_speed_monitor("convoy", i - 1, 7000, 600, 0.9);
    vh_plane thread _plane_drive_highway_internal();
    vh_plane thread dogfight_drone_evade();
    vh_plane thread f35_target_death_watcher();
    vh_plane.is_convoy_plane = 1;

    if(n_wave_num == 2 || n_wave_num == 3)
      vh_plane thread dogfight_drones_weapons_think();

    if(!isDefined(vh_lead_plane))
      vh_lead_plane = vh_plane;

    if(n_wave_num == 3) {
      if(i == 0 || i == 2 || i == 4 || i == 6)
        vh_plane.wave_3_split = 1;
    }

    level.a_convoy_planes[level.a_convoy_planes.size] = vh_plane;
    wait 0.25;
  }

  if(n_wave_num == 3)
    level thread last_wave_vo();

  level notify("drone_spawn_done");
  level thread wave_speed_monitor(level.a_convoy_planes);
  array_wait(level.a_convoy_planes, "death");
  flag_clear("strafing_run_active");
}

last_wave_vo() {
  a_drones = level.a_convoy_planes;

  while(a_drones.size > 0) {
    array_wait_any(a_drones, "death");
    a_drones = remove_dead_from_array(a_drones);

    if(a_drones.size == 4)
      level.player thread queue_dialog("f38c_warning_structural_2");
    else if(a_drones.size == 1)
      level.player thread queue_dialog("sect_she_s_coming_apart_0");
  }
}

convoy_strafing_exploders(n_wave) {
  level endon("drone_wave_complete");
  level endon("dogfights_done");

  if(n_wave == 1)
    n_exploder = 510;
  else if(n_wave == 2)
    n_exploder = 520;
  else if(n_wave == 3)
    n_exploder = 530;

  while(true) {
    level waittill("missile_fired_at_convoy");
    exploder(n_exploder);
    wait 10;
  }
}

convoy_strafing_fail_watcher() {
  level endon("dogfights_done");
  vh_van = level.convoy.vh_van;
  level.n_safe_strafes = 1;
  n_random_spoken = 0;
  n_convoy_health = level.convoy.vehicles.size * 2;

  if(n_convoy_health > 5)
    n_convoy_health = 5;

  if(flag("harper_dead"))
    str_dialog_array = array("samu_we_re_taking_damage_0", "samu_dammit_we_re_under_0", "samu_keep_them_off_us_0", "samu_we_need_you_with_the_0");
  else
    str_dialog_array = array("harp_section_those_dron_0", "take_the_heat_off_009", "the_drones_are_tar_051", "harp_where_are_you_secti_0", "keep_them_off_us_015");

  str_dialog_array = array_randomize(str_dialog_array);

  while(true) {
    wait 5;
    level waittill("missile_fired_at_convoy");

    if(level.n_safe_strafes) {
      level.n_safe_strafes--;

      if(str_dialog_array.size <= n_random_spoken)
        n_random_spoken = 0;

      vh_van say_dialog(str_dialog_array[n_random_spoken]);
      n_random_spoken++;
      continue;
    } else {
      n_convoy_health--;
      str_vo = undefined;

      switch (n_convoy_health) {
        case 5:
          str_vo = flag("harper_dead") ? "we_just_took_a_dir_052" : "dammit_were_taki_014";
          level thread convoy_strafing_kill_cougar();
          break;
        case 4:
          convoy_strafe_pip("la_pip_seq_5", "samu_the_drones_are_targe_0");
          break;
        case 3:
          str_vo = flag("harper_dead") ? "samu_where_are_you_secti_0" : "harp_where_the_hell_are_y_0";
          level thread convoy_strafing_kill_cougar();
          break;
        case 2:
          convoy_strafe_pip("la_pip_seq_6", "samu_dammit_section_w_0");
          break;
        case 1:
          convoy_strafe_pip("la_pip_seq_7", "samu_dammit_section_on_0");
          break;
        case 0:
          level thread convoy_strafing_kill_cougar();
          break;
      }

      if(isDefined(str_vo)) {
        wait 3;
        vh_van say_dialog(str_vo);
      }
    }
  }
}

convoy_strafing_kill_cougar() {
  vh_leader = convoy_get_leader();
  e_attacker = getentarray("convoy_strafing_plane", "targetname")[0];
  vh_leader.takedamage = 1;
  vh_leader.overridevehicledamage = undefined;
  vh_leader do_vehicle_damage(vh_leader.armor, e_attacker);
}

convoy_strafe_pip(str_pip, str_vo) {
  wait 3;
  level thread pip_start(str_pip);
  level.convoy.vh_potus say_dialog(str_vo, 1.5);
  b_played_pip = 1;
}

spawn_convoy_f35_allies(initial_path, n_count, n_wave_num, b_blah, b_follow_obj, b_remove_in_proximity) {
  if(!isDefined(b_follow_obj))
    b_follow_obj = 1;

  if(!isDefined(b_remove_in_proximity))
    b_remove_in_proximity = 1;

  if(!isDefined(b_blah))
    level waittill("drone_spawn_done");
  else if(!isDefined(level.drone_targets)) {
    level.drone_targets = [];
    level.drone_targets[0] = level.player;
  }

  f35_allies = [];

  if(!isDefined(level.a_air_to_air_offsets))
    define_air_to_air_offsets();

  nd_best_start = getvehiclenode(initial_path, "targetname");

  for(i = 0; i < n_count; i++) {
    vh_plane = plane_spawn("f35_fast_la2");
    vh_plane setmodel("veh_t6_air_fa38_x2");
    vh_plane.targetname = "convoy_f35_ally_" + n_wave_num;
    vh_plane.script_noteworthy = "friendly_f35";
    vh_plane.n_wave_num = n_wave_num;
    vh_plane.default_path_fixed_offset = level.a_air_to_air_offsets["allies"][i];
    vh_plane pathfixedoffset(vh_plane.default_path_fixed_offset);
    vh_plane.default_path_variable_offset = (1000, 500, 1000);
    vh_plane thread go_path(nd_best_start);
    vh_plane thread _dogfight_ally_speed_monitor();
    vh_plane.is_convoy_plane = 1;

    if(b_follow_obj)
      vh_plane thread _dogfight_follow_ally(b_remove_in_proximity);

    if(!isDefined(b_blah))
      vh_plane thread dogfight_allies_weapons_think();

    vh_plane.transfer_route = 1;
    vh_plane thread _plane_drive_highway_internal();
    f35_allies[i] = vh_plane;

    if(isDefined(b_blah) || n_wave_num == 3) {
      if(isDefined(level.drone_targets)) {
        level.drone_targets[level.drone_targets.size] = vh_plane;
        vh_plane thread drone_target_death_watcher();
      }
    }

    if(n_wave_num == 3) {
      if(i == 1 || i == 3)
        vh_plane.wave_3_split = 1;
    }

    wait 0.25;
  }

  if(!isDefined(b_blah)) {
    level waittill("drone_wave_complete");
    array_thread(f35_allies, ::f38_delete_offscreen);
  }
}

spawn_attack_drones_manager() {
  level endon("dogfights_done");
  drones = [];
  level.attack_drone_offsets = [];
  level.attack_drone_offsets[0] = vectorscale((1, 0, 0), 15000.0);
  level.attack_drone_offsets[1] = (15000, -1500, 1000);
  level.attack_drone_offsets[2] = (15000, 1500, -1000);
  level.f35.dot_active = 0;

  while(true) {
    level.convoy.vh_van thread say_dialog("harp_dammit_section_the_0");

    for(i = 0; i < 1; i++)
      drones[drones.size] = spawn_attacking_drone(i);

    array_wait(drones, "death");
    wait 25;
  }
}

spawn_attacking_drone(id) {
  vh_plane = spawn_vehicle_from_targetname("pegasus_fast_la2_dogfights");
  vh_plane.origin = level.player.origin + (randomintrange(-10000, 10000), randomintrange(-10000, 10000), randomintrange(-1000, 1000));
  vh_plane thread attacking_drone_think(id);
  return vh_plane;
}

attacking_drone_think(id) {
  self endon("death");
  level endon("kill_attacking_drones");
  self setspeed(600, 500);
  target_set(self);
  self thread attacking_drone_fire_weapons();
  attack_time = 0;
  max_attack_time = 10;
  leave_time = 0;
  max_leave_time = 3;

  while(true) {
    player_ang_vel = level.f35 getangularvelocity();
    ang_vel_pct = abs(player_ang_vel[1]) / 60;
    ang_vel_scale = ang_vel_pct * 3;

    if(level.f35.boosting)
      ang_vel_scale = ang_vel_scale * 3;

    attack_time = attack_time + 0.05 * ang_vel_scale;
    attack_dist = -3000;

    if(attack_time > max_attack_time) {
      attack_dist = level.attack_drone_offsets[id][0];
      self notify("player_shook_me");
      level notify("player_shook_me");
      level.f35.dot_active = 0;
    }

    self setvehgoalpos(level.f35.origin + anglestoforward(level.f35.angles) * attack_dist + anglestoright(level.f35.angles) * level.attack_drone_offsets[id][1]);
    wait 0.05;
  }
}

attacking_drone_fire_weapons() {
  self endon("death");
  self maps\_turret::set_turret_target(level.f35, vectorscale((0, 0, 1), 50.0), 0);
  self maps\_turret::set_turret_target(level.f35, (0, -1500, 500), 1);
  self maps\_turret::set_turret_target(level.f35, (0, 1500, 500), 2);

  while(true) {
    level notify("player_being_fired_on");
    self thread attack_drone_fake_dot();
    self maps\_turret::fire_turret_for_time(randomfloatrange(4, 6), 0);
    self notify("done_firing");
    wait(randomfloatrange(0.5, 1));
    self thread maps\_turret::fire_turret_for_time(1, 1);
    self thread maps\_turret::fire_turret_for_time(1, 2);
  }
}

attack_drone_fake_dot() {
  self endon("death");
  self endon("done_firing");
  self endon("player_shook_me");
  level endon("player_shook_me");
  level.f35 endon("death");

  if(level.f35.dot_active) {
    return;
  }
  level.f35.dot_active = 1;
  fire_time = 0;
  dt = 0.1;

  while(true) {
    fire_time = fire_time + dt;

    if(fire_time < 2)
      level.f35 dodamage(5, self.origin, self);
    else {
      wait 2;
      fire_time = 0;
    }

    wait(dt);
  }
}

f38_delete_offscreen() {
  self endon("death");

  while(level.player is_player_looking_at(self.origin, 0.7, 0))
    wait 0.05;

  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

_dogfight_follow_ally(b_remove_in_proximity) {
  if(!isDefined(b_remove_in_proximity))
    b_remove_in_proximity = 1;

  maps\_objectives::set_objective(level.obj_follow, self, "follow");
  n_remove_follow_dist = 100000000;

  if(b_remove_in_proximity) {
    wait 7;
    is_player_near = 0;

    while(isalive(self) && isDefined(self) && !is_player_near) {
      n_dist = distancesquared(self.origin, level.f35.origin);

      if(n_dist < n_remove_follow_dist)
        is_player_near = 1;

      wait 0.05;
    }

    maps\_objectives::set_objective(level.obj_follow, self, "remove");
  } else {
    level waittill("eject_drone_spawned");
    maps\_objectives::set_objective(level.obj_follow, self, "remove");
  }
}

drone_target_death_watcher() {
  self waittill("death");
  arrayremovevalue(level.drone_targets, self);
}

f35_target_death_watcher() {
  self waittill("death");
  arrayremovevalue(level.a_convoy_planes, self);
}

_plane_drive_highway_internal(initial_path) {
  self endon("death");

  if(isDefined(initial_path))
    self thread go_path(initial_path);

  self thread _plane_respect_path_width();

  while(true) {
    self waittill("switch_node");
    switch_node_name = self.currentnode.script_string;

    if(switch_node_name == "transfer") {
      loop_id = self.currentnode.script_int;
      switch_node_name = level.highway_routes[loop_id][self.transfer_route];
      self.transfer_route++;

      if(self.transfer_route >= level.highway_routes[loop_id].size)
        self.transfer_route = 0;
    } else if(switch_node_name == "attack_path") {
      if(self.n_wave_num == 3) {
        continue;
      }
      switch_node_name = "wave_" + self.n_wave_num + "_attack_path";
    } else if(switch_node_name == "wave_3_split_path") {
      if(!isDefined(self.wave_3_split))
        continue;
    }

    self.switchnode = getvehiclenode(switch_node_name, "targetname");
    self setswitchnode(self.nextnode, self.switchnode);
  }
}

_plane_respect_path_width() {
  self endon("death");

  while(true) {
    radius = self.vteam == "axis" ? level.plane_radii["axis"] : level.plane_radii["allies"];
    variable_offset = self getpathvariableoffset();
    fixed_offset = self getpathfixedoffset();

    if(isDefined(self.nextnode)) {
      if(isDefined(self.nextnode.height)) {
        target_z = self.nextnode.origin[2] + self.nextnode.height;
        path_z = self.pathpos[2];
        fixed_offset_z = fixed_offset[2];
        variable_offset_z = variable_offset[2];
        real_z = path_z + fixed_offset_z;

        if(real_z < target_z) {
          new_offset_z = fixed_offset[2] + 50.0;
          self pathfixedoffset((fixed_offset[0], fixed_offset[1], new_offset_z));
        }
      } else if(isDefined(self.default_path_fixed_offset)) {
        if(fixed_offset[2] != self.default_path_fixed_offset[2]) {
          delta_z = self.default_path_fixed_offset[2] - fixed_offset[2];
          self pathfixedoffset((fixed_offset[0], fixed_offset[1], fixed_offset[2] + delta_z * 0.05));
        }
      }
    }

    if(isDefined(self.default_path_fixed_offset)) {
      if(abs(fixed_offset[1]) + radius > self.pathwidth) {
        desired_offset = self.default_path_fixed_offset[1] < 0 ? self.pathwidth * -1 + radius / 2 : self.pathwidth - radius / 2;
        delta = (self.default_path_fixed_offset[1] - fixed_offset[1]) / 0.05;
        delta = clamp(delta, -1000, 1000);
        new_offset_y = fixed_offset[1];
        new_offset_y = new_offset_y + delta * 0.05;
        new_offset_y = clamp(new_offset_y, self.pathwidth * -1, self.pathwidth);
        self pathfixedoffset((fixed_offset[0], new_offset_y, fixed_offset[2]));
      } else if(abs(fixed_offset[1]) < abs(self.default_path_fixed_offset[1]) && abs(self.default_path_fixed_offset[1]) < self.pathwidth) {
        new_offset_y = fixed_offset[1];
        delta = (self.default_path_fixed_offset[1] - fixed_offset[1]) / 0.05;
        delta = clamp(delta, -1000, 1000);
        new_offset_y = new_offset_y + delta * 0.05;

        if(self.default_path_fixed_offset[1] < 0 && new_offset_y < self.default_path_fixed_offset[1])
          new_offset_y = self.default_path_fixed_offset[1];
        else if(self.default_path_fixed_offset[1] > 0 && new_offset_y > self.default_path_fixed_offset[1])
          new_offset_y = self.default_path_fixed_offset[1];

        new_offset_y = clamp(new_offset_y, self.pathwidth * -1, self.pathwidth);
        self pathfixedoffset((fixed_offset[0], new_offset_y, fixed_offset[2]));
      }
    }

    wait 0.05;
  }
}

plane_drive_highway(initial_path, vh_lead_plane, n_follower) {
  if(isDefined(vh_lead_plane)) {
    self thread plane_drive_highway_follow(vh_lead_plane.chosen_path, n_follower);
    return;
  }

  if(isDefined(initial_path))
    nd_best_start = getvehiclenode(initial_path, "targetname");

  self.default_path_variable_offset = vectorscale((1, 1, 1), 2000.0);
  self pathvariableoffset(self.default_path_variable_offset, randomfloatrange(3, 5));
  self.chosen_path = nd_best_start;
  self thread _plane_drive_highway_internal(nd_best_start);
}

plane_drive_highway_follow(nd_start_path, num_offset) {
  self endon("death");

  if(num_offset < level.a_air_to_air_offsets["convoy"].size) {
    self.default_path_fixed_offset = level.a_air_to_air_offsets["convoy"][num_offset];
    self pathfixedoffset(self.default_path_fixed_offset);
  }

  self.default_path_variable_offset = (2000, 1000, 2000);
  self pathvariableoffset(self.default_path_variable_offset, randomfloatrange(2, 5));
  self thread _plane_drive_highway_internal(nd_start_path);
}

dogfight_allies_weapons_think() {
  self endon("death");

  while(true) {
    wait(randomfloatrange(4, 6));

    if(level.a_convoy_planes.size > 0) {
      level notify("f38_firing_cannons");
      target = random(level.a_convoy_planes);
      self maps\_turret::set_turret_target(target, (0, 0, 0), 1);
      self maps\_turret::set_turret_target(target, (0, 0, 0), 2);
      self thread maps\_turret::fire_turret_for_time(randomfloatrange(3, 5), 1);
      self thread maps\_turret::fire_turret_for_time(randomfloatrange(3, 5), 2);

      if(randomint(100) < 20) {
        level notify("f38_firing_missile");
        self maps\_turret::set_turret_target(target, (0, 0, 0), 0);
        self fireweapon(target);
      }
    }
  }
}

dogfight_drones_weapons_think() {
  self endon("death");

  while(true) {
    wait(randomfloatrange(4, 6));

    if(isDefined(level.drone_targets) && level.drone_targets.size > 0) {
      target = random(level.drone_targets);
      self maps\_turret::set_turret_target(target, (0, 0, 0), 0);
      self thread maps\_turret::fire_turret_for_time(randomfloatrange(3, 5), 0);
    }
  }
}

dogfight_player_strafe(vh_lead_plane, n_follower) {
  level thread player_strafe_burst_firing();

  if(isDefined(vh_lead_plane)) {
    self thread dogfight_player_strafe_follow(vh_lead_plane, n_follower, (0, 36, 36));
    return true;
  }

  if(absangleclamp180(level.f35.angles[2]) > 15) {
    wait 1.0;
    return false;
  }

  v_forward = anglestoforward((0, level.f35.angles[1], level.f35.angles[2]));
  nd_start_path = getvehiclenode("start_flyover_player_spline", "targetname");
  nd_start_path.origin = level.f35.origin + vectorscale((0, 0, 1), 360.0);
  nd_next_path = getvehiclenode(nd_start_path.target, "targetname");
  nd_next_path.origin = level.f35.origin + v_forward * 12000 + vectorscale((0, 0, 1), 120.0);
  front_ref_point = nd_next_path;
  a_dogfight_nodes = getvehiclenodearray("dogfight", "script_noteworthy");
  a_dogfight_valid_nodes = [];

  foreach(node in a_dogfight_nodes) {
    if(vectordot(node.script_dir, v_forward) > 0.6)
      a_dogfight_valid_nodes[a_dogfight_valid_nodes.size] = node;
  }

  a_dogfight_nodes_player_can_see = [];

  foreach(node in a_dogfight_valid_nodes) {
    if(level.player is_looking_at(node.origin, 0.7, 1))
      a_dogfight_nodes_player_can_see[a_dogfight_nodes_player_can_see.size] = node;
  }

  a_dogfight_valid_nodes = a_dogfight_nodes_player_can_see;
  a_nodes_too_close = get_array_of_closest(front_ref_point.origin, a_dogfight_valid_nodes, undefined, undefined, 12000);

  for(i = 0; i < a_nodes_too_close.size; i++)
    arrayremovevalue(a_dogfight_valid_nodes, a_nodes_too_close[i]);

  if(a_dogfight_valid_nodes.size == 0) {
    wait 1.0;

    if(1)
      return false;

    trig_dogfight = getent("trig_dogfight_spawn_control", "targetname");

    if(level.player istouching(trig_dogfight)) {
      wait 1.0;
      return false;
    }

    if(level.player is_looking_at((trig_dogfight.origin[0], trig_dogfight.origin[1], 0) + (0, 0, level.player.origin[2]), 0.5, 0)) {
      wait 1.0;
      return false;
    }

    v_forward = v_forward * -1;

    foreach(node in a_dogfight_nodes) {
      if(vectordot(node.script_dir, v_forward) > 0.7)
        a_dogfight_valid_nodes[a_dogfight_valid_nodes.size] = node;
    }

    backwards = 1;
    a_nodes_too_close = get_array_of_closest(level.f35.origin, a_dogfight_valid_nodes, undefined, undefined, 12000);

    for(i = 0; i < a_nodes_too_close.size; i++)
      arrayremovevalue(a_dogfight_valid_nodes, a_nodes_too_close[i]);
  } else
    backwards = 0;

  assert(a_dogfight_valid_nodes.size > 0, "No good nodes in front of or behind the player, start adding side checks");

  if(isDefined(backwards) && backwards) {
    nd_start_path.origin = level.f35.origin - v_forward * 24000 + vectorscale((0, 0, 1), 360.0);
    nd_join_path = get_array_of_closest(level.f35.origin, a_dogfight_valid_nodes)[0];
    nd_prev = nd_start_path;

    for(i = 0; i < 3; i++) {
      nd_next = getvehiclenode(nd_prev.target, "targetname");
      v_dir_to_path = nd_join_path.origin - nd_prev.origin;
      n_length_fwd = vectordot(v_forward, v_dir_to_path);
      v_move_node = (v_forward * n_length_fwd * 0.5 + v_dir_to_path * 0.5) / 2;
      nd_next.origin = nd_prev.origin + v_move_node;
      nd_prev = nd_next;
    }
  } else {
    nd_join_path = get_array_of_closest(level.f35.origin, a_dogfight_valid_nodes)[0];
    nd_prev = nd_next_path;

    for(i = 0; i < 2; i++) {
      nd_next = getvehiclenode(nd_prev.target, "targetname");
      v_dir_to_path = nd_join_path.origin - nd_prev.origin;
      n_length_fwd = vectordot(v_forward, v_dir_to_path);
      v_move_node = (v_forward * n_length_fwd * 0.5 + v_dir_to_path * 0.5) / 2;
      nd_next.origin = nd_prev.origin + v_move_node;
      nd_prev = nd_next;
    }
  }

  reconnectvehiclenodes();
  self.chosen_path = nd_start_path;
  self.switch_nodes = [];
  self.switch_nodes[0] = nd_next;
  self.switch_nodes[1] = nd_join_path;
  self pathvariableoffset(vectorscale((1, 1, 1), 500.0), 1);
  self thread go_path(nd_start_path);
  self setswitchnode(nd_next, nd_join_path);
  self playsound("evt_flyby_avenger_apex_spawn");
  return true;
}

dogfight_convoy_strafe(initial_path, vh_lead_plane, n_follower) {
  if(isDefined(vh_lead_plane)) {
    self thread dogfight_convoy_strafe_follow(vh_lead_plane.chosen_path, n_follower);
    return;
  }

  if(isDefined(initial_path))
    nd_best_start = getvehiclenode(initial_path, "targetname");
  else {
    a_last_strafed_nodes = [];
    a_convoy_strafe_nodes = getvehiclenodearray("convoy_start_strafe_nodes", "script_noteworthy");
    a_convoy_strafe_nodes = array_randomize(a_convoy_strafe_nodes);

    while(!isDefined(nd_best_start)) {
      for(i = 0; i < a_convoy_strafe_nodes.size; i++) {
        if(level.player is_looking_at(a_convoy_strafe_nodes[i].origin, 0.1, 1))
          continue;
        else {
          nd_best_start = a_convoy_strafe_nodes[i];
          break;
        }
      }
    }
  }

  self.default_path_variable_offset = vectorscale((1, 1, 1), 2000.0);
  self.chosen_path = nd_best_start;
  self thread go_path(nd_best_start);
}

dogfight_convoy_strafe_follow(nd_start_path, num_offset) {
  self endon("death");

  if(num_offset < level.a_air_to_air_offsets["convoy"].size) {
    self.default_path_fixed_offset = level.a_air_to_air_offsets["convoy"][num_offset];
    self pathfixedoffset(self.default_path_fixed_offset);
  }

  self.default_path_variable_offset = (2000, 1000, 2000);
  self thread go_path(nd_start_path);
}

dogfight_player_strafe_follow(vh_leader, num_offset, vec_variation) {
  self endon("death");
  self thread go_path(vh_leader.chosen_path);
  self playsound("evt_flyby_avenger_apex_spawn");

  if(num_offset < level.a_air_to_air_offsets["player"].size)
    self pathfixedoffset(level.a_air_to_air_offsets["player"][num_offset]);

  self setswitchnode(vh_leader.switch_nodes[0], vh_leader.switch_nodes[1]);
}

dogfight_drone_evade() {
  self endon("death");

  while(true) {
    self waittill("damage");
    self pathvariableoffset(vectorscale((1, 1, 1), 1000.0), 1.0);
    wait 5;
  }
}

_set_objective_on_plane() {
  n_targets_total = 8;

  if(!isDefined(level.dogfights_objective_marker_active)) {
    level.dogfights_objective_marker_active = 1;
    objective_add(level.obj_dogfights, "current");
    objective_string(level.obj_dogfights, & "LA_2_OBJ_DOGFIGHTS", n_targets_total);
    dogfights_objective_setup();
    objective_set3d(level.obj_dogfights, 1, "default");
  }

  n_index = dogfights_objective_get_available_position();
  self.objective_target = 1;
  target_set(self);
  self waittill_either("death", "dogfight_done");
  self dogfights_objective_release_position(n_index);
  objective_additionalposition(level.obj_dogfights, n_index, (0, 0, 0));
  dogfights_objective_update_counter();
}

dogfights_objective_update_counter() {
  n_targets_total = 8;
  n_killed = level.aerial_vehicles.dogfights.killed_total;
  n_remaining = n_targets_total - n_killed;
  n_halfway = int(n_targets_total * 0.5);

  if(1) {
    return;
  }
  if(n_killed == n_halfway)
    level thread _autosave_after_bink();

  if(n_remaining <= 0) {
    if(!flag("dogfight_done")) {
      flag_set("dogfight_done");
      objective_string(level.obj_dogfights, & "LA_2_OBJ_DOGFIGHTS", 0);
      objective_state(level.obj_dogfights, "done");
    }
  } else
    objective_string(level.obj_dogfights, & "LA_2_OBJ_DOGFIGHTS", n_remaining);
}

dogfights_objective_setup() {
  level.aerial_vehicles.dogfights.objective_positions = [];
  n_max_objectives = 8;

  for(i = 0; i < n_max_objectives; i++)
    level.aerial_vehicles.dogfights.objective_positions[level.aerial_vehicles.dogfights.objective_positions.size] = 0;
}

dogfights_objective_get_available_position() {
  assert(!isDefined(self.dogfights_objective_index), "objective index is already defined on dogfight plane!");
  n_free_position = -1;

  for(i = 0; i < level.aerial_vehicles.dogfights.objective_positions.size; i++) {
    if(level.aerial_vehicles.dogfights.objective_positions[i] == 0) {
      level.aerial_vehicles.dogfights.objective_positions[i] = 1;
      self.dogfights_objective_index = i;
      n_free_position = i;
      break;
    }
  }

  return n_free_position;
}

dogfights_objective_release_position(n_index) {
  level.aerial_vehicles.dogfights.objective_positions[n_index] = 0;
}

_dogfight_spawner_determine_type() {
  n_index = randomint(2);

  if(n_index == 0)
    str_type = "avenger";
  else
    str_type = "pegasus";

  return str_type;
}

dogfight_enemy_counter() {
  level.aerial_vehicles.dogfights.targets[level.aerial_vehicles.dogfights.targets.size] = self;
  self waittill("death");
  level.aerial_vehicles.dogfights.killed_total++;
  level.aerial_vehicles.player_killed_total++;
  level.aerial_vehicles.dogfights.targets = array_removedead(level.aerial_vehicles.dogfights.targets);
}

wave_speed_monitor(a_planes, n_ideal_dist, n_too_close) {
  if(!isDefined(n_ideal_dist))
    n_ideal_dist = 8000;

  if(!isDefined(n_too_close))
    n_too_close = 6000;

  level endon("drone_wave_complete");
  level endon("midair_collision_started");
  n_dist_too_close = n_too_close * n_too_close;
  n_ideal_dist_sq = n_ideal_dist * n_ideal_dist;

  while(true) {
    a_planes = array_removedead(a_planes);
    should_speed_up = 0;
    is_player_close = 0;

    foreach(e_plane in a_planes) {
      if(isDefined(level.f35)) {
        n_distance_sq = distance2dsquared(e_plane.origin, level.f35.origin);

        if(n_distance_sq < n_dist_too_close)
          should_speed_up = 1;
        else if(n_distance_sq < n_ideal_dist_sq) {
          is_player_close = 1;
          v_plane_to_player = vectornormalize(level.f35.origin - e_plane.origin);
          v_plane_forward = vectornormalize(anglestoforward(e_plane.angles));
          v_player_forward = vectornormalize(anglestoforward(level.f35.angles));

          if(vectordot(v_plane_to_player, v_plane_forward) > 0.7) {
            if(vectordot(v_plane_forward, v_player_forward) > 0.7)
              should_speed_up = 1;
          }
        }

        continue;
      }

      should_speed_up = 1;
    }

    level.b_should_exceed_speed = should_speed_up;
    level.b_should_match_speed = is_player_close;
    wait 0.05;
  }
}

_dogfight_speed_monitor(str_path, n_path_index, ideal_dist, tolerance, dampening) {
  self endon("death");
  n_speed_min = level.f35.speed_drone_min;
  n_speed_max = level.f35.speed_drone_max;

  if(!isDefined(ideal_dist))
    ideal_dist = 8000;

  n_distance_ideal_sq = ideal_dist * ideal_dist;

  if(!isDefined(tolerance))
    tolerance = 600;

  n_tolerance_sq = tolerance * tolerance;

  if(!isDefined(dampening))
    dampening = 0.7;

  is_slow = 0;

  while(!flag("dogfight_done")) {
    if(self.n_wave_num == level.n_current_strafing_wave) {
      n_speed_new = level.f35 getspeedmph();
      n_speed_max = level.f35 getmaxspeed() / 17.6;

      if(level.b_should_exceed_speed)
        self setspeed(n_speed_max * 1.2);
      else if(!level.b_should_match_speed) {
        is_slow = 1;
        n_speed_new = int(n_speed_max * dampening);
        n_speed_new = clamp(n_speed_new, n_speed_min, n_speed_max);
        self setspeed(n_speed_new);
      } else if(level.b_should_match_speed) {
        is_slow = 0;
        n_speed_new = clamp(n_speed_new, n_speed_min, n_speed_max);
        self setspeed(n_speed_new);
      }
    }

    wait 0.05;
  }
}

_dogfight_ally_speed_monitor() {
  self endon("death");
  n_distance_ideal = 25000000;
  n_dist_too_close = 9000000;

  while(!flag("dogfight_done")) {
    if(level.a_convoy_planes.size > 0) {
      e_target = level.a_convoy_planes[0];
      n_dist = distance2dsquared(self.origin, e_target.origin);

      foreach(e_temp_target in level.a_convoy_planes) {
        n_temp_dist = distance2dsquared(self.origin, e_temp_target.origin);

        if(n_temp_dist < n_dist) {
          e_target = e_temp_target;
          n_dist = n_temp_dist;
        }
      }

      v_player_to_enemy = vectornormalize(e_target.origin - level.f35.origin);
      v_self_to_enemy = vectornormalize(e_target.origin - self.origin);
      v_self_forward = vectornormalize(anglestoforward(self.angles));
      n_speed = e_target getspeedmph();
      n_dot = vectordot(v_self_forward, v_self_to_enemy);

      if(n_dist < n_dist_too_close)
        n_speed = n_speed * 0.8;
      else if(n_dist > n_distance_ideal)
        n_speed = n_speed * 3.0;

      self setspeed(n_speed, 250);
    }

    wait 0.05;
  }
}

_dogfight_fire_on_command(e_target) {
  assert(isDefined(e_target), "Spline strafer didnt have a target - _dogfight_fire_on_command");
  self endon("death");
  level endon("dogfight_done");
  v_offset = (0, 0, 0);
  n_distance_for_missiles_sq = 12000 * 12000;
  n_distance_for_missiles_max_sq = 35000 * 35000;
  n_distance_for_guns_sq = 10000 * 10000;
  n_shots = int(2 / 0.25);
  self _setup_plane_firing_by_type();

  while(!flag("dogfight_done")) {
    self waittill("drone_update_target");

    if(e_target == "convoy")
      e_my_target = get_array_of_closest(self.origin, level.convoy.vehicles)[0];
    else if(e_target == "player")
      e_my_target = level.f35;

    for(i = 0; i < self.weapon_indicies.size; i++) {
      n_index = self.weapon_indicies[i];
      self maps\_turret::set_turret_target(e_my_target, v_offset, n_index);
    }

    self waittill("drone_fire_turret");
    level notify("convoy_being_fired_on");

    for(i = 0; i < self.weapon_indicies.size; i++) {
      n_index = self.weapon_indicies[i];
      self maps\_turret::set_turret_target(e_my_target, v_offset, n_index);
      self thread maps\_turret::fire_turret_for_time(2, n_index);
    }
  }
}

_dogfight_drone_attack_missile_fire() {
  self endon("death");

  while(true) {
    self waittill("drone_fire_missile");
    level notify("missile_fired_at_convoy");
    structs = getstructarray("drone_attack_struct_" + self.n_wave_num, "targetname");
    origin = random(structs).origin;
    self setgunnertargetvec(origin, 0);
    self setgunnertargetvec(origin, 1);
    wait(randomfloatrange(0.25, 1));
    self firegunnerweapon(0);
    self firegunnerweapon(1);
    self maps\_turret::set_turret_target(level.convoy.vh_potus, (0, 0, 0), 0);
    self thread maps\_turret::fire_turret_for_time(4, 0);
  }
}

dogfight_countermeasures_think() {
  self endon("death");

  while(true) {
    self waittill("missileTurret_fired_at_me", e_missile);
    n_dist = distance2d(self.origin, e_missile.origin);
    n_percent = n_dist * 0.003;

    if(randomint(100) < n_percent)
      b_fired_chaff = try_to_use_chaff(e_missile);
  }
}

dogfight_switch_node_test() {
  self waittill("drone_fire_turret");
  start_node = getvehiclenode("switch_test_1", "targetname");
  end_node = getvehiclenode("switch_test_2", "targetname");
  self setswitchnode(start_node, end_node);
}

init_chaff() {
  if(!isDefined(self.chaff_count))
    self.chaff_count = 1;
}

try_to_use_chaff(e_missile) {
  b_used_chaff = 0;

  if(self can_use_chaff()) {
    b_used_chaff = 1;
    self thread use_chaff(e_missile);
  }

  return b_used_chaff;
}

can_use_chaff() {
  b_can_use_chaff = isDefined(self.chaff_count) && self.chaff_count > 0;
  return b_can_use_chaff;
}

use_chaff(e_missile) {
  if(isDefined(e_missile) && is_alive(self)) {
    self.chaff_count--;
    n_chaff_scale = 200;
    n_chaff_time = 6;
    playfxontag(level._effect["chaff"], self, "tag_origin");
    self playsound("evt_drone_chaff_use");
    v_forward = anglestoforward(self.angles);
    v_right = anglestoright(self.angles);
    v_down = anglestoup(self.angles) * -1;
    v_chaff_pos = self.origin + v_down * n_chaff_scale;
    n_speed = self getspeedmph();
    n_gravity = getdvarint(#"phys_gravity");
    v_gravity = getdvarvector(#"phys_gravity_dir");
    v_chaff_direction = self.origin + v_forward * n_speed;
    v_chaff_dir = vectornormalize(vectorscale(v_forward, -0.2) + v_right);
    v_velocity = vectorscale(v_chaff_dir, randomintrange(400, 600));
    v_velocity = (v_velocity[0], v_velocity[1], v_velocity[2] - randomintrange(10, 100));
    e_chaff = spawn("script_model", v_chaff_pos);
    e_chaff setmodel("tag_origin");
    e_chaff movegravity(v_velocity, n_chaff_time);
    e_missile missile_settarget(e_chaff);
    e_missile thread _detonate_missile_near_chaff(e_chaff);
    wait(n_chaff_time);
    e_chaff delete();

    if(isDefined(e_missile) && is_alive(self)) {
      e_missile notify("stop_chasing_chaff");
      e_missile missile_settarget(self);
    }
  }
}

_detonate_missile_near_chaff(e_chaff) {
  self endon("death");
  self endon("stop_chasing_chaff");
  n_distance_explode_sq = 256 * 256;

  while(isDefined(e_chaff) && isDefined(self)) {
    n_distance_sq = distancesquared(self.origin, e_chaff.origin);

    if(n_distance_sq < n_distance_explode_sq) {
      self notify("death");
      wait 0.1;
      self resetmissiledetonationtime(0);
    }

    wait 0.1;
  }
}

plane_spawn(str_targetname, func_behavior, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_targetname), "str_targetname is a required parameter for plane_spawn!");
  vh_plane = maps\_vehicle::spawn_vehicle_from_targetname(str_targetname);
  vh_plane thread maps\la_2_drones_ambient::plane_counter();

  if(isDefined(func_behavior))
    single_thread(vh_plane, func_behavior, param_1, param_2, param_3, param_4, param_5);

  return vh_plane;
}

uav_target_convoy_leader() {
  while(!isDefined(level.convoy.leader))
    wait 0.05;

  vh_leader = level.convoy.leader;
  return vh_leader;
}

delay_weapon_firing(n_firing_wait, e_target, n_time, v_offset, n_index) {
  self endon("death");
  wait(n_firing_wait);

  if(isDefined(e_target))
    self thread maps\_turret::shoot_turret_at_target(e_target, n_time, v_offset, n_index);
}

_setup_plane_firing_by_type() {
  a_indicies = [];

  if(self.vehicletype == "drone_pegasus_fast_la2" || self.vehicletype == "drone_pegasus_fast_la2_2x") {
    n_fire_min = 2;
    n_fire_max = 4.5;
    n_wait_min = 4;
    n_wait_max = 8;

    if(isDefined(self.is_dogfight_plane) && self.is_dogfight_plane)
      a_indicies[a_indicies.size] = 0;
    else
      a_indicies[a_indicies.size] = 1;
  } else if(self.vehicletype == "drone_avenger_fast_la2" || self.vehicletype == "drone_avenger_fast_la2_2x" || self.vehicletype == "drone_avenger") {
    n_fire_min = 2;
    n_fire_max = 4.5;
    n_wait_min = 2;
    n_wait_max = 4;
    a_indicies[a_indicies.size] = 0;
  } else if(self.vehicletype == "plane_f35_fast_la2") {
    n_fire_min = 2;
    n_fire_max = 4.5;
    n_wait_min = 2;
    n_wait_max = 4;
    n_weapon_select = randomint(2);

    if(n_weapon_select == 0)
      a_indicies[a_indicies.size] = 0;
    else {
      a_indicies[a_indicies.size] = 1;
      a_indicies[a_indicies.size] = 2;
    }
  } else if(self.vehicletype == "plane_f35_vtol") {
    n_fire_min = 2;
    n_fire_max = 4.5;
    n_wait_min = 2;
    n_wait_max = 4;
    n_weapon_select = randomint(2);

    if(n_weapon_select == 0)
      a_indicies[a_indicies.size] = 0;
    else {
      a_indicies[a_indicies.size] = 1;
      a_indicies[a_indicies.size] = 2;
    }
  } else if(self.vehicletype == "plane_f35_fast_la2") {
    n_fire_min = 2;
    n_fire_max = 4.5;
    n_wait_min = 2;
    n_wait_max = 4;
    n_weapon_select = randomint(2);

    if(n_weapon_select == 0)
      a_indicies[a_indicies.size] = 0;
    else {
      a_indicies[a_indicies.size] = 1;
      a_indicies[a_indicies.size] = 2;
    }
  } else {
    assertmsg(self.vehicletype + " is not currently supported by _setup_plane_firing_by_type. implement this!");

  }

  for(i = 0; i < a_indicies.size; i++) {
    n_index = a_indicies[i];
    self maps\_turret::set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index);
  }

  self.weapons_configured = 1;
  self.weapon_indicies = a_indicies;
  return a_indicies;
}

_plane_move_to_point(s_position) {
  assert(isDefined(s_position), "s_position is a required parameter for _plane_move_to_point");
  self.origin = s_position.origin;

  if(isDefined(s_position.angles))
    self.angles = s_position.angles;
}

getbestmissileturrettarget_f38_deathblossom() {
  targetsall = target_getarray();
  targetsvalid = [];

  for(idx = 0; idx < targetsall.size; idx++) {
    if(self insidemissileturretreticlenolock(targetsall[idx]) && (isDefined(targetsall[idx].db_target) && targetsall[idx].db_target))
      targetsvalid[targetsvalid.size] = targetsall[idx];
  }

  if(targetsvalid.size == 0)
    return undefined;

  chosenent = targetsvalid[0];
  bestdot = -999;
  chosenindex = -1;

  if(targetsvalid.size > 1) {
    forward = anglestoforward(self getplayerangles());

    for(i = 0; i < targetsvalid.size; i++) {
      vec_to_target = vectornormalize(targetsvalid[i].origin - self get_eye());
      dot = vectordot(vec_to_target, forward);

      if(dot > bestdot) {
        bestdot = dot;
        chosenindex = i;
      }
    }
  }

  if(chosenindex > -1)
    chosenent = targetsvalid[chosenindex];

  return chosenent;
}

player_strafe_burst_firing() {
  v_f35_forward = anglestoforward(level.f35.angles);
  level notify("player_being_fired_on");

  if(cointoss())
    level.player playsound("evt_strafe_burst_front_00");
  else
    level.player playsound("evt_strafe_burst_front_01");

  for(i = 0; i < 10; i++) {
    v_start = level.f35.origin + vectorscale((0, 0, 1), 120.0);
    v_end = v_start + v_f35_forward * 1000;
    magicbullet("pegasus_side_minigun", v_start, v_end);
    wait 0.05;
  }
}

_dogfight_track_kills_for_vo() {
  level endon("dogfight_done");

  while(true) {
    while(!isDefined(level.player.missileturrettarget))
      wait 0.05;

    level thread _notify_target_died(level.player.missileturrettarget);
    level thread _notify_target_lost(level.player.missileturrettarget);
    level waittill("snd_target_gone", str_what_happened);

    switch (str_what_happened) {
      case "death_f38":
        level notify("f38_shot_down_drone");
        break;
      case "death_player":
        level notify("player_shot_down_drone");
        break;
      case "lost":
        level notify("vo_lost_lock");
        break;
    }

    wait 2;
  }
}

_notify_target_died(e_target) {
  level endon("snd_target_gone");
  e_target waittill("death");

  if(isDefined(e_target.locked_on) && e_target.locked_on)
    level notify("snd_target_gone", "death_f38");
  else
    level notify("snd_target_gone", "death_player");
}

_notify_target_lost(e_target) {
  level endon("snd_target_gone");

  while(true) {
    while(isDefined(level.player.missileturrettarget) && level.player.missileturrettarget == e_target)
      wait 0.05;

    wait 0.1;

    if(!isDefined(level.player.missileturrettarget) || level.player.missileturrettarget != e_target)
      level notify("snd_target_gone", "lost");
  }
}

change_dogfights_fog_based_on_height() {
  n_fog_transition_time = 1;
  maps\createart\la_2_art::art_jet_mode_settings();
  b_using_low_fog = 0;

  while(!flag("dogfight_done")) {
    n_height_from_ground = level.player.origin[2];
    b_in_low_range = n_height_from_ground < 3800;
    b_should_change_fog_setting = b_using_low_fog && !b_in_low_range || !b_using_low_fog && b_in_low_range;

    if(b_should_change_fog_setting) {
      if(b_using_low_fog)
        maps\createart\la_2_art::art_jet_mode_settings(n_fog_transition_time);
      else
        maps\createart\la_2_art::art_vtol_mode_settings(n_fog_transition_time);

      wait(n_fog_transition_time);
      b_using_low_fog = !b_using_low_fog;
    }

    wait 1;
  }
}

dogfight_ambient_building_explosions() {
  level endon("dogfight_done");
  n_max_dist = 400000000;
  n_min_dist = 0;
  a_explosion_structs = getstructarray("drone_amb_building_explosion", "targetname");

  while(true) {
    s_current_struct = undefined;
    n_current_dist = 1410065408;

    foreach(s_explode_struct in a_explosion_structs) {
      n_dist = distance2dsquared(level.f35.origin, s_explode_struct.origin);

      if(n_dist < n_max_dist && n_dist > n_min_dist && n_dist < n_current_dist) {
        if(level.player is_player_looking_at(s_explode_struct.origin, 0.7, 0))
          n_current_dist = n_dist;

        s_current_struct = s_explode_struct;
      }
    }

    if(isDefined(s_current_struct))
      playfx(level._effect["explosion_side_large"], s_current_struct.origin, anglestoforward(s_current_struct.angles));

    wait 1;
  }
}

dogfight_ally_avoid_player() {
  self endon("death");
  level endon("dogfights_done");
  self.last_player_avoid_offset = (0, 0, 0);
  self.player_avoid_offset = (0, 0, 0);

  while(isDefined(level.f35)) {
    self.last_player_avoid_offset = self.player_avoid_offset;
    delta = self.origin - level.f35.origin;
    angles = level.f35.angles;
    angles = (angles[0], angles[1], 0);
    fwd = anglestoforward(angles);
    right = anglestoright(angles);
    dist = length(delta);
    dist_fwd = vectordot(delta, fwd);
    dist_right = vectordot(delta, right);

    if(dist_right < 1000 && dist_fwd < 2000)
      self.player_avoid_offset = (self.player_avoid_offset[0], self.player_avoid_offset[1] + 25.0, self.player_avoid_offset[2]);
    else {
      y = difftrack(0, self.player_avoid_offset[1], 1, 0.05);
      self.player_avoid_offset = (self.player_avoid_offset[0], y, self.player_avoid_offset[2]);
    }

    current_offset = self getpathfixedoffset();
    current_offset = current_offset - self.last_player_avoid_offset;
    current_offset = current_offset + self.player_avoid_offset;
    self pathfixedoffset(current_offset);
    wait 0.05;
  }
}

dogfight_save_restore() {
  avg_pos = (0, 0, 0);
  avg_fwd = (0, 0, 0);
  count = 0;
  vehicles = getvehiclearray();

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.is_convoy_plane) && vehicle.is_convoy_plane) {
      avg_pos = avg_pos + vehicle.origin;
      avg_fwd = avg_fwd + anglestoforward(vehicle.angles);
      count++;
    }
  }

  if(count == 0) {
    return;
  }
  avg_pos = avg_pos / count;
  avg_fwd = avg_fwd / count;
  avg_fwd = vectornormalize(avg_fwd);
  start_pos = avg_pos - avg_fwd * 1000;

  if(isDefined(level.f35)) {
    level.f35.origin = start_pos;
    level.f35 setphysangles((0, vectoangles(avg_fwd), 0));
  }
}