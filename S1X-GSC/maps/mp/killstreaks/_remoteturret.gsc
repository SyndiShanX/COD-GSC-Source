/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_remoteturret.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

ENTER_MESSAGE_ALPHA = 0.25;
ENTER_MESSAGE_FADE_TIME = 1.5;

CONST_REMOTE_TURRET_SENTRY_BURSTMIN = 20;
CONST_REMOTE_TURRET_SENTRY_BURSTMAX = 120;
CONST_REMOTE_TURRET_SENTRY_PAUSEMIN = 0.15;
CONST_REMOTE_TURRET_SENTRY_PAUSEMAX = 0.35;
CONST_REMOTE_TURRET_SENTRY_SPINUPTIME = 0.05;
CONST_REMOTE_TURRET_SENTRY_OVERHEATTIME = 4.0;
CONST_REMOTE_TURRET_SENTRY_COOLDOWNTIME = 0.1;
CONST_REMOTE_TURRET_SENTRY_FXTIME = 0.3;
CONST_REMOTE_TURRET_SENTRY_HORZ_ARC = 80;
CONST_REMOTE_TURRET_SENTRY_HORZ_ARC_FULL = 180;
CONST_REMOTE_TURRET_SENTRY_TOP_ARC = 50;
CONST_REMOTE_TURRET_SENTRY_BOTTOM_ARC = 30;
CONST_REMOTE_TURRET_BEAM_WEAPINFO = "remote_energy_turret_mp";
CONST_REMOTE_TURRET_MG_WEAPINFO = "sentry_minigun_mp";
CONST_REMOTE_TURRET_ROCKET_WEAPINFO = "killstreakmahem_mp";

init() {
  if(!isDefined(level.turretType)) {
    level.turretType = [];
  }
  level.turretType["mg_turret"] = "remote_mg_turret";

  level.killStreakFuncs["remote_mg_turret"] = ::tryUseRemoteMGTurret;
  level.killStreakFuncs["remote_mg_sentry_turret"] = ::tryUseRemoteMGSentryTurret;

  level.killstreakWieldWeapons["remote_energy_turret_mp"] = "remote_mg_sentry_turret";
  level.killstreakWieldWeapons["sentry_minigun_mp"] = "remote_mg_sentry_turret";
  level.killstreakWieldWeapons["killstreakmahem_mp"] = "remote_mg_sentry_turret";

  if(!isDefined(level.turretSettings)) {
    level.turretSettings = [];
  }

  level.turretSettings["mg_turret"] = spawnStruct();
  level.turretSettings["mg_turret"].sentryModeOn = "sentry";
  level.turretSettings["mg_turret"].sentryModeOff = "sentry_offline";
  level.turretSettings["mg_turret"].timeOut = 60.0;
  level.turretSettings["mg_turret"].maxHealth = 1000;
  level.turretSettings["mg_turret"].streakName = "remote_mg_turret";

  level.turretSettings["mg_turret"].teamSplash = "used_remote_mg_turret";
  level.turretSettings["mg_turret"].hintEnter = &"MP_ENTER_REMOTE_TURRET";
  level.turretSettings["mg_turret"].hintPickUp = &"MP_HOLD_TO_CARRY";
  level.turretSettings["mg_turret"].hintRipOff = &"MP_TURRET_RIP_OFF";
  level.turretSettings["mg_turret"].hintDropTurret = &"MP_TURRET_DROP";
  level.turretSettings["mg_turret"].placeString = &"MP_TURRET_PLACE";
  level.turretSettings["mg_turret"].cannotPlaceString = &"MP_TURRET_CANNOT_PLACE";

  level.turretSettings["mg_turret"].laptopInfo = "killstreak_remote_turret_mp";

  level._effect["sentry_explode_mp"] = LoadFX("vfx/explosion/remote_sentry_death");
  level._effect["sentry_smoke_mp"] = LoadFX("vfx/smoke/vehicle_sentrygun_damaged_smoke");
  level._effect["sentry_overheat_mp"] = LoadFX("vfx/distortion/sentrygun_overheat");
  level._effect["antenna_light_mp"] = LoadFX("vfx/lights/light_detonator_blink");
  level._effect["sentry_stunned_mp"] = LoadFX("vfx/sparks/emp_drone_damage");
  level._effect["sentry_laser_flash"] = LoadFX("vfx/fire/remote_sentry_laser_flash");
  level._effect["sentry_gone"] = LoadFX("vfx/explosion/remote_sentry_death_smoke");
  level._effect["sentry_rocket_muzzleflash_wv"] = LoadFX("vfx/muzzleflash/rpg_flash_wv");
  level._effect["sentry_rocket_muzzleflash_view"] = LoadFX("vfx/muzzleflash/rpg_flash_view");

  game["dialog"]["ks_sentrygun_destroyed"] = "ks_sentrygun_destroyed";

  SetDevDvarIfUninitialized("scr_remote_turret_timeout", 0);
  SetDevDvarIfUninitialized("scr_remote_turret_destroy", 0);
}

tryUseRemoteMGSentryTurret(lifeId, modules) {
  result = tryUseRemoteTurret(lifeId, "mg_turret", true, modules);

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.turretSettings["mg_turret"].streakName, self.origin);
  }

  self.isCarrying = false;

  return result;
}

tryUseRemoteMGTurret(lifeId, modules) {
  result = tryUseRemoteTurret(lifeId, "mg_turret", false, modules);

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.turretSettings["mg_turret"].streakName, self.origin);
  }

  self.isCarrying = false;

  return result;
}

takeKillstreakWeapons(turretType) {
  self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe(level.turretSettings[turretType].laptopInfo);
}

tryUseRemoteTurret(lifeId, turretType, isSentry, modules) {
  if(isDefined(self.turret)) {
    self IPrintLnBold(&"KILLSTREAKS_SENTRY_IN_USE");
    return false;
  }

  turret = createTurretForPlayer(turretType, self, isSentry, modules);

  if(isDefined(level.isHorde) && level.isHorde && self.killstreakIndexWeapon == 1) {
    self.hordeClassTurret = turret;
  }

  self playerAddNotifyCommands();

  self removePerks();

  self.carriedTurret = turret;

  self setCarryingTurret(turret, true);

  self.carriedTurret = undefined;

  self thread restorePerks();

  if(isDefined(turret)) {
    return true;
  } else {
    return false;
  }
}

setupHeavyResistanceModel() {
  if(self.heavyResistance) {
    self HidePart("TAG_OPTIC_STANDARD");
  } else {
    self HidePart("TAG_OPTIC_RESISTANCE");
  }
}

setupRippableModel() {
  if(!self.rippable) {
    self HidePart("TAG_HANDLES");
  }
}

setModelTurretBaseOnly() {
  if(isDefined(self.model) && self.model != "") {
    self ShowAllParts();
  }
  if(self.energyTurret) {
    self setModel("npc_sentry_energy_turret_empty_base");
  } else if(self.rocketTurret) {
    self setModel("npc_sentry_rocket_turret_empty_base");
  } else {
    self setModel("npc_sentry_minigun_turret_empty_base");
  }
  self setupHeavyResistanceModel();
  self setupRippableModel();
}

setModelRemoteTurret() {
  if(isDefined(self.model) && self.model != "") {
    self ShowAllParts();
  }
  if(self.energyTurret) {
    self setModel("npc_sentry_energy_turret_base");
  } else if(self.rocketTurret) {
    self setModel("npc_sentry_rocket_turret_base");
  } else {
    self setModel("npc_sentry_minigun_turret_base");
  }
  self setupHeavyResistanceModel();
  self setupRippableModel();
}

