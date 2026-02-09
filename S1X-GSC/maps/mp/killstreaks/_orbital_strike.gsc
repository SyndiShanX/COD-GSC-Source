/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_orbital_strike.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

CONST_laser_fwd_offset = 30;

CONST_laser_radius = 128;
CONST_laser_radius_upgrade = 256;
CONST_laser_burst_duration = 4;
CONST_laser_chargeup_time = 6;
CONST_laser_z_height_offset = 1024;

init() {
  level._effect["orbital_laser_clouds"] = LoadFX("vfx/unique/vfx_odin_parallax_clouds");

  level._effect["orbital_laser_warmup"] = LoadFX("vfx/beam/orbital_laser_warmup");
  level._effect["orbital_laser_warmup_water"] = LoadFX("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_warmup_wide"] = LoadFX("vfx/beam/orbital_laser_warmup_large");
  level._effect["orbital_laser_warmup_wide_water"] = LoadFX("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_warmup_lightshow"] = LoadFX("vfx/beam/orbital_laser_warmup_lightshow");
  level._effect["orbital_laser_warmup_lightshow_water"] = LoadFX("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_warmup_lightshow_wide"] = LoadFX("vfx/beam/orbital_laser_warmup_lightshow_large");
  level._effect["orbital_laser_warmup_lightshow_wide_water"] = LoadFX("vfx/beam/orbital_laser_water_boiling");

  level._effect["orbital_laser_fire"] = LoadFX("vfx/beam/orbital_laser_fire_small");
  level._effect["orbital_laser_fire_water"] = LoadFX("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_fire_wide"] = LoadFX("vfx/beam/orbital_laser_fire_large");
  level._effect["orbital_laser_fire_wide_water"] = LoadFX("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_fire_lightshow"] = LoadFX("vfx/beam/orbital_laser_fire_lightshow");
  level._effect["orbital_laser_fire_lightshow_water"] = LoadFX("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_fire_lightshow_wide"] = LoadFX("vfx/beam/orbital_laser_fire_lightshow_large");
  level._effect["orbital_laser_fire_lightshow_wide_water"] = LoadFX("vfx/beam/orbital_laser_water_sm");

  level._effect["orbital_laser_ending"] = LoadFX("vfx/beam/orbital_laser_ending");
  level._effect["orbital_laser_ending_water"] = LoadFX("vfx/beam/orbital_laser_water_aftermath");

  level._effect["orbital_laser_beam"] = LoadFX("vfx/beam/orbital_laser_lightbeam");
  level._effect["orbital_laser_beam_wide"] = LoadFX("vfx/beam/orbital_laser_lightbeam_lg");
  level._effect["orbital_laser_beam_lightshow"] = LoadFX("vfx/beam/orbital_laser_lightbeam_lightshow");
  level._effect["orbital_laser_beam_lightshow_wide"] = LoadFX("vfx/beam/orbital_laser_lightbeam_lightshow_lg");

  level._effect["orbital_laser_smoldering"] = LoadFX("vfx/beam/orbital_laser_smoldering");
  level._effect["orbital_laser_death"] = LoadFX("vfx/beam/orbital_laser_lightbeam_burnmark");

  level._orbital_strike_setting = [];
  level._orbital_strike_setting = spawnStruct();
  level._orbital_strike_setting.vehicle = "orbital_laser_strike_mp";
  level._orbital_strike_setting.heliType = "OrbitalStrike";
  level._orbital_strike_setting.maxHealth = 9999999;

  level.killstreakFuncs["orbital_strike_laser"] = ::tryUseOrbitalStrike;

  level.killstreakWieldWeapons["orbital_laser_fov_mp"] = "orbital_strike_laser";

  if(!isDefined(level.orbital_lasers)) {
    level.orbital_lasers = [];
  }

  if(level.teamBased) {
    level.orbital_laser_axis = false;
    level.orbital_laser_allies = false;
  }

  SetDvarIfUninitialized("scr_orbital_laser_ground", "0");
  SetDvarIfUninitialized("scr_orbital_laser_timeout", "0");
  SetDvarIfUninitialized("scr_orbital_laser_chargetime", "0");

  level.orbitallaseroverrides = spawnStruct();
  level.orbitallaseroverrides.spawnHeight = undefined;
  level.orbitallaseroverrides.spawnPoint = undefined;

  if(isDefined(level.orbitalLaserOverrideFunc)) {
    [[level.orbitalLaserOverrideFunc]]();
  }
}

tryUseOrbitalStrike(lifeId, modules) {
  if(self CheckOrbitalLaserUsage()) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + 1 >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_TOO_MANY_VEHICLES");
    return false;
  }

  incrementFauxVehicleCount();
  team = undefined;
  if(level.teamBased) {
    team = self.team;
    SetOrbitalLaserForTeam(team, true);
  }

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("orbital_strike");
  if(result != "success") {
    decrementFauxVehicleCount();
    if(level.teamBased) {
      SetOrbitalLaserForTeam(team, false);
    }
    return false;
  }

  if(isDefined(level.isHorde) && level.isHorde && self.killstreakIndexWeapon == 1) {
    self notify("used_horde_orbital");
  }

  self setUsingRemote("orbital_strike");

  result = self SetupOrbitalStrike(lifeId, modules);

  self maps\mp\_matchdata::logKillstreakEvent("orbital_strike", self.origin);

  return result;
}

CheckOrbitalLaserUsage() {
  if(level.teamBased) {
    if(self.team == "allies") {
      return level.orbital_laser_allies;
    } else {
      return level.orbital_laser_axis;
    }
  } else {
    return level.orbital_lasers.size >= 2;
  }
}

SetOrbitalLaserForTeam(team, value) {
  if(team == "allies") {
    level.orbital_laser_allies = value;
  } else {
    level.orbital_laser_axis = value;
  }
}

OrbitalStrikeSetupDelay(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  waitframe();
  OrbitalStrike ThermalDrawDisable();
}

