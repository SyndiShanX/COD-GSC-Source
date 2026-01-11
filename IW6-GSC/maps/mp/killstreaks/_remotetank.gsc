/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_remotetank.gsc
***********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

PLACEMENT_RADIUS = 25.0;
PLACEMENT_HEIGHT = 25.0;
PLACEMENT_FORWARD_DISTANCE = 50.0;
PLACEMENT_UP_DISTANCE = 40.0;
PLACEMENT_SWEEP_DISTANCE = 80.0;
PLACEMENT_MIN_NORMAL = 0.7;

MAX_DAMAGE_STATE = 7;

RELOAD_MG_TIME = 2.5;
RELOAD_MISSILE_TIME = 5.0;
EMP_GRENADE_TIME = 3.5;
DAMAGE_FADE_TIME = 1.0;

init() {
  level.killStreakFuncs["remote_tank"] = ::tryUseRemoteTank;

  level.tankSettings = [];

  level.tankSettings["remote_tank"] = spawnStruct();
  level.tankSettings["remote_tank"].timeOut = 60.0;
  level.tankSettings["remote_tank"].health = 99999;
  level.tankSettings["remote_tank"].maxHealth = 1000;
  level.tankSettings["remote_tank"].streakName = "remote_tank";
  level.tankSettings["remote_tank"].mgTurretInfo = "ugv_turret_mp";

  level.tankSettings["remote_tank"].missileInfo = "remote_tank_projectile_mp";
  level.tankSettings["remote_tank"].sentryModeOff = "sentry_offline";
  level.tankSettings["remote_tank"].vehicleInfo = "remote_ugv_mp";
  level.tankSettings["remote_tank"].modelBase = "vehicle_ugv_talon_mp";
  level.tankSettings["remote_tank"].modelMGTurret = "vehicle_ugv_talon_gun_mp";

  level.tankSettings["remote_tank"].modelPlacement = "vehicle_ugv_talon_obj";
  level.tankSettings["remote_tank"].modelPlacementFailed = "vehicle_ugv_talon_obj_red";
  level.tankSettings["remote_tank"].modelDestroyed = "vehicle_ugv_talon_mp";
  level.tankSettings["remote_tank"].stringPlace = &"KILLSTREAKS_REMOTE_TANK_PLACE";
  level.tankSettings["remote_tank"].stringCannotPlace = &"KILLSTREAKS_REMOTE_TANK_CANNOT_PLACE";
  level.tankSettings["remote_tank"].laptopInfo = "killstreak_remote_tank_laptop_mp";
  level.tankSettings["remote_tank"].remoteInfo = "killstreak_remote_tank_remote_mp";

  level._effect["remote_tank_dying"] = LoadFX("fx/explosions/killstreak_explosion_quick");
  level._effect["remote_tank_explode"] = LoadFX("fx/explosions/bouncing_betty_explosion");
  level._effect["remote_tank_spark"] = LoadFX("fx/impacts/large_metal_painted_hit");
  level._effect["remote_tank_antenna_light_mp"] = LoadFX("fx/misc/aircraft_light_red_blink");
  level._effect["remote_tank_camera_light_mp"] = LoadFX("fx/misc/aircraft_light_wingtip_green");

  level.remote_tank_armor_bulletdamage = 0.5;

  SetDevDvarIfUninitialized("scr_remotetank_timeout", 60.0);
}

tryUseRemoteTank(lifeId, streakName) {
  numIncomingVehicles = 1;

  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  incrementFauxVehicleCount();

  result = self giveTank(lifeId, "remote_tank");
  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent("remote_tank", self.origin);
    self thread teamPlayerCardSplash("used_remote_tank", self);

    self takeKillstreakWeapons("remote_tank");
  } else {
    decrementFauxVehicleCount();
  }

  self.isCarrying = false;

  return result;
}

