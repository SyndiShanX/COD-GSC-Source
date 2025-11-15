/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_dome_ns_alien_think.gsc
**********************************************/

#include common_scripts\utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;

main() {
  self setupAlienState();

  self thread think();
  self thread watchOwnerDamage();
  self thread watchOwnerDeath();
  self thread watchOwnerTeamChange();
  self thread WaitForBadPath();
  self thread WaitForPathSet();

  self thread debug_dog();
}

setupAlienState() {
  self.bLockGoalPos = false;
  self.ownerRadiusSq = 144 * 144;
  self.meleeRadiusSq = 90 * 90;
  self.attackOffset = 25 + self.radius;
  self.attackRadiusSq = 450 * 450;
  self.warningRadiusSq = 550 * 550;
  self.warningZHeight = 128 * 0.75;
  self.attackZHeight = 54;
  self.attackZHeightDown = -64;
  self.ownerDamagedRadiusSq = 1500 * 1500;
  self.dogDamagedRadiusSq = 6500 * 6500;
  self.keepPursuingTargetRadiusSq = 6000 * 6000;
  self.preferredOffsetFromOwner = 76;
  self.minOffsetFromOwner = 50;
  self.forceAttack = true;
  self.ignoreCloseFoliage = true;
  self.moveMode = "run";
  self.enableExtendedKill = true;
  self.attackState = "idle";
  self.moveState = "idle";
  self.bHasBadPath = false;
  self.timeOfLastDamage = 0;

  self.Alien_GoalPos = get_closest(self.origin, self.PathNodeArray);
  self.allowCrouch = true;

  self ScrAgentSetGoalRadius(24);
}

init() {
  self.animCBs = spawnStruct();
  self.animCBs.OnEnter = [];
  self.animCBs.OnEnter["idle"] = maps\mp\mp_dome_ns_alien_idle::main;
  self.animCBs.OnEnter["move"] = maps\mp\mp_dome_ns_alien_move::main;
  self.animCBs.OnEnter["traverse"] = maps\mp\mp_dome_ns_alien_traverse::main;

  self.animCBs.OnExit = [];
  self.animCBs.OnExit["idle"] = maps\mp\mp_dome_ns_alien_idle::end_script;
  self.animCBs.OnExit["move"] = maps\mp\mp_dome_ns_alien_move::end_script;
  self.animCBs.OnExit["traverse"] = maps\mp\mp_dome_ns_alien_traverse::end_script;

  self Suicide();

  self.watchAttackStateFunc = ::watchAttackState;

  self.aiState = "idle";
  self.moveMode = "fastwalk";

  self.radius = 15;
  self.height = 40;
}

onEnterAnimState(prevState, nextState) {
  self notify("killanimscript");

  if(!isDefined(self.animCBs.OnEnter[nextState])) {
    return;
  }
  if(prevState == nextState && (nextState != "alien_traverse")) {
    return;
  }
  if(isDefined(self.animCBs.OnExit[prevState]))
    self[[self.animCBs.OnExit[prevState]]]();

  ExitAIState(self.aiState);

  self.aiState = nextState;

  EnterAIState(nextState);

  self[[self.animCBs.OnEnter[nextState]]]();
}

think() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner)) {
    self endon("owner_disconnect");
    self thread destroyOnOwnerDisconnect(self.owner);
  }

  self thread[[self.watchAttackStateFunc]]();
  self thread MonitorFlash();

  while(true) {
    if(self ProcessDebugMode()) {
      continue;
    }
    if(!self.stateLocked && self readyToMeleeTarget()) {
      self mp_dome_ns_alien_explode(self.curMeleeTarget);
      return;
    }

    switch (self.aiState) {
      case "idle":
        self updateIdle();
        break;
      case "move":
        self updateMove();
        break;
      case "melee":
        self updateMelee();
        break;
    }
    wait(0.05);
  }
}

