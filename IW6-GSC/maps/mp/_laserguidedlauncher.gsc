/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_laserguidedlauncher.gsc
********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

CONST_LOCK_ON_TIME_MSEC = 1500;

LGM_init(fxSplit, fxHoming) {
  level._effect["laser_guided_launcher_missile_split"] = LoadFX(fxSplit);
  level._effect["laser_guided_launcher_missile_spawn_homing"] = LoadFX(fxHoming);
}

LGM_update_launcherUsage(weaponName, weaponNameHoming) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self thread LGM_monitorLaser();

  weaponCurr = self GetCurrentWeapon();
  while(1) {
    while(weaponCurr != weaponName) {
      self waittill("weapon_change", weaponCurr);
    }

    self childthread LGM_firing_monitorMissileFire(weaponCurr, weaponNameHoming);

    self waittill("weapon_change", weaponCurr);

    self LGM_firing_endMissileFire();
  }
}

LGM_monitorLaser() {
  self endon("LGM_player_endMonitorFire");

  self waittill_any("death", "disconnect");

  if(isDefined(self)) {
    self LGM_disableLaser();
  }
}

LASER_GUIDED_MISSILE_LASER_TRACE_CLOSE_TIME_MSEC = 400;
LASER_GUIDED_MISSILE_LASER_TRACE_LENGTH_SHORT = 800;
LASER_GUIDED_MISSILE_LASER_TRACE_LENGTH = 8000;
LASER_GUIDED_MISSILE_DELAY_CHILDREN_SPAWN = 0.35;
LASER_GUIDED_MISSILE_DELAY_CHILDREN_TRACK = 0.1;
LASER_GUIDED_MISSILE_PITCH_CHILDREN_DIVERGE = 20;
LASER_GUIDED_MISSILE_YAW_CHILDREN_DIVERGE = 20;

LGM_firing_endMissileFire() {
  self LGM_disableLaser();

  self notify("LGM_player_endMonitorFire");
}

LGM_firing_monitorMissileFire(weaponName, weaponNameChild, weaponNameHoming) {
  self endon("LGM_player_endMonitorFire");

  self LGM_enableLaser();

  entTarget = undefined;

  while(1) {
    missile = undefined;
    self waittill("missile_fire", missile, weaponNotified);

    if(isDefined(missile.isMagicBullet) && missile.isMagicBullet) {
      continue;
    }
    if(weaponNotified != weaponName) {
      continue;
    }
    if(!isDefined(entTarget)) {
      entTarget = LGM_requestMissileGuideEnt(self);
    }

    self thread LGM_firing_delaySpawnChildren(weaponName, weaponNameChild, weaponNameHoming, LASER_GUIDED_MISSILE_DELAY_CHILDREN_SPAWN, LASER_GUIDED_MISSILE_DELAY_CHILDREN_TRACK, missile, entTarget);
  }
}

LGM_firing_delaySpawnChildren(weaponName, weaponNameChild, weaponNameHoming, delaySpawn, delayTrack, missile, entTarget) {
  self notify("monitor_laserGuidedMissile_delaySpawnChildren");
  self endon("monitor_laserGuidedMissile_delaySpawnChildren");

  self endon("death");
  self endon("LGM_player_endMonitorFire");

  LGM_missilesNotifyAndRelease(entTarget);

  wait(delaySpawn);

  if(!IsValidMissile(missile)) {
    return;
  }
  missileOrigin = missile.origin;
  missileFwd = anglesToForward(missile.angles);
  missileUp = AnglesToUp(missile.angles);
  missileRight = AnglesToRight(missile.angles);

  missile Delete();

  playFX(level._effect["laser_guided_launcher_missile_split"], missileOrigin, missileFwd, missileUp);

  missiles = [];

  for(i = 0; i < 2; i++) {
    pitch = LASER_GUIDED_MISSILE_PITCH_CHILDREN_DIVERGE;
    yaw = 0;

    if(i == 0) {
      yaw = LASER_GUIDED_MISSILE_YAW_CHILDREN_DIVERGE;
    } else if(i == 1) {
      yaw = -1 * LASER_GUIDED_MISSILE_YAW_CHILDREN_DIVERGE;
    } else if(i == 2) {}

    childMissileFwd = RotatePointAroundVector(missileRight, missileFwd, pitch);
    childMissileFwd = RotatePointAroundVector(missileUp, childMissileFwd, yaw);

    missileChild = MagicBullet(weaponNameChild, missileOrigin, missileOrigin + childMissileFwd * 180, self);
    missileChild.isMagicBullet = true;
    missiles[missiles.size] = missileChild;

    waitframe();
  }

  wait(delayTrack);

  missiles = LGM_removeInvalidMissiles(missiles);

  if(missiles.size > 0) {
    foreach(missChild in missiles) {
      entTarget.missilesChasing[entTarget.missilesChasing.size] = missChild;
      missChild Missile_SetTargetEnt(entTarget);

      self thread LGM_onMissileNotifies(entTarget, missChild);
    }

    self thread LGM_firing_monitorPlayerAim(entTarget, weaponNameHoming);
  }
}