takeKillstreakWeapons(tankType) {
  if(!is_aliens()) {
    killstreakWeapon = getKillstreakWeapon(level.tankSettings[tankType].streakName);
  } else {
    killstreakWeapon = "killstreak_remote_tank_mp";
  }

  maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe(killstreakWeapon);

  self TakeWeapon(level.tankSettings[tankType].laptopInfo);
  self TakeWeapon(level.tankSettings[tankType].remoteInfo);
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

removeWeapons() {
  weaponlist = self GetWeaponsListPrimaries();
  foreach(weapon in weaponlist) {
    weaponTokens = StrTok(weapon, "_");
    if(weaponTokens[0] == "alt") {
      self.restoreWeaponClipAmmo[weapon] = self GetWeaponAmmoClip(weapon);
      self.restoreWeaponStockAmmo[weapon] = self GetWeaponAmmoStock(weapon);
      continue;
    }

    self.restoreWeaponClipAmmo[weapon] = self GetWeaponAmmoClip(weapon);
    self.restoreWeaponStockAmmo[weapon] = self GetWeaponAmmoStock(weapon);
  }

  self.weaponsToRestore = [];
  foreach(weapon in weaponlist) {
    weaponTokens = StrTok(weapon, "_");

    self.weaponsToRestore[self.weaponsToRestore.size] = weapon;

    if(weaponTokens[0] == "alt") {
      continue;
    }
    self TakeWeapon(weapon);
  }
}

restoreWeapons() {
  if(!isDefined(self.restoreWeaponClipAmmo) ||
    !isDefined(self.restoreWeaponStockAmmo) ||
    !isDefined(self.weaponsToRestore)) {
    return;
  }
  altWeapons = [];
  foreach(weapon in self.weaponsToRestore) {
    weaponTokens = StrTok(weapon, "_");
    if(weaponTokens[0] == "alt") {
      altWeapons[altWeapons.size] = weapon;
      continue;
    }

    self _giveWeapon(weapon);
    if(isDefined(self.restoreWeaponClipAmmo[weapon])) {
      self SetWeaponAmmoClip(weapon, self.restoreWeaponClipAmmo[weapon]);
    }
    if(isDefined(self.restoreWeaponStockAmmo[weapon])) {
      self SetWeaponAmmoStock(weapon, self.restoreWeaponStockAmmo[weapon]);
    }
  }

  foreach(altWeapon in altWeapons) {
    if(isDefined(self.restoreWeaponClipAmmo[altWeapon])) {
      self SetWeaponAmmoClip(altWeapon, self.restoreWeaponClipAmmo[altWeapon]);
    }
    if(isDefined(self.restoreWeaponStockAmmo[altWeapon])) {
      self SetWeaponAmmoStock(altWeapon, self.restoreWeaponStockAmmo[altWeapon]);
    }
  }

  self.restoreWeaponClipAmmo = undefined;
  self.restoreWeaponStockAmmo = undefined;
}

waitRestoreWeapons() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  self restoreWeapons();
}

giveTank(lifeId, tankType) {
  tankForPlayer = createTankForPlayer(tankType, self);
  tankForPlayer.lifeId = lifeId;

  self removePerks();
  self removeWeapons();

  result = self setCarryingTank(tankForPlayer, true);

  self thread restorePerks();
  self thread restoreWeapons();

  if(!isDefined(result)) {
    result = false;
  }

  return result;
}

createTankForPlayer(tankType, owner) {
  assertEx(isDefined(owner), "createTankForPlayer() called without owner specified");

  tank = SpawnTurret("misc_turret", owner.origin + (0, 0, 25), level.tankSettings[tankType].mgTurretInfo);

  tank.angles = owner.angles;
  tank.tankType = tankType;
  tank.owner = owner;

  tank setModel(level.tankSettings[tankType].modelBase);

  tank MakeTurretInoperable();
  tank SetTurretModeChangeWait(true);
  tank SetMode("sentry_offline");
  tank MakeUnusable();
  tank SetSentryOwner(owner);

  return tank;
}

