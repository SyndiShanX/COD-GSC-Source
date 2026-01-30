/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_equipment.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_weapons;

watchTrophyUsage() {
  self endon("spawned_player");
  self endon("disconnect");

  self.trophyArray = [];
  while(1) {
    self waittill("grenade_fire", grenade, weapname);
    if(weapname == "trophy" || weapname == "trophy_mp") {
      if(!IsAlive(self)) {
        grenade delete();
        return;
      }

      grenade Hide();
      grenade waittill("missile_stuck");
      distanceZ = 40;
      if(distanceZ * distanceZ < DistanceSquared(grenade.origin, self.origin)) {
        secTrace = bulletTrace(self.origin, self.origin - (0, 0, distanceZ), false, self);

        if(secTrace["fraction"] == 1) {
          grenade delete();
          self SetWeaponAmmoStock("trophy_mp", self GetWeaponAmmoStock("trophy_mp") + 1);
          continue;
        }

        grenade.origin = secTrace["position"];
      }
      grenade Show();

      self.trophyArray = array_removeUndefined(self.trophyArray);

      if(self.trophyArray.size >= level.maxPerPlayerExplosives) {
        self.trophyArray[0] thread trophyBreak();
      }

      trophy = spawn("script_model", grenade.origin);
      assert(isDefined(trophy));

      trophy setModel("mp_trophy_system");
      trophy thread maps\mp\gametypes\_weapons::createBombSquadModel("mp_trophy_system_bombsquad", "tag_origin", self);
      trophy.angles = grenade.angles;

      self.trophyArray[self.trophyArray.size] = trophy;
      trophy.owner = self;
      trophy.team = self.team;
      trophy.weaponName = weapname;
      trophy.stunned = false;
      level.trophies[level.trophies.size] = trophy;

      if(isDefined(self.trophyRemainingAmmo) && self.trophyRemainingAmmo > 0) {
        trophy.ammo = self.trophyRemainingAmmo;
      } else {
        trophy.ammo = 2;
      }

      trophy.trigger = spawn("script_origin", trophy.origin);

      trophy thread trophyDamage(self);
      trophy thread trophyActive(self);
      trophy thread trophyDisconnectWaiter(self);
      trophy thread trophyPlayerSpawnWaiter(self);
      trophy thread trophyUseListener(self);

      trophy thread c4EMPKillstreakWait();

      if(level.teamBased) {
        trophy maps\mp\_entityheadicons::setTeamHeadIcon(trophy.team, (0, 0, 65));
      } else {
        trophy maps\mp\_entityheadicons::setPlayerHeadIcon(trophy.owner, (0, 0, 65));
      }

      wait(0.05);
      if(isDefined(grenade)) {
        grenade Delete();
      }
    }
  }
}

trophyStunBegin() {
  if(self.stunned) {
    return;
  }

  self.stunned = true;
  playFXOnTag(getfx("mine_stunned"), self, "tag_origin");
}

trophyStunEnd() {
  self.stunned = false;
  stopFXOnTag(getfx("mine_stunned"), self, "tag_origin");
}

trophyChangeOwner(newOwner) {
  if(isDefined(self.entityHeadIcon)) {
    self.entityHeadIcon destroy();
  }

  self notify("change_owner");

  self.owner = newOwner;
  self.team = newOwner.team;
  newOwner.trophyArray[newOwner.trophyArray.size] = self;

  if(level.teamBased) {
    self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 65));
  } else {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 65));
  }

  self thread trophyDamage(newOwner);
  self thread trophyActive(newOwner);
  self thread trophyDisconnectWaiter(newOwner);
  self thread trophyPlayerSpawnWaiter(newOwner);
}

trophyUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");
  owner endon("death");

  self.trigger setCursorHint("HINT_NOICON");
  self.trigger setHintString(&"MP_PICKUP_TROPHY");
  self.trigger setSelfUsable(owner);
  self.trigger thread notUsableForJoiningPlayers(owner);

  for(;;) {
    self.trigger waittill("trigger", owner);

    owner playLocalSound("scavenger_pack_pickup");

    currentClipAmmo = owner GetWeaponAmmoClip("trophy_mp");
    owner SetWeaponAmmoClip("trophy_mp", currentClipAmmo + 1);
    owner.trophyRemainingAmmo = self.ammo;
    self.trigger delete();
    self delete();
    self notify("death");
  }
}

