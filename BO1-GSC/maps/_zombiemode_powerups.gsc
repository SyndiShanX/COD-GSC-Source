/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_powerups.gsc
*****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  PrecacheShader("specialty_doublepoints_zombies");
  PrecacheShader("specialty_instakill_zombies");
  PrecacheShader("specialty_firesale_zombies");
  PrecacheShader("zom_icon_bonfire");
  PrecacheShader("zom_icon_minigun");
  PrecacheShader("black");
  set_zombie_var("zombie_insta_kill", 0);
  set_zombie_var("zombie_point_scalar", 1);
  set_zombie_var("zombie_drop_item", 0);
  set_zombie_var("zombie_timer_offset", 350);
  set_zombie_var("zombie_timer_offset_interval", 30);
  set_zombie_var("zombie_powerup_fire_sale_on", false);
  set_zombie_var("zombie_powerup_fire_sale_time", 30);
  set_zombie_var("zombie_powerup_bonfire_sale_on", false);
  set_zombie_var("zombie_powerup_bonfire_sale_time", 30);
  set_zombie_var("zombie_powerup_insta_kill_on", false);
  set_zombie_var("zombie_powerup_insta_kill_time", 30);
  set_zombie_var("zombie_powerup_point_doubler_on", false);
  set_zombie_var("zombie_powerup_point_doubler_time", 30);
  set_zombie_var("zombie_powerup_drop_increment", 2000);
  set_zombie_var("zombie_powerup_drop_max_per_round", 4);
  set_zombie_var("zombie_powerup_minigun_on", false);
  set_zombie_var("zombie_powerup_minigun_time", 30);
  level._effect["powerup_on"] = loadfx("misc/fx_zombie_powerup_on");
  level._effect["powerup_grabbed"] = loadfx("misc/fx_zombie_powerup_grab");
  level._effect["powerup_grabbed_wave"] = loadfx("misc/fx_zombie_powerup_wave");
  level._effect["powerup_on_red"] = loadfx("misc/fx_zombie_powerup_on_red");
  level._effect["powerup_on_solo"] = LoadFX("misc/fx_zombie_powerup_solo_on");
  level._effect["powerup_grabbed_solo"] = LoadFX("misc/fx_zombie_powerup_solo_grab");
  if(level.mutators["mutator_noPowerups"]) {
    return;
  }
  init_powerups();
  thread watch_for_drop();
  thread setup_firesale_audio();
  thread setup_bonfiresale_audio();
}

init_powerups() {
  flag_init("zombie_drop_powerups");
  flag_set("zombie_drop_powerups");
  if(!isDefined(level.zombie_powerup_array)) {
    level.zombie_powerup_array = [];
  }
  if(!isDefined(level.zombie_special_drop_array)) {
    level.zombie_special_drop_array = [];
  }
  add_zombie_powerup("nuke", "zombie_bomb", & "ZOMBIE_POWERUP_NUKE", "misc/fx_zombie_mini_nuke");
  add_zombie_powerup("insta_kill", "zombie_skull", & "ZOMBIE_POWERUP_INSTA_KILL");
  add_zombie_powerup("double_points", "zombie_x2_icon", & "ZOMBIE_POWERUP_DOUBLE_POINTS");
  add_zombie_powerup("full_ammo", "zombie_ammocan", & "ZOMBIE_POWERUP_MAX_AMMO");
  if(!level.mutators["mutator_noBoards"]) {
    add_zombie_powerup("carpenter", "zombie_carpenter", & "ZOMBIE_POWERUP_MAX_AMMO");
  }
  if(!level.mutators["mutator_noMagicBox"]) {
    add_zombie_powerup("fire_sale", "zombie_firesale", & "ZOMBIE_POWERUP_MAX_AMMO");
  }
  add_zombie_powerup("bonfire_sale", "zombie_pickup_bonfire", & "ZOMBIE_POWERUP_MAX_AMMO");
  add_zombie_powerup("all_revive", "zombie_revive", & "ZOMBIE_POWERUP_MAX_AMMO");
  add_zombie_special_drop("dog");
  add_zombie_powerup("minigun", "zombie_pickup_minigun", & "ZOMBIE_POWERUP_MINIGUN", level._effect["minigun_pickup"]);
  randomize_powerups();
  level.zombie_powerup_index = 0;
  randomize_powerups();
  level.rare_powerups_active = 0;
  level.firesale_vox_firstime = false;
  level thread powerup_hud_overlay();
  level thread solo_powerup_hud_overlay();
}