setCarryingTank(tankForPlayer, allowCancel) {
  self endon("death");
  self endon("disconnect");

  assert(isReallyAlive(self));

  tankForPlayer thread tank_setCarried(self);

  self _disableWeapon();

  self notifyOnPlayerCommand("place_tank", "+attack");
  self notifyOnPlayerCommand("place_tank", "+attack_akimbo_accessible");
  self notifyOnPlayerCommand("cancel_tank", "+actionslot 4");
  if(!level.console) {
    self notifyOnPlayerCommand("cancel_tank", "+actionslot 5");
    self notifyOnPlayerCommand("cancel_tank", "+actionslot 6");
    self notifyOnPlayerCommand("cancel_tank", "+actionslot 7");
  }

  while(true) {
    result = waittill_any_return("place_tank", "cancel_tank", "force_cancel_placement");

    if(result == "cancel_tank" || result == "force_cancel_placement") {
      if(!allowCancel && result == "cancel_tank") {
        continue;
      }
      if(level.console) {
        killstreakWeapon = getKillstreakWeapon(level.tankSettings[tankForPlayer.tankType].streakName);
        if(isDefined(self.killstreakIndexWeapon) &&
          killstreakWeapon == getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName) &&
          !(self GetWeaponsListItems()).size) {
          self _giveWeapon(killstreakWeapon, 0);
          self _setActionSlot(4, "weapon", killstreakWeapon);
        }
      }

      tankForPlayer tank_setCancelled();
      self _enableWeapon();
      return false;
    }

    if(!tankForPlayer.canBePlaced) {
      continue;
    }
    tankForPlayer thread tank_setPlaced();
    self _enableWeapon();
    return true;
  }
}

tank_setCarried(carrier) {
  assert(isPlayer(carrier));
  assertEx(carrier == self.owner, "tank_setCarried() specified carrier does not own this ims");

  self setModel(level.tankSettings[self.tankType].modelPlacement);

  self SetSentryCarrier(carrier);
  self SetContents(0);
  self setCanDamage(false);

  self.carriedBy = carrier;
  carrier.isCarrying = true;

  carrier thread updateTankPlacement(self);

  self thread tank_onCarrierDeath(carrier);
  self thread tank_onCarrierDisconnect(carrier);
  self thread tank_onGameEnded();

  self notify("carried");
}

updateTankPlacement(tank) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  tank endon("placed");
  tank endon("death");

  tank.canBePlaced = true;
  lastCanPlaceTank = -1;

  while(true) {
    placement = self CanPlayerPlaceTank(PLACEMENT_RADIUS, PLACEMENT_HEIGHT, PLACEMENT_FORWARD_DISTANCE, PLACEMENT_UP_DISTANCE, PLACEMENT_SWEEP_DISTANCE, PLACEMENT_MIN_NORMAL);

    tank.origin = placement["origin"];
    tank.angles = placement["angles"];
    tank.canBePlaced = self isOnGround() && placement["result"] && (abs(placement["origin"][2] - self.origin[2]) < 20);

    if(is_aliens()) {
      tank.canBePlaced = tank.canBePlaced && !self.inLastStand;
    }

    if(tank.canBePlaced != lastCanPlaceTank) {
      if(tank.canBePlaced) {
        tank setModel(level.tankSettings[tank.tankType].modelPlacement);
        if(self.team != "spectator") {
          self ForceUseHintOn(level.tankSettings[tank.tankType].stringPlace);
        }
      } else {
        tank setModel(level.tankSettings[tank.tankType].modelPlacementFailed);
        if(self.team != "spectator") {
          if(!is_aliens()) {
            self ForceUseHintOn(level.tankSettings[tank.tankType].stringCannotPlace);
          }
          else {
            if(!self.inLastStand) {
              self ForceUseHintOn(level.tankSettings[tank.tankType].stringCannotPlace);
            }
          }
        }
      }
    }

    lastCanPlaceTank = tank.canBePlaced;
    wait(0.05);
  }
}