mp_dome_ns_alien_explode(explosion_target, maxDamage, blastRadius, attacker) {
  self EmissiveBlend(0.2, 1.0);
  playFX(level._effect["vfx_alien_minion_explode_dome"], self.origin);
  phyExpMagnitude = 2;
  minDamage = 1;
  if(!isDefined(maxDamage))
    maxDamage = 400;
  if(!isDefined(blastRadius))
    blastRadius = 380;

  if(isDefined(attacker)) {
    attacker radiusDamage(self.origin, blastRadius, maxDamage, minDamage, attacker, "MOD_EXPLOSIVE", "killstreak_level_event_mp");
  } else if(isDefined(self.owner)) {
    self radiusDamage(self.origin, blastRadius, maxDamage, minDamage, self.owner, "MOD_EXPLOSIVE", "killstreak_level_event_mp");
  } else {
    self radiusDamage(self.origin, blastRadius, maxDamage, minDamage, undefined, "MOD_EXPLOSIVE", "killstreak_level_event_mp");
  }

  self playSound("alien_minion_explode");
  physicsExplosionSphere(self.origin, blastRadius, blastRadius / 2, phyExpMagnitude);
  self maps\mp\gametypes\_shellshock::barrel_earthQuake();

  self notify("killanimscript");
  self SetAnimState("explode", 0, 1);

  wait GetAnimLength(self GetAnimEntry("explode", 0));
  if(isDefined(self))
    self suicide();
}

DidPastPursuitFail(enemy) {
  assert(isDefined(enemy));

  if(isDefined(self.curMeleeTarget) && enemy != self.curMeleeTarget)
    return false;

  if(!isDefined(self.lastPursuitFailedPos) || !isDefined(self.lastPursuitFailedMyPos))
    return false;

  if(Distance2DSquared(enemy.origin, self.lastPursuitFailedPos) > 4)
    return false;

  if(self.bLastPursuitFailedPosBad)
    return true;

  if(DistanceSquared(self.origin, self.lastPursuitFailedMyPos) > 64 * 64 && GetTime() - self.lastPursuitFailedTime > 2000)
    return false;

  return true;
}

DidPastMeleeFail() {
  assert(isDefined(self.curMeleeTarget));

  if(isDefined(self.lastMeleeFailedPos) && isDefined(self.lastMeleeFailedMyPos) &&
    Distance2DSquared(self.curMeleeTarget.origin, self.lastMeleeFailedPos) < 4 &&
    DistanceSquared(self.origin, self.lastMeleeFailedMyPos) < 50 * 50)
    return true;

  if(self WantToAttackTargetButCant(false))
    return true;

  return false;
}

enterAIState(state) {
  self ExitAIState(self.aiState);
  self.aiState = state;

  switch (state) {
    case "idle":
      self.moveState = "idle";
      self.bHasBadPath = false;
      break;
    case "move":
      self.moveState = "follow";
      break;
    case "melee":
      break;
    default:
      break;
  }
}

ExitAIState(state) {
  switch (state) {
    case "move":
      self.ownerPrevPos = undefined;
      break;
    default:
      break;
  }
}

updateIdle() {
  self UpdateMoveState();
}

updateMove() {
  self UpdateMoveState();
}

