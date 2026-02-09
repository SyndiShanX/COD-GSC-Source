/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_water.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_art;

CONST_SWIMMING_DEPTH = 48;

init() {
  level._effect["water_wake"] = loadfx("vfx/treadfx/body_wake_water");
  level._effect["water_wake_stationary"] = loadfx("vfx/treadfx/body_wake_water_stationary");
  level._effect["water_splash_emerge"] = loadfx("vfx/water/body_splash_exit");
  level._effect["water_splash_enter"] = loadfx("vfx/water/body_splash");

  PreCacheShellShock("underwater");

  if(!isDefined(level.waterline_ents)) {
    level.waterline_ents = [];
  }

  if(!isDefined(level.waterline_offset)) {
    level.waterline_offset = 0;
  }
  if(!isDefined(level.shallow_water_weapon)) {
    SetShallowWaterWeapon("iw5_combatknife_mp");
  }
  if(!isDefined(level.deep_water_weapon)) {
    SetDeepWaterWeapon("iw5_underwater_mp");
  }
  if(!isDefined(level.allow_swimming)) {
    level.allow_swimming = true;
  }
  if(level.deep_water_weapon == level.shallow_water_weapon) {
    level.allow_swimming = false;
  }
  if(!isDefined(level.swimming_depth)) {
    level.swimming_depth = CONST_SWIMMING_DEPTH;
  }

  triggers = getEntArray("trigger_underwater", "targetname");
  level.water_triggers = triggers;

  foreach(trig in triggers) {
    trig create_clientside_water_ents();
    trig thread watchPlayerEnterWater();
    level thread clearWaterVarsOnspawn(trig);
  }

  level thread OnPlayerConnectFunctions();
}

player_set_in_water(in_water) {
  if(in_water) {
    self.inWater = true;
    if(IsAIGameParticipant(self)) {
      self BotSetFlag("in_water", true);
    }
  } else {
    self.inWater = undefined;
    if(IsAIGameParticipant(self)) {
      self BotSetFlag("in_water", false);
    }
  }
}

OnPlayerConnectFunctions() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    foreach(waterline_ent in level.waterline_ents) {
      player InitWaterClientTrigger(waterline_ent.script_noteworthy, waterline_ent);
    }
  }
}

create_clientside_water_ents() {
  water_ent_struct = getstruct(self.target, "targetname");
  AssertEx(isDefined(water_ent_struct), "waterline needs to be defined. Place a script_struct at the height of the waterline and link your underwater trigger to it.");

  water_ent_struct.origin = water_ent_struct.origin + (0, 0, level.waterline_offset);

  waterline_ent = water_ent_struct spawn_tag_origin();
  waterline_ent show();

  if(isDefined(self.script_noteworthy)) {
    waterline_ent.script_noteworthy = self.script_noteworthy;
    level.waterline_ents = array_add(level.waterline_ents, waterline_ent);
  }
}

clearWaterVarsOnspawn(underWater) {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    if(!player IsTouching(underWater)) {
      player player_set_in_water(false);
      player.underWater = undefined;
      player.inThickWater = undefined;
      player.isSwimming = undefined;
      player.isWading = undefined;
      player.water_last_weapon = undefined;
      player.isShocked = undefined;
      player notify("out_of_water");
    }
  }
}

watchPlayerEnterWater() {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", ent);

    if(isDefined(level.isHorde) && level.isHorde && IsAgent(ent) && isDefined(ent.horde_type) && ent.horde_type == "Quad" && !isDefined(ent.inWater)) {
      ent thread hordeDogInWater(self);
    }

    if(!isPlayer(ent) && !IsAI(ent)) {
      continue;
    }

    if(!isAlive(ent)) {
      continue;
    }

    if(!isDefined(ent.inWater)) {
      ent player_set_in_water(true);
      ent thread playerInWater(self);
    }
  }
}

