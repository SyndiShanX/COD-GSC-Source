/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_moon_teleporter.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\zombie_moon_utility;
#include maps\zombie_moon_wasteland;

teleporter_function(name) {
  teleporter = getEnt(name, "targetname");
  teleport_time = 0;
  str = name + "_bottom_name";
  fx_bottom = getstruct(str, "targetname");
  str = name + "_top_name";
  fx_top = getstruct(str, "targetname");
  teleport_state = "Waiting for Players";
  while(1) {
    players = get_players();
    num_players = valid_players_teleport();
    switch (teleport_state) {
      case "Waiting for Power":
        break;
      case "Waiting for Players":
        num_players_inside = num_players_touching_volume(teleporter);
        if(num_players_inside == 0) {
          set_teleporter_message(&"NULL_EMPTY");
        } else if(num_players_inside < num_players) {
          set_teleporter_message(&"ZOMBIE_PARIS_TRANSPORTER_WAITING");
        } else {
          set_teleporter_message(&"ZOMBIE_PARIS_TRANSPORTER_ACTIVATED");
          teleport_time = gettime();
          teleport_time += 2500;
          teleport_state = "Teleport Countdown";
          clientnotify("tafx");
        }
        break;
      case "Teleport Countdown":
        num_players_inside = num_players_touching_volume(teleporter);
        if(num_players_inside < num_players) {
          set_teleporter_message(&"ZOMBIE_PARIS_TRANSPORTER_ABORTED");
          teleporter_ending(teleporter, 1);
          teleport_state = "Waiting for Players";
          clientnotify("cafx");
        } else {
          current_time = gettime();
          if(teleport_time <= current_time) {
            wait_network_frame();
            if(num_players_touching_volume(teleporter) != valid_players_teleport()) {
              continue;
            }
            target_positions = get_teleporter_target_positions(teleporter, name);
            teleporter_starting(teleporter);
            for(i = 0; i < players.size; i++) {
              teleport_player_to_target(players[i], target_positions);
              players[i] clientnotify("bmfx");
            }
            teleport_state = "Recharging";
            set_teleporter_message(&"NULL_EMPTY");
            teleport_time = gettime() + 5000;
            level thread nml_dogs_init();
            teleporter_ending(teleporter, 0);
          }
        }
        break;
      case "Recharging":
        current_time = gettime();
        if(teleport_time <= current_time) {
          teleport_state = "Waiting for Players";
        }
        break;
    }
    wait(0.5);
  }
}

valid_players_teleport() {
  players = get_players();
  valid_players = 0;
  for(i = 0; i < players.size; i++) {
    if(is_player_teleport_valid(players[i]))
      valid_players += 1;
  }
  return valid_players;
}

is_player_teleport_valid(player) {
  if(!isDefined(player)) {
    return false;
  }
  if(!IsAlive(player)) {
    return false;
  }
  if(!IsPlayer(player)) {
    return false;
  }
  if(player.sessionstate == "spectator") {
    return false;
  }
  if(player.sessionstate == "intermission") {
    return false;
  }
  if(player isnotarget()) {
    return false;
  }
  return true;
}

get_teleporter_target_positions(teleporter_ent, name) {
  target_positions = [];
  if((isDefined(teleporter_ent.script_noteworthy)) && (teleporter_ent.script_noteworthy == "enter_no_mans_land")) {
    player_starts = getstructarray("packp_respawn_point", "script_noteworthy");
    for(i = 0; i < player_starts.size; i++) {
      target_positions[i] = player_starts[i];
    }
  } else {
    dest_name = "nml_to_bridge_teleporter";
    for(i = 0; i < 4; i++) {
      str = dest_name + "_player" + (i + 1) + "_position";
      ent = getstruct(str, "targetname");
      target_positions[i] = ent;
    }
  }
  return (target_positions);
}

get_teleporter_dest_ent_name() {
  index = level.nml_teleporter_dest_index;
  str = level.nml_teleporter_dest_names[index];
  return (str);
}

