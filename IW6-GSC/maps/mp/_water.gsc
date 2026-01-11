/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_water.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

waterShallowFx() {
  level._effect["water_kick"] = LoadFX("vfx/moments/flood/flood_db_foam_allie_ch_fast_cheap");
  level._effect["water_splash_emerge"] = LoadFX("vfx/moments/flood/flood_db_foam_allie_vertical_splash_sml");
  level._effect["water_splash_large"] = LoadFX("vfx/moments/flood/flood_db_foam_allie_vertical_splash_lrg");
}

waterShallowInit(waterDeleteZ, waterShallowSplashZ) {
  if(isDefined(waterDeleteZ)) {
    level.waterDeleteZ = waterDeleteZ;
  }

  level.trigUnderWater = GetEnt("trigger_underwater", "targetname");
  level.trigAboveWater = GetEnt("trigger_abovewater", "targetname");
  level.trigUnderWater thread watchPlayerEnterWater(level.trigAboveWater, waterShallowSplashZ);
  level thread clearWaterVarsOnspawn(level.trigUnderWater);

  if(isDefined(waterDeleteZ)) {
    level thread watchEntsInDeepWater(level.trigUnderWater, waterDeleteZ);
  }
}

watchEntsInDeepWater(trigUnderWater, waterDeleteZ) {
  level childthread watchEntsInDeepWater_mines(trigUnderWater, waterDeleteZ);
  level childthread watchEntsInDeepWater_ks(trigUnderWater, waterDeleteZ);
}

CONST_SENTRY_AND_AGENT_OFFSET = 35;
CONST_TROPHY_OFFSET = 28;
watchEntsInDeepWater_ks(trigUnderWater, waterDeleteZ) {
  level endon("game_ended");

  while(true) {
    wait(0.05);

    ksToDestroy = level.placedIMS;
    ksToDestroy = array_combine(ksToDestroy, level.uplinks);
    ksToDestroy = array_combine(ksToDestroy, level.turrets);

    foreach(kstreak in ksToDestroy) {
      if(!isDefined(kstreak)) {
        continue;
      }
      waterZoverride = ter_op(isDefined(kstreak.sentrytype) && kstreak.sentrytype == "sentry_minigun", waterDeleteZ - CONST_SENTRY_AND_AGENT_OFFSET, waterDeleteZ);
      if(kstreak.origin[2] <= waterZoverride && kstreak IsTouching(trigUnderWater)) {
        kstreak notify("death");
      }
    }

    wait(0.05);

    foreach(character in level.characters) {
      if(isDefined(character) &&
        IsAlive(character) &&
        IsAI(character) &&
        character.origin[2] <= waterDeleteZ - CONST_SENTRY_AND_AGENT_OFFSET &&
        character IsTouching(trigUnderWater)
      ) {
        if(IsAgent(character) &&
          isDefined(character.agent_type) &&
          character.agent_type == "dog"
        ) {
          if(!isDefined(character.spawnTime) || (GetTime() - character.spawnTime) > 2000) {
            character[[character maps\mp\agents\_agent_utility::agentFunc("on_damaged")]](level, undefined, Int(ceil(character.maxhealth * 0.08)), 0, "MOD_CRUSH", "none", (0, 0, 0), (0, 0, 0), "none", 0);
          }
        } else {
          character DoDamage(Int(ceil(character.maxhealth * 0.08)), character.origin);
        }
      }
    }
  }
}

watchEntsInDeepWater_mines(trigUnderWater, waterDeleteZ) {
  level endon("game_ended");

  while(true) {
    level waittill("mine_planted");

    waittillframeend;

    mines = level.mines;
    foreach(uId, mine in mines) {
      if(!isDefined(mine)) {
        continue;
      }
      offset = 0;
      if(isDefined(mine.isTallForWaterChecks)) {
        offset = CONST_TROPHY_OFFSET;
      }

      if(mine.origin[2] <= waterDeleteZ - offset && mine IsTouching(trigUnderWater)) {
        mine maps\mp\gametypes\_weapons::deleteExplosive();
      }
    }
  }
}

clearWaterVarsOnspawn(underWater) {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    if(!player IsTouching(underWater)) {
      player.inWater = undefined;
      player.underWater = undefined;
      player notify("out_of_water");
    }
  }
}

watchPlayerEnterWater(aboveWater, waterShallowSplashZ) {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", ent);

    if(!IsPlayer(ent) && !IsAgent(ent)) {
      continue;
    }
    if(!IsAlive(ent) || (IsAgent(ent) && isDefined(ent.agent_type) && ent.agent_type == "dog")) {
      continue;
    }
    if(!isDefined(ent.inWater)) {
      ent.inWater = true;
      ent thread playerInWater(self, aboveWater, waterShallowSplashZ);
    }
  }
}