hordeDogInWater(trig) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self player_set_in_water(true);

  while(1) {
    if(!self inShallowWater(trig, 40)) {
      wait 2.5;
      if(!self inShallowWater(trig, 20)) {
        self DoDamage(self.health, self.origin);
      }
    }
    waitframe();
  }
}

playerInWater(underWater) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  self thread inWaterWake(underWater);
  self thread playerWaterClearWait();

  self.eyeHeightLastFrame = 0;
  self.eye_velocity = 0;

  while(true) {
    if(self maps\mp\_utility::isUsingRemote()) {
      if(isDefined(self.underWater) && isDefined(self.isShocked)) {
        self StopShellShock();
        self.isShocked = undefined;
      }
    } else {
      if(isDefined(self.underWater) && !isDefined(self.isShocked)) {
        self shellShock("underwater", 19);
        self.isShocked = true;
      }
    }

    if(!self IsTouching(underWater)) {
      self player_set_in_water(false);
      self.underWater = undefined;
      self.inThickWater = undefined;
      self.isSwimming = undefined;
      self.moveSpeedScaler = level.basePlayerMoveScale;
      self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
      self notify("out_of_water");
      break;
    }

    if(isDefined(self.inThickWater) && self inShallowWater(underwater, 32)) {
      self.inThickWater = undefined;
      self.moveSpeedScaler = level.basePlayerMoveScale;
      self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
    }

    if(!isDefined(self.inThickWater) && !self inShallowWater(underwater, 32)) {
      self.inThickWater = true;
      self.moveSpeedScaler = .7 * level.basePlayerMoveScale;
      self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
    }

    if(!isDefined(self.underWater) && !self isAboveWaterLine(underWater, 0)) {
      self.underWater = true;
      self thread playerHandleDamage();
      if(isAugmentedGameMode()) {
        self DisableExo();
      }
      if(!self maps\mp\_utility::isUsingRemote()) {
        self shellShock("underwater", 19);
        self.isShocked = true;
      }

      currentWeapon = self GetCurrentWeapon();
      if(currentWeapon != "none" && WeaponInventoryType(currentWeapon) == "primary") {
        self.water_last_weapon = currentWeapon;
      }

      if(isDefined(level.gamemodeOnUnderWater)) {
        self[[level.gamemodeOnUnderWater]](underWater);
      }
      self maps\mp\killstreaks\_coop_util::playerStopPromptForStreakSupport();
    }

    if(isDefined(self.underWater) && (isDefined(self.isSwimming) || !isDefined(self.isWading)) && (self inShallowWater(underwater, level.swimming_depth) || self GetStance() == "prone" || !level.allow_swimming)) {
      self.isWading = true;
      self.isSwimming = undefined;
      self PlayerDisableUnderwater();
      if(isDefined(self.isJuggernaut) && self.isJuggernaut == true) {
        self PlayerEnableUnderwater("none");
        self AllowFire(false);
        self DisableOffhandSecondaryWeapons();
      } else {
        self PlayerEnableUnderwater("shallow");
      }
    }

    if(isDefined(self.underWater) && (isDefined(self.isWading) || !isDefined(self.isSwimming)) && (!self inShallowWater(underwater, level.swimming_depth) && self GetStance() != "prone" && level.allow_swimming)) {
      self.isSwimming = true;
      self.isWading = undefined;
      self PlayerDisableUnderwater();
      if(isDefined(self.isJuggernaut) && self.isJuggernaut == true) {
        self PlayerEnableUnderwater("none");
        self AllowFire(false);
        self DisableOffhandSecondaryWeapons();
      } else {
        self PlayerEnableUnderwater("deep");
      }
    }

    if(isDefined(self.underWater) && self isAboveWaterLine(underWater, 0)) {
      self.underWater = undefined;
      self.isSwimming = undefined;
      self.isWading = undefined;
      self notify("above_water");
      speed = Distance(self GetVelocity(), (0, 0, 0));
      point = (self.origin[0], self.origin[1], getWaterLine(underwater));
      playFX(level._effect["water_splash_emerge"], point, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
      if(!self maps\mp\_utility::isUsingRemote()) {
        self StopShellshock();
        self.isShocked = undefined;
      }
      self PlayerDisableUnderwater();
      if(isAugmentedGameMode()) {
        self EnableExo();
      }
      self maps\mp\killstreaks\_coop_util::playerStartPromptForStreakSupport();
    }

    wait(0.05);
  }
}

