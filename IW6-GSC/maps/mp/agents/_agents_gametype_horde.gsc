/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_horde.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\gametypes\_damage;
#include maps\mp\gametypes\_horde_util;
#include maps\mp\gametypes\_horde_crates;
#include maps\mp\agents\_agent_utility;

CONST_FORCE_DOG_SPAWN = false;
CONST_FORCE_PLAYER_ENEMY_SPAWN = false;
CONST_DISABLE_AUTO_AI_REMOVAL = false;

main() {
  setup_callbacks();
  level thread runRoundSpawning();
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
  self.agentname = &"HORDE_INFECTED";
  self.horde_type = "";
}

runRoundSpawning() {
  level endon("game_ended");

  while(true) {
    level waittill("start_round");

    if(isSpecialRound()) {
      runSpecialRound();
    } else {
      runNormalRound();
    }
  }
}

runSpecialRound() {
  runLootDrop();
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

    level waittill("enemy_death");
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

  if(isDogRound() && (RandomIntRange(1, 101) < level.chanceToSpawnDog)) {
    createDogEnemy();
  } else {
    createHumanoidEnemy();
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

      level.currentEnemyCount++;
      level.currentAliveEnemyCount++;
    }

    waitframe();
  }
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
      foreach(player in level.characters) {
        if(isOnHumanTeam(player)) {
          continue;
        }
        if(isReallyAlive(player)) {
          player HudOutlineEnable(level.enemyOutlineColor, false);
          player.outlineColor = level.enemyOutlineColor;
        }
      }

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
  trackIntelKills(sWeapon, sMeansOfDeath);

  level thread maps\mp\gametypes\horde::chanceToSpawnPickup(self);
  level notify("enemy_death");

  if(IsPlayer(eAttacker)) {
    awardHordeKill(eAttacker);

    if(eAttacker _hasPerk("specialty_triggerhappy")) {
      eAttacker thread maps\mp\perks\_perkfunctions::setTriggerHappyInternal();
    }
  }

  if(isDefined(eAttacker) && isDefined(eAttacker.owner) && IsPlayer(eAttacker.owner) && isDefined(eAttacker.owner.killz)) {
    awardHordeKill(eAttacker.owner);
  }
}

trackIntelKills(sWeapon, sMeansOfDeath) {
  if(level.isTeamIntelComplete) {
    return;
  }
  if(sWeapon == "none") {
    return;
  }
  if(sMeansOfDeath == "MOD_MELEE") {
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
      outlineStuckAI(self);

      if(!bot_in_combat(240 * 1000)) {
        break;
      }
    }

    if(checkExpireTime(spawnTime, 240, 480)) {
      break;
    }
  }

  killAgent(self);
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
      outlineStuckAI(self);

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
    outlineStuckAI(self);

    if(aliveTime > expireTime) {
      return true;
    }
  }

  return false;
}

outlineStuckAI(agent) {
  agent HudOutlineEnable(level.enemyOutlineColor, false);
  agent.outlineColor = level.enemyOutlineColor;

  agent HudOutlineEnable(2, false);
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
  self _setNameplateMaterial("player_name_bg_green_dog", "player_name_bg_red_dog");
  self.enableExtendedKill = false;
  self.agentname = &"HORDE_QUAD";
  self.horde_type = "Quad";

  self.lasSetGoalPos = (0, 0, 0);
  self.bHasNoPath = false;
  self.randomPathStopTime = 0;

  maps\mp\gametypes\horde::setEnemyAgentHealth(self);
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