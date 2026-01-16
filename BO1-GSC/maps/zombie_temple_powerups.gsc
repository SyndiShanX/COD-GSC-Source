/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_powerups.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_utility_raven;
#include maps\_zombiemode;

init() {
  level._zombiemode_special_powerup_setup = ::temple_special_powerup_setup;
  level._zombiemode_powerup_grab = ::temple_powerup_grab;
  maps\_zombiemode_powerups::add_zombie_powerup("monkey_swarm", "zombie_pickup_monkey", & "ZOMBIE_POWERUP_MONKEY_SWARM");
  level.playable_area = getentarray("player_volume", "script_noteworthy");
  level._effect["zombie_kill"] = LoadFX("impacts/fx_flesh_hit_body_fatal_lg_exit_mp");
}

temple_special_powerup_setup(powerup) {
  return true;
}

temple_powerup_grab(powerup) {
  if(!isDefined(powerup)) {
    return;
  }
  switch (powerup.powerup_name) {
    case "monkey_swarm":
      level thread monkey_swarm(powerup);
      break;
    default:
      break;
  }
}

monkey_swarm(powerup) {
  monkey_count_per_player = 2;
  flag_clear("spawn_zombies");
  players = GetPlayers();
  level.monkeys_left_to_spawn = players.size * monkey_count_per_player;
  for(i = 0; i < players.size; i++) {
    players[i] thread player_monkey_think(monkey_count_per_player);
  }
  while(level.monkeys_left_to_spawn > 0) {
    wait_network_frame();
  }
  flag_set("spawn_zombies");
}

player_monkey_think(numMonkeys) {
  spawns = getEntArray("monkey_zombie_spawner", "targetname");
  if(spawns.size == 0) {
    level.monkeys_left_to_spawn -= numMonkeys;
    return;
  }
  spawnRadius = 10.0;
  zoneOverride = undefined;
  if(isDefined(self.is_on_waterslide) && self.is_on_waterslide) {
    zoneOverride = "caves1_zone";
  } else if(isDefined(self.is_on_minecart) && self.is_on_minecart) {
    zoneOverride = "waterfall_lower_zone";
  }
  barriers = self maps\zombie_temple_ai_monkey::ent_GatherValidBarriers(zoneOverride);
  println("Spawn Monkeys: " + numMonkeys);
  for(i = 0; i < numMonkeys; i++) {
    wait(RandomFloat(1.0, 2.0));
    zombie = self _ent_GetBestZombie(300.0);
    if(!isDefined(zombie)) {
      zombie = self _ent_GetBestZombie();
    }
    bloodFX = false;
    angles = (0, RandomFloat(360.0), 0);
    forward = AnglesToForward(angles);
    spawnLoc = self.origin + spawnRadius * forward;
    spawnAngles = self.angles;
    if(isDefined(zombie)) {
      spawnLoc = zombie.origin + (0, 0, 50);
      spawnAngles = zombie.angles;
      zombie Delete();
      level.zombie_total++;
      bloodFX = true;
    } else if(barriers.size > 0) {
      best = undefined;
      bestDist = 0.0;
      for(b = 0; b < barriers.size; b++) {
        barrier = barriers[b];
        dist2 = distanceSquared(barrier.origin, self.origin);
        if(!isDefined(best) || dist2 < bestDist) {
          best = barrier;
          bestDist = dist2;
        }
      }
      spawnLoc = maps\zombie_temple_ai_monkey::getBarrierAttackLocation(best);
      spawnAngles = best.angles;
    }
    level.monkeys_left_to_spawn--;
    println("Spawning monkey");
    monkey = spawns[i] Stalingradspawn();
    if(spawn_failed(monkey)) {
      println("monkey spawn failed");
      continue;
    }
    spawns[i].count = 100;
    spawns[i].last_spawn_time = GetTime();
    monkey.attacking_zombie = false;
    monkey.no_shrink = true;
    monkey SetPlayerCollision(false);
    monkey maps\_zombiemode_ai_monkey::monkey_prespawn();
    monkey ForceTeleport(spawnLoc, spawnAngles);
    if(bloodFX) {
      PlayFX(level._effect["zombie_kill"], spawnLoc);
    }
    PlayFX(level._effect["monkey_death"], spawnLoc);
    playsoundatposition("zmb_bolt", spawnLoc);
    monkey magic_bullet_shield();
    monkey disable_pain();
    monkey thread maps\_zombiemode_ai_monkey::monkey_zombie_choose_run();
    monkey thread monkey_powerup_timeout();
    monkey thread monkey_protect_player(self);
  }
}