setModelTurretPlacementGood() {
  if(isDefined(self.model) && self.model != "") {
    self ShowAllParts();
  }
  if(self.energyTurret) {
    self setModel("npc_sentry_energy_turret_base_yellow_obj");
  } else if(self.rocketTurret) {
    self setModel("npc_sentry_rocket_turret_base_yellow_obj");
  } else {
    self setModel("npc_sentry_minigun_turret_base_yellow_obj");
  }
  self setupHeavyResistanceModel();
  self setupRippableModel();
}

setModelTurretPlacementFailed() {
  if(isDefined(self.model) && self.model != "") {
    self ShowAllParts();
  }
  if(self.energyTurret) {
    self setModel("npc_sentry_energy_turret_base_red_obj");
  } else if(self.rocketTurret) {
    self setModel("npc_sentry_rocket_turret_base_red_obj");
  } else {
    self setModel("npc_sentry_minigun_turret_base_red_obj");
  }
  self setupHeavyResistanceModel();
  self setupRippableModel();
}

setCarryingTurret(turret, allowCancel) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isReallyAlive(self)) {
    turret Delete();
    return;
  }

  turret turret_setCarried(self);

  killstreakWeapon = self getKillstreakWeapon("remote_mg_sentry_turret");
  lastWeapon = self GetCurrentPrimaryWeapon();
  if(!maps\mp\gametypes\_weapons::isValidLastWeapon(lastWeapon) || lastWeapon == "iw5_underwater_mp") {
    lastWeapon = self getLastWeapon();
  }
  if(!allowCancel) {
    self _giveWeapon(killstreakWeapon, 0);
    self SwitchToWeapon(killstreakWeapon);
    self.water_last_weapon = killstreakWeapon;
    self _disableWeaponSwitch();
  }

  for(;;) {
    result = waittill_any_return("place_turret", "cancel_turret", "force_cancel_placement");

    if(result == "cancel_turret" || result == "force_cancel_placement") {
      if(result == "cancel_turret" && !allowCancel) {
        continue;
      }

      turret turret_setCancelled();
      if(!allowCancel) {
        if(!isDefined(self.underWater)) {
          self playerSwitchAwayFromHoldingTurret(lastWeapon, killstreakWeapon);
        } else {
          self.water_last_weapon = lastWeapon;
        }
        self _enableWeaponSwitch();
      }
      return false;
    }

    if(isDefined(turret)) {
      if(!turret.canBePlaced) {
        continue;
      }

      turret turret_setPlaced();
    }

    if(!allowCancel) {
      if(!isDefined(self.underWater)) {
        self playerSwitchAwayFromHoldingTurret(lastWeapon, killstreakWeapon);
      } else {
        self.water_last_weapon = lastWeapon;
      }
      self _enableWeaponSwitch();
    }
    return true;
  }
}

playerSwitchAwayFromHoldingTurret(lastWeapon, killstreakWeapon) {
  self endon("death");
  self endon("disconnect");

  self switch_to_last_weapon(lastWeapon);

  while(self GetCurrentPrimaryWeapon() != lastWeapon) {
    waitframe();
  }

  self.water_last_weapon = lastWeapon;

  self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe(killstreakWeapon);
}

setRipOffTurretHead(turret) {
  self endon("death");
  self endon("disconnect");

  assert(isReallyAlive(self));
  assert(isPlayer(self));

  turret setCanDamage(false);
  turret SetContents(0);
  turret FreeEntitySentient();

  turret.carriedBy = self;
  self.isCarrying = false;

  turret turret_setInactive();
  turret setModelTurretBaseOnly();
  turret notify("carried");
  turret notify("ripped");
  turret SetTurretMinimapVisible(false);
  turret thread deleteAfterTime(20);

  turret.remoteEnt makeGloballyUnusableByType();

  if(turret.energyTurret) {
    self thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadenergy_mp");
  } else if(turret.rocketTurret) {
    self thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadrocket_mp");
  } else {
    self thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadmg_mp");
  }

  turret playSound("sentry_gun_detach");
}

deleteAfterTime(time) {
  self endon("death");

  level maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(time);

  if(isDefined(self)) {
    deathSoundsAndFX();
    self delete();
  }
}

deathSoundsAndFX() {
  org = self GetTagOrigin("TAG_AIM_PIVOT");
  playFX(getfx("sentry_gone"), org);
  playSoundAtPos(org, "sentry_gun_self_destruct");
}

removePerks() {
  if(self _hasPerk("specialty_explosivebullets")) {
    self.restorePerk = "specialty_explosivebullets";
    self _unsetPerk("specialty_explosivebullets");
  }
}

restorePerks() {
  if(isDefined(self.restorePerk)) {
    self givePerk(self.restorePerk, false);
    self.restorePerk = undefined;
  }
}

waitRestorePerks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  self restorePerks();
}

turret_quickDeath(data) {
  self.quick_death = true;
  self notify("death");
}

turret_setPlaced() {
  self setModelRemoteTurret();

  self thread sentry_attackTargets();

  self SetSentryCarrier(undefined);
  self setCanDamage(true);

  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
    self make_entity_sentient_mp(self.owner.team);
  }

  data = spawnStruct();
  data.linkParent = self.placementLinkEntity;
  data.endonString = "carried";
  data.deathOverrideCallback = ::turret_quickDeath;
  self thread maps\mp\_movers::handle_moving_platforms(data);

  self playSound("sentry_gun_deploy");

  self thread turret_setActive();
  self notify("placed");
}

turret_setCancelled() {
  self.carriedBy forceUseHintOff();
  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  self delete();
}

turret_setCarried(carrier) {
  assert(isPlayer(carrier));
  assertEx(carrier == self.owner, "turret_setCarried() specified carrier does not own this turret");

  self setModelTurretPlacementGood();

  self setCanDamage(false);
  self SetSentryCarrier(carrier);
  self SetContents(0);
  self FreeEntitySentient();
  self Unlink();

  self.carriedBy = carrier;
  carrier.isCarrying = true;

  carrier thread updateTurretPlacement(self);

  self thread turret_onCarrierDeath(carrier);
  self thread turret_onCarrierDisconnect(carrier);
  self thread turret_onCarrierChangedTeam(carrier);
  self thread turret_onGameEnded();

  self SetDefaultDropPitch(-89.0);

  self turret_setInactive();

  self notify("carried");
}

updateTurretPlacement(turret) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  turret endon("placed");
  turret endon("death");

  turret.canBePlaced = true;
  turret.placementLinkEntity = undefined;

  lastCanPlaceTurret = -1;

  for(;;) {
    placement = self canPlayerPlaceSentry(true);

    turret.origin = placement["origin"];
    turret.angles = placement["angles"];
    turret.canBePlaced = self isOnGround() && placement["result"] && (abs(turret.origin[2] - self.origin[2]) < 10 && !turret isTouchingWater());

    if(isDefined(placement["entity"])) {
      turret.placementLinkEntity = placement["entity"];
    } else {
      turret.placementLinkEntity = undefined;
    }

    if(turret.canBePlaced != lastCanPlaceTurret) {
      if(turret.canBePlaced) {
        turret setModelTurretPlacementGood();
        self ForceUseHintOn(level.turretSettings[turret.turretType].placeString);
      } else {
        turret setModelTurretPlacementFailed();
        self ForceUseHintOn(level.turretSettings[turret.turretType].cannotPlaceString);
      }
    }

    lastCanPlaceTurret = turret.canBePlaced;
    wait(0.05);
  }
}