powerup_hud_overlay() {
  level endon("disconnect");
  level.powerup_hud_array = [];
  level.powerup_hud_array[0] = true;
  level.powerup_hud_array[1] = true;
  level.powerup_hud_array[2] = true;
  level.powerup_hud_array[3] = true;
  level.powerup_hud = [];
  level.powerup_hud_cover = [];
  for(i = 0; i < 4; i++) {
    level.powerup_hud[i] = create_simple_hud();
    level.powerup_hud[i].foreground = true;
    level.powerup_hud[i].sort = 2;
    level.powerup_hud[i].hidewheninmenu = false;
    level.powerup_hud[i].alignX = "center";
    level.powerup_hud[i].alignY = "bottom";
    level.powerup_hud[i].horzAlign = "user_center";
    level.powerup_hud[i].vertAlign = "user_bottom";
    level.powerup_hud[i].x = -32 + (i * 15);
    level.powerup_hud[i].y = level.powerup_hud[i].y - 5;
    level.powerup_hud[i].alpha = 0.8;
  }
  level thread Power_up_hud("specialty_doublepoints_zombies", level.powerup_hud[0], -44, "zombie_powerup_point_doubler_time", "zombie_powerup_point_doubler_on");
  level thread Power_up_hud("specialty_instakill_zombies", level.powerup_hud[1], -04, "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
  level thread Power_up_hud("specialty_firesale_zombies", level.powerup_hud[2], 36, "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
  level thread Power_up_hud("zom_icon_bonfire", level.powerup_hud[3], 116, "zombie_powerup_bonfire_sale_time", "zombie_powerup_bonfire_sale_on");
}

Power_up_hud(Shader, PowerUp_Hud, X_Position, PowerUp_timer, PowerUp_Var) {
  while(true) {
    if(level.zombie_vars[PowerUp_timer] < 5) {
      wait(0.1);
      PowerUp_Hud.alpha = 0;
      wait(0.1);
    } else if(level.zombie_vars[PowerUp_timer] < 10) {
      wait(0.2);
      PowerUp_Hud.alpha = 0;
      wait(0.18);
    }
    if(level.zombie_vars[PowerUp_Var] == true) {
      PowerUp_Hud.x = X_Position;
      PowerUp_Hud.alpha = 1;
      PowerUp_Hud setshader(Shader, 32, 32);
    } else {
      PowerUp_Hud.alpha = 0;
    }
    wait(0.05);
  }
}

solo_powerup_hud_overlay() {
  level endon("disconnect");
  flag_wait("all_players_connected");
  players = get_players();
  for(p = 0; p < players.size; p++) {
    players[p].solo_powerup_hud_array = [];
    players[p].solo_powerup_hud_array[players[p].solo_powerup_hud_array.size] = true;
    players[p].solo_powerup_hud = [];
    players[p].solo_powerup_hud_cover = [];
    for(i = 0; i < players[p].solo_powerup_hud_array.size; i++) {
      players[p].solo_powerup_hud[i] = create_simple_hud(players[p]);
      players[p].solo_powerup_hud[i].foreground = true;
      players[p].solo_powerup_hud[i].sort = 2;
      players[p].solo_powerup_hud[i].hidewheninmenu = false;
      players[p].solo_powerup_hud[i].alignX = "center";
      players[p].solo_powerup_hud[i].alignY = "bottom";
      players[p].solo_powerup_hud[i].horzAlign = "user_center";
      players[p].solo_powerup_hud[i].vertAlign = "user_bottom";
      players[p].solo_powerup_hud[i].x = -32 + (i * 15);
      players[p].solo_powerup_hud[i].y = players[p].solo_powerup_hud[i].y - 5;
      players[p].solo_powerup_hud[i].alpha = 0.8;
    }
    players[p] thread solo_power_up_hud("zom_icon_minigun", players[p].solo_powerup_hud[0], 76, "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
  }
}

solo_power_up_hud(Shader, PowerUp_Hud, X_Position, PowerUp_timer, PowerUp_Var) {
  self endon("disconnect");
  while(true) {
    if(level.zombie_vars[PowerUp_timer] < 5 &&
      (isDefined(self._show_solo_hud) && self._show_solo_hud == true)) {
      wait(0.1);
      PowerUp_Hud.alpha = 0;
      wait(0.1);
    } else if(level.zombie_vars[PowerUp_timer] < 10 &&
      (isDefined(self._show_solo_hud) && self._show_solo_hud == true)) {
      wait(0.2);
      PowerUp_Hud.alpha = 0;
      wait(0.18);
    }
    if(level.zombie_vars[PowerUp_Var] == true &&
      (isDefined(self._show_solo_hud) && self._show_solo_hud == true)) {
      PowerUp_Hud.x = X_Position;
      PowerUp_Hud.alpha = 1;
      PowerUp_Hud setshader(Shader, 32, 32);
    } else {
      PowerUp_Hud.alpha = 0;
    }
    wait(0.05);
  }
}

randomize_powerups() {
  level.zombie_powerup_array = array_randomize(level.zombie_powerup_array);
}

get_next_powerup() {
  powerup = level.zombie_powerup_array[level.zombie_powerup_index];
  level.zombie_powerup_index++;
  if(level.zombie_powerup_index >= level.zombie_powerup_array.size) {
    level.zombie_powerup_index = 0;
    randomize_powerups();
  }
  return powerup;
}

get_valid_powerup() {
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
  while(1) {
    if(powerup == "carpenter" && get_num_window_destroyed() < 5) {
      powerup = get_next_powerup();
    } else if(powerup == "fire_sale" &&
      (level.zombie_vars["zombie_powerup_fire_sale_on"] == true ||
        level.chest_moves < 1)) {
      powerup = get_next_powerup();
    } else if(powerup == "all_revive") {
      if(!maps\_laststand::player_num_in_laststand()) {
        powerup = get_next_powerup();
      }
    } else if(powerup == "bonfire_sale") {
      powerup = get_next_powerup();
    } else if(powerup == "minigun" && mingun_no_drop()) {
      powerup = get_next_powerup();
    } else {
      return (powerup);
    }
  }
}

mingun_no_drop() {
  if(level.zombie_vars["zombie_powerup_minigun_on"] == true) {
    return true;
  }
  if(!flag("power_on")) {
    if(flag("solo_game")) {
      if(!flag("solo_revive")) {
        return true;
      }
    } else {
      return true;
    }
  }
  return false;
}

get_num_window_destroyed() {
  num = 0;
  for(i = 0; i < level.exterior_goals.size; i++) {
    if(all_chunks_destroyed(level.exterior_goals[i].barrier_chunks)) {
      num += 1;
    }
  }
  return num;
}

watch_for_drop() {
  flag_wait("begin_spawning");
  players = get_players();
  score_to_drop = (players.size * level.zombie_vars["zombie_score_start_" + players.size + "p"]) + level.zombie_vars["zombie_powerup_drop_increment"];
  while(1) {
    flag_wait("zombie_drop_powerups");
    players = get_players();
    curr_total_score = 0;
    for(i = 0; i < players.size; i++) {
      curr_total_score += players[i].score_total;
    }
    if(curr_total_score > score_to_drop) {
      level.zombie_vars["zombie_powerup_drop_increment"] *= 1.14;
      score_to_drop = curr_total_score + level.zombie_vars["zombie_powerup_drop_increment"];
      level.zombie_vars["zombie_drop_item"] = 1;
    }
    wait(0.5);
  }
}

add_zombie_powerup(powerup_name, model_name, hint, fx) {
  if(isDefined(level.zombie_include_powerups) && !isDefined(level.zombie_include_powerups[powerup_name])) {
    return;
  }
  PrecacheModel(model_name);
  PrecacheString(hint);
  struct = SpawnStruct();
  if(!isDefined(level.zombie_powerups)) {
    level.zombie_powerups = [];
  }
  struct.powerup_name = powerup_name;
  struct.model_name = model_name;
  struct.weapon_classname = "script_model";
  struct.hint = hint;
  if(isDefined(fx)) {
    struct.fx = LoadFx(fx);
  }
  level.zombie_powerups[powerup_name] = struct;
  level.zombie_powerup_array[level.zombie_powerup_array.size] = powerup_name;
  add_zombie_special_drop(powerup_name);
}

add_zombie_special_drop(powerup_name) {
  level.zombie_special_drop_array[level.zombie_special_drop_array.size] = powerup_name;
}

include_zombie_powerup(powerup_name) {
  if("1" == getDvar(#"mutator_noPowerups")) {
    return;
  }
  if(!isDefined(level.zombie_include_powerups)) {
    level.zombie_include_powerups = [];
  }
  level.zombie_include_powerups[powerup_name] = true;
}

powerup_round_start() {
  level.powerup_drop_count = 0;
}

powerup_drop(drop_point) {
  if(level.mutators["mutator_noPowerups"]) {
    return;
  }
  if(level.powerup_drop_count >= level.zombie_vars["zombie_powerup_drop_max_per_round"]) {
    return;
  }
  if(!isDefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0) {
    return;
  }
  rand_drop = randomInt(100);
  if(rand_drop > 2) {
    if(!level.zombie_vars["zombie_drop_item"]) {
      return;
    }
    debug = "score";
  } else {
    debug = "random";
  }
  playable_area = getentarray("player_volume", "script_noteworthy");
  level.powerup_drop_count++;
  powerup = maps\_zombiemode_net::network_safe_spawn("powerup", 1, "script_model", drop_point + (0, 0, 40));
  valid_drop = false;
  for(i = 0; i < playable_area.size; i++) {
    if(powerup istouching(playable_area[i])) {
      valid_drop = true;
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
  powerup thread powerup_timeout();
  powerup thread powerup_wobble();
  powerup thread powerup_grab();
  level.zombie_vars["zombie_drop_item"] = 0;
}

specific_powerup_drop(powerup_name, drop_spot) {
  powerup = maps\_zombiemode_net::network_safe_spawn("powerup", 1, "script_model", drop_spot + (0, 0, 40));
  if(isDefined(powerup)) {
    struct = level.zombie_powerups[powerup_name];
    powerup setModel(struct.model_name);
    playsoundatposition("zmb_spawn_powerup", powerup.origin);
    powerup.powerup_name = struct.powerup_name;
    powerup.hint = struct.hint;
    if(isDefined(struct.fx)) {
      powerup.fx = struct.fx;
    }
    powerup playLoopSound("zmb_spawn_powerup_loop");
    powerup thread powerup_timeout();
    powerup thread powerup_wobble();
    powerup thread powerup_grab();
  }
}

special_powerup_drop(drop_point) {
  if(!isDefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0) {
    return;
  }
  powerup = spawn("script_model", drop_point + (0, 0, 40));
  playable_area = getentarray("player_volume", "script_noteworthy");
  valid_drop = false;
  for(i = 0; i < playable_area.size; i++) {
    if(powerup istouching(playable_area[i])) {
      valid_drop = true;
      break;
    }
  }
  if(!valid_drop) {
    powerup Delete();
    return;
  }
  powerup special_drop_setup();
}

powerup_setup() {
  powerup = get_valid_powerup();
  struct = level.zombie_powerups[powerup];
  self setModel(struct.model_name);
  playsoundatposition("zmb_spawn_powerup", self.origin);
  self.powerup_name = struct.powerup_name;
  self.hint = struct.hint;
  if(isDefined(struct.fx)) {
    self.fx = struct.fx;
  }
  self playLoopSound("zmb_spawn_powerup_loop");
}

special_drop_setup() {
  powerup = undefined;
  is_powerup = true;
  if(level.round_number <= 10 || maps\_laststand::player_num_in_laststand()) {
    powerup = get_valid_powerup();
  } else {
    powerup = level.zombie_special_drop_array[randomInt(level.zombie_special_drop_array.size)];
    if(level.round_number > 15 &&
      (randomInt(100) < (level.round_number - 15) * 5)) {
      powerup = "nothing";
    }
  }
  switch (powerup) {
    case "nuke":
    case "insta_kill":
    case "double_points":
    case "carpenter":
    case "fire_sale":
    case "bonfire_sale":
    case "all_revive":
    case "minigun":
      break;
    case "full_ammo":
      if(level.round_number > 10 &&
        (randomInt(100) < (level.round_number - 10) * 5)) {
        powerup = level.zombie_powerup_array[randomInt(level.zombie_powerup_array.size)];
      }
      break;
    case "dog":
      if(level.round_number >= 15) {
        is_powerup = false;
        dog_spawners = getEntArray("special_dog_spawner", "targetname");
        thread play_sound_2d("sam_nospawn");
      } else {
        powerup = get_valid_powerup();
      }
      break;
    default:
      is_powerup = false;
      Playfx(level._effect["lightning_dog_spawn"], self.origin);
      playsoundatposition("pre_spawn", self.origin);
      wait(1.5);
      playsoundatposition("zmb_bolt", self.origin);
      Earthquake(0.5, 0.75, self.origin, 1000);
      PlayRumbleOnPosition("explosion_generic", self.origin);
      playsoundatposition("spawn", self.origin);
      wait(1.0);
      thread play_sound_2d("sam_nospawn");
      self Delete();
  }
  if(is_powerup) {
    Playfx(level._effect["lightning_dog_spawn"], self.origin);
    playsoundatposition("pre_spawn", self.origin);
    wait(1.5);
    playsoundatposition("zmb_bolt", self.origin);
    Earthquake(0.5, 0.75, self.origin, 1000);
    PlayRumbleOnPosition("explosion_generic", self.origin);
    playsoundatposition("spawn", self.origin);
    struct = level.zombie_powerups[powerup];
    self setModel(struct.model_name);
    playsoundatposition("zmb_spawn_powerup", self.origin);
    self.powerup_name = struct.powerup_name;
    self.hint = struct.hint;
    if(isDefined(struct.fx)) {
      self.fx = struct.fx;
    }
    self playLoopSound("zmb_spawn_powerup_loop");
    self thread powerup_timeout();
    self thread powerup_wobble();
    self thread powerup_grab();
  }
}

powerup_grab() {
  self endon("powerup_timedout");
  self endon("powerup_grabbed");
  while(isDefined(self)) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] maps\_laststand::player_is_in_laststand() && self.powerup_name == "minigun") {
        continue;
      }
      if(distance(players[i].origin, self.origin) < 64) {
        if(isDefined(self.powerup_name) && self.powerup_name == "minigun") {
          playfx(level._effect["powerup_grabbed_solo"], self.origin);
        } else {
          playfx(level._effect["powerup_grabbed"], self.origin);
        }
        playfx(level._effect["powerup_grabbed_wave"], self.origin);
        if(isDefined(level.zombie_powerup_grab_func)) {
          level thread[[level.zombie_powerup_grab_func]]();
        } else {
          switch (self.powerup_name) {
            case "nuke":
              level thread nuke_powerup(self);
              players[i] thread powerup_vo("nuke");
              zombies = getaiarray("axis");
              players[i].zombie_nuked = get_array_of_closest(self.origin, zombies);
              players[i] notify("nuke_triggered");
              break;
            case "full_ammo":
              level thread full_ammo_powerup(self);
              players[i] thread powerup_vo("full_ammo");
              break;
            case "double_points":
              level thread double_points_powerup(self);
              players[i] thread powerup_vo("double_points");
              break;
            case "insta_kill":
              level thread insta_kill_powerup(self);
              players[i] thread powerup_vo("insta_kill");
              break;
            case "carpenter":
              level thread start_carpenter(self.origin);
              players[i] thread powerup_vo("carpenter");
              break;
            case "fire_sale":
              level thread start_fire_sale(self);
              players[i] thread powerup_vo("firesale");
              break;
            case "bonfire_sale":
              level thread start_bonfire_sale(self);
              players[i] thread powerup_vo("firesale");
              break;
            case "minigun":
              level thread minigun_weapon_powerup(players[i]);
              players[i] thread powerup_vo("insta_kill");
              break;
            case "all_revive":
              level thread start_revive_all(self);
              players[i] thread powerup_vo("revive");
              break;
            default:
              println("Unrecognized poweup.");
              break;
          }
        }
        wait(0.1);
        playsoundatposition("zmb_powerup_grabbed", self.origin);
        self stopLoopSound();
        if(self.powerup_name != "fire_sale") {
          level thread maps\_zombiemode_audio::do_announcer_playvox(level.devil_vox["powerup"][self.powerup_name]);
        }
        self delete();
        self notify("powerup_grabbed");
      }
    }
    wait 0.1;
  }
}

start_revive_all(item) {
  players = get_players();
  reviver = players[0];
  for(i = 0; i < players.size; i++) {
    if(!players[i] maps\_laststand::player_is_in_laststand()) {
      reviver = players[i];
      break;
    }
  }
  for(i = 0; i < players.size; i++) {
    if(players[i] maps\_laststand::player_is_in_laststand()) {
      players[i] maps\_laststand::revive_force_revive(reviver);
      players[i] notify("zombified");
    }
  }
}

start_fire_sale(item) {
  level notify("powerup fire sale");
  level endon("powerup fire sale");
  level thread maps\_zombiemode_audio::do_announcer_playvox(level.devil_vox["powerup"]["fire_sale_short"]);
  level.zombie_vars["zombie_powerup_fire_sale_on"] = true;
  level thread toggle_fire_sale_on();
  level.zombie_vars["zombie_powerup_fire_sale_time"] = 30;
  while(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
    wait(0.1);
    level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] - 0.1;
  }
  level.zombie_vars["zombie_powerup_fire_sale_on"] = false;
  level notify("fire_sale_off");
}

start_bonfire_sale(item) {
  level notify("powerup bonfire sale");
  level endon("powerup bonfire sale");
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playLoopSound("zmb_double_point_loop");
  level.zombie_vars["zombie_powerup_bonfire_sale_on"] = true;
  level thread toggle_bonfire_sale_on();
  level.zombie_vars["zombie_powerup_bonfire_sale_time"] = 30;
  while(level.zombie_vars["zombie_powerup_bonfire_sale_time"] > 0) {
    wait(0.1);
    level.zombie_vars["zombie_powerup_bonfire_sale_time"] = level.zombie_vars["zombie_powerup_bonfire_sale_time"] - 0.1;
  }
  level.zombie_vars["zombie_powerup_bonfire_sale_on"] = false;
  level notify("bonfire_sale_off");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] playsound("zmb_points_loop_off");
  }
  temp_ent Delete();
}

