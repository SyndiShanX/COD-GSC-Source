/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_deployablebox_gun.gsc
******************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

BOX_TYPE = "deployable_ammo";

init() {
  boxConfig = spawnStruct();
  boxConfig.id = "deployable_weapon_crate";
  boxConfig.weaponInfo = "deployable_weapon_crate_marker_mp";
  boxConfig.modelBase = "mp_weapon_crate";
  boxConfig.modelBombSquad = "mp_weapon_crate_bombsquad";
  boxConfig.hintString = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  boxConfig.capturingString = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  boxConfig.event = "deployable_ammo_taken";
  boxConfig.streakName = BOX_TYPE;
  boxConfig.splashName = "used_deployable_ammo";
  boxConfig.shaderName = "compass_objpoint_deploy_ammo_friendly";
  boxConfig.headIconOffset = 20;
  boxConfig.lifeSpan = 90.0;
  boxConfig.voGone = "ammocrate_gone";
  boxConfig.useXP = 50;
  boxConfig.xpPopup = "destroyed_ammo";
  boxConfig.voDestroyed = "ammocrate_destroyed";
  boxConfig.deployedSfx = "mp_vest_deployed_ui";
  boxConfig.onUseSfx = "ammo_crate_use";
  boxConfig.onUseCallback = ::onUseDeployable;
  boxConfig.canUseCallback = ::canUseDeployable;
  boxConfig.noUseKillstreak = true;
  boxConfig.useTime = 1000;
  boxConfig.maxHealth = 150;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathVfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
  boxConfig.allowMeleeDamage = true;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 4;

  boxConfig.minigunChance = 20;

  boxConfig.miniGunChance = 10;

  boxConfig.minigunWeapon = "iw6_minigun_mp";
  boxConfig.ammoRestockCheckFreq = 0.5;
  boxConfig.ammoRestockTime = 10.0;
  boxConfig.triggerRadius = 200;
  boxConfig.triggerHeight = 64;
  boxConfig.onDeployCallback = ::onBoxDeployed;
  boxConfig.canUseOtherBoxes = false;

  level.boxSettings[BOX_TYPE] = boxConfig;

  level.killStreakFuncs[BOX_TYPE] = ::tryUseDeployable;

  level.deployableGunBox_BonusInXUses = RandomIntRange(1, boxConfig.minigunChance + 1);

  level.deployable_box[BOX_TYPE] = [];

  maps\mp\gametypes\sotf::defineChestWeapons();
}

tryUseDeployable(lifeId, streakName) {
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
  level.deployableGunBox_BonusInXUses--;

  if(level.deployableGunBox_BonusInXUses == 0) {
    boxConfig = level.boxSettings[boxEnt.boxType];

    if(isDefined(level.deployableBoxGiveWeaponFunc)) {
      [[level.deployableBoxGiveWeaponFunc]](true);
    }
    else {
      giveGun(self, boxConfig.minigunWeapon);
    }

    self maps\mp\gametypes\_missions::processChallenge("ch_guninabox");

    level.deployableGunBox_BonusInXUses = RandomIntRange(boxConfig.minigunChance, boxConfig.minigunChance + 1);
  } else {
    giveRandomGun(self);
  }
}

onBoxDeployed(config) {
  self thread restockAmmoAura(config);
}

giveRandomGun(player) {
  baseWeapons = [];
  foreach(gun in player GetWeaponsListPrimaries()) {
    baseWeapons[baseWeapons.size] = GetWeaponBaseName(gun);
  }

  newWeapon = undefined;
  while(true) {
    newWeapon = maps\mp\gametypes\sotf::getRandomWeapon(level.weaponArray);
    newBaseWeapon = newWeapon["name"];

    if(!array_contains(baseWeapons, newBaseWeapon)) {
      break;
    }
  }

  newWeapon = maps\mp\gametypes\sotf::getRandomAttachments(newWeapon);

  giveGun(player, newWeapon);
}

giveGun(player, newWeapon) {
  weaponList = player GetWeaponsListPrimaries();

  primaryCount = 0;
  foreach(weap in weaponList) {
    if(!maps\mp\gametypes\_weapons::isAltModeWeapon(weap)) {
      primaryCount++;
    }
  }

  if(primaryCount > 1) {
    playerPrimary = player.lastDroppableWeapon;
    if(isDefined(playerPrimary) && playerPrimary != "none") {
      player DropItem(playerPrimary);
    }
  }

  player _giveWeapon(newWeapon);
  player SwitchToWeapon(newWeapon);
  player GiveStartAmmo(newWeapon);
}

restockAmmoAura(config) {
  self endon("death");
  level endon("game_eneded");

  trigger = spawn("trigger_radius", self.origin, 0, config.triggerRadius, config.triggerHeight);
  trigger.owner = self;
  self thread maps\mp\gametypes\_weapons::deleteOnDeath(trigger);

  if(isDefined(self.moving_platform)) {
    trigger EnableLinkTo();
    trigger LinkTo(self.moving_platform);
  }

  rangeSq = config.triggerRadius * config.triggerRadius;
  player = undefined;
  while(true) {
    touchingPlayers = trigger GetIsTouchingEntities(level.players);

    foreach(player in touchingPlayers) {
      if(isDefined(player) &&
        !(self.owner IsEnemy(player)) &&
        self shouldAddAmmo(player)) {
        self addAmmo(player, config.ammoRestockTime);
      }
    }

    wait(config.ammoRestockCheckFreq);
  }
}

shouldAddAmmo(player) {
  return (!isDefined(player.deployableGunNextAmmoTime) ||
    GetTime() >= player.deployableGunNextAmmoTime);
}

addAmmo(player, freq) {
  player.deployableGunNextAmmoTime = GetTime() + (freq * 1000);
  maps\mp\gametypes\_weapons::scavengerGiveAmmo(player);

  player maps\mp\gametypes\_damagefeedback::hudIconType("boxofguns");
}

addAmmoOverTime(player, rangeSq, freq) {
  self endon("death");
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");

  while(true) {
    self addAmmo(player);

    wait(freq);

    if(DistanceSquared(player.origin, self.origin) > rangeSq) {
      break;
    }
  }
}

canUseDeployable(boxEnt) {
  if(is_aliens() && isDefined(boxEnt) && boxEnt.owner == self && !isDefined(boxEnt.air_dropped)) {
    return false;
  }
  if(!is_aliens()) {
    return (!self isJuggernaut());
  }
  else {
    return true;
  }
}