trophyPlayerSpawnWaiter(owner) {
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");

  owner waittill("spawned");
  self thread trophyBreak();
}

trophyDisconnectWaiter(owner) {
  self endon("death");
  self endon("change_owner");

  owner waittill("disconnect");
  self thread trophyBreak();
}

trophyActive(owner, radius, ignoreAmmo, trophyName) {
  owner endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");

  if(!isDefined(radius)) {
    radius = 384;
  }

  if(!isDefined(ignoreAmmo)) {
    ignoreAmmo = false;
  }

  if(!isDefined(trophyName)) {
    trophyName = "exorepulsor_equipment_mp";
  }

  radiusSq = radius * radius;

  for(;;) {
    if(!isDefined(level.grenades) || (level.grenades.size < 1 && level.missiles.size < 1 && level.trackingDrones.size < 1) || isDefined(self.disabled) || self.stunned == true) {
      wait(.05);
      continue;
    }

    sentryTargets = array_combine(level.grenades, level.missiles);

    sentryTargets = array_combine(sentryTargets, level.trackingDrones);

    if(sentryTargets.size < 1) {
      wait(.05);
      continue;
    }

    foreach(grenade in sentryTargets) {
      wait(.05);

      if(!isDefined(grenade)) {
        continue;
      }

      if(grenade == self) {
        continue;
      }

      if(isDefined(grenade.weaponName)) {
        switch (grenade.weaponName) {
          case "claymore_mp":
          case "orbital_carepackage_pod_mp":
          case "orbital_carepackage_droppod_mp":
            continue;
        }
      }

      switch (grenade.model) {
        case "mp_trophy_system":
        case "weapon_radar":
        case "weapon_jammer":
        case "weapon_parabolic_knife":
          continue;
      }

      if(!isDefined(grenade.owner)) {
        grenade.owner = GetMissileOwner(grenade);
      }

      if(isDefined(grenade.owner) && level.teamBased && grenade.owner.team == owner.team) {
        continue;
      }

      if(isDefined(grenade.owner) && grenade.owner == owner) {
        continue;
      }

      if(!trophyWithinMinDot(grenade)) {
        continue;
      }

      grenadeDistanceSquared = DistanceSquared(grenade.origin, self.origin);

      if(grenadeDistanceSquared < radiusSq) {
        if(BulletTracePassed(grenade.origin, self.origin, false, self)) {
          fxOrigin = self.origin + (0, 0, 32);
          if(isDefined(self.laserEnt)) {
            fxOrigin = self.laserEnt.origin;
          }
          playFX(level.sentry_fire, fxOrigin, (grenade.origin - self.origin), AnglesToUp(self.angles));
          self thread trophyHandleLaser(owner, grenade);
          self playSound("trophy_detect_projectile");

          if((isDefined(grenade.classname) && grenade.classname == "rocket") &&
            (isDefined(grenade.type) && (grenade.type == "remote"))) {
            if(isDefined(grenade.type) && grenade.type == "remote") {
              level thread maps\mp\gametypes\_missions::vehicleKilled(grenade.owner, owner, undefined, owner, undefined, "MOD_EXPLOSIVE", trophyName);
              level thread teamPlayerCardSplash("callout_destroyed_predator_missile", owner);
              level thread maps\mp\gametypes\_rank::awardGameEvent("kill", owner, trophyName, undefined, "MOD_EXPLOSIVE");
              owner notify("destroyed_killstreak", trophyName);
            }

            if(isDefined(level.chopper_fx["explode"]["medium"])) {
              playFX(level.chopper_fx["explode"]["medium"], grenade.origin);
            }
            if(isDefined(level.barrelExpSound)) {
              grenade playSound(level.barrelExpSound);
            }
          }

          if(isDefined(grenade.type) && grenade.type == "tracking_drone") {
            grenade thread maps\mp\_tracking_drone::trackingDrone_leave();
          } else {
            owner thread projectileExplode(grenade, self);
            owner maps\mp\gametypes\_missions::processChallenge("ch_noboomforyou");
          }

          if(!ignoreAmmo) {
            self.ammo--;
          }

          if(self.ammo <= 0) {
            self thread trophyBreak();
          }
        }
      }
    }
  }

}

