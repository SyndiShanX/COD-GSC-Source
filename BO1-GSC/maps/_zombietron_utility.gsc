/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_utility.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;

get_camera_launch_direction() {
  pos = GetDvarVector("player_topDownCamCenterPos") + GetDvarVector("player_topDownCamOffset");
  return VectorNormalize(pos - self.origin);
}

fake_linkto(entity, offset) {
  while(isDefined(self) && isDefined(entity)) {
    self.origin = entity.origin;
    if(isDefined(offset)) {
      self.origin += offset;
    }
    wait 0.05;
  }
}

ok_to_gib() {
  if(!is_mature()) {
    return false;
  }
  if(is_german_build()) {
    return false;
  }
  return true;
}

randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = randomInt(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

assassinateHudElem(hudelm, note) {
  level waittill(note);
  destroyHudElem(hudelm);
}

destroyHudElem(hudElem) {
  if(isDefined(hudElem))
    hudElem destroy();
}

sort_by_score(array) {
  sorted = [];
  rightsize = array.size;
  while(sorted.size < rightsize) {
    highest = array[0];
    for(i = 0; i < array.size; i++) {
      if(array[i].score > highest.score) {
        highest = array[i];
      }
    }
    sorted = array_add(sorted, highest);
    array = array_remove(array, highest);
  }
  return sorted;
}

spawn_zombie(spawner, target_name, nofailsafe) {
  if(!isDefined(spawner)) {
    return undefined;
  }
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
    if(!isDefined(nofailsafe)) {
      guy thread maps\_zombietron_spawner::zombie_killer_failsafe();
    }
    guy.original_location = guy.origin;
    return guy;
  }
  return undefined;
}

get_closest_valid_player(origin, ignore_player) {
  valid_player_found = false;
  players = get_players();
  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      if(isDefined(ignore_player[i])) {
        players = array_remove(players, ignore_player[i]);
      }
    }
  }
  while(!valid_player_found) {
    player = GetClosest(origin, players);
    if(!isDefined(player)) {
      return undefined;
    }
    if(!is_player_valid(player, true)) {
      players = array_remove(players, player);
      continue;
    }
    return player;
  }
}

is_player_valid(player, checkIgnoreMeFlag) {
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
  if(player maps\_laststand::player_is_in_laststand()) {
    return false;
  }
  if(player isnotarget()) {
    return false;
  }
  if(isDefined(checkIgnoreMeFlag) && player.ignoreme) {
    return false;
  }
  return true;
}

get_number_of_valid_players() {
  players = get_players();
  num_player_valid = 0;
  for(i = 0; i < players.size; i++) {
    if(is_player_valid(players[i]))
      num_player_valid += 1;
  }
  return num_player_valid;
}

