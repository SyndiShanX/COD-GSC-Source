/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_portable_radar.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

deletePortableRadar(portable_radar) {
  if(!isDefined(portable_radar)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player)) {
      player.inPlayerPortableRadar = undefined;
    }
  }

  portable_radar notify("death");
  portable_radar Delete();
}

monitorPortableRadarUse() {
  self endon("disconnect");
  level endon("game_ended");

  self.PortableRadarArray = [];

  for(;;) {
    self waittill("grenade_fire", grenade, weapName);
    if(weapname == "portabl_radar" || weapname == "portable_radar_mp") {
      if(!IsAlive(self)) {
        grenade delete();
      } else {
        self.PortableRadarArray = array_removeUndefined(self.PortableRadarArray);

        if(self.PortableRadarArray.size >= level.maxPerPlayerExplosives) {
          deletePortableRadar(self.PortableRadarArray[0]);
        }

        grenade waittill("missile_stuck");

        GroundPosition = grenade.origin;

        if(isDefined(grenade)) {
          grenade Delete();
        }

        portable_radar = spawn("script_model", GroundPosition);
        portable_radar.health = 100;
        portable_radar.team = self.team;
        portable_radar.owner = self;

        portable_radar setCanDamage(true);

        portable_radar makePortableRadar(self);
        portable_radar portableRadarSetup(self);
        portable_radar thread maps\mp\gametypes\_weapons::createBombSquadModel("weapon_radar_bombsquad", "tag_origin", self);
        portable_radar thread portableRadarProximityTracker();
        self thread portableRadarWatchOwner(portable_radar);

        self.PortableRadarArray[self.PortableRadarArray.size] = portable_radar;
      }
    }
  }
}

portableRadarSetup(owner) {
  self setModel("weapon_radar");

  if(level.teamBased) {
    self maps\mp\_entityheadIcons::setTeamHeadIcon(self.team, (0, 0, 20));
  } else {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(owner, (0, 0, 20));
  }

  self thread portableRadarDamageListener(owner);
  self thread portableRadarUseListener(owner);
  self thread portableRadarBeepSounds();
  self thread notUsableForJoiningPlayers(owner);
}

portableRadarWatchOwner(portable_radar) {
  portable_radar endon("death");
  level endon("game_ended");

  self waittill_any("disconnect", "joined_team", "joined_spectators", "spawned_player");

  level thread deletePortableRadar(portable_radar);
}

portableRadarBeepSounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait(2.0);
    self playSound("sentry_gun_beep");
  }
}

portableRadarDamageListener(owner) {
  self endon("death");

  self.health = 999999;
  self.maxHealth = 100;
  self.damageTaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker)) {
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

    self.damageTaken += damage;

    if(isDefined(shortWeapon) && (shortWeapon == "emp_grenade_mp" || shortWeapon == "emp_grenade_var_mp" || shortWeapon == "emp_grenade_killstreak_mp")) {
      self.damageTaken = self.maxhealth + 1;
    }

    if(isPlayer(attacker)) {
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("portable_radar");
    }

    if(self.damageTaken >= self.maxHealth) {
      if(isDefined(owner) && attacker != owner) {
        attacker notify("destroyed_explosive");
      }

      self playSound("sentry_explode");
      self.deathEffect = playFX(getfx("equipment_explode"), self.origin);
      self FreeEntitySentient();
      attacker thread deletePortableRadar(self);
    }
  }
}

portableRadarUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH_PICKUP_PORTABLE_RADAR");
  self setSelfUsable(owner);

  for(;;) {
    self waittill("trigger", owner);

    ammoStock = owner GetWeaponAmmoStock("portable_radar_mp");

    if(ammoStock < WeaponMaxAmmo("portable_radar_mp")) {
      owner playLocalSound("scavenger_pack_pickup");

      owner SetWeaponAmmoStock("portable_radar_mp", ammoStock + 1);

      owner thread deletePortableRadar(self);
    }
  }
}

portableRadarProximityTracker() {
  self endon("death");
  level endon("game_ended");

  portableRadarProximity = 512;

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(level.teambased && player.team == self.team) {
        continue;
      }

      if(player _hasPerk("specialty_class_lowprofile")) {
        continue;
      }

      proxDistance = DistanceSquared(self.origin, player.origin);

      if(DistanceSquared(player.origin, self.origin) < portableRadarProximity * portableRadarProximity) {
        player.inPlayerPortableRadar = self.owner;
      } else {
        player.inPlayerPortableRadar = undefined;
      }
    }

    wait(0.05);
  }
}