start_carpenter(origin) {
  window_boards = getstructarray("exterior_goal", "targetname");
  total = level.exterior_goals.size;
  carp_ent = spawn("script_origin", (0, 0, 0));
  carp_ent playLoopSound("evt_carpenter");
  while(true) {
    windows = get_closest_window_repair(window_boards, origin);
    if(!isDefined(windows)) {
      carp_ent stopLoopSound(1);
      carp_ent playsound("evt_carpenter_end", "sound_done");
      carp_ent waittill("sound_done");
      break;
    } else
      window_boards = array_remove(window_boards, windows);
    while(1) {
      if(all_chunks_intact(windows.barrier_chunks)) {
        break;
      }
      chunk = get_random_destroyed_chunk(windows.barrier_chunks);
      if(!isDefined(chunk)) {
        break;
      }
      windows thread maps\_zombiemode_blockers::replace_chunk(chunk, undefined, true);
      windows.clip enable_trigger();
      windows.clip DisconnectPaths();
      wait_network_frame();
      wait(0.05);
    }
    wait_network_frame();
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] maps\_zombiemode_score::player_add_points("carpenter_powerup", 200);
  }
  carp_ent delete();
}

get_closest_window_repair(windows, origin) {
  current_window = undefined;
  shortest_distance = undefined;
  for(i = 0; i < windows.size; i++) {
    if(all_chunks_intact(windows[i].barrier_chunks))
      continue;
    if(!isDefined(current_window)) {
      current_window = windows[i];
      shortest_distance = distanceSquared(current_window.origin, origin);
    } else {
      if(distanceSquared(windows[i].origin, origin) < shortest_distance) {
        current_window = windows[i];
        shortest_distance = distanceSquared(windows[i].origin, origin);
      }
    }
  }
  return current_window;
}

