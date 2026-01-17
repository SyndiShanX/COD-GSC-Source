/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_behavior.gsc
*****************************************************/

#include maps\_utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;
#include common_scripts\utility;

main(behaviorCallbacks) {
  if(getdvar("scr_forceshotgun") == "on" && self.primaryweapon != "winchester1200") {
    self.secondaryweapon = self.primaryweapon;
    self.primaryweapon = "winchester1200";
    self animscripts\init::initWeapon(self.primaryweapon, "primary");
    self animscripts\init::initWeapon(self.secondaryweapon, "secondary");
    self animscripts\shared::placeWeaponOn(self.secondaryweapon, "back");
    self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
    self.weapon = self.primaryweapon;
    self animscripts\weaponList::RefillClip();
  }
  self.couldntSeeEnemyPos = self.origin;
  time = gettime();
  nextAllowedLookTime = time - 1;
  nextAllowedSuppressTime = time - 1;
  self.a.getBoredOfThisNodeTime = gettime() + randomintrange(2000, 6000);
  resetSeekOutEnemyTime();
  self.a.lastEncounterTime = time;
  self.a.idlingAtCover = false;
  self.a.movement = "stop";
  self.exposedSet = 0;
  self.exposedSetOverride = 1;
  self thread watchSuppression();
  desynched = (gettime() > 2500);
  correctAngles = self.coverNode.angles;
  if(self.coverNode.type == "Cover Left" || self.coverNode.type == "Cover Left Wide")
    correctAngles = (correctAngles[0], correctAngles[1] + 90, correctAngles[2]);
  else if(self.coverNode.type == "Cover Right" || self.coverNode.type == "Cover Right Wide")
    correctAngles = (correctAngles[0], correctAngles[1] - 90, correctAngles[2]);
  if(getdvar("scr_coveridle") == "1") {
    self.coverNode.script_onlyidle = true;
  }
  for(;;) {
    if(isDefined(behaviorCallbacks.mainLoopStart)) {
      startTime = gettime();
      self thread endIdleAtFrameEnd();
      [
        [behaviorCallbacks.mainLoopStart]
      ]();
      if(gettime() == startTime)
        self notify("dont_end_idle");
    }
    self teleport(self.covernode.origin, correctAngles);
    if(isDefined(self.coverNode.script_onlyidle)) {
      assert(self.coverNode.script_onlyidle);
      idle(behaviorCallbacks);
      continue;
    }
    if(!desynched) {
      idle(behaviorCallbacks, 0.05 + randomfloat(1.5));
      desynched = true;
      continue;
    }
    if(suppressedBehavior(behaviorCallbacks)) {
      if(isEnemyVisibleFromExposed())
        resetSeekOutEnemyTime();
      self.a.lastEncounterTime = gettime();
      continue;
    }
    if(coverReload(behaviorCallbacks, 0)) {
      continue;
    }
    visibleEnemy = false;
    suppressableEnemy = false;
    if(isalive(self.enemy)) {
      visibleEnemy = isEnemyVisibleFromExposed();
      suppressableEnemy = canSuppressEnemyFromExposed();
    }
    if(isDefined(anim.throwGrenadeAtPlayerASAP) && self.team == "axis") {
      players = GetPlayers();
      for(i = 0; i < players.size; i++) {
        if(isAlive(players[i])) {
          if(tryThrowingGrenade(players[i], 200)) {
            continue;
          }
        }
      }
    }
    if(visibleEnemy) {
      if(distanceSquared(self.origin, self.enemy.origin) > 750 * 750) {
        if(tryThrowingGrenade(behaviorCallbacks, self.enemy)) {
          continue;
        }
      }
      if(leaveCoverAndShoot(behaviorCallbacks, "normal")) {
        resetSeekOutEnemyTime();
        self.a.lastEncounterTime = gettime();
      } else {
        idle(behaviorCallbacks);
      }
    } else {
      if(!visibleEnemy && enemyIsHiding() && !self.fixedNode) {
        if(advanceOnHidingEnemy()) {
          return;
        }
      }
      if(suppressableEnemy) {
        permutation = getPermutation(2);
        done = false;
        for(i = 0; i < permutation.size && !done; i++) {
          switch (i) {
            case 0:
              if(self.provideCoveringFire || gettime() >= nextAllowedSuppressTime) {
                preferredActivity = "suppress";
                if(!self.provideCoveringFire && (gettime() - self.lastSuppressionTime) > 5000 && randomint(3) < 2)
                  preferredActivity = "ambush";
                if(!self animscripts\shoot_behavior::shouldSuppress())
                  preferredActivity = "ambush";
                if(leaveCoverAndShoot(behaviorCallbacks, preferredActivity)) {
                  nextAllowedSuppressTime = gettime() + randomintrange(3000, 20000);
                  if(isEnemyVisibleFromExposed())
                    self.a.lastEncounterTime = gettime();
                  done = true;
                }
              }
              break;
            case 1:
              if(tryThrowingGrenade(behaviorCallbacks, self.enemy)) {
                done = true;
              }
              break;
          }
        }
        if(done) {
          continue;
        }
        idle(behaviorCallbacks);
      } else {
        if(coverReload(behaviorCallbacks, 0.1)) {
          continue;
        }
        if(isValidEnemy(self.enemy)) {
          if(tryThrowingGrenade(behaviorCallbacks, self.enemy)) {
            continue;
          }
        }
        if(self.team == "axis" && self weaponAnims() != "rocketlauncher") {
          if(leaveCoverAndShoot(behaviorCallbacks, "ambush")) {
            nextAllowedSuppressTime = gettime() + randomintrange(3000, 20000);
            if(isEnemyVisibleFromExposed())
              self.a.lastEncounterTime = gettime();
            continue;
          }
        }
        if(gettime() >= nextAllowedLookTime) {
          if(lookForEnemy(behaviorCallbacks)) {
            nextAllowedLookTime = gettime() + randomintrange(4000, 15000);
            continue;
          }
        }
        if(gettime() > self.a.getBoredOfThisNodeTime) {
          if(cantFindAnythingToDo()) {
            return;
          }
        }
        if(gettime() >= nextAllowedSuppressTime && isValidEnemy(self.enemy)) {
          if(leaveCoverAndShoot(behaviorCallbacks, "ambush")) {
            if(isEnemyVisibleFromExposed())
              resetSeekOutEnemyTime();
            self.a.lastEncounterTime = gettime();
            nextAllowedSuppressTime = gettime() + randomintrange(6000, 20000);
            continue;
          }
        }
        idle(behaviorCallbacks);
      }
    }
  }
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
    self teleport(self.coverNode.origin);
    if(tryToGetOutOfDangerousSituation()) {
      self notify("killanimscript");
      return true;
    }
    canThrowGrenade = isEnemyVisibleFromExposed() || canSuppressEnemyFromExposed();
    if(self.a.atConcealmentNode && self canSeeEnemy()) {
      return false;
    }
    if(canThrowGrenade && isDefined(anim.throwGrenadeAtPlayerASAP) && self.team == "axis") {
      players = GetPlayers();
      for(i = 0; i < players.size; i++) {
        if(isAlive(players[i])) {
          if(tryThrowingGrenade(players[i], 200)) {
            continue;
          }
        }
      }
    }
    if(coverReload(behaviorCallbacks, 0)) {
      continue;
    }
    permutation = getPermutation(2);
    done = false;
    for(i = 0; i < permutation.size && !done; i++) {
      switch (i) {
        case 0:
          if(self.team != "allies" && gettime() >= nextAllowedBlindfireTime) {
            if(blindfire(behaviorCallbacks)) {
              nextAllowedBlindfireTime = gettime() + randomintrange(3000, 12000);
              done = true;
            }
          }
          break;
        case 1:
          if(canThrowGrenade && tryThrowingGrenade(behaviorCallbacks, self.enemy)) {
            justlooked = true;
            done = true;
          }
          break;
      }
    }
    if(done) {
      continue;
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
  if(!self.fixedNode)
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
    if(usingGasWeapon()) {
      result = callOptionalBehaviorCallback(behaviorCallbacks.look, 5 + randomfloat(2));
    } else {
      result = callOptionalBehaviorCallback(behaviorCallbacks.look, 2 + randomfloat(2));
    }
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
  self notify("end_idle");
  self.a.idlingAtCover = false;
}

tryThrowingGrenade(behaviorCallbacks, throwAt) {
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
    if(self.fixedNode) {
      return;
    }
    wait 0.5 + randomfloat(0.75);
    if(!isValidEnemy(self.enemy)) {
      continue;
    }
    if(enemyIsHiding()) {
      if(advanceOnHidingEnemy())
        return;
    }
    if(!self canSeeEnemy() && !self canSuppressEnemy()) {
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
  if(isplayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
      return true;
  } else {
    if(issentient(self.enemy) && self.enemy isSuppressedWrapper())
      return true;
  }
  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading)
    return true;
  return false;
}

wouldBeSmartForMyAITypeToSeekOutEnemy() {
  if(self weaponAnims() == "rocketlauncher")
    return false;
  if(self isSniper())
    return false;
  return true;
}

resetSeekOutEnemyTime() {
  self.seekOutEnemyTime = gettime() + randomintrange(3000, 5000);
}

cantFindAnythingToDo() {
  return advanceOnHidingEnemy();
}

advanceOnHidingEnemy() {
  foundBetterCover = false;
  if(!isValidEnemy(self.enemy) || !self.enemy isFlashed())
    foundBetterCover = lookForBetterCover();
  if(!foundBetterCover && isValidEnemy(self.enemy) && wouldBeSmartForMyAITypeToSeekOutEnemy() && !self canSeeEnemyFromExposed()) {
    if(gettime() >= self.seekOutEnemyTime || self.enemy isFlashed()) {
      return tryRunningToEnemy(false);
    }
  }
  return foundBetterCover;
}

tryToGetOutOfDangerousSituation() {
  return lookForBetterCover();
}