updateMelee() {
  self ScrAgentSetGoalPos(self.origin);
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
    self.moveState = self GetMoveState();
  }

  if(self.moveState == "pursuit") {
    attackPoint = self GetAttackPoint(self.enemy);
    bLastBadMeleeTarget = false;
    if(isDefined(self.lastBadPathTime) && (GetTime() - self.lastBadPathTime < 3000)) {
      if(Distance2DSquared(attackPoint, self.lastBadPathGoal) < 16)
        bLastBadMeleeTarget = true;
      else if(isDefined(self.lastBadPathMoveState) && self.lastBadPathMoveState == "pursuit" && Distance2DSquared(self.lastBadPathUltimateGoal, self.enemy.origin) < 16)
        bLastBadMeleeTarget = true;
    }
    if(bLastBadMeleeTarget) {
      self.moveState = "follow";
      bWantedPursuitButFollowInstead = true;
    } else if(self wantToAttackTargetButCant(true)) {
      self.moveState = "follow";
      bWantedPursuitButFollowInstead = true;
    } else if(self DidPastPursuitFail(self.enemy)) {
      self.moveState = "follow";
      bWantedPursuitButFollowInstead = true;
    }
  }

  self SetPastPursuitFailed(bWantedPursuitButFollowInstead);

  if(self.moveState == "follow") {
    self.curMeleeTarget = undefined;
    self.moveMode = self GetFollowMoveMode(self.moveMode);
    self.bArrivalsEnabled = true;

    myPos = self GetPathGoalPos();
    if(!isDefined(myPos))
      myPos = self.origin;

    if(GetTime() - self.timeOfLastDamage < 5000)
      bRefreshGoal = true;

    distFromGoalPos = Distance2DSquared(self.origin, self.Alien_GoalPos.origin);

    if((distFromGoalPos < 800)) {
      self PickNewLocation();
    }
    self ScrAgentSetGoalPos(self.Alien_GoalPos.origin);

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

PickNewLocation() {
  self.Alien_GoalPos = GetStruct(self.Alien_GoalPos.target, "targetname");
}

GetMoveState(prevState) {
  if(isDefined(self.enemy)) {
    if(!maps\mp\_utility::IsReallyAlive(self.enemy))
      return "follow";

    if(isDefined(self.favoriteEnemy) && self.enemy == self.favoriteEnemy)
      return "pursuit";

    if(abs(self.origin[2] - self.enemy.origin[2]) < self.warningZHeight && Distance2DSquared(self.enemy.origin, self.origin) < self.attackRadiusSq)
      return "pursuit";

    if(isDefined(self.curMeleeTarget) && self.curMeleeTarget == self.enemy) {
      if(Distance2DSquared(self.curMeleeTarget.origin, self.origin) < self.keepPursuingTargetRadiusSq)
        return "pursuit";
    }
  }

  return "follow";
}

SetPastPursuitFailed(bWantedPursuitButFollowInstead) {
  if(bWantedPursuitButFollowInstead) {
    if(!isDefined(self.lastPursuitFailedPos)) {
      self.lastPursuitFailedPos = self.enemy.origin;
      self.lastPursuitFailedMyPos = self.origin;
      groundPos = self DropPosToGround(self.enemy.origin);
      self.bLastPursuitFailedPosBad = !isDefined(groundPos);
      self.lastPursuitFailedTime = GetTime();
    }
  } else {
    self.lastPursuitFailedPos = undefined;
    self.lastPursuitFailedMyPos = undefined;
    self.bLastPursuitFailedPosBad = undefined;
    self.lastPursuitFailedTime = undefined;
  }
}

WaitForBadPath() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("bad_path", badGoalPos);
    self.bHasBadPath = true;
    self.lastBadPathTime = GetTime();
    self.lastBadPathGoal = badGoalPos;
    self.lastBadPathMoveState = self.moveState;
    if(self.moveState == "follow" && isDefined(self.owner))
      self.lastBadPathUltimateGoal = self.owner.origin;
    else if(self.moveState == "pursuit" && isDefined(self.enemy))
      self.lastBadPathUltimateGoal = self.enemy.origin;
  }
}

WaitForPathSet() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("path_set");
    self.bHasBadPath = false;
  }
}

GetFollowMoveMode(currentMoveMode) {
  cRunToFastWalkDistSq = 350 * 350;
  cFastWalkToRunDistSq = 400 * 400;

  pathGoalPos = self GetPathGoalPos();
  if(isDefined(pathGoalPos)) {
    distSq = DistanceSquared(pathGoalPos, self.origin);
    if(currentMoveMode == "run" || currentMoveMode == "sprint") {
      if(distSq < cRunToFastWalkDistSq)
        return "fastwalk";
      else if(currentMoveMode == "sprint")
        return "run";
    } else if(currentMoveMode == "fastwalk") {
      if(distSq > cFastWalkToRunDistSq)
        return "run";
    }
  }

  return currentMoveMode;
}