isTouchingWater() {
  if(!isDefined(level.water_triggers)) {
    return false;
  } else {
    foreach(trig in level.water_triggers) {
      if(self IsTouching(trig)) {
        return true;
      }
    }
  }

  return false;
}

turret_onCarrierDeath(carrier) {
  self endon("placed");
  self endon("death");
  self endon("ripped");

  carrier waittill("death");

  if(self.canBePlaced) {
    self turret_setPlaced();
  } else {
    if(isDefined(self.owner)) {
      self.owner.isCarrying = false;
    }
    self delete();
  }
}

turret_onCarrierDisconnect(carrier) {
  self endon("placed");
  self endon("death");
  self endon("ripped");

  carrier waittill("disconnect");

  self delete();
}

turret_onCarrierChangedTeam(carrier) {
  self endon("placed");
  self endon("death");
  self endon("ripped");

  carrier waittill_any("joined_team", "joined_spectators");

  self delete();
}

turret_onGameEnded(carrier) {
  self endon("placed");
  self endon("death");
  self endon("ripped");

  level waittill("game_ended");

  self delete();
}

createTurretForPlayer(turretType, owner, isSentry, modules) {
  assertEx(isDefined(owner), "createTurretForPlayer() called without owner specified");

  turretWeapon = CONST_REMOTE_TURRET_MG_WEAPINFO;
  if(array_contains(modules, "sentry_energy_turret")) {
    turretWeapon = CONST_REMOTE_TURRET_BEAM_WEAPINFO;
  }

  turret = SpawnTurret("misc_turret", owner.origin, turretWeapon);
  turret.angles = owner.angles;
  turret.owner = owner;
  turret.health = level.turretSettings[turretType].maxHealth;
  turret.maxHealth = level.turretSettings[turretType].maxHealth;
  turret.turretType = turretType;
  turret.stunned = false;
  turret.directHacked = false;
  turret.modules = modules;
  turret.heavyResistance = array_contains(turret.modules, "sentry_heavy_resistance");
  turret.antiIntrusion = array_contains(turret.modules, "sentry_anti_intrusion");
  turret.rocketTurret = array_contains(turret.modules, "sentry_rocket_turret");
  turret.energyTurret = array_contains(turret.modules, "sentry_energy_turret");
  turret.rippable = array_contains(turret.modules, "sentry_rippable");
  turret.isSentry = array_contains(turret.modules, "sentry_guardian");
  turret.is360 = array_contains(turret.modules, "sentry_360");
  turret.weaponInfo = turretWeapon;

  turret setModelRemoteTurret();

  if(turret.rocketTurret) {
    turret TurretFireDisable();
    turret.weaponInfo = CONST_REMOTE_TURRET_ROCKET_WEAPINFO;
  }

  if(turret.rocketTurret || turret.energyTurret) {
    turret TurretSetBarrelSpinEnabled(false);
  }

  turret SetTurretModeChangeWait(true);
  turret turret_setInactive();
  turret SetSentryOwner(owner);
  turret SetTurretMinimapVisible(true, turretType);

  if(turret.is360) {
    turret SetLeftArc(CONST_REMOTE_TURRET_SENTRY_HORZ_ARC_FULL);
    turret SetRightArc(CONST_REMOTE_TURRET_SENTRY_HORZ_ARC_FULL);
  } else {
    turret SetLeftArc(CONST_REMOTE_TURRET_SENTRY_HORZ_ARC);
    turret SetRightArc(CONST_REMOTE_TURRET_SENTRY_HORZ_ARC);
  }
  turret SetTopArc(CONST_REMOTE_TURRET_SENTRY_TOP_ARC);
  turret SetBottomArc(CONST_REMOTE_TURRET_SENTRY_BOTTOM_ARC);
  turret SetDefaultDropPitch(-89.0);

  turret thread turret_handleOwnerDisconnect();

  owner.turret = turret;

  turret.damageFade = 1.0;
  turret thread turret_incrementDamageFade();
  turret thread sentry_attackTargets();

  return turret;
}

turret_setActive() {
  self endon("death");
  self.owner endon("disconnect");

  self MakeUnusable();
  self MakeTurretSolid();

  if(!isDefined(self.owner)) {
    return;
  }

  owner = self.owner;

  level.turrets[self GetEntityNumber()] = self;

  if(isDefined(owner.remoteTurretList)) {
    foreach(turret in owner.remoteTurretList) {
      turret notify("death");
    }
  }
  owner.remoteTurretList = [];
  owner.remoteTurretList[0] = self;

  if(!isDefined(self.remoteEnt)) {
    self.remoteEnt = spawn("script_model", self.origin + (0, 0, 1));
    self.remoteEnt setModel("tag_origin");
    self.remoteEnt.owner = owner;
    self.remoteEnt makeGloballyUsableByType("killstreakRemote", level.turretSettings[self.turretType].hintEnter, owner);
  } else {
    self.remoteEnt enableGloballyUsableByType();
  }

  owner.using_remote_turret = false;
  owner.pickup_message_deleted = undefined;
  owner.enter_message_deleted = undefined;
  owner thread watchOwnerMessageOnDeath(self);

  if(level.teamBased) {
    self.team = owner.team;
    self setTurretTeam(owner.team);
    self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 65), "tag_origin");
  } else {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 65), "tag_origin");
  }

  self.ownerTrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 32, 64);
  assert(isDefined(self.ownerTrigger));

  self.pickupEnt = spawn("script_model", self.origin + (0, 0, 1));
  self.pickupEnt setModel("tag_origin");
  self.pickupEnt.owner = owner;

  owner thread player_handleTurretPickup(self);
  owner thread player_handleTurretHints(self);
  if(self.rippable) {
    owner thread player_handleTurretRippable(self);
  }

  self thread watchEnterAndExit();
  self thread turret_handleDeath();
  self thread maps\mp\gametypes\_damage::setEntityDamageCallback(self.maxhealth, undefined, ::onTurretDeath, ::turret_ModifyDamage, true);
  self thread turret_timeOut();
  self thread turret_gameEnd();
  self thread turret_watchEMP();
  if(!self.heavyResistance) {
    self thread turret_watchDisabled();
  }
  if(self.antiIntrusion) {
    self thread turret_createAntiIntrusionKillcamEnt();
  }

  self thread turret_handlePitch();
  self thread turret_handleLaser();

  if(isDefined(level.isHorde) && level.isHorde) {
    self thread turret_hordeShootDronesAndTurrets();
  }
  self thread turret_watchDestroy();
}

turret_ModifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = self maps\mp\gametypes\_damage::modifyDamage(attacker, weapon, type, damage);

  if(isDefined(self.owner) && (modifiedDamage > 0)) {
    self.owner PlayRumbleOnEntity("damage_heavy");
    self.owner thread maps\mp\killstreaks\_aerial_utility::playerShowStreakStaticForDamage();
  }

  return modifiedDamage;
}

