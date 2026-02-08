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

  PrecacheShader("black");
  set_zombie_var("zombie_insta_kill", 0);
  set_zombie_var("zombie_point_scalar", 1);
  set_zombie_var("zombie_drop_item", 0);
  set_zombie_var("zombie_timer_offset", 350);
  set_zombie_var("zombie_timer_offset_interval", 30);
  set_zombie_var("zombie_powerup_insta_kill_on", false);
  set_zombie_var("zombie_powerup_point_doubler_on", false);
  set_zombie_var("zombie_powerup_point_doubler_time", 30);
  set_zombie_var("zombie_powerup_insta_kill_time", 30);
  set_zombie_var("zombie_powerup_drop_increment", 2000);
  set_zombie_var("zombie_powerup_drop_max_per_round", 4);

  level._effect["powerup_on"] = loadfx("misc/fx_zombie_powerup_on");
  level._effect["powerup_grabbed"] = loadfx("misc/fx_zombie_powerup_grab");
  level._effect["powerup_grabbed_wave"] = loadfx("misc/fx_zombie_powerup_wave");

  init_powerups();

  thread watch_for_drop();
}

init_powerups() {
  add_zombie_powerup("nuke", "zombie_bomb", &"ZOMBIE_POWERUP_NUKE", "misc/fx_zombie_mini_nuke");
  add_zombie_powerup("insta_kill", "zombie_skull", &"ZOMBIE_POWERUP_INSTA_KILL");
  add_zombie_powerup("double_points", "zombie_x2_icon", &"ZOMBIE_POWERUP_DOUBLE_POINTS");
  add_zombie_powerup("full_ammo", "zombie_ammocan", &"ZOMBIE_POWERUP_MAX_AMMO");

  randomize_powerups();

  level.zombie_powerup_index = 0;
  randomize_powerups();

  level thread powerup_hud_overlay();
}

powerup_hud_overlay() {
  level.powerup_hud_array = [];
  level.powerup_hud_array[0] = true;
  level.powerup_hud_array[1] = true;

  level.powerup_hud = [];
  level.powerup_hud_cover = [];
  level endon("disconnect");

  for(i = 0; i < 2; i++) {
    level.powerup_hud[i] = create_simple_hud();
    level.powerup_hud[i].foreground = true;
    level.powerup_hud[i].sort = 2;
    level.powerup_hud[i].hidewheninmenu = false;
    level.powerup_hud[i].alignX = "center";
    level.powerup_hud[i].alignY = "bottom";
    level.powerup_hud[i].horzAlign = "center";
    level.powerup_hud[i].vertAlign = "bottom";
    level.powerup_hud[i].x = -32 + (i * 15);
    level.powerup_hud[i].y = level.powerup_hud[i].y - 35;
    level.powerup_hud[i].alpha = 0.8;
  }

  shader_2x = "specialty_doublepoints_zombies";
  shader_insta = "specialty_instakill_zombies";

  while(true) {
    if(level.zombie_vars["zombie_powerup_insta_kill_time"] < 5) {
      wait(0.1);
      level.powerup_hud[1].alpha = 0;
      wait(0.1);
    } else if(level.zombie_vars["zombie_powerup_insta_kill_time"] < 10) {
      wait(0.2);
      level.powerup_hud[1].alpha = 0;
      wait(0.18);
    }

    if(level.zombie_vars["zombie_powerup_point_doubler_time"] < 5) {
      wait(0.1);
      level.powerup_hud[0].alpha = 0;
      wait(0.1);
    } else if(level.zombie_vars["zombie_powerup_point_doubler_time"] < 10) {
      wait(0.2);
      level.powerup_hud[0].alpha = 0;
      wait(0.18);
    }

    if(level.zombie_vars["zombie_powerup_point_doubler_on"] == true && level.zombie_vars["zombie_powerup_insta_kill_on"] == true) {
      level.powerup_hud[0].x = -24;
      level.powerup_hud[1].x = 24;
      level.powerup_hud[0].alpha = 1;
      level.powerup_hud[1].alpha = 1;
      level.powerup_hud[0] setshader(shader_2x, 32, 32);
      level.powerup_hud[1] setshader(shader_insta, 32, 32);
    } else if(level.zombie_vars["zombie_powerup_point_doubler_on"] == true && level.zombie_vars["zombie_powerup_insta_kill_on"] == false) {
      level.powerup_hud[0].x = 0;

      level.powerup_hud[0] setshader(shader_2x, 32, 32);
      level.powerup_hud[1].alpha = 0;
      level.powerup_hud[0].alpha = 1;
    } else if(level.zombie_vars["zombie_powerup_insta_kill_on"] == true && level.zombie_vars["zombie_powerup_point_doubler_on"] == false) {
      level.powerup_hud[1].x = 0;

      level.powerup_hud[1] setshader(shader_insta, 32, 32);
      level.powerup_hud[0].alpha = 0;
      level.powerup_hud[1].alpha = 1;
    } else {
      level.powerup_hud[1].alpha = 0;
      level.powerup_hud[0].alpha = 0;
    }

    wait(0.01);
  }
}