teleport_player_to_target(player, target_positions) {
  player_index = player getEntityNumber();
  target_ent = undefined;
  for(i = 0; i < target_positions.size; i++) {
    if(isDefined(target_positions[i].script_int) && target_positions[i].script_int == player_index + 1) {
      target_ent = target_positions[i];
    }
  }
  if(!isDefined(target_ent)) {
    target_ent = target_positions[player_index];
  }
  if(player getstance() == "prone") {
    player SetStance("crouch");
  }
  player setorigin(target_ent.origin + (RandomFloat(24), RandomFloat(24), 0));
  if(isDefined(target_ent.angles)) {
    player setplayerangles(target_ent.angles);
  }
  if(!level.been_to_moon_before) {
    level.been_to_moon_before = true;
    level.skit_vox_override = true;
    level thread turn_override_off();
  }
}

turn_override_off() {
  level notify("no_multiple_overrides");
  level endon("no_multiple_overrides");
  wait(15);
  level.skit_vox_override = false;
}

teleporter_starting(teleporter_ent) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(is_player_valid(player)) {
      player EnableInvulnerability();
    }
  }
  if(isDefined(teleporter_ent.script_noteworthy)) {
    if(teleporter_ent.script_noteworthy == "enter_no_mans_land") {}
  }
}

teleporter_check_for_endgame() {
  level waittill_any("end_game", "track_nml_time");
  level.nml_best_time = GetTime() - level.nml_start_time;
  players = get_players();
  level.nml_kills = players[0].kills;
  level.nml_score = players[0].score_total;
  level.nml_pap = 0;
  level.nml_speed = 0;
  level.nml_jugg = 0;
  if(isDefined(players[0].pap_used) && players[0].pap_used) {
    level.nml_pap = 22;
  }
  if(isDefined(players[0].speed_used) && players[0].speed_used) {
    level.nml_speed = 33;
  }
  if(isDefined(players[0].jugg_used) && players[0].jugg_used) {
    level.nml_jugg = 44;
  }
}

display_time_survived() {
  players = get_players();
  level.nml_best_time = GetTime() - level.nml_start_time;
  level.nml_kills = players[0].kills;
  level.nml_score = players[0].score_total;
  level.nml_didteleport = true;
  level.nml_pap = 0;
  level.nml_speed = 0;
  level.nml_jugg = 0;
  level.left_nomans_land = 1;
  survived = [];
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].pap_used) && players[i].pap_used) {
      level.nml_pap = 22;
    }
    if(isDefined(players[i].speed_used) && players[i].speed_used) {
      level.nml_speed = 33;
    }
    if(isDefined(players[i].jugg_used) && players[i].jugg_used) {
      level.nml_jugg = 44;
    }
    survived[i] = NewClientHudElem(players[i]);
    survived[i].alignX = "center";
    survived[i].alignY = "middle";
    survived[i].horzAlign = "center";
    survived[i].vertAlign = "middle";
    survived[i].y -= 100;
    survived[i].foreground = true;
    survived[i].fontScale = 2;
    survived[i].alpha = 0;
    survived[i].color = (1.0, 1.0, 1.0);
    if(players[i] isSplitScreen()) {
      survived[i].y += 40;
    }
    nomanslandtime = level.nml_best_time;
    player_survival_time = int(nomanslandtime / 1000);
    player_survival_time_in_mins = maps\_zombiemode::to_mins(player_survival_time);
    survived[i] SetText(&"ZOMBIE_SURVIVED_NOMANS", player_survival_time_in_mins);
    survived[i] FadeOverTime(1);
    survived[i].alpha = 1;
  }
  wait(3.0);
  for(i = 0; i < players.size; i++) {
    survived[i] FadeOverTime(1);
    survived[i].alpha = 0;
  }
  level.left_nomans_land = 2;
}