onTurretDeath(attacker, weapon, meansOfDeath, damage) {
  self notify("death", attacker, meansOfDeath, weapon);

  if(isDefined(self.tagMarkedBy) && (self.tagMarkedBy != attacker)) {
    self.tagMarkedBy thread maps\mp\killstreaks\_marking_util::playerProcessTaggedAssist(self);
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    if(!isPlayer(attacker)) {
      attacker = attacker.owner;
    }
  }

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "sentry_gun_destroyed", undefined, undefined, false);
  self LaserOff();
}

playerShowTurretOverlay(turret) {
  self endon("disconnect");
  self endon("playerHideTurretOverlay");

  wait 0.5;

  omnvarValue = 0;
  if(turret.weaponInfo == CONST_REMOTE_TURRET_MG_WEAPINFO) {
    omnvarValue = 1;
  } else if(turret.weaponInfo == CONST_REMOTE_TURRET_BEAM_WEAPINFO) {
    omnvarValue = 2;
  } else if(turret.weaponInfo == CONST_REMOTE_TURRET_ROCKET_WEAPINFO) {
    omnvarValue = 3;
  }

  self SetClientOmnvar("ui_sentry_ammo_type", omnvarValue);
  self SetClientOmnvar("ui_sentry_toggle", true);
  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
}

playerHideTurretOverlay() {
  self notify("playerHideTurretOverlay");

  self SetClientOmnvar("ui_sentry_toggle", false);
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();
}

playerWaittillWeaponSwitchOver(weapon) {
  self endon("weapon_change");

  self waittill("weapon_switch_started", newWeapon);
  if(weapon != newWeapon) {
    return;
  }

  while(self IsSwitchingWeapon()) {
    waitframe();
  }
}

startUsingRemoteTurret(leftArc, rightArc, topArc, bottomArc, isCoop) {
  if(!isDefined(isCoop)) {
    isCoop = false;
  }

  owner = self.owner;

  if(!isCoop) {
    owner PlayerLinkTo(self.remoteEnt);
    owner PlayerLinkedOffsetEnable();
    owner _giveWeapon(level.turretSettings[self.turretType].laptopInfo);
    owner SwitchToWeapon(level.turretSettings[self.turretType].laptopInfo);
    owner DisableOffhandWeapons();
    owner DisableOffhandSecondaryWeapons();
    owner playerWaittillWeaponSwitchOver(level.turretSettings[self.turretType].laptopInfo);
    newWeapon = owner GetCurrentWeapon();

    if(newWeapon != level.turretSettings[self.turretType].laptopInfo) {
      owner takeKillstreakWeapons(self.turretType);
      owner EnableOffhandWeapons();
      owner EnableOffhandSecondaryWeapons();
      owner Unlink();
      return false;
    }
  }

  self.remoteControlled = true;

  self sentry_stopAttackingTargets();

  owner thread playerDoRideKillstreak(self, isCoop);
  owner waittill("initRideKillstreak_complete", success);
  if(!success) {
    return false;
  }

  owner playerSaveAngles();

  owner setUsingRemote(self.turretType);

  self notify("remoteControlledUpdate");
  self.killCamStartTime = GetTime();

  owner thread waitSetThermal(1.0, self);

  if(getDvarInt("camera_thirdPerson")) {
    owner setThirdPersonDOF(false);
  }

  owner PlayerLinkWeaponViewToDelta(self, "tag_player", 0, leftArc, rightArc, topArc, bottomArc, false);
  owner PlayerLinkedSetViewZNear(false);
  owner PlayerLinkedSetUseBaseAngleForViewClamp(true);
  owner RemoteControlTurret(self);

  if(isDefined(self.remoteEnt)) {
    self.remoteEnt disableGloballyUsableByType();
  }
  self turret_clearPickupHints();
  owner thread playerShowTurretOverlay(self);
  if(self.rocketTurret) {
    owner thread playerMonitorRocketTurretFire(self);
  }

  if(owner isJuggernaut()) {
    owner.juggernautOverlay.alpha = 0;
  }

  self thread playLoopSoundToPlayers("sentry_gun_remote_view_bg", (0, 0, 60), [owner]);

  return true;
}

waitSetThermal(delay, remoteTurret) {
  self endon("disconnect");
  remoteTurret endon("death");

  wait(delay);

  self ThermalVisionFOFOverlayOn();
}

stopUsingRemoteTurret(showMessage) {
  if(!isDefined(self.remoteControlled) || !self.remoteControlled) {
    return;
  }

  self.remoteControlled = undefined;
  self notify("remoteControlledUpdate");

  owner = self.owner;

  owner takeKillstreakWeapons(self.turretType);
  owner EnableOffhandWeapons();
  owner EnableOffhandSecondaryWeapons();

  self thread sentry_attackTargets();

  killstreakWeapon = getKillstreakWeapon(level.turretSettings[self.turretType].streakName);
  owner maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe(killstreakWeapon);

  lastWeapon = owner getLastWeapon();
  if(isDefined(owner.underWater) && owner.underWater) {
    lastWeapon = owner maps\mp\_utility::get_water_weapon();
  }

  owner switchToWeapon(lastWeapon);

  if(!isDefined(showMessage)) {
    showMessage = true;
  }

  owner Unlink();
  if(owner isUsingRemote()) {
    owner ThermalVisionFOFOverlayOff();
    owner RemoteControlTurretOff(self);
    if(owner isUsingRemote()) {
      owner clearUsingRemote();
    }

    if(getDvarInt("camera_thirdPerson")) {
      owner setThirdPersonDOF(true);
    }
  }

  if(self turret_isStunned()) {
    owner StopShellShock();
  }

  if(!self turret_isStunned() && showMessage && (!isDefined(owner.using_remote_turret_when_died) || !owner.using_remote_turret_when_died)) {
    self.remoteEnt enableGloballyUsableByType();
  }

  if(owner isJuggernaut()) {
    owner.juggernautOverlay.alpha = 1;
  }

  owner playerHideTurretOverlay();
  self notify("stop soundsentry_gun_remote_view_bg");

  if(isDefined(owner.killCamEnt)) {
    owner.killCamEnt delete();
  }

  self playerRestoreAngles();

  self notify("exit");
}

playerDoRideKillstreak(turret, isCoop) {
  type = "remote_turret";
  if(isCoop) {
    type = "coop";
  }

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(type);

  if(!isDefined(self)) {
    return;
  }

  if(result != "success" || turret turret_isStunned() || isDefined(turret.dead)) {
    if(result != "disconnect" || turret turret_isStunned() || isDefined(turret.dead)) {
      self thread playerRemoteKillstreakShowHud();
      turret stopUsingRemoteTurret(!isCoop);
    }

    self notify("initRideKillstreak_complete", false);
    return;
  }

  self notify("initRideKillstreak_complete", true);
}

watchOwnerMessageOnDeath(turret) {
  self endon("disconnect");
  turret endon("death");
  turret endon("ripped");

  self.using_remote_turret_when_died = false;
  while(true) {
    if(IsAlive(self)) {
      self waittill("death");
    }

    turret.remoteEnt disableGloballyUsableByType();
    turret turret_clearPickupHints();

    if(self.using_remote_turret) {
      self.using_remote_turret_when_died = true;
    } else {
      self.using_remote_turret_when_died = false;
    }

    self waittill("spawned_player");

    self.using_remote_turret_when_died = false;
    turret.remoteEnt enableGloballyUsableByType();
  }
}

