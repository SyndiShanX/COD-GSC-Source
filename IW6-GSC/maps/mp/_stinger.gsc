/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_stinger.gsc
*****************************************************/

#include maps\mp\_utility;

InitStingerUsage() {
  self.stingerStage = undefined;
  self.stingerTarget = undefined;
  self.stingerLockStartTime = undefined;
  self.stingerLostSightlineTime = undefined;

  self thread ResetStingerLockingOnDeath();
  level.stingerTargets = [];
}

ResetStingerLocking() {
  if(!isDefined(self.stingerUseEntered))
    return;
  self.stingerUseEntered = undefined;

  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");

  self WeaponLockFree();
  InitStingerUsage();
}

ResetStingerLockingOnDeath() {
  self endon("disconnect");

  self notify("ResetStingerLockingOnDeath");
  self endon("ResetStingerLockingOnDeath");

  for(;;) {
    self waittill("death");
    self ResetStingerLocking();
  }
}

StillValidStingerLock(ent) {
  assert(isDefined(self));

  if(!isDefined(ent))
    return false;
  if(!(self WorldPointInReticle_Circle(ent.origin, 65, 85)))
    return false;

  if(self.stingerTarget == level.ac130.planeModel && !isDefined(level.ac130player))
    return false;

  return true;
}

LoopStingerLockingFeedback() {
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingerTarget) && self.stingerTarget == level.chopper.gunner)
      level.chopper.gunner playLocalSound("missile_locking");

    if(isDefined(level.ac130player) && isDefined(self.stingerTarget) && self.stingerTarget == level.ac130.planeModel)
      level.ac130player playLocalSound("missile_locking");

    self playLocalSound("stinger_locking");
    self PlayRumbleOnEntity("ac130_25mm_fire");

    wait 0.6;
  }
}

LoopStingerLockedFeedback() {
  self endon("stop_javelin_locked_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingerTarget) && self.stingerTarget == level.chopper.gunner)
      level.chopper.gunner playLocalSound("missile_locking");

    if(isDefined(level.ac130player) && isDefined(self.stingerTarget) && self.stingerTarget == level.ac130.planeModel)
      level.ac130player playLocalSound("missile_locking");

    self playLocalSound("stinger_locked");
    self PlayRumbleOnEntity("ac130_25mm_fire");

    wait 0.25;
  }
}

DrawStar(point) {
  Line(point + (10, 0, 0), point - (10, 0, 0));
  Line(point + (0, 10, 0), point - (0, 10, 0));
  Line(point + (0, 0, 10), point - (0, 0, 10));
}

LockSightTest(target) {
  eyePos = self getEye();

  if(!isDefined(target))
    return false;

  passed = SightTracePassed(eyePos, target.origin, false, target);
  if(passed)
    return true;

  front = target GetPointInBounds(1, 0, 0);
  passed = SightTracePassed(eyePos, front, false, target);
  if(passed)
    return true;

  back = target GetPointInBounds(-1, 0, 0);
  passed = SightTracePassed(eyePos, back, false, target);
  if(passed)
    return true;

  return false;
}

StingerDebugDraw(target) {
  if(getDvar("missileDebugDraw") != "1")
    return;
  if(!isDefined(target)) {
    return;
  }
  org = target.origin;
  DrawStar(org);
  org = target GetPointInBounds(1, 0, 0);
  DrawStar(org);
  org = target GetPointInBounds(-1, 0, 0);
  DrawStar(org);
}

SoftSightTest() {
  LOST_SIGHT_LIMIT = 500;

  if(self LockSightTest(self.stingerTarget)) {
    self.stingerLostSightlineTime = 0;
    return true;
  }

  if(self.stingerLostSightlineTime == 0)
    self.stingerLostSightlineTime = getTime();

  timePassed = GetTime() - self.stingerLostSightlineTime;

  if(timePassed >= LOST_SIGHT_LIMIT) {
    ResetStingerLocking();
    return false;
  }

  return true;
}

StingerUsageLoop() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  LOCK_LENGTH = 1000;

  InitStingerUsage();

  for(;;) {
    wait 0.05;

    if(self PlayerADS() < 0.95) {
      ResetStingerLocking();
      continue;
    }

    weapon = self getCurrentWeapon();

    if(weapon != "stinger_mp" && weapon != "at4_mp" && weapon != "iw5_smaw_mp") {
      ResetStingerLocking();
      continue;
    }

    self.stingerUseEntered = true;

    if(!isDefined(self.stingerStage))
      self.stingerStage = 0;

    StingerDebugDraw(self.stingerTarget);

    if(self.stingerStage == 0) {
      targets = maps\mp\gametypes\_weapons::lockOnLaunchers_getTargetArray();
      if(targets.size == 0) {
        continue;
      }
      targetsInReticle = [];
      foreach(target in targets) {
        if(!isDefined(target)) {
          continue;
        }
        insideReticle = self WorldPointInReticle_Circle(target.origin, 65, 75);

        if(insideReticle)
          targetsInReticle[targetsInReticle.size] = target;
      }
      if(targetsInReticle.size == 0) {
        continue;
      }
      sortedTargets = SortByDistance(targetsInReticle, self.origin);
      if(!(self LockSightTest(sortedTargets[0]))) {
        continue;
      }
      thread LoopStingerLockingFeedback();
      self.stingerTarget = sortedTargets[0];
      self.stingerLockStartTime = GetTime();
      self.stingerStage = 1;
      self.stingerLostSightlineTime = 0;
    }

    if(self.stingerStage == 1) {
      if(!(self StillValidStingerLock(self.stingerTarget))) {
        ResetStingerLocking();
        continue;
      }

      passed = SoftSightTest();
      if(!passed) {
        continue;
      }
      timePassed = getTime() - self.stingerLockStartTime;

      if(self _hasPerk("specialty_fasterlockon")) {
        if(timePassed < (LOCK_LENGTH * 0.5))
          continue;
      } else {
        if(timePassed < LOCK_LENGTH)
          continue;
      }

      self notify("stop_javelin_locking_feedback");
      thread LoopStingerLockedFeedback();

      if(checkVehicleModelForLock(self.stingerTarget.model))
        self WeaponLockFinalize(self.stingerTarget);
      else if(isPlayer(self.stingerTarget))
        self WeaponLockFinalize(self.stingerTarget, (100, 0, 64));
      else
        self WeaponLockFinalize(self.stingerTarget, (100, 0, -32));

      self.stingerStage = 2;
    }

    if(self.stingerStage == 2) {
      passed = SoftSightTest();
      if(!passed) {
        continue;
      }
      if(!(self StillValidStingerLock(self.stingerTarget))) {
        ResetStingerLocking();
        continue;
      }
    }
  }
}

checkVehicleModelForLock(model) {
  switch (model) {
    case "vehicle_av8b_harrier_jet_opfor_mp":
    case "vehicle_av8b_harrier_jet_mp":
    case "vehicle_ugv_talon_mp":
      return true;
    default:
      if(model == level.littlebird_model)
        return true;
  };

  return false;
}