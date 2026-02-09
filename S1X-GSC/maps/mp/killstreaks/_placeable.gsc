/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_placeable.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  if(!isDefined(level.placeableConfigs)) {
    level.placeableConfigs = [];
  }
}

givePlaceable(streakName) {
  placeable = self createPlaceable(streakName);

  self removePerks();

  self.carriedItem = placeable;

  result = self onBeginCarrying(streakName, placeable, true);

  self.carriedItem = undefined;

  self restorePerks();

  return (isDefined(placeable));
}

createPlaceable(streakName) {
  if(isDefined(self.isCarrying) && self.isCarrying) {
    return;
  }

  config = level.placeableConfigs[streakName];

  obj = spawn("script_model", self.origin);
  obj setModel(config.modelBase);
  obj.angles = self.angles;
  obj.owner = self;
  obj.team = self.team;
  obj.config = config;
  obj.firstPlacement = true;

  if(isDefined(config.onCreateDelegate)) {
    obj[[config.onCreateDelegate]](streakName);
  }

  obj deactivate(streakName);

  obj thread timeOut(streakName);
  obj thread handleUse(streakName);

  obj thread onKillstreakDisowned(streakName);
  obj thread onGameEnded(streakName);

  obj thread createBombSquadModel(streakName);

  return obj;
}

handleUse(streakName) {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("trigger", player);

    assert(player == self.owner);
    assert(!isDefined(self.carriedBy));

    if(!isReallyAlive(player)) {
      continue;
    }

    if(isDefined(self GetLinkedParent())) {
      self Unlink();
    }

    player onBeginCarrying(streakName, self, false);
  }
}

onBeginCarrying(streakName, placeable, allowCancel) {
  self endon("death");
  self endon("disconnect");

  assert(isReallyAlive(self));

  placeable thread onCarried(streakName, self);

  self _disableWeapon();

  if(!IsAI(self)) {
    self notifyOnPlayerCommand("placePlaceable", "+attack");
    self notifyOnPlayerCommand("placePlaceable", "+attack_akimbo_accessible");
    self notifyOnPlayerCommand("cancelPlaceable", "+actionslot 4");
    if(!level.console) {
      self notifyOnPlayerCommand("cancelPlaceable", "+actionslot 5");
      self notifyOnPlayerCommand("cancelPlaceable", "+actionslot 6");
      self notifyOnPlayerCommand("cancelPlaceable", "+actionslot 7");
      self notifyOnPlayerCommand("cancelPlaceable", "+actionslot 8");
    }
  }

  while(true) {
    result = waittill_any_return("placePlaceable", "cancelPlaceable", "force_cancel_placement");

    if(!isDefined(placeable)) {
      self _enableWeapon();
      return true;
    } else if((result == "cancelPlaceable" && allowCancel) || result == "force_cancel_placement") {
      placeable onCancel(streakName, result == "force_cancel_placement" && !isDefined(placeable.firstPlacement));
      return false;
    } else if(placeable.canBePlaced) {
      placeable thread onPlaced(streakName);
      self _enableWeapon();
      return true;
    }
  }
}

onCancel(streakName, playDestroyVfx) {
  if(isDefined(self.carriedBy)) {
    owner = self.carriedBy;
    owner ForceUseHintOff();
    owner.isCarrying = undefined;

    owner.carriedItem = undefined;

    owner _enableWeapon();
  }

  if(isDefined(self.bombSquadModel)) {
    self.bombSquadModel Delete();
  }

  if(isDefined(self.carriedObj)) {
    self.carriedObj Delete();
  }

  config = level.placeableConfigs[streakName];
  if(isDefined(config.onCancelDelegate)) {
    self[[config.onCancelDelegate]](streakName);
  }

  if(isDefined(playDestroyVfx) && playDestroyVfx) {
    self maps\mp\gametypes\_weapons::equipmentDeleteVfx();
  }

  self Delete();
}

