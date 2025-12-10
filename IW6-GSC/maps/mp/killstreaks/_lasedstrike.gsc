/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_lasedstrike.gsc
************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.killStreakFuncs["lasedStrike"] = ::tryUseLasedStrike;
  level.numberOfSoflamAmmo = 2;

  level.lasedStrikeGlow = loadfx("fx/misc/laser_glow");
  level.lasedStrikeExplode = LoadFX("fx/explosions/uav_advanced_death");

  remoteMissileSpawnArray = getEntArray("remoteMissileSpawn", "targetname");
  foreach(startPoint in remoteMissileSpawnArray) {
    if(isDefined(startPoint.target))
      startPoint.targetEnt = getEnt(startPoint.target, "targetname");
  }
  level.lasedStrikeEnts = remoteMissileSpawnArray;

  thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
    player.soflamAmmoUsed = 0;
    player.hasSoflam = false;
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

  }
}

tryUseLasedStrike(lifeId, streakName) {
  return useLasedStrike();
}

useLasedStrike() {
  used = self watchSoflamUsage();

  if(isDefined(used) && used) {
    self.hasSoflam = false;
    return true;
  } else {
    return false;
  }
}

giveMarker() {
  self maps\mp\killstreaks\_killstreaks::giveKillstreakWeapon("iw5_soflam_mp");

  self.hasSoflam = true;
  self thread watchSoflamUsage();
}

watchSoflamUsage() {
  self notify("watchSoflamUsage");
  self endon("watchSoflamUsage");

  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  while(self isChangingWeapon())
    wait(0.05);

  for(;;) {
    if(self AttackButtonPressed() && self GetCurrentWeapon() == "iw5_soflam_mp" && self AdsButtonPressed()) {
      self WeaponLockTargetTooClose(false);
      self WeaponLockFree();

      targetInfo = getTargetPoint();

      if(!isDefined(targetInfo)) {
        wait 0.05;
        continue;
      }

      if(!isDefined(targetInfo[0])) {
        wait 0.05;
        continue;
      }

      targPoint = targetInfo[0];

      used = self attackLasedTarget(targPoint);

      if(used)
        self.soflamAmmoUsed++;

      if(self.soflamAmmoUsed >= level.numberOfSoflamAmmo)
        return true;
    }

    if(self isChangingWeapon())
      return false;

    wait(0.05);
  }

}

playLockSound() {
  if(isDefined(self.playingLockSound) && self.playingLockSound) {
    return;
  }
  self PlayLocalSound("javelin_clu_lock");
  self.playingLockSound = true;

  wait(.75);

  self StopLocalSound("javelin_clu_lock");
  self.playingLockSound = false;
}

playLockErrorSound() {
  if(isDefined(self.playingLockSound) && self.playingLockSound) {
    return;
  }
  self PlayLocalSound("javelin_clu_aquiring_lock");
  self.playingLockSound = true;

  wait(.75);

  self StopLocalSound("javelin_clu_aquiring_lock");
  self.playingLockSound = false;
}

attackLasedTarget(targPoint) {
  finalTargetEnt = undefined;
  midTargetEnt = undefined;

  upQuantity = 6000;
  upVector = (0, 0, upQuantity);
  backDist = 3000;
  forward = anglesToForward(self.angles);
  ownerOrigin = self.origin;
  startpos = ownerOrigin + upVector + forward * backDist * -1;

  foundAngle = false;

  skyTrace = bulletTrace(targPoint + (0, 0, upQuantity), targPoint, false);
  if(skyTrace["fraction"] > .99) {
    foundAngle = true;
    startPos = targPoint + (0, 0, upQuantity);
  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (300, 0, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (300, 0, upQuantity);
    }

  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (0, 300, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (0, 300, upQuantity);
    }

  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (0, -300, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (0, -300, upQuantity);
    }

  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (300, 300, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (300, 300, upQuantity);
    }

  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (-300, 0, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (-300, 0, upQuantity);
    }

  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (-300, -300, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (-300, -300, upQuantity);
    }

  }

  if(!foundAngle) {
    skyTrace = bulletTrace(targPoint + (300, -300, upQuantity), targPoint, false);
    if(skyTrace["fraction"] > .99) {
      foundAngle = true;
      startPos = targPoint + (300, -300, upQuantity);
    }

  }

  if(!foundAngle) {
    for(i = 0; i < 5; i++) {
      upQuantity = upQuantity / 2;
      upVector = (0, 0, upQuantity);
      startpos = self.origin + upVector + forward * backDist * -1;

      targetSkyCheck = bulletTrace(targPoint, startpos, false);
      if(targetSkyCheck["fraction"] > .99) {
        foundAngle = true;
        break;
      }
      wait(0.05);
    }
  }

  if(!foundAngle) {
    for(i = 0; i < 5; i++) {
      upQuantity = upQuantity * 2.5;

      upVector = (0, 0, upQuantity);
      startpos = self.origin + upVector + forward * backDist * -1;

      targetSkyCheck = bulletTrace(targPoint, startpos, false);
      if(targetSkyCheck["fraction"] > .99) {
        foundAngle = true;
        break;
      }
      wait(0.05);
    }
  }

  if(!foundAngle) {
    self thread cantHitTarget();
    return false;
  }

  finalTargetEnt = SpawnFx(level.lasedStrikeGlow, targPoint);

  self thread playLockSound();

  self WeaponLockFinalize(targPoint, (0, 0, 0), false);

  missile = MagicBullet("lasedStrike_missile_mp", startPos, targPoint, self);
  missile Missile_SetTargetEnt(finalTargetEnt);

  self thread loopTriggeredeffect(finalTargetEnt, missile);

  missile waittill("death");

  if(isDefined(finalTargetEnt)) {
    finalTargetEnt delete();
  }

  self WeaponLockFree();
  return true;
}

