/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_drone_recon.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\killstreaks\_drone_common;

CONST_Movement_hudx = 120;
CONST_Movement_hudy = 400;

CONST_Steer_hudx = 420;
CONST_Steer_hudy = 375;

CONST_Controls_hudx = 25;
CONST_Controls_hudy = 380;

PAINT_DRAW_TIME = .5;

DAMAGE_FADE_TIME = 1.0;

PLACEMENT_RADIUS = 25.0;
PLACEMENT_HEIGHT = 25.0;
PLACEMENT_FORWARD_DISTANCE = 100.0;
PLACEMENT_UP_DISTANCE = 40.0;
PLACEMENT_SWEEP_DISTANCE = 80.0;
PLACEMENT_MIN_NORMAL = 0.7;

SCR_CONST_DEBUG_INFINITE = false;

init() {
  SetDvarIfUninitialized("scr_drone_recon_infinite", 0);

  level._effect["emp_grenade"] = LoadFX("vfx/explosion/emp_grenade_explosion");
  level._effect["antenna_light_mp"] = loadfx("vfx/lights/light_reconugv_antenna");
  level._effect["recon_drone_marker_threat"] = LoadFX("vfx/ui/vfx_marker_drone_recon");
  level._effect["recon_drone_marker_emp"] = LoadFX("vfx/ui/vfx_marker_drone_recon2");
  level._effect["recond_drone_exhaust"] = LoadFX("vfx/vehicle/vehicle_mp_recon_drone_smoke");

  level.UgvMarkedArrays = [];

  thread OnPlayerConnect();

  level.killStreakFuncs["recon_ugv"] = ::tryUseReconDrone;

  level.killstreakWieldWeapons["recon_drone_turret_mp"] = "recon_ugv";
  level.killstreakWieldWeapons["emp_grenade_killstreak_mp"] = "recon_ugv";
  level.killstreakWieldWeapons["paint_grenade_killstreak_mp"] = "recon_ugv";

  game["dialog"]["ks_recdrone_destroyed"] = "ks_recdrone_destroyed";
}

getDroneSpawnPoint() {
  results = droneGetSpawnPoint();

  return results;
}

tryUseReconDrone(lifeId, modules) {
  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + 1 >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_TOO_MANY_VEHICLES");
    return false;
  }

  incrementFauxVehicleCount();

  results = getDroneSpawnPoint();
  if(!results.placementOK) {
    self IPrintLnBold(&"MP_DRONE_PLACEMENT_INVALID");
    decrementFauxVehicleCount();
    return false;
  }

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("recon_ugv");
  if(result != "success") {
    decrementFauxVehicleCount();
    return false;
  }
  self setUsingRemote("recon_ugv");

  droneInstance = self CreateReconUav(lifeId, modules, results.origin, results.angles);

  if(isDefined(droneInstance)) {
    self maps\mp\_matchdata::logKillstreakEvent("recon_ugv", self.origin);
    self thread teamPlayerCardSplash("used_recon_ugv", self);

    return true;
  } else {
    decrementFauxVehicleCount();
    return false;
  }
}

OnPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  self waittill("spawned_player");

  TempMarkArrayStruct = spawnStruct();
  TempMarkArrayStruct.MarkedPlayerArray = [];
  TempMarkArrayStruct.MarkedTurretArray = [];
  TempMarkArrayStruct.owner = self;
  TempMarkArrayStruct.MonitorMarkingThread = false;

  level.UgvMarkedArrays = array_add(level.UgvMarkedArrays, TempMarkArrayStruct);
}