powerup_vo(type) {
  self endon("death");
  self endon("disconnect");
  wait(randomfloatrange(3, 3.5));
  self maps\_zombiemode_audio::create_and_play_dialog("powerup", type);
}

powerup_wobble() {
  self endon("powerup_grabbed");
  self endon("powerup_timedout");
  if(isDefined(self)) {
    if(isDefined(self.powerup_name) && self.powerup_name == "minigun") {
      playfxontag(level._effect["powerup_on_solo"], self, "tag_origin");
    } else {
      playfxontag(level._effect["powerup_on"], self, "tag_origin");
    }
  }
  while(isDefined(self)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = randomInt(360);
    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }
    yaw = self.angles[1] + yaw;
    self rotateto((-60 + randomInt(120), yaw, -45 + randomInt(90)), waittime, waittime * 0.5, waittime * 0.5);
    wait randomfloat(waittime - 0.1);
  }
}

powerup_timeout() {
  self endon("powerup_grabbed");
  wait 15;
  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self hide();
    } else {
      self show();
    }
    if(i < 15) {
      wait 0.5;
    } else if(i < 25) {
      wait 0.25;
    } else {
      wait 0.1;
    }
  }
  self notify("powerup_timedout");
  self delete();
}

nuke_powerup(drop_item) {
  zombies = getaispeciesarray("axis");
  location = drop_item.origin;
  PlayFx(drop_item.fx, location);
  level thread nuke_flash();
  wait(0.5);
  zombies = get_array_of_closest(location, zombies);
  zombies_nuked = [];
  for(i = 0; i < zombies.size; i++) {
    if(isDefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
      continue;
    }
    if(isDefined(zombies[i].nuke_damage_func)) {
      zombies[i] thread[[zombies[i].nuke_damage_func]]();
      continue;
    }
    if(is_magic_bullet_shield_enabled(zombies[i])) {
      continue;
    }
    zombies[i].marked_for_death = true;
    zombies[i].nuked = true;
    zombies_nuked[zombies_nuked.size] = zombies[i];
  }
  for(i = 0; i < zombies_nuked.size; i++) {
    wait(randomfloatrange(0.1, 0.7));
    if(!isDefined(zombies_nuked[i])) {
      continue;
    }
    if(is_magic_bullet_shield_enabled(zombies_nuked[i])) {
      continue;
    }
    if(i < 5 && !(zombies_nuked[i].isdog)) {
      zombies_nuked[i] thread animscripts\zombie_death::flame_death_fx();
      zombies_nuked[i] playsound("evt_nuked");
    }
    if(!(zombies_nuked[i].isdog)) {
      zombies_nuked[i] maps\_zombiemode_spawner::zombie_head_gib();
      zombies_nuked[i] playsound("evt_nuked");
    }
    zombies_nuked[i] dodamage(zombies_nuked[i].health + 666, zombies_nuked[i].origin);
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] maps\_zombiemode_score::player_add_points("nuke_powerup", 400);
  }
}