loopTriggeredEffect(effect, missile) {
  missile endon("death");
  level endon("game_ended");

  for(;;) {
    TriggerFX(effect);
    wait(0.05);
  }

}

lasedMissileDistance(remote) {
  levelendon("game_ended");
  remote endon("death");
  remote endon("remote_done");
  self endon("death");

  while(true) {
    targetDist = distance(self.origin, remote.targetent.origin);
    remote.owner SetClientDvar("ui_reaper_targetDistance", int(targetDist / 12));

    wait(0.05);
  }
}

cantHitTarget() {
  self thread playLockErrorSound();

  self WeaponLockTargetTooClose(true);
}

checkBestTargetVector(remote, targPoint) {
  foreach(ent in level.lasedStrikeEnts) {
    check = bulletTrace(ent.origin, targPoint, false, remote);
    if(check["fraction"] >= .98) {
      return ent;
    }

    wait(0.05);
  }

  return;
}

getTargetPoint() {
  origin = self getEye();
  angles = self GetPlayerAngles();
  forward = anglesToForward(angles);
  endpoint = origin + forward * 15000;

  res = bulletTrace(origin, endpoint, false, undefined);

  if(res["surfacetype"] == "none")
    return undefined;
  if(res["surfacetype"] == "default")
    return undefined;

  ent = res["entity"];
  if(isDefined(ent)) {
    if(ent == level.ac130.planeModel)
      return undefined;
  }

  results = [];
  results[0] = res["position"];
  results[1] = res["normal"];

  return results;
}

spawnRemote(owner) {
  remote = spawnPlane(owner, "script_model", level.UAVRig getTagOrigin("tag_origin"), "compass_objpoint_reaper_friendly", "compass_objpoint_reaper_enemy");
  if(!isDefined(remote))
    return undefined;

  remote setModel("vehicle_predator_b");
  remote.team = owner.team;
  remote.owner = owner;
  remote.numFlares = 2;

  remote setCanDamage(true);
  remote thread damageTracker();

  remote.heliType = "remote_mortar";

  remote.uavType = "remote_mortar";
  remote maps\mp\killstreaks\_uav::addUAVModel();

  zOffset = 6300;
  angle = randomInt(360);
  radiusOffset = 6100;
  xOffset = cos(angle) * radiusOffset;
  yOffset = sin(angle) * radiusOffset;
  angleVector = vectorNormalize((xOffset, yOffset, zOffset));
  angleVector = (angleVector * 6100);
  remote linkTo(level.UAVRig, "tag_origin", angleVector, (0, angle - 90, 10));

  remote thread handleDeath(owner);

  remote thread handleOwnerChangeTeam(owner);
  remote thread handleOwnerDisconnect(owner);
  remote thread handleTimeOut();

  remote thread handleIncomingStinger();
  remote thread handleIncomingSAM();

  return remote;
}

handleDeath(owner) {
  level endon("game_ended");
  owner endon("disconnect");
  self endon("remote_removed");
  selfendon("remote_done");

  self waittill("death");

  level thread removeRemote(self, true);
}