IsActiveKillstreakWaterRestricted(player) {
  if(isDefined(player.killstreakIndexWeapon)) {
    streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
    if(isDefined(streakName)) {
      if(string_find(streakName, "turret") > 0 || string_find(streakName, "sentry") > 0) {
        return true;
      }
    }
  }
  return false;
}

playerWaterClearWait() {
  msg = self waittill_any_return("death", "out_of_water");

  self.underwaterMotionType = undefined;
  self.dont_give_or_take_weapon = undefined;
  self player_set_in_water(false);
  self.underWater = undefined;
  self.inThickWater = undefined;
  self.water_last_weapon = undefined;
  self.moveSpeedScaler = level.basePlayerMoveScale;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

inWaterWake(underwater) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("out_of_water");

  speed = Distance(self GetVelocity(), (0, 0, 0));
  if(speed > 90) {
    point = (self.origin[0], self.origin[1], getWaterLine(underwater));
    playFX(level._effect["water_splash_enter"], point, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
  }

  while(true) {
    velocity = self GetVelocity();
    speed = Distance(velocity, (0, 0, 0));
    if(speed > 0) {
      wait(max((1 - (speed / 120)), 0.1));
    } else {
      wait(0.3);
    }

    if(speed > 5) {
      movementDir = VectorNormalize((velocity[0], velocity[1], 0));
      forwardVec = anglesToForward(VectorToAngles(movementDir) + (270, 180, 0));
      point = (self.origin[0], self.origin[1], getWaterLine(underwater)) + ((speed / 4) * movementDir);
      playFX(level._effect["water_wake"], point, forwardVec);
    } else {
      point = (self.origin[0], self.origin[1], getWaterLine(underwater));
      playFX(level._effect["water_wake_stationary"], point, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
    }
  }
}

playerhandleDamage() {
  level endon("game_ended");
  self endon("death");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");

  self thread onPlayerDeath();

  wait(13);

  while(true) {
    if(!isDefined(self.isJuggernaut) || self.isJuggernaut == false) {
      RadiusDamage(self.origin + anglesToForward(self.angles) * 5, 1, 20, 20, undefined, "MOD_TRIGGER_HURT");
    }

    wait(1);
  }
}

onPlayerDeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("above_water");

  self waittill("death");

  self player_set_in_water(false);
  self.underWater = undefined;
  self.inThickWater = undefined;
  self.isSwimming = undefined;
  self.isWading = undefined;
  self.water_last_weapon = undefined;
  self.underwaterMotionType = undefined;
  self.eye_velocity = 0;
  self.eyeHeightLastFrame = 0;
  self maps\mp\killstreaks\_coop_util::playerStartPromptForStreakSupport();
}

inShallowWater(trig, depth) {
  if(!isDefined(depth)) {
    depth = 32;
  }
  if(level GetWaterLine(trig) - self.origin[2] <= depth) {
    return true;
  }
  return false;
}

isAboveWaterLine(trig, offset) {
  if((self GetPlayerEyeHeight() + offset) >= level GetWaterLine(trig)) {
    return true;
  } else {
    return false;
  }
}

GetPlayerEyeHeight() {
  player_eye = self getEye();
  self.eye_velocity = player_eye[2] - self.eyeHeightLastFrame;
  self.eyeHeightLastFrame = player_eye[2];
  return player_eye[2];
}

GetWaterLine(trig) {
  water_line_struct = getstruct(trig.target, "targetname");
  water_line = water_line_struct.origin[2];

  return water_line;
}

PlayerEnableUnderwater(type) {
  level endon("game_ended");

  self endon("death");
  self endon("disconnect");
  self endon("end_swimming");

  if(!isDefined(type)) {
    type = "shallow";
  }

  if((type == "shallow" && self HasWeapon(level.shallow_water_weapon)) || (type == "deep" && self HasWeapon(level.deep_water_weapon))) {
    self.dont_give_or_take_weapon = true;
  }

  switch (type) {
    case "deep":
      self give_water_weapon(level.deep_water_weapon);
      self SwitchToWeaponImmediate(level.deep_water_weapon);
      self.underwaterMotionType = "deep";
      break;
    case "shallow":
      self give_water_weapon(level.shallow_water_weapon);
      self SwitchToWeaponImmediate(level.shallow_water_weapon);
      self.underwaterMotionType = "shallow";
      break;
    case "none":
      self.underwaterMotionType = "none";
      break;
    default:
      self give_water_weapon(level.shallow_water_weapon);
      self SwitchToWeaponImmediate(level.shallow_water_weapon);
      self.underwaterMotionType = "shallow";
      break;
  }

  self DisableWeaponPickup();
  self _disableWeaponSwitch();
  self _disableOffhandWeapons();
}

playerDisableUnderwater() {
  level endon("game_ended");

  self endon("death");
  self endon("disconnect");

  if(isDefined(self.underwaterMotionType)) {
    type = self.underwaterMotionType;

    self notify("end_swimming");

    self EnableWeaponPickup();
    self _enableWeaponSwitch();
    self _enableOffhandWeapons();

    if(isDefined(self.isJuggernaut) && self.isJuggernaut == true && isDefined(self.heavyExoData)) {
      self AllowFire(true);

      if(!isDefined(self.heavyExoData.hasLongPunch) || self.heavyExoData.hasLongPunch == false) {
        self DisableOffhandWeapons();
      }

      if(!isDefined(self.heavyExoData.hasRockets) || self.heavyExoData.hasRockets == false) {
        self DisableOffhandSecondaryWeapons();
      } else {
        self EnableOffhandSecondaryWeapons();
      }
    }

    if(isDefined(self.water_last_weapon)) {
      self switch_to_last_weapon(self.water_last_weapon);
    }

    switch (type) {
      case "deep":
        self take_water_weapon(level.deep_water_weapon);
        break;
      case "shallow":
        self take_water_weapon(level.shallow_water_weapon);
        break;
      case "none":
        break;
      default:
        self take_water_weapon(level.shallow_water_weapon);
        break;
    }

    self.underwaterMotionType = undefined;
    self.dont_give_or_take_weapon = undefined;
  }
}

give_water_weapon(weapon) {
  if(!isDefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon) {
    self giveWeapon(weapon);
  }
}

take_water_weapon(weapon) {
  if(!isDefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon) {
    self takeWeapon(weapon);
  }
}

EnableExo() {
  self playerAllowHighJump(true);
  self playerAllowHighJumpDrop(true);
  self playerAllowBoostJump(true);
  self playerAllowPowerSlide(true);
  self playerAllowDodge(true);
}

DisableExo() {
  self playerAllowHighJump(false);
  self playerAllowHighJumpDrop(false);
  self playerAllowBoostJump(false);
  self playerAllowPowerSlide(false);
  self playerAllowDodge(false);
}

SetShallowWaterWeapon(weapon) {
  assertEx(isValidUnderWaterWeapon(weapon), "weapon is not a valid underwater weapon");

  level.shallow_water_weapon = weapon;
}

SetDeepWaterWeapon(weapon) {
  assertEx(isValidUnderWaterWeapon(weapon), "weapon is not a valid underwater weapon");

  level.deep_water_weapon = weapon;
}

isValidUnderWaterWeapon(weapon) {
  switch (weapon) {
    case "iw5_underwater_mp":
    case "iw5_combatknife_mp":
    case "none":
      return true;
    default:
      return false;
  }
}