nuke_flash() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] play_sound_2d("evt_nuke_flash");
  }
  level thread devil_dialog_delay();
  fadetowhite = newhudelem();
  fadetowhite.x = 0;
  fadetowhite.y = 0;
  fadetowhite.alpha = 0;
  fadetowhite.horzAlign = "fullscreen";
  fadetowhite.vertAlign = "fullscreen";
  fadetowhite.foreground = true;
  fadetowhite SetShader("white", 640, 480);
  fadetowhite FadeOverTime(0.2);
  fadetowhite.alpha = 0.8;
  wait 0.5;
  fadetowhite FadeOverTime(1.0);
  fadetowhite.alpha = 0;
  wait 1.1;
  fadetowhite destroy();
}

double_points_powerup(drop_item) {
  level notify("powerup points scaled");
  level endon("powerup points scaled");
  level thread point_doubler_on_hud(drop_item);
  level.zombie_vars["zombie_point_scalar"] = 2;
  wait 30;
  level.zombie_vars["zombie_point_scalar"] = 1;
}

full_ammo_powerup(drop_item) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    primary_weapons = players[i] GetWeaponsList();
    for(x = 0; x < primary_weapons.size; x++) {
      players[i] notify("zmb_lost_knife");
      players[i] notify("zmb_disable_claymore_prompt");
      players[i] GiveMaxAmmo(primary_weapons[x]);
    }
  }
  level thread full_ammo_on_hud(drop_item);
}

