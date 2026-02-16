/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_spawning.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_utility_raven;
#include maps\_zombiemode;

temple_init_zone_spawn_locations() {
  level.main_spawner = GetEnt("main_zombie_spawner", "targetname");
  AssertEX(isDefined(level.main_spawner), "No spawner defined for map");
  zkeys = GetArrayKeys(level.zones);
  for(z = 0; z < zkeys.size; z++) {
    zoneName = zkeys[z];
    zone = level.zones[zoneName];
    zone.spawn_locations = [];
    spawn_locations = getStructArray(zone.volumes[0].target, "targetname");
    for(i = 0; i < spawn_locations.size; i++) {
      loc = spawn_locations[i];
      loc.zone_name = zoneName;
      loc.is_enabled = true;
      zone.spawn_locations[zone.spawn_locations.size] = loc;
    }
  }
}
temple_ignore_spawner(spawner) {
  if(spawner.classname == "actor_zombie_smoker") {
    return true;
  }
  return false;
}
temple_manage_zones(zkeys) {
  player_on_waterslide = false;
  players = GetPlayers();
  for(i = 0; i < players.size && !player_on_waterslide; i++) {
    player_on_waterslide = isDefined(players[i].is_on_waterslide) && players[i].is_on_waterslide;
  }
  if(player_on_waterslide) {
    caves1_zone = level.zones["caves1_zone"];
    if(isDefined(caves1_zone) && caves1_zone.is_enabled) {
      caves1_zone.is_active = true;
      caves1_zone.is_occupied = true;
    }
  }
  if(isDefined(level.minecart_force_zone_active) && level.minecart_force_zone_active) {
    waterfall_zone = level.zones["waterfall_lower_zone"];
    if(isDefined(waterfall_zone)) {
      waterfall_zone.is_active = true;
      waterfall_zone.is_occupied = true;
    }
  }
}
temple_create_spawner_list(zkeys) {
  temple_manage_zones(zkeys);
  level.enemy_spawns = [];
  level.enemy_spawn_locations = [];
  level.enemy_dog_locations = [];
  level.zombie_rise_spawners = [];
  level.zombie_fall_spawners = [];
  level.monkey_spawns = [];
  for(z = 0; z < zkeys.size; z++) {
    zoneName = zkeys[z];
    zone = level.zones[zoneName];
    if(zone.is_enabled && zone.is_active) {
      for(x = 0; x < zone.spawn_locations.size; x++) {
        if(zone.spawn_locations[x].is_enabled) {
          level.enemy_spawn_locations[level.enemy_spawn_locations.size] = zone.spawn_locations[x];
        }
      }
      for(x = 0; x < zone.dog_locations.size; x++) {
        if(zone.dog_locations[x].is_enabled) {
          level.enemy_dog_locations[level.enemy_dog_locations.size] = zone.dog_locations[x];
        }
      }
      for(x = 0; x < zone.rise_locations.size; x++) {
        if(zone.rise_locations[x].is_enabled) {
          level.zombie_rise_spawners[level.zombie_rise_spawners.size] = zone.rise_locations[x];
        }
      }
      for(x = 0; x < zone.fall_locations.size; x++) {
        if(zone.fall_locations[x].is_enabled) {
          level.zombie_fall_spawners[level.zombie_fall_spawners.size] = zone.fall_locations[x];
        }
      }
      if(zone.is_occupied) {
        for(x = 0; x < level.monkey_zombie_spawners.size; x++) {
          spawner = level.monkey_zombie_spawners[x];
          if(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == zoneName &&
            isDefined(zone.barriers) && zone.barriers.size > 0) {
            level.monkey_spawns[level.monkey_spawns.size] = spawner;
          }
        }
      }
    }
  }
}
temple_round_prestart() {
  if(GetDvarInt(#"zombie_fall_test")) {
    level.round_spawn_func = maps\_zombiemode_ai_faller::round_spawning_fall_test;
  }
  wait(2);
}
temple_round_spawning() {
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  if(level.intermission) {
    return;
  }
  ai_calculate_health(level.round_number);
  count = 0;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].zombification_time = 0;
  }
  max = level.zombie_vars["zombie_max_ai"];
  multiplier = level.round_number / 5;
  if(multiplier < 1) {
    multiplier = 1;
  }
  if(level.round_number >= 10) {
    multiplier *= level.round_number * 0.15;
  }
  player_num = get_players().size;
  if(player_num == 1) {
    max += int((0.5 * level.zombie_vars["zombie_ai_per_player"]) * multiplier);
  } else {
    max += int(((player_num - 1) * level.zombie_vars["zombie_ai_per_player"]) * multiplier);
  }
  if(!isDefined(level.max_zombie_func)) {
    level.max_zombie_func = ::default_max_zombie_func;
  }
  if(!(isDefined(level.kill_counter_hud) && level.zombie_total > 0)) {
    level.zombie_total = [[level.max_zombie_func]](max);
  }
  if(level.round_number < 10) {
    level thread zombie_speed_up_temple();
  }
  mixed_spawns = 0;
  _update_napalm_variables();
  _update_monkey_variables();
  _update_sonic_variables();
  level.special_zombie_spawned_this_round = false;
  old_spawn = undefined;
  while(1) {
    while(get_enemy_count() > 31 || level.zombie_total <= 0) {
      wait(0.1);
    }
    if(!flag("spawn_zombies")) {
      flag_wait("spawn_zombies");
    }
    if(level.enemy_spawn_locations.size < 1 || !isDefined(level.main_spawner)) {
      ASSERTMSG("No active spawners in the map.Check to see if the zone is active and if it's pointing to spawners.");
      return;
    }
    spawn_point = level.enemy_spawn_locations[RandomInt(level.enemy_spawn_locations.size)];
    if(!isDefined(old_spawn)) {
      old_spawn = spawn_point;
    } else if(Spawn_point == old_spawn) {
      spawn_point = level.enemy_spawn_locations[RandomInt(level.enemy_spawn_locations.size)];
    }
    old_spawn = spawn_point;
    ai = _try_spawn_napalm(spawn_point);
    if(!isDefined(ai)) {
      ai = _try_spawn_monkey();
    }
    if(!isDefined(ai)) {
      ai = _try_spawn_sonic(spawn_point);
    }
    if(!isDefined(ai)) {
      ai = _try_spawn_zombie(spawn_point);
    }
    if(isDefined(ai)) {
      level.zombie_total--;
      ai thread round_spawn_failsafe();
      count++;
    }
    wait(level.zombie_vars["zombie_spawn_delay"]);
    wait_network_frame();
  }
}
_setup_spawner(spawn_point) {
  level.main_spawner.script_string = spawn_point.script_string;
}
zombie_speed_up_temple() {
  if(level.round_number <= 3) {
    return;
  }
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  while(level.zombie_total > 4) {
    wait(2.0);
  }
  num_zombies = get_enemy_count();
  while(num_zombies > 3) {
    wait(2.0);
    num_zombies = get_enemy_count();
  }
  zombies = GetAiSpeciesArray("axis", "all");
  while(zombies.size > 0) {
    if(zombies.size == 1 && is_true(zombies[0].has_legs)) {
      if(!zombies[0] maps\zombie_temple_traps::zombie_on_mud()) {
        var = randomintrange(1, 4);
        zombies[0] set_run_anim("sprint" + var);
        zombies[0].run_combatanim = level.scr_anim[zombies[0].animname]["sprint" + var];
        zombies[0].zombie_move_speed = "sprint";
      }
    }
    wait(0.5);
    zombies = GetAiSpeciesArray("axis", "all");
  }
}
temple_round_wait() {
  wait(1);
  while(get_enemy_count() || level.zombie_total > 0 || level.intermission) {
    if(flag("end_round_wait")) {
      return;
    }
    wait(1.0);
  }
}
enemies_still_alive() {
  enemies = [];
  enemies = GetAiSpeciesArray("axis", "all");
  for(i = 0; i < enemies.size; i++) {
    if(isDefined(enemies[i].animname) && enemies[i].animname != "monkey_zombie") {
      return true;
    }
  }
  return false;
}
_update_napalm_variables() {
  level.zombiesLeftBeforeNapalmSpawn = RandomIntRange(int(level.zombie_total * 0.25), int(level.zombie_total * 0.75));
}
_try_spawn_napalm(spawn_point) {
  if(!isDefined(level.napalmZombiesEnabled) || level.napalmZombiesEnabled == false || level.napalm_zombie_spawners.size == 0) {
    return undefined;
  }
  if(isDefined(level.napalmZombieCount) && level.napalmZombieCount > 0) {
    return undefined;
  }
  if(level.special_zombie_spawned_this_round) {
    return undefined;
  }
  ai = undefined;
  if(_can_spawn_napalm()) {
    spawner = level.napalm_zombie_spawners[0];
    spawnpoint = _get_special_spawn_point();
    if(!isDefined(spawnpoint)) {
      return undefined;
    }
    spawnOrigin = spawnpoint.origin;
    if(isDefined(spawnOrigin)) {
      spawner.target = "";
      spawner.script_string = "zombie_chaser";
      spawner.origin = spawnOrigin;
    } else {
      spawnOrigin = spawn_point.origin;
      spawner.target = spawn_point.target;
    }
    ai = spawn_zombie(spawner);
    spawner.script_string = undefined;
    spawner.count = 100;
    spawner.last_spawn_time = GetTime();
    if(!spawn_failed(ai)) {
      ai ForceTeleport(spawnOrigin, spawn_point.angles);
      level.special_zombie_spawned_this_round = true;
    }
  }
  return ai;
}
_get_non_visible_spawn_point() {
  players = get_players();
  player = random(players);
  barriers = player maps\zombie_temple_ai_monkey::ent_GatherValidBarriers(undefined, false, true);
  for(i = 0; i < barriers.size; i++) {
    barrierValid = true;
    for(p = 0; p < players.size; p++) {
      if(distance2d(players[p].origin, barriers[i].origin) < 500) {
        barrierValid = false;
        break;
      }
    }
    if(barrierValid) {
      return maps\zombie_temple_ai_monkey::getBarrierAttackLocation(barriers[i]);
    }
  }
  return undefined;
}
_get_special_spawn_point() {
  occupiedPoints = [];
  activePoints = [];
  zkeys = GetArrayKeys(level.zones);
  for(z = 0; z < zkeys.size; z++) {
    zoneName = zkeys[z];
    zone = level.zones[zoneName];
    if(zone.is_occupied) {
      occupiedPoints = array_combine(occupiedPoints, zone.napalm_spawn_locations);
    }
    if(zone.is_active) {
      activePoints = array_combine(activePoints, zone.napalm_spawn_locations);
    }
  }
  points = occupiedPoints;
  if(points.size == 0) {
    points = activePoints;
  }
  if(points.size == 0) {
    return undefined;
  }
  return random(points);
}
_can_spawn_napalm() {
  forceSpawn = flag("zombie_napalm_force_spawn");
  if(GetDvarInt("zombiemode_debug_napalm") != 0) {
    return true;
  }
  if((level.nextNapalmSpawnRound > level.round_number) && !forceSpawn) {
    return false;
  }
  spawnPoint = _get_special_spawn_point();
  if(!isDefined(spawnPoint)) {
    return false;
  }
  if(forceSpawn) {
    return true;
  }
  return level.zombie_total < level.zombiesLeftBeforeNapalmSpawn;
}
_update_monkey_variables() {
  level.monkeysSpawnedThisRound = 0;
  level.zombiesLeftBeforeMonkeySpawn = RandomIntRange(int(level.zombie_total * 0.75), level.zombie_total);
  level.monkey_zombie_health = level.zombie_health;
}
_try_spawn_monkey() {
  if(!isDefined(level.monkey_spawns) || level.monkey_spawns.size == 0) {
    return undefined;
  }
  ai = undefined;
  if(_can_spawn_monkey()) {
    spawner = level.monkey_spawns[RandomInt(level.monkey_spawns.size)];
    ai = spawner Stalingradspawn();
    if(!spawn_failed(ai)) {
      ai maps\zombie_temple_ai_monkey::monkey_TempleThink(spawner);
      level.monkeysSpawnedThisRound++;
    }
  }
  return ai;
}
_can_spawn_monkey() {
  return false;
}
_update_sonic_variables() {
  level.zombiesLeftBeforeSonicSpawn = RandomIntRange(int(level.zombie_total * 0.25), int(level.zombie_total * 0.75));
}
_try_spawn_sonic(spawn_point) {
  if(!isDefined(level.sonicZombiesEnabled) || level.sonicZombiesEnabled == false || level.sonic_zombie_spawners.size == 0) {
    return undefined;
  }
  if(isDefined(level.sonicZombieCount) && level.sonicZombieCount > 0) {
    return undefined;
  }
  if(level.special_zombie_spawned_this_round) {
    return undefined;
  }
  ai = undefined;
  if(_can_spawn_sonic()) {
    spawner = level.sonic_zombie_spawners[0];
    spawnpoint = _get_special_spawn_point();
    if(!isDefined(spawnpoint)) {
      return undefined;
    }
    spawnOrigin = spawnpoint.origin;
    if(isDefined(spawnOrigin)) {
      spawner.target = "";
      spawner.script_string = "zombie_chaser";
      spawner.origin = spawnOrigin;
    } else {
      spawnOrigin = spawn_point.origin;
      spawner.target = spawn_point.target;
    }
    ai = spawn_zombie(spawner);
    spawner.script_string = undefined;
    spawner.count = 100;
    spawner.last_spawn_time = GetTime();
    if(!spawn_failed(ai)) {
      ai ForceTeleport(spawnOrigin, spawn_point.angles);
      level.special_zombie_spawned_this_round = true;
    }
  }
  return ai;
}
_can_spawn_sonic() {
  if(GetDvarInt("zombiemode_debug_sonic") != 0) {
    return true;
  }
  if(level.nextSonicSpawnRound > level.round_number) {
    return false;
  }
  return level.zombie_total < level.zombiesLeftBeforeSonicSpawn;
}
_try_spawn_zombie(spawn_point) {
  level.main_spawner.script_string = spawn_point.script_string;
  level.main_spawner.target = spawn_point.target;
  level.main_spawner.zone_name = spawn_point.zone_name;
  ai = spawn_zombie(level.main_spawner);
  level.main_spawner.count = 100;
  level.main_spawner.last_spawn_time = GetTime();
  if(!spawn_failed(ai)) {
    ai ForceTeleport(spawn_point.origin, spawn_point.angles);
  }
  return ai;
}
zombie_tracking_init() {
  flag_wait("all_players_connected");
  while(true) {
    zombies = GetAIArray("axis");
    if(!isDefined(zombies)) {
      break;
    } else {
      for(i = 0; i < zombies.size; i++) {
        zombies[i] thread delete_zombie_noone_looking(1500);
      }
    }
    wait(10);
  }
}
delete_zombie_noone_looking(how_close) {
  self endon("death");
  if(!isDefined(how_close)) {
    how_close = 1000;
  }
  self.inview = 0;
  self.player_close = 0;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i].sessionstate == "spectator") {
      continue;
    }
    can_be_seen = self player_can_see_me(players[i]);
    if(can_be_seen) {
      self.inview++;
    } else {
      dist = Distance(self.origin, players[i].origin);
      if(dist < how_close) {
        self.player_close++;
      }
    }
  }
  wait_network_frame();
  if(self.inview == 0 && self.player_close == 0) {
    if(!isDefined(self.animname) || (isDefined(self.animname) && self.animname != "zombie")) {
      return;
    }
    if(isDefined(self.electrified) && self.electrified == true) {
      return;
    }
    if(self.health != level.zombie_health) {
      return;
    } else {
      if(isDefined(self.in_the_ground) && self.in_the_ground == true) {
        return;
      }
      if(isDefined(self.in_the_ceiling) && self.in_the_ceiling == true) {
        return;
      }
      level.zombie_total++;
      self maps\_zombiemode_spawner::reset_attack_spot();
      self notify("zombie_delete");
      self Delete();
    }
  }
}
player_can_see_me(player) {
  playerAngles = player getplayerangles();
  playerForwardVec = anglesToForward(playerAngles);
  playerUnitForwardVec = VectorNormalize(playerForwardVec);
  banzaiPos = self.origin;
  playerPos = player GetOrigin();
  playerToBanzaiVec = banzaiPos - playerPos;
  playerToBanzaiUnitVec = VectorNormalize(playerToBanzaiVec);
  forwardDotBanzai = VectorDot(playerUnitForwardVec, playerToBanzaiUnitVec);
  angleFromCenter = ACos(forwardDotBanzai);
  playerFOV = GetDvarFloat(#"cg_fov");
  banzaiVsPlayerFOVBuffer = GetDvarFloat(#"g_banzai_player_fov_buffer");
  if(banzaiVsPlayerFOVBuffer <= 0) {
    banzaiVsPlayerFOVBuffer = 0.2;
  }
  playerCanSeeMe = (angleFromCenter <= (playerFOV * 0.5 * (1 - banzaiVsPlayerFOVBuffer)));
  return playerCanSeeMe;
}