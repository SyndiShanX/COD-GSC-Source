/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_drone_assault.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\killstreaks\_assaultdrone_ai;
#include maps\mp\killstreaks\_drone_common;

PAINT_DRAW_TIME = .5;

DAMAGE_FADE_TIME = 1.0;

CONST_Rocket_AmmoMax = 3;
CONST_Rocket_Shot_Interval = 1;
CONST_Rocket_Reload_Interval = 5;

CONST_C4_EXPLODE_DIST = 200;

SCR_CONST_DEBUG_ENABLE_AI = false;
SCR_CONST_DEBUG_ENABLE_MG = false;
SCR_CONST_DEBUG_ENABLE_ROCKETS = false;
SCR_CONST_DEBUG_ENABLE_HARDENED = false;
SCR_CONST_DEBUG_ENABLE_AR_HUD = false;
SCR_CONST_DEBUG_ENABLE_CLOAK = false;
SCR_CONST_DEBUG_INFINITE = false;

init() {
  SetDvarIfUninitialized("scr_drone_assault_infinite", 0);

  level._effect["assault_c4_explode"] = LoadFX("vfx/vehicle/vehicle_assault_drone_rocket");
  level._effect["remote_tank_explode"] = LoadFX("vfx/explosion/vehicle_assault_drone_death");
  level._effect["c4_forward_blur"] = LoadFX("vfx/unique/forward_view_radial_blur");
  level._effect["assault_drone_exhaust"] = LoadFX("vfx/vehicle/vehicle_mp_assault_drone_exhaust");
  level._effect["assault_drone_thruster"] = LoadFX("vfx/vehicle/vehicle_mp_assault_drone_thruster");
  level._effect["assault_drone_marker"] = LoadFX("vfx/ui/vfx_marker_drone_assault");
  level._effect["assault_drone_exhaust_bottom"] = LoadFX("vfx/vehicle/vehicle_mp_assault_drone_exhaust");

  level.killStreakFuncs["assault_ugv"] = ::tryUseAssaultDrone;

  level.killstreakWieldWeapons["drone_assault_remote_turret_mp"] = "assault_ugv";
  level.killstreakWieldWeapons["ugv_missile_mp"] = "assault_ugv";
  level.killstreakWieldWeapons["assaultdrone_c4_mp"] = "assault_ugv";
  level.killstreakWieldWeapons["killstreak_terrace_mp"] = "mp_terrace";

  thread assault_vehicle_ai_init();

  game["dialog"]["ks_adrone_destroyed"] = "ks_adrone_destroyed";
}

getDroneSpawnPoint(modules) {
  spawnOrigin = undefined;
  spawnAngles = undefined;
  placementOK = undefined;

  results = spawnStruct();
  results.placementOK = true;

  if(array_contains(modules, "mp_terrace")) {
    orbit_initial_ent = GetEnt("killstreak_orbit_initial", "targetname");
    orbit_lookat_ent = GetEnt("killstreak_orbit_lookat", "targetname");
    if(isDefined(orbit_initial_ent) && isDefined(orbit_lookat_ent)) {
      results.origin = orbit_initial_ent.origin;
      results.angles = VectorToAngles(orbit_lookat_ent.origin - orbit_initial_ent.origin);
    } else {
      spawn_loc = GetStruct("mp_terrace_killstreak_start", "targetname");
      results.origin = spawn_loc.origin;
      results.angles = spawn_loc.angles;
    }
  } else {
    results = droneGetSpawnPoint();
  }

  return results;
}

tryUseAssaultDrone(lifeId, modules) {
  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(self.aerialDrone))
  }
  self.aerialDrone notify("death");

  numIncomingVehicles = 1;

  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || ((level.fauxVehicleCount + numIncomingVehicles) >= maxVehiclesAllowed())) {
    self IPrintLnBold(&"MP_TOO_MANY_VEHICLES");
    return false;
  }

  incrementFauxVehicleCount();

  results = getDroneSpawnPoint(modules);
  if(!results.placementOK) {
    self IPrintLnBold(&"MP_DRONE_PLACEMENT_INVALID");
    decrementFauxVehicleCount();
    return false;
  }

  hasAIOption = array_contains(modules, "assault_ugv_ai");
  /#	
  hasAIOption = hasAIOption || SCR_CONST_DEBUG_ENABLE_AI;

  if(!hasAIOption) {
    result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("assault_ugv");
    if(result != "success") {
      decrementFauxVehicleCount();
      return false;
    }
    self setUsingRemote("assault_ugv");
  }

  droneInstance = self CreateAssaultUav(lifeId, modules, results.origin, results.angles);

  if(isDefined(droneInstance)) {
    if(array_contains(modules, "mp_terrace")) {
      self maps\mp\_matchdata::logKillstreakEvent("mp_terrace", self.origin);
      self thread teamPlayerCardSplash("used_mp_terrace", self);
    } else {
      self maps\mp\_matchdata::logKillstreakEvent("assault_ugv", self.origin);
      self thread teamPlayerCardSplash("used_assault_ugv", self);
    }

    if(isDefined(level.isHorde) && level.isHorde) {
      self.aerialDrone = droneInstance;
    }

    return true;
  } else {
    return false;
  }
}

