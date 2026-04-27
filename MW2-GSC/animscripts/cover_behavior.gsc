/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\cover_behavior.gsc
********************************************************/

#include maps\_utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;
#include common_scripts\utility;
#using_animtree("generic_human");

MELEE_GRACE_PERIOD_REQUIRED_TIME = 3000;
MELEE_GRACE_PERIOD_GIVEN_TIME = 5000;

main(behaviorCallbacks) {
  self.couldntSeeEnemyPos = self.origin;

  behaviorStartTime = gettime();
  coverTimers = spawnStruct();
  coverTimers.nextAllowedLookTime = behaviorStartTime - 1;
  coverTimers.nextAllowedSuppressTime = behaviorStartTime - 1;

  resetLookForBetterCoverTime();
  resetRespondToDeathTime();

  self.seekOutEnemyTime = gettime();

  self.a.lastEncounterTime = behaviorStartTime;
  self.a.idlingAtCover = false;
  self.a.movement = "stop";

  self.meleeCoverChargeMinTime = behaviorStartTime + MELEE_GRACE_PERIOD_REQUIRED_TIME;

  if(getDvar("scr_coveridle") == "1")
    self.coverNode.script_onlyidle = true;

  self thread watchSuppression();

  desynched = (gettime() > 2500);

  correctAngles = getCorrectCoverAngles();

  for(;;) {
    if(shouldHelpAdvancingTeammate()) {
      if(tryRunningToEnemy(true)) {
        wait 0.05;
        continue;
      }
    }

    if(isDefined(behaviorCallbacks.mainLoopStart)) {
      startTime = gettime();
      self thread endIdleAtFrameEnd();

      [[behaviorCallbacks.mainLoopStart]]();

      if(gettime() == startTime)
        self notify("dont_end_idle");
    }

    if(isDefined(behaviorCallbacks.moveToNearByCover)) {
      if([[behaviorCallbacks.moveToNearByCover]]())
        continue;
    }

    self safeTeleport(self.covernode.origin, correctAngles);

    if(!desynched) {
      idle(behaviorCallbacks, 0.05 + randomfloat(1.5));
      desynched = true;
      continue;
    }

    if(doNonAttackCoverBehavior(behaviorCallbacks)) {
      continue;
    }
    if(isDefined(anim.throwGrenadeAtPlayerASAP) && isAlive(level.player)) {
      if(tryThrowingGrenade(behaviorCallbacks, level.player))
        continue;
    }

    if(respondToDeadTeammate()) {
      return;
    }

    visibleEnemy = false;
    suppressableEnemy = false;
    if(isalive(self.enemy)) {
      visibleEnemy = isEnemyVisibleFromExposed();
      suppressableEnemy = canSuppressEnemyFromExposed();
    }

    if(visibleEnemy) {
      if(self.a.getBoredOfThisNodeTime < gettime()) {
        if(lookForBetterCover())
          return;
      }

      attackVisibleEnemy(behaviorCallbacks);
    } else {
      if(isDefined(self.aggressiveMode) || enemyIsHiding()) {
        if(advanceOnHidingEnemy())
          return;
      }

      if(suppressableEnemy) {
        attackSuppressableEnemy(behaviorCallbacks, coverTimers);
      } else {
        if(attackNothingToDo(behaviorCallbacks, coverTimers))
          return;
      }
    }
  }
}

end_script(coverMode) {
  self.turnToMatchNode = undefined;
  self.a.prevAttack = undefined;

  if(isDefined(self.meleeCoverChargeMinTime) && (self.meleeCoverChargeMinTime <= getTime())) {
    self.meleeCoverChargeGraceEndTime = getTime() + MELEE_GRACE_PERIOD_GIVEN_TIME;
    self.meleeCoverChargeMinTime = undefined;
  }
}

getCorrectCoverAngles() {
  correctAngles = (self.coverNode.angles[0], getNodeForwardYaw(self.coverNode), self.coverNode.angles[2]);
  return correctAngles;
}

RESPOND_TO_DEATH_RETRY_INTERVAL = 30 * 1000;

respondToDeadTeammate() {
  if(self atDangerousNode() && self.a.respondToDeathTime < gettime()) {
    if(lookForBetterCover())
      return true;

    self.a.respondToDeathTime = gettime() + RESPOND_TO_DEATH_RETRY_INTERVAL;
  }

  return false;
}

