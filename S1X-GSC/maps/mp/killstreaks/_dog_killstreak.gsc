/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_dog_killstreak.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;

CONST_MAX_ACTIVE_KILLSTREAK_DOGS_PER_GAME = 5;
CONST_MAX_ACTIVE_KILLSTREAK_DOGS_PER_PLAYER = 1;
CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER = 2;

init() {
  PreCacheModel("animal_dobernan");

  level.killStreakFuncs["guard_dog"] = ::tryUseDog;
}

setup_callbacks() {
  level.agent_funcs["dog"] = level.agent_funcs["player"];

  level.agent_funcs["dog"]["spawn"] = ::spawn_dog;
  level.agent_funcs["dog"]["on_killed"] = ::on_agent_dog_killed;
  level.agent_funcs["dog"]["on_damaged"] = maps\mp\agents\_agents::on_agent_generic_damaged;
  level.agent_funcs["dog"]["on_damaged_finished"] = ::on_damaged_finished;
  level.agent_funcs["dog"]["think"] = maps\mp\agents\dog\_dog_think::main;

  level.killstreakWieldWeapons["agent_mp"] = "agent_mp";
}

tryUseDog(lifeId, streakName) {
  return useDog();
}

useDog() {
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

  nearestPathNode = self getValidSpawnPathNodeNearPlayer(true);
  if(!isDefined(nearestPathNode)) {
    return false;
  }

  agent = maps\mp\agents\_agent_common::connectNewAgent("dog", self.team);
  if(!isDefined(agent)) {
    return false;
  }

  agent set_agent_team(self.team, self);

  spawnOrigin = nearestPathNode.origin;
  spawnAngles = VectorToAngles(self.origin - nearestPathNode.origin);

  agent thread[[agent agentFunc("spawn")]](spawnOrigin, spawnAngles, self);

  agent _setNameplateMaterial("player_name_bg_green_dog", "player_name_bg_red_dog");

  if(isDefined(self.ballDrone) && self.ballDrone.ballDroneType == "ball_drone_backup") {
    self maps\mp\gametypes\_missions::processChallenge("ch_twiceasdeadly");
  }

  return true;
}

on_agent_dog_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self.isActive = false;
  self.hasDied = false;

  eAttacker.lastKillDogTime = GetTime();

  if(isDefined(self.animCBs.OnExit[self.aiState])) {
    self[[self.animCBs.OnExit[self.aiState]]]();
  }

  if(isPlayer(eAttacker) && isDefined(self.owner) && (eAttacker != self.owner)) {
    self.owner leaderDialogOnPlayer("dog_killed");
    self maps\mp\gametypes\_damage::onKillstreakKilled(eAttacker, sWeapon, sMeansOfDeath, iDamage, "destroyed_guard_dog");

    if(isPlayer(eAttacker)) {
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

  self playSound("anml_doberman_death");

  self maps\mp\agents\_agent_utility::deactivateAgent();

  self notify("killanimscript");
}

on_damaged_finished(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(!isDefined(self.playing_pain_sound)) {
    self thread play_pain_sound(2.5);
  }

  damageModified = iDamage;
  if(isDefined(sHitLoc) && sHitLoc == "head" && level.gametype != "horde") {
    damageModified = int(damageModified * 0.6);
    if(iDamage > 0 && damageModified <= 0) {
      damageModified = 1;
    }
  }

  if(self.health - damageModified > 0) {
    self maps\mp\agents\dog\_dog_think::OnDamage(eInflictor, eAttacker, damageModified, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
  }

  if(isPlayer(eAttacker)) {
    if(isDefined(self.attackState) && self.attackState != "attacking") {
      if(DistanceSquared(self.origin, eAttacker.origin) <= self.dogDamagedRadiusSq) {
        self.favoriteEnemy = eAttacker;
        self.forceAttack = true;
        self thread maps\mp\agents\dog\_dog_think::watchFavoriteEnemyDeath();
      }
    }
  }

  maps\mp\agents\_agents::agent_damage_finished(eInflictor, eAttacker, damageModified, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

play_pain_sound(delay) {
  self endon("death");

  self playSound("anml_doberman_pain");
  self.playing_pain_sound = true;
  wait(delay);
  self.playing_pain_sound = undefined;
}

spawn_dog(optional_spawnOrigin, optional_spawnAngles, optional_owner) {
  if(IsHairRunning()) {
    self setModel("animal_dobernan");
  } else {
    self setModel("animal_dobernan");
  }

  self.species = "dog";

  self.OnEnterAnimState = maps\mp\agents\dog\_dog_think::OnEnterAnimState;

  if(isDefined(optional_spawnOrigin) && isDefined(optional_spawnAngles)) {
    spawnOrigin = optional_spawnOrigin;
    spawnAngles = optional_spawnAngles;
  } else {
    spawnPoint = self[[level.getSpawnPoint]]();
    spawnOrigin = spawnpoint.origin;
    spawnAngles = spawnpoint.angles;
  }
  self activateAgent();
  self.spawnTime = GetTime();
  self.lastSpawnTime = GetTime();

  self maps\mp\agents\dog\_dog_think::init();

  self SpawnAgent(spawnOrigin, spawnAngles, "dog_animclass", 15, 40, optional_owner);
  level notify("spawned_agent", self);

  self maps\mp\agents\_agent_common::set_agent_health(250);

  if(isDefined(optional_owner)) {
    self set_agent_team(optional_owner.team, optional_owner);
  }

  self SetThreatBiasGroup("Dogs");

  self TakeAllWeapons();

  if(isDefined(self.owner)) {
    self Hide();
    wait(1.0);

    if(!IsAlive(self)) {
      return;
    }

    self Show();
    wait(0.1);
  }

  self thread[[self agentFunc("think")]]();

  wait(0.1);
  if(IsHairRunning()) {
    playFXOnTag(level.furFX, self, "tag_origin");
  }
}