LGM_onMissileNotifies(entTarget, missile) {
  missile waittill_any("death", "missile_pairedWithFlare", "LGM_missile_abandoned");

  if(isDefined(entTarget.missilesChasing) && entTarget.missilesChasing.size > 0) {
    entTarget.missilesChasing = array_remove(entTarget.missilesChasing, missile);
    entTarget.missilesChasing = LGM_removeInvalidMissiles(entTarget.missilesChasing);
  }

  if(!isDefined(entTarget.missilesChasing) || entTarget.missilesChasing.size == 0) {
    self notify("LGM_player_allMissilesDestroyed");
  }
}

LGM_firing_monitorPlayerAim(entTarget, weaponNameHoming) {
  self notify("LGM_player_newMissilesFired");
  self endon("LGM_player_newMissilesFired");

  self endon("LGM_player_allMissilesDestroyed");
  self endon("LGM_player_endMonitorFire");
  self endon("death");
  self endon("disconnect");

  originGoal = undefined;
  targetVeh = undefined;
  lockOnTime = undefined;
  lockedOn = false;

  timeTraceFar = GetTime() + LASER_GUIDED_MISSILE_LASER_TRACE_CLOSE_TIME_MSEC;

  while(isDefined(entTarget.missilesChasing) && entTarget.missilesChasing.size > 0) {
    targetLook = self LGM_targetFind();

    if(!isDefined(targetLook)) {
      if(isDefined(targetVeh)) {
        self notify("LGM_player_targetLost");
        targetVeh = undefined;

        foreach(missile in entTarget.missilesChasing) {
          missile notify("missile_targetChanged");
        }
      }

      lockOnTime = undefined;
      lockedOn = false;

      traceDist = ter_op(GetTime() > timeTraceFar, LASER_GUIDED_MISSILE_LASER_TRACE_LENGTH, LASER_GUIDED_MISSILE_LASER_TRACE_LENGTH_SHORT);
      viewDir = anglesToForward(self GetPlayerAngles());
      startPos = self getEye() + viewDir * 12;
      trace = bulletTrace(startPos, startPos + viewDir * traceDist, true, self, false, false, false);

      originGoal = trace["position"];
    } else {
      originGoal = targetLook.origin;

      newTarget = !isDefined(targetVeh) || targetLook != targetVeh;
      targetVeh = targetLook;

      if(newTarget || !isDefined(lockOnTime)) {
        lockOnTime = GetTime() + CONST_LOCK_ON_TIME_MSEC;
        level thread LGM_locking_think(targetVeh, self);
      } else if(GetTime() >= lockOnTime) {
        lockedOn = true;
        self notify("LGM_player_lockedOn");
      }

      if(lockedOn) {
        waittillframeend;

        if(entTarget.missilesChasing.size > 0) {
          missileOrigins = [];

          foreach(missile in entTarget.missilesChasing) {
            if(!IsValidMissile(missile)) {
              continue;
            }
            missileOrigins[missileOrigins.size] = missile.origin;

            missile notify("missile_targetChanged");
            missile notify("LGM_missile_abandoned");
            missile Delete();
          }

          if(missileOrigins.size > 0) {
            level thread LGM_locked_think(targetVeh, self, weaponNameHoming, missileOrigins);
          }

          entTarget.missilesChasing = [];
        } else {
          break;
        }
      } else if(newTarget) {
        LGM_targetNotifyMissiles(targetVeh, self, entTarget.missilesChasing);
      }
    }

    entTarget.origin = originGoal;

    waitframe();
  }
}

TARGET_ENT_COUNT_PREFERRED_MAX = 4;