randomize_powerups() {
  level.zombie_powerup_array = array_randomize(level.zombie_powerup_array);
}

get_next_powerup() {
  if(level.zombie_powerup_index >= level.zombie_powerup_array.size) {
    level.zombie_powerup_index = 0;
    randomize_powerups();
  }

  powerup = level.zombie_powerup_array[level.zombie_powerup_index];
  level.zombie_powerup_index++;

  return powerup;
}

watch_for_drop() {
  players = get_players();
  score_to_drop = (players.size * level.zombie_vars["zombie_score_start"]) + level.zombie_vars["zombie_powerup_drop_increment"];

  while(1) {
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

  struct = spawnStruct();

  if(!isDefined(level.zombie_powerups)) {
    level.zombie_powerups = [];
  }

  if(!isDefined(level.zombie_powerup_array)) {
    level.zombie_powerup_array = [];
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
}

include_zombie_powerup(powerup_name) {
  if(!isDefined(level.zombie_include_powerups)) {
    level.zombie_include_powerups = [];
  }

  level.zombie_include_powerups[powerup_name] = true;
}

powerup_round_start() {
  level.powerup_drop_count = 0;
}

powerup_drop(drop_point) {
  rand_drop = randomint(100);

  if(level.powerup_drop_count == level.zombie_vars["zombie_powerup_drop_max_per_round"]) {
    println("^3POWERUP DROP EXCEEDED THE MAX PER ROUND!");
    return;
  }

  if(rand_drop > 2) {
    if(!level.zombie_vars["zombie_drop_item"]) {
      return;
    }

    debug = "score";
  } else {
    debug = "random";
  }

  playable_area = getEntArray("playable_area", "targetname");

  powerup = spawn("script_model", drop_point + (0, 0, 40));

  valid_drop = false;
  for(i = 0; i < playable_area.size; i++) {
    if(powerup istouching(playable_area[i])) {
      valid_drop = true;
    }
  }

  if(!valid_drop) {
    powerup delete();
    return;
  }

  powerup powerup_setup();
  level.powerup_drop_count++;

  print_powerup_drop(powerup.powerup_name, debug);

  powerup thread powerup_timeout();
  powerup thread powerup_wobble();
  powerup thread powerup_grab();

  level.zombie_vars["zombie_drop_item"] = 0;
}

powerup_setup() {
  powerup = get_next_powerup();

  struct = level.zombie_powerups[powerup];
  self setModel(struct.model_name);

  playsoundatposition("spawn_powerup", self.origin);

  self.powerup_name = struct.powerup_name;
  self.hint = struct.hint;

  if(isDefined(struct.fx)) {
    self.fx = struct.fx;
  }

  self playLoopSound("spawn_powerup_loop");
}

powerup_grab() {
  self endon("powerup_timedout");
  self endon("powerup_grabbed");

  while(isDefined(self)) {
    players = get_players();

    for(i = 0; i < players.size; i++) {
      if(distance(players[i].origin, self.origin) < 64) {
        playFX(level._effect["powerup_grabbed"], self.origin);
        playFX(level._effect["powerup_grabbed_wave"], self.origin);

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
            default:
              println("Unrecognized poweup.");
              break;
          }
        }

        wait(0.1);

        playsoundatposition("powerup_grabbed", self.origin);
        self stoploopsound();

        self delete();
        self notify("powerup_grabbed");
      }
    }
    wait 0.1;
  }
}

powerup_vo(type) {
  self endon("death");
  self endon("disconnect");

  index = maps\_zombiemode_weapons::get_player_index(self);
  sound = undefined;

  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }

  wait(randomfloatrange(1, 2));

  switch (type) {
    case "nuke":
      sound = "plr_" + index + "_vox_powerup_nuke_0";
      break;
    case "insta_kill":
      sound = "plr_" + index + "_vox_powerup_insta_0";
      break;
    case "full_ammo":
      sound = "plr_" + index + "_vox_powerup_ammo_0";
      break;
    case "double_points":
      sound = "plr_" + index + "_vox_powerup_double_0";
      break;
  }

  if(level.player_is_speaking != 1 && isDefined(sound)) {
    level.player_is_speaking = 1;
    self playSound(sound, "sound_done");
    self waittill("sound_done");
    level.player_is_speaking = 0;
  }
}

