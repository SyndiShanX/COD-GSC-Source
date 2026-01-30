/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_stinger.gsc
***************************************************/

#include maps\mp\_utility;

InitStingerUsage() {
  self.stingerStage = undefined;
  self.stingerTarget = undefined;
  self.stingerLockStartTime = undefined;
  self.stingerLostSightlineTime = undefined;

  self thread ResetStingerLockingOnDeath();
}

ResetStingerLocking() {
  if(!isDefined(self.stingerUseEntered)) {
    return;
  }
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

  if(!isDefined(ent)) {
    return false;
  }
  if(!(self WorldPointInReticle_Circle(ent.origin, 65, 85))) {
    return false;
  }

  if(isDefined(level.ac130) && self.stingerTarget == level.ac130.planeModel && !isDefined(level.ac130player)) {
    return false;
  }

  if(isDefined(level.orbitalsupport_planeModel) && self.stingerTarget == level.orbitalsupport_planeModel && !isDefined(level.orbitalsupport_player)) {
    return false;
  }

  return true;
}

LoopStingerLockingFeedback() {
  self endon("faux_spawn");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingerTarget) && self.stingerTarget == level.chopper.gunner) {
      level.chopper.gunner playLocalSound("missile_locking");
    }

    if(isDefined(level.ac130player) && isDefined(self.stingerTarget) && self.stingerTarget == level.ac130.planeModel) {
      level.ac130player playLocalSound("missile_locking");
    }

    self playLocalSound("stinger_locking");
    self PlayRumbleOnEntity("ac130_25mm_fire");

    wait 0.6;
  }
}

LoopStingerLockedFeedback() {
  self endon("faux_spawn");
  self endon("stop_javelin_locked_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingerTarget) && self.stingerTarget == level.chopper.gunner) {
      level.chopper.gunner playLocalSound("missile_locking");
    }

    if(isDefined(level.ac130player) && isDefined(self.stingerTarget) && self.stingerTarget == level.ac130.planeModel) {
      level.ac130player playLocalSound("missile_locking");
    }

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

  if(!isDefined(target)) {
    return false;
  }

  passed = SightTracePassed(eyePos, target.origin, false, target);
  if(passed) {
    return true;
  }

  front = target GetPointInBounds(1, 0, 0);
  passed = SightTracePassed(eyePos, front, false, target);
  if(passed) {
    return true;
  }

  back = target GetPointInBounds(-1, 0, 0);
  passed = SightTracePassed(eyePos, back, false, target);
  if(passed) {
    return true;
  }

  return false;
}

StingerDebugDraw(target) {
  if(GetDVar("missileDebugDraw") != "1") {
    return;
  }
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

  if(self.stingerLostSightlineTime == 0) {
    self.stingerLostSightlineTime = getTime();
  }

  timePassed = GetTime() - self.stingerLostSightlineTime;

  if(timePassed >= LOST_SIGHT_LIMIT) {
    ResetStingerLocking();
    return false;
  }

  return true;
}

GetTargetList() {
  targets = [];

  if(inVirtualLobby()) {
    return targets;
  }

  if(level.teamBased) {
    if(isDefined(level.chopper) && (level.chopper.team != self.team || (isDefined(level.chopper.owner) && level.chopper.owner == self))) {
      targets[targets.size] = level.chopper;
    }

    if(isDefined(level.ac130player) && level.ac130player.team != self.team) {
      targets[targets.size] = level.ac130.planemodel;
    }

    if(isDefined(level.orbitalsupport_player) && level.orbitalsupport_player.team != self.team) {
      targets[targets.size] = level.orbitalsupport_planemodel;
    }

    if(isDefined(level.SpawnedWarbirds)) {
      foreach(warbird in level.SpawnedWarbirds) {
        if(isDefined(warbird) && warbird.team != self.team) {
          targets[targets.size] = warbird;
        }
      }
    }

    if(isDefined(level.harriers)) {
      foreach(harrier in level.harriers) {
        if(isDefined(harrier) && (harrier.team != self.team || (isDefined(harrier.owner) && harrier.owner == self))) {
          targets[targets.size] = harrier;
        }
      }
    }

    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        if(self.team != level.teamNameList[i]) {
          if(level.UAVModels[level.teamNameList[i]].size) {
            foreach(UAV in level.UAVModels[level.teamNameList[i]]) {
              targets[targets.size] = UAV;
            }
          }
        }
      }
    } else if(level.UAVModels[level.otherTeam[self.team]].size) {
      foreach(UAV in level.UAVModels[level.otherTeam[self.team]]) {
        targets[targets.size] = UAV;
      }
    }

    if(isDefined(level.littleBirds)) {
      foreach(lb in level.littleBirds) {
        if(isDefined(lb) && (lb.team != self.team || (isDefined(lb.owner) && lb.owner == self))) {
          targets[targets.size] = lb;
        }
      }
    }

    if(isDefined(level.ugvs)) {
      foreach(ugv in level.ugvs) {
        if(isDefined(ugv) && (ugv.team != self.team || (isDefined(ugv.owner) && ugv.owner == self))) {
          targets[targets.size] = ugv;
        }
      }
    }

  } else {
    if(isDefined(level.chopper)) {
      targets[targets.size] = level.chopper;
    }

    if(isDefined(level.ac130player)) {
      targets[targets.size] = level.ac130.planemodel;
    }

    if(isDefined(level.harriers)) {
      foreach(harrier in level.harriers) {
        if(isDefined(harrier)) {
          targets[targets.size] = harrier;
        }
      }
    }

    if(level.UAVModels.size) {
      foreach(ownerGuid, UAV in level.UAVModels) {
        if(isDefined(UAV.owner) && UAV.owner == self) {
          continue;
        }

        targets[targets.size] = UAV;
      }
    }

    if(isDefined(level.littleBirds)) {
      foreach(lb in level.littleBirds) {
        if(!isDefined(lb)) {
          continue;
        }

        targets[targets.size] = lb;
      }
    }

    if(isDefined(level.ugvs)) {
      foreach(ugv in level.ugvs) {
        if(!isDefined(ugv)) {
          continue;
        }

        targets[targets.size] = ugv;
      }
    }

  }

  return targets;
}

StingerUsageLoop() {
  if(!IsPlayer(self)) {
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

    if(IsSubStr(weapon, "stingerm7")) {
      continue;
    }

    if(weapon != "stinger_mp" && weapon != "iw5_maaws_mp") {
      ResetStingerLocking();
      continue;
    }

    self.stingerUseEntered = true;

    if(!isDefined(self.stingerStage)) {
      self.stingerStage = 0;
    }

    StingerDebugDraw(self.stingerTarget);

    if(self.stingerStage == 0) {
      targets = GetTargetList();
      if(targets.size == 0) {
        continue;
      }

      targetsInReticle = [];
      foreach(target in targets) {
        if(!isDefined(target)) {
          continue;
        }

        insideReticle = self WorldPointInReticle_Circle(target.origin, 65, 75);

        if(insideReticle) {
          targetsInReticle[targetsInReticle.size] = target;
        }
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
        if(timePassed < (LOCK_LENGTH * 0.5)) {
          continue;
        }
      } else {
        if(timePassed < LOCK_LENGTH) {
          continue;
        }
      }

      self notify("stop_javelin_locking_feedback");
      thread LoopStingerLockedFeedback();

      self WeaponLockFinalize(self.stingerTarget);

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