SetupOrbitalStrike(lifeId, modules) {
  self playerAddNotifyCommands();

  SpawnPoint = self FindBestSpawnLocation();

  OrbitalStrike = SpawnHelicopter(self, SpawnPoint.origin, (0, 0, 0), level._orbital_strike_setting.vehicle, "tag_origin");

  if(!isDefined(OrbitalStrike)) {
    return false;
  }

  OrbitalStrikeSetupDelay(OrbitalStrike);

  level.orbital_lasers = array_add(level.orbital_lasers, OrbitalStrike);

  OrbitalStrike.modules = modules;
  OrbitalStrike.vehicleType = "orbital_strike";
  OrbitalStrike.lifeId = lifeId;
  OrbitalStrike.team = self.pers["team"];
  OrbitalStrike.pers["team"] = self.pers["team"];
  OrbitalStrike.owner = self;
  OrbitalStrike.maxhealth = level._orbital_strike_setting.maxHealth;
  OrbitalStrike.zOffset = (0, 0, 0);
  OrbitalStrike.targeting_delay = level.heli_targeting_delay;
  OrbitalStrike.primaryTarget = undefined;
  OrbitalStrike.secondaryTarget = undefined;
  OrbitalStrike.attacker = undefined;
  OrbitalStrike.cloakState = 0;

  OrbitalStrike.numCharges = 1;
  if(array_contains(OrbitalStrike.modules, "orbital_strike_laser_burst1")) {
    OrbitalStrike.numCharges++;
  }
  if(array_contains(OrbitalStrike.modules, "orbital_strike_laser_burst2")) {
    OrbitalStrike.numCharges++;
  }
  OrbitalStrike.wideBeam = array_contains(OrbitalStrike.modules, "orbital_strike_laser_width");
  OrbitalStrike.beams = array_contains(OrbitalStrike.modules, "orbital_strike_laser_beam");
  OrbitalStrike.fireDuration = CONST_laser_burst_duration;
  if(array_contains(OrbitalStrike.modules, "orbital_strike_laser_duration")) {
    OrbitalStrike.fireDuration *= 2;
  }

  if(getDvar("scr_orbital_laser_timeout", "0") != "0") {
    OrbitalStrike.fireDuration = GetDvarFloat("scr_orbital_laser_timeout");
  }

  self.ControllingOrbitalLaser = true;

  self thread MonitorOrbitalStrikeTimeout(OrbitalStrike);
  self thread MonitorOrbitalStrikeDeath(OrbitalStrike);
  self thread MonitorPlayerDisconnect(OrbitalStrike);
  self thread MonitorPlayerTeamChange(OrbitalStrike);
  self thread MonitorGameEnded(OrbitalStrike);
  self thread PlayerControlOrbitalStrike(OrbitalStrike);
  self thread WatchAllPlayerDeath(OrbitalStrike, self);
  self thread onPlayerConnect(OrbitalStrike, self);

  return true;
}

onPlayerConnect(OrbitalStrike, owner) {
  owner endon("OrbitalStrikeStreakComplete");
  owner endon("disconnect");

  OrbitalStrike endon("death");
  OrbitalStrike endon("PossessHoldTimeComplete");
  OrbitalStrike endon("leaving");

  while(true) {
    level waittill("connected", player);
    player thread WaitForLaserDeath(OrbitalStrike, owner);
  }
}

zoomSlam(orbitalStrike) {
  if(getDvar("scr_orbital_laser_ground", "0") != "0") {
    return;
  }

  ent = spawn("script_model", orbitalStrike.origin + (0, 0, 3000));
  ent.angles = VectorToAngles((0, 0, 1));
  ent setModel("tag_origin");
  ent thread waitAndDelete(5);

  players_to_zoom = array_add(self get_players_watching(), self);
  foreach(player in players_to_zoom) {
    player SetClientOmnvar("cam_scene_name", "odin_zoom_down");
    player SetClientOmnvar("cam_scene_lead", orbitalStrike GetEntityNumber());
    player SetClientOmnvar("cam_scene_support", ent GetEntityNumber());
    player PlayLocalSound("vulcan_hud_transition");
    player thread clouds(orbitalStrike);
  }
}

clouds(orbitalStrike) {
  level endon("game_ended");

  ent = spawn("script_model", orbitalStrike.origin + (0, 0, -1000));
  ent.angles = VectorToAngles((0, 0, 1));
  ent setModel("tag_origin");
  ent thread waitAndDelete(5);

  PlayFXOnTagForClients(level._effect["orbital_laser_clouds"], ent, "tag_origin", self);
}

waitAndDelete(time) {
  self endon("death");
  level endon("game_ended");
  wait(time);
  self delete();
}

turnOnAndHideOrbitalHUD() {
  self SetClientOmnvar("ui_orbital_laser", true);
  self SetClientOmnvar("ui_orbital_laser_mode", 0);
  self SetClientOmnvar("ui_orbital_laser_charge", 0);
  self SetClientOmnvar("ui_orbital_laser_bursts", 0);
  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
}

showOrbitalStrikeHud(OrbitalStrike) {
  self thread activateThermal();

  self SetClientOmnvar("ui_orbital_laser_mode", 1);
  self SetClientOmnvar("ui_orbital_laser_bursts", OrbitalStrike.numCharges);
  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
}

OrbitalStrikeBeginChargeUp(OrbitalStrike, chargeTimeRemaining) {
  self endon("disconnect");
  self endon("OrbitalStrikeStreakComplete");

  endTime = GetTime() + (chargeTimeRemaining * 1000);

  self SetClientOmnvar("ui_orbital_laser_charge", endTime);

  self SetClientOmnvar("ui_orbital_laser_mode", 1);

  self PlayRumbleOnEntity("orbital_laser_charge");
  PlayWarmupSounds(OrbitalStrike, false);
  wait 0.1;
  PlayWarmupEffects(OrbitalStrike);
}

OrbitalStrikChargeUpSpeedUp(OrbitalStrike, chargeTimeRemaining) {
  endTime = GetTime() + (chargeTimeRemaining * 1000);

  self SetClientOmnvar("ui_orbital_laser_charge", endTime);

  self StopRumble("orbital_laser_charge");
  self PlayRumbleOnEntity("orbital_laser_charge_quick");

  PlayWarmupSounds(OrbitalStrike, true);
}

OrbitalStrikeChargeUpComplete(OrbitalStrike) {
  self SetClientOmnvar("ui_orbital_laser_charge", 0);

  self StopRumble("orbital_laser_charge");
  self StopRumble("orbital_laser_charge_quick");
  self PlayRumbleLoopOnEntity("orbital_laser_fire");
}

createOrbitalTimer(OrbitalStrike, chargeTime) {
  endTime = GetTime() + (chargeTime * 1000);

  self thread OrbitalStrikeBeginChargeUp(OrbitalStrike, chargeTime);

  self waitForTimeOrNotify(chargeTime, "StartFire");

  timeLeft = endTime - GetTime();

  if(timeLeft > 2500) {
    OrbitalStrikChargeUpSpeedUp(OrbitalStrike, 1.1);
    wait(1.1);
  } else {
    StopWarmupSounds(OrbitalStrike);
  }

  OrbitalStrikeChargeUpComplete(OrbitalStrike);
}

HideFireHud(OrbitalStrike) {
  self SetClientOmnvar("ui_orbital_laser_mode", 2);
}

SetHUDNumBursts(OrbitalStrike) {
  self SetClientOmnvar("ui_orbital_laser_bursts", OrbitalStrike.numCharges);
}

