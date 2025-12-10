/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerups.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_powerups;

function init() {
  zombie_utility::set_zombie_var("zombie_insta_kill", 0, undefined, undefined, 1);
  zombie_utility::set_zombie_var("zombie_point_scalar", 1, undefined, undefined, 1);
  zombie_utility::set_zombie_var("zombie_drop_item", 0);
  zombie_utility::set_zombie_var("zombie_timer_offset", 350);
  zombie_utility::set_zombie_var("zombie_timer_offset_interval", 30);
  zombie_utility::set_zombie_var("zombie_powerup_fire_sale_on", 0);
  zombie_utility::set_zombie_var("zombie_powerup_fire_sale_time", 30);
  zombie_utility::set_zombie_var("zombie_powerup_bonfire_sale_on", 0);
  zombie_utility::set_zombie_var("zombie_powerup_bonfire_sale_time", 30);
  zombie_utility::set_zombie_var("zombie_powerup_insta_kill_on", 0, undefined, undefined, 1);
  zombie_utility::set_zombie_var("zombie_powerup_insta_kill_time", 30, undefined, undefined, 1);
  zombie_utility::set_zombie_var("zombie_powerup_double_points_on", 0, undefined, undefined, 1);
  zombie_utility::set_zombie_var("zombie_powerup_double_points_time", 30, undefined, undefined, 1);
  zombie_utility::set_zombie_var("zombie_powerup_drop_increment", 2000);
  zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4);
  callback::on_connect(&init_player_zombie_vars);
  level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
  level._effect["powerup_off"] = "zombie/fx_powerup_off_green_zmb";
  level._effect["powerup_grabbed"] = "zombie/fx_powerup_grab_green_zmb";
  if(isDefined(level.using_zombie_powerups) && level.using_zombie_powerups) {
    level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
    level._effect["powerup_grabbed_red"] = "zombie/fx_powerup_grab_red_zmb";
  }
  level._effect["powerup_on_solo"] = "zombie/fx_powerup_on_solo_zmb";
  level._effect["powerup_grabbed_solo"] = "zombie/fx_powerup_grab_solo_zmb";
  level._effect["powerup_on_caution"] = "zombie/fx_powerup_on_caution_zmb";
  level._effect["powerup_grabbed_caution"] = "zombie/fx_powerup_grab_caution_zmb";
  init_powerups();
  if(!level.enable_magic) {
    return;
  }
  thread watch_for_drop();
}

function init_powerups() {
  level flag::init("zombie_drop_powerups");
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level flag::set("zombie_drop_powerups");
  }
  if(!isDefined(level.active_powerups)) {
    level.active_powerups = [];
  }
  add_zombie_powerup("insta_kill_ug", "zombie_skull", &"ZOMBIE_POWERUP_INSTA_KILL", &func_should_never_drop, 1, 0, 0, undefined, "powerup_instant_kill_ug", "zombie_powerup_insta_kill_ug_time", "zombie_powerup_insta_kill_ug_on", 1);
  if(isDefined(level.level_specific_init_powerups)) {
    [[level.level_specific_init_powerups]]();
  }
  randomize_powerups();
  level.zombie_powerup_index = 0;
  randomize_powerups();
  level.rare_powerups_active = 0;
  level.firesale_vox_firstime = 0;
  level thread powerup_hud_monitor();
  clientfield::register("scriptmover", "powerup_fx", 1, 3, "int");
}

function init_player_zombie_vars() {
  self.zombie_vars["zombie_powerup_insta_kill_ug_on"] = 0;
  self.zombie_vars["zombie_powerup_insta_kill_ug_time"] = 18;
}

function set_weapon_ignore_max_ammo(weapon) {
  if(!isDefined(level.zombie_weapons_no_max_ammo)) {
    level.zombie_weapons_no_max_ammo = [];
  }
  level.zombie_weapons_no_max_ammo[weapon] = 1;
}

function powerup_hud_monitor() {
  level flag::wait_till("start_zombie_round_logic");
  if(isDefined(level.current_game_module) && level.current_game_module == 2) {
    return;
  }
  flashing_timers = [];
  flashing_values = [];
  flashing_timer = 10;
  flashing_delta_time = 0;
  flashing_is_on = 0;
  flashing_value = 3;
  flashing_min_timer = 0.15;
  while(flashing_timer >= flashing_min_timer) {
    if(flashing_timer < 5) {
      flashing_delta_time = 0.1;
    } else {
      flashing_delta_time = 0.2;
    }
    if(flashing_is_on) {
      flashing_timer = (flashing_timer - flashing_delta_time) - 0.05;
      flashing_value = 2;
    } else {
      flashing_timer = flashing_timer - flashing_delta_time;
      flashing_value = 3;
    }
    flashing_timers[flashing_timers.size] = flashing_timer;
    flashing_values[flashing_values.size] = flashing_value;
    flashing_is_on = !flashing_is_on;
  }
  client_fields = [];
  powerup_keys = getarraykeys(level.zombie_powerups);
  for(powerup_key_index = 0; powerup_key_index < powerup_keys.size; powerup_key_index++) {
    if(isDefined(level.zombie_powerups[powerup_keys[powerup_key_index]].client_field_name)) {
      powerup_name = powerup_keys[powerup_key_index];
      client_fields[powerup_name] = spawnStruct();
      client_fields[powerup_name].client_field_name = level.zombie_powerups[powerup_name].client_field_name;
      client_fields[powerup_name].only_affects_grabber = level.zombie_powerups[powerup_name].only_affects_grabber;
      client_fields[powerup_name].time_name = level.zombie_powerups[powerup_name].time_name;
      client_fields[powerup_name].on_name = level.zombie_powerups[powerup_name].on_name;
    }
  }
  client_field_keys = getarraykeys(client_fields);
  while(true) {
    wait(0.05);
    waittillframeend();
    players = level.players;
    for(playerindex = 0; playerindex < players.size; playerindex++) {
      for(client_field_key_index = 0; client_field_key_index < client_field_keys.size; client_field_key_index++) {
        player = players[playerindex];
        if(isDefined(player.pers[""]) && player.pers[""]) {
          continue;
        }
        if(isDefined(level.powerup_player_valid)) {
          if(![
              [level.powerup_player_valid]
            ](player)) {
            continue;
          }
        }
        client_field_name = client_fields[client_field_keys[client_field_key_index]].client_field_name;
        time_name = client_fields[client_field_keys[client_field_key_index]].time_name;
        on_name = client_fields[client_field_keys[client_field_key_index]].on_name;
        powerup_timer = undefined;
        powerup_on = undefined;
        if(client_fields[client_field_keys[client_field_key_index]].only_affects_grabber) {
          if(isDefined(player._show_solo_hud) && player._show_solo_hud == 1) {
            powerup_timer = player.zombie_vars[time_name];
            powerup_on = player.zombie_vars[on_name];
          }
        } else {
          if(isDefined(level.zombie_vars[player.team][time_name])) {
            powerup_timer = level.zombie_vars[player.team][time_name];
            powerup_on = level.zombie_vars[player.team][on_name];
          } else if(isDefined(level.zombie_vars[time_name])) {
            powerup_timer = level.zombie_vars[time_name];
            powerup_on = level.zombie_vars[on_name];
          }
        }
        if(isDefined(powerup_timer) && isDefined(powerup_on)) {
          player set_clientfield_powerups(client_field_name, powerup_timer, powerup_on, flashing_timers, flashing_values);
          continue;
        }
        player clientfield::set_to_player(client_field_name, 0);
      }
    }
  }
}