add_sound(ref, alias) {
  if(!isDefined(level.zombie_sounds)) {
    level.zombie_sounds = [];
  }
  level.zombie_sounds[ref] = alias;
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

deleteMe_in_n_seconds(secs) {
  wait secs;
  if(isDefined(self)) {
    self Delete();
  }
}

is_headshot(sWeapon, sHitLoc, sMeansOfDeath) {
  return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_BAYONET" && sMeansOfDeath != "MOD_IMPACT";
}

destroy_me_on_player_notify(player, note) {
  self endon("death");
  player waittill(note);
  if(isDefined(self)) {
    self Delete();
  }
}

ghetto_linkto(ent) {
  self endon("ghetto_unlink");
  while(1) {
    self.origin = ent.origin;
    wait 0.05;
  }
}

kill_me() {
  self DoDamage(self.health + 100, self.origin);
}

wait_until_first_player() {
  players = get_players();
  while(players.size == 0) {
    wait 0.05;
    players = get_players();
  }
}

waittill_timeout(note, timeout) {
  self endon(note);
  wait timeout;
  self notify(note);
}

waittill_notify_timeout(note, timeout) {
  self thread waittill_timeout(note, timeout);
  self waittill(note);
}

notify_timeout(note, timeout) {
  self endon("death");
  wait timeout;
  self notify(note);
}

kill_all_the_mfn_zombies(seconds) {
  level endon("round_spawning_starting");
  if(isDefined(seconds)) {
    wait seconds;
  }
  zombies = GetAISpeciesArray("axis", "all");
  array_thread(zombies, ::kill_me);
}

waittill_all_zombies_dead() {
  zombies = GetAISpeciesArray("axis", "all");
  while(zombies.size > 0 || flag("round_is_active")) {
    wait 1;
    zombies = GetAISpeciesArray("axis", "all");
    if(isDefined(level.desiredRound)) {
      array_thread(zombies, ::kill_me);
    }
  }
}

wait_anim_length(animation, blend) {
  len = GetAnimLength(animation) - blend;
  if(len > 0) {
    wait len;
  }
}

ammo() {
  wait 2;
  self endon("disconnect");
  while(1) {
    wait .5;
    weaponsList = self GetWeaponsListPrimaries();
    for(idx = 0; idx < weaponsList.size; idx++)
      self SetWeaponAmmoClip(weaponsList[idx], 100);
  }
}

setup_smashtv_loadout() {
  wait 1;
  self TakeAllWeapons();
  self GiveWeapon(self.default_weap);
  self switchToWeapon(self.default_weap);
  self.headshots = 0;
}

IsExplosiveDamage(damage_mod) {
  if(damage_mod == "MOD_GRENADE" ||
    damage_mod == "MOD_GRENADE_SPLASH" ||
    damage_mod == "MOD_PROJECTILE" ||
    damage_mod == "MOD_PROJECTILE_SPLASH" ||
    damage_mod == "MOD_EXPLOSIVE") {
    return true;
  }
  return false;
}

is_tesla_damage(mod) {
  return (isDefined(self.damageweapon) && (self.damageweapon == "tesla_gun_zt") &&
    (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH"));
}

string_to_float(string) {
  floatParts = strTok(string, ".");
  if(floatParts.size == 1)
    return int(floatParts[0]);
  whole = int(floatParts[0]);
  decimal = 0;
  for(i = floatParts[1].size - 1; i >= 0; i--) {
    decimal = decimal / 10 + int(floatParts[1][i]) / 10;
  }
  if(whole >= 0)
    return (whole + decimal);
  else
    return (whole - decimal);
}

set_zombie_var(var, value, is_float, column) {
  if(!isDefined(is_float)) {
    is_float = false;
  }
  if(!isDefined(column)) {
    column = 1;
  }
  table = "mp/zombiemode_zt.csv";
  table_value = TableLookUp(table, 0,
    var, column);
  if(isDefined(table_value) && table_value != "") {
    if(is_float) {
      value = float(table_value);
    } else {
      value = int(table_value);
    }
  }
  level.zombie_vars[var] = value;
  return value;
}

get_table_var(table, var_name, value, is_float, column) {
  if(!isDefined(table)) {
    table = "mp/zombiemode_zt.csv";
  }
  if(!isDefined(is_float)) {
    is_float = false;
  }
  if(!isDefined(column)) {
    column = 1;
  }
  table_value = TableLookUp(table, 0, var_name, column);
  if(isDefined(table_value) && table_value != "") {
    if(is_float) {
      value = string_to_float(table_value);
    } else {
      value = int(table_value);
    }
  }
  return value;
}

drawcylinder(pos, rad, height) {
  self endon("stop_cylinder");
}

_disableInvulnerability() {
  self DisableInvulnerability();
}

_enableInvulnerability() {
  self EnableInvulnerability();
}

is_arena_boss_available() {
  spawner_set = level.arenas[level.current_arena] + "_spawner";
  if(level.spawners[spawner_set]["boss"].size > 0) {
    return true;
  } else {
    return false;
  }
}

fade_out(time) {
  if(!isDefined(time)) {
    time = 1;
  }
  if(!isDefined(level.introblack)) {
    level.introblack = NewHudElem();
    level.introblack.x = 0;
    level.introblack.y = 0;
    level.introblack.horzAlign = "fullscreen";
    level.introblack.vertAlign = "fullscreen";
    level.introblack.foreground = true;
    level.introblack SetShader("black", 640, 480);
    level.introblack.alpha = 0;
    wait .05;
  }
  level.introblack FadeOverTime(time);
  level.introblack.alpha = 1;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(true);
  }
  wait time;
}

fade_in(hold_black_time) {
  if(!isDefined(level.introblack)) {
    level.introblack = NewHudElem();
    level.introblack.x = 0;
    level.introblack.y = 0;
    level.introblack.horzAlign = "fullscreen";
    level.introblack.vertAlign = "fullscreen";
    level.introblack.foreground = true;
    level.introblack SetShader("black", 640, 480);
    level.introblack.alpha = 1;
    wait .05;
  }
  level.introblack.alpha = 1;
  if(isDefined(hold_black_time))
    wait hold_black_time;
  else
    wait .2;
  level.introblack FadeOverTime(1.5);
  level.introblack.alpha = 0;
  wait 1.5;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(false);
  }
  level notify("fade_in_complete");
}

plot_circle_fortime(radius, time, color) {
  if(!isDefined(color)) {
    color = (0, 1, 0);
  }
  hangtime = .05;
  circleres = 16;
  hemires = circleres / 2;
  circleinc = 360 / circleres;
  circleres++;
  plotpoints = [];
  rad = 0;
  plotpoints = [];
  rad = 0.000;
  timer = gettime() + (time * 1000);
  while(gettime() < timer) {
    players = get_players();
    angletoplayer = vectortoangles(self.origin - players[0] getEye());
    for(i = 0; i < circleres; i++) {
      plotpoints[plotpoints.size] = self.origin + vector_scale(anglesToForward((angletoplayer + (rad, 90, 0))), radius);
      rad += circleinc;
    }
    plot_points(plotpoints, color[0], color[1], color[2], hangtime);
    plotpoints = [];
    wait hangtime;
  }
}

get_closest_to(origin, entArray) {
  bestEnt = entArray[0];
  bestSQ = 2048 * 2048;
  if(isDefined(entArray)) {
    for(i = 0; i < entArray.size; i++) {
      if(!isDefined(entArray[i])) {
        continue;
      }
      distsq = distanceSquared(entArray[i].origin, origin);
      if(distsq < bestSQ) {
        bestEnt = entArray[i];
        bestSQ = distsq;
      }
    }
  }
  return bestEnt;
}

moveto_and_delete(origin, time) {
  self moveTo(origin, time, 0, 0);
  wait time;
  if(isDefined(self.trigger)) {
    self.trigger Delete();
  }
  if(isDefined(self)) {
    self Delete();
  }
}

get_closest_to_me(entArray) {
  return get_closest_to(self.origin, entArray);
}

network_entity_valid(entity) {
  if(!isDefined(entity)) {
    return false;
  }
  return true;
}

_network_safe_play_fx_on_tag(fx, entity, tag) {
  if(network_entity_valid(entity)) {
    playFXOnTag(fx, entity, tag);
  }
}

network_safe_play_fx_on_tag(id, max, fx, entity, tag) {
  network_safe_init(id, max);
  network_choke_action(id, ::_network_safe_play_fx_on_tag, fx, entity, tag);
}

network_safe_init(id, max) {
  if(!isDefined(level.zombie_network_choke_ids_max) || !isDefined(level.zombie_network_choke_ids_max[id])) {
    network_choke_init(id, max);
  }
  assert(max == level.zombie_network_choke_ids_max[id]);
}

network_choke_safe(id) {
  return (level.zombie_network_choke_ids_count[id] < level.zombie_network_choke_ids_max[id]);
}

network_choke_action(id, choke_action, arg1, arg2, arg3) {
  AssertEx(isDefined(level.zombie_network_choke_ids_max[id]), "Network Choke: " + id + " undefined");
  while(!network_choke_safe(id)) {
    wait(0.05);
  }
  level.zombie_network_choke_ids_count[id]++;
  if(!isDefined(arg1)) {
    return ([[choke_action]]());
  }
  if(!isDefined(arg2)) {
    return ([[choke_action]](arg1));
  }
  if(!isDefined(arg3)) {
    return ([[choke_action]](arg1, arg2));
  }
  return ([[choke_action]](arg1, arg2, arg3));
}

network_choke_init(id, max) {
  if(!isDefined(level.zombie_network_choke_ids_max)) {
    level.zombie_network_choke_ids_max = [];
    level.zombie_network_choke_ids_count = [];
  }
  level.zombie_network_choke_ids_max[id] = max;
  level.zombie_network_choke_ids_count[id] = 0;
  level thread network_choke_thread(id);
}

network_choke_thread(id) {
  while(1) {
    wait_network_frame();
    wait_network_frame();
    level.zombie_network_choke_ids_count[id] = 0;
  }
}

breadcrumb_point_clear() {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self.crumbs)) {
    for(i = 0; i < self.max_crumb; i++) {
      self.crumbs[i] = undefined;
    }
  }
}

breadcrumb_point_thread(num_history, interval_sec) {
  self endon("disconnect");
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(self.crumbs)) {
    self.crumbs = [];
    self.cur_crumb = 0;
    self.max_crumb = num_history;
  }
  while(1) {
    if(!isDefined(self.heli) && !isDefined(self.tank)) {
      if(self.cur_crumb == self.max_crumb) {
        self.cur_crumb = 0;
      }
      self.crumbs[self.cur_crumb] = self.origin;
      self.cur_crumb++;
    }
    wait interval_sec;
  }
}