CreateReconUav(lifeId, modules, spawnOrigin, spawnAngles) {
  vehicle = "recon_uav_mp";

  model = "vehicle_atlas_aerial_drone_02_patrol_mp_static_75p";
  ReconUav = spawnHelicopter(self, spawnOrigin, spawnAngles, vehicle, model);
  if(!isDefined(ReconUav)) {
    return undefined;
  }

  self thread playerCommonReconVehicleSetup(ReconUav, modules, lifeId);

  ReconUav.maxHealth = 250;
  ReconUav.vehicleType = "drone_recon";
  ReconUav.VehName = "recon_uav";
  ReconUav.MarkDistance = 1500;

  if(ReconUav.hasIncreasedTime) {
    lifeSpan = 30.0 + 15.0;
  } else {
    lifeSpan = 30.0;
  }
  ReconUav.lifeSpan = lifeSpan;
  ReconUav.endTime = GetTime() + lifespan * 1000;

  ReconUav thread maps\mp\gametypes\_damage::setEntityDamageCallback(ReconUav.maxHealth, undefined, ::onReconDroneDeath, maps\mp\killstreaks\_aerial_utility::heli_ModifyDamage, true);

  if(ReconUav.hasCloak) {
    self thread droneCloakReady(ReconUav, ReconUav.hasCloak);
  }

  self StartUsingReconVehicle(ReconUav);

  self thread MonitorUavSafeArea(ReconUav);
  self thread MonitorPlayerDisconnect(ReconUav);
  self thread MonitorPlayerSwitchTeams(ReconUav);
  self thread MonitorPlayerGameEnded(ReconUav);
  self thread ReconHandleTimeoutWarning(ReconUav);
  self thread ReconHandleTimeout(ReconUav);
  self thread ReconHandleDeath(ReconUav);
  self thread ReconHudSetup(ReconUav);
  self thread playerWatchForDroneEMP(ReconUav);

  data = spawnStruct();
  data.validateAccurateTouching = true;
  data.deathOverrideCallback = ::override_drone_platform_death;
  ReconUav thread maps\mp\_movers::handle_moving_platforms(data);

  ReconUav.getStingerTargetPosFunc = ::reconuav_stinger_target_pos;

  return ReconUav;
}

reconuav_stinger_target_pos() {
  return self GetTagOrigin("tag_origin");
}

override_drone_platform_death(data) {
  self notify("death");
}