function set_clientfield_powerups(clientfield_name, powerup_timer, powerup_on, flashing_timers, flashing_values) {
  if(powerup_on) {
    if(powerup_timer < 10) {
      flashing_value = 3;
      for(i = flashing_timers.size - 1; i > 0; i--) {
        if(powerup_timer < flashing_timers[i]) {
          flashing_value = flashing_values[i];
          break;
        }
      }
      self clientfield::set_to_player(clientfield_name, flashing_value);
    } else {
      self clientfield::set_to_player(clientfield_name, 1);
    }
  } else {
    self clientfield::set_to_player(clientfield_name, 0);
  }
}

function randomize_powerups() {
  if(!isDefined(level.zombie_powerup_array)) {
    level.zombie_powerup_array = [];
  } else {
    level.zombie_powerup_array = array::randomize(level.zombie_powerup_array);
  }
}

function get_next_powerup() {
  powerup = level.zombie_powerup_array[level.zombie_powerup_index];
  level.zombie_powerup_index++;
  if(level.zombie_powerup_index >= level.zombie_powerup_array.size) {
    level.zombie_powerup_index = 0;
    randomize_powerups();
  }
  return powerup;
}

function get_valid_powerup() {
  if(isDefined(level.zombie_devgui_power) && level.zombie_devgui_power == 1) {
    level.zombie_devgui_power = 0;
    return level.zombie_powerup_array[level.zombie_powerup_index];
  }
  if(isDefined(level.zombie_powerup_boss)) {
    i = level.zombie_powerup_boss;
    level.zombie_powerup_boss = undefined;
    return level.zombie_powerup_array[i];
  }
  if(isDefined(level.zombie_powerup_ape)) {
    powerup = level.zombie_powerup_ape;
    level.zombie_powerup_ape = undefined;
    return powerup;
  }
  powerup = get_next_powerup();
  while(true) {
    powerup = get_next_powerup();
  }
  if(![[level.zombie_powerups[powerup].func_should_drop_with_regular_powerups]]()) {}
  return powerup;
}

function minigun_no_drop() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i].zombie_vars["zombie_powerup_minigun_on"] == 1) {
      return true;
    }
  }
  if(!level flag::get("power_on")) {
    if(level flag::get("solo_game")) {
      if(!isDefined(level.solo_lives_given) || level.solo_lives_given == 0) {
        return true;
      }
    } else {
      return true;
    }
  }
  return false;
}

function watch_for_drop() {
  level endon("unloaded");
  level flag::wait_till("start_zombie_round_logic");
  level flag::wait_till("begin_spawning");
  wait(0.05);
  players = getplayers();
  score_to_drop = (players.size * (level.zombie_vars[("zombie_score_start_" + players.size) + "p"])) + level.zombie_vars["zombie_powerup_drop_increment"];
  while(true) {
    level flag::wait_till("zombie_drop_powerups");
    players = getplayers();
    curr_total_score = 0;
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].score_total)) {
        curr_total_score = curr_total_score + players[i].score_total;
      }
    }
    if(curr_total_score > score_to_drop) {
      level.zombie_vars["zombie_powerup_drop_increment"] = level.zombie_vars["zombie_powerup_drop_increment"] * 1.14;
      score_to_drop = curr_total_score + level.zombie_vars["zombie_powerup_drop_increment"];
      level.zombie_vars["zombie_drop_item"] = 1;
    }
    wait(0.5);
  }
}

function get_random_powerup_name() {
  powerup_keys = getarraykeys(level.zombie_powerups);
  powerup_keys = array::randomize(powerup_keys);
  return powerup_keys[0];
}

function get_regular_random_powerup_name() {
  powerup_keys = getarraykeys(level.zombie_powerups);
  powerup_keys = array::randomize(powerup_keys);
  for(i = 0; i < powerup_keys.size; i++) {
    if([
        [level.zombie_powerups[powerup_keys[i]].func_should_drop_with_regular_powerups]
      ]()) {
      return powerup_keys[i];
    }
  }
  return powerup_keys[0];
}