doNonAttackCoverBehavior(behaviorCallbacks) {
  if(isDefined(self.coverNode.script_onlyidle)) {
    assert(self.coverNode.script_onlyidle);
    idle(behaviorCallbacks);
    return true;
  }

  if(suppressedBehavior(behaviorCallbacks)) {
    if(isEnemyVisibleFromExposed())
      resetSeekOutEnemyTime();
    self.a.lastEncounterTime = gettime();
    return true;
  }

  if(coverReload(behaviorCallbacks, 0))
    return true;

  return false;
}

attackVisibleEnemy(behaviorCallbacks) {
  if(distanceSquared(self.origin, self.enemy.origin) > 750 * 750) {
    if(tryThrowingGrenade(behaviorCallbacks, self.enemy))
      return;
  }

  if(leaveCoverAndShoot(behaviorCallbacks, "normal")) {
    resetSeekOutEnemyTime();
    self.a.lastEncounterTime = gettime();
  } else {
    idle(behaviorCallbacks);
  }
}

attackSuppressableEnemy(behaviorCallbacks, coverTimers) {
  if(self.doingAmbush) {
    if(leaveCoverAndShoot(behaviorCallbacks, "ambush"))
      return;
  } else if(self.provideCoveringFire || gettime() >= coverTimers.nextAllowedSuppressTime) {
    preferredActivity = "suppress";
    if(!self.provideCoveringFire && (gettime() - self.lastSuppressionTime) > 5000 && randomint(3) < 2)
      preferredActivity = "ambush";
    else if(!self animscripts\shoot_behavior::shouldSuppress())
      preferredActivity = "ambush";

    if(leaveCoverAndShoot(behaviorCallbacks, preferredActivity)) {
      coverTimers.nextAllowedSuppressTime = gettime() + randomintrange(3000, 20000);

      if(isEnemyVisibleFromExposed())
        self.a.lastEncounterTime = gettime();
      return;
    }
  }

  if(tryThrowingGrenade(behaviorCallbacks, self.enemy)) {
    return;
  }
  idle(behaviorCallbacks);
}

attackNothingToDo(behaviorCallbacks, coverTimers) {
  if(coverReload(behaviorCallbacks, 0.1))
    return false;

  if(isDefined(self.enemy)) {
    if(tryThrowingGrenade(behaviorCallbacks, self.enemy))
      return false;
  }

  if(!self.doingAmbush && gettime() >= coverTimers.nextAllowedLookTime) {
    if(lookForEnemy(behaviorCallbacks)) {
      coverTimers.nextAllowedLookTime = gettime() + randomintrange(4000, 15000);

      return false;
    }
  }

  if(gettime() > self.a.getBoredOfThisNodeTime) {
    if(cantFindAnythingToDo())
      return true;
  }

  if(self.doingAmbush || (gettime() >= coverTimers.nextAllowedSuppressTime && isDefined(self.enemy))) {
    if(leaveCoverAndShoot(behaviorCallbacks, "ambush")) {
      if(isEnemyVisibleFromExposed())
        resetSeekOutEnemyTime();
      self.a.lastEncounterTime = gettime();
      coverTimers.nextAllowedSuppressTime = gettime() + randomintrange(6000, 20000);
      return false;
    }
  }

  idle(behaviorCallbacks);
  return false;
}

isEnemyVisibleFromExposed() {
  if(!isDefined(self.enemy))
    return false;

  if(distanceSquared(self.enemy.origin, self.couldntSeeEnemyPos) < 16 * 16)
    return false;
  else
    return canSeeEnemyFromExposed();
}

