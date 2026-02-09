/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\mp_wolfpack_killstreak.gsc
**********************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;

CONST_KILLSTREAK_NAME = "mine_level_killstreak";
CONST_WOLF_HEALTH = 200;

init() {
  level.killStreakFuncs[CONST_KILLSTREAK_NAME] = ::tryUseWolfpack;

  level.killstreakWeildWeapons["killstreak_wolfpack_mp"] = CONST_KILLSTREAK_NAME;
}

setup_callbacks() {
  level.agent_funcs["wolf"] = level.agent_funcs["dog"];

  level.agent_funcs["wolf"]["spawn"] = ::spawn_dog;
  level.agent_funcs["wolf"]["on_killed"] = ::on_agent_dog_killed;
  level.agent_funcs["wolf"]["on_damaged"] = maps\mp\agents\_agents::on_agent_generic_damaged;
  level.agent_funcs["wolf"]["on_damaged_finished"] = maps\mp\killstreaks\_dog_killstreak::on_damaged_finished;

  level.agent_funcs["wolf"]["think"] = ::think_init;
}

tryUseWolfpack(lifeId, streakName) {
  setup_callbacks();

  return useDog();
}

CONST_MAX_ACTIVE_KILLSTREAK_AGENTS_PER_PLAYER = 2;
useDog() {
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

  result = self spawnWolf(1);
  if(result) {
    self playSound("mp_mine_wolf_spawn");

    self threadspawnWolfPack();
  }

  return result;
}

spawnWolf(id) {
  agent = maps\mp\agents\_agent_common::connectNewAgent("wolf", self.team);
  if(!isDefined(agent)) {
    return false;
  }

  agent set_agent_team(self.team, self);

  structName = "wolf_spawn_0" + id;
  wolfStruct = getstruct(structName, "targetname");

  spawnOrigin = wolfStruct.origin;
  spawnAngles = self.angles;
  agent.wolfId = id;

  agent.pathNodeArray = getstructarray("wolf_path_0" + id, "script_noteworthy");

  agent thread[[agent agentFunc("spawn")]](spawnOrigin, spawnAngles, self);

  agent _setNameplateMaterial("player_name_bg_green_dog", "player_name_bg_red_dog");

  return true;
}

CONST_NUM_WOLVES = 3;
CONST_NUM_TOTAL_WOLVES = 6;
spawnWolfPack() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(i = 2; i <= CONST_NUM_WOLVES; i++) {
    wait(0.75);

    spawnWolf(i);
  }

  numWolvesLeft = CONST_NUM_TOTAL_WOLVES - CONST_NUM_WOLVES;

  while(true) {
    level waittill("wolf_killed", id);

    if(numWolvesLeft > 0) {
      wait(0.75);
      spawnWolf(id);

      numWolvesLeft--;
    } else {
      break;
    }
  }
}

on_agent_dog_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  self.isActive = false;
  self.hasDied = false;

  if(isDefined(self.owner))
    self.owner.hasDog = false;

  eAttacker.lastKillDogTime = GetTime();

  if(isDefined(self.animCBs.OnExit[self.aiState]))
    self[[self.animCBs.OnExit[self.aiState]]]();

  if(isPlayer(eAttacker) && isDefined(self.owner) && (eAttacker != self.owner)) {
    self maps\mp\gametypes\_damage::onKillstreakKilled(eAttacker, sWeapon, sMeansOfDeath, iDamage, "destroyed_ks_wolf");
  }

  self SetAnimState("death");
  animEntry = self GetAnimEntry();
  animLength = GetAnimLength(animEntry);

  deathAnimDuration = int(animLength * 1000);

  self.body = self CloneAgent(deathAnimDuration);

  self playSound("anml_wolf_shot_death");

  level notify("wolf_killed", self.wolfId);

  self maps\mp\agents\_agent_utility::deactivateAgent();

  self notify("killanimscript");
}

