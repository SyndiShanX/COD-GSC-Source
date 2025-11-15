/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_powerups.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_ai_monkey;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\zm_temple_ai_monkey;
#using scripts\zm\zm_temple_sq;
#using scripts\zm\zm_temple_sq_brock;
#namespace zm_temple_powerups;

function init() {
  level._zombiemode_special_powerup_setup = & temple_special_powerup_setup;
  level._zombiemode_powerup_grab = & temple_powerup_grab;
  zm_powerups::add_zombie_powerup("monkey_swarm", "zombie_pickup_monkey", & "ZOMBIE_POWERUP_MONKEY_SWARM");
  level.playable_area = getEntArray("player_volume", "script_noteworthy");
  level._effect["zombie_kill"] = "impacts/fx_flesh_hit_body_fatal_lg_exit_mp";
}

function temple_special_powerup_setup(powerup) {
  return true;
}

function temple_powerup_grab(powerup) {
  if(!isDefined(powerup)) {
    return;
  }
  switch (powerup.powerup_name) {
    case "monkey_swarm": {
      level thread monkey_swarm(powerup);
      break;
    }
    default: {
      break;
    }
  }
}

function monkey_swarm(powerup) {
  monkey_count_per_player = 2;
  level flag::clear("spawn_zombies");
  players = getplayers();
  level.monkeys_left_to_spawn = players.size * monkey_count_per_player;
  for(i = 0; i < players.size; i++) {
    players[i] thread player_monkey_think(monkey_count_per_player);
  }
  while(level.monkeys_left_to_spawn > 0) {
    util::wait_network_frame();
  }
  level flag::set("spawn_zombies");
}

function player_monkey_think(nummonkeys) {
  spawns = getEntArray("monkey_zombie_spawner", "targetname");
  if(spawns.size == 0) {
    level.monkeys_left_to_spawn = level.monkeys_left_to_spawn - nummonkeys;
    return;
  }
  spawnradius = 10;
  zoneoverride = undefined;
  if(isDefined(self.is_on_waterslide) && self.is_on_waterslide) {
    zoneoverride = "caves1_zone";
  } else if(isDefined(self.is_on_minecart) && self.is_on_minecart) {
    zoneoverride = "waterfall_lower_zone";
  }
  barriers = self zm_temple_ai_monkey::ent_gathervalidbarriers(zoneoverride);
  println("" + nummonkeys);
  for(i = 0; i < nummonkeys; i++) {
    wait(randomfloatrange(1, 2));
    zombie = self _ent_getbestzombie(300);
    if(!isDefined(zombie)) {
      zombie = self _ent_getbestzombie();
    }
    bloodfx = 0;
    angles = (0, randomfloat(360), 0);
    forward = anglesToForward(angles);
    spawnloc = self.origin + (spawnradius * forward);
    spawnangles = self.angles;
    if(isDefined(zombie)) {
      spawnloc = zombie.origin + vectorscale((0, 0, 1), 50);
      spawnangles = zombie.angles;
      zombie delete();
      level.zombie_total++;
      bloodfx = 1;
    } else if(barriers.size > 0) {
      best = undefined;
      bestdist = 0;
      for(b = 0; b < barriers.size; b++) {
        barrier = barriers[b];
        dist2 = distancesquared(barrier.origin, self.origin);
        if(!isDefined(best) || dist2 < bestdist) {
          best = barrier;
          bestdist = dist2;
        }
      }
      spawnloc = zm_temple_ai_monkey::getbarrierattacklocation(best);
      spawnangles = best.angles;
    }
    level.monkeys_left_to_spawn--;
    println("");
    monkey = zombie_utility::spawn_zombie(spawns[i]);
    if(spawner::spawn_failed(monkey)) {
      println("");
      continue;
    }
    spawns[i].count = 100;
    spawns[i].last_spawn_time = gettime();
    monkey.attacking_zombie = 0;
    monkey.no_shrink = 1;
    monkey setplayercollision(0);
    monkey zm_ai_monkey::monkey_prespawn();
    monkey forceteleport(spawnloc, spawnangles);
    if(bloodfx) {
      playFX(level._effect["zombie_kill"], spawnloc);
    }
    playFX(level._effect["monkey_death"], spawnloc);
    playsoundatposition("zmb_bolt", spawnloc);
    monkey util::magic_bullet_shield();
    monkey.allowpain = 0;
    monkey thread zm_ai_monkey::monkey_zombie_choose_run();
    monkey thread monkey_powerup_timeout();
    monkey thread monkey_protect_player(self);
  }
}