tank_onCarrierDeath(carrier) {
  self endon("placed");
  self endon("death");

  if(!is_aliens()) {
    carrier waittill("death");
  }
  else {
    carrier waittill_any("death", "last_stand");
    carrier notify("cancel_tank");
  }

  self tank_setCancelled();
}

tank_onCarrierDisconnect(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill("disconnect");

  self tank_setCancelled();
}

tank_onGameEnded(carrier) {
  self endon("placed");
  self endon("death");

  level waittill("game_ended");

  self tank_setCancelled();
}

tank_setCancelled() {
  if(isDefined(self.carriedBy)) {
    self.carriedBy forceUseHintOff();
  }

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  if(isDefined(self)) {
    self delete();
  }
}

tank_setPlaced() {
  self endon("death");
  level endon("game_ended");

  self notify("placed");
  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  if(!isDefined(self.owner)) {
    return false;
  }

  owner = self.owner;

  owner.isCarrying = false;

  tank = createTank(self);
  if(!isDefined(tank)) {
    return false;
  }

  tank playSound("sentry_gun_plant");

  tank notify("placed");
  tank thread tank_setActive();

  self delete();
}

tank_giveWeaponOnPlaced() {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;
  owner endon("death");

  self waittill("placed");

  owner takeKillstreakWeapons(self.tankType);

  owner _giveWeapon(level.tankSettings[self.tankType].laptopInfo);
  owner SwitchToWeaponImmediate(level.tankSettings[self.tankType].laptopInfo);
}

createTank(tankForPlayer) {
  owner = tankForPlayer.owner;
  tankType = tankForPlayer.tankType;
  lifeId = tankForPlayer.lifeId;

  remoteTank = SpawnVehicle(level.tankSettings[tankType].modelBase, tankType, level.tankSettings[tankType].vehicleInfo, tankForPlayer.origin, tankForPlayer.angles, owner);
  if(!isDefined(remoteTank)) {
    return undefined;
  }

  turretAttachTagOrigin = remoteTank GetTagOrigin("tag_turret_attach");

  mgTurret = SpawnTurret("misc_turret", turretAttachTagOrigin, level.tankSettings[tankType].mgTurretInfo, false);
  mgTurret LinkTo(remoteTank, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  mgTurret setModel(level.tankSettings[tankType].modelMGTurret);
  mgTurret.health = level.tankSettings[tankType].health;

  mgTurret.owner = owner;
  mgTurret.angles = owner.angles;
  mgTurret.specialDamageCallback = ::Callback_VehicleDamage;
  mgTurret.tank = remoteTank;
  mgTurret MakeUnusable();
  mgTurret SetDefaultDropPitch(0);
  mgTurret setCanDamage(false);

  remoteTank.specialDamageCallback = ::Callback_VehicleDamage;
  remoteTank.lifeId = lifeId;
  remoteTank.team = owner.team;
  remoteTank.owner = owner;
  remoteTank SetOtherEnt(owner);
  remoteTank.mgTurret = mgTurret;

  remoteTank.health = level.tankSettings[tankType].health;
  remoteTank.maxHealth = level.tankSettings[tankType].maxHealth;
  remoteTank.damageTaken = 0;
  remoteTank.destroyed = false;
  remoteTank setCanDamage(false);
  remoteTank.tankType = tankType;
  remoteTank make_entity_sentient_mp(remoteTank.team);

  mgTurret SetTurretModeChangeWait(true);

  remoteTank tank_setInactive();
  mgTurret SetSentryOwner(owner);

  owner.using_remote_tank = false;

  remoteTank.empGrenaded = false;
  remoteTank.damageFade = DAMAGE_FADE_TIME;
  remoteTank thread tank_incrementDamageFade();
  remoteTank thread tank_watchLowHealth();
  remoteTank thread tank_giveWeaponOnPlaced();

  return remoteTank;
}

tank_setActive() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  self MakeUnusable();
  self.mgTurret MakeTurretSolid();

  self MakeVehicleSolidCapsule(23, 23, 23);

  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;

  headIconOffset = (0, 0, 20);
  if(level.teamBased) {
    self.team = owner.team;
    self.mgTurret.team = owner.team;

    self.mgTurret SetTurretTeam(owner.team);

    foreach(player in level.players) {
      if(player != owner && player.team == owner.team) {
        headIcon = self.mgTurret maps\mp\_entityheadicons::setHeadIcon(player, maps\mp\gametypes\_teams::getTeamHeadIcon(self.team), headIconOffset, 10, 10, false, 0.05, false, true, false, true);
        if(isDefined(headIcon)) {
          headIcon SetTargetEnt(self);
        }
      }
    }
  }

  self thread tank_handleDisconnect();
  self thread tank_handleStopUsing();
  self thread tank_handleChangeTeams();
  self thread tank_handleDeath();
  self thread tank_handleTimeout();
  self thread tank_blinkyLightAntenna();
  self thread tank_blinkyLightCamera();

  self startUsingTank();
}