setupPlayerCommands(modules) {
  if(IsBot(self)) {
    return;
  }

  self NotifyOnPlayerCommand("recon_fire_main", "+attack");
  self NotifyOnPlayerCommand("recon_fire_main", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommand("recon_fire_secondary", "+speed_throw");
  self NotifyOnPlayerCommand("recon_fire_secondary", "+toggleads_throw");
  self NotifyOnPlayerCommand("recon_fire_secondary", "+ads_akimbo_accessible");

  if(array_contains(modules, "recon_ugv_cloak")) {
    self NotifyOnPlayerCommand("Cloak", "+activate");
    self NotifyOnPlayerCommand("Cloak", "+usereload");
  }
}

disablePlayercommands(drone) {
  if(IsBot(self)) {
    return;
  }

  self NotifyOnPlayerCommandRemove("recon_fire_main", "+attack");
  self NotifyOnPlayerCommandRemove("recon_fire_main", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommandRemove("recon_fire_secondary", "+speed_throw");
  self NotifyOnPlayerCommandRemove("recon_fire_secondary", "+toggleads_throw");
  self NotifyOnPlayerCommandRemove("recon_fire_secondary", "+ads_akimbo_accessible");
  if(isDefined(drone) && drone.hasCloak) {
    self NotifyOnPlayerCommandRemove("Cloak", "+activate");
    self NotifyOnPlayerCommandRemove("Cloak", "+usereload");
  }
}

playerCommonReconVehicleSetup(vehicle, modules, lifeId) {
  self endon("reconStreakComplete");
  vehicle endon("death");

  self.using_remote_tank = false;

  vehicle.lifeId = lifeId;
  vehicle.team = self.team;
  vehicle.owner = self;
  vehicle.damageTaken = 0;
  vehicle.destroyed = false;
  vehicle.empGrenaded = false;
  vehicle.damageFade = DAMAGE_FADE_TIME;
  vehicle.markedPlayers = [];

  vehicle.modules = modules;
  vehicle.hasARHud = array_contains(vehicle.modules, "recon_ugv_ar_hud");
  vehicle.hasPaintGrenade = true;
  vehicle.hasAssistPoints = array_contains(vehicle.modules, "recon_ugv_assist_points");
  vehicle.hasStun = array_contains(vehicle.modules, "recon_ugv_stun");
  vehicle.hasIncreasedTime = array_contains(vehicle.modules, "recon_ugv_increased_time");
  vehicle.hasCloak = array_contains(vehicle.modules, "recon_ugv_cloak");
  vehicle.hasEMPGrenade = array_contains(vehicle.modules, "recon_ugv_emp");

  vehicle Hide();
  vehicle MakeUnusable();
  vehicle MakeVehicleSolidCapsule(23, -9, 23);
  vehicle setCanDamage(true);
  vehicle make_entity_sentient_mp(vehicle.team);

  reconSpawnTurret(vehicle);

  self thread droneSetupCloaking(vehicle, vehicle.hasCloak);

  wait(1.6);

  self setupPlayerCommands(modules);

  self thread notify_recon_drone_on_player_command(vehicle);

  groundMarkerEffectRef = "recon_drone_marker_threat";
  if(vehicle.hasEMPGrenade) {
    groundMarkerEffectRef = "recon_drone_marker_emp";
  }
  self thread updateShootingLocation(vehicle, getfx(groundMarkerEffectRef), true);
  self thread playerHandleExhaustFx(vehicle, "recond_drone_exhaust", "tag_exhaust");

  vehicle.mgTurret SetTargetEntity(vehicle.targetEnt);

  self thread ReconPlayerExit(vehicle);
}

reconSpawnTurret(vehicle) {
  turretWeapon = "recon_drone_turret_mp";
  turretLinkTag = "tag_turret";
  turretModelName = "vehicle_atlas_aerial_drone_02_patrol_mp_turret_75p";

  mgTurret = SpawnTurret("misc_turret", vehicle GetTagOrigin(turretLinkTag), turretWeapon, false);
  mgTurret.angles = vehicle GetTagAngles(turretLinkTag);
  mgTurret setModel(turretModelName);
  mgTurret SetDefaultDropPitch(45.0);
  mgTurret LinkTo(vehicle, turretLinkTag, (0, 0, 0), (0, 0, 0));
  mgTurret.owner = vehicle.owner;
  mgTurret.health = 99999;
  mgTurret.maxHealth = 1000;
  mgTurret.damageTaken = 0;
  mgTurret.stunned = false;
  mgTurret.stunnedTime = 0.0;
  mgTurret setCanDamage(false);
  mgTurret setCanRadiusDamage(false);
  mgTurret MakeUnusable();
  mgTurret.team = vehicle.team;
  mgTurret.pers["team"] = vehicle.team;
  if(level.teamBased) {
    mgTurret SetTurretTeam(vehicle.team);
  }
  mgTurret SetMode("sentry_manual");
  mgTurret SetSentryOwner(vehicle.owner);
  mgTurret SetTurretMinimapVisible(false);
  mgTurret.chopper = vehicle;
  mgTurret SetContents(0);

  mgTurret.fireSoundEnt = spawn("script_model", vehicle GetTagOrigin(turretLinkTag));
  mgTurret.fireSoundEnt setModel("tag_origin");
  mgTurret.fireSoundEnt LinkToSynchronizedParent(vehicle, turretLinkTag, (0, 0, 0), (0, 0, 0));
  mgTurret.fireSoundEnt SetContents(0);

  mgTurret Hide();

  vehicle.mgTurret = mgTurret;

  if(vehicle.hasPaintGrenade) {
    thread fireThreatGrenades(vehicle);
  }
  if(vehicle.hasEMPGrenade) {
    thread fireEmpGrenades(vehicle);
  }
}

fireThreatGrenades(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  nextFlashTime = GetTime();
  shouldFlash = false;

  while(true) {
    self waittill("recon_fire_main");

    self notify("ForceUncloak");

    startPos = vehicle.mgTurret GetTagOrigin("tag_aim");
    targetPos = vehicle.targetEnt.origin;

    if(vehicle.hasStun && GetTime() >= nextFlashTime) {
      nextFlashTime = GetTime() + 6000;
      shouldFlash = true;
    }

    self maps\mp\killstreaks\_aerial_utility::playerFakeShootPaintGrenadeAtTarget(vehicle.mgTurret.fireSoundEnt, startPos, targetPos, shouldFlash, vehicle);

    self SetClientOmnvar("ui_recondrone_paint", 2);

    wait 2;

    self SetClientOmnvar("ui_recondrone_paint", 1);

    shouldFlash = false;
  }
}

fireEMPGrenades(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("recon_fire_secondary");

    self notify("ForceUncloak");

    startPos = vehicle.mgTurret GetTagOrigin("tag_aim");
    targetPos = vehicle.targetEnt.origin;

    self maps\mp\killstreaks\_aerial_utility::playerFakeShootEmpGrenadeAtTarget(vehicle.mgTurret.fireSoundEnt, startPos, targetPos);

    self SetClientOmnvar("ui_recondrone_emp", 2);

    wait 5;

    self SetClientOmnvar("ui_recondrone_emp", 1);
  }
}

notify_recon_drone_on_player_command(vehicle) {
  self endon("disconnect");
  vehicle endon("death");

  while(1) {
    result = self waittill_any_return("recon_fire_main", "recon_fire_secondary", "Cloak");
    if(isDefined(result)) {
      vehicle notify(result);
    }
  }
}

StartUsingReconVehicle(ReconVeh) {
  owner = self;

  if(getDvarInt("camera_thirdPerson")) {
    owner setThirdPersonDOF(false);
  }

  owner playerSaveAngles();

  owner CameraLinkTo(ReconVeh, "tag_origin");
  owner RemoteControlVehicle(ReconVeh);

  owner thread setDroneVisionAndLightSetPerMap(1.5, ReconVeh);

  owner.using_remote_tank = true;

  if(owner isJuggernaut()) {
    owner.juggernautOverlay.alpha = 0;
  }
}

ReconHudSetup(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  ReconHudRemove(vehicle);

  wait 0.5;

  self SetClientOmnvar("ui_recondrone_toggle", true);

  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();

  self SetClientOmnvar("ui_recondrone_countdown", vehicle.endTime);
  if(SCR_CONST_DEBUG_INFINITE || GetDvarInt("scr_drone_recon_infinite", 0)) {
    self SetClientOmnvar("ui_recondrone_countdown", 0);
  }

  if(vehicle.hasCloak) {
    self SetClientOmnvar("ui_drone_cloak", 2);
  }

  if(vehicle.hasPaintGrenade) {
    self SetClientOmnvar("ui_recondrone_paint", 1);
  }

  if(vehicle.hasEMPGrenade) {
    self SetClientOmnvar("ui_recondrone_emp", 1);
  }

  if(vehicle.hasARHud) {
    self ThermalVisionFOFOverlayOn();
  }
}

ReconHudRemove(vehicle) {
  self SetClientOmnvar("ui_recondrone_toggle", false);
  self SetClientOmnvar("ui_recondrone_countdown", 0);
  self SetClientOmnvar("ui_drone_cloak", 0);
  self SetClientOmnvar("ui_drone_cloak_time", 0);
  self SetClientOmnvar("ui_drone_cloak_cooldown", 0);
  self SetClientOmnvar("ui_recondrone_paint", 0);
  self SetClientOmnvar("ui_recondrone_emp", 0);
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();
}

MonitorUavSafeArea(vehicle) {
  self endon("reconStreakComplete");

  self thread maps\mp\killstreaks\_aerial_utility::playerHandleBoundaryStatic(vehicle, "reconStreakComplete");
  self thread maps\mp\killstreaks\_aerial_utility::playerHandleKillVehicle(vehicle, "reconStreakComplete");

  vehicle waittill("outOfBounds");

  wait 2;

  vehicle notify("death");
}

MonitorPlayerDisconnect(vehicle) {
  self endon("StopWaitForDisconnect");
  vehicle endon("death");

  self waittill("disconnect");

  vehicle notify("death");
}

MonitorPlayerSwitchTeams(vehicle) {
  self endon("reconStreakComplete");

  self waittill_any("joined_team", "joined_spectators");

  vehicle notify("death");
}

MonitorPlayerGameEnded(vehicle) {
  self endon("reconStreakComplete");

  level waittill("game_ended");

  vehicle notify("death");
}

onReconDroneDeath(attacker, weapon, meansOfDeath, damage) {
  self notify("death", attacker, meansOfDeath, weapon);

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "recon_drone_destroyed", undefined, "callout_destroyed_drone_recon", true);
}