spawn_dog(optional_spawnOrigin, optional_spawnAngles, optional_owner) {
  dog_type = 1;

  dog_model = "mp_fullbody_wolf_c";
  wolf_type = 1;
  if(self.wolfId == 1) {
    dog_model = "mp_fullbody_wolf_b";
    wolf_type = 0;
  }

  if(IsHairRunning())
    dog_model = dog_model + "_fur";

  self setModel(dog_model);

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

  self.bIsWolf = true;
  animclass = "wolf_animclass";

  self maps\mp\agents\dog\_dog_think::init();
  self.watchAttackStateFunc = ::watchAttackState;

  self SpawnAgent(spawnOrigin, spawnAngles, animclass, 15, 40, optional_owner);
  level notify("spawned_agent", self);

  self maps\mp\agents\_agent_common::set_agent_health(CONST_WOLF_HEALTH);

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
  }

  self thread[[self agentFunc("think")]]();

  wait(0.1);

  if(IsHairRunning()) {
    furFX = level.wolfFurFX[wolf_type];

    assert(isDefined(furFX));
    playFXOnTag(furFX, self, "tag_origin");
  }
}

think_init() {
  self maps\mp\agents\dog\_dog_think::setupDogState();
  self.wolfGoalPos = get_closest(self.origin, self.pathNodeArray);

  self thread think();
  self thread maps\mp\agents\dog\_dog_think::watchOwnerDeath();
  self thread maps\mp\agents\dog\_dog_think::watchOwnerTeamChange();
  self thread maps\mp\agents\dog\_dog_think::WaitForBadPath();
  self thread maps\mp\agents\dog\_dog_think::WaitForPathSet();

  self thread maps\mp\agents\dog\_dog_think::debug_dog();
}

think() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner)) {
    self endon("owner_disconnect");
    self thread maps\mp\agents\dog\_dog_think::destroyOnOwnerDisconnect(self.owner);
  }

  self thread[[self.watchAttackStateFunc]]();
  self thread maps\mp\agents\dog\_dog_think::MonitorFlash();

  while(true) {
    if(self maps\mp\agents\dog\_dog_think::ProcessDebugMode()) {
      continue;
    }
    if(self.aiState != "melee" && !self.stateLocked && self maps\mp\agents\dog\_dog_think::readyToMeleeTarget() && !self maps\mp\agents\dog\_dog_think::DidPastMeleeFail())
      self ScrAgentBeginMelee(self.curMeleeTarget);

    switch (self.aiState) {
      case "idle":
        self updateMove();
        break;
      case "move":
        self updateMove();
        break;
      case "melee":
        self maps\mp\agents\dog\_dog_think::updateMelee();
        break;
    }
    wait(0.05);
  }
}

updateMove() {
  self UpdateMoveState();
}

UpdateMoveState() {
  if(self.bLockGoalPos) {
    return;
  }
  self.prevMoveState = self.moveState;

  attackPoint = undefined;
  bRefreshGoal = false;
  bWantedPursuitButFollowInstead = false;

  cBadPathTimeOut = 500;
  if(self.bHasBadPath && GetTime() - self.lastBadPathTime < cBadPathTimeOut) {
    self.moveState = "follow";
    bRefreshGoal = true;
  } else {
    self.moveState = self maps\mp\agents\dog\_dog_think::GetMoveState();
  }

  if(self.moveState == "pursuit") {
    attackPoint = self maps\mp\agents\dog\_dog_think::GetAttackPoint(self.enemy);
    bLastBadMeleeTarget = false;
    if(isDefined(self.lastBadPathTime) && (GetTime() - self.lastBadPathTime < 3000)) {
      if(Distance2DSquared(attackPoint, self.lastBadPathGoal) < 16)
        bLastBadMeleeTarget = true;
      else if(isDefined(self.lastBadPathMoveState) && self.lastBadPathMoveState == "pursuit" && Distance2DSquared(self.lastBadPathUltimateGoal, self.enemy.origin) < 16)
        bLastBadMeleeTarget = true;
    }
    if(!isReallyAlive(self.enemy) || bLastBadMeleeTarget || self maps\mp\agents\dog\_dog_think::wantToAttackTargetButCant(true) || self maps\mp\agents\dog\_dog_think::DidPastPursuitFail(self.enemy)) {
      self.moveState = "follow";
      bWantedPursuitButFollowInstead = true;
    }
  }

  self maps\mp\agents\dog\_dog_think::SetPastPursuitFailed(bWantedPursuitButFollowInstead);

  if(self.moveState == "follow") {
    self.curMeleeTarget = undefined;
    self.moveMode = self maps\mp\agents\dog\_dog_think::GetFollowMoveMode(self.moveMode);
    self.bArrivalsEnabled = true;

    myPos = self GetPathGoalPos();
    if(!isDefined(myPos))
      myPos = self.origin;

    if(GetTime() - self.timeOfLastDamage < 5000)
      bRefreshGoal = true;

    distFromGoalPos = Distance2DSquared(self.origin, self.wolfGoalPos.origin);

    if((distFromGoalPos < 800)) {
      self pickNewLocation();
    }
    self ScrAgentSetGoalPos(self.wolfGoalPos.origin);

    if(bRefreshGoal == true) {
      self ScrAgentSetGoalPos(self.origin);
    }
  } else if(self.moveState == "pursuit") {
    self.curMeleeTarget = self.enemy;
    self.moveMode = "sprint";
    self.bArrivalsEnabled = false;

    assert(isDefined(attackPoint));
    self ScrAgentSetGoalPos(attackPoint);
  }
}