watchEnterAndExit() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");

  owner = self.owner;

  thread watchEnterAndExitInput();

  while(true) {
    if(owner player_shouldDisableRemoteEnter(self)) {
      if(!isDefined(owner.enter_message_deleted) || !owner.enter_message_deleted) {
        owner.enter_message_deleted = true;
        self.remoteEnt disableGloballyUsableByType();
      }
    } else {
      if(isDefined(owner.enter_message_deleted) && owner.enter_message_deleted) {
        self.remoteEnt enableGloballyUsableByType();
        owner.enter_message_deleted = false;
      }
    }

    waitframe();
  }
}

player_shouldDisableRemoteEnter(turret) {
  currentWeapon = self GetCurrentWeapon();
  return (turret turret_isStunned() || self player_isUsingKillstreak(turret) || (isDefined(self.underWater) && self.underWater) || self.using_remote_turret || currentWeapon == "none" || self IsTouching(turret.ownerTrigger) || (self IsLinked() && !self.using_remote_turret) || (isDefined(self.empGrenaded) && self.empGrenaded)
  );
}

watchEnterAndExitInput() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");

  owner = self.owner;

  topArc = CONST_REMOTE_TURRET_SENTRY_TOP_ARC;
  bottomArc = CONST_REMOTE_TURRET_SENTRY_BOTTOM_ARC;
  leftArc = CONST_REMOTE_TURRET_SENTRY_HORZ_ARC;
  rightArc = CONST_REMOTE_TURRET_SENTRY_HORZ_ARC;

  if(self.is360) {
    leftArc = CONST_REMOTE_TURRET_SENTRY_HORZ_ARC_FULL;
    rightArc = CONST_REMOTE_TURRET_SENTRY_HORZ_ARC_FULL;
  }

  while(true) {
    self waittillRemoteTurretUsedReturn();

    owner.using_remote_turret = true;
    success = self startUsingRemoteTurret(leftArc, rightArc, topArc, bottomArc);

    if(success) {
      wait 2.0;

      self waittillRemoteTurretLeaveReturn();

      owner.using_remote_turret = false;
      self stopUsingRemoteTurret();

      wait 2.0;
    } else {
      owner.using_remote_turret = false;
    }
  }
}

waittillRemoteTurretUsedReturn() {
  owner = self.owner;

  while(true) {
    self.remoteEnt waittill("trigger");

    if(owner playerCanUseTurret(self)) {
      return;
    }
  }
}

waittillRemoteTurretLeaveReturn() {
  owner = self.owner;

  while(true) {
    useHold = 0;
    while(owner useButtonPressed()) {
      useHold += 0.05;
      if(useHold > 1 && owner playerCanUseTurret(self)) {
        return;
      }
      waitframe();
    }

    waitframe();
  }
}

playerCanUseTurret(turret) {
  if(self fragButtonPressed() || isDefined(self.throwingGrenade) || self SecondaryOffhandbuttonPressed()) {
    return false;
  }

  if(self IsUsingTurret() || !self IsOnGround()) {
    return false;
  }

  if(isDefined(turret.ownerTrigger) && self IsTouching(turret.ownerTrigger)) {
    return false;
  }

  if(isDefined(self.empGrenaded) && self.empGrenaded) {
    return false;
  }

  if(isDefined(self.isCarrying) && self.isCarrying) {
    return false;
  }

  if(isDefined(self.isCapturingCrate) && self.isCapturingCrate) {
    return false;
  }

  if(!IsAlive(self)) {
    return false;
  }

  if(!self.using_remote_turret && self isUsingRemote()) {
    return false;
  }

  if(self IsLinked() && !self.using_remote_turret) {
    return false;
  }

  return true;
}

player_isUsingKillstreak(turret) {
  currentWeapon = self GetCurrentWeapon();
  return (self isJuggernaut() || self isUsingRemote() || self isInRemoteTransition() || (isKillstreakWeapon(currentWeapon) &&
      currentWeapon != "killstreak_remote_turret_mp" &&
      currentWeapon != CONST_REMOTE_TURRET_MG_WEAPINFO &&
      currentWeapon != CONST_REMOTE_TURRET_BEAM_WEAPINFO &&
      currentWeapon != level.turretSettings[turret.turretType].laptopInfo &&
      currentWeapon != "none" &&
      currentWeapon != "turretheadmg_mp" &&
      currentWeapon != "turretheadenergy_mp" &&
      currentWeapon != "turretheadrocket_mp")
  );
}

player_handleTurretHints(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");

  if(IsBot(self)) {
    return;
  }

  if(!isDefined(turret.ownerTrigger) || !isDefined(turret.pickupEnt)) {
    return;
  }

  turret.pickupEnt endon("death");

  while(true) {
    if(self player_shouldClearTurretPickupHints(turret)) {
      if(!isDefined(self.pickup_message_deleted) || !self.pickup_message_deleted) {
        self.pickup_message_deleted = true;
        turret turret_clearPickupHints();
      }
    } else {
      if(isDefined(self.pickup_message_deleted) && self.pickup_message_deleted) {
        turret thread turret_setPickupHints();
        self.pickup_message_deleted = false;
      }
    }

    waitframe();
  }
}

player_shouldClearTurretPickupHints(turret) {
  currentWeapon = self GetCurrentWeapon();
  return (turret turret_isStunned() || self player_isUsingKillstreak(turret) || (isDefined(self.underWater) && self.underWater) || self.using_remote_turret || currentWeapon == "none" || !self IsTouching(turret.ownerTrigger) || !isReallyAlive(self) || !self IsOnGround() || isDefined(turret.carriedBy)
  );
}

player_handleTurretPickup(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");

  if(IsBot(self)) {
    return;
  }

  if(!isDefined(turret.ownerTrigger) || !isDefined(turret.pickupEnt)) {
    return;
  }

  turret.pickupEnt endon("death");

  buttonTime = 0;
  while(true) {
    if(player_isUsingKillstreak(turret)) {
      waitframe();
      continue;
    }

    if(!self IsTouching(turret.ownerTrigger)) {
      waitframe();
      continue;
    }

    if(isReallyAlive(self) &&
      self IsTouching(turret.ownerTrigger) &&
      !isDefined(turret.carriedBy) &&
      self IsOnGround()) {
      timeUsed = 0;
      while(self useButtonPressed()) {
        if(!isReallyAlive(self)) {
          break;
        }

        if(!self IsTouching(turret.ownerTrigger)) {
          break;
        }

        if(self fragButtonPressed() || self SecondaryOffhandbuttonPressed() || isDefined(self.throwingGrenade)) {
          break;
        }

        if(self IsLinked() || !self IsOnGround() || self IsUsingTurret() || self isUsingRemote()) {
          break;
        }

        if(isDefined(self.isCarrying) && self.isCarrying) {
          break;
        }

        if(isDefined(self.isCapturingCrate) && self.isCapturingCrate) {
          break;
        }

        if(isDefined(self.empGrenaded) && self.empGrenaded) {
          break;
        }

        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          break;
        }

        if(isDefined(self.ball_carried)) {
          break;
        }

        timeUsed += 0.05;
        if(timeUsed > 0.75) {
          turret playSound("sentry_gun_pick_up");
          turret SetMode(level.turretSettings[turret.turretType].sentryModeOff);
          turret sentry_stopAttackingTargets();
          self thread setCarryingTurret(turret, false);
          turret turret_clearPickupHints();
          self.remoteTurretList = undefined;
          turret.pickupEnt Delete();
          turret.ownerTrigger delete();
          return;
        }
        waitframe();
      }
    }
    waitframe();
  }
}