playerSplash() {
  self endon("out_of_water");
  self endon("death");
  self endon("disconnect");

  vel = self GetVelocity();
  if(vel[2] > -100) {
    return;
  }
  wait(0.2);

  vel = self GetVelocity();
  if(vel[2] <= -100) {
    self playSound("watersplash_lrg");
    playFX(level._effect["water_splash_large"], self.origin + (0, 0, 36), (0, 0, 1), anglesToForward((0, self.angles[1], 0)));
  }
}

playerInWater(underWater, aboveWater, waterShallowSplashZ) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  self thread inWaterWake(waterShallowSplashZ);
  self thread playerWaterClearWait();

  self thread playerSplash();

  while(true) {
    if(!self IsTouching(underWater)) {
      self.inWater = undefined;
      self.underWater = undefined;
      self notify("out_of_water");
      stopWaterVisuals();
      break;
    }

    if(!isDefined(self.underWater) && !self IsTouching(aboveWater)) {
      if(self.classname == "script_vehicle") {
        self notify("death");
      } else {
        self.underWater = true;
        self thread playerUnderWater();
      }
    }

    if(isDefined(self.underWater) && self IsTouching(aboveWater)) {
      self.underWater = undefined;
      self notify("above_water");
      stopWaterVisuals();

      if(IsPlayer(self)) {
        if(self hasFemaleCustomizationModel()) {
          self playLocalSound("Fem_breathing_better");
        } else {
          self playLocalSound("breathing_better");
        }
      }
      playFX(level._effect["water_splash_emerge"], self.origin + (0, 0, 24));
    }

    wait(0.05);
  }
}

IsActiveKillstreakPoolRestricted(player) {
  if(isDefined(player.killstreakIndexWeapon)) {
    streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
    if(isDefined(streakName)) {
      switch (streakName) {
        case "remote_uav":
        case "remote_mg_turret":
        case "minigun_turret":
        case "ims":
        case "sentry":
        case "remote_tank":
        case "sam_turret":
          return true;
      }
    }
  }

  return false;
}

playerWaterClearWait() {
  self waittill_any("death", "disconnect", "out_of_water");

  if(!isDefined(self)) {
    return;
  }
  self.inWater = undefined;
  self.underWater = undefined;
}

CONST_WATER_KICK_MIN_MSEC = 200;

inWaterWake(waterShallowSplashZ) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("out_of_water");

  zGround = ter_op(isDefined(waterShallowSplashZ), waterShallowSplashZ, self.origin[2]);
  fxPlayedRecently = false;
  while(true) {
    if(fxPlayedRecently) {
      wait(0.05);
    } else {
      wait(0.3);
    }

    if(!isDefined(level.waterKickTimeNext)) {
      level.waterKickTimeNext = GetTime() + CONST_WATER_KICK_MIN_MSEC;
    } else {
      time = GetTime();
      if(GetTime() < level.waterKickTimeNext) {
        fxPlayedRecently = true;
        continue;
      } else {
        level.waterKickTimeNext = time + CONST_WATER_KICK_MIN_MSEC;
      }
    }

    fxPlayedRecently = false;

    vel = self GetVelocity();

    if(!isDefined(waterShallowSplashZ)) {
      if(abs(vel[2]) <= 1) {
        zGround = self.origin[2];
      }
    }

    if(abs(vel[2]) > 30) {
      playFX(level._effect["water_kick"], (self.origin[0], self.origin[1], min(zGround, self.origin[2])));
    } else if(Length2DSquared(vel) > 60 * 60) {
      fwd = VectorNormalize((vel[0], vel[1], 0));
      playFX(level._effect["water_kick"], (self.origin[0], self.origin[1], min(zGround, self.origin[2])) + fwd * 36, fwd, (0, 0, 1));
    }
  }
}

playerUnderWater() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");

  if(!self maps\mp\_utility::isUsingRemote()) {
    self startWaterVisuals();

    self thread stopWaterVisualsOnRemote();
  }

  playFX(level._effect["water_splash_emerge"], self getEye() - (0, 0, 24));

  wait(2);
  self thread onPlayerDrowned();

  while(true) {
    self DoDamage(20, self.origin);
    wait(1);
  }
}

onPlayerDrowned() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");

  self waittill("death");

  self.inWater = undefined;
  self.underWater = undefined;
}

underWaterBubbles() {
  level endon("game_ended");
  self endon("death");
  self endon("using_remote");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");

  while(true) {
    playFX(level._effect["water_bubbles"], self getEye() + (AnglesToUp(self.angles) * -13) + (anglesToForward(self.angles) * 25));
    wait(0.75);
  }
}

startWaterVisuals() {
  self ShellShock("mp_flooded_water", 8);
  if(IsPlayer(self)) {
    self SetBlurForPlayer(10, 0.0);
  }
}

stopWaterVisuals() {
  self StopShellShock();
  if(IsPlayer(self)) {
    self SetBlurForPlayer(0, 0.85);
  }
}

stopWaterVisualsOnRemote() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");

  self waittill("using_remote");
  self stopWaterVisuals();
}