trophySetMinDot(minDot, trophyModelForwardAngleOffset) {
  if(!isDefined(trophyModelForwardAngleOffset)) {
    trophyModelForwardAngleOffset = (0, 0, 0);
  }

  self.minDot = minDot;
  self.trophyAngleOffset = trophyModelForwardAngleOffset;
}

trophyWithinMinDot(grenade) {
  if(!isDefined(self.minDot)) {
    return true;
  }

  dirTrophy = anglesToForward(self.angles + self.trophyAngleOffset);
  dirToGrenade = VectorNormalize(grenade.origin - self.origin);

  dot = VectorDot(dirTrophy, dirToGrenade);

  return (dot > self.minDot);
}

trophyHandleLaser(owner, grenade) {
  if(!isDefined(self.laserEnt)) {
    return;
  }

  owner endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self.laserEnt endon("death");

  self notify("trophyDelayClearLaser");
  self endon("trophyDelayClearLaser");

  self.laserEnt.angles = VectorToAngles(grenade.origin - self.laserEnt.origin);

  self.laserEnt LaserOn("tracking_drone_laser");

  wait 0.7;

  self.laserEnt LaserOff();
}

trophyAddlaser(laserOriginOffset, laserForwardAngles) {
  self.laserEnt = spawn("script_model", self.origin);
  self.laserEnt setModel("tag_laser");
  self.laserEnt.angles = self.angles;

  self.laserEnt.laserOriginOffset = laserOriginOffset;
  self.laserEnt.laserForwardAngles = laserForwardAngles;

  self thread trophyUpdateLaser();
}

trophyUpdateLaser() {
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self.laserEnt endon("death");

  while(true) {
    dirTrophy = anglesToForward(self.angles + self.laserEnt.laserForwardAngles);
    self.laserEnt.origin = self.origin + (dirTrophy * self.laserEnt.laserOriginOffset);
    waitframe();
  }
}

projectileExplode(projectile, trophy) {
  self endon("death");

  projPosition = projectile.origin;
  projType = projectile.model;
  projAngles = projectile.angles;

  if(projType == "weapon_light_marker") {
    playFX(level.empGrenadeExplode, projPosition, anglesToForward(projAngles), AnglesToUp(projAngles));

    trophy thread trophyBreak();

    projectile delete();
    return;
  }

  projectile delete();
  trophy playSound("trophy_fire");
  playFX(level.mine_explode, projPosition, anglesToForward(projAngles), AnglesToUp(projAngles));
  RadiusDamage(projPosition, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp");
}

trophyDamage(owner) {
  self endon("death");
  owner endon("death");
  self endon("change_owner");

  self setCanDamage(true);

  self.health = 999999;
  self.maxHealth = 100;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(!friendlyFireCheck(self.owner, attacker)) {
      continue;
    }

    if(isDefined(weapon)) {
      shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");
    } else {
      shortWeapon = undefined;
    }

    if(isDefined(shortWeapon)) {
      switch (shortWeapon) {
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "stun_grenade_mp":
        case "stun_grenade_var_mp":
        case "smoke_grenade_mp":
        case "smoke_grenade_var_mp":
          continue;
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(isMeleeMOD(type)) {
      self.damageTaken += self.maxHealth;
    }

    if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
      self.wasDamagedFromBulletPenetration = true;
    }

    self.wasDamaged = true;

    if(isDefined(shortWeapon) && (shortWeapon == "emp_grenade_mp" || shortWeapon == "emp_grenade_var_mp" || shortWeapon == "emp_grenade_killstreak_mp")) {
      self.damageTaken += self.maxHealth;
    }

    self.damageTaken += damage;

    if(isPlayer(attacker)) {
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("trophy");
    }

    if(self.damageTaken >= self.maxHealth) {
      if(isDefined(owner) && attacker != owner) {
        attacker notify("destroyed_explosive");
      }

      self thread trophyBreak();
    }
  }
}

trophyBreak() {
  playFXOnTag(getfx("sentry_explode_mp"), self, "tag_origin");
  playFXOnTag(getfx("sentry_smoke_mp"), self, "tag_origin");
  self playSound("sentry_explode");

  self notify("death");

  placement = self.origin;

  self.trigger MakeUnusable();

  if(isDefined(self.laserEnt)) {
    self.laserEnt Delete();
  }

  wait(3);

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}