player_handleTurretRippable(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");

  if(IsBot(self)) {
    return;
  }

  if(!isDefined(turret.ownerTrigger) || !isDefined(turret.pickupEnt)) {
    return;
  }

  turret.pickupEnt endon("death");

  buttonTime = 0;
  while(true) {
    if(player_isUsingKillstreak(turret)) {
      wait(0.05);
      continue;
    }

    if(self maps\mp\killstreaks\_rippedturret::playerHasTurretHeadWeapon()) {
      waitframe();
      continue;
    }

    if(!self IsTouching(turret.ownerTrigger)) {
      wait(0.05);
      continue;
    }

    if(isReallyAlive(self) &&
      self IsTouching(turret.ownerTrigger) &&
      !isDefined(turret.carriedBy) &&
      self IsOnGround()) {
      if(self useButtonPressed()) {
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        buttonTime = 0;
        while(self useButtonPressed()) {
          buttonTime += 0.05;
          wait(0.05);
        }

        if(buttonTime >= 0.5) {
          continue;
        }

        buttonTime = 0;
        while(!self useButtonPressed() && buttonTime < 0.5) {
          buttonTime += 0.05;
          wait(0.05);
        }

        if(buttonTime >= 0.5) {
          continue;
        }

        if(!isReallyAlive(self)) {
          continue;
        }

        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        if(isDefined(self.ball_carried)) {
          continue;
        }

        turret SetMode(level.turretSettings[turret.turretType].sentryModeOff);
        turret sentry_stopAttackingTargets();
        self thread setRipOffTurretHead(turret);
        turret turret_clearPickupHints();
        self.remoteTurretList = undefined;
        turret.pickupEnt Delete();
        turret.ownerTrigger Delete();
        return;
      }
    }
    wait(0.05);
  }
}

turret_blinky_light() {
  self endon("death");
  self endon("carried");

  while(true) {
    playFXOnTag(getfx("antenna_light_mp"), self, "tag_fx");
    wait(1.0);
    stopFXOnTag(getfx("antenna_light_mp"), self, "tag_fx");
  }
}

turret_setInactive() {
  self SetMode(level.turretSettings[self.turretType].sentryModeOff);
  self sentry_stopAttackingTargets();

  if(level.teamBased) {
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.owner)) {
    return;
  }

  owner = self.owner;

  level.turrets[self GetEntityNumber()] = undefined;

  if(isDefined(self.remoteEnt)) {
    self.remoteEnt disableGloballyUsableByType();
  }

  if(isDefined(owner.using_remote_turret) && owner.using_remote_turret) {
    owner ThermalVisionOff();
    owner ThermalVisionFOFOverlayOff();
    owner RemoteControlTurretOff(self);
    owner unlink();

    lastWeapon = owner getLastWeapon();
    if(isDefined(owner.underWater) && owner.underWater) {
      lastWeapon = owner maps\mp\_utility::get_water_weapon();
    }

    owner switchToWeapon(lastWeapon);

    if(owner isUsingRemote()) {
      owner clearUsingRemote();
    }

    if(getDvarInt("camera_thirdPerson")) {
      owner setThirdPersonDOF(true);
    }

    if(isDefined(owner.disabledUsability) && owner.disabledUsability) {
      if(isDefined(level.isHorde) && level.isHorde && isDefined(owner.lastStand) && owner.lastStand) {
        if(owner.disabledUsability > 1) {
          owner.disabledUsability--;
        }
      } else {
        owner _enableUsability();
      }
    }

    owner takeKillstreakWeapons(self.turretType);

    if(owner isJuggernaut()) {
      owner.juggernautOverlay.alpha = 1;
    }
  }
}

turret_handleOwnerDisconnect() {
  self endon("death");
  level endon("game_ended");

  self notify("turret_handleOwner");
  self endon("turret_handleOwner");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("death");
}

turret_gameEnd() {
  self endon("death");
  level waittill("game_ended");
  if(isDefined(self.owner)) {
    self.owner playerHideTurretOverlay();
  }
}

turret_timeOut() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.timeoutStarted)) {
    return;
  }

  self.timeoutStarted = true;

  lifeSpan = level.turretSettings[self.turretType].timeOut;
  self.owner SetClientOmnvar("ui_sentry_lifespan", lifeSpan);

  if(getDvar("scr_remote_turret_timeout", "0") != "0") {
    lifeSpan = GetDvarFloat("scr_remote_turret_timeout");
  }

  while(lifeSpan) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(!isDefined(self.carriedBy)) {
      lifeSpan = max(0, lifeSpan - 1.0);
    }
  }

  if(isDefined(self.owner)) {
    self.owner playerHideTurretOverlay();
  }

  self notify("death");
}

turret_handleDeath() {
  self endon("carried");

  entNum = self GetEntityNumber();

  self maps\mp\killstreaks\_autosentry::addToTurretList(entNum);

  self waittill("death", attacker, meansOfDeath, weapon);

  self ClearTargetEntity();
  self turret_deathSounds(attacker, weapon);
  self.damagecallback = undefined;
  self setCanDamage(false);
  self SetDamageCallbackOn(false);
  self FreeEntitySentient();
  self LaserOff();
  self.dead = true;

  self maps\mp\killstreaks\_autosentry::removeFromTurretList(entNum);

  if(!isDefined(self)) {
    return;
  }

  self turret_clearPickupHints();
  self turret_setInactive();
  self setDefaultDropPitch(35);
  self SetSentryOwner(undefined);
  self SetTurretMinimapVisible(false);

  if(isDefined(self.remoteEnt)) {
    self.remoteEnt makeGloballyUnusableByType();
  }

  owner = self.owner;
  if(isDefined(owner)) {
    self stopUsingRemoteTurret();

    owner.using_remote_turret = false;
    owner.turret = undefined;

    owner restorePerks();
    owner playerRemoveNotifyCommands();
    if(owner GetCurrentWeapon() == "none") {
      lastWeapon = owner getLastWeapon();
      if(isDefined(owner.underWater) && owner.underWater) {
        lastWeapon = owner maps\mp\_utility::get_water_weapon();
      }

      owner switchToWeapon(lastWeapon);
    }
  }

  self playSound("sentry_gun_death_exp");

  if(!isDefined(self.quick_death) || !self.quick_death) {
    playFXOnTag(getFx("sentry_explode_mp"), self, "TAG_AIM_PIVOT");
    wait(1.5);

    for(smokeTime = 8; smokeTime > 0; smokeTime -= 0.4) {
      playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
      wait(0.4);
    }
  }

  self notify("deleting");

  if(isDefined(self.target_ent)) {
    self.target_ent delete();
  }

  if(isDefined(self.ownerTrigger)) {
    self.ownerTrigger delete();
  }

  if(isDefined(self.pickupEnt)) {
    self.pickupEnt Delete();
  }

  if(isDefined(self.remoteEnt)) {
    self.remoteEnt Delete();
  }

  if(isDefined(self.rocketMuzzleFlashEnt)) {
    self.rocketMuzzleFlashEnt Delete();
  }

  deathSoundsAndFX();

  self delete();
}

turret_deathSounds(attacker, weapon) {
  if(isDefined(self.owner) && isDefined(attacker) && self.owner != attacker) {
    self.owner thread leaderDialogOnPlayer("ks_sentrygun_destroyed", undefined, undefined, self.origin);
  }
}