teleporter_ending(teleporter_ent, was_aborted) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(is_player_valid(player)) {
      player DisableInvulnerability();
    }
  }
  if(!was_aborted) {
    flag_set("teleporter_used");
    if(isDefined(teleporter_ent.script_noteworthy)) {
      if(teleporter_ent.script_noteworthy == "enter_no_mans_land") {
        flag_set("enter_nml");
        level.on_the_moon = false;
        level thread maps\zombie_moon::zombie_earth_gravity_init();
        level thread nml_ramp_up_zombies();
        level clientnotify("NMS");
        level thread sky_transition_fog_settings();
        set_zombie_var("zombie_intermission_time", 2);
        set_zombie_var("zombie_between_round_time", 2);
        zombies = GetAIArray("axis");
        level.prev_round_zombies = zombies.size + level.zombie_total;
        flag_clear("zombie_drop_powerups");
        level thread perk_machine_arrival_update();
        nml_setup_round_spawner();
      } else if(teleporter_ent.script_noteworthy == "exit_no_mans_land") {
        flag_clear("enter_nml");
        level notify("stop_ramp");
        flag_clear("start_supersprint");
        level.on_the_moon = true;
        level.ignore_distance_tracking = true;
        if(isDefined(level.ever_been_on_the_moon) && !level.ever_been_on_the_moon) {
          level notify("track_nml_time");
          level thread display_time_survived();
          level.ever_been_on_the_moon = true;
        }
        level clientnotify("MMS");
        level thread sky_transition_fog_settings();
        level.round_number = level.nml_last_round;
        resume_moon_rounds(level.round_number);
        level thread maps\zombie_moon::zombie_moon_gravity_init();
        level.round_spawn_func = maps\_zombiemode::round_spawning;
        level thread teleporter_to_nml_power_down();
        set_zombie_var("zombie_intermission_time", 15);
        set_zombie_var("zombie_between_round_time", 10);
        flag_set("zombie_drop_powerups");
        level.ignore_distance_tracking = false;
      }
    }
  }
}

teleporter_to_nml_init() {
  level.teleporter_to_nml_gate_height = 140;
  level.teleporter_to_nml_gate_ent = getEnt("teleporter_gate", "targetname");
  level.teleporter_to_nml_gate_open = 0;
  level.teleporter_to_nml_powerdown_time = 120;
  level.teleporter_to_nml_gate2_ent = getEnt("teleporter_gate_top", "targetname");
  level.teleporter_to_nml_gate2_height = 256;
  level.teleporter_exit_nml_gate_ent = getEnt("bunker_gate", "targetname");
  level.teleporter_exit_nml_gate_height = -195;
  level.teleporter_exit_nml_gate_open = 1;
  level.teleporter_exit_nml_powerdown_time = 75;
  level.teleporter_exit_nml_gate2_ent = getEnt("bunker_gate_2", "targetname");
  level.teleporter_exit_nml_gate2_height = -96;
  level.teleporter_gate_move_time = 3;
  init_teleporter_lights();
  teleporter_lights_red();
  level thread teleporter_exit_nml_think();
  level thread teleporter_waiting_for_electric();
}

teleporter_waiting_for_electric() {
  teleporter_to_nml_gate_move(1);
}

teleporter_to_nml_gate_move(open_it) {
  if((level.teleporter_to_nml_gate_open && open_it) || (!level.teleporter_to_nml_gate_open && !open_it)) {
    return;
  }
  level.teleporter_to_nml_gate_open = open_it;
  gate_height = level.teleporter_to_nml_gate_height;
  gate2_height = level.teleporter_to_nml_gate2_height;
  if(!open_it) {
    gate_height *= -1.0;
  }
  time = level.teleporter_gate_move_time;
  accel = time / 6.0;
  ent = level.teleporter_to_nml_gate_ent;
  ent2 = level.teleporter_to_nml_gate2_ent;
  ent playSound("amb_teleporter_gate_start");
  ent playLoopSound("amb_teleporter_gate_loop", .5);
  pos = (ent.origin[0], ent.origin[1], ent.origin[2] - gate_height);
  ent moveTo(pos, time, accel, accel);
  ent thread play_stopmoving_sounds();
  pos2 = (ent2.origin[0], ent2.origin[1], ent2.origin[2] + gate_height);
  ent2 moveTo(pos2, time, accel, accel);
  if(open_it) {
    ent connectpaths();
  } else {
    ent disconnectpaths();
  }
  if(open_it) {
    teleporter_lights_green();
  } else {
    teleporter_lights_red();
  }
}

