/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_rippedturret.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

CONST_REMOTE_TURRET_SENTRY_RIPPABLE_AMMO_MG = 100;
CONST_REMOTE_TURRET_SENTRY_RIPPABLE_AMMO_ROCKET = 6;
CONST_REMOTE_TURRET_SENTRY_RIPPABLE_AMMO_ENERGY_SECONDS = 10;

init() {
  level.killStreakFuncs["ripped_turret"] = ::tryUseRippedTurret;

  level.killstreakWieldWeapons["turretheadmg_mp"] = "ripped_turret";
  level.killstreakWieldWeapons["turretheadenergy_mp"] = "ripped_turret";
  level.killstreakWieldWeapons["turretheadrocket_mp"] = "ripped_turret";

  level thread onPlayerConnect();
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);
    level thread onPlayerSpawned(player);
  }
}

onPlayerSpawned(player) {
  while(true) {
    player waittill("killstreakUseWaiter");
    level thread updateAmmo(player);
  }
}

updateAmmo(player) {
  player SetClientOmnvar("ui_energy_ammo", 1);

  if(!isDefined(player.pers["rippableSentry"])) {
    return;
  }

  weapon = undefined;

  if(player HasWeapon("turretheadmg_mp")) {
    weapon = "turretheadmg_mp";
  } else if(player HasWeapon("turretheadenergy_mp")) {
    weapon = "turretheadenergy_mp";
  } else if(player HasWeapon("turretheadrocket_mp")) {
    weapon = "turretheadrocket_mp";
  }

  if(!isDefined(weapon)) {
    return;
  }

  ammo = player playerGetRippableAmmo();

  if(isTurretEnergyWeapon(weapon)) {
    fullEnergy = getAmmoForTurretWeaponType(weapon);
    percent = ammo / fullEnergy;
    player SetClientOmnvar("ui_energy_ammo", percent);
  } else {
    player SetWeaponAmmoClip(weapon, ammo);
  }
}

tryUseRippedTurret(lifeId, modules) {
  result = tryUseRippedTurretInternal(modules);

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent("ripped_turret", self.origin);
  }

  return result;
}

tryUseRippedTurretInternal(modules) {
  if(self isUsingRemote()) {
    return false;
  }

  Assert(self playerModulesHaveRippedTurret(modules) && self playerHasRippableTurretInfo());

  result = self playerSetupRecordedTurretHead(modules);
  return result;
}

playerGiveTurretHead(weapon) {
  self maps\mp\killstreaks\_killstreaks::giveKillstreak("ripped_turret", false, false, self, [weapon]);

  if(!isDefined(self.pers["rippableSentry"])) {
    self.pers["rippableSentry"] = spawnStruct();
  }

  ammo = getAmmoForTurretWeaponType(weapon);
  self playerRecordRippableAmmo(ammo);

  if(!self is_player_gamepad_enabled()) {
    self notify("streakUsed1");
    waittillframeend;
  }

  self SwitchToWeapon(weapon);
}

playerModulesHaveRippedTurret(modules) {
  foreach(module in modules) {
    if(module == "turretheadenergy_mp" || module == "turretheadrocket_mp" || module == "turretheadmg_mp") {
      return true;
    }
  }

  return false;
}

playerSetupRecordedTurretHead(modules) {
  self endon("disconnect");
  level endon("game_ended");

  ammo = self playerGetRippableAmmo();
  weapon = modules[0];

  if(!isTurretEnergyWeapon(weapon)) {
    self SetWeaponAmmoClip(weapon, ammo);
  }
  self SetWeaponAmmoStock(weapon, 0);

  self thread playerMonitorWeaponSwitch(weapon);

  if(isTurretEnergyWeapon(weapon)) {
    self thread playerSetupTurretEnergyBar(weapon, ammo);
  } else {
    self thread playerTrackTurretAmmo(weapon);
  }

  self waittill_any_return("death", "rippable_complete", "rippable_switch");

  if(!isDefined(self)) {
    return false;
  }

  if(isTurretEnergyWeapon(weapon)) {
    self NotifyOnPlayerCommandRemove("fire_turret_weapon", "+attack");
    self NotifyOnPlayerCommandRemove("fire_turret_weapon", "+attack_akimbo_accessible");
  }

  result = !playerHasRippableTurretInfo();

  return result;
}