function add_zombie_powerup(powerup_name, model_name, hint, func_should_drop_with_regular_powerups, only_affects_grabber, any_team, zombie_grabbable, fx, client_field_name, time_name, on_name, clientfield_version = 1, player_specific = 0) {
  if(isDefined(level.zombie_include_powerups) && (!(isDefined(level.zombie_include_powerups[powerup_name]) && level.zombie_include_powerups[powerup_name]))) {
    return;
  }
  if(!isDefined(level.zombie_powerup_array)) {
    level.zombie_powerup_array = [];
  }
  struct = spawnStruct();
  if(!isDefined(level.zombie_powerups)) {
    level.zombie_powerups = [];
  }
  struct.powerup_name = powerup_name;
  struct.model_name = model_name;
  struct.weapon_classname = "script_model";
  struct.hint = hint;
  struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
  struct.only_affects_grabber = only_affects_grabber;
  struct.any_team = any_team;
  struct.zombie_grabbable = zombie_grabbable;
  struct.var_2c8ee667 = hashstring(powerup_name);
  struct.player_specific = player_specific;
  struct.can_pick_up_in_last_stand = 1;
  if(isDefined(fx)) {
    struct.fx = fx;
  }
  level.zombie_powerups[powerup_name] = struct;
  level.zombie_powerup_array[level.zombie_powerup_array.size] = powerup_name;
  add_zombie_special_drop(powerup_name);
  if(isDefined(client_field_name)) {
    clientfield::register("toplayer", client_field_name, clientfield_version, 2, "int");
    struct.client_field_name = client_field_name;
    struct.time_name = time_name;
    struct.on_name = on_name;
  }
}

function powerup_set_can_pick_up_in_last_stand(powerup_name, b_can_pick_up) {
  level.zombie_powerups[powerup_name].can_pick_up_in_last_stand = b_can_pick_up;
}

function powerup_set_prevent_pick_up_if_drinking(powerup_name, b_prevent_pick_up) {
  level._custom_powerups[powerup_name].prevent_pick_up_if_drinking = b_prevent_pick_up;
}

function powerup_set_player_specific(powerup_name, b_player_specific = 1) {
  level.zombie_powerups[powerup_name].player_specific = b_player_specific;
}

function powerup_set_statless_powerup(powerup_name) {
  if(!isDefined(level.zombie_statless_powerups)) {
    level.zombie_statless_powerups = [];
  }
  level.zombie_statless_powerups[powerup_name] = 1;
}

function add_zombie_special_drop(powerup_name) {
  if(!isDefined(level.zombie_special_drop_array)) {
    level.zombie_special_drop_array = [];
  }
  level.zombie_special_drop_array[level.zombie_special_drop_array.size] = powerup_name;
}

function include_zombie_powerup(powerup_name) {
  if(!isDefined(level.zombie_include_powerups)) {
    level.zombie_include_powerups = [];
  }
  level.zombie_include_powerups[powerup_name] = 1;
}

function powerup_remove_from_regular_drops(powerup_name) {
  assert(isDefined(level.zombie_powerups));
  assert(isDefined(level.zombie_powerups[powerup_name]));
  level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = &func_should_never_drop;
}

function powerup_round_start() {
  level.powerup_drop_count = 0;
}

function powerup_drop(drop_point) {
  if(isDefined(level.custom_zombie_powerup_drop)) {
    b_outcome = [[level.custom_zombie_powerup_drop]](drop_point);
    if(isDefined(b_outcome) && b_outcome) {
      return;
    }
  }
  if(level.powerup_drop_count >= level.zombie_vars["zombie_powerup_drop_max_per_round"]) {
    println("");
    return;
  }
  if(!isDefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0) {
    return;
  }
  rand_drop = randomint(100);
  if(bgb::is_team_enabled("zm_bgb_power_vacuum") && rand_drop < 20) {
    debug = "zm_bgb_power_vacuum";
  } else {
    if(rand_drop > 2) {
      if(!level.zombie_vars["zombie_drop_item"]) {
        return;
      }
      debug = "score";
    } else {
      debug = "random";
    }
  }
  playable_area = getEntArray("player_volume", "script_noteworthy");
  level.powerup_drop_count++;
  powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", drop_point + vectorscale((0, 0, 1), 40));
  valid_drop = 0;
  for(i = 0; i < playable_area.size; i++) {
    if(powerup istouching(playable_area[i])) {
      valid_drop = 1;
      break;
    }
  }
  if(valid_drop && level.rare_powerups_active) {
    pos = (drop_point[0], drop_point[1], drop_point[2] + 42);
    if(check_for_rare_drop_override(pos)) {
      level.zombie_vars["zombie_drop_item"] = 0;
      valid_drop = 0;
    }
  }
  if(!valid_drop) {
    level.powerup_drop_count--;
    powerup delete();
    return;
  }
  powerup powerup_setup();
  print_powerup_drop(powerup.powerup_name, debug);
  bb::logpowerupevent(powerup, undefined, "_dropped");
  powerup thread powerup_timeout();
  powerup thread powerup_wobble();
  powerup thread powerup_grab();
  powerup thread powerup_move();
  powerup thread powerup_emp();
  level.zombie_vars["zombie_drop_item"] = 0;
  level notify("powerup_dropped", powerup);
}

function specific_powerup_drop(powerup_name, drop_spot, powerup_team, powerup_location, pickup_delay, powerup_player, b_stay_forever) {
  powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", drop_spot + vectorscale((0, 0, 1), 40));
  level notify("powerup_dropped", powerup);
  if(isDefined(powerup)) {
    powerup powerup_setup(powerup_name, powerup_team, powerup_location, powerup_player);
    if(!(isDefined(b_stay_forever) && b_stay_forever)) {
      powerup thread powerup_timeout();
    }
    powerup thread powerup_wobble();
    if(isDefined(pickup_delay) && pickup_delay > 0) {
      powerup util::delay(pickup_delay, "powerup_timedout", &powerup_grab, powerup_team);
    } else {
      powerup thread powerup_grab(powerup_team);
    }
    powerup thread powerup_move();
    powerup thread powerup_emp();
    return powerup;
  }
}