startUsingTank() {
  owner = self.owner;

  owner setUsingRemote(self.tankType);

  if(is_aliens()) {
    owner VisionSetThermalForPlayer("black_bw", 0);
    owner VisionSetThermalForPlayer(game["thermal_vision"], 1.5);
    owner ThermalVisionOn();
    owner ThermalVisionFOFOverlayOn();

  }
  if(getDvarInt("camera_thirdPerson")) {
    owner setThirdPersonDOF(false);
  }

  owner.restoreAngles = owner.angles;

  owner freezeControlsWrapper(true);
  result = owner maps\mp\killstreaks\_killstreaks::initRideKillstreak("remote_tank");
  if(result != "success") {
    if(result != "disconnect") {
      owner clearUsingRemote();
    }

    if(isDefined(owner.disabledWeapon) && owner.disabledWeapon) {
      owner _enableWeapon();
    }
    self notify("death");

    return false;
  }
  owner freezeControlsWrapper(false);

  self.mgTurret setCanDamage(true);
  self setCanDamage(true);

  data = spawnStruct();
  data.playDeathFx = true;
  data.deathOverrideCallback = ::tank_override_moving_platform_death;
  self thread maps\mp\_movers::handle_moving_platforms(data);

  owner RemoteControlVehicle(self);
  owner RemoteControlTurret(self.mgTurret);

  owner thread tank_WatchFiring(self);

  if(is_aliens()) {
    owner thread tank_DropMines(self);
  } else {
    owner thread tank_FireMissiles(self);
  }

  self thread tank_Earthquake();
  self thread tank_playerExit();

  owner.using_remote_tank = true;

  owner _giveWeapon(level.tankSettings[self.tankType].remoteInfo);
  owner SwitchToWeaponImmediate(level.tankSettings[self.tankType].remoteInfo);

  self thread tank_handleDamage();
  self.mgTurret thread tank_turret_handleDamage();
}

tank_blinkyLightAntenna() {
  self endon("death");

  while(true) {
    playFXOnTag(getfx("remote_tank_antenna_light_mp"), self.mgTurret, "tag_headlight_right");
    wait(1.0);
    stopFXOnTag(getfx("remote_tank_antenna_light_mp"), self.mgTurret, "tag_headlight_right");
  }
}

tank_blinkyLightCamera() {
  self endon("death");

  while(true) {
    playFXOnTag(getfx("remote_tank_camera_light_mp"), self.mgTurret, "tag_tail_light_right");
    wait(2.0);
    stopFXOnTag(getfx("remote_tank_camera_light_mp"), self.mgTurret, "tag_tail_light_right");
  }
}

