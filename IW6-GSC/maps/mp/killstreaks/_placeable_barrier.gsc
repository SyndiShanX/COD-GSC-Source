/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_placeable_barrier.gsc
******************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

KS_NAME = "placeable_barrier";
init() {
  config = spawnStruct();
  config.streakName = KS_NAME;
  config.weaponInfo = "ims_projectile_mp";

  config.modelBase = "placeable_barrier";
  config.modelDestroyed = "placeable_barrier_destroyed";
  config.modelPlacement = "placeable_barrier_obj";
  config.modelPlacementFailed = "placeable_barrier_obj_red";

  config.hintString = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_PICKUP";
  config.placeString = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_PLACE";
  config.cannotPlaceString = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_CANNOT_PLACE";
  config.headIconHeight = 75;
  config.splashName = "used_placeable_barrier";
  config.lifeSpan = 60.0;

  config.maxHealth = 500;
  config.allowMeleeDamage = false;
  config.damageFeedback = "ims";
  config.xpPopup = "destroyed_ims";
  config.destroyedVO = "ims_destroyed";

  config.onPlacedDelegate = ::onPlaced;
  config.onCarriedDelegate = ::onCarried;
  config.placedSfx = "ims_plant";
  config.onDamagedDelegate = ::onDamaged;

  config.onDeathDelegate = ::onDeath;
  config.deathVfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");

  config.colRadius = 72;
  config.colHeight = 36;

  level.placeableConfigs[KS_NAME] = config;

  setupBrushModel();

  level.killStreakFuncs[KS_NAME] = ::tryUsePlaceable;
}

tryUsePlaceable(lifeId, streakName) {
  result = self maps\mp\killstreaks\_placeable::givePlaceable(KS_NAME);

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(KS_NAME, self.origin);
  }

  self.isCarrying = undefined;

  return result;
}

onPlaced(streakName) {
  config = level.placeableConfigs[streakName];
  self setModel(config.modelBase);

  collision = spawn_tag_origin();
  collision Show();
  collision.origin = self.origin;

  if(!isDefined(level.barrierCollision)) {
    setupBrushModel();
  }
  collision CloneBrushmodelToScriptmodel(level.barrierCollision);

  otherTeam = getOtherTeam(self.owner.team);
  BadPlace_Cylinder(streakName + (self GetEntityNumber()), -1, self.origin, config.colRadius, config.colHeight, otherTeam);

  self.collision = collision;
}

onCarried(streakName) {
  self disableCollision(streakName);
}

onDamaged(streakname, attacker, owner, damage) {
  return damage;
}

onDeath(streakName) {
  self disableCollision(streakName);

  config = level.placeableConfigs[streakName];
  if(isDefined(config.deathSfx)) {
    self playSound(config.deathSfx);
  }

  playFX(config.deathVfx, self.origin);

  wait(0.5);
}

disableCollision(streakName) {
  if(isDefined(self.collision)) {
    BadPlace_Delete(streakName + (self GetEntityNumber()));

    self.collision Delete();

    self.collision = undefined;
  }
}

setupBrushModel() {
  scriptModel = GetEnt("barrier_collision", "targetname");

  if(isDefined(scriptmodel)) {
    level.barrierCollision = GetEnt(scriptModel.target, "targetname");
    scriptModel Delete();
  }

  if(!isDefined(level.barrierCollision)) {
    Print("!!! level does not contain a barrier_collision script model, please add one!");
    level.barrierCollision = level.airDropCrateCollision;
  }
}