IsWithinAttackHeight(targetPos) {
  zDiff = targetPos[2] - self.origin[2];

  return zDiff <= self.attackZHeight && zDiff >= self.attackZHeightDown;
}

WantToAttackTargetButCant(bCheckSight) {
  if(!isDefined(self.curMeleeTarget))
    return false;

  return !self IsWithinAttackHeight(self.curMeleeTarget.origin) &&
    Distance2DSquared(self.origin, self.curMeleeTarget.origin) < self.meleeRadiusSq * 0.75 * 0.75 &&
    (!bCheckSight || self AgentCanSeeSentient(self.curMeleeTarget));
}

readyToMeleeTarget() {
  if(!isDefined(self.curMeleeTarget))
    return false;

  if(!maps\mp\_utility::IsReallyAlive(self.curMeleeTarget))
    return false;

  if(self.aiState == "traverse")
    return false;

  if(Distance2DSquared(self.origin, self.curMeleeTarget.origin) > self.meleeRadiusSq)
    return false;

  if(!self IsWithinAttackHeight(self.curMeleeTarget.origin))
    return false;

  return true;
}

wantsToGrowlAtTarget() {
  if(!isDefined(self.enemy))
    return false;

  if(abs(self.origin[2] - self.enemy.origin[2]) <= self.warningZHeight || self AgentCanSeeSentient(self.enemy)) {
    distSq = Distance2DSquared(self.origin, self.enemy.origin);
    if(distSq < self.warningRadiusSq)
      return true;
  }

  return false;
}

getAttackPoint(enemy) {
  meToTarget = enemy.origin - self.origin;
  meToTarget = VectorNormalize(meToTarget);

  pathGoalPos = self GetPathGoalPos();
  closeEnough = self.attackOffset + 4;
  if(isDefined(pathGoalPos) && Distance2DSquared(pathGoalPos, enemy.origin) < closeEnough * closeEnough && self CanMovePointToPoint(enemy.origin, pathGoalPos))
    return pathGoalPos;

  attackPoint = enemy.origin - meToTarget * self.attackOffset;
  attackPoint = self DropPosToGround(attackPoint);

  if(!isDefined(attackPoint))
    return enemy.origin;

  if(!self CanMovePointToPoint(enemy.origin, attackPoint)) {
    enemyFacing = anglesToForward(enemy.angles);
    attackPoint = enemy.origin + enemyFacing * self.attackOffset;

    if(!self CanMovePointToPoint(enemy.origin, attackPoint))
      return enemy.origin;
  }

  return attackPoint;
}

cross2D(a, b) {
  return a[0] * b[1] - b[0] * a[1];
}

destroyOnOwnerDisconnect(owner) {
  self endon("death");
  owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone())
    wait 0.05;

  self notify("killanimscript");
  if(isDefined(self.animCBs.OnExit[self.aiState]))
    self[[self.animCBs.OnExit[self.aiState]]]();
  self mp_dome_ns_alien_explode(undefined, 1, 0);
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
        if(self wantsToGrowlAtTarget()) {
          self.attackState = "warning";
          self SetSoundState("growl", "warning");
        } else {
          self.attackState = self.aiState;
          self SetSoundState("pant");
        }
      } else {
        if(!self wantsToGrowlAtTarget()) {
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
      self thread playPanting();
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
    self PlaySoundOnMovingEnt("alien_minion_attack");
    self.barking_sound = true;
    self thread watchBarking();
  }
}

watchBarking() {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  wait(RandomIntRange(5, 10));
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
    self PlaySoundOnMovingEnt("alien_minion_attack");

    wait(RandomIntRange(3, 6));
  }
}

