/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_deployablebox_ammo.gsc
*******************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

BOX_TYPE = "deployable_ammo";

init() {
  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "deployable_vest_marker_mp";
  boxConfig.modelBase = "mil_ammo_case_1_open";
  boxConfig.hintString = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  boxConfig.capturingString = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  boxConfig.event = "deployable_ammo_taken";
  boxConfig.streakName = BOX_TYPE;
  boxConfig.splashName = "used_deployable_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_ammo_friendly";
  boxConfig.headIconOffset = 25;
  boxConfig.lifeSpan = 90.0;
  boxConfig.useXP = 50;
  boxConfig.xpPopup = "destroyed_vest";
  boxConfig.voDestroyed = "ballistic_vest_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable;
  boxConfig.canUseCallback = ::canUseDeployable;
  boxConfig.useTime = 500;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_ammo_mp";
  boxConfig.deathVfx = loadfx("fx/explosions/clusterbomb_exp_direct_runner");
  boxConfig.deathDamageRadius = 256;
  boxConfig.deathDamageMax = 130;
  boxconfig.deathDamageMin = 50;
  boxConfig.allowMeleeDamage = true;
  boxConfig.allowGrenadeDamage = true;
  boxConfig.maxUses = 4;

  level.boxSettings[BOX_TYPE] = boxConfig;

  level.killStreakFuncs[BOX_TYPE] = ::tryUseDeployableAmmo;

  level.deployable_box[BOX_TYPE] = [];
}

tryUseDeployableAmmo(lifeId, streakName) {
  result = self maps\mp\killstreaks\_deployablebox::beginDeployableViaMarker(lifeId, BOX_TYPE);

  if((!isDefined(result) || !result)) {
    return false;
  }

  if(!is_aliens()) {
    self maps\mp\_matchdata::logKillstreakEvent(BOX_TYPE, self.origin);
  }

  return true;
}

onUseDeployable(boxEnt) {
  if(is_aliens()) {
    self addAlienWeaponAmmo(boxEnt);
  } else {
    self addAllWeaponAmmo();
  }
}
addAllWeaponAmmo() {
  weaponList = self GetWeaponsListAll();

  if(isDefined(weaponList)) {
    foreach(weaponName in weaponList) {
      if(maps\mp\gametypes\_weapons::isBulletWeapon(weaponName)) {
        self addOneWeaponAmmo(weaponName, 2);
      } else if(WeaponClass(weaponName) == "rocketlauncher") {
        self addOneWeaponAmmo(weaponName, 1);
      }
    }
  }
}

addOneWeaponAmmo(weaponName, numClips) {
  clipSize = WeaponClipSize(weaponName);
  curStock = self GetWeaponAmmoStock(weaponName);
  self SetWeaponAmmoStock(weaponName, curStock + numClips * clipSize);
}

addRatioMaxStockToAllWeapons(ratio_of_max) {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    if(maps\mp\gametypes\_weapons::isBulletWeapon(weapon)) {
      if(weapon != "iw6_alienminigun_mp") {
        cur_stock = self GetWeaponAmmoStock(weapon);
        max_stock = WeaponMaxAmmo(weapon);
        new_stock = cur_stock + max_stock * ratio_of_max;
        self SetWeaponAmmoStock(weapon, int(min(new_stock, max_stock)));
      }
    }
  }
}

addFullClipToAllWeapons() {
  primary_weapons = self GetWeaponsListPrimaries();
  foreach(weapon in primary_weapons) {
    clip_size = WeaponClipSize(weapon);
    self SetWeaponAmmoClip(weapon, clip_size);
  }
}

addAlienWeaponAmmo(boxEnt) {
  primary_weapons = self GetWeaponsListPrimaries();

  assert(isDefined(boxEnt.upgrade_rank));

  switch (boxEnt.upgrade_rank) {
    case 0:
      self addRatioMaxStockToAllWeapons(.4);
      break;
    case 1:
      self addRatioMaxStockToAllWeapons(.7);
      break;
    case 2:
      self addRatioMaxStockToAllWeapons(1.0);
      break;
    case 3:
      self addRatioMaxStockToAllWeapons(1.0);
      self addFullClipToAllWeapons();
      break;
    case 4:
      self addRatioMaxStockToAllWeapons(1.0);
      self addFullClipToAllWeapons();
      break;
  }
}

canUseDeployable(boxEnt) {
  if(is_aliens() && isDefined(boxEnt) && boxEnt.owner == self && !isDefined(boxEnt.air_dropped)) {
    return false;
  }
  if(!is_aliens())
    return (!self isJuggernaut());
  else
    return true;
}