function special_powerup_drop(drop_point) {
  if(!isDefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0) {
    return;
  }
  powerup = spawn("script_model", drop_point + vectorscale((0, 0, 1), 40));
  playable_area = getEntArray("player_volume", "script_noteworthy");
  valid_drop = 0;
  for(i = 0; i < playable_area.size; i++) {
    if(powerup istouching(playable_area[i])) {
      valid_drop = 1;
      break;
    }
  }
  if(!valid_drop) {
    powerup delete();
    return;
  }
  powerup special_drop_setup();
}

function powerup_setup(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound = 1) {
  powerup = undefined;
  if(!isDefined(powerup_override)) {
    powerup = get_valid_powerup();
  } else {
    powerup = powerup_override;
    if("tesla" == powerup && tesla_powerup_active()) {
      powerup = "minigun";
    }
  }
  struct = level.zombie_powerups[powerup];
  if(isDefined(level._custom_powerups) && isDefined(level._custom_powerups[powerup]) && isDefined(level._custom_powerups[powerup].setup_powerup)) {
    self[[level._custom_powerups[powerup].setup_powerup]]();
  } else {
    self setModel(struct.model_name);
  }
  demo::bookmark("zm_powerup_dropped", gettime(), undefined, undefined, 1);
  if(isDefined(shouldplaysound) && shouldplaysound) {
    playsoundatposition("zmb_spawn_powerup", self.origin);
  }
  if(isDefined(powerup_team)) {
    self.powerup_team = powerup_team;
  }
  if(isDefined(powerup_location)) {
    self.powerup_location = powerup_location;
  }
  if(isDefined(powerup_player)) {
    self.powerup_player = powerup_player;
  } else {
    assert(!(isDefined(struct.player_specific) && struct.player_specific), "");
  }
  self.powerup_name = struct.powerup_name;
  self.hint = struct.hint;
  self.only_affects_grabber = struct.only_affects_grabber;
  self.any_team = struct.any_team;
  self.zombie_grabbable = struct.zombie_grabbable;
  self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;
  if(isDefined(struct.fx)) {
    self.fx = struct.fx;
  }
  if(isDefined(struct.can_pick_up_in_last_stand)) {
    self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
  }
  self playLoopSound("zmb_spawn_powerup_loop");
  level.active_powerups[level.active_powerups.size] = self;
}

function special_drop_setup() {
  powerup = undefined;
  if(isDefined(level.powerup_special_drop_override)) {
    powerup = [[level.powerup_special_drop_override]]();
  } else {
    powerup = get_valid_powerup();
  }
  if(isDefined(powerup)) {
    playFX(level._effect["lightning_dog_spawn"], self.origin);
    playsoundatposition("zmb_hellhound_prespawn", self.origin);
    wait(1.5);
    playsoundatposition("zmb_hellhound_bolt", self.origin);
    earthquake(0.5, 0.75, self.origin, 1000);
    playsoundatposition("zmb_hellhound_spawn", self.origin);
    self powerup_setup(powerup);
    self thread powerup_timeout();
    self thread powerup_wobble();
    self thread powerup_grab();
    self thread powerup_move();
    self thread powerup_emp();
  }
}

function powerup_zombie_grab_trigger_cleanup(trigger) {
  self util::waittill_any("powerup_timedout", "powerup_grabbed", "hacked");
  trigger delete();
}

function powerup_zombie_grab(powerup_team) {
  self endon("powerup_timedout");
  self endon("powerup_grabbed");
  self endon("hacked");
  zombie_grab_trigger = spawn("trigger_radius", self.origin - vectorscale((0, 0, 1), 40), 9, 32, 72);
  zombie_grab_trigger enablelinkto();
  zombie_grab_trigger linkto(self);
  zombie_grab_trigger setteamfortrigger(level.zombie_team);
  self thread powerup_zombie_grab_trigger_cleanup(zombie_grab_trigger);
  poi_dist = 300;
  if(isDefined(level._zombie_grabbable_poi_distance_override)) {
    poi_dist = level._zombie_grabbable_poi_distance_override;
  }
  zombie_grab_trigger zm_utility::create_zombie_point_of_interest(poi_dist, 2, 0, 1, undefined, undefined, powerup_team);
  while(isDefined(self)) {
    zombie_grab_trigger waittill("trigger", who);
    if(isDefined(level._powerup_grab_check)) {
      if(!self[[level._powerup_grab_check]](who)) {
        continue;
      }
    } else if(!isDefined(who) || !isai(who)) {
      continue;
    }
    playFX(level._effect["powerup_grabbed_red"], self.origin);
    if(isDefined(level._custom_powerups) && isDefined(level._custom_powerups[self.powerup_name]) && isDefined(level._custom_powerups[self.powerup_name].grab_powerup)) {
      b_continue = self[[level._custom_powerups[self.powerup_name].grab_powerup]]();
      if(isDefined(b_continue) && b_continue) {
        continue;
      }
    } else {
      if(isDefined(level._zombiemode_powerup_zombie_grab)) {
        level thread[[level._zombiemode_powerup_zombie_grab]](self);
      }
      if(isDefined(level._game_mode_powerup_zombie_grab)) {
        level thread[[level._game_mode_powerup_zombie_grab]](self, who);
      } else {
        println("");
      }
    }
    level thread zm_audio::sndannouncerplayvox(self.powerup_name);
    wait(0.1);
    playsoundatposition("zmb_powerup_grabbed", self.origin);
    self stoploopsound();
    self thread powerup_delete_delayed();
    self notify("powerup_grabbed");
  }
}