playPanting(state) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self.lastPantPlayedTime) && GetTime() - self.lastPantPlayedTime < 3000)
    wait(3);

  self.lastPantPlayedTime = GetTime();

  while(true) {
    if(self.aiState == "idle") {
      wait(3);
      continue;
    }

    self.lastPantPlayedTime = GetTime();
    if(self.moveMode == "run" || self.moveMode == "sprint")
      self PlaySoundOnMovingEnt("alien_minion_idle");
    else
      self PlaySoundOnMovingEnt("alien_minion_idle");

    wait(RandomIntRange(6, 8));
  }
}

watchOwnerDamage() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("damage", damage, attacker);

    if(IsPlayer(attacker) && attacker != self.owner) {
      if(self.attackState == "attacking") {
        continue;
      }
      if(DistanceSquared(self.owner.origin, self.origin) > self.ownerDamagedRadiusSq) {
        continue;
      }
      if(DistanceSquared(self.owner.origin, attacker.origin) > self.ownerDamagedRadiusSq) {
        continue;
      }
      self.favoriteEnemy = attacker;
      self.forceAttack = true;
      self thread watchFavoriteEnemyDeath();
    }
  }
}

watchOwnerDeath() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("death");

    switch (level.gameType) {
      case "sd":

        killDog();
        break;
      case "sr":

        result = level waittill_any_return("sr_player_eliminated", "sr_player_respawned");
        if(isDefined(result) && result == "sr_player_eliminated")
          killDog();
        break;
    }
  }
}

watchOwnerTeamChange() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self.owner)) {
      return;
    }
    result = self.owner waittill_any_return_no_endon_death("joined_team", "joined_spectators");

    if(isDefined(result) && (result == "joined_team" || result == "joined_spectators"))
      killDog();
  }
}

watchFavoriteEnemyDeath() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");

  self endon("death");

  self.favoriteEnemy waittill_any_timeout(5.0, "death", "disconnect");

  self.favoriteEnemy = undefined;
  self.forceAttack = false;
}

OnDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  self.timeOfLastDamage = GetTime();
  if(isDefined(self.owner))
    self.damagedOwnerToMe = VectorNormalize(self.origin - self.owner.origin);

  if(self ShouldPlayHitReaction(iDamage, sWeapon, sMeansOfDeath)) {
    switch (self.aiState) {
      case "idle":
        self thread maps\mp\mp_dome_ns_alien_idle::OnDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
        break;
      case "move":
        self thread maps\mp\mp_dome_ns_alien_move::OnDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
        break;
    }
  }
}

ShouldPlayHitReaction(iDamage, sWeapon, sMeansOfDeath) {
  if(isDefined(sWeapon) && WeaponClass(sWeapon) == "sniper")
    return true;
  if(isDefined(sMeansOfDeath) && IsExplosiveDamageMOD(sMeansOfDeath) && iDamage >= 10)
    return true;
  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE")
    return true;
  if(isDefined(sWeapon) && sWeapon == "concussion_grenade_mp")
    return true;

  return false;
}

MonitorFlash() {
  self endon("death");

  while(true) {
    self waittill("flashbang", origin, percent_distance, percent_angle, attacker, teamName, extraDuration);

    if(isDefined(attacker) && attacker == self.owner) {
      continue;
    }
    switch (self.aiState) {
      case "idle":
        self maps\mp\mp_dome_ns_alien_idle::onFlashbanged();
        break;
      case "move":
        self maps\mp\mp_dome_ns_alien_move::onFlashbanged();
        break;
    }
  }
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

debug_dog() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(GetDvarInt("scr_debugdog") > 0) {
      start = self.origin;
      end = self.origin;
      if(isDefined(self.enemy))
        end = self.enemy.origin;
      color = [1, 1, 1];

      switch (self.attackState) {
        case "idle":
          color = [1, 1, 1];
          break;
        case "move":
          color = [0, 1, 0];
          break;
        case "traverse":
          color = [0.5, 0.5, 0.5];
          break;
        case "melee":
        case "attacking":
          color = [1, 0, 0];
          break;
        case "warning":
          color = [0.8, 0.8, 0];
          break;
        default:
          break;
      }

      Print3d(self.origin + (0, 0, 10), self.attackState, (color[0], color[1], color[2]));
      Line(start, end, (color[0], color[1], color[2]));
    }

    wait(0.05);
  }
}