LGM_requestMissileGuideEnt(player) {
  if(!isDefined(level.laserGuidedMissileEnts_inUse)) {
    level.laserGuidedMissileEnts_inUse = [];
  }

  if(!isDefined(level.laserGuidedMissileEnts_ready)) {
    level.laserGuidedMissileEnts_ready = [];
  }

  ent = undefined;

  if(level.laserGuidedMissileEnts_ready.size) {
    ent = level.laserGuidedMissileEnts_ready[0];
    level.laserGuidedMissileEnts_ready = array_remove(level.laserGuidedMissileEnts_ready, ent);
  } else {
    ent = spawn("script_origin", player.origin);
  }

  level.laserGuidedMissileEnts_inUse[level.laserGuidedMissileEnts_inUse.size] = ent;

  level thread LGM_monitorLaserEntCleanUp(ent, player);

  ent.missilesChasing = [];

  return ent;
}

LGM_monitorLaserEntCleanUp(entTarget, player) {
  player waittill_any("death", "disconnect", "LGM_player_endMonitorFire");

  AssertEx(array_contains(level.laserGuidedMissileEnts_inUse, entTarget), "LGM_monitorLaserEntCleanUp() attempting to clean up laser target ent not currently in use.");

  AssertEx(isDefined(entTarget.missilesChasing) && IsArray(entTarget.missilesChasing), "LGM_monitorLaserEntCleanUp() given missile ent with now missile array.");
  foreach(missile in entTarget.missilesChasing) {
    if(IsValidMissile(missile)) {
      missile Missile_ClearTarget();
    }
  }

  entTarget.missilesChasing = undefined;

  level.laserGuidedMissileEnts_inUse = array_remove(level.laserGuidedMissileEnts_inUse, entTarget);

  if(level.laserGuidedMissileEnts_ready.size + level.laserGuidedMissileEnts_inUse.size < TARGET_ENT_COUNT_PREFERRED_MAX) {
    level.laserGuidedMissileEnts_ready[level.laserGuidedMissileEnts_ready.size] = entTarget;
  } else {
    entTarget Delete();
  }
}

LGM_locking_think(targetVeh, player) {
  AssertEx(isDefined(player), "LGM_locking_think called with undefined player.");

  outline = outlineEnableForPlayer(targetVeh, "orange", player, true, "killstreak_personal");

  level thread LGM_locking_loopSound(player, "maaws_reticle_tracking", 1.5, "LGM_player_lockingDone");
  level thread LGM_locking_notifyOnTargetDeath(targetVeh, player);

  player waittill_any("death", "disconnect", "LGM_player_endMonitorFire", "LGM_player_newMissilesFired", "LGM_player_targetLost", "LGM_player_lockedOn", "LGM_player_allMissilesDestroyed", "LGM_player_targetDied");

  if(isDefined(targetVeh)) {
    outlineDisable(outline, targetVeh);
  }

  if(isDefined(player)) {
    player notify("LGM_player_lockingDone");

    player StopLocalSound("maaws_reticle_tracking");
  }
}

LGM_locked_missileOnDeath(missile, targetVeh, groupID) {
  targetVeh endon("death");

  missile waittill("death");

  targetVeh.LG_missilesLocked[groupID] = array_remove(targetVeh.LG_missilesLocked[groupID], missile);

  if(targetVeh.LG_missilesLocked[groupID].size == 0) {
    targetVeh.LG_missilesLocked[groupID] = undefined;
    targetVeh notify("LGM_target_lockedMissilesDestroyed");
  }
}

LGM_locking_notifyOnTargetDeath(target, player) {
  player endon("death");
  player endon("disconnect");
  player endon("LGM_player_lockingDone");

  target waittill("death");

  player notify("LGM_player_targetDied");
}

LGM_locking_loopSound(player, sound, time, endonPlayer) {
  player endon("death");
  player endon("disconnect");
  player endon(endOnPlayer);

  while(1) {
    player PlayLocalSound(sound);
    wait(time);
  }
}

LGM_locked_spawnMissiles(target, player, weaponNameHoming, missileOrigins) {
  target endon("death");
  player endon("death");
  player endon("disconnect");

  missilesLocked = [];

  for(i = 0; i < missileOrigins.size; i++) {
    missileChild = MagicBullet(weaponNameHoming, missileOrigins[i], target.origin, player);
    missileChild.isMagicBullet = true;
    missilesLocked[missilesLocked.size] = missileChild;

    playFX(level._effect["laser_guided_launcher_missile_spawn_homing"], missileChild.origin, anglesToForward(missileChild.angles), AnglesToUp(missileChild.angles));

    waitframe();
  }

  return missilesLocked;
}