GetOrbitalLaserZHeight() {
  if(isDefined(level.orbitallaseroverrides.spawnHeight)) {
    return level.orbitallaseroverrides.spawnHeight;
  }

  heliAnchor = maps\mp\killstreaks\_aerial_utility::getHeliAnchor();
  spawnHeight = heliAnchor.origin[2] + CONST_laser_z_height_offset;

  if(isDefined(level.airstrikeoverrides) && isDefined(level.airstrikeoverrides.spawnHeight)) {
    spawnHeight += level.airstrikeoverrides.spawnHeight;
  }

  return spawnHeight;
}

FindBestSpawnLocation() {
  if(!isDefined(self.strikeSpawnPoint)) {
    self.strikeSpawnPoint = spawnStruct();
  }

  heliAnchor = maps\mp\killstreaks\_aerial_utility::getHeliAnchor();
  laserHeight = GetOrbitalLaserZHeight();

  spawnPoint = level.mapCenter;
  if(isDefined(level.orbitallaseroverrides.spawnPoint)) {
    spawnPoint = level.orbitallaseroverrides.spawnPoint;
  }

  self.strikeSpawnPoint.origin = spawnPoint + (0, 0, laserHeight);
  self.strikeSpawnPoint.angles = (0, self.angles[1], 0);

  return self.strikeSpawnPoint;
}

MonitorOrbitalStrikeSafeArea(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  self thread maps\mp\killstreaks\_aerial_utility::playerHandleBoundaryStatic(OrbitalStrike, "OrbitalStrikeStreakComplete");

  OrbitalStrike waittill("outOfBounds");

  wait 2;

  OrbitalStrike notify("leaving");
}

PlayerControlOrbitalStrike(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  self thread freezeControlsWrapper(true);

  self thread MonitorOrbitalStrikeSafeArea(OrbitalStrike);

  self playerSaveAngles();

  wait 0.45;

  self thread setVulcanVisionAndLightSetPerMap(0.5);
  self zoomSlam(OrbitalStrike);
  self turnOnAndHideOrbitalHUD();

  wait 1.5;

  self maps\mp\killstreaks\_aerial_utility::playerShowFullStatic();

  self thread freezeControlsWrapper(false);
  self _giveWeapon("orbital_laser_fov_mp");
  self SwitchToWeapon("orbital_laser_fov_mp");
  self _disableWeaponSwitch();

  self Unlink();

  OrbitalStrike SetHoverParams(0, 0, 0);
  OrbitalStrike SetJitterParams((0, 0, 0), 0, 0);

  self thread LeaveOrbitalStrikeEarly(OrbitalStrike);
  self thread playInteriorSound(OrbitalStrike);

  if(getDvar("scr_orbital_laser_ground", "0") != "0") {
    self thread WeaponSetup(OrbitalStrike);
    return;
  }

  self SetPlayerAngles((0, 0, 0));
  self RemoteControlVehicle(OrbitalStrike);
  wait(0.05);

  self CameraLinkTo(OrbitalStrike, "tag_origin");

  wait 0.55;
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  OrbitalStrike.killCamStartTime = GetTime();

  self showOrbitalStrikeHud(OrbitalStrike);
  self thread WeaponSetup(OrbitalStrike);
}

SetPlayerStance() {
  if(self GetStance() == "prone") {
    self SetStance("crouch");
  }
}

LeaveOrbitalStrikeEarly(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");
  OrbitalStrike endon("death");
  WaitBeats = 5;
  while(true) {
    self waittill("ToggleControlState");

    self thread CancelPossessButtonPressMonitor();
    self.HoldingLeaveButton = true;

    for(i = 0; i <= WaitBeats; i++) {
      wait(0.1);
      if(self.HoldingLeaveButton == true && i == WaitBeats) {
        OrbitalStrike notify("PossessHoldTimeComplete");
      } else if(self.HoldingLeaveButton == false) {
        break;
      }
    }
  }
}

CancelPossessButtonPressMonitor() {
  self endon("OrbitalStrikeStreakComplete");
  self endon("PossessHoldTimeComplete");

  self waittill("ToggleControlCancel");

  self.HoldingLeaveButton = false;
}

activateThermal() {
  if(getDvar("scr_orbital_laser_ground", "0") != "0") {
    return;
  }

  self SetShadowRendering(false);
  self ThermalVisionFOFOverlayOn();
  self SetBlurForPlayer(1.1, 0);
  adsAperature = 0.125;
  adsFocalDistance = 8500;
  normalAperature = 0.125;
  normalFocalDistance = 5500;
  focusSpeed = 20;
  aperatureSpeed = 30;
  self thread maps\mp\killstreaks\_aerial_utility::thermalVision("OrbitalStrikeStreakComplete", adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed);
}

playInteriorSound(OrbitalStrike) {
  localPlayers = array_add(self get_players_watching(), self);

  if(isDefined(OrbitalStrike)) {
    OrbitalStrike thread playLoopSoundToPlayers("vulcan_interior_loop_plr", undefined, localPlayers);
  }

  self waittill_any("OrbitalStrikeStreakComplete");

  if(isDefined(OrbitalStrike)) {
    OrbitalStrike stop_loop_sound_on_entity("vulcan_interior_loop_plr");
  }
}

WeaponListenForStopFire(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  endTime = GetTime() + (OrbitalStrike.fireDuration * 1000);
  self SetClientOmnvar("ui_orbital_laser_fire", endTime);

  wait OrbitalStrike.fireDuration;

  self SetClientOmnvar("ui_orbital_laser_fire", 0);
  OrbitalStrike notify("stop_charge");
}

GetLaserRadius(OrbitalStrike) {
  if(OrbitalStrike.wideBeam) {
    return CONST_laser_radius_upgrade;
  } else {
    return CONST_laser_radius;
  }
}