function powerup_grab(powerup_team) {
  if(isDefined(self) && self.zombie_grabbable) {
    self thread powerup_zombie_grab(powerup_team);
    return;
  }
  self endon("powerup_timedout");
  self endon("powerup_grabbed");
  range_squared = 4096;
  while(isDefined(self)) {
    if(isDefined(self.powerup_player)) {
      grabbers = [];
      grabbers[0] = self.powerup_player;
    } else {
      if(isDefined(level.powerup_grab_get_players_override)) {
        grabbers = [
          [level.powerup_grab_get_players_override]
        ]();
      } else {
        grabbers = getplayers();
      }
    }
    for(i = 0; i < grabbers.size; i++) {
      grabber = grabbers[i];
      if(isalive(grabber.owner) && isplayer(grabber.owner)) {
        player = grabber.owner;
      } else if(isplayer(grabber)) {
        player = grabber;
      }
      if(self.only_affects_grabber && !isDefined(player)) {
        continue;
      }
      if(isDefined(player.is_drinking) && player.is_drinking > 0 && isDefined(level._custom_powerups) && isDefined(level._custom_powerups[self.powerup_name]) && (isDefined(level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking) && level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking)) {
        continue;
      }
      if(self.powerup_name == "minigun" || self.powerup_name == "tesla" || self.powerup_name == "random_weapon" || self.powerup_name == "meat_stink" && (!isplayer(grabber) || player laststand::player_is_in_laststand() || (player usebuttonpressed() && player zm_utility::in_revive_trigger()) || player bgb::is_enabled("zm_bgb_disorderly_combat"))) {
        continue;
      }
      if(!(isDefined(self.can_pick_up_in_last_stand) && self.can_pick_up_in_last_stand) && player laststand::player_is_in_laststand()) {
        continue;
      }
      ignore_range = 0;
      if(grabber.ignore_range_powerup === self) {
        grabber.ignore_range_powerup = undefined;
        ignore_range = 1;
      }
      if(distancesquared(grabber.origin, self.origin) < range_squared || ignore_range) {
        if(isDefined(level._powerup_grab_check)) {
          if(!self[[level._powerup_grab_check]](player)) {
            continue;
          }
        }
        if(isDefined(level._custom_powerups) && isDefined(level._custom_powerups[self.powerup_name]) && isDefined(level._custom_powerups[self.powerup_name].grab_powerup)) {
          b_continue = self[[level._custom_powerups[self.powerup_name].grab_powerup]](player);
          if(isDefined(b_continue) && b_continue) {
            continue;
          }
        } else {
          switch (self.powerup_name) {
            case "teller_withdrawl": {
              level thread teller_withdrawl(self, player);
              break;
            }
            default: {
              if(isDefined(level._zombiemode_powerup_grab)) {
                level thread[[level._zombiemode_powerup_grab]](self, player);
              } else {
                println("");
              }
              break;
            }
          }
        }
        demo::bookmark("zm_player_powerup_grabbed", gettime(), player);
        bb::logpowerupevent(self, player, "_grabbed");
        if(isDefined(self.var_2c8ee667)) {
          player recordmapevent(23, gettime(), grabber.origin, level.round_number, self.var_2c8ee667);
        }
        if(should_award_stat(self.powerup_name) && isplayer(player)) {
          player zm_stats::increment_client_stat("drops");
          player zm_stats::increment_player_stat("drops");
          player zm_stats::increment_client_stat(self.powerup_name + "_pickedup");
          player zm_stats::increment_player_stat(self.powerup_name + "_pickedup");
          player zm_stats::increment_challenge_stat("SURVIVALIST_POWERUP");
        }
        if(self.only_affects_grabber) {
          playFX(level._effect["powerup_grabbed_solo"], self.origin);
        } else {
          if(self.any_team) {
            playFX(level._effect["powerup_grabbed_caution"], self.origin);
          } else {
            playFX(level._effect["powerup_grabbed"], self.origin);
          }
        }
        if(isDefined(self.stolen) && self.stolen) {
          level notify("monkey_see_monkey_dont_achieved");
        }
        if(isDefined(self.grabbed_level_notify)) {
          level notify(self.grabbed_level_notify);
        }
        self.claimed = 1;
        self.power_up_grab_player = player;
        wait(0.1);
        playsoundatposition("zmb_powerup_grabbed", self.origin);
        self stoploopsound();
        self hide();
        if(self.powerup_name != "fire_sale") {
          if(isDefined(self.power_up_grab_player)) {
            if(isDefined(level.powerup_intro_vox)) {
              level thread[[level.powerup_intro_vox]](self);
              return;
            }
            if(isDefined(level.powerup_vo_available)) {
              can_say_vo = [
                [level.powerup_vo_available]
              ]();
              if(!can_say_vo) {
                self thread powerup_delete_delayed();
                self notify("powerup_grabbed");
                return;
              }
            }
          }
        }
        if(isDefined(self.only_affects_grabber) && self.only_affects_grabber) {
          level thread zm_audio::sndannouncerplayvox(self.powerup_name, player);
        } else {
          level thread zm_audio::sndannouncerplayvox(self.powerup_name);
        }
        self thread powerup_delete_delayed();
        self notify("powerup_grabbed");
      }
    }
    wait(0.1);
  }
}

function get_closest_window_repair(windows, origin) {
  current_window = undefined;
  shortest_distance = undefined;
  for(i = 0; i < windows.size; i++) {
    if(zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks)) {
      continue;
    }
    if(!isDefined(current_window)) {
      current_window = windows[i];
      shortest_distance = distancesquared(current_window.origin, origin);
      continue;
    }
    if(distancesquared(windows[i].origin, origin) < shortest_distance) {
      current_window = windows[i];
      shortest_distance = distancesquared(windows[i].origin, origin);
    }
  }
  return current_window;
}