CreateAssaultUav(lifeId, modules, spawnOrigin, spawnAngles) {
  hasTurret = array_contains(modules, "assault_ugv_mg") || array_contains(modules, "assault_ugv_rockets") || array_contains(modules, "mp_terrace");
  /#	
  hasTurret = hasTurret || SCR_CONST_DEBUG_ENABLE_MG || SCR_CONST_DEBUG_ENABLE_ROCKETS;

  mp_terrace = array_contains(modules, "mp_terrace");

  vehType = "assault_uav_mp";
  lifespan = 30;

  if(hasTurret) {
    vehType = "mg_assault_uav_mp";
    lifespan = 45;
  }

  if(GetDvar("scr_assault_drone_time", "0") != "0") {
    lifespan = GetDvarFloat("scr_assault_drone_time");
  }

  modelType = "vehicle_atlas_aerial_drone_01_assult_mp_noturret_clr_50p";
  if(!hasTurret) {
    modelType = "vehicle_atlas_aerial_drone_01_patrol_mp_static_clr_01_50p";
  }

  if(mp_terrace) {
    vehType = "assault_uav_mp_terrace";

    modelType = "vehicle_sniper_drone_cloak_mp";
    lifespan = 30;
  }

  vehicle = spawnHelicopter(self, spawnOrigin, spawnAngles, vehType, modelType);
  if(!isDefined(vehicle)) {
    return;
  }

  thread SetupCommonAssaultDroneProperties(vehicle, lifeId, lifespan, modules);

  vehicle.getStingerTargetPosFunc = ::assault_drone_stinger_target_pos;

  return vehicle;
}

assault_drone_stinger_target_pos() {
  return self GetTagOrigin("tag_origin");
}