WeaponSetup(OrbitalStrike) {
  orbitalForwardDir = anglesToForward(OrbitalStrike.angles);
  orbitalRightDir = AnglesToRight(OrbitalStrike.angles);

  laser_start = OrbitalStrike GetTagOrigin("tag_origin") + (orbitalForwardDir * CONST_laser_fwd_offset);
  laser_dir = (0, 0, -1);
  laser_end = laser_start + (laser_dir * 5000);
  trace = bulletTrace(laser_start, laser_end, false, OrbitalStrike);
  laserCenterEnd = trace["position"];

  laserRadius = GetLaserRadius(OrbitalStrike);

  OrbitalStrike.WeaponLinker = spawn("script_model", laser_start);
  OrbitalStrike.WeaponLinker setModel("generic_prop_raven");
  OrbitalStrike.WeaponLinker LinkToSynchronizedParent(OrbitalStrike, "tag_origin");

  laserEnd = laserCenterEnd;
  laserAngles = VectorToAngles(laserEnd - laser_start);
  tag1 = spawn("script_model", laser_start);
  tag1 setModel("tag_origin");
  tag1.angles = laserAngles;
  tag1 LinkToSynchronizedParent(OrbitalStrike.WeaponLinker, "tag_origin");
  OrbitalStrike.WeaponTag01 = tag1;

  tag1Target = spawn("script_model", laserEnd);
  tag1Target.angles = (-90, 0, 0);
  tag1Target setModel("tag_origin");
  tag1Target SetOtherEnt(tag1);
  tag1Target Show();
  OrbitalStrike.WeaponTag01.targetedEnt = tag1Target;

  if(OrbitalStrike.beams) {
    laserEnd = laserCenterEnd + (orbitalForwardDir * laserRadius);
    laserAngles = VectorToAngles(laserEnd - laser_start);
    tag2 = spawn("script_model", laser_start);
    tag2 setModel("tag_origin");
    tag2.angles = laserAngles;
    tag2 LinkToSynchronizedParent(OrbitalStrike.WeaponLinker, "j_prop_1");
    OrbitalStrike.WeaponTag02 = tag2;

    tag2Target = spawn("script_model", laserEnd);
    tag2Target.angles = (-90, 0, 0);
    tag2Target setModel("tag_origin");
    tag2Target SetOtherEnt(tag2);
    tag2Target Show();
    OrbitalStrike.WeaponTag02.targetedEnt = tag2Target;

    distRight = Sin(60) * laserRadius;
    distForward = Cos(60) * laserRadius;

    laserEnd = laserCenterEnd - (orbitalForwardDir * distForward) + (orbitalRightDir * distRight);
    laserAngles = VectorToAngles(laserEnd - laser_start);
    tag3 = spawn("script_model", laser_start);
    tag3 setModel("tag_origin");
    tag3.angles = laserAngles;
    tag3 LinkToSynchronizedParent(OrbitalStrike.WeaponLinker, "j_prop_1");
    OrbitalStrike.WeaponTag03 = tag3;

    tag3Target = spawn("script_model", laserEnd);
    tag3Target.angles = (-90, 0, 0);
    tag3Target setModel("tag_origin");
    tag3Target SetOtherEnt(tag3);
    tag3Target Show();
    OrbitalStrike.WeaponTag03.targetedEnt = tag3Target;

    laserEnd = laserCenterEnd - (orbitalForwardDir * distForward) - (orbitalRightDir * distRight);
    laserAngles = VectorToAngles(laserEnd - laser_start);
    tag4 = spawn("script_model", laser_start);
    tag4 setModel("tag_origin");
    tag4.angles = laserAngles;
    tag4 LinkToSynchronizedParent(OrbitalStrike.WeaponLinker, "j_prop_1");
    OrbitalStrike.WeaponTag04 = tag4;

    tag4Target = spawn("script_model", laserEnd);
    tag4Target.angles = (-90, 0, 0);
    tag4Target setModel("tag_origin");
    tag4Target SetOtherEnt(tag4);
    tag4Target Show();
    OrbitalStrike.WeaponTag04.targetedEnt = tag4Target;
  }

  self thread SpinTheLasers(OrbitalStrike);

  self thread MonitorOrbitalStrikeWeapon(OrbitalStrike);
}

DeleteWeaponModels(OrbitalStrike) {
  if(isDefined(OrbitalStrike.WeaponTag01)) {
    OrbitalStrike.WeaponTag01.targetedEnt Delete();
    OrbitalStrike.WeaponTag01 Delete();
    if(OrbitalStrike.beams) {
      OrbitalStrike.WeaponTag02.targetedEnt Delete();
      OrbitalStrike.WeaponTag02 Delete();
      OrbitalStrike.WeaponTag03.targetedEnt Delete();
      OrbitalStrike.WeaponTag03 Delete();
      OrbitalStrike.WeaponTag04.targetedEnt Delete();
      OrbitalStrike.WeaponTag04 Delete();
    }
  }

  if(isDefined(OrbitalStrike.WeaponLinker)) {
    OrbitalStrike.WeaponLinker Delete();
  }
}

SpinTheLasers(OrbitalStrike) {
  OrbitalStrike.WeaponLinker ScriptModelPlayAnim("mp_generic_prop_spin", "hello");
}

MonitorOrbitalStrikeWeapon(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  OrbitalStrike ClearTurretTarget();
  wait(1);

  chargeTime = CONST_laser_chargeup_time;

  if(getDvar("scr_orbital_laser_chargetime", "0") != "0") {
    chargeTime = GetDvarFloat("scr_orbital_laser_chargetime");
  }

  while(OrbitalStrike.numCharges > 0) {
    self createOrbitalTimer(OrbitalStrike, chargeTime);
    OrbitalStrike.numCharges--;
    SetHUDNumBursts(OrbitalStrike);
    self thread WeaponListenForStopFire(OrbitalStrike);
    HideFireHud(OrbitalStrike);
    self LaserWeapon(OrbitalStrike);

    wait 0.1;
  }

  OrbitalStrike notify("done");
}

OneShotSoundOnMovingEnt(aliasName, lifetime) {
  if(!isDefined(lifetime)) {
    lifetime = 5.0;
  }

  soundEnt = spawn("script_model", self.origin);
  soundEnt setModel("tag_origin");
  soundEnt LinkToSynchronizedParent(self);
  soundEnt playSound(aliasName);
  soundEnt thread waitAndDelete(lifetime);
}

OneShotSoundOnStationaryEnt(aliasName, lifetime) {
  if(!isDefined(lifetime)) {
    lifetime = 5.0;
  }

  soundEnt = spawn("script_model", self.origin);
  soundEnt setModel("tag_origin");
  soundEnt playSound(aliasName);
  soundEnt thread waitAndDelete(lifetime);
}