function powerup_vo(type) {
  self endon("death");
  self endon("disconnect");
  if(!isplayer(self)) {
    return;
  }
  if(isDefined(level.powerup_vo_available)) {
    if(![
        [level.powerup_vo_available]
      ]()) {
      return;
    }
  }
  wait(randomfloatrange(2, 2.5));
  if(type == "tesla") {
    self zm_audio::create_and_play_dialog("weapon_pickup", type);
  } else {
    self zm_audio::create_and_play_dialog("powerup", type);
  }
  if(isDefined(level.custom_powerup_vo_response)) {
    level[[level.custom_powerup_vo_response]](self, type);
  }
}

function powerup_wobble_fx() {
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.powerup_fx_func)) {
    self thread[[level.powerup_fx_func]]();
    return;
  }
  if(self.only_affects_grabber) {
    self clientfield::set("powerup_fx", 2);
  } else {
    if(self.any_team) {
      self clientfield::set("powerup_fx", 4);
    } else {
      if(self.zombie_grabbable) {
        self clientfield::set("powerup_fx", 3);
      } else {
        self clientfield::set("powerup_fx", 1);
      }
    }
  }
}

function powerup_wobble() {
  self endon("powerup_grabbed");
  self endon("powerup_timedout");
  self thread powerup_wobble_fx();
  while(isDefined(self)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = randomint(360);
    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }
    yaw = self.angles[1] + yaw;
    new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
    self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    if(isDefined(self.worldgundw)) {
      self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    }
    wait(randomfloat(waittime - 0.1));
  }
}

function powerup_show(visible) {
  if(!visible) {
    self ghost();
    if(isDefined(self.worldgundw)) {
      self.worldgundw ghost();
    }
  } else {
    self show();
    if(isDefined(self.worldgundw)) {
      self.worldgundw show();
    }
    if(isDefined(self.powerup_player)) {
      self setinvisibletoall();
      self setvisibletoplayer(self.powerup_player);
      if(isDefined(self.worldgundw)) {
        self.worldgundw setinvisibletoall();
        self.worldgundw setvisibletoplayer(self.powerup_player);
      }
    }
  }
}

function powerup_timeout() {
  if(isDefined(level._powerup_timeout_override) && !isDefined(self.powerup_team)) {
    self thread[[level._powerup_timeout_override]]();
    return;
  }
  self endon("powerup_grabbed");
  self endon("death");
  self endon("powerup_reset");
  self powerup_show(1);
  wait_time = 15;
  if(isDefined(level._powerup_timeout_custom_time)) {
    time = [[level._powerup_timeout_custom_time]](self);
    if(time == 0) {
      return;
    }
    wait_time = time;
  }
  if(bgb::is_team_enabled("zm_bgb_temporal_gift")) {
    wait_time = wait_time + 30;
  }
  wait(wait_time);
  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self powerup_show(0);
    } else {
      self powerup_show(1);
    }
    if(i < 15) {
      wait(0.5);
      continue;
    }
    if(i < 25) {
      wait(0.25);
      continue;
    }
    wait(0.1);
  }
  self notify("powerup_timedout");
  bb::logpowerupevent(self, undefined, "_timedout");
  self powerup_delete();
}

function powerup_delete() {
  arrayremovevalue(level.active_powerups, self, 0);
  if(isDefined(self.worldgundw)) {
    self.worldgundw delete();
  }
  self delete();
}

function powerup_delete_delayed(time) {
  if(isDefined(time)) {
    wait(time);
  } else {
    wait(0.01);
  }
  self powerup_delete();
}

function is_insta_kill_active() {
  return level.zombie_vars[self.team]["zombie_insta_kill"];
}

function check_for_instakill(player, mod, hit_location) {
  if(isDefined(player) && isalive(player) && isDefined(level.check_for_instakill_override)) {
    if(!self[[level.check_for_instakill_override]](player)) {
      return;
    }
    if(player.use_weapon_type == "MOD_MELEE") {
      player.last_kill_method = "MOD_MELEE";
    } else {
      player.last_kill_method = "MOD_UNKNOWN";
    }
    modname = zm_utility::remove_mod_from_methodofdeath(mod);
    if(!(isDefined(self.no_gib) && self.no_gib)) {
      self zombie_utility::zombie_head_gib();
    }
    self.health = 1;
    self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
    player notify("zombie_killed");
  }
  if(isDefined(player) && isalive(player) && (level.zombie_vars[player.team]["zombie_insta_kill"] || (isDefined(player.personal_instakill) && player.personal_instakill))) {
    if(zm_utility::is_magic_bullet_shield_enabled(self)) {
      return;
    }
    if(isDefined(self.instakill_func)) {
      b_result = self thread[[self.instakill_func]](player, mod, hit_location);
      if(isDefined(b_result) && b_result) {
        return;
      }
    }
    if(player.use_weapon_type == "MOD_MELEE") {
      player.last_kill_method = "MOD_MELEE";
    } else {
      player.last_kill_method = "MOD_UNKNOWN";
    }
    modname = zm_utility::remove_mod_from_methodofdeath(mod);
    if(!level flag::get("special_round") && (!(isDefined(self.no_gib) && self.no_gib))) {
      self zombie_utility::zombie_head_gib();
    }
    self.health = 1;
    self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
    player notify("zombie_killed");
  }
}

function point_doubler_on_hud(drop_item, player_team) {
  self endon("disconnect");
  if(level.zombie_vars[player_team]["zombie_powerup_double_points_on"]) {
    level.zombie_vars[player_team]["zombie_powerup_double_points_time"] = 30;
    return;
  }
  level.zombie_vars[player_team]["zombie_powerup_double_points_on"] = 1;
  level thread time_remaining_on_point_doubler_powerup(player_team);
}