init_teleporter_lights() {
  level.teleporter_lights = [];
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_1";
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_2";
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_3";
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_4";
}

teleporter_lights_red() {
  for(i = 0; i < level.teleporter_lights.size; i++) {
    zapper_light_red(level.teleporter_lights[i], "targetname");
  }
}

teleporter_lights_green() {
  for(i = 0; i < level.teleporter_lights.size; i++) {
    zapper_light_green(level.teleporter_lights[i], "targetname");
  }
}

teleporter_to_nml_power_down() {
  teleporter_to_nml_gate_move(0);
  if(flag("teleporter_used") && is_true(level.first_teleporter_use)) {
    level waittill("between_round_over");
    wait_network_frame();
  }
  if(!isDefined(level.first_teleporter_use)) {
    level.first_teleporter_use = true;
  }
  level waittill("between_round_over");
  time = gettime();
  open_door_time = time + (level.teleporter_to_nml_powerdown_time * 1000);
  lights_mode = 0;
  dt = open_door_time - time;
  time0 = time + (dt / 4.0);
  time1 = time + (dt / 2.0);
  time2 = time + ((3.0 * dt) / 4.0);
  time3 = open_door_time - 0.75;
  while(time < open_door_time) {
    time = gettime();
    switch (lights_mode) {
      case 0:
        if(time >= time0) {
          zapper_light_green(level.teleporter_lights[0], "targetname");
          lights_mode++;
        }
        break;
      case 1:
        if(time >= time1) {
          zapper_light_green(level.teleporter_lights[1], "targetname");
          lights_mode++;
        }
        break;
      case 2:
        if(time >= time2) {
          zapper_light_green(level.teleporter_lights[2], "targetname");
          lights_mode++;
        }
        break;
      case 3:
        if(time >= time3) {
          zapper_light_green(level.teleporter_lights[3], "targetname");
          lights_mode++;
          teleporter_to_nml_gate_move(1);
        }
        break;
      default:
        wait(0.1);
        break;
    }
    wait(1);
  }
}

teleporter_exit_nml_think() {
  wait(3);
  level thread teleporter_exit_nml_gate_move(0);
  while(1) {
    flag_wait("enter_nml");
    if(level.on_the_moon == false) {
      wait(20);
    } else {
      wait(level.teleporter_exit_nml_powerdown_time);
    }
    level thread teleporter_exit_nml_gate_move(1);
    while(flag("enter_nml")) {
      wait(1);
    }
    level thread teleporter_exit_nml_gate_move(0);
  }
}

teleporter_exit_nml_gate_move(open_it) {
  if((level.teleporter_exit_nml_gate_open && open_it) || (!level.teleporter_exit_nml_gate_open && !open_it)) {
    return;
  }
  level.teleporter_exit_nml_gate_open = open_it;
  gate_height = level.teleporter_exit_nml_gate_height;
  gate2_height = level.teleporter_exit_nml_gate2_height;
  if(!open_it) {
    gate_height *= -1.0;
    gate2_height *= -1.0;
  }
  time = level.teleporter_gate_move_time;
  accel = time / 6.0;
  ent = level.teleporter_exit_nml_gate_ent;
  ent playSound("amb_teleporter_gate_start");
  ent playLoopSound("amb_teleporter_gate_loop", .5);
  ent2 = level.teleporter_exit_nml_gate2_ent;
  pos2 = (ent2.origin[0], ent2.origin[1], ent2.origin[2] - gate2_height);
  ent2 moveTo(pos2, time, accel, accel);
  pos = (ent.origin[0], ent.origin[1], ent.origin[2] - gate_height);
  ent moveTo(pos, time, accel, accel);
  ent thread play_stopmoving_sounds();
  if(open_it) {
    ent connectpaths();
  } else {
    wait(level.teleporter_gate_move_time);
    ent disconnectpaths();
  }
}

play_stopmoving_sounds() {
  self waittill("movedone");
  self stopLoopSound(.5);
  self playSound("amb_teleporter_gate_stop");
}