StartLaserSounds(OrbitalStrike) {
  OrbitalStrike.playingLoopFireSounds = true;

  localPlayers = array_add(self get_players_watching(), self);

  OrbitalStrike.WeaponTag01.targetedEnt thread play_loop_sound_on_entity("vulcan_beam_loop_npc");
  OrbitalStrike.WeaponTag01.targetedEnt thread play_loop_sound_on_entity("vulcan_impact_loop_npc");
  OrbitalStrike.WeaponTag01.targetedEnt OneShotSoundOnMovingEnt("vulcan_shot_snap_npc");
  OrbitalStrike.WeaponTag01.targetedEnt OneShotSoundOnMovingEnt("vulcan_shot_tail_npc");

  beamLoopSound = "vulcan_std_beam_loop_plr";
  if(OrbitalStrike.beams) {
    beamLoopSound = "vulcan_lshow_beam_loop_plr";
  } else if(OrbitalStrike.wideBeam) {
    beamLoopSound = "vulcan_wide_beam_loop_plr";
  }

  OrbitalStrike thread playLoopSoundToPlayers("vulcan_beam_loop_plr", undefined, localPlayers);
  OrbitalStrike thread playLoopSoundToPlayers(beamLoopSound, undefined, localPlayers);

  if(getDvar("scr_orbital_laser_ground", "0") != "0") {
    return;
  }

  beamSnapSound = "vulcan_shot_snap_plr";
  if(OrbitalStrike.beams) {
    beamSnapSound = "vulcan_shot_snap_lshow_plr";
  } else if(OrbitalStrike.wideBeam) {
    beamSnapSound = "vulcan_shot_snap_wide_plr";
  }

  self PlayLocalSound(beamSnapSound);
  self PlayLocalSound("vulcan_shot_tail_plr");
}

StopLaserSounds(OrbitalStrike) {
  if(isDefined(OrbitalStrike.WeaponTag01)) {
    OrbitalStrike.WeaponTag01.targetedEnt stop_loop_sound_on_entity("vulcan_beam_loop_npc");
    OrbitalStrike.WeaponTag01.targetedEnt stop_loop_sound_on_entity("vulcan_impact_loop_npc");

    if(OrbitalStrike.beams) {
      OrbitalStrike.WeaponTag02.targetedEnt stop_loop_sound_on_entity("vulcan_beam_loop_npc");
      OrbitalStrike.WeaponTag02.targetedEnt stop_loop_sound_on_entity("vulcan_impact_loop_npc");

      OrbitalStrike.WeaponTag03.targetedEnt stop_loop_sound_on_entity("vulcan_beam_loop_npc");
      OrbitalStrike.WeaponTag03.targetedEnt stop_loop_sound_on_entity("vulcan_impact_loop_npc");

      OrbitalStrike.WeaponTag04.targetedEnt stop_loop_sound_on_entity("vulcan_beam_loop_npc");
      OrbitalStrike.WeaponTag04.targetedEnt stop_loop_sound_on_entity("vulcan_impact_loop_npc");
    }
  }

  beamLoopSound = "vulcan_std_beam_loop_plr";
  if(OrbitalStrike.wideBeam) {
    beamLoopSound = "vulcan_wide_beam_loop_plr";
  }

  OrbitalStrike stop_loop_sound_on_entity("vulcan_beam_loop_plr");
  OrbitalStrike stop_loop_sound_on_entity(beamLoopSound);

  if(isDefined(OrbitalStrike.playingLoopFireSounds) && OrbitalStrike.playingLoopFireSounds) {
    OrbitalStrike.playingLoopFireSounds = false;

    if(isDefined(OrbitalStrike.WeaponTag01)) {
      OrbitalStrike.WeaponTag01.targetedEnt OneShotSoundOnStationaryEnt("vulcan_beam_stop_npc");
      if(OrbitalStrike.beams) {
        OrbitalStrike.WeaponTag02.targetedEnt OneShotSoundOnStationaryEnt("vulcan_beam_stop_npc");
        OrbitalStrike.WeaponTag03.targetedEnt OneShotSoundOnStationaryEnt("vulcan_beam_stop_npc");
        OrbitalStrike.WeaponTag04.targetedEnt OneShotSoundOnStationaryEnt("vulcan_beam_stop_npc");
      }
    }

    if(self.ControllingOrbitalLaser) {
      playLocalSounds = true;

      if(getDvar("scr_orbital_laser_ground", "0") != "0") {
        playLocalSounds = false;
      }

      if(isDefined(self) && playLocalSounds) {
        self PlayLocalSound("vulcan_beam_stop_plr");
      }
    }
  }
}

LaserWeapon(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  StopWarmupEffects(OrbitalStrike);

  waitframe();
  waitframe();

  self thread fireLaserBeam(OrbitalStrike);
  self thread LaserPilotQuake(OrbitalStrike);
  self thread LaserSurfaceQuake(OrbitalStrike);
  self thread LaserDoPhysics(OrbitalStrike);

  self thread LaserDoDamge(OrbitalStrike);

  self SetRemoteHelicopterThrottleScale(0.3);
  OrbitalStrike waittill("stop_charge");
  self SetRemoteHelicopterThrottleScale(1.0);
}