onPlaced(streakName) {
  config = level.placeableConfigs[streakName];

  self.origin = self.placementOrigin;
  self.angles = self.carriedObj.angles;

  self playSound(config.placedSfx);

  self showPlacedModel(streakName);

  if(isDefined(config.onPlacedDelegate)) {
    self[[config.onPlacedDelegate]](streakName);
  }

  self setCursorHint("HINT_NOICON");
  self setHintString(config.hintString);

  owner = self.owner;
  owner ForceUseHintOff();
  owner.isCarrying = undefined;
  self.carriedBy = undefined;
  self.isPlaced = true;
  self.firstPlacement = undefined;

  if(isDefined(config.headIconHeight)) {
    if(level.teamBased) {
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, config.headIconHeight));
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(owner, (0, 0, config.headIconHeight));
    }
  }

  self thread handleDamage(streakName);
  self thread handleDeath(streakName);

  self MakeUsable();

  self make_entity_sentient_mp(self.owner.team);
  if(IsSentient(self)) {
    self SetThreatBiasGroup("DogsDontAttack");
  }

  foreach(player in level.players) {
    if(player == owner) {
      self EnablePlayerUse(player);
    } else {
      self DisablePlayerUse(player);
    }
  }

  if(isDefined(self.shouldSplash)) {
    level thread teamPlayerCardSplash(config.splashName, owner);
    self.shouldSplash = false;
  }

  data = spawnStruct();
  data.linkParent = self.moving_platform;
  data.playDeathFx = true;
  data.endonString = "carried";
  if(isDefined(config.onMovingPlatformCollision)) {
    data.deathOverrideCallback = config.onMovingPlatformCollision;
  }
  self thread maps\mp\_movers::handle_moving_platforms(data);

  self thread watchPlayerConnected();

  self notify("placed");

  self.carriedObj Delete();
  self.carriedObj = undefined;
}

onCarried(streakName, carrier) {
  config = level.placeableConfigs[streakName];

  assert(isPlayer(carrier));
  assertEx(carrier == self.owner, "_placeable::onCarried: specified carrier does not own this ims");

  self.carriedObj = carrier createCarriedObject(streakName);

  self.isPlaced = undefined;
  self.carriedBy = carrier;
  carrier.isCarrying = true;

  self deactivate(streakName);

  self hidePlacedModel(streakName);

  if(isDefined(config.onCarriedDelegate)) {
    self[[config.onCarriedDelegate]](streakName);
  }

  self thread updatePlacement(streakName, carrier);

  self thread onCarrierDeath(streakName, carrier);

  self notify("carried");
}

updatePlacement(streakName, carrier) {
  carrier endon("death");
  carrier endon("disconnect");
  level endon("game_ended");

  self endon("placed");
  self endon("death");

  self.canBePlaced = true;
  prevCanBePlaced = -1;

  config = level.placeableConfigs[streakName];

  placementOffset = (0, 0, 0);
  if(isDefined(config.placementOffsetZ)) {
    placementOffset = (0, 0, config.placementOffsetZ);
  }

  carriedObj = self.carriedObj;

  while(true) {
    placement = carrier CanPlayerPlaceSentry(true, config.placementRadius);

    self.placementOrigin = placement["origin"];
    carriedObj.origin = self.placementOrigin + placementOffset;
    carriedObj.angles = placement["angles"];

    self.canBePlaced = carrier IsOnGround() &&
      placement["result"] &&
      (abs(self.placementOrigin[2] - carrier.origin[2]) < config.placementHeightTolerance);

    if(isDefined(placement["entity"])) {
      self.moving_platform = placement["entity"];
    } else {
      self.moving_platform = undefined;
    }

    if(self.canBePlaced != prevCanBePlaced) {
      if(self.canBePlaced) {
        carriedObj setModel(config.modelPlacement);
        carrier ForceUseHintOn(config.placeString);
      } else {
        carriedObj setModel(config.modelPlacementFailed);
        carrier ForceUseHintOn(config.cannotPlaceString);
      }
    }

    prevCanBePlaced = self.canBePlaced;
    wait(0.05);
  }
}

deactivate(streakName) {
  self MakeUnusable();

  self hideHeadIcons();

  self FreeEntitySentient();

  config = level.placeableConfigs[streakName];
  if(isDefined(config.onDeactiveDelegate)) {
    self[[config.onDeactiveDelegate]](streakName);
  }
}

hideHeadIcons() {
  if(level.teamBased) {
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));
  }
}

handleDamage(streakName) {
  self endon("carried");

  config = level.placeableConfigs[streakName];

  self maps\mp\gametypes\_damage::setEntityDamageCallback(
    config.maxHealth, config.damageFeedback, ::handleDeathDamage, ::modifyDamage, true
  );
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  config = self.config;
  if(isDefined(config.allowMeleeDamage) && config.allowMeleeDamage) {
    modifiedDamage = self maps\mp\gametypes\_damage::handleMeleeDamage(weapon, type, modifiedDamage);
  }

  if(isDefined(config.allowEmpDamage) && config.allowEmpDamage) {
    modifiedDamage = self maps\mp\gametypes\_damage::handleEmpDamage(weapon, type, modifiedDamage, attacker);
  }
  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  if(isDefined(config.modifyDamage)) {
    modifiedDamage = self[[config.modifyDamage]](weapon, type, modifiedDamage);
  }

  return modifiedDamage;
}

