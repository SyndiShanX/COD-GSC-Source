/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_teleporter.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_moon;
#using scripts\zm\zm_moon_gravity;
#using scripts\zm\zm_moon_utility;
#using scripts\zm\zm_moon_wasteland;
#namespace zm_moon_teleporter;

function teleporter_function(name) {
  teleporter = getent(name, "targetname");
  teleport_time = 0;
  str = name + "_bottom_name";
  fx_bottom = struct::get(str, "targetname");
  str = name + "_top_name";
  fx_top = struct::get(str, "targetname");
  teleport_state = "Waiting for Players";
  while(true) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(isgodmode(players[i])) {
        level.devcheater = 1;
      }
      if(players[i] isnotarget()) {
        level.devcheater = 1;
      }
    }
    num_players = valid_players_teleport();
    switch (teleport_state) {
      case "Waiting for Power": {
        break;
      }
      case "Waiting for Players": {
        num_players_inside = zm_moon_wasteland::num_players_touching_volume(teleporter);
        if(num_players_inside == 0) {} else {
          if(num_players_inside < num_players) {} else {
            teleport_time = gettime();
            teleport_time = teleport_time + 2500;
            teleport_state = "Teleport Countdown";
            clientfield::increment("teleporter_audio_sfx");
            teleporter thread function_2f6b6897();
          }
        }
        break;
      }
      case "Teleport Countdown": {
        num_players_inside = zm_moon_wasteland::num_players_touching_volume(teleporter);
        if(num_players_inside < num_players) {
          teleporter_ending(teleporter, 1);
          teleport_state = "Waiting for Players";
          util::clientnotify("cafx");
          teleporter notify("stop_exploder");
        } else {
          current_time = gettime();
          if(teleport_time <= current_time) {
            util::wait_network_frame();
            if(zm_moon_wasteland::num_players_touching_volume(teleporter) != valid_players_teleport()) {
              continue;
            }
            target_positions = get_teleporter_target_positions(teleporter, name);
            teleporter_starting(teleporter);
            for(i = 0; i < players.size; i++) {
              teleport_player_to_target(players[i], target_positions);
              players[i] clientfield::increment("beam_fx_audio");
            }
            teleport_state = "Recharging";
            teleport_time = gettime() + 5000;
            teleporter notify("stop_exploder");
            if(name == "generator_teleporter") {
              if(isDefined(level._dte_done) && level._dte_done) {
                exploder::exploder("fxexp_600");
                exploder::exploder("fxexp_601");
              }
              wait(0.5);
              exploder::exploder("fxexp_502");
              level util::delay(2, undefined, & function_78f5cb79);
              level flag::set("teleported_to_nml");
            }
            if(name == "nml_teleporter") {
              level notify("hash_5b75f7cb");
              level flag::clear("teleported_to_nml");
              if(isDefined(level._dte_done) && level._dte_done) {
                exploder::kill_exploder("fxexp_600");
                exploder::kill_exploder("fxexp_601");
              }
            }
            level thread zm_moon_wasteland::nml_dogs_init();
            teleporter_ending(teleporter, 0);
          }
        }
        break;
      }
      case "Recharging": {
        current_time = gettime();
        if(teleport_time <= current_time) {
          teleport_state = "Waiting for Players";
        }
        break;
      }
    }
    wait(0.5);
  }
}

function function_78f5cb79() {
  var_509912e9 = getent("nml_teleporter", "targetname");
  var_5021a61d = get_teleporter_target_positions(var_509912e9, "nml_teleporter");
  a_e_players = getplayers();
  foreach(e_player in a_e_players) {
    e_player zm_utility::create_streamer_hint(var_5021a61d[0].origin, var_5021a61d[0].angles, 1);
  }
  level waittill("hash_5b75f7cb");
  a_e_players = getplayers();
  foreach(e_player in a_e_players) {
    e_player zm_utility::clear_streamer_hint();
  }
}

function function_6454df1b() {
  var_c35f7190 = getent("t_stream_hint_nml_player", "targetname");
  while(true) {
    var_c35f7190 waittill("trigger", e_player);
    if(!(isDefined(e_player.var_a31e4590) && e_player.var_a31e4590)) {
      e_player.var_a31e4590 = 1;
      e_player thread function_7305cc9b(var_c35f7190);
    }
  }
}

function function_7305cc9b(var_34ef544f) {
  self endon("disconnect");
  var_f657052b = getent("generator_teleporter", "targetname");
  var_5021a61d = get_teleporter_target_positions(var_f657052b, "generator_teleporter");
  self zm_utility::create_streamer_hint(var_5021a61d[0].origin, var_5021a61d[0].angles, 1);
  while(self istouching(var_34ef544f)) {
    wait(0.05);
  }
  wait(0.05);
  self.var_a31e4590 = 0;
  if(!level flag::get("teleported_to_nml")) {
    self zm_utility::clear_streamer_hint();
  }
}

