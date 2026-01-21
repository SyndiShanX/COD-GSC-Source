/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_utility.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;

init_utility() {}

get_enemy_count() {
  enemies = [];
  enemies = GetAiSpeciesArray("axis", "all");
  return enemies.size;
}

spawn_zombie(spawner, target_name) {
  spawner.script_moveoverride = true;
  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
    guy = spawner Stalingradspawn();
  } else {
    guy = spawner Dospawn();
  }
  spawner.count = 666;
  if(!spawn_failed(guy)) {
    if(isDefined(target_name)) {
      guy.targetname = target_name;
    }
    return guy;
  }
  return undefined;
}

create_simple_hud(client) {
  if(isDefined(client)) {
    hud = NewClientHudElem(client);
  } else {
    hud = NewHudElem();
  }
  level.hudelem_count++;
  hud.foreground = true;
  hud.sort = 1;
  hud.hidewheninmenu = false;
  return hud;
}

destroy_hud() {
  level.hudelem_count--;
  self Destroy();
}

all_chunks_intact(barrier_chunks) {
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i].destroyed) {
      return false;
    }
  }
  return true;
}

all_chunks_destroyed(barrier_chunks) {
  for(i = 0; i < barrier_chunks.size; i++) {
    if(!barrier_chunks[i].destroyed || isDefined(barrier_chunks[i].target_by_zombie)) {
      return false;
    }
  }
  return true;
}

round_up_to_ten(score) {
  new_score = score - score % 10;
  if(new_score < score) {
    new_score += 10;
  }
  return new_score;
}

random_tan() {
  rand = randomint(100);
  if(isDefined(level.script) && level.script == "nazi_zombie_sumpf") {
    percentNotCharred = 85;
  } else {
    percentNotCharred = 65;
  }
  if(rand > percentNotCharred) {
    self StartTanning();
  }
}

places_before_decimal(num) {
  abs_num = abs(num);
  count = 0;
  while(1) {
    abs_num *= 0.1;
    count += 1;
    if(abs_num < 1) {
      return count;
    }
  }
}

get_closest_valid_player(origin, ignore_player) {
  valid_player_found = false;
  players = get_players();
  if(isDefined(ignore_player)) {
    players = array_remove(players, ignore_player);
  }
  while(!valid_player_found) {
    player = GetClosest(origin, players);
    if(!isDefined(player)) {
      return undefined;
    }
    if(!is_player_valid(player)) {
      players = array_remove(players, player);
      continue;
    }
    return player;
  }
}

is_player_valid(player) {
  if(!isDefined(player)) {
    return false;
  }
  if(!IsAlive(player)) {
    return false;
  }
  if(!IsPlayer(player)) {
    return false;
  }
  if(player.is_zombie == true) {
    return false;
  }
  if(player.sessionstate == "spectator") {
    return false;
  }
  if(player.sessionstate == "intermission") {
    return false;
  }
  if(player maps\_laststand::player_is_in_laststand()) {
    return false;
  }
  if(player isnotarget()) {
    return false;
  }
  return true;
}

in_revive_trigger() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i]) || !IsAlive(players[i])) {
      continue;
    }
    if(isDefined(players[i].revivetrigger)) {
      if(self IsTouching(players[i].revivetrigger)) {
        return true;
      }
    }
  }
  return false;
}

get_closest_node(org, nodes) {
  return getClosest(org, nodes);
}

get_closest_2d(origin, ents) {
  if(!isDefined(ents)) {
    return undefined;
  }
  dist = Distance2d(origin, ents[0].origin);
  index = 0;
  for(i = 1; i < ents.size; i++) {
    temp_dist = Distance2d(origin, ents[i].origin);
    if(temp_dist < dist) {
      dist = temp_dist;
      index = i;
    }
  }
  return ents[index];
}

disable_trigger() {
  if(!isDefined(self.disabled) || !self.disabled) {
    self.disabled = true;
    self.origin = self.origin - (0, 0, 10000);
  }
}