setupPlayerCommands(drone) {
  if(IsBot(self)) {
    return;
  }

  if(isDefined(drone) && drone.hasAIOption) {
    return;
  }

  self NotifyOnPlayerCommand("FirePrimaryWeapon", "+attack");
  self NotifyOnPlayerCommand("FirePrimaryWeapon", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommand("FireSecondaryWeapon", "+speed_throw");
  self NotifyOnPlayerCommand("FireSecondaryWeapon", "+toggleads_throw");
  self NotifyOnPlayerCommand("FireSecondaryWeapon", "+ads_akimbo_accessible");

  if(isDefined(drone) && drone.hasCloak) {
    self NotifyOnPlayerCommand("Cloak", "+usereload");
    self NotifyOnPlayerCommand("Cloak", "+activate");
  }
}

disablePlayercommands(drone) {
  if(IsBot(self)) {
    return;
  }

  if(isDefined(drone) && drone.hasAIOption) {
    return;
  }

  self NotifyOnPlayerCommandRemove("FirePrimaryWeapon", "+attack");
  self NotifyOnPlayerCommandRemove("FirePrimaryWeapon", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommandRemove("FireSecondaryWeapon", "+speed_throw");
  self NotifyOnPlayerCommandRemove("FireSecondaryWeapon", "+toggleads_throw");
  self NotifyOnPlayerCommandRemove("FireSecondaryWeapon", "+ads_akimbo_accessible");
  if(isDefined(drone) && drone.hasCloak) {
    self NotifyOnPlayerCommandRemove("Cloak", "+usereload");
    self NotifyOnPlayerCommandRemove("Cloak", "+activate");
  }
}

SetupCommonAssaultDroneProperties(vehicle, lifeId, lifespan, modules) {
  vehicle MakeUnusable();
  vehicle MakeVehicleSolidCapsule(23, 23, 23);

  vehicle.lifeId = lifeId;
  vehicle.team = self.team;
  vehicle.owner = self;
  vehicle.maxHealth = 250;
  vehicle.destroyed = false;
  vehicle.vehicleType = "drone_assault";

  vehicle make_entity_sentient_mp(self.team);

  vehicle.modules = modules;
  vehicle.mp_terrace = array_contains(modules, "mp_terrace");

  vehicle.hardened = array_contains(modules, "assault_ugv_hardened");
  /#	
  vehicle.hardened = vehicle.hardened || SCR_CONST_DEBUG_ENABLE_HARDENED;

  vehicle.hasMG = array_contains(modules, "assault_ugv_mg") || vehicle.mp_terrace;
  /#	
  vehicle.hasMG = vehicle.hasMG || SCR_CONST_DEBUG_ENABLE_MG;

  vehicle.hasRockets = array_contains(modules, "assault_ugv_rockets");
  /#	
  vehicle.hasRockets = vehicle.hasRockets || SCR_CONST_DEBUG_ENABLE_ROCKETS;

  vehicle.hasCloak = array_contains(modules, "assault_ugv_cloak");
  /#	
  vehicle.hasCloak = vehicle.hasCloak || SCR_CONST_DEBUG_ENABLE_CLOAK;

  vehicle.hasAIOption = array_contains(modules, "assault_ugv_ai");
  /#	
  vehicle.hasAIOption = vehicle.hasAIOption || SCR_CONST_DEBUG_ENABLE_AI;

  vehicle.hasARHud = array_contains(modules, "assault_ugv_ar_hud") || vehicle.mp_terrace;
  /#	
  vehicle.hasARHud = vehicle.hasARHud || SCR_CONST_DEBUG_ENABLE_AR_HUD;

  vehicle.hasTurret = (vehicle.hasMG || vehicle.hasRockets);
  vehicle.endTime = GetTime() + lifespan * 1000;

  if(vehicle.hardened) {
    vehicle.maxHealth = Int(vehicle.maxHealth * 1.3);
  }

  if(!vehicle.hasAIOption) {
    self setupPlayerCommands(vehicle);
    self thread notify_assault_drone_on_player_command(vehicle);
  }

  vehicle setCanDamage(true);
  vehicle.empGrenaded = false;
  vehicle.damageFade = DAMAGE_FADE_TIME;

  vehicle thread maps\mp\gametypes\_damage::setEntityDamageCallback(vehicle.maxHealth, undefined, ::onAssaultDroneDeath, maps\mp\killstreaks\_aerial_utility::heli_ModifyDamage, true);

  vehicle Ghost();
  self thread droneSetupCloaking(vehicle, vehicle.hasCloak);
  if(vehicle.hasCloak) {
    self thread droneCloakReady(vehicle, vehicle.hasCloak);
  }

  self.using_remote_tank = !vehicle.hasAIOption;
  self.hasAIAssaultDrone = vehicle.hasAIOption;

  if(!vehicle.hasAIOption) {
    self PlayerStartUsingAssaultVehicle(vehicle);
    self thread AssaultHudSetup(vehicle);
    self thread MonitorUavSafeArea(vehicle);
  } else {
    self thread AIStartUsingAssaultVehicle(vehicle);
  }

  self thread MonitorPlayerDisconnect(vehicle);
  self thread AssaultHandleDeath(vehicle);
  self thread MonitorPlayerSwitchTeams(vehicle);
  self thread MonitorPlayerGameEnded(vehicle);
  self thread playerWatchForDroneEMP(vehicle);

  if(vehicle.mp_terrace) {
    orbit_ent = GetEnt("killstreak_orbit_origin", "targetname");
    orbit_initial = GetEnt("killstreak_orbit_initial", "targetname");
    orbit_lookat = GetEnt("killstreak_orbit_lookat", "targetname");

    if(isDefined(orbit_ent) && isDefined(orbit_initial) && isDefined(orbit_lookat)) {
      vehicle SetOrbiterEnts(self, orbit_ent, orbit_initial, orbit_lookat);
    }
  }

  if(!vehicle.mp_terrace) {
    self thread playerHandleExhaustFx(vehicle, "assault_drone_exhaust", "TAG_EXHAUST_REAR", "assaultDroneHunterKiller");
    self thread playerHandleExhaustFx(vehicle, "assault_drone_exhaust_bottom", "tag_exhaust_lt");
    self thread playerHandleExhaustFx(vehicle, "assault_drone_exhaust_bottom", "tag_exhaust_rt");
  }

  if(!isDefined(level.isHorde) || (isDefined(level.isHorde) && self GetClientOmnvar("ui_horde_player_class") != "drone")) {
    self thread AssaultHandleTimeoutWarning(vehicle, lifespan);
  }
  self AssaultVehicleMonitorWeapons(vehicle);

  self thread updateShootingLocation(vehicle, getfx("assault_drone_marker"));

  self thread debug_Show_origin(vehicle);

  data = spawnStruct();
  data.validateAccurateTouching = true;
  data.deathOverrideCallback = ::override_drone_platform_death;
  vehicle thread maps\mp\_movers::handle_moving_platforms(data);

  return vehicle;
}

override_drone_platform_death(data) {
  self notify("death");
}

debug_show_origin(vehicle) {}

notify_assault_drone_on_player_command(vehicle) {
  self endon("disconnect");
  vehicle endon("death");

  while(1) {
    result = self waittill_any_return("FirePrimaryWeapon", "FireSecondaryWeapon", "Cloak");
    if(isDefined(result)) {
      vehicle notify(result);
    }
  }
}

PlayerStartUsingAssaultVehicle(vehicle) {
  owner = self;

  if(getDvarInt("camera_thirdPerson")) {
    owner setThirdPersonDOF(false);
  }

  owner playerSaveAngles();

  if(!vehicle.mp_terrace) {
    owner CameraLinkTo(vehicle, "tag_origin");
  }

  owner RemoteControlVehicle(vehicle);

  owner thread setDroneVisionAndLightSetPerMap(1.5, vehicle);

  owner.using_remote_tank = true;

  return true;
}

AssaultVehicleMonitorWeapons(vehicle) {
  if(vehicle.hasTurret) {
    self thread SpawnMgTurret(vehicle);
  } else {
    self thread WaitForC4Detonation(vehicle);
  }

  if(vehicle.hasRockets) {
    self thread SetupRockets(vehicle);
  }

  self thread AssaultPlayerExit(vehicle);
}

GetAssaultVehicleC4Radius() {
  return CONST_C4_EXPLODE_DIST;
}

WaitForC4Detonation(vehicle) {
  level endon("game_ended");
  vehicle endon("death");

  if(!vehicle.hasAIOption) {
    self thread playerHudOutlinesHunterKiller(vehicle);
  }

  wait 2;

  vehicle waittill("FirePrimaryWeapon");

  self notify("ForceUncloak");

  self playerDoHunterKillerBehavior(vehicle);

  vehicle RadiusDamage(vehicle.origin + (0, 0, 50), GetAssaultVehicleC4Radius(), 200, 200, self, "MOD_EXPLOSIVE", "AssaultDrone_C4_mp");
  playFX(getfx("assault_c4_explode"), vehicle.origin);

  vehicle notify("death");
}

playerHudOutlinesHunterKiller(vehicle) {
  foreach(player in level.players) {
    if(self.team != player.team && !player _hasPerk("specialty_blindeye")) {
      player HudOutlineEnableForClient(self, 0, true);
    }
  }

  vehicle waittill("death");

  if(!isDefined(self)) {
    return;
  }

  foreach(player in level.players) {
    if(self.team != player.team) {
      player HudOutlineDisableForClient(self);
    }
  }
}

onPlayerConnectHunterKiller(vehicle) {
  vehicle endon("death");

  while(true) {
    level waittill("connected", player);

    if(!isDefined(self)) {
      return;
    }

    if(self.team != player.team) {
      player thread onPlayerSpawnedHunterKiller();
    }
  }
}

onPlayerSpawnedHunterKiller(vehicleOwner) {
  self endon("disconnect");

  self waittill("spawned_player");

  if(isDefined(vehicleOwner)) {
    self HudOutlineEnableForClient(vehicleOwner, 0, true);
  }
}

playerDoHunterKillerBehavior(vehicle) {
  MAX_TIME_TO_EXPLODE = 7000;
  DIST_TO_CAM_UNLINK_SQ = 150 * 150;
  DIST_TO_EXPLODE_SQ = 60 * 60;

  self notify("assaultDroneHunterKiller");
  vehicle.hunterKiller = true;

  if(vehicle.hasAIOption) {
    start = vehicle.origin;
  } else {
    start = self GetViewOrigin(true);
  }
  end = vehicle.targetEnt.origin;
  dir = VectorNormalize(end - start);
  end = start + (dir * 20000);
  trace = bulletTrace(start, end, false, vehicle, false, false, true, false, false);

  goal = trace["position"];
  distSq = DistanceSquared(vehicle.origin, goal);
  if(distSq > DIST_TO_EXPLODE_SQ) {
    fxEnt = undefined;
    if(vehicle.hasAIOption) {
      pos = vehicle.origin;
      ang = vehicle.angles;
    } else {
      pos = self GetViewOrigin(true);
      ang = self GetPlayerAngles();
      vehicle.camLinkEnt = spawn("script_model", pos);
      vehicle.camLinkEnt setModel("tag_player");
      vehicle.camLinkEnt.angles = ang;
      vehicle.camLinkEnt LinkTo(vehicle, "tag_origin");
      waitframe();
      self PlayerLinkWeaponViewToDelta(vehicle.camLinkEnt, "tag_player", 1, 0, 0, 0, 0, true);
      self PlayerLinkedSetViewZnear(false);
      self RemoteControlVehicleOff();
      Earthquake(0.2, 1, pos, 100);
      fxEnt = SpawnFXForClient(getfx("c4_forward_blur"), pos, self);
      TriggerFX(fxEnt);
    }
    stopFXOnTag(getfx("assault_drone_exhaust"), vehicle, "TAG_EXHAUST_REAR");
    vehicle notify("stopShootLocationUpdate");
    vehicle SetOtherEnt(undefined);
    vehicle Vehicle_Teleport(vehicle.origin, vehicle.angles, false, false);
    waitframe();
    self thread playerPlayTargetFX(vehicle, goal);
    self thread playerPlayThrusterSound(vehicle);
    endTime = GetTime() + MAX_TIME_TO_EXPLODE;
    speed = 120;
    accel = speed * 4 / 5;
    vehicle Vehicle_SetSpeed(speed, accel);
    vehicle SetVehGoalPos(goal, false);
    vehicle.staticLevelWaitTime = 0.3;
    vehicle.alwaysStaticOut = true;
    vehicle SetContents(0);

    waitframe();
    playFXOnTag(getfx("assault_drone_thruster"), vehicle, "TAG_EXHAUST_REAR");
    distSq = DistanceSquared(vehicle.origin, goal);
    while(GetTime() < endTime && distSq > DIST_TO_CAM_UNLINK_SQ) {
      waitframe();
      distSq = DistanceSquared(vehicle.origin, goal);
      GlassRadiusDamage(vehicle.origin, 70, 200, 200);
    }
    if(!vehicle.hasAIOption) {
      vehicle.camLinkEnt Unlink();
    }
    while(GetTime() < endTime && distSq > DIST_TO_EXPLODE_SQ) {
      waitframe();
      distSq = DistanceSquared(vehicle.origin, goal);
      GlassRadiusDamage(vehicle.origin, 70, 200, 200);
    }

    vehicle Vehicle_SetSpeedImmediate(0);

    if(!vehicle.hasAIOption) {
      fxEnt Delete();
    }
  }
}

playerPlayThrusterSound(vehicle) {
  soundEnt = spawn("script_model", vehicle.origin);
  soundEnt LinkTo(vehicle, "tag_origin");
  soundEnt Hide();
  foreach(player in level.players) {
    if(self == player) {
      continue;
    }

    soundEnt ShowToPlayer(player);
  }
  soundEnt PlaySoundOnMovingEnt("assault_drn_kamikaze_boost_npc");

  self PlayLocalSound("assault_drn_kamikaze_boost_plr");

  wait 2;

  soundEnt Delete();
}

playerPlayTargetFX(vehicle, targetPos) {
  groundEnt = spawn("script_model", targetPos);
  groundEnt setModel("tag_origin");
  groundEnt.angles = (-90, 0, 0);

  PlayFXOnTagForClients(getfx("assault_drone_marker"), groundEnt, "tag_origin", self);

  vehicle waittill("death");

  stopFXOnTag(getfx("assault_drone_marker"), groundEnt, "tag_origin");
  waitframe();
  groundEnt Delete();
}

SpawnMgTurret(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  turretType = "drone_assault_remote_turret_mp";
  turretModel = "vehicle_atlas_aerial_drone_01_mp_turret_50p";
  dropPitch = 0.0;

  tagName = "tag_origin";
  tagOriginOffset = (0, 0, 0);
  tagAngleOffset = (0, 0, 0);

  if(vehicle.mp_terrace) {
    turretType = "killstreak_terrace_mp";
    turretModel = "vehicle_sniper_drone_turret_mp_cloak";
  }

  turretAttachTagOrigin = vehicle GetTagOrigin(tagName);

  mgTurret = SpawnTurret("misc_turret", turretAttachTagOrigin, turretType, false);
  mgTurret.angles = vehicle.angles;
  mgTurret setModel(turretModel);
  mgTurret SetDefaultDropPitch(dropPitch);
  mgTurret LinkTo(vehicle, tagName, tagOriginOffset, tagAngleOffset);
  mgTurret.owner = self;
  mgTurret.health = 99999;
  mgTurret setCanDamage(false);
  mgTurret setCanRadiusDamage(false);
  mgTurret.tank = vehicle;
  mgTurret MakeUnusable();

  if(vehicle.hasAIOption) {
    mgTurret.killCamEnt = vehicle;
  }

  vehicle.mgTurret = mgTurret;
  vehicle.mgTurret SetMode("sentry_manual");
  vehicle.mgTurret SetSentryOwner(self);
  vehicle.mgTurret SetTurretMinimapVisible(false);

  vehicle.mgTurret CloakingEnable();

  if(!vehicle.hasMG) {
    vehicle.mgTurret TurretFireDisable();
  }

  if(vehicle.mp_terrace) {
    self EnableSlowAim(.2, .3, 0.8, 0.8);
    self thread terrace_turret_fx(vehicle);
  }

  if(!vehicle.hasAIOption) {
    if(vehicle.mp_terrace) {
      self thread control_turret_after_delay(vehicle, 0.0);
    } else {
      self thread control_turret_after_delay(vehicle, 1.6);
    }
  }

  self thread delete_turret_on_death(vehicle);

  if(vehicle.hasCloak && vehicle.hasMG) {
    self thread watchMGFireUncloak(vehicle);
  }
}

control_turret_after_delay(vehicle, delay_time) {
  dropPitch = 0.0;

  if(delay_time > 0) {
    wait(delay_time);
  }

  if(isDefined(self) && isDefined(vehicle) && isDefined(vehicle.mgTurret)) {
    self RemoteControlTurret(vehicle.mgTurret, dropPitch);
  }
}

watchMGFireUncloak(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  while(true) {
    vehicle waittill("FirePrimaryWeapon");
    self notify("ForceUncloak");
  }
}

terrace_turret_fx(vehicle) {
  vehicle endon("death");
  level endon("game_ended");

  waitframe();

  PlayFXOnTagForClients(level._effect["sniper_drone_thruster_view"], vehicle.mgTurret, "tag_fx2", self);
  waitframe();
  PlayFXOnTagForClients(level._effect["sniper_drone_wind_marker"], vehicle.mgTurret, "tag_fx1", self);
}

delete_turret_on_death(vehicle) {
  vehicle waittill("death");

  if(isDefined(self)) {
    self RemoteControlTurretOff(vehicle.mgTurret);
    self ThermalVisionFOFOverlayOff();
  }

  if(vehicle.mp_terrace) {
    stopFXOnTag(level._effect["sniper_drone_thruster_view"], vehicle.mgTurret, "tag_fx2");
    stopFXOnTag(level._effect["sniper_drone_wind_marker"], vehicle.mgTurret, "tag_fx1");
  }

  vehicle.mgTurret Delete();
}

SetupRockets(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  vehicle.RocketAmmo = CONST_Rocket_AmmoMax;

  if(self GetClientOmnvar("ui_assaultdrone_toggle")) {
    self SetClientOmnvar("ui_assaultdrone_rockets", vehicle.RocketAmmo);
  }

  while(1) {
    if(vehicle.hasMG) {
      vehicle waittill("FireSecondaryWeapon");
    } else {
      vehicle waittill("FirePrimaryWeapon");
    }

    self notify("ForceUncloak");

    Earthquake(0.3, 1, vehicle.origin, 500);
    self PlayRumbleOnEntity("damage_heavy");
    missile_tag_origin = vehicle.mgTurret GetTagOrigin("tag_flash");
    missile_end = vehicle.TargetEnt.origin;

    if(vehicle.hasAIOption) {
      assault_velocity = vehicle Vehicle_GetVelocity();
    } else {
      assault_velocity = vehicle GetEntityVelocity();
    }

    missile = MagicBullet("ugv_missile_mp", missile_tag_origin + assault_velocity / 10, missile_end, self);

    missile Missile_SetTargetEnt(vehicle.TargetEnt);
    missile Missile_SetFlightmodeDirect();

    if(vehicle.hasAIOption) {
      missile.killCamEnt = vehicle;
    }

    vehicle.RocketAmmo--;

    if(vehicle.RocketAmmo > 0) {
      self SetClientOmnvar("ui_assaultdrone_rockets", vehicle.RocketAmmo);
      wait CONST_Rocket_Shot_Interval;
    } else {
      self SetClientOmnvar("ui_assaultdrone_rockets", 4);
      wait CONST_Rocket_Reload_Interval;
      vehicle.RocketAmmo = CONST_Rocket_AmmoMax;
      self SetClientOmnvar("ui_assaultdrone_rockets", vehicle.RocketAmmo);
    }
  }
}

AssaultHudSetup(vehicle) {
  vehicle endon("death");
  self endon("disconnect");

  AssaultHudRemove(vehicle);

  wait(0.5);

  self SetClientOmnvar("ui_assaultdrone_toggle", true);

  if(vehicle.mp_terrace) {
    self ForceFirstPersonWhenFollowed();
  }

  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();

  self SetClientOmnvar("ui_assaultdrone_countdown", vehicle.endTime);
  /#	
  if(SCR_CONST_DEBUG_INFINITE || GetDvarInt("scr_drone_assault_infinite", 0)) {
    self SetClientOmnvar("ui_assaultdrone_countdown", 0);
  }

  if(!vehicle.hasTurret) {
    self SetClientOmnvar("ui_assaultdrone_weapon", 2);
  } else {
    if(vehicle.mp_terrace)
  }
  self SetClientOmnvar("ui_assaultdrone_weapon", 3);
  else if(vehicle.hasMG) {
    self SetClientOmnvar("ui_assaultdrone_weapon", 1);
  }

  if(vehicle.hasRockets && isDefined(vehicle.RocketAmmo)) {
    self SetClientOmnvar("ui_assaultdrone_rockets", vehicle.RocketAmmo);
  }

  if(vehicle.hasCloak) {
    self SetClientOmnvar("ui_drone_cloak", 2);
  }
  if(isDefined(level.isHorde) && level.isHorde && self GetClientOmnvar("ui_horde_player_class") == "drone") {
    self SetClientOmnvar("ui_horde_drone_heal", 1);
  }

  if(vehicle.hasARHud) {
    self ThermalVisionFOFOverlayOn();
  }
}

AssaultHudRemove(vehicle) {
  self SetClientOmnvar("ui_assaultdrone_toggle", false);
  self SetClientOmnvar("ui_assaultdrone_countdown", 0);
  self SetClientOmnvar("ui_drone_cloak", 0);
  self SetClientOmnvar("ui_drone_cloak_time", 0);
  self SetClientOmnvar("ui_drone_cloak_cooldown", 0);
  self SetClientOmnvar("ui_assaultdrone_weapon", 0);
  self SetClientOmnvar("ui_assaultdrone_rockets", 0);
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();

  if(vehicle.mp_terrace) {
    self DisableForceFirstPersonWhenFollowed();
  }
}

MonitorUavSafeArea(vehicle) {
  self endon("assaultStreakComplete");

  if(vehicle.mp_terrace) {
    return;
  }

  self thread maps\mp\killstreaks\_aerial_utility::playerHandleBoundaryStatic(vehicle, "assaultStreakComplete");
  self thread maps\mp\killstreaks\_aerial_utility::playerHandleKillVehicle(vehicle, "assaultStreakComplete");

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
  self endon("assaultStreakComplete");

  self waittill_any("joined_team", "joined_spectators");

  vehicle notify("death");
}

MonitorPlayerGameEnded(vehicle) {
  self endon("assaultStreakComplete");

  level waittill("game_ended");

  vehicle notify("death");
}

onAssaultDroneDeath(attacker, weapon, meansOfDeath, damage) {
  self notify("death", attacker, meansOfDeath, weapon);

  if(isDefined(level.isHorde) && level.isHorde && isDefined(attacker.ishordeenemysentry) && attacker.ishordeenemysentry) {
    return;
  }

  if(self.mp_terrace) {
    self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "map_killstreak_destroyed", undefined, "callout_destroyed_terrace_sniper_drone", true);
  } else {
    self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "assault_drone_destroyed", undefined, "callout_destroyed_drone_assault", true);
  }
}