insta_kill_powerup(drop_item) {
  level notify("powerup instakill");
  level endon("powerup instakill");
  level thread insta_kill_on_hud(drop_item);
  level.zombie_vars["zombie_insta_kill"] = 1;
  wait(30);
  level.zombie_vars["zombie_insta_kill"] = 0;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] notify("insta_kill_over");
  }
}

check_for_instakill(player, mod, hit_location) {
  if(level.mutators["mutator_noPowerups"]) {
    return;
  }
  if(isDefined(player) && IsAlive(player) && level.zombie_vars["zombie_insta_kill"]) {
    if(is_magic_bullet_shield_enabled(self)) {
      return;
    }
    if(isDefined(self.animname) && self.animname == "ape_zombie") {
      return;
    }
    if(player.use_weapon_type == "MOD_MELEE") {
      player.last_kill_method = "MOD_MELEE";
    } else {
      player.last_kill_method = "MOD_UNKNOWN";
    }
    modName = remove_mod_from_methodofdeath(mod);
    if(flag("dog_round")) {
      self DoDamage(self.health * 10, self.origin, player, undefined, modName, hit_location);
      player notify("zombie_killed");
    } else {
      self maps\_zombiemode_spawner::zombie_head_gib();
      self DoDamage(self.health * 10, self.origin, player, undefined, modName, hit_location);
      player notify("zombie_killed");
    }
  }
}

insta_kill_on_hud(drop_item) {
  self endon("disconnect");
  if(level.zombie_vars["zombie_powerup_insta_kill_on"]) {
    level.zombie_vars["zombie_powerup_insta_kill_time"] = 30;
    return;
  }
  level.zombie_vars["zombie_powerup_insta_kill_on"] = true;
  level thread time_remaning_on_insta_kill_powerup();
}