function time_remaining_on_point_doubler_powerup(player_team) {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playLoopSound("zmb_double_point_loop");
  while(level.zombie_vars[player_team]["zombie_powerup_double_points_time"] >= 0) {
    wait(0.05);
    level.zombie_vars[player_team]["zombie_powerup_double_points_time"] = level.zombie_vars[player_team]["zombie_powerup_double_points_time"] - 0.05;
  }
  level.zombie_vars[player_team]["zombie_powerup_double_points_on"] = 0;
  players = getplayers(player_team);
  for(i = 0; i < players.size; i++) {
    players[i] playSound("zmb_points_loop_off");
  }
  temp_ent stoploopsound(2);
  level.zombie_vars[player_team]["zombie_powerup_double_points_time"] = 30;
  temp_ent delete();
}

function devil_dialog_delay() {
  wait(1);
}

function check_for_rare_drop_override(pos) {
  if(level flagsys::get("ape_round")) {
    return false;
  }
  return false;
}

function tesla_powerup_active() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i].zombie_vars["zombie_powerup_tesla_on"]) {
      return true;
    }
  }
  return false;
}

function print_powerup_drop(powerup, type) {
  if(!isDefined(level.powerup_drop_time)) {
    level.powerup_drop_time = 0;
    level.powerup_random_count = 0;
    level.powerup_score_count = 0;
  }
  time = (gettime() - level.powerup_drop_time) * 0.001;
  level.powerup_drop_time = gettime();
  if(type == "") {
    level.powerup_random_count++;
  } else {
    level.powerup_score_count++;
  }
  println("");
  println("" + powerup);
  println("" + type);
  println("");
  println("" + time);
  println("" + level.powerup_random_count);
  println("" + level.powerup_score_count);
  println("");
}

function register_carpenter_node(node, callback) {
  if(!isDefined(level._additional_carpenter_nodes)) {
    level._additional_carpenter_nodes = [];
  }
  node._post_carpenter_callback = callback;
  level._additional_carpenter_nodes[level._additional_carpenter_nodes.size] = node;
}

function is_carpenter_boards_upgraded() {
  if(isDefined(level.pers_carpenter_boards_active) && level.pers_carpenter_boards_active == 1) {
    return true;
  }
  return false;
}

function func_should_never_drop() {
  return false;
}

function func_should_always_drop() {
  return true;
}

function powerup_move() {
  self endon("powerup_timedout");
  self endon("powerup_grabbed");
  drag_speed = 75;
  while(true) {
    self waittill("move_powerup", moveto, distance);
    drag_vector = moveto - self.origin;
    range_squared = lengthsquared(drag_vector);
    if(range_squared > (distance * distance)) {
      drag_vector = vectornormalize(drag_vector);
      drag_vector = distance * drag_vector;
      moveto = self.origin + drag_vector;
    }
    self.origin = moveto;
  }
}

function powerup_emp() {
  self endon("powerup_timedout");
  self endon("powerup_grabbed");
  if(!zm_utility::should_watch_for_emp()) {
    return;
  }
  while(true) {
    level waittill("emp_detonate", origin, radius);
    if(distancesquared(origin, self.origin) < (radius * radius)) {
      playFX(level._effect["powerup_off"], self.origin);
      self thread powerup_delete_delayed();
      self notify("powerup_timedout");
    }
  }
}

function get_powerups(origin, radius) {
  if(isDefined(origin) && isDefined(radius)) {
    powerups = [];
    foreach(powerup in level.active_powerups) {
      if(distancesquared(origin, powerup.origin) < (radius * radius)) {
        powerups[powerups.size] = powerup;
      }
    }
    return powerups;
  }
  return level.active_powerups;
}

function should_award_stat(powerup_name) {
  if(powerup_name == "teller_withdrawl" || powerup_name == "blue_monkey" || powerup_name == "free_perk" || powerup_name == "bonus_points_player") {
    return false;
  }
  if(isDefined(level.zombie_statless_powerups) && isDefined(level.zombie_statless_powerups[powerup_name]) && level.zombie_statless_powerups[powerup_name]) {
    return false;
  }
  return true;
}

function teller_withdrawl(powerup, player) {
  player zm_score::add_to_player_score(powerup.value);
}

function show_on_hud(player_team, str_powerup) {
  self endon("disconnect");
  str_index_on = ("zombie_powerup_" + str_powerup) + "_on";
  str_index_time = ("zombie_powerup_" + str_powerup) + "_time";
  if(level.zombie_vars[player_team][str_index_on]) {
    level.zombie_vars[player_team][str_index_time] = 30;
    if(bgb::is_team_enabled("zm_bgb_temporal_gift")) {
      level.zombie_vars[player_team][str_index_time] = level.zombie_vars[player_team][str_index_time] + 30;
    }
    return;
  }
  level.zombie_vars[player_team][str_index_on] = 1;
  level thread time_remaining_on_powerup(player_team, str_powerup);
}

function time_remaining_on_powerup(player_team, str_powerup) {
  str_index_on = ("zombie_powerup_" + str_powerup) + "_on";
  str_index_time = ("zombie_powerup_" + str_powerup) + "_time";
  str_sound_loop = ("zmb_" + str_powerup) + "_loop";
  str_sound_off = ("zmb_" + str_powerup) + "_loop_off";
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playLoopSound(str_sound_loop);
  if(bgb::is_team_enabled("zm_bgb_temporal_gift")) {
    level.zombie_vars[player_team][str_index_time] = level.zombie_vars[player_team][str_index_time] + 30;
  }
  while(level.zombie_vars[player_team][str_index_time] >= 0) {
    wait(0.05);
    level.zombie_vars[player_team][str_index_time] = level.zombie_vars[player_team][str_index_time] - 0.05;
  }
  level.zombie_vars[player_team][str_index_on] = 0;
  getplayers()[0] playsoundtoteam(str_sound_off, player_team);
  temp_ent stoploopsound(2);
  level.zombie_vars[player_team][str_index_time] = 30;
  temp_ent delete();
}