LaserDoDamge(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  OrbitalStrike endon("death");
  OrbitalStrike endon("PossessHoldTimeComplete");
  OrbitalStrike endon("leaving");
  OrbitalStrike endon("stop_charge");

  radius = GetLaserRadius(OrbitalStrike);

  while(1) {
    OrbitalStrike RadiusDamage(OrbitalStrike.WeaponTag01.targetedEnt.origin + (0, 0, 8), radius, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
    if(isDefined(level.ishorde) && level.ishorde && isDefined(level.flying_attack_drones)) {
      foreach(drone in level.flying_attack_drones) {
        if(drone.origin[2] > OrbitalStrike.WeaponTag01.targetedEnt.origin[2] && Distance2DSquared(drone.origin, OrbitalStrike.WeaponTag01.targetedEnt.origin) < (int((radius * radius) / 9))) {
          drone DoDamage(90, OrbitalStrike.WeaponTag01.targetedEnt.origin, self, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
        }
      }
    }
    if(OrbitalStrike.beams) {
      OrbitalStrike RadiusDamage(OrbitalStrike.WeaponTag02.targetedEnt.origin + (0, 0, 8), radius, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
      OrbitalStrike RadiusDamage(OrbitalStrike.WeaponTag03.targetedEnt.origin + (0, 0, 8), radius, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
      OrbitalStrike RadiusDamage(OrbitalStrike.WeaponTag04.targetedEnt.origin + (0, 0, 8), radius, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
    }
    GlassRadiusDamage(OrbitalStrike.WeaponTag01.targetedEnt.origin + (0, 0, 32), radius * 2, 200, 200);
    if(OrbitalStrike.beams) {
      GlassRadiusDamage(OrbitalStrike.WeaponTag02.targetedEnt.origin + (0, 0, 32), radius * 2, 200, 200);
      GlassRadiusDamage(OrbitalStrike.WeaponTag03.targetedEnt.origin + (0, 0, 32), radius * 2, 200, 200);
      GlassRadiusDamage(OrbitalStrike.WeaponTag04.targetedEnt.origin + (0, 0, 32), radius * 2, 200, 200);
    }
    wait(0.15);
  }
}

WatchAllPlayerDeath(OrbitalStrike, owner) {
  foreach(player in level.players) {
    player thread WaitForLaserDeath(OrbitalStrike, owner);
  }
}

WaitForLaserDeath(OrbitalStrike, owner) {
  self endon("OrbitalStrikeStreakComplete");

  OrbitalStrike endon("death");
  OrbitalStrike endon("PossessHoldTimeComplete");
  OrbitalStrike endon("leaving");

  while(true) {
    self waittill("death", attacker_ent, means_of_death, weapon_name);
    if(isDefined(weapon_name) && isDefined(attacker_ent) && attacker_ent == owner && weapon_name == "orbital_laser_fov_mp") {
      try_again = 10;
      for(i = 0; i < try_again; i++) {
        wait(0.05);
        if(isDefined(self) && isDefined(self.body)) {
          playFXOnTag(level._effect["orbital_laser_death"], self.body, "tag_origin");
          break;
        }
      }
    }
    wait(0.05);
  }
}

LaserDoPhysics(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  OrbitalStrike endon("death");
  OrbitalStrike endon("PossessHoldTimeComplete");
  OrbitalStrike endon("leaving");
  OrbitalStrike endon("stop_charge");

  radius = GetLaserRadius(OrbitalStrike);

  force = 2;

  while(1) {
    RanNum1 = RandomFloatRange(0.65, 0.8);
    RanNum2 = RandomIntRange(-180, 180);

    RandomAngles = (OrbitalStrike.WeaponTag01.targetedEnt.angles[0] * RanNum1, RanNum2, RanNum2);
    dir = anglesToForward(RandomAngles);
    PhysicsExplosionSphere(OrbitalStrike.WeaponTag01.targetedEnt.origin + (0, 0, 1), radius, 96, force);
    wait(0.4);
  }
}

fireLaserBeam(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");
  OrbitalStrike endon("death");

  PlayFireEffects(OrbitalStrike);
  PlayBeamEffects(OrbitalStrike);
  StartLaserSounds(OrbitalStrike);

  OrbitalStrike waittill("stop_charge");

  if(isDefined(OrbitalStrike)) {
    StopFireEffects(OrbitalStrike);
    StopBeamEffects(OrbitalStrike);
    StopLaserSounds(OrbitalStrike);
  }
}

LaserPilotQuake(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");
  OrbitalStrike endon("death");
  OrbitalStrike endon("stop_weapon");
  OrbitalStrike endon("stop_charge");

  QuakeTime = 0.25;

  Earthquake(0.07, QuakeTime, OrbitalStrike.origin, 256);
  wait(QuakeTime);
}

LaserSurfaceQuake(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");
  OrbitalStrike endon("death");
  OrbitalStrike endon("stop_weapon");
  OrbitalStrike endon("stop_charge");

  QuakeTime = 0.25;

  Earthquake(0.5, QuakeTime, OrbitalStrike.WeaponTag01.targetedEnt.origin + (0, 0, 16), 384);
  wait(QuakeTime);
}

PlayEffectOnGroundEnt(groundFX, waterFX, notifyStop) {
  level endon("game_ended");
  self endon("death");

  inWater = self IsGroundEntOverWater();
  if(inWater) {
    playFXOnTag(waterFX, self, "tag_origin");
  } else {
    playFXOnTag(groundFX, self, "tag_origin");
  }

  while(1) {
    prevInWater = inWater;
    inWater = self IsGroundEntOverWater();

    if(inWater != prevInWater) {
      if(inWater) {
        stopFXOnTag(groundFX, self, "tag_origin");
        playFXOnTag(waterFX, self, "tag_origin");
      } else {
        stopFXOnTag(waterFX, self, "tag_origin");
        playFXOnTag(groundFX, self, "tag_origin");
      }
    }

    val = waittill_notify_or_timeout_return(notifyStop, 0.05);
    if(!isDefined(val) || val != "timeout") {
      break;
    }
  }

  if(inWater) {
    stopFXOnTag(waterFX, self, "tag_origin");
  } else {
    stopFXOnTag(groundFX, self, "tag_origin");
  }
}

PlayWarmupEffects(OrbitalStrike) {
  notifyStop = "stop_warmup_fx";
  warmupFXGround = getWarmupEffect(OrbitalStrike);
  warmupFXWater = getWarmupEffect(OrbitalStrike, true);

  OrbitalStrike.WeaponTag01.targetedEnt thread PlayEffectOnGroundEnt(warmupFXGround, warmupFXWater, notifyStop);

  if(OrbitalStrike.beams) {
    warmupLightshowFXGround = getWarmupLightshowEffect(OrbitalStrike);
    warmupLightshowFXGroundWater = getWarmupLightshowEffect(OrbitalStrike, true);

    OrbitalStrike.WeaponTag02.targetedEnt thread PlayEffectOnGroundEnt(warmupLightshowFXGround, warmupLightshowFXGroundWater, notifyStop);
    OrbitalStrike.WeaponTag03.targetedEnt thread PlayEffectOnGroundEnt(warmupLightshowFXGround, warmupLightshowFXGroundWater, notifyStop);
    OrbitalStrike.WeaponTag04.targetedEnt thread PlayEffectOnGroundEnt(warmupLightshowFXGround, warmupLightshowFXGroundWater, notifyStop);
  }
}

StopWarmupEffects(OrbitalStrike) {
  notifyStop = "stop_warmup_fx";

  if(isDefined(OrbitalStrike.WeaponTag01)) {
    OrbitalStrike.WeaponTag01.targetedEnt notify(notifyStop);
    if(OrbitalStrike.beams) {
      OrbitalStrike.WeaponTag02.targetedEnt notify(notifyStop);
      OrbitalStrike.WeaponTag03.targetedEnt notify(notifyStop);
      OrbitalStrike.WeaponTag04.targetedEnt notify(notifyStop);
    }
  }
}

getWarmupEffect(OrbitalStrike, inWater) {
  fxRef = "orbital_laser_warmup";
  if(OrbitalStrike.wideBeam) {
    fxRef = fxRef + "_wide";
  }

  if(isDefined(inWater) && inWater) {
    fxRef = fxRef + "_water";
  }

  return getfx(fxRef);
}
getWarmupLightshowEffect(OrbitalStrike, inWater) {
  fxRef = "orbital_laser_warmup_lightshow";
  if(OrbitalStrike.wideBeam) {
    fxRef = fxRef + "_wide";
  }

  if(isDefined(inWater) && inWater) {
    fxRef = fxRef + "_water";
  }

  return getfx(fxRef);
}

PlayWarmupSounds(OrbitalStrike, quick) {
  StopWarmupSounds(OrbitalStrike);

  npcSound = "vulcan_charge_start_npc";
  plrSound = "vulcan_charge_start_plr";
  if(quick) {
    npcSound = "vulcan_charge_up_npc";
    plrSound = "vulcan_charge_up_plr";
  }

  OrbitalStrike.WeaponTag01.targetedEnt PlaySoundOnMovingEnt(npcSound);
  if(OrbitalStrike.beams) {
    OrbitalStrike.WeaponTag02.targetedEnt PlaySoundOnMovingEnt(npcSound);
    OrbitalStrike.WeaponTag03.targetedEnt PlaySoundOnMovingEnt(npcSound);
    OrbitalStrike.WeaponTag04.targetedEnt PlaySoundOnMovingEnt(npcSound);
  }

  if(getDvar("scr_orbital_laser_ground", "0") != "0") {
    return;
  }

  self PlayLocalSound(plrSound);
}

StopWarmupSounds(OrbitalStrike) {
  if(isDefined(OrbitalStrike.WeaponTag01)) {
    OrbitalStrike.WeaponTag01.targetedEnt StopSounds();
    if(OrbitalStrike.beams) {
      OrbitalStrike.WeaponTag02.targetedEnt StopSounds();
      OrbitalStrike.WeaponTag03.targetedEnt StopSounds();
      OrbitalStrike.WeaponTag04.targetedEnt StopSounds();
    }
  }

  if(isDefined(self)) {
    self StopLocalSound("vulcan_charge_start_plr");
    self StopLocalSound("vulcan_charge_up_plr");
  }
}

PlayFireEffects(OrbitalStrike) {
  notifyStop = "stop_fire_fx";

  fireFXGround = getFireEffect(OrbitalStrike);
  fireFXWater = getFireEffect(OrbitalStrike, true);

  lightshowFireFXGround = getFireLightshowEffect(OrbitalStrike);
  lightshowFireFXWater = getFireLightshowEffect(OrbitalStrike, true);

  if(OrbitalStrike.beams) {
    OrbitalStrike.WeaponTag01.targetedEnt thread PlayEffectOnGroundEnt(lightshowFireFXGround, lightshowFireFXWater, notifyStop);
    OrbitalStrike.WeaponTag02.targetedEnt thread PlayEffectOnGroundEnt(lightshowFireFXGround, lightshowFireFXWater, notifyStop);
    OrbitalStrike.WeaponTag03.targetedEnt thread PlayEffectOnGroundEnt(lightshowFireFXGround, lightshowFireFXWater, notifyStop);
    OrbitalStrike.WeaponTag04.targetedEnt thread PlayEffectOnGroundEnt(lightshowFireFXGround, lightshowFireFXWater, notifyStop);
  } else {
    OrbitalStrike.WeaponTag01.targetedEnt thread PlayEffectOnGroundEnt(fireFXGround, fireFXWater, notifyStop);
  }
}

StopFireEffects(OrbitalStrike) {
  notifyStop = "stop_fire_fx";

  if(isDefined(OrbitalStrike.WeaponTag01)) {
    OrbitalStrike.WeaponTag01.targetedEnt notify(notifyStop);
    if(OrbitalStrike.beams) {
      OrbitalStrike.WeaponTag02.targetedEnt notify(notifyStop);
      OrbitalStrike.WeaponTag03.targetedEnt notify(notifyStop);
      OrbitalStrike.WeaponTag04.targetedEnt notify(notifyStop);
    }

    PlayLaserEndingEffect(OrbitalStrike);
  }
}

PlayLaserEndingEffect(OrbitalStrike) {
  ent = OrbitalStrike.WeaponTag01.targetedEnt;

  if(ent IsGroundEntOverWater()) {
    playFX(level._effect["orbital_laser_ending_water"], ent.origin, anglesToForward(ent.angles), AnglesToUp(ent.angles));
  } else {
    playFX(level._effect["orbital_laser_ending"], ent.origin, anglesToForward(ent.angles), AnglesToUp(ent.angles));
  }
}

getFireEffect(OrbitalStrike, inWater) {
  fxRef = "orbital_laser_fire";
  if(OrbitalStrike.wideBeam) {
    fxRef = fxRef + "_wide";
  }

  if(isDefined(inWater) && inWater) {
    fxRef = fxRef + "_water";
  }

  return getfx(fxRef);
}
getFireLightshowEffect(OrbitalStrike, inWater) {
  fxRef = "orbital_laser_fire_lightshow";
  if(OrbitalStrike.wideBeam) {
    fxRef = fxRef + "_wide";
  }

  if(isDefined(inWater) && inWater) {
    fxRef = fxRef + "_water";
  }

  return getfx(fxRef);
}

PlayBeamEffects(OrbitalStrike) {
  beamFX = getBeamEffect(OrbitalStrike);
  playFXOnTag(beamFX, OrbitalStrike.WeaponTag01.targetedEnt, "tag_origin");
  if(OrbitalStrike.beams) {
    lightshowBeamFX = getLightshowBeamEffect(OrbitalStrike);
    playFXOnTag(lightshowBeamFX, OrbitalStrike.WeaponTag02.targetedEnt, "tag_origin");
    playFXOnTag(lightshowBeamFX, OrbitalStrike.WeaponTag03.targetedEnt, "tag_origin");
    playFXOnTag(lightshowBeamFX, OrbitalStrike.WeaponTag04.targetedEnt, "tag_origin");
  }
}

StopBeamEffects(OrbitalStrike) {
  beamFX = getBeamEffect(OrbitalStrike);
  waitframe();
  if(isDefined(OrbitalStrike.WeaponTag01)) {
    stopFXOnTag(beamFX, OrbitalStrike.WeaponTag01.targetedEnt, "tag_origin");
    if(OrbitalStrike.beams) {
      lightshowBeamFX = getLightshowBeamEffect(OrbitalStrike);
      stopFXOnTag(lightshowBeamFX, OrbitalStrike.WeaponTag02.targetedEnt, "tag_origin");
      stopFXOnTag(lightshowBeamFX, OrbitalStrike.WeaponTag03.targetedEnt, "tag_origin");
      stopFXOnTag(lightshowBeamFX, OrbitalStrike.WeaponTag04.targetedEnt, "tag_origin");
    }
  }
}

PlayLingerEffects(OrbitalStrike) {
  playFXOnTag("orbital_laser_smoldering", OrbitalStrike.WeaponTag01.targetedEnt, "tag_origin");
}

getBeamEffect(OrbitalStrike) {
  fxRef = "orbital_laser_beam";
  if(OrbitalStrike.wideBeam) {
    fxRef = fxRef + "_wide";
  }

  return getfx(fxRef);
}

getLightshowBeamEffect(OrbitalStrike) {
  fxRef = "orbital_laser_beam_lightshow";
  if(OrbitalStrike.wideBeam) {
    fxRef = fxRef + "_wide";
  }
  return getfx(fxRef);
}

OrbitalStrikeTimer(lifeSpan, OrbitalStrike) {
  self endon("disconnect");
  self endon("OrbitalStrikeStreakComplete");
  wait(lifeSpan);
  OrbitalStrike notify("leaving");
}

MonitorOrbitalStrikeDeath(OrbitalStrike) {
  self endon("disconnect");
  self endon("game_ended");
  self endon("OrbitalStrikeStreakComplete");

  OrbitalStrike waittill("death", attacker, meansOfDeath, weapon);

  OrbitalStrike maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, OrbitalStrike.health + 1, "vulcan_destroyed", undefined, undefined, true);

  OrbitalStrike notify("finish_death");
}

MonitorOrbitalStrikeTimeout(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  OrbitalStrike waittill_any("leaving", "crashing", "PossessHoldTimeComplete", "done", "finish_death");

  self thread OrbitalStrikeCleanup(OrbitalStrike);
}

GiveControlBack(OrbitalStrike) {
  if(isDefined(OrbitalStrike) && isDefined(OrbitalStrike.WeaponTag01)) {
    OrbitalStrike.WeaponTag01.targetedEnt SetOtherEnt(undefined);

    if(OrbitalStrike.beams) {
      OrbitalStrike.WeaponTag02.targetedEnt SetOtherEnt(undefined);
      OrbitalStrike.WeaponTag03.targetedEnt SetOtherEnt(undefined);
      OrbitalStrike.WeaponTag04.targetedEnt SetOtherEnt(undefined);
    }
  }

  self SetClientOmnvar("ui_orbital_laser_charge", 0);
  self SetClientOmnvar("ui_orbital_laser_mode", 0);
  self SetClientOmnvar("ui_orbital_laser_bursts", 0);
  self SetClientOmnvar("ui_orbital_laser_fire", 0);
  self SetClientOmnvar("ui_orbital_laser", false);
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();

  self TakeWeapon("orbital_laser_fov_mp");
  if(self.disabledWeaponSwitch > 0) {
    self _enableWeaponSwitch();
  }
  self SetBlurForPlayer(0, 0);
  self SetShadowRendering(true);
  maps\mp\killstreaks\_aerial_utility::disableOrbitalThermal(self);
  self ThermalVisionFOFOverlayOff();
  self RemoteControlVehicleOff();
  self ControlsUnlink();
  self CameraUnlink();
  if(self isUsingRemote()) {
    self clearUsingRemote();
  }
  self thread DelayControl();
  self thread removeVulcanVisionAndLightSetPerMap(0.5);
  if(GetDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(true);
  }

  if(getDvar("scr_orbital_laser_ground", "0") != "0") {
    self notify("player_control_strike_over");
    return;
  }

  self playerRestoreAngles();
  self notify("player_control_strike_over");
}

DelayControl() {
  self FreezeControls(true);
  wait(0.5);
  self FreezeControls(false);
}

MonitorPlayerDisconnect(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  self waittill("disconnect");

  self thread OrbitalStrikeCleanup(OrbitalStrike, true);
}

MonitorPlayerTeamChange(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  self waittill_either("joined_team", "joined_spectators");

  self thread OrbitalStrikeCleanup(OrbitalStrike);
}

MonitorGameEnded(OrbitalStrike) {
  self endon("OrbitalStrikeStreakComplete");

  level waittill("game_ended");

  self thread OrbitalStrikeCleanup(OrbitalStrike);
}

OrbitalStrikeCleanup(OrbitalStrike, disconnected) {
  self notify("OrbitalStrikeStreakComplete");

  waittillframeend;

  if(!isDefined(OrbitalStrike)) {
    return;
  }

  if(!isDefined(disconnected)) {
    disconnected = false;
  }

  if(!disconnected) {
    self.ControllingOrbitalLaser = false;

    self GiveControlBack(OrbitalStrike);

    self playerRemoveNotifyCommands();
  }

  level.orbital_lasers = array_remove(level.orbital_lasers, OrbitalStrike);
  if(level.teamBased) {
    SetOrbitalLaserForTeam(OrbitalStrike.team, false);
  }

  StopWarmupSounds(OrbitalStrike);
  StopLaserSounds(OrbitalStrike);
  StopWarmupEffects(OrbitalStrike);
  StopFireEffects(OrbitalStrike);
  StopBeamEffects(OrbitalStrike);

  DeleteWeaponModels(OrbitalStrike);
  OrbitalStrike Delete();

  decrementFauxVehicleCount();

  waitframe();
  if(isDefined(self)) {
    self StopRumble("orbital_laser_charge");
    self StopRumble("orbital_laser_charge_quick");
  }

  waitframe();
  if(isDefined(self)) {
    self StopRumble("orbital_laser_fire");
  }
}

playerAddNotifyCommands() {
  if(!IsBot(self)) {
    self NotifyOnPlayerCommand("SwitchVisionMode", "+actionslot 1");
    self NotifyOnPlayerCommand("ToggleControlState", "+activate");
    self NotifyOnPlayerCommand("ToggleControlCancel", "-activate");
    self NotifyOnPlayerCommand("ToggleControlState", "+usereload");
    self NotifyOnPlayerCommand("ToggleControlCancel", "-usereload");
    self NotifyOnPlayerCommand("StartFire", "+attack");
    self NotifyOnPlayerCommand("StartFire", "+attack_akimbo_accessible");
  }
}

playerRemoveNotifyCommands() {
  if(!IsBot(self)) {
    self NotifyOnPlayerCommandRemove("SwitchVisionMode", "+actionslot 1");
    self NotifyOnPlayerCommandRemove("ToggleControlState", "+activate");
    self NotifyOnPlayerCommandRemove("ToggleControlCancel", "-activate");
    self NotifyOnPlayerCommandRemove("ToggleControlState", "+usereload");
    self NotifyOnPlayerCommandRemove("ToggleControlCancel", "-usereload");
    self NotifyOnPlayerCommandRemove("StartFire", "+attack");
    self NotifyOnPlayerCommandRemove("StartFire", "+attack_akimbo_accessible");
  }
}
setVulcanVisionAndLightSetPerMap(delay) {
  self endon("disconnect");
  self endon("game_ended");
  self endon("OrbitalStrikeStreakComplete");

  wait(delay);

  if(isDefined(level.vulcanvisionset)) {
    self SetClientTriggerVisionSet(level.vulcanvisionset, 0);
  }

  if(isDefined(level.vulcanlightset)) {
    self LightSetForPlayer(level.vulcanlightset);
  }

  self maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

removeVulcanVisionAndLightSetPerMap(delay) {
  self SetClientTriggerVisionSet("", delay);
  self LightSetForPlayer("");
  self maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}