ReconHandleTimeoutWarning(ReconVeh) {
  ReconVeh endon("death");

  if(SCR_CONST_DEBUG_INFINITE || GetDvarInt("scr_drone_recon_infinite", 0)) {
    return;
  }

  timeout_warning_length = 10.0;
  warn_interval = 1.0;

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(ReconVeh.lifeSpan - timeout_warning_length);

  while(timeout_warning_length > 0) {
    ReconVeh playSound("mp_warbird_outofbounds_warning");
    timeout_warning_length -= warn_interval;

    wait(warn_interval);
  }

  ReconVeh notify("death");
}

ReconHandleTimeout(ReconVeh) {
  ReconVeh endon("death");

  if(SCR_CONST_DEBUG_INFINITE || GetDvarInt("scr_drone_recon_infinite", 0)) {
    return;
  }

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(ReconVeh.lifeSpan);

  ReconVeh notify("death");
}

ReconHandleDeath(vehicle) {
  entNum = vehicle GetEntityNumber();

  vehicle droneAddToGlobalList(entNum);

  vehicle waittill("death", attacker);

  if(isDefined(vehicle)) {
    vehicle Ghost();
  }

  if(isDefined(vehicle.mgTurret)) {
    vehicle.mgTurret Ghost();
  }

  if(isDefined(self)) {
    freezeControlsWrapper(true);
  }

  self notify("reconStreakComplete");
  self notify("StopWaitForDisconnect");

  vehicle playSound("assault_drn_death");

  vehicle droneRemoveFromGlobalList(entNum);

  waitframe();

  playFXOnTag(level._effect["remote_tank_explode"], vehicle, "tag_origin");

  wait 1;
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(isDefined(self) && !level.gameEnded) {
    freezeControlsWrapper(false);
  }

  if(isDefined(self) && isDefined(attacker) && self != attacker) {
    self thread leaderDialogOnPlayer("ks_recdrone_destroyed", undefined, undefined, self.origin);
  }

  if(isDefined(self) && (self.using_remote_tank || self isUsingRemote())) {
    self ReconSetInactivity(vehicle);
    self.using_remote_tank = false;
    if(self isJuggernaut()) {
      self.juggernautOverlay.alpha = 1;
    }
  }

  decrementFauxVehicleCount();

  if(isDefined(vehicle.mgTurret)) {
    if(isDefined(vehicle.mgTurret.fireSoundEnt)) {
      vehicle.mgTurret.fireSoundEnt Delete();
    }
    vehicle.mgTurret Delete();
  }

  if(isDefined(vehicle.thing)) {
    vehicle.thing Delete();
  }

  vehicle delete();
}