handleDeathDamage(attacker, weapon, type, damage) {
  config = self.config;

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, config.xpPopup, config.destroyedVO);
}

handleDeath(streakName) {
  self endon("carried");

  self waittill("death");

  config = level.placeableConfigs[streakName];

  if(isDefined(self)) {
    self deactivate(streakName);

    if(isDefined(config.modelDestroyed)) {
      self setModel(config.modelDestroyed);
    }

    if(isDefined(config.onDeathDelegate)) {
      self[[config.onDeathDelegate]](streakName);
    }

    self Delete();
  }
}

onCarrierDeath(streakName, carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("disconnect");

  carrier waittill("death");

  if(self.canBePlaced) {
    self thread onPlaced(streakName);
  } else {
    self onCancel(streakName);
  }
}

onKillstreakDisowned(streakName) {
  self endon("death");
  level endon("game_ended");

  self.owner waittill("killstreak_disowned");

  self cleanup(streakName);
}

onGameEnded(streakName) {
  self endon("death");

  level waittill("game_ended");

  self cleanup(streakName);
}

cleanup(streakName) {
  if(isDefined(self.isPlaced)) {
    self notify("death");
  } else {
    self onCancel(streakName);
  }
}

watchPlayerConnected() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    self thread onPlayerConnected(player);
  }
}

onPlayerConnected(owner) {
  self endon("death");
  owner endon("disconnect");

  owner waittill("spawned_player");

  self DisablePlayerUse(owner);
}

timeOut(streakName) {
  self endon("death");
  level endon("game_ended");

  config = level.placeableConfigs[streakName];
  lifeSpan = config.lifeSpan;

  while(lifeSpan > 0.0) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(!isDefined(self.carriedBy)) {
      lifeSpan -= 1.0;
    }
  }

  if(isDefined(self.owner) && isDefined(config.goneVO)) {
    self.owner thread leaderDialogOnPlayer(config.goneVO);
  }

  self notify("death");
}

removeWeapons() {
  if(self HasWeapon("iw6_riotshield_mp")) {
    self.restoreWeapon = "iw6_riotshield_mp";
    self takeWeapon("iw6_riotshield_mp");
  }
}

removePerks() {
  if(self _hasPerk("specialty_explosivebullets")) {
    self.restorePerk = "specialty_explosivebullets";
    self _unsetPerk("specialty_explosivebullets");
  }
}

restoreWeapons() {
  if(isDefined(self.restoreWeapon)) {
    self _giveWeapon(self.restoreWeapon);
    self.restoreWeapon = undefined;
  }
}

restorePerks() {
  if(isDefined(self.restorePerk)) {
    self givePerk(self.restorePerk, false);
    self.restorePerk = undefined;
  }
}

createBombSquadModel(streakName) {
  config = level.placeableConfigs[streakName];

  if(isDefined(config.modelBombSquad)) {
    bombSquadModel = spawn("script_model", self.origin);
    bombSquadModel.angles = self.angles;
    bombSquadModel Hide();

    bombSquadModel thread maps\mp\gametypes\_weapons::bombSquadVisibilityUpdater(self.owner);
    bombSquadModel setModel(config.modelBombSquad);
    bombSquadModel LinkTo(self);
    bombSquadModel SetContents(0);
    self.bombSquadModel = bombSquadModel;

    self waittill("death");

    if(isDefined(bombSquadModel)) {
      bombSquadModel delete();
      self.bombSquadModel = undefined;
    }
  }
}

showPlacedModel(streakname) {
  self Show();

  if(isDefined(self.bombSquadModel)) {
    self.bombSquadModel Show();
    level notify("update_bombsquad");
  }
}

hidePlacedModel(streakName) {
  self Hide();

  if(isDefined(self.bombSquadModel)) {
    self.bombSquadModel Hide();
  }
}

createCarriedObject(streakName) {
  assertEx(isDefined(self), "createIMSForPlayer() called without owner specified");

  if(isDefined(self.isCarrying) && self.isCarrying) {
    return;
  }

  carriedObj = SpawnTurret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");

  carriedObj.angles = self.angles;
  carriedObj.owner = self;

  config = level.placeableConfigs[streakName];
  carriedObj setModel(config.modelBase);

  carriedObj MakeTurretInoperable();
  carriedObj SetTurretModeChangeWait(true);
  carriedObj SetMode("sentry_offline");
  carriedObj MakeUnusable();
  carriedObj SetSentryOwner(self);
  carriedObj SetSentryCarrier(self);

  carriedObj setCanDamage(false);
  carriedObj SetContents(0);

  return carriedObj;
}