turret_incrementDamageFade() {
  self endon("death");
  level endon("game_ended");

  damaged = false;
  while(true) {
    if(self.damageFade < 1.0) {
      self.damageFade += 0.1;
      damaged = true;
    } else {
      if(damaged) {
        self.damageFade = 1.0;

        damaged = false;
      }
    }
    wait(0.1);
  }
}

turret_setPickupHints() {
  self notify("turretClearPickupHints");
  self endon("turretClearPickupHints");

  Assert(isDefined(self.pickupEnt));

  self.pickupEnt MakeUsable();
  self.pickupEnt SetHintString(level.turretSettings[self.turretType].hintPickUp);
  self.pickupEnt SetCursorHint("HINT_NOICON");
  self.pickupEnt SetHintStringVisibleOnlyToOwner(true);

  if(self.rippable) {
    while(true) {
      hintStringSet = false;

      if(!hintStringSet && isDefined(self.owner) && !(self.owner maps\mp\killstreaks\_rippedturret::playerHasTurretHeadWeapon())) {
        self.pickupEnt SetSecondaryHintString(level.turretSettings[self.turretType].hintRipOff);
        hintStringSet = true;
      } else if(hintStringSet) {
        self.pickupEnt SetSecondaryHintString("");
        hintStringSet = false;
      }

      waitframe();
    }
  }
}

turret_clearPickupHints() {
  self notify("turretClearPickupHints");

  if(!isDefined(self.pickupEnt)) {
    return;
  }

  self.pickupEnt MakeUnusable();
  self.pickupEnt SetHintString("");
  self.pickupEnt SetSecondaryHintString("");
  self.pickupEnt SetHintStringVisibleOnlyToOwner(false);
}

sentry_stopAttackingTargets() {
  self notify("sentry_stop");
}

sentry_attackTargets(shootFunc) {
  if(!self.isSentry) {
    return;
  }

  self endon("sentry_stop");
  self endon("death");
  level endon("game_ended");
  self notify("sentry_start");

  self.momentum = 0;
  self.heatLevel = 0;
  self.overheated = false;

  if(!self.rocketTurret) {
    self thread sentry_heatMonitor(CONST_REMOTE_TURRET_MG_WEAPINFO, CONST_REMOTE_TURRET_SENTRY_OVERHEATTIME, CONST_REMOTE_TURRET_SENTRY_COOLDOWNTIME);
  }
  self SetMode(level.turretSettings["mg_turret"].sentryModeOn);
  self.fireReadyTime = GetTime();

  for(;;) {
    self waittill_either("turretstatechange", "cooled");

    if(self isFiringTurret()) {
      self thread turret_startShooting(shootFunc);
    } else {
      self thread turret_stopShooting();
    }
  }
}

turret_startShooting(shootFunc) {
  if(self.rocketTurret) {
    self thread turret_fireRockets();
  } else {
    self thread sentry_burstFireStart(shootFunc);
  }
}

turret_stopShooting() {
  if(self.rocketTurret) {
    self thread turret_stopRockets();
  } else {
    self sentry_spinDown();
    self thread sentry_burstFireStop();
  }
}

playerMonitorRocketTurretFire(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");
  turret endon("sentry_start");
  turret endon("exit");

  turret.fireReadyTime = GetTime();

  while(true) {
    self waittill("turret_fire");
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }

    if(GetTime() >= turret.fireReadyTime) {
      turret thread turret_fireRocket(false);
    }
  }
}

sentry_targetLockSound() {
  self endon("death");
  self endon("sentry_stop");

  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
}

sentry_spinUp() {
  self endon("death");
  self endon("sentry_stop");

  self thread sentry_targetLockSound();

  while(self.momentum < CONST_REMOTE_TURRET_SENTRY_SPINUPTIME) {
    self.momentum += 0.1;

    wait(0.1);
  }
}

sentry_spinDown() {
  self.momentum = 0;
}

sentry_burstFireStart(shootFunc) {
  self endon("death");
  self endon("sentry_stop");
  self endon("stop_shooting");

  level endon("game_ended");

  self sentry_spinUp();

  fireTime = weaponFireTime(CONST_REMOTE_TURRET_MG_WEAPINFO);
  minShots = CONST_REMOTE_TURRET_SENTRY_BURSTMIN;
  maxShots = CONST_REMOTE_TURRET_SENTRY_BURSTMAX;
  minPause = CONST_REMOTE_TURRET_SENTRY_PAUSEMIN;
  maxPause = CONST_REMOTE_TURRET_SENTRY_PAUSEMAX;

  for(;;) {
    numShots = randomIntRange(minShots, maxShots + 1);

    for(i = 0; i < numShots && !self.overheated; i++) {
      if(isDefined(shootFunc)) {
        self[[shootFunc]]();
      } else {
        self shootTurret();
      }
      self.heatLevel += fireTime;
      wait(fireTime);
    }

    wait(randomFloatRange(minPause, maxPause));
  }
}

turret_stopRockets() {
  self notify("stop_shooting");
}

turret_fireRockets() {
  self endon("death");
  self endon("sentry_stop");
  self endon("stop_shooting");

  level endon("game_ended");

  self.fireReadyTime = GetTime();

  while(true) {
    if(GetTime() >= self.fireReadyTime) {
      self thread turret_fireRocket(true);
    }

    waitframe();
  }
}

turret_fireRocket(isAutoTurret) {
  level endon("game_ended");

  start = self GetTagOrigin("tag_flash");
  dir = anglesToForward(self GetTagAngles("tag_flash"));
  end = start + (dir * 10000);
  start = start + (dir * 10);
  trace = bulletTrace(start, end, true);

  entHit = trace["entity"];

  hitEnemyPlayer = 0;

  if(isDefined(level.isHorde) && level.isHorde) {
    hitEnemyPlayer = (isDefined(entHit) && isDefined(entHit.team) && (self.team != entHit.team));
  } else {
    hitEnemyPlayer = (isDefined(entHit) && isPlayer(entHit) && !IsAlliedSentient(self.owner, entHit));
  }

  if(!hitEnemyPlayer && isAutoTurret) {
    return;
  }

  self playRumbleOnEntity("damage_heavy");
  rocket = MagicBullet(CONST_REMOTE_TURRET_ROCKET_WEAPINFO, start, end, self.owner);

  if(isAutoTurret) {
    reloadTime = 2500;
  } else {
    reloadTime = 1250;
  }

  self.fireReadyTime = GetTime() + reloadTime;

  if(!isAutoTurret) {
    PlayFXOnTagForClients(getfx("sentry_rocket_muzzleflash_view"), self, "tag_flash", self.owner);
    if(!isDefined(self.rocketMuzzleFlashEnt)) {
      self.rocketMuzzleFlashEnt = spawnMuzzleFlashEnt(self, "tag_flash", self.owner);
    }
    playFXOnTag(getfx("sentry_rocket_muzzleflash_wv"), self.rocketMuzzleFlashEnt, "tag_origin");
  } else {
    playFXOnTag(getfx("sentry_rocket_muzzleflash_wv"), self, "tag_flash");
  }
}