time_remaning_on_insta_kill_powerup() {
  temp_enta = spawn("script_origin", (0, 0, 0));
  temp_enta playLoopSound("zmb_insta_kill_loop");
  while(level.zombie_vars["zombie_powerup_insta_kill_time"] >= 0) {
    wait 0.1;
    level.zombie_vars["zombie_powerup_insta_kill_time"] = level.zombie_vars["zombie_powerup_insta_kill_time"] - 0.1;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] playsound("zmb_insta_kill");
  }
  temp_enta stopLoopSound(2);
  level.zombie_vars["zombie_powerup_insta_kill_on"] = false;
  level.zombie_vars["zombie_powerup_insta_kill_time"] = 30;
  temp_enta delete();
}

point_doubler_on_hud(drop_item) {
  self endon("disconnect");
  if(level.zombie_vars["zombie_powerup_point_doubler_on"]) {
    level.zombie_vars["zombie_powerup_point_doubler_time"] = 30;
    return;
  }
  level.zombie_vars["zombie_powerup_point_doubler_on"] = true;
  level thread time_remaining_on_point_doubler_powerup();
}

time_remaining_on_point_doubler_powerup() {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playLoopSound("zmb_double_point_loop");
  while(level.zombie_vars["zombie_powerup_point_doubler_time"] >= 0) {
    wait 0.1;
    level.zombie_vars["zombie_powerup_point_doubler_time"] = level.zombie_vars["zombie_powerup_point_doubler_time"] - 0.1;
  }
  level.zombie_vars["zombie_powerup_point_doubler_on"] = false;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] playsound("zmb_points_loop_off");
  }
  temp_ent stopLoopSound(2);
  level.zombie_vars["zombie_powerup_point_doubler_time"] = 30;
  temp_ent delete();
}

toggle_bonfire_sale_on() {
  level endon("powerup bonfire sale");
  if(!isDefined(level.zombie_vars["zombie_powerup_bonfire_sale_on"])) {
    return;
  }
  if(level.zombie_vars["zombie_powerup_bonfire_sale_on"]) {
    if(isDefined(level.bonfire_init_func)) {
      level thread[[level.bonfire_init_func]]();
    }
    level waittill("bonfire_sale_off");
  }
}

toggle_fire_sale_on() {
  level endon("powerup fire sale");
  if(!isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"])) {
    return;
  }
  if(level.zombie_vars["zombie_powerup_fire_sale_on"]) {
    for(i = 0; i < level.chests.size; i++) {
      level.chests[i].zombie_cost = 10;
      level.chests[i] set_hint_string(level.chests[i], "powerup_fire_sale_cost");
      if(level.chest_index != i) {
        level.chests[i] thread maps\_zombiemode_weapons::show_chest();
        level.chests[i] thread maps\_zombiemode_weapons::hide_rubble();
        wait_network_frame();
      }
    }
    level waittill("fire_sale_off");
    for(i = 0; i < level.chests.size; i++) {
      if(level.chest_index != i) {
        level thread remove_temp_chest(i);
      }
      if(isDefined(level.chests[i].grab_weapon_hint) && (level.chests[i].grab_weapon_hint == true)) {
        level.chests[i] thread fire_sale_weapon_wait();
      } else {
        level.chests[i].zombie_cost = level.chests[i].old_cost;
        level.chests[i] set_hint_string(level.chests[i], "default_treasure_chest_" + level.chests[i].zombie_cost);
      }
    }
  }
}

fire_sale_weapon_wait() {
  self.zombie_cost = self.old_cost;
  while(isDefined(self.chest_user)) {
    wait_network_frame();
  }
  self set_hint_string(self, "default_treasure_chest_" + self.zombie_cost);
}

remove_temp_chest(chest_index) {
  while(isDefined(level.chests[chest_index].chest_user) || (isDefined(level.chests[chest_index]._box_open) && level.chests[chest_index]._box_open == true)) {
    wait_network_frame();
  }
  playfx(level._effect["poltergeist"], level.chests[chest_index].orig_origin);
  level.chests[chest_index] playsound("zmb_box_poof_land");
  level.chests[chest_index] playsound("zmb_couch_slam");
  level.chests[chest_index] maps\_zombiemode_weapons::hide_chest();
  level.chests[chest_index] maps\_zombiemode_weapons::show_rubble();
}

devil_dialog_delay() {
  wait(1.0);
}

full_ammo_on_hud(drop_item) {
  self endon("disconnect");
  hudelem = maps\_hud_util::createFontString("objective", 2);
  hudelem maps\_hud_util::setPoint("TOP", undefined, 0, level.zombie_vars["zombie_timer_offset"] - (level.zombie_vars["zombie_timer_offset_interval"] * 2));
  hudelem.sort = 0.5;
  hudelem.alpha = 0;
  hudelem fadeovertime(0.5);
  hudelem.alpha = 1;
  hudelem.label = drop_item.hint;
  hudelem thread full_ammo_move_hud();
}