enable_trigger() {
  if(!isDefined(self.disabled) || !self.disabled) {
    return;
  }
  self.disabled = false;
  self.origin = self.origin + (0, 0, 10000);
}

in_playable_area() {
  trigger = getEntArray("playable_area", "targetname");
  if(!isDefined(trigger)) {
    println("No playable area trigger found! Assume EVERYWHERE is PLAYABLE");
    return true;
  }
  for(i = 0; i < trigger.size; i++) {
    if(self IsTouching(trigger[i])) {
      return true;
    }
  }
  return false;
}

get_random_non_destroyed_chunk(barrier_chunks) {
  chunk = undefined;
  chunks = get_non_destroyed_chunks(barrier_chunks);
  if(isDefined(chunks)) {
    return chunks[RandomInt(chunks.size)];
  }
  return undefined;
}

get_closest_non_destroyed_chunk(origin, barrier_chunks) {
  chunk = undefined;
  chunks = get_non_destroyed_chunks(barrier_chunks);
  if(isDefined(chunks)) {
    return get_closest_2d(origin, chunks);
  }
  return undefined;
}

get_random_destroyed_chunk(barrier_chunks) {
  chunk = undefined;
  chunks = get_destroyed_chunks(barrier_chunks);
  if(isDefined(chunks)) {
    return chunks[RandomInt(chunks.size)];
  }
  return undefined;
}

get_non_destroyed_chunks(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(!barrier_chunks[i].destroyed && !isDefined(barrier_chunks[i].target_by_zombie)) {
      array[array.size] = barrier_chunks[i];
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

get_destroyed_chunks(barrier_chunks) {
  array = [];
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i].destroyed) {
      array[array.size] = barrier_chunks[i];
    }
  }
  if(array.size == 0) {
    return undefined;
  }
  return array;
}

is_float(num) {
  val = num - int(num);
  if(val != 0) {
    return true;
  } else {
    return false;
  }
}

array_limiter(array, total) {
  new_array = [];
  for(i = 0; i < array.size; i++) {
    if(i < total) {
      new_array[new_array.size] = array[i];
    }
  }
  return new_array;
}

array_validate(array) {
  if(isDefined(array) && array.size > 0) {
    return true;
  } else {
    return false;
  }
}

add_later_round_spawners() {
  spawners = getEntArray("later_round_spawners", "script_noteworthy");
  for(i = 0; i < spawners.size; i++) {
    add_spawner(spawners[i]);
  }
}

add_spawner(spawner) {
  if(isDefined(spawner.script_start) && level.round_number < spawner.script_start) {
    return;
  }
  if(isDefined(spawner.locked_spawner) && spawner.locked_spawner) {
    return;
  }
  if(isDefined(spawner.has_been_added) && spawner.has_been_added) {
    return;
  }
  spawner.has_been_added = true;
  level.enemy_spawns[level.enemy_spawns.size] = spawner;
}

fake_physicslaunch(target_pos, power) {
  start_pos = self.origin;
  gravity = GetDvarInt("g_gravity") * -1;
  dist = Distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * (time * time);
  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);
  level thread draw_line_ent_to_pos(self, target_pos);
  self MoveGravity(velocity, time);
  return time;
}

add_to_spectate_list() {
  if(!isDefined(level.spectate_list)) {
    level.spectate_list = [];
  }
  level.spectate_list[level.spectate_list.size] = self;
}

remove_from_spectate_list() {
  if(!isDefined(level.spectate_list)) {
    return undefined;
  }
  level.spectate_list = array_remove(level.spectate_list, self);
}

get_next_from_spectate_list(ent) {
  index = 0;
  for(i = 0; i < level.spectate_list.size; i++) {
    if(ent == level.spectate_list[i]) {
      index = i;
    }
  }
  index++;
  if(index >= level.spectate_list.size) {
    index = 0;
  }
  return level.spectate_list[index];
}