suppressedBehavior(behaviorCallbacks) {
  if(!isSuppressedWrapper())
    return false;

  nextAllowedBlindfireTime = gettime();

  justlooked = true;

  while(isSuppressedWrapper()) {
    justlooked = false;

    self safeTeleport(self.coverNode.origin);

    tryMovingNodes = true;

    if(isDefined(self.favor_blindfire))
      tryMovingNodes = coinToss();

    if(tryMovingNodes) {
      if(tryToGetOutOfDangerousSituation(behaviorCallbacks)) {
        self notify("killanimscript");

        return true;
      }
    }

    if(self.a.atConcealmentNode && self canSeeEnemy()) {
      return false;
    }

    if(isEnemyVisibleFromExposed() || canSuppressEnemyFromExposed()) {
      if(isDefined(anim.throwGrenadeAtPlayerASAP) && isAlive(level.player)) {
        if(tryThrowingGrenade(behaviorCallbacks, level.player))
          continue;
      }

      if(coverReload(behaviorCallbacks, 0)) {
        continue;
      }
      if(self.team != "allies" && gettime() >= nextAllowedBlindfireTime) {
        if(blindfire(behaviorCallbacks)) {
          nextAllowedBlindfireTime = gettime();
          if(!isDefined(self.favor_blindfire))
            nextAllowedBlindfireTime += randomintrange(3000, 12000);

          continue;
        }
      }

      if(tryThrowingGrenade(behaviorCallbacks, self.enemy)) {
        justlooked = true;
        continue;
      }
    }

    if(coverReload(behaviorCallbacks, 0.1)) {
      continue;
    }

    idle(behaviorCallbacks);
  }

  if(!justlooked && randomint(2) == 0)
    lookfast(behaviorCallbacks);

  return true;
}
getPermutation(n) {
  permutation = [];
  assert(n > 0);
  if(n == 1) {
    permutation[0] = 0;
  } else if(n == 2) {
    permutation[0] = randomint(2);
    permutation[1] = 1 - permutation[0];
  } else {
    for(i = 0; i < n; i++)
      permutation[i] = i;
    for(i = 0; i < n; i++) {
      switchIndex = i + randomint(n - i);
      temp = permutation[switchIndex];
      permutation[SwitchIndex] = permutation[i];
      permutation[i] = temp;
    }
  }
  return permutation;
}

callOptionalBehaviorCallback(callback, arg, arg2, arg3) {
  if(!isDefined(callback))
    return false;

  self thread endIdleAtFrameEnd();

  starttime = gettime();

  val = undefined;
  if(isDefined(arg3))
    val = [[callback]](arg, arg2, arg3);
  else if(isDefined(arg2))
    val = [[callback]](arg, arg2);
  else if(isDefined(arg))
    val = [[callback]](arg);
  else
    val = [[callback]]();

  assert(isDefined(val) && (val == true || val == false));

  if(val)
    assert(gettime() != starttime);
  else
    assert(gettime() == starttime);

  if(!val)
    self notify("dont_end_idle");

  return val;
}

watchSuppression() {
  self endon("killanimscript");

  self.lastSuppressionTime = gettime() - 100000;
  self.suppressionStart = self.lastSuppressionTime;

  while(1) {
    self waittill("suppression");

    time = gettime();
    if(self.lastSuppressionTime < time - 700)
      self.suppressionStart = time;
    self.lastSuppressionTime = time;
  }
}

coverReload(behaviorCallbacks, threshold) {
  if(self.bulletsInClip > weaponClipSize(self.weapon) * threshold)
    return false;

  self.isreloading = true;

  result = callOptionalBehaviorCallback(behaviorCallbacks.reload);

  self.isreloading = false;

  return result;
}
leaveCoverAndShoot(behaviorCallbacks, initialGoal) {
  self thread animscripts\shoot_behavior::decideWhatAndHowToShoot(initialGoal);

  if(!self.fixedNode && !self.doingAmbush)
    self thread breakOutOfShootingIfWantToMoveUp();

  val = callOptionalBehaviorCallback(behaviorCallbacks.leaveCoverAndShoot);

  self notify("stop_deciding_how_to_shoot");

  return val;
}

lookForEnemy(behaviorCallbacks) {
  if(self.a.atConcealmentNode && self canSeeEnemy())
    return false;

  if(self.a.lastEncounterTime + 6000 > gettime()) {
    return lookfast(behaviorCallbacks);
  } else {
    result = callOptionalBehaviorCallback(behaviorCallbacks.look, 2 + randomfloat(2));
    if(result)
      return true;
    return callOptionalBehaviorCallback(behaviorCallbacks.fastlook);
  }
}

lookfast(behaviorCallbacks) {
  result = callOptionalBehaviorCallback(behaviorCallbacks.fastlook);
  if(result)
    return true;
  return callOptionalBehaviorCallback(behaviorCallbacks.look, 0);
}

idle(behaviorCallbacks, howLong) {
  self.flinching = false;

  if(isDefined(behaviorCallbacks.flinch)) {
    if(!self.a.idlingAtCover && gettime() - self.suppressionStart < 600) {
      if([[behaviorCallbacks.flinch]]())
        return true;
    } else {
      self thread flinchWhenSuppressed(behaviorCallbacks);
    }
  }

  if(!self.a.idlingAtCover) {
    assert(isDefined(behaviorCallbacks.idle));
    self thread idleThread(behaviorCallbacks.idle);
    self.a.idlingAtCover = true;
  }

  if(isDefined(howLong))
    self idleWait(howLong);
  else
    self idleWaitABit();

  if(self.flinching)
    self waittill("flinch_done");

  self notify("stop_waiting_to_flinch");
}