function monkey_powerup_timeout() {
  wait(60);
  self.timeout = 1;
  while(self.attacking_zombie) {
    wait(0.1);
  }
  if(isDefined(self.zombie)) {
    self.zombie.monkey_claimed = 0;
  }
  playFX(level._effect["monkey_death"], self.origin);
  playsoundatposition("zmb_bolt", self.origin);
  self notify("timeout");
  self delete();
}

function monkey_protect_player(player) {
  self endon("timeout");
  wait(0.5);
  while(true) {
    if(isDefined(self.timeout) && self.timeout) {
      self waittill("forever");
    }
    zombie = player _ent_getbestzombie();
    if(isDefined(zombie)) {
      self thread monkey_attack_zombie(zombie);
      self util::waittill_any("bad_path", "zombie_killed");
      if(isDefined(zombie)) {
        zombie.monkey_claimed = 0;
      }
    } else {
      goaldist = 64;
      checkdist2 = goaldist * goaldist;
      dist2 = distancesquared(self.origin, player.origin);
      if(dist2 > checkdist2) {
        self.goalradius = goaldist;
        self setgoalentity(player);
        self waittill("goal");
        self setgoalpos(self.origin);
      }
    }
    wait(0.5);
  }
}

function monkey_attack_zombie(zombie) {
  self endon("bad_path");
  self endon("timeout");
  self.zombie = zombie;
  zombie.monkey_claimed = 1;
  self.goalradius = 32;
  self setgoalpos(zombie.origin);
  checkdist2 = self.goalradius * self.goalradius;
  while(true) {
    if(!isDefined(zombie) || !isalive(zombie)) {
      self notify("zombie_killed");
      return;
    }
    dist2 = distancesquared(zombie.origin, self.origin);
    if(dist2 < checkdist2) {
      break;
    }
    self setgoalpos(zombie.origin);
    util::wait_network_frame();
  }
  self.attacking_zombie = 1;
  zombie notify("stop_find_flesh");
  forward = anglesToForward(zombie.angles);
  self.attacking_zombie = 0;
  if(isDefined(zombie)) {
    zombie.no_powerups = 1;
    zombie.a.gib_ref = "head";
    zombie dodamage(zombie.health + 666, zombie.origin);
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      players[i] zm_score::player_add_points("nuke_powerup", 20);
    }
  }
  self.zombie = undefined;
  self notify("zombie_killed");
}

function _ent_getbestzombie(mindist) {
  bestzombie = undefined;
  bestdist = 0;
  zombies = getaispeciesarray("axis", "all");
  if(isDefined(mindist)) {
    bestdist = mindist * mindist;
  } else {
    bestdist = 1E+08;
  }
  for(i = 0; i < zombies.size; i++) {
    z = zombies[i];
    if(isDefined(z.monkey_claimed) && z.monkey_claimed) {
      continue;
    }
    if(isDefined(z.animname) && z.animname == "monkey_zombie") {
      continue;
    }
    if(z.classname == "actor_zombie_napalm" || z.classname == "actor_zombie_sonic") {
      continue;
    }
    dist2 = distancesquared(z.origin, self.origin);
    if(dist2 < bestdist) {
      valid = z _ent_inplayablearea();
      if(valid) {
        bestzombie = z;
        bestdist = dist2;
      }
    }
  }
  return bestzombie;
}

function _ent_inplayablearea() {
  for(i = 0; i < level.playable_area.size; i++) {
    if(self istouching(level.playable_area[i])) {
      return true;
    }
  }
  return false;
}