tank_setInactive() {
  self.mgTurret SetMode(level.tankSettings[self.tankType].sentryModeOff);

  if(level.teamBased) {
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  }
  else if(isDefined(self.owner)) {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;
  if(isDefined(owner.using_remote_tank) && owner.using_remote_tank) {
    owner notify("end_remote");
    if(is_aliens()) {
      owner ThermalVisionOff();
      owner ThermalVisionFOFOverlayOff();
    }

    owner RemoteControlVehicleOff(self);
    owner RemoteControlTurretOff(self.mgTurret);

    owner switchToWeapon(owner getLastWeapon());
    owner clearUsingRemote();
    owner setPlayerAngles(owner.restoreAngles);

    if(getDvarInt("camera_thirdPerson")) {
      owner setThirdPersonDOF(true);
    }
    if(is_aliens()) {
      owner VisionSetThermalForPlayer(game["thermal_vision"], 0);
    }

    if(isDefined(owner.disabledUsability) && owner.disabledUsability) {
      owner _enableUsability();
    }

    owner takeKillstreakWeapons(level.tankSettings[self.tankType].streakName);

    owner.using_remote_tank = false;

    owner thread tank_freezeBuffer();
  }
}

tank_freezeBuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

tank_handleDisconnect() {
  self endon("death");

  self.owner waittill("disconnect");

  if(isDefined(self.mgTurret)) {
    self.mgTurret notify("death");
  }

  self notify("death");
}

tank_handleStopUsing() {
  self endon("death");

  self.owner waittill("stop_using_remote");

  self notify("death");
}

tank_handleChangeTeams() {
  self endon("death");

  self.owner waittill_any("joined_team", "joined_spectators");

  self notify("death");
}

tank_handleTimeout() {
  self endon("death");

  lifeSpan = level.tankSettings[self.tankType].timeOut;

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(lifeSpan);

  self notify("death");
}

tank_override_moving_platform_death(data) {
  self notify("death");
}

tank_handleDeath() {
  level endon("game_ended");

  entNum = self GetEntityNumber();
  self addToUGVList(entNum);

  self waittill("death");

  self playSound("talon_destroyed");

  self removeFromUGVList(entNum);

  self setModel(level.tankSettings[self.tankType].modelDestroyed);

  if(isDefined(self.owner) && (self.owner.using_remote_tank || self.owner isUsingRemote())) {
    self tank_setInactive();

    self.owner.using_remote_tank = false;
  }

  self.mgTurret SetDefaultDropPitch(40);
  self.mgTurret SetSentryOwner(undefined);

  self playSound("sentry_explode");
  playFXOnTag(level._effect["remote_tank_dying"], self.mgTurret, "tag_aim");
  wait(2.0);
  playFX(level._effect["remote_tank_explode"], self.origin);

  self.mgTurret delete();

  decrementFauxVehicleCount();

  self delete();
}

Callback_VehicleDamage(inflictor, attacker, damage, iDFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName) {
  vehicle = self;

  if(isDefined(self.tank)) {
    vehicle = self.tank;
  }

  if(isDefined(vehicle.alreadyDead) && vehicle.alreadyDead) {
    return;
  }
  if(!maps\mp\gametypes\_weapons::friendlyFireCheck(vehicle.owner, attacker)) {
    return;
  }
  if(isDefined(iDFlags) && (iDFlags &level.iDFLAGS_PENETRATION)) {
    vehicle.wasDamagedFromBulletPenetration = true;
  }

  vehicle.wasDamaged = true;

  vehicle.damageFade = 0.0;

  PlayFXOnTagForClients(level._effect["remote_tank_spark"], vehicle, "tag_player", vehicle.owner);

  if(isDefined(weapon)) {
    switch (weapon) {
      case "artillery_mp":
      case "stealth_bomb_mp":
        damage *= 4;
        break;
    }
  }

  if(meansOfDeath == "MOD_MELEE") {
    damage = vehicle.maxHealth * 0.5;
  }

  modifiedDamage = damage;

  if(isPlayer(attacker)) {
    attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("remote_tank");

    if(meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET") {
      if(attacker _hasPerk("specialty_armorpiercing")) {
        modifiedDamage += damage * level.armorPiercingMod;
      }

    }

    if(IsExplosiveDamageMOD(meansOfDeath)) {
      modifiedDamage += damage;
    }
  }

  if(IsExplosiveDamageMOD(meansOfDeath) && (isDefined(weapon) && weapon == "destructible_car")) {
    modifiedDamage = vehicle.maxHealth;
  }

  if(isDefined(attacker.owner) && IsPlayer(attacker.owner)) {
    attacker.owner maps\mp\gametypes\_damagefeedback::updateDamageFeedback("remote_tank");
  }

  if(isDefined(weapon)) {
    switch (weapon) {
      case "ac130_105mm_mp":
      case "ac130_40mm_mp":
      case "stinger_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "remotemissile_projectile_mp":
        vehicle.largeProjectileDamage = true;
        modifiedDamage = vehicle.maxHealth + 1;
        break;

      case "artillery_mp":
      case "stealth_bomb_mp":
        vehicle.largeProjectileDamage = false;
        modifiedDamage = (vehicle.maxHealth * 0.5);
        break;

      case "bomb_site_mp":
        vehicle.largeProjectileDamage = false;
        modifiedDamage = vehicle.maxHealth + 1;
        break;

      case "emp_grenade_mp":

        modifiedDamage = 0;
        vehicle thread tank_EMPGrenaded();
        break;

      case "ims_projectile_mp":
        vehicle.largeProjectileDamage = true;
        modifiedDamage = (vehicle.maxHealth * 0.5);
        break;
    }

    maps\mp\killstreaks\_killstreaks::killstreakHit(attacker, weapon, self);
  }

  vehicle.damageTaken += modifiedDamage;
  vehicle playSound("talon_damaged");

  if(vehicle.damageTaken >= vehicle.maxHealth) {
    if(isPlayer(attacker) && (!isDefined(vehicle.owner) || attacker != vehicle.owner)) {
      vehicle.alreadyDead = true;
      attacker notify("destroyed_killstreak", weapon);
      thread teamPlayerCardSplash("callout_destroyed_remote_tank", attacker);
      attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", 300, weapon, meansOfDeath);
      attacker thread maps\mp\gametypes\_rank::xpEventPopup("destroyed_remote_tank");
      thread maps\mp\gametypes\_missions::vehicleKilled(vehicle.owner, vehicle, undefined, attacker, damage, meansOfDeath, weapon);
    }

    vehicle notify("death");
  }
}

tank_EMPGrenaded() {
  self notify("tank_EMPGrenaded");
  self endon("tank_EMPGrenaded");

  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  self.empGrenaded = true;

  self.mgTurret TurretFireDisable();

  wait(EMP_GRENADE_TIME);

  self.empGrenaded = false;

  self.mgTurret TurretFireEnable();
}

tank_incrementDamageFade() {
  self endon("death");
  level endon("game_ended");

  damaged = false;
  while(true) {
    if(!self.empGrenaded) {
      if(self.damageFade < DAMAGE_FADE_TIME) {
        self.damageFade += 0.1;
        damaged = true;
      } else {
        if(damaged) {
          self.damageFade = 1.0;

          damaged = false;
        }
      }
    }
    wait(0.1);
  }
}

tank_watchLowHealth() {
  self endon("death");
  level endon("game_ended");

  percentage = 0.1;

  damageState = 1;
  firstDamage = true;

  while(true) {
    if(firstDamage) {
      if(self.damageTaken > 0) {
        firstDamage = false;

        damageState++;
      }
    } else {
      if(self.damageTaken >= (self.maxHealth * (percentage * damageState))) {
        damageState++;
      }
    }
    wait(0.05);
  }
}

tank_handleDamage() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(isDefined(self.specialDamageCallback)) {
      self[[self.specialDamageCallback]](undefined, attacker, damage, iDFlags, meansOfDeath, weapon, point, direction_vec, undefined, undefined, modelName, partName);
    }
  }
}