playerMonitorWeaponSwitch(weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("rippable_complete");

  currentWeapon = self GetCurrentWeapon();

  while(currentWeapon == weapon || isBombSiteWeapon(currentWeapon)) {
    self waittill("weapon_change", currentWeapon);
  }

  if(isKillstreakWeapon(currentWeapon)) {
    self.justSwitchedToKillstreakWeapon = currentWeapon;
  }

  self notify("rippable_switch");
}

playerTrackTurretAmmo(weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("rippable_switch");

  while(true) {
    ammo = self GetWeaponAmmoClip(weapon);
    self playerRecordRippableAmmo(ammo);
    if(ammo == 0) {
      self playerClearRippableTurretInfo();
      self notify("rippable_complete");
      return;
    }
    waitframe();
  }
}

playerHasTurretHeadWeapon() {
  if(self playerHasRippableTurretInfo()) {
    return true;
  }

  weapons = self GetWeaponsListPrimaries();
  foreach(weapon in weapons) {
    if((weapon == "turretheadenergy_mp") || (weapon == "turretheadrocket_mp") || (weapon == "turretheadmg_mp"))
      return true;
  }
  return false;
}

getAmmoForTurretWeaponType(weapon) {
  if(weapon == "turretheadmg_mp") {
    return CONST_REMOTE_TURRET_SENTRY_RIPPABLE_AMMO_MG;
  } else if(weapon == "turretheadrocket_mp") {
    return CONST_REMOTE_TURRET_SENTRY_RIPPABLE_AMMO_ROCKET;
  } else {
    return getFullEnergy();
  }
}

isTurretEnergyWeapon(weapon) {
  return (weapon == "turretheadenergy_mp");
}

playerSetupTurretEnergyBar(weapon, ammo) {
  self endon("death");
  self endon("disconnect");
  self endon("rippable_switch");

  fullEnergy = getFullEnergy();
  self NotifyOnPlayerCommand("fire_turret_weapon", "+attack");
  self NotifyOnPlayerCommand("fire_turret_weapon", "+attack_akimbo_accessible");

  ammo = self playerGetRippableAmmo();
  percent = ammo / fullEnergy;
  self SetClientOmnvar("ui_energy_ammo", percent);

  while(true) {
    if(!self attackButtonPressed()) {
      self waittill("fire_turret_weapon");
    }

    if(self IsSwitchingWeapon() || self GetCurrentWeapon() != "turretheadenergy_mp" || !self IsFiring() || self IsUsingOffhand()) {
      waitframe();
      continue;
    }

    ammo = self playerGetRippableAmmo();
    percent = ammo / fullEnergy;
    self SetClientOmnvar("ui_energy_ammo", percent);

    if(ammo <= 0) {
      weapons = self GetWeaponsListPrimaries();
      if(weapons.size > 0) {
        self SwitchToWeapon(weapons[0]);
      } else {
        self TakeWeapon(weapon);
      }
      self playerClearRippableTurretInfo();
      self notify("rippable_complete");
      return;
    }

    waitframe();

    self playerRecordRippableAmmo(ammo - 1);
  }
}

getFullEnergy() {
  return (CONST_REMOTE_TURRET_SENTRY_RIPPABLE_AMMO_ENERGY_SECONDS / 0.05);
}

playerGetRippableAmmo() {
  AssertEx(isDefined(self.pers["rippableSentry"]), "playerGetRippableAmmo() called on player with no \"playerGetRippableAmmo\" array key.");

  return self.pers["rippableSentry"].ammo;
}

playerRecordRippableAmmo(ammo) {
  AssertEx(isDefined(self.pers["rippableSentry"]), "playerGetRippableAmmo() called on player with no \"playerGetRippableAmmo\" array key.");

  self.pers["rippableSentry"].ammo = ammo;
}

playerHasRippableTurretInfo() {
  return (isDefined(self.pers["rippableSentry"]) && self playerGetRippableAmmo() > 0);
}

playerClearRippableTurretInfo() {
  self.pers["rippableSentry"] = undefined;
}