ReconSetInactivity(ReconVeh) {
  if(!isDefined(ReconVeh)) {
    return;
  }

  owner = self;

  if(isDefined(owner.using_remote_tank) && owner.using_remote_tank) {
    owner notify("end_remote");

    owner RemoteControlVehicleOff(ReconVeh);
    owner ThermalVisionFOFOverlayOff();
    self thread removeDroneVisionAndLightSetPerMap(1.5);

    owner ReconHudRemove(ReconVeh);

    owner disablePlayercommands(ReconVeh);

    if(owner isUsingRemote() && !level.gameEnded) {
      owner clearUsingRemote();
    }

    killstreakWeapon = getKillstreakWeapon("recon_ugv");
    owner TakeWeapon(killstreakWeapon);

    owner EnableWeaponSwitch();
    owner SwitchToWeapon(self getLastWeapon());
    owner playerRestoreAngles();

    if(getDvarInt("camera_thirdPerson")) {
      owner setThirdPersonDOF(true);
    }

    if(isDefined(owner.disabledUsability) && owner.disabledUsability) {
      owner _enableUsability();
    }

    owner.using_remote_tank = false;
  }
}

ReconPlayerExit(vehicle) {
  if(!isDefined(self)) {
    return;
  }

  owner = self;

  level endon("game_ended");
  owner endon("disconnect");
  vehicle endon("death");

  while(true) {
    timeUsed = 0;
    while(owner useButtonPressed()) {
      timeUsed += 0.05;
      if(timeUsed > 0.75) {
        vehicle notify("death");
        return;
      }
      wait(0.05);
    }
    wait(0.05);
  }
}