function valid_players_teleport() {
  players = getplayers();
  valid_players = 0;
  for(i = 0; i < players.size; i++) {
    if(is_player_teleport_valid(players[i])) {
      valid_players = valid_players + 1;
    }
  }
  return valid_players;
}

function is_player_teleport_valid(player) {
  if(!isDefined(player)) {
    return false;
  }
  if(!isalive(player)) {
    return false;
  }
  if(!isplayer(player)) {
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

function get_teleporter_target_positions(teleporter_ent, name) {
  target_positions = [];
  if(isDefined(teleporter_ent.script_noteworthy) && teleporter_ent.script_noteworthy == "enter_no_mans_land") {
    player_starts = struct::get_array("packp_respawn_point", "script_label");
    for(i = 0; i < player_starts.size; i++) {
      target_positions[i] = player_starts[i];
    }
  } else {
    dest_name = "nml_to_bridge_teleporter";
    for(i = 0; i < 4; i++) {
      str = (dest_name + "_player") + (i + 1) + "_position";
      ent = struct::get(str, "targetname");
      target_positions[i] = ent;
    }
  }
  return target_positions;
}

function get_teleporter_dest_ent_name() {
  index = level.nml_teleporter_dest_index;
  str = level.nml_teleporter_dest_names[index];
  return str;
}

function teleport_player_to_target(player, target_positions) {
  player_index = player.characterindex;
  target_ent = undefined;
  for(i = 0; i < target_positions.size; i++) {
    if(isDefined(target_positions[i].script_int) && target_positions[i].script_int == (player_index + 1)) {
      target_ent = target_positions[i];
    }
  }
  if(!isDefined(target_ent)) {
    target_ent = target_positions[player_index];
  }
  if(player getstance() == "prone") {
    player setstance("crouch");
  }
  player setorigin(target_ent.origin + (randomfloat(24), randomfloat(24), 0));
  if(isDefined(target_ent.angles)) {
    player setplayerangles(target_ent.angles);
  }
  if(!level.been_to_moon_before) {
    level.been_to_moon_before = 1;
    level.skit_vox_override = 1;
    level thread turn_override_off();
  }
}

function turn_override_off() {
  level notify("no_multiple_overrides");
  level endon("no_multiple_overrides");
  wait(15);
  level.skit_vox_override = 0;
}

function teleporter_starting(teleporter_ent) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(zombie_utility::is_player_valid(player)) {
      player enableinvulnerability();
    }
  }
  if(isDefined(teleporter_ent.script_noteworthy)) {}
}

function teleporter_check_for_endgame() {
  if(!isDefined(level.nml_start_time)) {
    level.nml_start_time = 0;
  }
  level util::waittill_any("end_game", "track_nml_time");
  level.nml_best_time = gettime() - level.nml_start_time;
  players = getplayers();
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

function function_2f6b6897() {
  switch (self.targetname) {
    case "nml_teleporter": {
      str_exploder_name = "fxexp_500";
      break;
    }
    case "generator_teleporter": {
      str_exploder_name = "fxexp_501";
      break;
    }
  }
  exploder::exploder(str_exploder_name);
  self waittill("stop_exploder");
  exploder::stop_exploder(str_exploder_name);
}

function display_time_survived() {
  players = getplayers();
  level.nml_best_time = gettime() - level.nml_start_time;
  level.nml_kills = players[0].kills;
  level.nml_score = players[0].score_total;
  level.nml_didteleport = 1;
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
    survived[i] = newclienthudelem(players[i]);
    survived[i].alignx = "center";
    survived[i].aligny = "middle";
    survived[i].horzalign = "center";
    survived[i].vertalign = "middle";
    survived[i].y = survived[i].y - 100;
    survived[i].foreground = 1;
    survived[i].fontscale = 2;
    survived[i].alpha = 0;
    survived[i].color = (1, 1, 1);
    if(players[i] issplitscreen()) {
      survived[i].y = survived[i].y + 40;
    }
    nomanslandtime = level.nml_best_time;
    player_survival_time = int(nomanslandtime / 1000);
    player_survival_time_in_mins = zm::to_mins(player_survival_time);
    survived[i] settext(&"ZOMBIE_SURVIVED_NOMANS", player_survival_time_in_mins);
    survived[i] fadeovertime(1);
    survived[i].alpha = 1;
  }
  wait(3);
  for(i = 0; i < players.size; i++) {
    survived[i] fadeovertime(1);
    survived[i].alpha = 0;
  }
  level.left_nomans_land = 2;
}