powerup_wobble() {
  self endon("powerup_grabbed");
  self endon("powerup_timedout");

  if(isDefined(self)) {
    playFXOnTag(level._effect["powerup_on"], self, "tag_origin");
  }

  while(isDefined(self)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = RandomInt(360);
    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }
    yaw = self.angles[1] + yaw;
    self rotateto((-60 + randomint(120), yaw, -45 + randomint(90)), waittime, waittime * 0.5, waittime * 0.5);
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

  playFX(drop_item.fx, drop_item.origin);
  level thread nuke_flash();

  zombies = get_array_of_closest(drop_item.origin, zombies);

  for(i = 0; i < zombies.size; i++) {
    wait(randomfloatrange(0.1, 0.7));
    if(!isDefined(zombies[i])) {
      continue;
    }

    if(is_magic_bullet_shield_enabled(zombies[i])) {
      continue;
    }

    if(i < 5 && !(zombies[i] enemy_is_dog())) {
      zombies[i] thread animscripts\death::flame_death_fx();
    }

    if(!(zombies[i] enemy_is_dog())) {
      zombies[i] maps\_zombiemode_spawner::zombie_head_gib();
    }

    zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
    playsoundatposition("nuked", zombies[i].origin);
  }

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].score += 400;
    players[i].score_total += 400;
    players[i] maps\_zombiemode_score::set_player_score_hud();
  }
}

nuke_flash() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] play_sound_2d("nuke_flash");
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

  level.zombie_vars["zombie_point_scalar"] *= 2;

  wait 30;

  level.zombie_vars["zombie_point_scalar"] = 1;
}

full_ammo_powerup(drop_item) {
  players = get_players();

  for(i = 0; i < players.size; i++) {
    primaryWeapons = players[i] GetWeaponsList();

    for(x = 0; x < primaryWeapons.size; x++) {
      players[i] GiveMaxAmmo(primaryWeapons[x]);
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

check_for_instakill(player) {
  if(isDefined(player) && IsAlive(player) && level.zombie_vars["zombie_insta_kill"]) {
    if(is_magic_bullet_shield_enabled(self)) {
      return;
    }

    if(player.use_weapon_type == "MOD_MELEE") {
      player.last_kill_method = "MOD_MELEE";
    } else {
      player.last_kill_method = "MOD_UNKNOWN";
    }

    if(flag("dog_round")) {
      self DoDamage(self.health + 666, self.origin, player);
      player notify("zombie_killed");
    } else {
      self maps\_zombiemode_spawner::zombie_head_gib();
      self DoDamage(self.health + 666, self.origin, player);
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
  level thread play_devil_dialog("insta_vox");
  temp_enta = spawn("script_origin", (0, 0, 0));
  temp_enta playLoopSound("insta_kill_loop");

  while(level.zombie_vars["zombie_powerup_insta_kill_time"] >= 0) {
    wait 0.1;
    level.zombie_vars["zombie_powerup_insta_kill_time"] = level.zombie_vars["zombie_powerup_insta_kill_time"] - 0.1;
  }

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] playSound("insta_kill");
  }

  temp_enta stoploopsound(2);
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
play_devil_dialog(sound_to_play) {
  if(!isDefined(level.devil_is_speaking)) {
    level.devil_is_speaking = 0;
  }
  if(level.devil_is_speaking == 0) {
    level.devil_is_speaking = 1;
    play_sound_2D(sound_to_play);
    wait 2.0;
    level.devil_is_speaking = 0;
  }
}
time_remaining_on_point_doubler_powerup() {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playLoopSound("double_point_loop");

  level thread play_devil_dialog("dp_vox");

  while(level.zombie_vars["zombie_powerup_point_doubler_time"] >= 0) {
    wait 0.1;
    level.zombie_vars["zombie_powerup_point_doubler_time"] = level.zombie_vars["zombie_powerup_point_doubler_time"] - 0.1;
  }

  level.zombie_vars["zombie_powerup_point_doubler_on"] = false;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] playSound("points_loop_off");
  }
  temp_ent stoploopsound(2);

  level.zombie_vars["zombie_powerup_point_doubler_time"] = 30;
  temp_ent delete();
}
devil_dialog_delay() {
  wait(1.8);
  level thread play_devil_dialog("nuke_vox");
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
  level thread play_devil_dialog("ma_vox");
  for(i = 0; i < players.size; i++) {
    players[i] playSound("full_ammo");
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

print_powerup_drop(powerup, type) {
  if(!isDefined(level.powerup_drop_time)) {
    level.powerup_drop_time = 0;
    level.powerup_random_count = 0;
    level.powerup_score_count = 0;
  }

  time = (GetTime() - level.powerup_drop_time) * 0.001;
  level.powerup_drop_time = GetTime();

  if(type == "random") {
    level.powerup_random_count++;
  } else {
    level.powerup_score_count++;
  }

  println("========== POWER UP DROPPED ==========");
  println("DROPPED: " + powerup);
  println("HOW IT DROPPED: " + type);
  println("--------------------");
  println("Drop Time: " + time);
  println("Random Powerup Count: " + level.powerup_random_count);
  println("Random Powerup Count: " + level.powerup_score_count);
  println("======================================");
}