spawnMuzzleFlashEnt(parent, tagname, hideFromPlayer) {
  muzzleEnt = spawn("script_model", (0, 0, 0));
  muzzleEnt setModel("tag_origin");
  muzzleEnt LinkTo(parent, tagname, (0, 0, 0), (0, 0, 0));
  muzzleEnt Hide();
  foreach(player in level.players) {
    if(player != hideFromPlayer) {
      muzzleEnt ShowToPlayer(player);
    }
  }
  thread onPlayerConnectMuzzleFlashEnt(muzzleEnt);
  return muzzleEnt;
}

onPlayerConnectMuzzleFlashEnt(muzzleEnt) {
  muzzleEnt endon("death");

  while(true) {
    level waittill("connected", player);

    self thread onPlayerSpawnedMuzzleFlashEnt(muzzleEnt, player);
  }
}

onPlayerSpawnedMuzzleFlashEnt(muzzleEnt, player) {
  muzzleEnt endon("death");
  player endon("disconnect");

  player waittill("spawned_player");

  muzzleEnt ShowToPlayer(player);
}

sentry_burstFireStop() {
  self notify("stop_shooting");
}

sentry_heatMonitor(weapInfo, overheatTime, overheatCoolDown) {
  self endon("death");
  self endon("sentry_stop");

  fireTime = weaponFireTime(weapInfo);

  lastHeatLevel = 0;
  lastFxTime = 0;

  for(;;) {
    if(self.heatLevel != lastHeatLevel) {
      wait(fireTime);
    } else {
      self.heatLevel = max(0, self.heatLevel - 0.05);
    }

    if(self.heatLevel > overheatTime) {
      self.overheated = true;
      self TurretSetBarrelSpinEnabled(false);
      self thread playHeatFX();
      switch (self.turretType) {
        case "mg_turret":
          playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

          break;
        default:
          break;
      }

      while(self.heatLevel) {
        self.heatLevel = max(0, self.heatLevel - overheatCoolDown);
        wait(0.1);
      }

      self TurretSetBarrelSpinEnabled(true);
      self.overheated = false;
      self notify("not_overheated");
    }

    lastHeatLevel = self.heatLevel;
    wait(0.05);
  }
}

playHeatFX() {
  self endon("death");
  self endon("sentry_stop");
  self endon("not_overheated");
  level endon("game_ended");

  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(getFx("sentry_overheat_mp"), self, "tag_flash");

    wait(CONST_REMOTE_TURRET_SENTRY_FXTIME);
  }
}

turret_watchEMP() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  self waittill("emp_damage");

  self notify("death");
}

turret_watchDisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("concussed");

    duration = 4;

    playFXOnTag(getfx("sentry_stunned_mp"), self, "tag_aim");
    self notify("stunned");
    self.stunned = true;

    if(self.isSentry) {
      self SetDefaultDropPitch(35);
      self SetMode(level.turretSettings[self.turretType].sentryModeOff);
    }

    if(isDefined(self.remoteControlled) && self.remoteControlled) {
      self stopUsingRemoteTurret();
    }

    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(duration);

    stopFXOnTag(getfx("sentry_stunned_mp"), self, "tag_aim");

    if(self.isSentry) {
      self SetDefaultDropPitch(0);
      self SetMode(level.turretSettings[self.turretType].sentryModeOn);
    }
    self.stunned = false;
    self notify("stunnedDone");
  }
}

turret_isStunned() {
  return (isDefined(self.stunned) && self.stunned);
}

turret_createAntiIntrusionKillcamEnt() {
  ent = spawn("script_model", self.origin + (0, 0, 60));
  self.killCamEnt = ent;

  self waittill_any("death", "carried");

  wait 3;

  ent Delete();
}

turret_handleLaser() {
  self endon("death");

  if(!self.isSentry) {
    return;
  }

  self LaserOn("mp_sentry_turret");

  self waittill("carried");

  self LaserOff();
}

turret_handlePitch() {
  self endon("carried");
  self endon("death");

  if(self.isSentry) {
    self SetDefaultDropPitch(0);
    return;
  } else {
    self SetDefaultDropPitch(35);
  }

  while(true) {
    self waittill("remoteControlledUpdate");

    if(isDefined(self.remoteControlled) && self.remoteControlled) {
      self SetDefaultDropPitch(0);
    } else {
      self SetDefaultDropPitch(35);
    }
  }
}

turret_hordeShootDronesAndTurrets() {
  self endon("death");

  CONST_TURRET_MIDHEIGHT = (0, 0, 40);

  while(true) {
    minDistance = 5000000;
    closestDrone = undefined;

    foreach(drone in level.flying_attack_drones) {
      dist = DistanceSquared(self.origin, drone.origin);
      if(dist < minDistance) {
        if(SightTracePassed(self.origin + CONST_TURRET_MIDHEIGHT, drone.origin, false, undefined)) {
          minDistance = dist;
          closestDrone = drone;
        }
      }
    }

    closestSentry = undefined;
    foreach(sentry in level.hordeSentryArray) {
      dist = DistanceSquared(self.origin, sentry.origin);
      if(dist < minDistance) {
        if(SightTracePassed(self.origin + CONST_TURRET_MIDHEIGHT, sentry.origin + CONST_TURRET_MIDHEIGHT, false, undefined)) {
          minDistance = dist;
          closestSentry = sentry;
        }
      }
    }

    if(isDefined(closestSentry)) {
      self SetTargetEntity(closestSentry, CONST_TURRET_MIDHEIGHT);
    } else if(isDefined(closestDrone)) {
      self SetTargetEntity(closestDrone);
    }
    waitframe;
  }
}

playerAddNotifyCommands() {
  self NotifyOnPlayerCommand("turret_fire", "+attack");
  self NotifyOnPlayerCommand("turret_fire", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommand("place_turret", "+attack");
  self NotifyOnPlayerCommand("place_turret", "+attack_akimbo_accessible");
  if(!IsBot(self)) {
    self NotifyOnPlayerCommand("cancel_turret", "weapnext");
    self NotifyOnPlayerCommand("cancel_turret", "+actionslot 4");
    if(!level.console) {
      self NotifyOnPlayerCommand("cancel_turret", "+actionslot 5");
      self NotifyOnPlayerCommand("cancel_turret", "+actionslot 6");
      self NotifyOnPlayerCommand("cancel_turret", "+actionslot 7");
      self NotifyOnPlayerCommand("cancel_turret", "+actionslot 8");
    }
  }
}

playerRemoveNotifyCommands() {
  self NotifyOnPlayerCommandRemove("turret_fire", "+attack");
  self NotifyOnPlayerCommandRemove("turret_fire", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommandRemove("place_turret", "+attack");
  self NotifyOnPlayerCommandRemove("place_turret", "+attack_akimbo_accessible");
  if(!IsBot(self)) {
    self NotifyOnPlayerCommandRemove("cancel_turret", "+actionslot 4");
    if(!level.console) {
      self NotifyOnPlayerCommandRemove("cancel_turret", "weapnext");
      self NotifyOnPlayerCommandRemove("cancel_turret", "+actionslot 5");
      self NotifyOnPlayerCommandRemove("cancel_turret", "+actionslot 6");
      self NotifyOnPlayerCommandRemove("cancel_turret", "+actionslot 7");
      self NotifyOnPlayerCommandRemove("cancel_turret", "+actionslot 8");
    }
  }
}

turret_watchDestroy() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");

  while(true) {
    if(GetDvarInt("scr_remote_turret_destroy", 0) != 0) {
      break;
    }

    waitframe();
  }

  setDvar("scr_remote_turret_destroy", 0);

  self notify("death");
}
# /