idleWait(howLong) {
  self endon("end_idle");
  wait howLong;
}

idleWaitAbit() {
  self endon("end_idle");
  wait 0.3 + randomfloat(0.1);
  self waittill("do_slow_things");
}

idleThread(idlecallback) {
  self endon("killanimscript");
  self[[idlecallback]]();
}

flinchWhenSuppressed(behaviorCallbacks) {
  self endon("killanimscript");
  self endon("stop_waiting_to_flinch");

  lastSuppressionTime = self.lastSuppressionTime;

  while(1) {
    self waittill("suppression");

    time = gettime();

    if(lastSuppressionTime < time - 2000) {
      break;
    }

    lastSuppressionTime = time;
  }

  self.flinching = true;

  self thread endIdleAtFrameEnd();

  assert(isDefined(behaviorCallbacks.flinch));
  val = [[behaviorCallbacks.flinch]]();

  if(!val)
    self notify("dont_end_idle");

  self.flinching = false;
  self notify("flinch_done");
}

endIdleAtFrameEnd() {
  self endon("killanimscript");
  self endon("dont_end_idle");
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self notify("end_idle");
  self.a.idlingAtCover = false;
}

tryThrowingGrenade(behaviorCallbacks, throwAt) {
  assert(isDefined(throwAt));

  forward = anglesToForward(self.angles);
  dir = vectorNormalize(throwAt.origin - self.origin);
  if(vectorDot(forward, dir) < 0)
    return false;

  if(self.doingAmbush && !recentlySawEnemy())
    return false;

  if(self isPartiallySuppressedWrapper()) {
    return callOptionalBehaviorCallback(behaviorCallbacks.grenadehidden, throwAt);
  } else {
    return callOptionalBehaviorCallback(behaviorCallbacks.grenade, throwAt);
  }
}

blindfire(behaviorCallbacks) {
  if(!canBlindFire())
    return false;

  return callOptionalBehaviorCallback(behaviorCallbacks.blindfire);
}
breakOutOfShootingIfWantToMoveUp() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  while(1) {
    if(self.fixedNode || self.doingAmbush) {
      return;
    }
    wait 0.5 + randomfloat(0.75);

    if(!isDefined(self.enemy)) {
      continue;
    }
    if(enemyIsHiding()) {
      if(advanceOnHidingEnemy())
        return;
    }

    if(!self recentlySawEnemy() && !self canSuppressEnemy()) {
      if(gettime() > self.a.getBoredOfThisNodeTime) {
        if(cantFindAnythingToDo())
          return;
      }
    }
  }
}

enemyIsHiding() {
  if(!isDefined(self.enemy))
    return false;

  if(self.enemy isFlashed())
    return true;

  if(isPlayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
      return true;
  } else {
    if(isAI(self.enemy) && self.enemy isSuppressedWrapper())
      return true;
  }

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading)
    return true;

  return false;
}

resetRespondToDeathTime() {
  self.a.respondToDeathTime = 0;
}

resetLookForBetterCoverTime() {
  currentTime = gettime();

  if(isDefined(self.didShuffleMove) && currentTime > self.a.getBoredOfThisNodeTime) {
    self.a.getBoredOfThisNodeTime = currentTime + randomintrange(2000, 5000);
  } else if(isDefined(self.enemy)) {
    dist = distance2D(self.origin, self.enemy.origin);
    if(dist < self.engageMinDist)
      self.a.getBoredOfThisNodeTime = currentTime + randomintrange(5000, 10000);
    else if(dist > self.engageMaxDist && dist < self.goalradius)
      self.a.getBoredOfThisNodeTime = currentTime + randomintrange(2000, 5000);
    else
      self.a.getBoredOfThisNodeTime = currentTime + randomintrange(10000, 15000);
  } else {
    self.a.getBoredOfThisNodeTime = currentTime + randomintrange(5000, 15000);
  }
}

resetSeekOutEnemyTime() {
  if(isDefined(self.aggressiveMode))
    self.seekOutEnemyTime = gettime() + randomintrange(500, 1000);
  else
    self.seekOutEnemyTime = gettime() + randomintrange(3000, 5000);
}
cantFindAnythingToDo() {
  return advanceOnHidingEnemy();
}