function weapon_powerup(ent_player, time, str_weapon, allow_cycling = 0) {
  str_weapon_on = ("zombie_powerup_" + str_weapon) + "_on";
  str_weapon_time_over = str_weapon + "_time_over";
  ent_player notify("replace_weapon_powerup");
  ent_player._show_solo_hud = 1;
  ent_player.has_specific_powerup_weapon[str_weapon] = 1;
  ent_player.has_powerup_weapon = 1;
  ent_player zm_utility::increment_is_drinking();
  if(allow_cycling) {
    ent_player enableweaponcycling();
  }
  ent_player._zombie_weapon_before_powerup[str_weapon] = ent_player getcurrentweapon();
  ent_player giveweapon(level.zombie_powerup_weapon[str_weapon]);
  ent_player switchtoweapon(level.zombie_powerup_weapon[str_weapon]);
  ent_player.zombie_vars[str_weapon_on] = 1;
  level thread weapon_powerup_countdown(ent_player, str_weapon_time_over, time, str_weapon);
  level thread weapon_powerup_replace(ent_player, str_weapon_time_over, str_weapon);
  level thread weapon_powerup_change(ent_player, str_weapon_time_over, str_weapon);
}

function weapon_powerup_change(ent_player, str_gun_return_notify, str_weapon) {
  ent_player endon("death");
  ent_player endon("disconnect");
  ent_player endon("player_downed");
  ent_player endon(str_gun_return_notify);
  ent_player endon("replace_weapon_powerup");
  while(true) {
    ent_player waittill("weapon_change", newweapon, oldweapon);
    if(newweapon != level.weaponnone && newweapon != level.zombie_powerup_weapon[str_weapon]) {
      break;
    }
  }
  level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 0);
}

function weapon_powerup_countdown(ent_player, str_gun_return_notify, time, str_weapon) {
  ent_player endon("death");
  ent_player endon("disconnect");
  ent_player endon("player_downed");
  ent_player endon(str_gun_return_notify);
  ent_player endon("replace_weapon_powerup");
  str_weapon_time = ("zombie_powerup_" + str_weapon) + "_time";
  ent_player.zombie_vars[str_weapon_time] = time;
  if(bgb::is_team_enabled("zm_bgb_temporal_gift")) {
    ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] + 30;
  }
  [[level._custom_powerups[str_weapon].weapon_countdown]](ent_player, str_weapon_time);
  level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 1);
}

function weapon_powerup_replace(ent_player, str_gun_return_notify, str_weapon) {
  ent_player endon("death");
  ent_player endon("disconnect");
  ent_player endon("player_downed");
  ent_player endon(str_gun_return_notify);
  str_weapon_on = ("zombie_powerup_" + str_weapon) + "_on";
  ent_player waittill("replace_weapon_powerup");
  ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
  ent_player.zombie_vars[str_weapon_on] = 0;
  ent_player.has_specific_powerup_weapon[str_weapon] = 0;
  ent_player.has_powerup_weapon = 0;
  ent_player zm_utility::decrement_is_drinking();
}

function weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, b_switch_back_weapon = 1) {
  ent_player endon("death");
  ent_player endon("player_downed");
  str_weapon_on = ("zombie_powerup_" + str_weapon) + "_on";
  ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
  ent_player.zombie_vars[str_weapon_on] = 0;
  ent_player._show_solo_hud = 0;
  ent_player.has_specific_powerup_weapon[str_weapon] = 0;
  ent_player.has_powerup_weapon = 0;
  ent_player notify(str_gun_return_notify);
  ent_player zm_utility::decrement_is_drinking();
  if(b_switch_back_weapon) {
    ent_player zm_weapons::switch_back_primary_weapon(ent_player._zombie_weapon_before_powerup[str_weapon]);
  }
}

function weapon_watch_gunner_downed(str_weapon) {
  str_notify = str_weapon + "_time_over";
  str_weapon_on = ("zombie_powerup_" + str_weapon) + "_on";
  if(!isDefined(self.has_specific_powerup_weapon) || (!(isDefined(self.has_specific_powerup_weapon[str_weapon]) && self.has_specific_powerup_weapon[str_weapon]))) {
    return;
  }
  primaryweapons = self getweaponslistprimaries();
  for(i = 0; i < primaryweapons.size; i++) {
    if(primaryweapons[i] == level.zombie_powerup_weapon[str_weapon]) {
      self takeweapon(level.zombie_powerup_weapon[str_weapon]);
    }
  }
  self notify(str_notify);
  self.zombie_vars[str_weapon_on] = 0;
  self._show_solo_hud = 0;
  wait(0.05);
  self.has_specific_powerup_weapon[str_weapon] = 0;
  self.has_powerup_weapon = 0;
}

function register_powerup(str_powerup, func_grab_powerup, func_setup) {
  assert(isDefined(str_powerup), "");
  _register_undefined_powerup(str_powerup);
  if(isDefined(func_grab_powerup)) {
    if(!isDefined(level._custom_powerups[str_powerup].grab_powerup)) {
      level._custom_powerups[str_powerup].grab_powerup = func_grab_powerup;
    }
  }
  if(isDefined(func_setup)) {
    if(!isDefined(level._custom_powerups[str_powerup].setup_powerup)) {
      level._custom_powerups[str_powerup].setup_powerup = func_setup;
    }
  }
}

function _register_undefined_powerup(str_powerup) {
  if(!isDefined(level._custom_powerups)) {
    level._custom_powerups = [];
  }
  if(!isDefined(level._custom_powerups[str_powerup])) {
    level._custom_powerups[str_powerup] = spawnStruct();
    include_zombie_powerup(str_powerup);
  }
}

function register_powerup_weapon(str_powerup, func_countdown) {
  assert(isDefined(str_powerup), "");
  _register_undefined_powerup(str_powerup);
  if(isDefined(func_countdown)) {
    if(!isDefined(level._custom_powerups[str_powerup].weapon_countdown)) {
      level._custom_powerups[str_powerup].weapon_countdown = func_countdown;
    }
  }
}