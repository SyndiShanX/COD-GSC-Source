/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_lasedstrike_alien.gsc
************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_SOFLAM_AMMO = 3;

init() {
  level.lasedStrikeGlow = loadfx("fx/misc/laser_glow");
  level.lasedStrikeExplode = LoadFX("fx/explosions/uav_advanced_death");

  thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
    player.soflamAmmoUsed = 0;

  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self thread watch_alien_soflam_usage();
    self thread watch_alien_soflam_weaponswitch();
  }
}

watch_alien_soflam_weaponswitch() {
  self endon("disconnect");
  self endon("death");

  while(1) {
    self waittill("weapon_change", newWeapon);

    if(newWeapon == "aliensoflam_mp")
      self SetWeaponAmmoClip("aliensoflam_mp", CONST_SOFLAM_AMMO - self.soflamAmmoUsed);
  }
}

watch_alien_soflam_usage() {
  self notify("watchaliensoflamusage");
  self endon("watchaliensoflamusage");

  level endon("game_ended");
  self endon("disconnect");

  while(self isChangingWeapon())
    wait(0.05);

  for(;;) {
    if(self AttackButtonPressed() && self GetCurrentWeapon() == "aliensoflam_mp" && self AdsButtonPressed() && !self IsUsingTurret()) {
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

      self attackLasedTarget(targPoint);
    }

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
  self thread update_soflam_ammocount();

  missile = MagicBullet("aliensoflam_missle_mp", startPos, targPoint, self);
  missile Missile_SetTargetEnt(finalTargetEnt);

  self thread loopTriggeredeffect(finalTargetEnt, missile);

  self WeaponLockFree();
  missile waittill("death");

  if(isDefined(finalTargetEnt)) {
    finalTargetEnt delete();
  }

  Earthquake(.4, 1, targPoint, 850);
  return true;
}

loopTriggeredEffect(effect, missile) {
  missile endon("death");
  level endon("game_ended");

  for(;;) {
    TriggerFX(effect);
    wait(0.5);
  }
}

cantHitTarget() {
  self thread playLockErrorSound();

  self WeaponLockTargetTooClose(true);
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

  results = [];
  results[0] = res["position"];
  results[1] = res["normal"];

  return results;
}

update_soflam_ammocount() {
  self.soflamAmmoUsed++;
  self SetWeaponAmmoClip("aliensoflam_mp", CONST_SOFLAM_AMMO - self.soflamAmmoUsed);
  if(self.soflamAmmoUsed >= CONST_SOFLAM_AMMO) {
    self.soflamAmmoUsed = 0;
    self takeweapon("aliensoflam_mp");
    if(!maps\mp\alien\_utility::is_true(self.has_special_weapon) && !maps\mp\alien\_utility::is_true(self.is_holding_deployable))
      self SwitchToWeapon(self GetWeaponsListPrimaries()[0]);
  }

}