handleOwnerChangeTeam(owner) {
  level endon("game_ended");
  selfendon("remote_done");
  selfendon("death");
  owner endon("disconnect");
  owner endon("removed_reaper_ammo");

  owner waittill_any("joined_team", "joined_spectators");

  self thread remoteLeave();
}

handleOwnerDisconnect(owner) {
  level endon("game_ended");
  selfendon("remote_done");
  selfendon("death");
  owner endon("removed_reaper_ammo");

  owner waittill("disconnect");

  self thread remoteLeave();
}

shotCounter() {
  level endon("game_ended");
  self endon("death");
  selfendon("remote_done");

  numShotsFired = 0;

  for(;;) {
    self waittill("lasedTargetShotFired");

    numShotsFired++;

    if(numShotsFired >= 5) {
      break;
    }
  }

  self thread remoteLeave();
}

handleTimeOut() {
  level endon("game_ended");
  self endon("death");
  selfendon("remote_done");

  wait 120;

  self thread remoteLeave();
}

removeRemote(remote, clearLevelRef) {
  self notify("remote_removed");

  if(isDefined(remote.targetEnt))
    remote.targetEnt delete();

  level.lasedStrikeActive = false;
  level.lasedStrikeCrateActive = false;

  if(isDefined(remote)) {
    remote delete();
    remote maps\mp\killstreaks\_uav::removeUAVModel();
  }

  if(!isDefined(clearLevelRef) || clearLevelRef == true)
    level.remote_mortar = undefined;
}

remoteLeave() {
  level.remote_mortar = undefined;

  level endon("game_ended");
  selfendon("death");

  self notify("remote_done");

  destPoint = self.origin + (anglesToForward(self.angles) * 20000);
  self moveTo(destPoint, 30);
  playFXOnTag(level._effect["ac130_engineeffect"], self, "tag_origin");
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(3);

  self moveTo(destPoint, 4, 4, 0.0);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(4);

  level thread removeRemote(self, false);
}

remoteExplode() {
  self notify("death");
  self Hide();
  forward = (AnglesToRight(self.angles) * 200);
  playFX(level.lasedStrikeExplode, self.origin, forward);

  level.lasedStrikeActive = false;
  level.lasedStrikeCrateActive = false;
}

damageTracker() {
  level endon("game_ended");
  self.owner endon("disconnect");

  self.health = 999999;
  self.maxHealth = 1500;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
      continue;
    }
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION))
      self.wasDamagedFromBulletPenetration = true;

    self.wasDamaged = true;

    modifiedDamage = damage;

    if(IsPlayer(attacker)) {
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("");

      if(meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET") {
        if(attacker _hasPerk("specialty_armorpiercing"))
          modifiedDamage += damage * level.armorPiercingMod;
      }
    }

    if(isDefined(weapon)) {
      switch (weapon) {
        case "stinger_mp":
        case "javelin_mp":
          self.largeProjectileDamage = true;
          modifiedDamage = self.maxhealth + 1;
          break;

        case "sam_projectile_mp":
          self.largeProjectileDamage = true;
          break;
      }

      maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
    }

    self.damageTaken += modifiedDamage;

    if(isDefined(self.owner))
      self.owner playLocalSound("reaper_damaged");

    if(self.damageTaken >= self.maxHealth) {
      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        attacker notify("destroyed_killstreak", weapon);
        thread teamPlayerCardSplash("callout_destroyed_remote_mortar", attacker);
        attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", 50, weapon, meansOfDeath);
        attacker thread maps\mp\gametypes\_rank::xpEventPopup("destroyed_remote_mortar");
        thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, meansOfDeath, weapon);

      }

      if(isDefined(self.owner))
        self.owner StopLocalSound("missile_incoming");

      self thread remoteExplode();

      level.remote_mortar = undefined;
      return;
    }
  }
}

handleIncomingStinger() {
  level endon("game_ended");
  self endon("death");
  self endon("remote_done");

  while(true) {
    level waittill("stinger_fired", player, missile, lockTarget);

    if(!isDefined(lockTarget) || (lockTarget != self)) {
      continue;
    }
    missile thread stingerProximityDetonate(lockTarget, player);
  }
}