get_random_from_spectate_list() {
  return level.spectate_list[RandomInt(level.spectate_list.size)];
}

add_zombie_hint(ref, text) {
  if(!isDefined(level.zombie_hints)) {
    level.zombie_hints = [];
  }
  PrecacheString(text);
  level.zombie_hints[ref] = text;
}

get_zombie_hint(ref) {
  if(isDefined(level.zombie_hints[ref])) {
    return level.zombie_hints[ref];
  }
  println("UNABLE TO FIND HINT STRING " + ref);
  return level.zombie_hints["undefined"];
}

set_hint_string(ent, default_ref) {
  if(isDefined(ent.script_hint)) {
    self SetHintString(get_zombie_hint(ent.script_hint));
  } else {
    self SetHintString(get_zombie_hint(default_ref));
  }
}

add_sound(ref, alias) {
  if(!isDefined(level.zombie_sounds)) {
    level.zombie_sounds = [];
  }
  level.zombie_sounds[ref] = alias;
}

play_sound_at_pos(ref, pos, ent) {
  if(isDefined(ent)) {
    if(isDefined(ent.script_soundalias)) {
      PlaySoundAtPosition(ent.script_soundalias, pos);
      return;
    }
    if(isDefined(self.script_sound)) {
      ref = self.script_sound;
    }
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    AssertMsg("Sound \"" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
    return;
  }
  PlaySoundAtPosition(level.zombie_sounds[ref], pos);
}

play_sound_on_ent(ref) {
  if(isDefined(self.script_soundalias)) {
    self playSound(self.script_soundalias);
    return;
  }
  if(isDefined(self.script_sound)) {
    ref = self.script_sound;
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    AssertMsg("Sound \"" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
    return;
  }
  self playSound(level.zombie_sounds[ref]);
}

play_loopsound_on_ent(ref) {
  if(isDefined(self.script_firefxsound)) {
    ref = self.script_firefxsound;
  }
  if(ref == "none") {
    return;
  }
  if(!isDefined(level.zombie_sounds[ref])) {
    AssertMsg("Sound \"" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
    return;
  }
  self playSound(level.zombie_sounds[ref]);
}

string_to_float(string) {
  floatParts = strTok(string, ".");
  if(floatParts.size == 1)
    return int(floatParts[0]);
  whole = int(floatParts[0]);
  decimal = int(floatParts[1]);
  while(decimal > 1)
    decimal *= 0.1;
  if(whole >= 0)
    return (whole + decimal);
  else
    return (whole - decimal);
}

set_zombie_var(var, value, div, is_float) {
  table = "mp/zombiemode.csv";
  table_value = TableLookUp(table, 0, var, 1);
  if(!isDefined(is_float)) {
    is_float = false;
  }
  if(isDefined(table_value) && table_value != "") {
    if(is_float) {
      value = string_to_float(table_value);
    } else {
      value = int(table_value);
    }
  }
  if(isDefined(div)) {
    value = value / div;
  }
  level.zombie_vars[var] = value;
}

debug_ui() {
  wait 1;
  x = 510;
  y = 280;
  menu_name = "zombie debug";
  menu_bkg = maps\_debug::new_hud(menu_name, undefined, x, y, 1);
  menu_bkg SetShader("white", 160, 120);
  menu_bkg.alignX = "left";
  menu_bkg.alignY = "top";
  menu_bkg.sort = 10;
  menu_bkg.alpha = 0.6;
  menu_bkg.color = (0.0, 0.0, 0.5);
  menu[0] = maps\_debug::new_hud(menu_name, "SD:", x + 5, y + 10, 1);
  menu[1] = maps\_debug::new_hud(menu_name, "ZH:", x + 5, y + 20, 1);
  menu[1] = maps\_debug::new_hud(menu_name, "ZS:", x + 5, y + 30, 1);
  menu[1] = maps\_debug::new_hud(menu_name, "WN:", x + 5, y + 40, 1);
  x_offset = 120;
  spawn_delay = menu.size;
  zombie_health = menu.size + 1;
  zombie_speed = menu.size + 2;
  round_number = menu.size + 3;
  menu[spawn_delay] = maps\_debug::new_hud(menu_name, "", x + x_offset, y + 10, 1);
  menu[zombie_health] = maps\_debug::new_hud(menu_name, "", x + x_offset, y + 20, 1);
  menu[zombie_speed] = maps\_debug::new_hud(menu_name, "", x + x_offset, y + 30, 1);
  menu[round_number] = maps\_debug::new_hud(menu_name, "", x + x_offset, y + 40, 1);
  while(true) {
    wait(0.05);
    menu[spawn_delay] SetText(level.zombie_vars["zombie_spawn_delay"]);
    menu[zombie_health] SetText(level.zombie_health);
    menu[zombie_speed] SetText(level.zombie_move_speed);
    menu[round_number] SetText(level.round_number);
  }
}

hudelem_count() {
  max = 0;
  curr_total = 0;
  while(1) {
    if(level.hudelem_count > max) {
      max = level.hudelem_count;
    }
    println("HudElems: " + level.hudelem_count + "[Peak: " + max + "]");
    wait(0.05);
  }
}

debug_round_advancer() {
  while(1) {
    zombs = getaiarray("axis");
    for(i = 0; i < zombs.size; i++) {
      zombs[i] dodamage(zombs[i].health * 100, (0, 0, 0));
      wait 0.5;
    }
  }
}

print_run_speed(speed) {
  self endon("death");
  while(1) {
    print3d(self.origin + (0, 0, 64), speed, (1, 1, 1));
    wait 0.05;
  }
}

draw_line_ent_to_ent(ent1, ent2) {
  if(GetDvarInt("zombie_debug") != 1) {
    return;
  }
  ent1 endon("death");
  ent2 endon("death");
  while(1) {
    line(ent1.origin, ent2.origin);
    wait(0.05);
  }
}

draw_line_ent_to_pos(ent, pos, end_on) {
  if(GetDvarInt("zombie_debug") != 1) {
    return;
  }
  ent endon("death");
  ent notify("stop_draw_line_ent_to_pos");
  ent endon("stop_draw_line_ent_to_pos");
  if(isDefined(end_on)) {
    ent endon(end_on);
  }
  while(1) {
    line(ent.origin, pos);
    wait(0.05);
  }
}

debug_print(msg) {
  if(GetDvarInt("zombie_debug") > 0) {
    println("######### ZOMBIE: " + msg);
  }
}

debug_blocker(pos, rad, height) {
  self notify("stop_debug_blocker");
  self endon("stop_debug_blocker");
  for(;;) {
    if(GetDvarInt("zombie_debug") != 1) {
      return;
    }
    wait(0.05);
    drawcylinder(pos, rad, height);
  }
}

drawcylinder(pos, rad, height) {
  currad = rad;
  curheight = height;
  for(r = 0; r < 20; r++) {
    theta = r / 20 * 360;
    theta2 = (r + 1) / 20 * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
  }
}

print3d_at_pos(msg, pos, thread_endon, offset) {
  self endon("death");
  if(isDefined(thread_endon)) {
    self notify(thread_endon);
    self endon(thread_endon);
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  while(1) {
    print3d(self.origin + offset, msg);
    wait(0.05);
  }
}

debug_breadcrumbs() {
  self endon("disconnect");
  while(1) {
    if(GetDvarInt("zombie_debug") != 1) {
      wait(1);
      continue;
    }
    for(i = 0; i < self.zombie_breadcrumbs.size; i++) {
      drawcylinder(self.zombie_breadcrumbs[i], 5, 5);
    }
    wait(0.05);
  }
}

debug_attack_spots_taken() {
  while(1) {
    if(GetDvarInt("zombie_debug") != 2) {
      wait(1);
      continue;
    }
    wait(0.05);
    count = 0;
    for(i = 0; i < self.attack_spots_taken.size; i++) {
      if(self.attack_spots_taken[i]) {
        count++;
      }
    }
    msg = "" + count + " / " + self.attack_spots_taken.size;
    print3d(self.origin, msg);
  }
}

float_print3d(msg, time) {
  self endon("death");
  time = GetTime() + (time * 1000);
  offset = (0, 0, 72);
  while(GetTime() < time) {
    offset = offset + (0, 0, 2);
    print3d(self.origin + offset, msg, (1, 1, 1));
    wait(0.05);
  }
}

do_player_vo(snd, variation_count) {
  index = maps\_zombiemode_weapons::get_player_index(self);
  sound = "plr_" + index + "_" + snd;
  if(isDefined(variation_count)) {
    sound = sound + "_" + randomintrange(0, variation_count);
  }
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(level.player_is_speaking == 0) {
    level.player_is_speaking = 1;
    self playSound(sound, "sound_done");
    self waittill("sound_done");
    wait(2);
    level.player_is_speaking = 0;
  }
}

player_killstreak_timer() {
  if(getdvar("zombie_kills") == "") {
    setdvar("zombie_kills", "7");
  }
  if(getdvar("zombie_kill_timer") == "") {
    setdvar("zombie_kill_timer", "5");
  }
  kills = getdvarint("zombie_kills");
  time = getdvarint("zombie_kill_timer");
  if(!isDefined(self.timerIsrunning)) {
    self.timerIsrunning = 0;
  }
  while(1) {
    self waittill("zom_kill");
    self.killcounter++;
    if(self.timerIsrunning != 1) {
      self.timerIsrunning = 1;
      self thread timer_actual(kills, time);
    }
  }
}

timer_actual(kills, time) {
  timer = gettime() + (time * 1000);
  while(getTime() < timer) {
    if(self.killcounter > kills) {
      self play_killstreak_dialog();
      wait(1);
      timer = -1;
    }
    wait(0.1);
  }
  self.killcounter = 0;
  self.timerIsrunning = 0;
}

play_killstreak_dialog() {
  index = maps\_zombiemode_weapons::get_player_index(self);
  player_index = "plr_" + index + "_";
  waittime = 0.25;
  if(!isDefined(self.vox_killstreak)) {
    num_variants = maps\_zombiemode_spawner::get_number_variants(player_index + "vox_killstreak");
    self.vox_killstreak = [];
    for(i = 0; i < num_variants; i++) {
      self.vox_killstreak[self.vox_killstreak.size] = "vox_killstreak_" + i;
    }
    self.vox_killstreak_available = self.vox_killstreak;
  }
  sound_to_play = random(self.vox_killstreak_available);
  self.vox_killstreak_available = array_remove(self.vox_killstreak_available, sound_to_play);
  self do_player_killstreak_dialog(player_index, sound_to_play, waittime);
  wait(waittime);
  if(self.vox_killstreak_available.size < 1) {
    self.vox_killstreak_available = self.vox_killstreak;
  }
}

do_player_killstreak_dialog(player_index, sound_to_play, waittime) {
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(level.player_is_speaking != 1) {
    level.player_is_speaking = 1;
    self playSound(player_index + sound_to_play, "sound_done" + sound_to_play);
    self waittill("sound_done" + sound_to_play);
    wait(waittime);
    level.player_is_speaking = 0;
  }
}

is_magic_bullet_shield_enabled(ent) {
  if(!isDefined(ent))
    return false;
  return (isDefined(ent.magic_bullet_shield) && ent.magic_bullet_shield == true);
}

enemy_is_dog() {
  return (self.type == "dog");
}

really_play_2D_sound(sound) {
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playSound(sound, sound + "wait");
  temp_ent waittill(sound + "wait");
  wait(0.05);
  temp_ent delete();
}

play_sound_2D(sound) {
  thread really_play_2D_sound(sound);
}