tank_turret_handleDamage() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(isDefined(self.specialDamageCallback) &&
      isDefined(self.tank) &&
      (!IsExplosiveDamageMOD(meansOfDeath) || (isDefined(weapon) && IsExplosiveDamageMOD(meansOfDeath) && (weapon == "stealth_bomb_mp" || weapon == "artillery_mp"))))
      self.tank[[self.specialDamageCallback]](undefined, attacker, damage, iDFlags, meansOfDeath, weapon, point, direction_vec, undefined, undefined, modelName, partName);
  }
}

tank_WatchFiring(remoteTank) {
  self endon("disconnect");
  self endon("end_remote");
  remoteTank endon("death");

  maxBullets = 50;
  numBullets = maxBullets;

  fireTime = WeaponFireTime(level.tankSettings[remoteTank.tankType].mgTurretInfo);
  while(true) {
    if(remoteTank.mgTurret IsFiringVehicleTurret()) {
      numBullets--;

      if(numBullets <= 0) {
        remoteTank.mgTurret TurretFireDisable();

        wait(RELOAD_MG_TIME);

        remoteTank playSound("talon_reload");
        self PlayLocalSound("talon_reload_plr");
        numBullets = maxBullets;

        remoteTank.mgTurret TurretFireEnable();
      }
    }

    wait(fireTime);
  }
}