LGM_locked_think(targetVeh, player, weaponNameHoming, missileOrigins) {
  AssertEx(missileOrigins.size > 0, "LGM_locked_think() passed empty missile origin array.");

  if(missileOrigins.size == 0) {
    return;
  }
  missilesLocked = LGM_locked_spawnMissiles(targetVeh, player, weaponNameHoming, missileOrigins);

  if(!isDefined(missilesLocked)) {
    return;
  }
  missilesLocked = LGM_removeInvalidMissiles(missilesLocked);
  if(missilesLocked.size == 0) {
    return;
  }
  player PlayLocalSound("maaws_reticle_locked");
  outlineID = outlineEnableForPlayer(targetVeh, "red", player, false, "killstreak_personal");

  targetOffset = LGM_getTargetOffset(targetVeh);

  foreach(mChild in missilesLocked) {
    mChild missile_setTargetAndFlightMode(targetVeh, "direct", targetOffset);

    LGM_targetNotifyMissiles(targetVeh, player, missilesLocked);
  }

  if(!isDefined(targetVeh.LG_missilesLocked)) {
    targetVeh.LG_missilesLocked = [];
  }

  targetVeh.LG_missilesLocked[outlineID] = missilesLocked;

  foreach(vMiss in missilesLocked) {
    level thread LGM_locked_missileOnDeath(vMiss, targetVeh, outlineID);
  }

  outlineOn = true;
  while(outlineOn) {
    msg = targetVeh waittill_any_return("death", "LGM_target_lockedMissilesDestroyed");

    if(msg == "death") {
      outlineOn = false;
      if(isDefined(targetVeh)) {
        targetVeh.LG_missilesLocked[outlineID] = undefined;
      }
    } else if(msg == "LGM_target_lockedMissilesDestroyed") {
      waittillframeend;

      if(!isDefined(targetVeh.LG_missilesLocked[outlineID]) || targetVeh.LG_missilesLocked[outlineID].size == 0) {
        outlineOn = false;
      }
    }
  }

  if(isDefined(targetVeh)) {
    outlineDisable(outlineID, targetVeh);
  }
}

LGM_targetFind() {
  targets = self maps\mp\gametypes\_weapons::lockOnLaunchers_getTargetArray();
  targets = SortByDistance(targets, self.origin);

  targetLook = undefined;
  foreach(target in targets) {
    if(self WorldPointInReticle_Circle(target.origin, 65, 75)) {
      targetLook = target;
      break;
    }
  }

  return targetLook;
}

LGM_enableLaser() {
  if(!isDefined(self.laserGuidedLauncher_laserOn) || self.laserGuidedLauncher_laserOn == false) {
    self.laserGuidedLauncher_laserOn = true;
    self enableWeaponLaser();
  }
}

LGM_disableLaser() {
  if(isDefined(self.laserGuidedLauncher_laserOn) && self.laserGuidedLauncher_laserOn == true) {
    self disableWeaponLaser();
  }

  self.laserGuidedLauncher_laserOn = undefined;
}

LGM_removeInvalidMissiles(missiles) {
  valid = [];
  foreach(m in missiles) {
    if(IsValidMissile(m)) {
      valid[valid.size] = m;
    }
  }
  return valid;
}

LGM_targetNotifyMissiles(targetVeh, attacker, missiles) {
  level notify("laserGuidedMissiles_incoming", attacker, missiles, targetVeh);
  targetVeh notify("targeted_by_incoming_missile", missiles);
}

LGM_getTargetOffset(target) {
  targetPoint = undefined;

  if(target.model != "vehicle_av8b_harrier_jet_mp")
    targetPoint = target GetTagOrigin("tag_missile_target");
  else
    targetPoint = target GetTagOrigin("tag_body");

  if(!isDefined(targetPoint)) {
    targetPoint = target GetPointInBounds(0, 0, 0);
    AssertMsg("LGM_getTargetOffset() failed to find tag_missile_target on entity." + target.classname);
  }

  return targetPoint - target.origin;
}

LGM_missilesNotifyAndRelease(entTarget) {
  if(isDefined(entTarget.missilesChasing) && entTarget.missilesChasing.size > 0) {
    foreach(missChasing in entTarget.missilesChasing) {
      if(IsValidMissile(missChasing)) {
        missChasing notify("missile_targetChanged");
        missChasing notify("LGM_missile_abandoned");
        missChasing Missile_ClearTarget();
      }
    }
  }

  entTarget.missilesChasing = [];
}