ProcessDebugMode() {
  if(getdvarint("scr_alienDebugMode") == 1) {
    if(!isDefined(self.bDebugMode) || !self.bDebugMode)
      self thread DoDebugMode();
    self.bDebugMode = true;
    wait(0.05);
    return true;
  } else {
    if(isDefined(self.bDebugMode) && self.bDebugMode)
      self EndDebugMode();
    self.bDebugMode = false;
    return false;
  }
}

DoDebugPrint3D(str, color) {
  self notify("enddebugprint3D");
  level endon("game_ended");
  self endon("death");
  self endon("enddebugprint3D");

  nTimes = 0;
  while(nTimes < 60) {
    printPos = self.origin + (0, 0, 48);
    print3D(printPos, str, color, 1, 1);
    nTimes++;
    wait(0.05);
  }
}

DebugDrawHitPos(pos, normal, color) {
  self notify("enddebugdrawhitpos");
  level endon("game_ended");
  self endon("death");
  self endon("enddebugdrawhitpos");

  lineEnd = pos + normal * 100;

  while(true) {
    Line(pos, lineEnd, color, 1, true, 1);
    wait(0.05);
  }
}

DoDebugMode() {
  self endon("death");
  level endon("game_ended");
  self endon("enddebugmode");

  if(isDefined(self.owner) && IsPlayer(self.owner))
    player = self.owner;
  else
    player = level.players[0];

  if(IsAI(player)) {
    return;
  }
  red = (255, 0, 0);
  green = (0, 255, 0);

  while(true) {
    player NotifyOnPlayerCommand("debug_setgoal", "+usereload");
    player waittill("debug_setgoal");

    viewAngles = player GetPlayerAngles();
    viewEye = player getEye();

    playerForward = anglesToForward(viewAngles);
    traceEndPos = viewEye + playerForward * 2048;

    trace = self AIPhysicsTrace(viewEye, traceEndPos, 1, 2, true, true);

    if(trace["fraction"] < 1) {
      hitNormal = trace["normal"];
      hitPos = trace["position"];
      drawColor = red;
      if(hitNormal[2] > 0.707) {
        goalPos = self DropPosToGround(hitPos);
        if(isDefined(goalPos)) {
          closestNode = GetClosestNodeInSight(goalPos);
          if(isDefined(closestNode)) {
            self ScrAgentSetGoalPos(goalPos);
            drawColor = green;
            self notify("enddebugprint3D");
            hitPos = goalPos;
          } else {
            thread DoDebugPrint3D("unable to find closest node to pos. (cannot path.)", red);
            self ScrAgentSetGoalPos(self.origin);
          }
        } else {
          thread DoDebugPrint3D("alien cannot stand there.", red);
          self ScrAgentSetGoalPos(self.origin);
        }
      } else {
        thread DoDebugPrint3D("hit pos too steep.", red);
        self ScrAgentSetGoalPos(self.origin);
      }

      thread DebugDrawHitPos(hitPos, hitNormal, drawColor);
    } else {
      thread DoDebugPrint3D("trace did not hit anything.", red);
      self ScrAgentSetGoalPos(self.origin);
      self notify("enddebugdrawhitpos");
    }
  }
}

EndDebugMode() {
  self notify("enddebugprint3D");
  self notify("enddebugdrawhitpos");
  self notify("enddebugmode");
}
# /