full_ammo_move_hud() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] playsound("zmb_full_ammo");
  }
  wait 0.5;
  move_fade_time = 1.5;
  self FadeOverTime(move_fade_time);
  self MoveOverTime(move_fade_time);
  self.y = 270;
  self.alpha = 0;
  wait move_fade_time;
  self destroy();
}

check_for_rare_drop_override(pos) {
  if(isDefined(flag("ape_round")) && flag("ape_round")) {
    return (0);
  }
  return (0);
}

setup_firesale_audio() {
  wait(2);
  intercom = getentarray("intercom", "targetname");
  while(1) {
    while(level.zombie_vars["zombie_powerup_fire_sale_on"] == false) {
      wait(0.2);
    }
    for(i = 0; i < intercom.size; i++) {
      intercom[i] thread play_firesale_audio();
    }
    while(level.zombie_vars["zombie_powerup_fire_sale_on"] == true) {
      wait(0.1);
    }
    level notify("firesale_over");
  }
}

play_firesale_audio() {
  self playLoopSound("mus_fire_sale");
  level waittill("firesale_over");
  self stopLoopSound();
}

setup_bonfiresale_audio() {
  wait(2);
  intercom = getentarray("intercom", "targetname");
  while(1) {
    while(level.zombie_vars["zombie_powerup_fire_sale_on"] == false) {
      wait(0.2);
    }
    for(i = 0; i < intercom.size; i++) {
      intercom[i] thread play_bonfiresale_audio();
    }
    while(level.zombie_vars["zombie_powerup_fire_sale_on"] == true) {
      wait(0.1);
    }
    level notify("firesale_over");
  }
}

play_bonfiresale_audio() {
  self playLoopSound("mus_fire_sale");
  level waittill("firesale_over");
  self stopLoopSound();
}

minigun_weapon_powerup(ent_player) {
  self endon("disconnect");
  ent_player endon("death");
  ent_player endon("player_downed");
  ent_player._show_solo_hud = true;
  level._zombie_minigun_powerup_last_stand_func = ::minigun_watch_gunner_downed;
  ent_player increment_is_drinking();
  ent_player._zombie_gun_before_minigun = ent_player GetCurrentWeapon();
  ent_player GiveWeapon("minigun_zm");
  ent_player SwitchToWeapon("minigun_zm");
  level.zombie_vars["zombie_powerup_minigun_on"] = true;
  level thread minigun_weapon_powerup_countdown(ent_player, "minigun_time_over");
}

minigun_weapon_powerup_countdown(ent_player, str_gun_return_notify) {
  ent_player endon("death");
  ent_player endon("player_downed");
  ent_player endon(str_gun_return_notify);
  time_passed = 0;
  setClientSysState("levelNotify", "minis", ent_player);
  level.zombie_vars["zombie_powerup_minigun_time"] = 30;
  while(level.zombie_vars["zombie_powerup_minigun_time"] > 0) {
    wait(0.1);
    level.zombie_vars["zombie_powerup_minigun_time"] = level.zombie_vars["zombie_powerup_minigun_time"] - 0.1;
  }
  setClientSysState("levelNotify", "minie", ent_player);
  level thread minigun_weapon_powerup_remove(ent_player, str_gun_return_notify);
}

minigun_weapon_powerup_remove(ent_player, str_gun_return_notify) {
  ent_player endon("death");
  ent_player endon("player_downed");
  ent_player TakeWeapon("minigun_zm");
  level.zombie_vars["zombie_powerup_minigun_on"] = false;
  ent_player._show_solo_hud = false;
  level._zombie_minigun_powerup_last_stand_func = undefined;
  ent_player notify(str_gun_return_notify);
  ent_player decrement_is_drinking();
  if(isDefined(ent_player._zombie_gun_before_minigun)) {
    player_weapons = ent_player GetWeaponsListPrimaries();
    for(i = 0; i < player_weapons.size; i++) {
      if(player_weapons[i] == ent_player._zombie_gun_before_minigun) {
        ent_player SwitchToWeapon(ent_player._zombie_gun_before_minigun);
        return;
      }
    }
  }
  primaryWeapons = ent_player GetWeaponsListPrimaries();
  if(primaryWeapons.size > 0) {
    ent_player SwitchToWeapon(primaryWeapons[0]);
  } else {
    allWeapons = ent_player GetWeaponsList();
    for(i = 0; i < allWeapons.size; i++) {
      if(allWeapons[i] == "knife_zm" || allWeapons[i] == "bowie_knife_zm") {
        ent_player SwitchToWeapon(allWeapons[i]);
        return;
      }
    }
  }
}

minigun_weapon_powerup_off() {
  level.zombie_vars["zombie_powerup_minigun_time"] = 0;
}

minigun_watch_gunner_downed() {
  primaryWeapons = self GetWeaponsListPrimaries();
  for(i = 0; i < primaryWeapons.size; i++) {
    if(primaryWeapons[i] == "minigun_zm") {
      self TakeWeapon("minigun_zm");
    }
  }
  self notify("minigun_time_over");
  level.zombie_vars["zombie_powerup_minigun_on"] = false;
  self._show_solo_hud = false;
  level._zombie_minigun_powerup_last_stand_func = undefined;
}

print_powerup_drop(powerup, type) {}