function teleporter_ending(teleporter_ent, was_aborted) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(zombie_utility::is_player_valid(player)) {
      if(!isgodmode(player) && getdvarint("zombie_cheat") < 1) {
        player disableinvulnerability();
      }
    }
  }
  if(!was_aborted) {
    level flag::set("teleporter_used");
    if(isDefined(teleporter_ent.script_noteworthy)) {
      if(teleporter_ent.script_noteworthy == "enter_no_mans_land") {
        level flag::set("enter_nml");
        level.on_the_moon = 0;
        level thread zm_moon::zombie_earth_gravity_init();
        level thread zm_moon_wasteland::nml_ramp_up_zombies();
        level thread zm_moon_utility::sky_transition_fog_settings();
        zombie_utility::set_zombie_var("zombie_intermission_time", 2);
        zombie_utility::set_zombie_var("zombie_between_round_time", 2);
        zombies = getaiarray();
        level.prev_round_zombies = zombies.size + level.zombie_total;
        level flag::clear("zombie_drop_powerups");
        level thread zm_moon_wasteland::perk_machine_arrival_update();
        zm_moon_wasteland::nml_setup_round_spawner();
      } else if(teleporter_ent.script_noteworthy == "exit_no_mans_land") {
        level flag::clear("enter_nml");
        level notify("stop_ramp");
        level flag::clear("start_supersprint");
        level.on_the_moon = 1;
        level.ignore_distance_tracking = 1;
        if(!(isDefined(level.intermission) && level.intermission) && isDefined(level.ever_been_on_the_moon) && !level.ever_been_on_the_moon) {
          level notify("track_nml_time");
          level thread display_time_survived();
          level.ever_been_on_the_moon = 1;
        }
        level thread zm_moon_utility::sky_transition_fog_settings();
        zm::set_round_number(level.nml_last_round);
        level.round_number = zm::get_round_number();
        zm_moon_wasteland::resume_moon_rounds(level.round_number);
        level thread zm_moon::zombie_moon_gravity_init();
        level.round_spawn_func = & zm::round_spawning;
        level thread teleporter_to_nml_power_down();
        zombie_utility::set_zombie_var("zombie_intermission_time", 15);
        zombie_utility::set_zombie_var("zombie_between_round_time", 10);
        level flag::set("zombie_drop_powerups");
        level.ignore_distance_tracking = 0;
        if(!(isDefined(level.first_round) && level.first_round)) {
          players = getplayers();
          players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "teleporter");
        }
      }
    }
  }
}

function teleporter_to_nml_init() {
  level.teleporter_to_nml_gate_height = 140;
  level.teleporter_to_nml_gate_ent = getent("teleporter_gate", "targetname");
  level.var_8243881a = getent(level.teleporter_to_nml_gate_ent.target, "targetname");
  level.var_8243881a linkto(level.teleporter_to_nml_gate_ent);
  level.teleporter_to_nml_gate_open = 0;
  level.teleporter_to_nml_powerdown_time = 120;
  level.teleporter_to_nml_gate2_ent = getent("teleporter_gate_top", "targetname");
  level.teleporter_to_nml_gate2_height = 256;
  level.teleporter_exit_nml_gate_ent = getent("bunker_gate", "targetname");
  level.teleporter_exit_nml_gate_height = -213;
  level.teleporter_exit_nml_gate_open = 1;
  level.teleporter_exit_nml_powerdown_time = 75;
  level.teleporter_exit_nml_gate2_ent = getent("bunker_gate_2", "targetname");
  level.teleporter_exit_nml_gate2_height = -106;
  level.teleporter_gate_move_time = 3;
  init_teleporter_lights();
  teleporter_lights_red();
  level thread teleporter_exit_nml_think();
  level thread teleporter_waiting_for_electric();
}

function teleporter_waiting_for_electric() {
  teleporter_to_nml_gate_move(1);
}

