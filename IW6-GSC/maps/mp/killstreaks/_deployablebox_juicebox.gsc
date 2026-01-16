/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_deployablebox_juicebox.gsc
***********************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

BOX_TYPE = "deployable_juicebox";

init() {
  boxConfig = spawnStruct();
  boxConfig.weaponInfo = "deployable_vest_marker_mp";
  boxConfig.modelBase = "afr_mortar_ammo_01";
  boxConfig.hintString = & "KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
  boxConfig.capturingString = & "KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
  boxConfig.event = "deployable_juicebox_taken";
  boxConfig.streakName = BOX_TYPE;
  boxConfig.splashName = "used_deployable_juicebox";
  boxConfig.shaderName = "compass_objpoint_deploy_juiced_friendly";
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
  boxConfig.maxHealth = 300;
  boxConfig.damageFeedback = "deployable_bag";
  boxConfig.deathWeaponInfo = "deployable_ammo_mp";
  boxConfig.deathVfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
  boxConfig.allowMeleeDamage = true;
  boxConfig.allowGrenadeDamage = false;
  boxConfig.maxUses = 4;

  level.boxSettings[BOX_TYPE] = boxConfig;

  level.killStreakFuncs[BOX_TYPE] = ::tryUseDeployableJuiced;

  level.deployable_box[BOX_TYPE] = [];
}

tryUseDeployableJuiced(lifeId, streakName) {
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
    assert(isDefined(boxEnt.upgrade_rank), "No rank specified for deployable juicebox");
    self thread maps\mp\perks\_perkfunctions::setJuiced(level.deployablebox_juicebox_rank[boxEnt.upgrade_rank]);
  } else {
    self thread maps\mp\perks\_perkfunctions::setJuiced(15);
  }
}

canUseDeployable(boxEnt) {
  if(is_aliens() && isDefined(boxEnt) && boxEnt.owner == self && !isDefined(boxEnt.air_dropped)) {
    return false;
  }

  return (!(self isJuggernaut()) && !(self maps\mp\perks\_perkfunctions::hasJuiced()));
}