stingerProximityDetonate(missileTarget, player) {
  self endon("death");
  missileTarget endon("death");

  if(isDefined(missileTarget.owner))
    missileTarget.owner PlayLocalSound("missile_incoming");

  self Missile_SetTargetEnt(missileTarget);

  minDist = Distance(self.origin, missileTarget GetPointInBounds(0, 0, 0));
  lastCenter = missileTarget GetPointInBounds(0, 0, 0);

  while(true) {
    if(!isDefined(missileTarget))
      center = lastCenter;
    else
      center = missileTarget GetPointInBounds(0, 0, 0);

    lastCenter = center;

    curDist = Distance(self.origin, center);

    if(curDist < 3000 && missileTarget.numFlares > 0) {
      missileTarget.numFlares--;

      missileTarget thread maps\mp\killstreaks\_flares::flares_playFX();
      newTarget = missileTarget maps\mp\killstreaks\_flares::flares_deploy();

      self Missile_SetTargetEnt(newTarget);
      missileTarget = newTarget;

      if(isDefined(missileTarget.owner))
        missileTarget.owner StopLocalSound("missile_incoming");

      return;
    }

    if(curDist < minDist)
      minDist = curDist;

    if(curDist > minDist) {
      if(curDist > 1536) {
        return;
      }
      if(isDefined(missileTarget.owner)) {
        missileTarget.owner stopLocalSound("missile_incoming");

        if(level.teambased) {
          if(missileTarget.team != player.team)
            RadiusDamage(self.origin, 1000, 1000, 1000, player, "MOD_EXPLOSIVE", "stinger_mp");
        } else {
          RadiusDamage(self.origin, 1000, 1000, 1000, player, "MOD_EXPLOSIVE", "stinger_mp");
        }
      }

      self Hide();

      wait(0.05);
      self delete();
    }

    wait(0.05);
  }
}

handleIncomingSAM() {
  level endon("game_ended");
  self endon("death");
  self endon("remote_done");

  while(true) {
    level waittill("sam_fired", player, missileGroup, lockTarget);

    if(!isDefined(lockTarget) || (lockTarget != self)) {
      continue;
    }
    level thread samProximityDetonate(lockTarget, player, missileGroup);
  }
}

samProximityDetonate(missileTarget, player, missileGroup) {
  missileTarget endon("death");

  if(isDefined(missileTarget.owner))
    missileTarget.owner PlayLocalSound("missile_incoming");

  sam_projectile_damage = 150;
  sam_projectile_damage_radius = 1000;

  minDist = [];
  for(i = 0; i < missileGroup.size; i++) {
    if(isDefined(missileGroup[i]))
      minDist[i] = Distance(missileGroup[i].origin, missileTarget GetPointInBounds(0, 0, 0));
    else
      minDist[i] = undefined;
  }

  while(true) {
    center = missileTarget GetPointInBounds(0, 0, 0);

    curDist = [];
    for(i = 0; i < missileGroup.size; i++) {
      if(isDefined(missileGroup[i]))
        curDist[i] = Distance(missileGroup[i].origin, center);
    }

    for(i = 0; i < curDist.size; i++) {
      if(isDefined(curDist[i])) {
        if(curDist[i] < 3000 && missileTarget.numFlares > 0) {
          missileTarget.numFlares--;

          missileTarget thread maps\mp\killstreaks\_flares::flares_playFX();
          newTarget = missileTarget maps\mp\killstreaks\_flares::flares_deploy();

          for(j = 0; j < missileGroup.size; j++) {
            if(isDefined(missileGroup[j])) {
              missileGroup[j] Missile_SetTargetEnt(newTarget);
            }
          }

          if(isDefined(missileTarget.owner))
            missileTarget.owner StopLocalSound("missile_incoming");

          return;
        }

        if(curDist[i] < minDist[i])
          minDist[i] = curDist[i];

        if(curDist[i] > minDist[i]) {
          if(curDist[i] > 1536) {
            continue;
          }
          if(isDefined(missileTarget.owner)) {
            missileTarget.owner StopLocalSound("missile_incoming");

            if(level.teambased) {
              if(missileTarget.team != player.team)
                RadiusDamage(missileGroup[i].origin, sam_projectile_damage_radius, sam_projectile_damage, sam_projectile_damage, player, "MOD_EXPLOSIVE", "sam_projectile_mp");
            } else {
              RadiusDamage(missileGroup[i].origin, sam_projectile_damage_radius, sam_projectile_damage, sam_projectile_damage, player, "MOD_EXPLOSIVE", "sam_projectile_mp");
            }
          }

          missileGroup[i] Hide();

          wait(0.05);
          missileGroup[i] delete();
        }
      }
    }

    wait(0.05);
  }
}