function teleporter_to_nml_gate_move(open_it) {
  if(level.teleporter_to_nml_gate_open && open_it || (!level.teleporter_to_nml_gate_open && !open_it)) {
    return;
  }
  level.teleporter_to_nml_gate_open = open_it;
  gate_height = level.teleporter_to_nml_gate_height;
  gate2_height = level.teleporter_to_nml_gate2_height;
  if(!open_it) {
    gate_height = gate_height * -1;
  }
  time = level.teleporter_gate_move_time;
  accel = time / 6;
  ent = level.teleporter_to_nml_gate_ent;
  var_c36da20d = level.var_8243881a;
  ent2 = level.teleporter_to_nml_gate2_ent;
  ent playSound("amb_teleporter_gate_start");
  ent playLoopSound("amb_teleporter_gate_loop", 0.5);
  pos = (ent.origin[0], ent.origin[1], ent.origin[2] - gate_height);
  ent moveto(pos, time, accel, accel);
  ent thread play_stopmoving_sounds();
  pos2 = (ent2.origin[0], ent2.origin[1], ent2.origin[2] + gate_height);
  ent2 moveto(pos2, time, accel, accel);
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

function init_teleporter_lights() {
  level.teleporter_lights = [];
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_1";
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_2";
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_3";
  level.teleporter_lights[level.teleporter_lights.size] = "zapper_teleport_opening_4";
}

function teleporter_lights_red() {
  for(i = 0; i < level.teleporter_lights.size; i++) {
    zm_moon_utility::zapper_light_red(level.teleporter_lights[i], "targetname");
  }
}

function teleporter_lights_green() {
  for(i = 0; i < level.teleporter_lights.size; i++) {
    zm_moon_utility::zapper_light_green(level.teleporter_lights[i], "targetname");
  }
}

function teleporter_to_nml_power_down() {
  teleporter_to_nml_gate_move(0);
  if(level flag::get("teleporter_used") && (isDefined(level.first_teleporter_use) && level.first_teleporter_use)) {
    level waittill("between_round_over");
    util::wait_network_frame();
  }
  if(!isDefined(level.first_teleporter_use)) {
    level thread zm_audio::sndmusicsystem_playstate("round_start_first");
    level.first_teleporter_use = 1;
  }
  level waittill("between_round_over");
  time = gettime();
  open_door_time = time + (level.teleporter_to_nml_powerdown_time * 1000);
  lights_mode = 0;
  dt = open_door_time - time;
  time0 = time + (dt / 4);
  time1 = time + (dt / 2);
  time2 = time + ((3 * dt) / 4);
  time3 = open_door_time - 0.75;
  while(time < open_door_time) {
    time = gettime();
    switch (lights_mode) {
      case 0: {
        if(time >= time0) {
          zm_moon_utility::zapper_light_green(level.teleporter_lights[0], "targetname");
          lights_mode++;
        }
        break;
      }
      case 1: {
        if(time >= time1) {
          zm_moon_utility::zapper_light_green(level.teleporter_lights[1], "targetname");
          lights_mode++;
        }
        break;
      }
      case 2: {
        if(time >= time2) {
          zm_moon_utility::zapper_light_green(level.teleporter_lights[2], "targetname");
          lights_mode++;
        }
        break;
      }
      case 3: {
        if(time >= time3) {
          zm_moon_utility::zapper_light_green(level.teleporter_lights[3], "targetname");
          lights_mode++;
          teleporter_to_nml_gate_move(1);
        }
        break;
      }
      default: {
        wait(0.1);
        break;
      }
    }
    wait(1);
  }
}

function teleporter_exit_nml_think() {
  wait(3);
  level thread teleporter_exit_nml_gate_move(0);
  while(true) {
    level flag::wait_till("enter_nml");
    if(level.on_the_moon == 0) {
      wait(20);
    } else {
      wait(level.teleporter_exit_nml_powerdown_time);
    }
    level thread teleporter_exit_nml_gate_move(1);
    while(level flag::get("enter_nml")) {
      wait(1);
    }
    level thread teleporter_exit_nml_gate_move(0);
  }
}

function teleporter_exit_nml_gate_move(open_it) {
  if(level.teleporter_exit_nml_gate_open && open_it || (!level.teleporter_exit_nml_gate_open && !open_it)) {
    return;
  }
  level.teleporter_exit_nml_gate_open = open_it;
  gate_height = level.teleporter_exit_nml_gate_height;
  gate2_height = level.teleporter_exit_nml_gate2_height;
  if(!open_it) {
    gate_height = gate_height * -1;
    gate2_height = gate2_height * -1;
  }
  time = level.teleporter_gate_move_time;
  accel = time / 6;
  ent = level.teleporter_exit_nml_gate_ent;
  ent playSound("amb_teleporter_gate_start");
  ent playLoopSound("amb_teleporter_gate_loop", 0.5);
  ent2 = level.teleporter_exit_nml_gate2_ent;
  pos2 = (ent2.origin[0], ent2.origin[1], ent2.origin[2] - gate2_height);
  ent2 moveto(pos2, time, accel, accel);
  pos = (ent.origin[0], ent.origin[1], ent.origin[2] - gate_height);
  ent moveto(pos, time, accel, accel);
  ent thread play_stopmoving_sounds();
  if(open_it) {
    ent connectpaths();
  } else {
    wait(level.teleporter_gate_move_time);
    ent disconnectpaths();
  }
}

function play_stopmoving_sounds() {
  self waittill("movedone");
  self stoploopsound(0.5);
  self playSound("amb_teleporter_gate_stop");
}