/******************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_instinct.gsc
******************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;

CONST_MAX_ACTIVE_KILLSTREAK_DOGS_PER_GAME = 3;
CONST_MAX_ACTIVE_KILLSTREAK_DOGS_PER_PLAYER = 3;
CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER = 3;
CONST_DOG_KILL_COUNT_LIMIT = 2;
CONST_STREAK_TIMEOUT = 60;
CONST_STREAK_RETREAT_TIMEOUT = 20;

init() {
  level.killstreakFuncs["mp_instinct"] = ::tryUseMPInstinct;
  level.mapKillStreak = "mp_instinct";

  level.InstinctDogs = [];

  PreCacheModel("animal_iw6_dog_a");

  level.killstreakWieldWeapons["killstreak_instinct_mp"] = "mp_instinct";

  level.InstinctDogSpawnPoints = [];

  SpawnPoints = GetNodeArray("InstinctDogSpawnPoint", "targetname");

  foreach(point in SpawnPoints) {
    tempPoint = spawnStruct();
    tempPoint.SpawnPoint = point;
    tempPoint.Weight = 0;

    level.InstinctDogSpawnPoints = add_to_array(level.InstinctDogSpawnPoints, tempPoint);
  }

  OnPlayerConnect();
}

tryUseMPInstinct(lifeId, streakName) {
  return spawnInstinctDogs();
}

setMPInstinctPlayer(player) {
  level.mp_instinct_owner = player;

  thread teamPlayerCardSplash("used_mp_instinct", player);

  return true;
}

OnPlayerConnect() {
  connectCount = 0;
  for(;;) {
    level waittill("connected", player);

    if(connectCount == 0) {
      if(!isDefined(level.isHorde) || !level.isHorde) {
        level.agent_funcs["dog"]["think"] = maps\mp\agents\dog\_instinct_dog_think::main;
        level.agent_funcs["dog"]["on_killed"] = ::on_agent_dog_killed;
      }
    }

    connectCount++;
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  self waittill("spawned_player");

  self thread MonitorKills();
}

spawnInstinctDogs() {
  if(getNumActiveAgents("dog") >= CONST_MAX_ACTIVE_KILLSTREAK_DOGS_PER_GAME) {
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_DOGS");
    return false;
  }

  if(getNumOwnedActiveAgentsByType(self, "dog") >= CONST_MAX_ACTIVE_KILLSTREAK_DOGS_PER_PLAYER) {
    self iPrintLnBold(&"KILLSTREAKS_ALREADY_HAVE_DOG");
    return false;
  }

  if(getNumOwnedActiveAgents(self) >= CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER) {
    self iPrintLnBold(&"KILLSTREAKS_AGENT_MAX");
    return false;
  }

  maxagents = GetMaxAgents();
  if(getNumActiveAgents() >= maxagents) {
    self iPrintLnBold(&"KILLSTREAKS_UNAVAILABLE");
    return false;
  }

  if(!isReallyAlive(self)) {
    return false;
  }

  ConnectAndSpawnInstinctDogPack();

  return true;
}

SortInstinctDogSpawnPoints() {
  foreach(point in level.InstinctDogSpawnPoints) {
    point.Weight = 0;

    tempDistance = Distance(point.SpawnPoint.origin, self.origin);
    if(tempDistance < 1500) {
      point.Weight = 1;
    } else if(tempDistance > 1500 && tempDistance < 2000) {
      point.Weight = 2;
    } else if(tempDistance > 2000 && tempDistance < 2500) {
      point.Weight = 3;
    } else if(tempDistance > 2500) {
      point.Weight = 4;
    }

    foreach(player in level.players) {
      start_pos = point.SpawnPoint.origin;
      target_pos = player.origin;
      LineOfSightCheck = SightTracePassed(start_pos, target_pos, false, player);

      if(LineOfSightCheck) {
        point.Weight--;
      }

      tempDistance = Distance(point.SpawnPoint.origin, player.origin);
      if(tempDistance < 256) {
        point.Weight--;
      }
    }
  }

  level.InstinctDogSpawnPoints = array_sort_with_func(level.InstinctDogSpawnPoints, ::isPointAScoredHigherThanB);
}

PickInstinctDogSpawnPoint() {
  SpawnPoint = level.InstinctDogSpawnPoints[0];

  level.InstinctDogSpawnPoints = array_remove(level.InstinctDogSpawnPoints, level.InstinctDogSpawnPoints[0]);

  return SpawnPoint;
}

isPointAScoredHigherThanB(a, b) {
  return (a.Weight > b.Weight);
}

WaitForTimeout() {
  self waittill_any_timeout(CONST_STREAK_TIMEOUT, "KillCountMet");
  self notify("retreat");
  DeleteNodes = GetNodeArray("DeletePoint", "targetname");
  Node = getClosest(self.origin, DeleteNodes);
  self notify("timeoutRetreat");
  self ScrAgentSetGoalPos(Node.origin);

  self waittill_any_timeout(CONST_STREAK_RETREAT_TIMEOUT, "stop_soon");

  self Suicide();
  self notify("death");
}

ConnectAndSpawnInstinctDogPack() {
  SortInstinctDogSpawnPoints();
  for(i = 0; i < 3; i++) {
    nearestPathNode = self PickInstinctDogSpawnPoint();

    if(!isDefined(nearestPathNode)) {
      return false;
    }

    agent = maps\mp\agents\_agent_common::connectNewAgent("dog", self.team);
    if(!isDefined(agent)) {
      return false;
    }

    oldHealth = self.health;
    newHealth = 25;
    self.agenthealth = newHealth;
    self.health = newHealth;
    self.maxhealth = newHealth;

    level.InstinctDogs = array_add(level.InstinctDogs, agent);

    agent thread WaitForDeath(nearestPathNode);

    agent set_agent_team(self.team, self);

    spawnOrigin = nearestPathNode.SpawnPoint.origin;
    spawnAngles = VectorToAngles(self.origin - nearestPathNode.SpawnPoint.origin);

    agent thread[[agent agentFunc("spawn")]](spawnOrigin, spawnAngles, self);

    if(isDefined(self.ballDrone) && self.ballDrone.ballDroneType == "ball_drone_backup") {
      self maps\mp\gametypes\_missions::processChallenge("ch_twiceasdeadly");
    }

    agent thread WaitForTimeout();
  }
}

WaitForDeath(PathNode) {
  self waittill_any("death", "retreat");
  level.InstinctDogSpawnPoints = array_add(level.InstinctDogSpawnPoints, PathNode);
  level.InstinctDogs = array_remove(level.InstinctDogs, self);
}

MonitorKills() {
  while(true) {
    self waittill("death", instigator);

    foreach(dog in level.InstinctDogs) {
      if(instigator == dog) {
        if(!isDefined(dog.EnemyKills)) {
          dog.EnemyKills = 0;
        }

        dog.EnemyKills++;

        if(dog.EnemyKills >= CONST_DOG_KILL_COUNT_LIMIT) {
          dog notify("KillCountMet");
        }
      }
    }
  }
}

on_agent_dog_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self.isActive = false;
  self.hasDied = false;

  eAttacker.lastKillDogTime = GetTime();

  if(isDefined(self.animCBs.OnExit[self.aiState])) {
    self[[self.animCBs.OnExit[self.aiState]]]();
  }

  if(isPlayer(eAttacker) && isDefined(self.owner) && (eAttacker != self.owner)) {
    self.owner leaderDialogOnPlayer("dog_kia_mp_instinct");
    self maps\mp\gametypes\_damage::onKillstreakKilled(eAttacker, sWeapon, sMeansOfDeath, iDamage, "destroyed_guard_dog");

    if(IsPlayer(eAttacker)) {
      eAttacker maps\mp\gametypes\_missions::processChallenge("ch_notsobestfriend");

      if(!self IsOnGround()) {
        eAttacker maps\mp\gametypes\_missions::processChallenge("ch_hoopla");
      }
    }
  }

  self SetAnimState("death");
  animEntry = self GetAnimEntry();
  animLength = GetAnimLength(animEntry);

  deathAnimDuration = int(animLength * 1000);

  self.body = self CloneAgent(deathAnimDuration);

  self playSound("anml_dog_shot_death");

  self maps\mp\agents\_agent_utility::deactivateAgent();

  self notify("killanimscript");
}