monkey_powerup_timeout() {
  wait(60.0);
  self.timeout = true;
  while(self.attacking_zombie) {
    wait(0.1);
  }
  if(isDefined(self.zombie)) {
    self.zombie.monkey_claimed = false;
  }
  PlayFX(level._effect["monkey_death"], self.origin);
  playsoundatposition("zmb_bolt", self.origin);
  self notify("timeout");
  self Delete();
}

monkey_protect_player(player) {
  self endon("timeout");
  wait(0.5);
  while(true) {
    if(isDefined(self.timeout) && self.timeout) {
      self waittill("forever");
    }
    zombie = player _ent_GetBestZombie();
    if(isDefined(zombie)) {
      self thread monkey_attack_zombie(zombie);
      self waittill_any("bad_path", "zombie_killed");
      if(isDefined(zombie)) {
        zombie.monkey_claimed = false;
      }
    } else {
      goalDist = 64;
      checkDist2 = goalDist * goalDist;
      dist2 = distanceSquared(self.origin, player.origin);
      if(dist2 > checkDist2) {
        self.goalradius = goalDist;
        self SetGoalEntity(player);
        self waittill("goal");
        self SetGoalPos(self.origin);
      }
    }
    wait(0.5);
  }
}

#using_animtree("generic_human");
monkey_attack_zombie(zombie) {
  self endon("bad_path");
  self endon("timeout");
  self.zombie = zombie;
  zombie.monkey_claimed = true;
  self.goalradius = 32;
  self SetGoalPos(zombie.origin);
  checkDist2 = self.goalradius * self.goalradius;
  while(true) {
    if(!isDefined(zombie) || !IsAlive(zombie)) {
      self notify("zombie_killed");
      return;
    }
    dist2 = distanceSquared(zombie.origin, self.origin);
    if(dist2 < checkDist2) {
      break;
    }
    self SetGoalPos(zombie.origin);
    wait_network_frame();
  }
  self.attacking_zombie = true;
  zombie_anim = % ai_zombie_taunts_9;
  zombie notify("stop_find_flesh");
  zombie animscripted("zombie_react", zombie.origin, zombie.angles, zombie_anim, "normal", % body, 1, 0.2);
  forward = AnglesToForward(zombie.angles);
  perk_attack_anim = % ai_zombie_monkey_attack_perks_front;
  time = getAnimLength(perk_attack_anim);
  self maps\_zombiemode_audio::do_zombies_playvocals("attack", "monkey_zombie");
  self animscripted("perk_attack_anim", zombie.origin + forward * 35.0, zombie.angles - (0, 180, 0), perk_attack_anim, "normal", % body, 1, 0.2);
  wait(time);
  self.attacking_zombie = false;
  if(isDefined(zombie)) {
    zombie.no_powerups = true;
    zombie.a.gib_ref = "head";
    zombie dodamage(zombie.health + 666, zombie.origin);
    players = GetPlayers();
    for(i = 0; i < players.size; i++) {
      players[i] maps\_zombiemode_score::player_add_points("nuke_powerup", 20);
    }
  }
  self.zombie = undefined;
  self notify("zombie_killed");
}

_ent_GetBestZombie(minDist) {
  bestZombie = undefined;
  bestDist = 0.0;
  zombies = GetAiSpeciesArray("axis", "all");
  if(isDefined(minDist)) {
    bestDist = minDist * minDist;
  } else {
    bestDist = 99999999.0;
  }
  for(i = 0; i < zombies.size; i++) {
    z = zombies[i];
    if(isDefined(z.monkey_claimed) && z.monkey_claimed) {
      continue;
    }
    if((isDefined(z.animname) && z.animname == "monkey_zombie")) {
      continue;
    }
    if(z.classname == "actor_zombie_napalm" || z.classname == "actor_zombie_sonic") {
      continue;
    }
    dist2 = distanceSquared(z.origin, self.origin);
    if(dist2 < bestDist) {
      valid = z _ent_InPlayableArea();
      if(valid) {
        bestZombie = z;
        bestDist = dist2;
      }
    }
  }
  return bestZombie;
}

_ent_InPlayableArea() {
  for(i = 0; i < level.playable_area.size; i++) {
    if(self IsTouching(level.playable_area[i])) {
      return true;
    }
  }
  return false;
}