AssaultHandleTimeoutWarning(vehicle, lifespan) {
  vehicle endon("death");

  /#	
  if(SCR_CONST_DEBUG_INFINITE || GetDvarInt("scr_drone_assault_infinite", 0)) {
    return;
  }

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(lifeSpan - 10);

  timeout = 10;

  while(timeout != 0) {
    if(!vehicle.hasAIOption) {
      vehicle playSound("mp_warbird_outofbounds_warning");
    }
    timeout -= 1;
    wait 1;
  }

  if(isDefined(vehicle.hunterKiller)) {
    return;
  }

  vehicle notify("death");
}

AssaultHandleDeath(vehicle) {
  entNum = vehicle GetEntityNumber();

  vehicle droneAddToGlobalList(entNum);

  vehicle waittill("death", attacker);

  if(isDefined(vehicle.camLinkEnt)) {
    vehicle.camLinkEnt Unlink();
  }

  if(isDefined(vehicle)) {
    vehicle Ghost();
  }

  if(isDefined(vehicle.mgTurret)) {
    vehicle.mgTurret Ghost();
  }

  if(isDefined(self) && !vehicle.hasAIOption) {
    self freezeControlsWrapper(true);
  }

  self notify("assaultStreakComplete");
  self notify("StopWaitForDisconnect");

  vehicle playSound("assault_drn_death");
  playFX(level._effect["remote_tank_explode"], vehicle.origin);

  vehicle droneRemoveFromGlobalList(entNum);

  if(isDefined(self) && !vehicle.hasTurret && !vehicle.hasAIOption && !level.gameEnded) {
    wait 1;
    self maps\mp\killstreaks\_aerial_utility::playerShowFullStatic();
    wait 0.8;
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }

  if(isDefined(self) && isDefined(attacker) && self != attacker) {
    self thread leaderDialogOnPlayer("ks_adrone_destroyed", undefined, undefined, self.origin);
  }

  if(!vehicle.hasAIOption) {
    if(isDefined(self) && !level.gameEnded) {
      self freezeControlsWrapper(false);
    }

    if(isDefined(self) && (self.using_remote_tank || self isUsingRemote())) {
      self AssaultSetInactivity(vehicle);
      self.using_remote_tank = false;
    }
  } else {
    if(isDefined(self)) {
      self.hasAIAssaultDrone = false;
    }
  }

  decrementFauxVehicleCount();

  if(isDefined(vehicle.camLinkEnt)) {
    vehicle.camLinkEnt Delete();
  }

  vehicle delete();
}