tank_FireMissiles(remoteTank) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  remoteTank endon("death");

  rocketNum = 0;

  while(true) {
    if(self FragButtonPressed() && !remoteTank.empGrenaded) {
      tagOrigin = remoteTank.mgTurret.origin;
      tagAngles = remoteTank.mgTurret.angles;
      switch (rocketNum) {
        case 0:
          tagOrigin = remoteTank.mgTurret GetTagOrigin("tag_missile1");
          tagAngles = remoteTank.mgTurret GetTagAngles("tag_player");
          break;
        case 1:
          tagOrigin = remoteTank.mgTurret GetTagOrigin("tag_missile2");
          tagAngles = remoteTank.mgTurret GetTagAngles("tag_player");
          break;
      }

      remoteTank playSound("talon_missile_fire");
      self PlayLocalSound("talon_missile_fire_plr");

      destPoint = tagOrigin + (anglesToForward(tagAngles) * 100);
      rocket = MagicBullet(level.tankSettings[remoteTank.tankType].missileInfo, tagOrigin, destPoint, self);

      rocketNum = (rocketNum + 1) % 2;

      wait(RELOAD_MISSILE_TIME);

      remoteTank playSound("talon_rocket_reload");
      self PlayLocalSound("talon_rocket_reload_plr");

    } else
      wait(0.05);
  }
}

tank_DropMines(remoteTank) {
  self endon("disconnect");
  self endon("end_remote");
  level endon("game_ended");
  remoteTank endon("death");

  while(true) {
    if(self SecondaryOffhandButtonPressed()) {
      trace = bulletTrace(remoteTank.origin + (0, 0, 4), remoteTank.origin - (0, 0, 4), false, remoteTank);
      normal = VectorNormalize(trace["normal"]);
      plantAngles = VectorToAngles(normal);
      plantAngles += (90, 0, 0);

      mine = maps\mp\gametypes\_weapons::spawnMine(remoteTank.origin, self, "equipment", plantAngles);

      remoteTank playSound("item_blast_shield_on");

      wait(8.0);

    } else
      wait(0.05);
  }
}

tank_Earthquake() {
  self endon("death");
  self.owner endon("end_remote");

  while(true) {
    Earthquake(0.1, 0.25, self.mgTurret GetTagOrigin("tag_player"), 50);

    wait(0.25);
  }
}

addToUGVList(entNum) {
  level.ugvs[entNum] = self;
}

removeFromUGVList(entNum) {
  level.ugvs[entNum] = undefined;
}

tank_playerExit() {
  if(!isDefined(self.owner)) {
    return;
  }
  owner = self.owner;

  level endon("game_ended");
  owner endon("disconnect");
  owner endon("end_remote");
  self endon("death");

  while(true) {
    timeUsed = 0;
    while(owner UseButtonPressed()) {
      timeUsed += 0.05;
      if(timeUsed > 0.75) {
        self notify("death");
        return;
      }
      wait(0.05);
    }
    wait(0.05);
  }
}