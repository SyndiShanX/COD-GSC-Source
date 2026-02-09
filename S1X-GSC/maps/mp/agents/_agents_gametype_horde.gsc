/*****************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_horde.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;
#include maps\mp\gametypes\_damage;
#include maps\mp\gametypes\_horde_util;
#include maps\mp\gametypes\_horde_crates;
#include maps\mp\gametypes\_horde_drones;
#include maps\mp\agents\_agent_utility;

CONST_DISABLE_SPAWNING = false;
CONST_FORCE_DOG_SPAWN = false;
CONST_FORCE_DRONE_SPAWN = false;
CONST_FORCE_PLAYER_ENEMY_SPAWN = false;
CONST_DISABLE_AUTO_AI_REMOVAL = false;

main() {
  setup_callbacks();
  level thread runRoundSpawning();

  if(getMapName() == "mp_detroit") {
    level.goliathExploitTrigger = spawn("trigger_radius", (-1662, -72, 582.5), 0, 86, 64);
  }
}

setup_callbacks() {
  level.agent_funcs["player"]["onAIConnect"] = ::onAIConnect;
  level.agent_funcs["player"]["think"] = ::enemyAgentThink;
  level.agent_funcs["player"]["on_killed"] = ::onAgentKilled;

  level.agent_funcs["squadmate"]["onAIConnect"] = ::onAIConnect;
  level.agent_funcs["squadmate"]["think"] = ::allyAgentThink;

  level.agent_funcs["dog"]["onAIConnect"] = ::onAIConnect;
  level.agent_funcs["dog"]["think"] = ::agentDogThink;
  level.agent_funcs["dog"]["on_killed"] = ::onDogKilled;
}

onAIConnect() {
  self.gameModefirstSpawn = true;
  self.agentname = &"HORDE_GRUNT";
  self.horde_type = "";
}

runRoundSpawning() {
  level endon("game_ended");

  while(true) {
    level waittill("start_round");

    if(CONST_DISABLE_SPAWNING) {
      continue;
    }

    wait 2;

    if(getMapName() == "mp_prison_z" && level.currentRoundNumber > 10) {
      runZombieRound();
    } else {
      runNormalRound();
    }
  }
}

runNormalRound() {
  level childthread highlightLastEnemies();

  while(level.currentEnemyCount < level.maxEnemyCount) {
    while(level.currentAliveEnemyCount < level.maxAliveEnemyCount) {
      createEnemy();

      if(level.currentEnemyCount == level.maxEnemyCount) {
        break;
      }
    }

    level.waveFirstSpawn = false;

    level waittill("enemy_death");
  }
}

runZombieRound() {
  level.zombiesDead = 0;
  level waittill("beginZombieSpawn");

  while(level.currentEnemyCount < level.maxEnemyCount) {
    while(level.currentAliveEnemyCount < level.maxAliveEnemyCount) {
      createEnemy();
      wait 0.1;
    }

    level.waveFirstSpawn = false;

    level waittill_any("enemy_death", "go_zombie");

    level.zombiesDead++;
  }
}

createEnemy() {
  if(CONST_FORCE_DOG_SPAWN) {
    createDogEnemy();
    return;
  }

  if(CONST_FORCE_PLAYER_ENEMY_SPAWN) {
    createHumanoidEnemy();
    return;
  }

  if(CONST_FORCE_DRONE_SPAWN) {
    createDroneEnemy();
    return;
  }

  if(level.maxDogCount > 1 && level.dogsAlive < level.maxDogCount) {
    createDogEnemy();
  } else {
    if(level.maxWarbirdCount > 0) {
      foreach(player in level.players) {
        if(isOnHumanTeam(player) && IsAlive(player)) {
          player createWarbirdEnemy();
          level.maxWarbirdCount--;
          break;
        }
      }
    } else if(level.maxDroneCount > 0) {
      createDroneEnemy();
      level.maxDroneCount--;
    } else {
      createHumanoidEnemy();
    }
  }
}

createHumanoidEnemy() {
  agent = undefined;

  while(!isDefined(agent)) {
    agent = maps\mp\agents\_agents::add_humanoid_agent("player", level.enemyTeam, "class1");

    if(isDefined(agent)) {
      level.currentEnemyCount++;
      level.currentAliveEnemyCount++;
    }

    waitframe();
  }
}

createDogEnemy() {
  agent = undefined;

  while(!isDefined(agent)) {
    agent = maps\mp\agents\_agent_common::connectNewAgent("dog", level.enemyTeam);
    if(isDefined(agent)) {
      agent thread[[agent agentFunc("spawn")]]();
      agent.awardpoints = 100;
      level.currentEnemyCount++;
      level.currentAliveEnemyCount++;
      level.dogsAlive++;
    }
    waitframe();
  }
}

createDroneEnemy() {
  thread waitingToSpawnDrone();

  level.currentEnemyCount++;
  level.currentAliveEnemyCount++;
}

waitingToSpawnDrone() {
  level.numDronesWaitingToSpawn++;

  while(currentActiveVehicleCount(2) >= maxVehiclesAllowed()) {
    wait 1;
  }

  level.numDronesWaitingToSpawn--;

  waitframe();
  drone = hordeCreateDrone(level.players[0], "assault_uav_horde", level.hordeDroneModel);

  drone HudOutlineEnable(level.enemyOutlineColor, true);
  drone.droneturret HudOutlineEnable(level.enemyOutlineColor, true);
  drone.outlineColor = level.enemyOutlineColor;
}

createWarbirdEnemy() {
  self thread maps\mp\gametypes\_horde_warbird::hordeCreateWarbird();
}

playAISpawnEffect() {
  playFX(level._effect["spawn_effect"], self.origin);
}

highlightLastEnemies() {
  level endon("round_ended");

  while(true) {
    level waittill("enemy_death");

    if(level.currentEnemyCount != level.maxEnemyCount) {
      continue;
    }

    if(level.currentAliveEnemyCount < 3) {
      foreach(drone in level.flying_attack_drones) {
        drone HudOutlineEnable(level.enemyOutlineColor, false);
        drone.droneTurret HudOutlineEnable(level.enemyOutlineColor, false);
        drone.lastTwoEnemies = true;
      }
      foreach(player in level.characters) {
        if(isOnHumanTeam(player)) {
          continue;
        }

        if(isReallyAlive(player) && !player IsCloaked()) {
          player HudOutlineEnable(level.enemyOutlineColor, false);
          player.outlineColor = level.enemyOutlineColor;
        }
      }
      setDvar("bg_compassShowEnemies", 1);

      break;
    }
  }
}

onAgentKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  if(!isOnHumanTeam(self)) {
    self hordeEnemyKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
  }

  self HudOutlineDisable();
  self maps\mp\agents\_agents::on_humanoid_agent_killed_common(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration, false);
  self maps\mp\agents\_agent_utility::deactivateAgent();
}

onDogKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  if(!isOnHumanTeam(self)) {
    self hordeEnemyKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
  }

  self HudOutlineDisable();
  self maps\mp\killstreaks\_dog_killstreak::on_agent_dog_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

hordeEnemyKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  AssertEx((level.currentAliveEnemyCount > 0), "currentAliveEnemyCount is below zero");

  level.currentAliveEnemyCount--;
  level.killsSinceIntelDrop++;
  level.killsSinceAmmoDrop++;

  if(level.objDefend) {
    maps\mp\gametypes\horde::checkDefendKill(self, eAttacker);
  }

  trackIntelKills(sWeapon, sMeansOfDeath);

  level thread maps\mp\gametypes\horde::chanceToSpawnPickup(self);
  level notify("enemy_death", eAttacker, self);

  level.enemiesLeft--;
  if(!level.zombiesStarted) {
    SetOmnvar("ui_horde_enemies_left", level.enemiesLeft);
  }

  if(isPlayer(eAttacker) && !level.zombiesStarted) {
    awardHordeKill(eAttacker);
    eAttacker thread maps\mp\gametypes\_rank::xpPointsPopup("kill", self.awardPoints);
    level thread hordeUpdateScore(eAttacker, self.awardPoints);

    if(eAttacker _hasPerk("specialty_triggerhappy")) {}
  }

  if(isDefined(eAttacker) && isDefined(eAttacker.owner) && isPlayer(eAttacker.owner) && isDefined(eAttacker.owner.killz)) {
    awardHordeKill(eAttacker.owner);
    eAttacker.owner thread maps\mp\gametypes\_rank::xpPointsPopup("kill", self.awardPoints);
    level thread hordeUpdateScore(eAttacker.owner, self.awardPoints);
  }
}

trackIntelKills(sWeapon, sMeansOfDeath) {
  if(level.isTeamIntelComplete) {
    return;
  }

  if(sWeapon == "none") {
    return;
  }

  if(isMeleeMOD(sMeansOfDeath)) {
    level.numMeleeKillsIntel++;
  }

  if(!isKillstreakWeapon(sWeapon) && (sMeansOfDeath == "MOD_HEAD_SHOT")) {
    level.numHeadShotsIntel++;
  }

  if(isKillstreakWeapon(sWeapon) && (sWeapon != level.intelMiniGun)) {
    level.numKillStreakKillsIntel++;
  }

  if(maps\mp\gametypes\_class::isValidEquipment(sWeapon, false) || maps\mp\gametypes\_class::isValidOffhand(sWeapon, false)) {
    level.numEquipmentKillsIntel++;
  }
}

enemyAgentThink() {
  selfendon("death");
  level endon("game_ended");

  self BotSetFlag("no_enemy_search", true);

  self thread monitorBadHumanoidAI();
  self thread locateEnemyPositions();
}

monitorBadHumanoidAI() {
  if(CONST_DISABLE_AUTO_AI_REMOVAL) {
    return;
  }

  selfendon("death");
  level endon("game_ended");

  spawnTime = GetTime();

  while(true) {
    wait(5.0);

    if(!bot_in_combat(120 * 1000)) {
      if(!bot_in_combat(240 * 1000)) {
        break;
      }
    }

    if(checkExpireTime(spawnTime, 240, 480)) {
      break;
    }
  }

}

monitorBadDogAI() {
  if(CONST_DISABLE_AUTO_AI_REMOVAL) {
    return;
  }

  selfendon("death");
  level endon("game_ended");

  spawnTime = GetTime();
  lastPosition = self.origin;
  lastPositionTime = spawnTime;

  while(true) {
    wait(5.0);

    positionDelta = DistanceSquared(self.origin, lastPosition);
    positionTime = (GetTime() - lastPositionTime) / 1000;

    if(positionDelta > (128 * 128)) {
      lastPosition = self.origin;
      lastPositionTime = GetTime();
    } else if(positionTime > 25) {
      if(positionTime > 55) {
        break;
      }
    }

    if(checkExpireTime(spawnTime, 120, 240)) {
      break;
    }
  }
  killAgent(self);
}

checkExpireTime(spawnTime, highLightTime, expireTime) {
  aliveTime = (GetTime() - spawnTime) / 1000;

  if(aliveTime > highLightTime) {
    if(aliveTime > expireTime) {
      return true;
    }
  }

  return false;
}

SCR_CONST_ALLY_AGENT_LOW_HEALTH_BEHAVIOR = 0.6;
SCR_CONST_PLAYER_LOW_HEALTH_BEHAVIOR = 0.5;

allyAgentThink() {
  selfendon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  self BotSetFlag("force_sprint", true);
  holding_till_health_regen = false;
  next_time_protect_player = 0;

  while(1) {
    if(float(self.owner.health) / self.owner.maxhealth < SCR_CONST_PLAYER_LOW_HEALTH_BEHAVIOR && GetTime() > next_time_protect_player) {
      nodes = GetNodesInRadiusSorted(self.owner.origin, 256, 0);
      if(nodes.size >= 2) {
        self.defense_force_next_node_goal = nodes[1];
        self notify("defend_force_node_recalculation");
        next_time_protect_player = GetTime() + 1000;
      }
    } else if(float(self.health) / self.maxhealth >= SCR_CONST_ALLY_AGENT_LOW_HEALTH_BEHAVIOR) {
      holding_till_health_regen = false;
    } else if(!holding_till_health_regen) {
      node = self bot_find_node_to_guard_player(self.owner.origin, 350, true);
      if(isDefined(node)) {
        self.defense_force_next_node_goal = node;
        self notify("defend_force_node_recalculation");

        holding_till_health_regen = true;
      }
    }

    if(!self bot_is_guarding_player(self.owner)) {
      optional_params["override_goal_type"] = "critical";
      optional_params["min_goal_time"] = 20;
      optional_params["max_goal_time"] = 30;
      self bot_guard_player(self.owner, 350, optional_params);
    }

    wait(0.05);
  }
}

hordeSetupDogState() {
  self.enableExtendedKill = false;
  self.agentname = &"HORDE_QUAD";
  self.horde_type = "Quad";
  self thread maps\mp\gametypes\horde::hordeApplyAIModifiers();

  self.lasSetGoalPos = (0, 0, 0);
  self.bHasNoPath = false;
  self.randomPathStopTime = 0;

  self.maxhealth = 60;
  self.health = self.maxhealth;
}

agentDogThink() {
  selfendon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  self maps\mp\agents\dog\_dog_think::setupDogState();
  self hordeSetupDogState();

  self thread locateEnemyPositions();
  self thread[[self.watchAttackStateFunc]]();
  self thread WaitForBadPathHorde();
  self thread monitorBadDogAI();
  self thread agentDogBark();

  self thread maps\mp\agents\dog\_dog_think::debug_dog();

  while(true) {
    if(self maps\mp\agents\dog\_dog_think::ProcessDebugMode()) {
      continue;
    }

    if(self.aiState != "melee" && !self.stateLocked && self maps\mp\agents\dog\_dog_think::readyToMeleeTarget() && !self maps\mp\agents\dog\_dog_think::DidPastMeleeFail()) {
      self ScrAgentBeginMelee(self.curMeleeTarget);
    }

    if(self.randomPathStopTime > GetTime()) {
      wait(0.05);
      continue;
    }

    if(!isDefined(self.enemy) || self.bHasNoPath) {
      pathNodes = GetNodesInRadiusSorted(self.origin, 1024, 256, 128, "Path");

      if(pathNodes.size > 0) {
        nodeNum = RandomIntRange(int(pathNodes.size * 0.9), pathNodes.size);
        self ScrAgentSetGoalPos(pathNodes[nodeNum].origin);
        self.bHasNoPath = false;
        self.randomPathStopTime = GetTime() + 2500;
      }
    } else {
      attackPoint = self maps\mp\agents\dog\_dog_think::GetAttackPoint(self.enemy);
      self.curMeleeTarget = self.enemy;
      self.moveMode = "sprint";
      self.bArrivalsEnabled = false;

      if(DistanceSquared(attackPoint, self.lasSetGoalPos) > (64 * 64)) {
        self ScrAgentSetGoalPos(attackPoint);
        self.lasSetGoalPos = attackPoint;
      }
    }

    wait(0.05);
  }
}

agentDogBark() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    while(!isDefined(self.curmeleetarget)) {
      wait 0.25;
    }

    while(isDefined(self.curMeleeTarget) && distance(self.origin, self.curMeleeTarget.origin) > 200) {
      wait randomfloatrange(0, 2);
      self playSound("anml_doberman_bark");
    }
    wait 0.05;
  }
}

WaitForBadPathHorde() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("bad_path", badGoalPos);
    self.bHasNoPath = true;
  }
}

locateEnemyPositions() {
  selfendon("death");
  level endon("game_ended");

  while(true) {
    foreach(player in level.participants) {
      if(isOnHumanTeam(player)) {
        self GetEnemyInfo(player);
        if(isDefined(player.hordeDrone)) {
          self GetEnemyInfo(player.hordeDrone);
        }
      }
    }

    wait(0.5);
  }
}

findClosestPlayer() {
  closestPlayer = undefined;
  closestDistance = 100000 * 100000;

  foreach(player in level.players) {
    if(isReallyAlive(player) && isOnHumanTeam(player) && !isPlayerInLastStand(player)) {
      distSquared = DistanceSquared(player.origin, self.origin);

      if(distSquared < closestDistance) {
        closestPlayer = player;
        closestDistance = distSquared;
      }
    }
  }

  return closestPlayer;
}

handleDetroitGoliathTrailerExploit() {
  self endon("death");
  level endon("game_ended");

  wait 1;

  while(true) {
    if(isDefined(self.enemy) && self.enemy IsTouching(level.goliathExploitTrigger)) {
      self BotSetScriptGoal((-1696, -408, 608.5), 32, "critical", 200);

      while(isDefined(self.enemy) && isReallyAlive(self.enemy) && !isPlayerInLastStand(self.enemy) && self.enemy istouching(level.goliathExploitTrigger)) {
        wait 0.25;
      }

      self BotClearScriptGoal();
    }

    wait 1;
  }
}