AssaultSetInactivity(AssaultVeh) {
  if(!isDefined(AssaultVeh)) {
    return;
  }

  owner = self;

  if(isDefined(owner.using_remote_tank) && owner.using_remote_tank) {
    owner notify("end_remote");

    owner DisableSlowAim();
    owner RemoteControlVehicleOff(AssaultVeh);
    owner ThermalVisionFOFOverlayOff();
    self thread removeDroneVisionAndLightSetPerMap(1.5);
    owner Unlink();

    if(owner isUsingRemote() && !level.gameEnded) {
      owner clearUsingRemote();
    }

    owner switch_back_to_player_weapon();
    owner playerRestoreAngles();

    owner disablePlayercommands(AssaultVeh);

    thread AssaultHudRemove(AssaultVeh);
    if(getDvarInt("camera_thirdPerson")) {
      owner setThirdPersonDOF(true);
    }

    if(isDefined(owner.disabledUsability) && owner.disabledUsability) {
      owner _enableUsability();
    }

    owner.using_remote_tank = false;
  }
}

switch_back_to_player_weapon() {
  killstreakWeapon = getKillstreakWeapon("orbitalsupport");
  self TakeWeapon(killstreakWeapon);

  self EnableWeaponSwitch();
  self SwitchToWeapon(self getLastWeapon());
}

AssaultPlayerExit(vehicle) {
  if(!isDefined(self)) {
    return;
  }

  owner = self;

  level endon("game_ended");
  owner endon("disconnect");
  owner endon("assaultDroneHunterKiller");
  vehicle endon("death");

  while(true) {
    timeUsed = 0;
    while(!vehicle.hasAIOption && owner UseButtonPressed()) {
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