advanceOnHidingEnemy() {
  if(self.fixedNode || self.doingAmbush)
    return false;

  if(isDefined(self.aggressiveMode) && gettime() >= self.seekOutEnemyTime) {
    return tryRunningToEnemy(false);
  }

  foundBetterCover = false;
  if(!isDefined(self.enemy) || !self.enemy isFlashed())
    foundBetterCover = lookForBetterCover();

  if(!foundBetterCover && isDefined(self.enemy) && !self canSeeEnemyFromExposed()) {
    if(gettime() >= self.seekOutEnemyTime) {
      return tryRunningToEnemy(false);
    }
  }

  return foundBetterCover;
}

tryToGetOutOfDangerousSituation(behaviorCallbacks) {
  if(isDefined(behaviorCallbacks.moveToNearByCover)) {
    if([[behaviorCallbacks.moveToNearByCover]]())
      return true;
  }

  return lookForBetterCover();
}
set_standing_turns() {
  self.a.array["turn_left_45"] = % exposed_tracking_turn45L;
  self.a.array["turn_left_90"] = % exposed_tracking_turn90L;
  self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
  self.a.array["turn_left_180"] = % exposed_tracking_turn180L;
  self.a.array["turn_right_45"] = % exposed_tracking_turn45R;
  self.a.array["turn_right_90"] = % exposed_tracking_turn90R;
  self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
  self.a.array["turn_right_180"] = % exposed_tracking_turn180R;
}

set_crouching_turns() {
  self.a.array["turn_left_45"] = % exposed_crouch_turn_90_left;
  self.a.array["turn_left_90"] = % exposed_crouch_turn_90_left;
  self.a.array["turn_left_135"] = % exposed_crouch_turn_180_left;
  self.a.array["turn_left_180"] = % exposed_crouch_turn_180_left;
  self.a.array["turn_right_45"] = % exposed_crouch_turn_90_right;
  self.a.array["turn_right_90"] = % exposed_crouch_turn_90_right;
  self.a.array["turn_right_135"] = % exposed_crouch_turn_180_right;
  self.a.array["turn_right_180"] = % exposed_crouch_turn_180_right;
}

turnToMatchNodeDirection(nodeAngleOffset) {
  if(isDefined(self.node)) {
    node = self.node;

    absRelYaw = abs(AngleClamp180(self.angles[1] - (node.angles[1] + nodeAngleOffset)));

    if(self.a.pose == "stand" && node getHighestNodeStance() != "stand") {
      if(absRelYaw > 45 && absRelYaw < 90)
        self orientmode("face angle", self.angles[1]);
      else
        self orientmode("face current");

      rate = 1.5;
      noteTime = getNotetrackTimes(%exposed_stand_2_crouch, "anim_pose = \"crouch\"")[0];
      noteTime = min(1, noteTime * 1.1);
      time = noteTime * getAnimLength(%exposed_stand_2_crouch) / rate;

      self setflaggedanimknoballrestart("crouchanim", %exposed_stand_2_crouch, %body, 1, .2, rate);
      self animscripts\shared::DoNoteTracksForTime(time, "crouchanim");
      self clearanim(%body, 0.2);
    }

    self orientmode("face angle", self.angles[1]);

    relYaw = AngleClamp180(self.angles[1] - (node.angles[1] + nodeAngleOffset));

    if(abs(relYaw) > 45) {
      if(self.a.pose == "stand")
        set_standing_turns();
      else
        set_crouching_turns();

      self.turnThreshold = 45;
      self.turnToMatchNode = true;
      animscripts\combat::TurnToFaceRelativeYaw(relYaw);
      self.turnToMatchNode = undefined;
    }
  }
}

moveToNearbyCover() {
  if(!isDefined(self.enemy))
    return false;

  if(isDefined(self.didShuffleMove)) {
    self.didShuffleMove = undefined;
    return false;
  }

  if(!isDefined(self.node))
    return false;

  if(randomint(3) == 0)
    return false;

  if(self.fixedNode || self.doingAmbush || self.keepClaimedNode || self.keepClaimedNodeIfValid)
    return false;

  if(distanceSquared(self.origin, self.node.origin) > 16 * 16)
    return false;

  node = self findshufflecovernode();

  if(isDefined(node) && (node != self.node) && self useCoverNode(node)) {
    self.shuffleMove = true;
    self.shuffleNode = node;
    self.didShuffleMove = true;

    wait 0.5;
    return true;
  }

  return false;
}