pickNewLocation() {
  self.wolfGoalPos = GetStruct(self.wolfGoalPos.target, "targetname");
}

get_closest(origin, points, maxDist) {
  Assert(points.size);

  closestPoint = points[0];
  dist = Distance(origin, closestPoint.origin);

  for(index = 0; index < points.size; index++) {
    testDist = Distance(origin, points[index].origin);
    if(testDist >= dist) {
      continue;
    }
    dist = testDist;
    closestPoint = points[index];
  }

  if(!isDefined(maxDist) || dist <= maxDist)
    return closestPoint;

  return undefined;
}

watchAttackState() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(self.aiState == "melee") {
      if(self.attackState != "melee") {
        self.attackState = "melee";
        self SetSoundState(undefined);
      }
    } else if(self.moveState == "pursuit") {
      if(self.attackState != "attacking") {
        self.attackState = "attacking";
        self SetSoundState("bark", "attacking");
      }
    } else {
      if(self.attackState != "warning") {
        if(self maps\mp\agents\dog\_dog_think::wantsToGrowlAtTarget()) {
          self.attackState = "warning";
          self SetSoundState("growl", "warning");
        } else {
          self.attackState = self.aiState;
          self SetSoundState("pant");
        }
      } else {
        if(!self maps\mp\agents\dog\_dog_think::wantsToGrowlAtTarget()) {
          self.attackState = self.aiState;
          self SetSoundState("pant");
        }
      }
    }

    wait(0.05);
  }
}

SetSoundState(state, attackState) {
  if(!isDefined(state)) {
    self notify("end_dog_sound");
    self.soundState = undefined;
    return;
  }

  if(!isDefined(self.soundState) || self.soundState != state) {
    self notify("end_dog_sound");
    self.soundState = state;

    if(state == "bark") {
      self thread playBark(attackState);
    } else if(state == "growl") {
      self thread playGrowl(attackState);
    } else if(state == "pant") {
      self thread maps\mp\agents\dog\_dog_think::playPanting();
    } else {
      assertmsg("unknown sound state " + state);
    }
  }
}

playBark(state) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(!isDefined(self.barking_sound)) {
    self PlaySoundOnMovingEnt("mine_wolf_bark");
    self.barking_sound = true;
    self watchBarking();
  }
}

watchBarking() {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  wait(RandomIntRange(4, 6));
  self.barking_sound = undefined;
}

playGrowl(state) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self.lastGrowlPlayedTime) && GetTime() - self.lastGrowlPlayedTime < 3000)
    wait(3);

  while(true) {
    self.lastGrowlPlayedTime = GetTime();
    self PlaySoundOnMovingEnt("mine_wolf_growl");

    wait(RandomIntRange(3, 6));
  }
}