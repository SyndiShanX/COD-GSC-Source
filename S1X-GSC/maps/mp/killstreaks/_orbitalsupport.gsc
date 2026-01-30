/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_orbitalsupport.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

ORBITALSUPPORT_MEDIUM_STARTING_AMMO = 8;
ORBITALSUPPORT_BUDDY_MEDIUM_STARTING_AMMO = 6;
ORBITALSUPPORT_BUDDY_TIME_BONUS = 7;

CONST_ORBITALSUPPORT_MODULE_TIME_BONUS = 15;
CONST_ORBITALSUPPORT_105_RELOAD_TIME = 6;
CONST_ORBITALSUPPORT_105_RELOAD_TIME_UPGRADE = 4;
CONST_ORBITALSUPPORT_40_RELOAD_TIME = 3;
CONST_ORBITALSUPPORT_40_RELOAD_TIME_UPGRADE = 2;
CONST_ORBITALSUPPORT_40_BUDDY_RELOAD_TIME = 5;
CONST_ORBITALSUPPORT_40_BUDDY_RELOAD_TIME_UPGRADE = 3;
CONST_ORBITALSUPPORT_ROCKET_RELOAD_TIME = 6;
CONST_ORBITALSUPPORT_ROCKET_RELOAD_TIME_UPGRADE = 4;
CONST_ORBITALSUPPORT_RELOAD_MASH_TIME_RATIO = (50 / CONST_ORBITALSUPPORT_105_RELOAD_TIME);
CONST_ORBITALSUPPORT_CHATTER_TIME = 10;
CONST_ORBITALSUPPORT_SPEED = 123;
CONST_ORBITALSUPPORT_DURATION = 40;
CONST_ORBITALSUPPORT_HEIGHT = 9275;
CONST_ORBITALSUPPORT_RADIUS = 8000;

init() {
  level.orbitalsupportoverrides = spawnStruct();
  level.orbitalsupportoverrides.spawnOrigin = undefined;
  level.orbitalsupportoverrides.spawnAngle = undefined;
  level.orbitalsupportoverrides.spawnAngleMax = undefined;
  level.orbitalsupportoverrides.spawnAngleMin = undefined;
  level.orbitalsupportoverrides.spawnRadius = undefined;
  level.orbitalsupportoverrides.spawnHeight = undefined;
  level.orbitalsupportoverrides.speed = undefined;
  level.orbitalsupportoverrides.turretPitch = undefined;
  level.orbitalsupportoverrides.leftArc = undefined;
  level.orbitalsupportoverrides.rightArc = undefined;
  level.orbitalsupportoverrides.topArc = undefined;
  level.orbitalsupportoverrides.bottomArc = undefined;

  if(isDefined(level.orbitalSupportOverrideFunc)) {
    [[level.orbitalSupportOverrideFunc]]();
  }

  level.orbitalsupport_use_duration = CONST_ORBITALSUPPORT_DURATION;
  level.orbitalsupport_speed = CONST_ORBITALSUPPORT_SPEED;
  if(isDefined(level.orbitalsupportoverrides.speed)) {
    level.orbitalsupport_speed = level.orbitalsupportoverrides.speed;
  }

  minimapOrigins = getEntArray("minimap_corner", "targetname");
  ospOrigin = (0, 0, 0);

  if(miniMapOrigins.size) {
    ospOrigin = maps\mp\gametypes\_spawnlogic::findBoxCenter(miniMapOrigins[0].origin, miniMapOrigins[1].origin);
  }
  if(isDefined(level.orbitalsupportoverrides.spawnOrigin)) {
    ospOrigin = level.orbitalsupportoverrides.spawnOrigin;
  }

  level.ospRig = spawn("script_model", ospOrigin);
  level.ospRig setModel("c130_zoomrig");
  level.ospRig.angles = (0, 115, 0);
  level.ospRig hide();
  thread rotatePlane(level.orbitalsupport_speed);

  level._effect["orbitalsupport_cloud"] = LoadFX("vfx/cloud/orbitalsupport_cloud");

  level._effect["orbitalsupport_big_muzzle_flash"] = LoadFX("vfx/muzzleflash/orbitalsupport_105mm_wv");
  level._effect["orbitalsupport_medium_muzzle_flash"] = LoadFX("vfx/muzzleflash/orbitalsupport_40mm_wv");
  level._effect["orbitalsupport_rocket_explode_player"] = LoadFX("vfx/explosion/rocket_explosion_distant");

  level._effect["orbitalsupport_entry"] = LoadFX("vfx/vehicle/vehicle_osp_enter_clouds_parent");
  level._effect["orbitalsupport_entry_complete"] = LoadFX("vfx/vehicle/vehicle_osp_enter_shock");
  level._effect["vehicle_osp_jet"] = LoadFX("vfx/vehicle/vehicle_osp_jet");

  level._effect["vehicle_osp_jet_lg"] = LoadFX("vfx/vehicle/vehicle_osp_jet_lg");
  level._effect["vehicle_osp_rocket_marker"] = LoadFX("vfx/unique/vfx_marker_killstreak_guide");
  level._effect["vehicle_osp_jet_lg_trl"] = LoadFX("vfx/vehicle/vehicle_osp_jet_lg_trl");

  level._effect["orbitalsupport_entry_flash"] = LoadFX("vfx/vehicle/vehicle_osp_enter_flash");
  level._effect["orbitalsupport_explosion"] = LoadFX("vfx/explosion/vehicle_mil_blimp_explosion");

  level._effect["orbitalsupport_explosion_jet"] = LoadFX("vfx/explosion/vehicle_mil_blimp_explosion_jet");
  level._effect["orbitalsupport_light"] = LoadFX("vfx/lights/vehicle_osp_light");

  level.physicsSphereRadius["orbitalsupport_40mm_mp"] = 600;
  level.physicsSphereRadius["orbitalsupport_40mmbuddy_mp"] = 600;
  level.physicsSphereRadius["orbitalsupport_105mm_mp"] = 1000;

  level.physicsSphereForce["orbitalsupport_40mm_mp"] = 3.0;
  level.physicsSphereForce["orbitalsupport_40mmbuddy_mp"] = 3.0;
  level.physicsSphereForce["orbitalsupport_105mm_mp"] = 6.0;

  level.orbitalsupportInUse = false;

  level thread onOrbitalSupportPlayerConnect();

  level.killstreakFuncs["orbitalsupport"] = ::tryUseOrbitalSupport;

  level.killstreakWieldWeapons["orbitalsupport_105mm_mp"] = "orbitalsupport";
  level.killstreakWieldWeapons["orbitalsupport_40mm_mp"] = "orbitalsupport";
  level.killstreakWieldWeapons["orbitalsupport_40mmbuddy_mp"] = "orbitalsupport";
  level.killstreakWieldWeapons["orbitalsupport_big_turret_mp"] = "orbitalsupport";

  level.killstreakWieldWeapons["orbitalsupport_missile_mp"] = "orbitalsupport";

  level.orbitalsupport_chatter_timer = 0;
  level.orbitalsupport_buddy_chatter_timer = 0;

  SetDvarIfUninitialized("scr_paladin_center", "0");
  SetDvarIfUninitialized("scr_paladin_stay_on_ground", "0");
  SetDvarIfUninitialized("scr_paladin_timeout", "0");
  SetDvarIfUninitialized("scr_paladin_angle", 0);
  SetDvarIfUninitialized("scr_paladin_radius", 0);
  SetDvarIfUninitialized("scr_paladin_height", 0);
  SetDvarIfUninitialized("scr_paladin_rightArc", 0);
  SetDvarIfUninitialized("scr_paladin_leftArc", 0);
  SetDvarIfUninitialized("scr_paladin_topArc", 0);
  SetDvarIfUninitialized("scr_paladin_bottomArc", 0);

  game["dialog"]["assist_mp_paladin"] = "ks_paladin_joinreq";
  game["dialog"]["pilot_sup_mp_paladin"] = "pilot_sup_mp_paladin";
  game["dialog"]["pilot_aslt_mp_paladin"] = "pilot_aslt_mp_paladin";
  game["dialog"]["copilot_sup_mp_paladin"] = "copilot_sup_mp_paladin";
  game["dialog"]["copilot_aslt_mp_paladin"] = "copilot_aslt_mp_paladin";

  game["dialog"]["copilot_enemykill_mp_paladin"] = "copilot_enemykill_mp_paladin";
  game["dialog"]["copilot_marked_mp_paladin"] = "copilot_marked_mp_paladin";
}

tryUseOrbitalSupport(lifeId, modules) {
  if(isDefined(level.orbitalsupport_player) || level.orbitalsupportInUse) {
    self iPrintLnBold(&"MP_ORBITALSUPPORT_IN_USE");
    return false;
  }

  level.orbitalsupportInUse = true;
  self thread playerClearOrbitalSupportOnTeamChange();

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("paladin", false, undefined, 3.0);
  if(result != "success") {
    level.orbitalsupportInUse = false;
    return false;
  }
  self setUsingRemote("orbitalsupport");
  thread setOrbitalSupportPlayer(self, modules);

  self maps\mp\_matchdata::logKillstreakEvent("orbitalsupport", self.origin);

  level.orbitalsupport_planeModel.crashed = undefined;

  return true;
}

playerClearOrbitalSupportOnTeamChange() {
  self endon("rideKillstreakBlack");

  self waittill("joined_team");

  level.orbitalsupportInUse = false;
}

setOrbitalSupportPlayer(player, modules) {
  self endon("orbitalsupport_player_removed");
  self endon("disconnect");

  level.orbitalsupport_player = player;

  player playerSaveAngles();
  player orbitalsupport_spawn();

  level.orbitalsupport_planeModel.incomingMissile = false;
  level.orbitalsupport_planeModel.vehicleType = "paladin";
  level.orbitalsupport_planeModel thread maps\mp\gametypes\_damage::setEntityDamageCallback(3000, undefined, ::crashPlane, maps\mp\killstreaks\_aerial_utility::heli_ModifyDamage, true);
  level.orbitalsupport_planeModel.modules = modules;
  level.orbitalsupport_planeModel.hasRockets = array_contains(modules, "orbitalsupport_rockets");
  level.orbitalsupport_planeModel.hasTurret = array_contains(modules, "orbitalsupport_turret");
  level.orbitalsupport_planeModel.coopOffensive = array_contains(modules, "orbitalsupport_coop_offensive");
  level.orbitalsupport_planeModel.extraFlare = array_contains(modules, "orbitalsupport_flares");
  level.orbitalsupport_planeModel.ammoFeeder = array_contains(modules, "orbitalsupport_ammo");
  level.orbitalsupport_planemodel.player = player;

  thread testCrashing();

  if(level.orbitalsupport_planeModel.extraFlare) {
    numExtraFlares = 1;
  } else {
    numExtraFlares = 0;
  }
  level.orbitalsupport_planeModel.heliType = "osp";
  level.orbitalsupport_planeModel thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor(numExtraFlares);

  thread teamPlayerCardSplash("used_orbitalsupport", player);

  player startAC130();

  player maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();

  player maps\mp\killstreaks\_killstreaks::playerWaittillRideKillstreakComplete();

  player thread waitSetThermal(1.0);
  player thread waitDisableShadows(1.0);
  player thread setOSPVisionAndLightSetPerMap(1.25);
  player thread clouds();

  if(getDvarInt("camera_thirdPerson")) {
    player setThirdPersonDOF(false);
  }

  player playerSwitchToTurret(level.orbitalsupport_big_turret);
  player.controlled_orbitalsupport_turret = "medium";

  player.reloading_big_orbitalsupport_gun = false;
  player.reloading_medium_orbitalsupport_gun = false;
  player.reloading_rocket_orbitalsupport_gun = false;
  player.reloading_buddy_medium_orbitalsupport_gun = false;
  player.medium_orbitalsupport_ammo = ORBITALSUPPORT_MEDIUM_STARTING_AMMO;

  player thread removeOrbitalSupportPlayerOnDisconnect();
  player thread removeOrbitalSupportPlayerOnChangeTeams();
  player thread removeOrbitalSupportPlayerOnSpectate();
  player thread removeOrbitalSupportPlayerOnCrash();
  player thread removeOrbitalSupportPlayerOnGameCleanup();

  wait 1;
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  player playerSetAvailableWeaponsHUD();
  player SetClientOmnvar("ui_osp_weapon", 1);
  player SetClientOmnvar("ui_osp_toggle", 1);
  player thread waitSetStatic(0.1);

  player thread pulseOrbitalSupportReloadText();
  player thread shotFired();

  duration = level.orbitalsupport_use_duration;
  if(array_contains(modules, "orbitalsupport_time")) {
    duration += CONST_ORBITALSUPPORT_MODULE_TIME_BONUS;
  }

  if(GetDvar("scr_paladin_timeout", "0") != "0") {
    duration = GetDvarFloat("scr_paladin_timeout", duration);
  }

  player.orbitalsupport_endtime = GetTime() + (duration * 1000);
  player SetClientOmnvar("ui_warbird_countdown", player.orbitalsupport_endtime);
  self NotifyOnPlayerCommand("orbitalsupport_fire", "+attack");
  self NotifyOnPlayerCommand("orbitalsupport_fire", "+attack_akimbo_accessible");

  player thread changeWeapons();
  player thread fireBigOrbitalSupportGun();
  player thread fireMediumOrbitalSupportGun();
  player thread fireRocketOrbitalSupportGun();
  player thread showAerialMarker();

  player thread removeOrbitalSupportPlayerAfterTime(duration);
  player thread removeOrbitalSupportPlayerOnCommand();

  if(level.teamBased) {
    level thread handleCoopJoining(player);
  }

  level thread setupPlayersDuringStreak();

  thread testOSPFlares(player);
}

waitSetStatic(delay) {
  self endon("orbitalsupport_player_removed");
  self endon("disconnect");

  wait(delay);

  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
}

waitSetThermal(delay) {
  self endon("disconnect");
  level endon("orbitalsupport_player_removed");
  self endon("orbitalsupport_player_removed");

  wait(delay);

  self ThermalVisionFOFOverlayOn();

  paladinHeight = CONST_ORBITALSUPPORT_HEIGHT;

  if(isDefined(level.orbitalsupportoverrides.spawnHeight)) {
    paladinHeight = level.orbitalsupportoverrides.spawnHeight - level.mapCenter[2];
  }

  adsAperature = 0.3;
  adsFocalDistance = paladinHeight;
  normalAperature = 0.3;
  normalFocalDistance = paladinHeight * 0.75;
  focusSpeed = 20;
  aperatureSpeed = 30;
  self thread maps\mp\killstreaks\_aerial_utility::thermalVision("orbitalsupport_player_removed", adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed);
}

waitDisableShadows(delay) {
  self endon("disconnect");
  level endon("orbitalsupport_player_removed");
  self endon("orbitalsupport_player_removed");

  wait(delay);

  self SetShadowRendering(false);
}

setOSPVisionAndLightSetPerMap(delay) {
  self endon("disconnect");
  level endon("orbitalsupport_player_removed");

  wait(delay);

  if(isDefined(level.ospvisionset)) {
    self SetClientTriggerVisionSet(level.ospvisionset, 0);
  }

  if(isDefined(level.osplightset)) {
    self LightSetForPlayer(level.osplightset);
  }

  self maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

removeOSPVisionAndLightSetPerMap(delay) {
  self SetClientTriggerVisionSet("", delay);
  self LightSetForPlayer("");
  self maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}

removeOrbitalSupportPlayerOnCommand() {
  self endon("orbitalsupport_player_removed");

  button_hold_time = 0;

  while(true) {
    if(self UseButtonPressed()) {
      button_hold_time += 0.05;
      if(button_hold_time > 1.0) {
        if((isDefined(level.orbitalsupport_buddy) && level.orbitalsupport_buddy.joined == true) || !isDefined(level.orbitalsupport_buddy)) {
          level thread removeOrbitalSupportPlayer(self, false);
          return;
        }
      }
    } else {
      button_hold_time = 0;
    }
    wait(0.05);
  }
}

removeOrbitalSupportPlayerOnGameCleanup() {
  self endon("orbitalsupport_player_removed");

  level waittill("game_ended");

  level thread removeOrbitalSupportPlayer(self, false);
}

removeOrbitalSupportPlayerOnCrash() {
  self endon("orbitalsupport_player_removed");

  level.orbitalsupport_planeModel waittill("crashing");

  level thread removeOrbitalSupportPlayer(self, false);
}

removeOrbitalSupportPlayerOnDisconnect() {
  self endon("orbitalsupport_player_removed");

  self waittill("disconnect");

  level thread removeOrbitalSupportPlayer(self, true);
}

removeOrbitalSupportPlayerOnChangeTeams() {
  self endon("orbitalsupport_player_removed");

  self waittill("joined_team");

  level thread removeOrbitalSupportPlayer(self, false);
}

removeOrbitalSupportPlayerOnSpectate() {
  self endon("orbitalsupport_player_removed");

  self waittill_any("joined_spectators", "spawned");

  level thread removeOrbitalSupportPlayer(self, false);
}

removeOrbitalSupportPlayerAfterTime(removeDelay) {
  self endon("orbitalsupport_player_removed");

  if(self _hasPerk("specialty_blackbox") && isDefined(self.specialty_blackbox_bonus)) {
    removeDelay *= self.specialty_blackbox_bonus;
  }

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(removeDelay);

  if(isDefined(level.orbitalsupport_buddy)) {
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(ORBITALSUPPORT_BUDDY_TIME_BONUS);
  }

  level thread removeOrbitalSupportPlayer(self, false);
}

removeOrbitalSupportPlayer(player, disconnected) {
  player notify("orbitalsupport_player_removed");
  level notify("orbitalsupport_player_removed");

  waittillframeend;

  level.orbitalsupport_planemodel.player = undefined;

  if(isDefined(level.orbitalsupport_buddy)) {
    level.orbitalsupport_buddy thread removeOrbitalSupportBuddy(false);
  }

  if(!disconnected) {
    player playerResetOSPOmnvars();

    player NotifyOnPlayerCommandRemove("orbitalsupport_fire", "+attack");
    player NotifyOnPlayerCommandRemove("orbitalsupport_fire", "+attack_akimbo_accessible");
    if(!IsBot(player) && (level.orbitalsupport_planeModel.hasRockets || level.orbitalsupport_planeModel.hasTurret)) {
      player NotifyOnPlayerCommandRemove("switch_orbitalsupport_turret", "weapnext");
    }

    player RemoteControlTurretOff(level.orbitalsupport_big_turret);
    level.orbitalsupport_big_turret Hide();
    player Unlink();

    killstreakWeapon = getKillstreakWeapon("orbitalsupport");
    player TakeWeapon(killstreakWeapon);

    if(player isUsingRemote()) {
      player clearUsingRemote();
    }

    maps\mp\killstreaks\_aerial_utility::disableOrbitalThermal(player);
    player SetShadowRendering(true);
    player ThermalVisionFOFOverlayOff();
    player setBlurForPlayer(0, 0);
    player removeOSPVisionAndLightSetPerMap(1.5);
    player stopAC130();

    if(getDvarInt("camera_thirdPerson")) {
      player setThirdPersonDOF(true);
    }

    if(isDefined(player.darkScreenOverlay)) {
      player.darkScreenOverlay destroy();
    }

    player.reloading_big_orbitalsupport_gun = undefined;
    player.reloading_medium_orbitalsupport_gun = undefined;
    player.reloading_rocket_orbitalsupport_gun = undefined;
    player.reloading_buddy_medium_orbitalsupport_gun = undefined;

    player playerRestoreAngles();
  }

  if(isDefined(level.orbitalsupport_planeModel.crashed)) {
    level.orbitalsupport_player = undefined;
    return;
  }

  level.orbitalsupport_player = undefined;
  level.orbitalsupport_planeModel StopLoopSound();
  level.orbitalsupport_planeModel playSound("paladin_orbit_return");

  level.orbitalsupport_planemodel orbitalsupportExit();
}

cleanupOSPEnts() {
  level.orbitalsupport_planeModel stopLoopSound();
  if(isDefined(level.orbitalsupport_targetEnt)) {
    stopFXOnTag(getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetEnt, "tag_origin");
    level.orbitalsupport_targetEnt Delete();
  }

  if(isDefined(level.orbitalsupport_big_turret.muzzleFlashEnt)) {
    level.orbitalsupport_big_turret.muzzleFlashEnt Delete();
  }

  if(isDefined(level.orbitalsupport_big_turret.mediumMuzzleFlashEnt1)) {
    level.orbitalsupport_big_turret.mediumMuzzleFlashEnt1 Delete();
  }

  if(isDefined(level.orbitalsupport_big_turret.mediumMuzzleFlashEnt2)) {
    level.orbitalsupport_big_turret.mediumMuzzleFlashEnt2 Delete();
  }

  if(isDefined(level.orbitalsupport_big_turret.mediumMuzzleFlashEnt3)) {
    level.orbitalsupport_big_turret.mediumMuzzleFlashEnt3 Delete();
  }

  if(isDefined(level.orbitalsupport_buddy_turret.muzzleFlashEnt)) {
    level.orbitalsupport_buddy_turret.muzzleFlashEnt Delete();
  }

  level.orbitalsupport_big_turret turretDeleteSoundEnts();
  level.orbitalsupport_big_turret Delete();
  level.orbitalsupport_buddy_turret turretDeleteSoundEnts();
  level.orbitalsupport_buddy_turret Delete();
  if(isDefined(level.orbitalsupport_planeModel.farFlightSound)) {
    level.orbitalsupport_planeModel.farFlightSound StopLoopSound();
    level.orbitalsupport_planeModel.farFlightSound Delete();
  }
  if(isDefined(level.orbitalsupport_planeModel.closeFlightSound)) {
    level.orbitalsupport_planeModel.closeFlightSound StopLoopSound();
    level.orbitalsupport_planeModel.closeFlightSound Delete();
  }
  if(isDefined(level.orbitalsupport_planemodel.minimapIcon)) {
    level.orbitalsupport_planemodel.minimapIcon Delete();
  }
}

testCrashing() {
  level endon("orbitalsupport_player_removed");

  while(true) {
    waitframe();

    if(GetDvarInt("scr_paladin_crash", 0) == 0) {
      continue;
    }

    SetDvar("scr_paladin_crash", "0");

    level thread crashPlane();

    return;
  }
}

orbitalsupport_spawn() {
  minimapOrigins = getEntArray("minimap_corner", "targetname");
  orbitalsupportOrigin = (0, 0, 0);

  if(miniMapOrigins.size) {
    orbitalsupportOrigin = maps\mp\gametypes\_spawnlogic::findBoxCenter(miniMapOrigins[0].origin, miniMapOrigins[1].origin);
    orbitalsupportOrigin = (orbitalsupportOrigin[0], orbitalsupportOrigin[1], 0);
  }
  if(isDefined(level.orbitalsupportoverrides.spawnOrigin)) {
    orbitalsupportOrigin = level.orbitalsupportoverrides.spawnOrigin;
    orbitalsupportOrigin = (orbitalsupportOrigin[0], orbitalsupportOrigin[1], 0);
  }

  level.orbitalsupport_planeModel = spawn("script_model", orbitalsupportOrigin);
  level.orbitalsupport_planeModel.angles = (0, 0, 0);
  level.orbitalsupport_planeModel setModel("vehicle_mil_blimp_orbital_platform_ai");
  level.orbitalsupport_planeModel.owner = self;
  level.orbitalsupport_planeModel make_entity_sentient_mp(self.team);

  level.orbitalsupport_planeModel.minimapIcon = spawnPlane(self, "script_model", orbitalsupportOrigin, "compass_objpoint_ac130_friendly", "compass_objpoint_ac130_enemy");
  level.orbitalsupport_planeModel.minimapIcon setModel("tag_origin");
  level.orbitalsupport_planeModel.minimapIcon LinkToSynchronizedParent(level.orbitalsupport_planemodel, "tag_origin", (0, 0, 0), (0, 0, 0));

  level.orbitalsupport_planeModel setCanDamage(true);
  level.orbitalsupport_planeModel setCanRadiusDamage(true);
  level.orbitalsupport_planeModel.maxhealth = 2000;
  level.orbitalsupport_planeModel.health = level.orbitalsupport_planeModel.maxhealth;
  level.orbitalsupport_planemodel.showThreatMarker = false;

  level.orbitalsupport_planeModel setRandomOrbitalSupportStartPosition();

  level.orbitalsupport_big_turret = spawnOrbitalSupportTurret("orbitalsupport_big_turret_mp", "orbitalsupport_big_turret", "tag_orbitalsupport_biggun", false);
  level.orbitalsupport_buddy_turret = spawnOrbitalSupportTurret("orbitalsupport_buddy_turret_mp", "orbitalsupport_small_turret", "tag_orbitalsupport_mediumgun2", true);

  if(GetDvar("scr_paladin_debug_entry", "0") != "0") {
    debugEntrance();
  }

  level.orbitalsupport_planeModel thread moveOrbitalSupportToDestination();
}

debugEntrance() {
  while(GetDvar("scr_paladin_debug_entry", "0") != "0") {
    level.orbitalsupport_planeModel moveOrbitalSupportToDestination(false);

    wait 1;

    level.orbitalsupport_planemodel notify("stopEffects");

    stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
    stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
    waitframe();
    stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
    stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
    level.orbitalsupport_planemodel ScriptModelClearAnim();

    wait 1;

    level.orbitalsupport_planemodel.origin += (0, 0, 65000);
  }
}

spawnOrbitalSupportTurret(turretweaponinfo, modelname, linktotag, isBuddy) {
  spawned_turret = SpawnTurret("misc_turret", level.orbitalsupport_planeModel GetTagOrigin(linktotag), turretweaponinfo, false);
  spawned_turret.angles = level.orbitalsupport_planeModel GetTagAngles(linktotag);
  spawned_turret setModel(modelname);
  spawned_turret SetDefaultDropPitch(45);
  spawned_turret LinkTo(level.orbitalsupport_planeModel, linktotag, (0, 0, 0), (0, 0, 0));
  spawned_turret.owner = undefined;
  spawned_turret.health = 99999;
  spawned_turret.maxHealth = 1000;
  spawned_turret.damageTaken = 0;
  spawned_turret.stunned = false;
  spawned_turret.stunnedTime = 0.0;
  spawned_turret setCanDamage(false);
  spawned_turret setCanRadiusDamage(false);
  spawned_turret TurretFireDisable();
  numSounds = 4;
  if(isBuddy) {
    numSounds = 1;
  }
  spawned_turret thread turretSpawnSoundEnts(numSounds, linktotag);

  return spawned_turret;
}

turretSpawnSoundEnts(num, linktotag) {
  self.soundEnts = [];
  for(i = 0; i < num; i++) {
    waitframe();
    soundEnt = spawn("script_model", self.origin);
    soundEnt setModel("tag_origin");
    soundEnt LinkTo(level.orbitalsupport_planeModel, linktotag, (0, 0, 0), (0, 0, 0));
    self.soundEnts[self.soundEnts.size] = soundEnt;
  }
}

pulseOrbitalSupportReloadText() {
  level endon("orbitalsupport_player_removed");
  self endon("orbitalsupport_player_removed");
  self endon("switch_orbitalsupport_turret");

  self SetClientOmnvar("ui_osp_reload_bitfield", 0);

  big_reload_bitfield_value = 1;
  medium_reload_bitfield_value = 2;
  rocket_reload_bitfield_value = 4;

  while(true) {
    bitfieldValue = 0;

    if(self.reloading_big_orbitalsupport_gun) {
      bitfieldValue += big_reload_bitfield_value;
    }

    if(self.reloading_medium_orbitalsupport_gun || self.reloading_buddy_medium_orbitalsupport_gun) {
      bitfieldValue += medium_reload_bitfield_value;
    }

    if(self.reloading_rocket_orbitalsupport_gun) {
      bitfieldValue += rocket_reload_bitfield_value;
    }

    self SetClientOmnvar("ui_osp_reload_bitfield", bitfieldValue);

    wait(0.05);
  }
}

changeWeapons() {
  self endon("orbitalsupport_player_removed");

  if(IsBot(self)) {
    return;
  }

  hasRockets = level.orbitalsupport_planeModel.hasRockets;
  hasBig = level.orbitalsupport_planeModel.hasTurret;

  if(!hasRockets && !hasBig) {
    return;
  }

  self NotifyOnPlayerCommand("switch_orbitalsupport_turret", "weapnext");

  wait(0.05);

  self SetClientOmnvar("ui_osp_weapon", 1);

  while(true) {
    self waittill("switch_orbitalsupport_turret");

    if(self.controlled_orbitalsupport_turret == "medium") {
      if(hasRockets) {
        self playerSwitchToRocketTurret();
      } else {
        self playerSwitchToBigTurret();
      }
    } else if(self.controlled_orbitalsupport_turret == "rocket") {
      if(hasBig) {
        self playerSwitchToBigTurret();
      } else {
        self playerSwitchToMediumTurret();
      }
    } else if(self.controlled_orbitalsupport_turret == "big") {
      self playerSwitchToMediumTurret();
    }

    self PlayLocalSound("paladin_weapon_cycle_plr");
  }
}

playerSetAvailableWeaponsHUD() {
  hasRockets = level.orbitalsupport_planeModel.hasRockets;
  hasBig = level.orbitalsupport_planeModel.hasTurret;

  weaponValue = 1;
  if(hasBig) {
    weaponValue = weaponValue + 2;
  }
  if(hasRockets) {
    weaponValue = weaponValue + 4;
  }
  self SetClientOmnvar("ui_osp_avail_weapons", weaponValue);
}

playerSwitchToTurret(turret) {
  self Unlink();
  level thread handleTurretSoundEnt(turret);

  if(GetDvar("scr_paladin_stay_on_ground", "0") != "0") {
    return;
  }

  rightArc = 25;
  leftArc = 25;
  topArc = -25;
  bottomArc = 60;

  if(isDefined(level.orbitalsupportoverrides.rightArc)) {
    rightArc = level.orbitalsupportoverrides.rightArc;
  }

  if(isDefined(level.orbitalsupportoverrides.leftArc)) {
    leftArc = level.orbitalsupportoverrides.leftArc;
  }

  if(isDefined(level.orbitalsupportoverrides.topArc)) {
    topArc = level.orbitalsupportoverrides.topArc;
  }

  if(isDefined(level.orbitalsupportoverrides.bottomArc)) {
    bottomArc = level.orbitalsupportoverrides.bottomArc;
  }

  if(GetDvarFloat("scr_paladin_rightArc", 0) != 0) {
    rightArc = GetDvarFloat("scr_paladin_rightArc");
  }
  if(GetDvarFloat("scr_paladin_leftArc", 0) != 0) {
    leftArc = GetDvarFloat("scr_paladin_leftArc");
  }
  if(GetDvarFloat("scr_paladin_topArc", 0) != 0) {
    topArc = GetDvarFloat("scr_paladin_topArc");
  }
  if(GetDvarFloat("scr_paladin_bottomArc", 0) != 0) {
    bottomArc = GetDvarFloat("scr_paladin_bottomArc");
  }

  self PlayerLinkWeaponViewToDelta(turret, "tag_player", 0, rightArc, leftArc, topArc, bottomArc, true);
  self PlayerLinkedSetUseBaseAngleForViewClamp(true);

  pitch = 45;
  if(isDefined(level.orbitalsupportoverrides.turretPitch)) {
    pitch = level.orbitalsupportoverrides.turretPitch;
  }

  self RemoteControlTurret(turret, pitch);
}

handleTurretSoundEnt(turret) {
  turret endon("death");

  turret notify("startHandleSoundEnt");
  turret endon("startHandleSoundEnt");

  if(GetDvar("scr_paladin_stay_on_ground", "0") != "0") {
    return;
  }

  foreach(soundEnt in turret.soundEnts) {
    soundEnt Hide();
  }

  foreach(player in level.players) {
    if(isDefined(turret.owner) && turret.owner != player) {
      foreach(soundEnt in turret.soundEnts) {
        soundEnt ShowToPlayer(player);
      }
    }
  }

  while(true) {
    level waittill("connected", player);

    foreach(soundEnt in turret.soundEnts) {
      soundEnt ShowToPlayer(player);
    }
  }
}

playerSwitchToBigTurret() {
  self.controlled_orbitalsupport_turret = "big";
  self SetClientOmnvar("ui_osp_weapon", 0);
  self thread pulseOrbitalSupportReloadText();
  if(isDefined(level.orbitalsupport_targetEnt)) {
    stopFXOnTag(getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetEnt, "tag_origin");
  }
}

playerSwitchToRocketTurret() {
  self.controlled_orbitalsupport_turret = "rocket";
  self SetClientOmnvar("ui_osp_weapon", 3);
  self thread pulseOrbitalSupportReloadText();
  if(isDefined(level.orbitalsupport_targetEnt)) {
    playFXOnTag(getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetEnt, "tag_origin");
  }
}

playerSwitchToMediumTurret() {
  self.controlled_orbitalsupport_turret = "medium";
  self SetClientOmnvar("ui_osp_weapon", 1);
  self thread pulseOrbitalSupportReloadText();
  if(isDefined(level.orbitalsupport_targetEnt)) {
    stopFXOnTag(getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetEnt, "tag_origin");
  }
}

playerGetTurretEndpoint(isBuddy) {
  if(GetDvar("scr_paladin_stay_on_ground", "0") != "0" && self == level.player) {
    start = self getEye();
    dir = anglesToForward(self GetPlayerAngles());
    end = start + (dir * 3000);
    trace = bulletTrace(start, end, false, self);
    if(trace["fraction"] < 1) {
      return trace["position"];
    }
  }

  if(!isDefined(isBuddy) || !isBuddy) {
    return level.orbitalsupport_big_turret GetTagOrigin("tag_player") + anglesToForward(level.orbitalsupport_big_turret GetTagAngles("tag_player")) * 20000;
  } else {
    return level.orbitalsupport_buddy_turret GetTagOrigin("tag_player") + anglesToForward(level.orbitalsupport_buddy_turret GetTagAngles("tag_player")) * 20000;
  }
}

fireBigOrbitalSupportGun() {
  self endon("orbitalsupport_player_removed");

  if(!level.orbitalsupport_planeModel.ammoFeeder) {
    reloadTime = CONST_ORBITALSUPPORT_105_RELOAD_TIME;
  } else {
    reloadTime = CONST_ORBITALSUPPORT_105_RELOAD_TIME_UPGRADE;
  }

  while(!isDefined(level.orbitalsupport_planeModel.paladinflying)) {
    waitframe();
  }

  if(!isDefined(level.orbitalsupport_big_turret.muzzleFlashEnt)) {
    level.orbitalsupport_big_turret.muzzleFlashEnt = spawnMuzzleFlashEnt(level.orbitalsupport_big_turret, "tag_missile1", level.orbitalsupport_player);
  }

  while(true) {
    self.reloading_big_orbitalsupport_gun = false;

    self waittill("orbitalsupport_fire");

    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }

    if(self.controlled_orbitalsupport_turret == "big") {
      endpoint = self playerGetTurretEndpoint();
      startpoint = level.orbitalsupport_big_turret GetTagOrigin("tag_missile1");
      bullet_ent = MagicBullet("orbitalsupport_105mm_mp", startpoint, endpoint, self);
      bullet_ent.vehicle_fired_from = level.orbitalsupport_planeModel;
      level.orbitalsupport_planeModel playSound("paladin_cannon_snap");
      bullet_ent playSound("orbitalsupport_105mm_proj_travel");

      playFXOnTag(getfx("orbitalsupport_big_muzzle_flash"), level.orbitalsupport_big_turret.muzzleFlashEnt, "tag_origin");

      self playRumbleOnEntity("ac130_105mm_fire");
      self PlayLocalSound("paladin_cannon_reload");
      Earthquake(0.3, 1, level.orbitalsupport_planeModel.origin, 1000);

      self.reloading_big_orbitalsupport_gun = true;

      wait reloadTime;
    }
  }
}

fireMediumOrbitalSupportGun() {
  self endon("orbitalsupport_player_removed");

  while(!isDefined(level.orbitalsupport_planeModel.paladinflying)) {
    waitframe();
  }

  if(!isDefined(level.orbitalsupport_big_turret.muzzleFlashEnt)) {
    level.orbitalsupport_big_turret.muzzleFlashEnt = spawnMuzzleFlashEnt(level.orbitalsupport_big_turret, "tag_missile1", level.orbitalsupport_player);
  }

  while(true) {
    self.reloading_medium_orbitalsupport_gun = false;

    if(!level.orbitalsupport_planeModel.ammoFeeder) {
      reloadTime = CONST_ORBITALSUPPORT_40_RELOAD_TIME;
    } else {
      reloadTime = CONST_ORBITALSUPPORT_40_RELOAD_TIME_UPGRADE;
    }

    if(self.controlled_orbitalsupport_turret == "medium" && self AttackButtonPressed() && !isDefined(level.hostMigrationTimer)) {
      startpoint = level.orbitalsupport_big_turret GetTagOrigin("tag_missile1");
      endpoint = self playerGetTurretEndpoint();
      level.orbitalsupport_planeModel playSound("paladin_mgun_burst_plr");
      bullet_ent = MagicBullet("orbitalsupport_40mm_mp", startpoint, endpoint, self);
      bullet_ent.vehicle_fired_from = level.orbitalsupport_planeModel;
      bullet_ent playSound("paladin_mgun_shot_dist_npc");

      playFXOnTag(getfx("orbitalsupport_medium_muzzle_flash"), level.orbitalsupport_big_turret.muzzleFlashEnt, "tag_origin");

      bullettraceresults = bulletTrace(startpoint, endpoint, false);

      wait(0.05);

      Earthquake(0.1, 0.5, level.orbitalsupport_planeModel.origin, 1000);

      fireMediumOrbitalSupportVolley(bullettraceresults["position"], "orbitalsupport_40mm_mp");

      fireMediumOrbitalSupportVolley(bullettraceresults["position"], "orbitalsupport_40mm_mp");

      fireMediumOrbitalSupportVolley(bullettraceresults["position"], "orbitalsupport_40mm_mp");

      self.medium_orbitalsupport_ammo--;
      if(self.medium_orbitalsupport_ammo <= 0) {
        self.reloading_medium_orbitalsupport_gun = true;

        wait reloadTime;
        self.medium_orbitalsupport_ammo = ORBITALSUPPORT_MEDIUM_STARTING_AMMO;
      }
    }
    wait(0.05);
  }
}

fireBuddyThreatGrenades() {
  self endon("orbitalsupport_player_removed");

  Assert(level.orbitalsupport_buddy_turret.soundEnts.size > 0);
  soundent = level.orbitalsupport_buddy_turret.soundEnts[0];

  while(true) {
    self waittill("orbitalsupport_fire");

    self maps\mp\killstreaks\_aerial_utility::playerFakeShootPaintMissile(soundEnt);

    wait 2;
  }
}

fireBuddyMediumOrbitalSupportGun() {
  self endon("orbitalsupport_player_removed");

  buddy_orbitalsupport_ammo = ORBITALSUPPORT_BUDDY_MEDIUM_STARTING_AMMO;
  self.reloading_buddy_medium_orbitalsupport_gun = false;
  self.controlled_orbitalsupport_turret = "buddy";
  self thread pulseOrbitalSupportReloadText();

  if(isDefined(level.orbitalsupport_buddy_turret.muzzleFlashEnt)) {
    level.orbitalsupport_buddy_turret.muzzleFlashEnt Delete();
  }
  level.orbitalsupport_buddy_turret.muzzleFlashEnt = spawnMuzzleFlashEnt(level.orbitalsupport_buddy_turret, "tag_missile1", level.orbitalsupport_buddy);

  while(true) {
    self.reloading_buddy_medium_orbitalsupport_gun = false;

    if(!level.orbitalsupport_planeModel.ammoFeeder) {
      reloadTime = CONST_ORBITALSUPPORT_40_BUDDY_RELOAD_TIME;
    } else {
      reloadTime = CONST_ORBITALSUPPORT_40_BUDDY_RELOAD_TIME_UPGRADE;
    }

    if(self AttackButtonPressed()) {
      startpoint = level.orbitalsupport_buddy_turret GetTagOrigin("tag_missile1");
      endpoint = self playerGetTurretEndpoint(true);
      level.orbitalsupport_planeModel playSound("paladin_mgun_burst_plr");
      bullet_ent = MagicBullet("orbitalsupport_40mmbuddy_mp", startpoint, endpoint, self);
      bullet_ent.vehicle_fired_from = level.orbitalsupport_planeModel;
      bullet_ent playSound("paladin_mgun_shot_dist_npc");

      playFXOnTag(getfx("orbitalsupport_medium_muzzle_flash"), level.orbitalsupport_buddy_turret.muzzleFlashEnt, "tag_origin");

      bullettraceresults = bulletTrace(startpoint, endpoint, false);

      waitframe();
      Earthquake(0.1, 0.5, level.orbitalsupport_planeModel.origin, 1000);

      fireMediumOrbitalSupportVolley(bullettraceresults["position"], "orbitalsupport_40mmbuddy_mp");

      fireMediumOrbitalSupportVolley(bullettraceresults["position"], "orbitalsupport_40mmbuddy_mp");

      fireMediumOrbitalSupportVolley(bullettraceresults["position"], "orbitalsupport_40mmbuddy_mp");

      buddy_orbitalsupport_ammo--;
      if(buddy_orbitalsupport_ammo <= 0) {
        self.reloading_buddy_medium_orbitalsupport_gun = true;

        wait reloadTime;
        buddy_orbitalsupport_ammo = ORBITALSUPPORT_BUDDY_MEDIUM_STARTING_AMMO;
      }
    }
    wait(0.05);
  }
}

fireMediumOrbitalSupportVolley(endpoint_coords, weaponName) {
  startpoint = level.orbitalsupport_planemodel GetTagOrigin("tag_orbitalsupport_mediumgun1");
  randFloatX = RandomFloat(400) - 200;
  randFloatY = RandomFloat(400) - 200;
  bullet_ent = MagicBullet(weaponName, startpoint, (endpoint_coords[0] + randFloatX, endpoint_coords[1] + randFloatY, endpoint_coords[2]), self);
  bullet_ent.vehicle_fired_from = level.orbitalsupport_planeModel;
  bullet_ent playSound("paladin_mgun_shot_dist_npc");
  self playRumbleOnEntity("ac130_25mm_fire");

  if(!isDefined(level.orbitalsupport_big_turret.mediumMuzzleFlashEnt1)) {
    level.orbitalsupport_big_turret.mediumMuzzleFlashEnt1 = spawnMuzzleFlashEnt(level.orbitalsupport_planemodel, "tag_orbitalsupport_mediumgun1", level.orbitalsupport_player);
  }
  playFXOnTag(getfx("orbitalsupport_medium_muzzle_flash"), level.orbitalsupport_big_turret.mediumMuzzleFlashEnt1, "tag_origin");
  wait(0.05);

  startpoint = level.orbitalsupport_planemodel GetTagOrigin("tag_orbitalsupport_mediumgun0");
  randFloatX = RandomFloat(400) - 200;
  randFloatY = RandomFloat(400) - 200;
  bullet_ent = MagicBullet(weaponName, startpoint, (endpoint_coords[0] + randFloatX, endpoint_coords[1] + randFloatY, endpoint_coords[2]), self);
  bullet_ent.vehicle_fired_from = level.orbitalsupport_planeModel;
  bullet_ent playSound("paladin_mgun_shot_dist_npc");
  self playRumbleOnEntity("ac130_25mm_fire");

  if(!isDefined(level.orbitalsupport_big_turret.mediumMuzzleFlashEnt2)) {
    level.orbitalsupport_big_turret.mediumMuzzleFlashEnt2 = spawnMuzzleFlashEnt(level.orbitalsupport_planemodel, "tag_orbitalsupport_mediumgun0", level.orbitalsupport_player);
  }
  playFXOnTag(getfx("orbitalsupport_medium_muzzle_flash"), level.orbitalsupport_big_turret.mediumMuzzleFlashEnt2, "tag_origin");
  wait(0.05);

  startpoint = level.orbitalsupport_planemodel GetTagOrigin("tag_orbitalsupport_mediumgun3");
  randFloatX = RandomFloat(400) - 200;
  randFloatY = RandomFloat(400) - 200;
  bullet_ent = MagicBullet(weaponName, startpoint, (endpoint_coords[0] + randFloatX, endpoint_coords[1] + randFloatY, endpoint_coords[2]), self);
  bullet_ent.vehicle_fired_from = level.orbitalsupport_planeModel;
  bullet_ent playSound("paladin_mgun_shot_dist_npc");
  self playRumbleOnEntity("ac130_25mm_fire");

  if(!isDefined(level.orbitalsupport_big_turret.mediumMuzzleFlashEnt3)) {
    level.orbitalsupport_big_turret.mediumMuzzleFlashEnt3 = spawnMuzzleFlashEnt(level.orbitalsupport_planemodel, "tag_orbitalsupport_mediumgun3", level.orbitalsupport_player);
  }
  playFXOnTag(getfx("orbitalsupport_medium_muzzle_flash"), level.orbitalsupport_big_turret.mediumMuzzleFlashEnt3, "tag_origin");
  wait(0.05);
}

random_vector(num) {
  return (RandomFloat(num) - num * 0.5, RandomFloat(num) - num * 0.5, RandomFloat(num) - num * 0.5);
}

fireRocketOrbitalSupportGun() {
  self endon("orbitalsupport_player_removed");

  rocketClip = 3;
  remainingRocketShots = rocketClip;

  self SetClientOmnvar("ui_osp_rockets", remainingRocketShots);

  if(!level.orbitalsupport_planeModel.ammoFeeder) {
    reloadTime = CONST_ORBITALSUPPORT_ROCKET_RELOAD_TIME;
  } else {
    reloadTime = CONST_ORBITALSUPPORT_ROCKET_RELOAD_TIME_UPGRADE;
  }

  thread updateShootingLocation();

  while(!isDefined(level.orbitalsupport_planeModel.paladinflying)) {
    waitframe();
  }

  while(true) {
    self.reloading_rocket_orbitalsupport_gun = false;

    if(self.controlled_orbitalsupport_turret == "rocket" && self AttackButtonPressed() && !isDefined(level.hostMigrationTimer)) {
      Earthquake(0.3, 1, level.orbitalsupport_planeModel.origin, 1000);
      playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], level.orbitalsupport_big_turret, "tag_missile1");

      missile_tag_origin = level.orbitalsupport_big_turret GetTagOrigin("tag_missile1");
      player_forward = VectorNormalize(anglesToForward(self GetPlayerAngles()));
      osp_velocity = VectorNormalize(anglesToForward(level.orbitalsupport_planeModel GetTagAngles("tag_origin")));

      for(i = 0; i < 4; i++) {
        fire_direction = player_forward + (0, 0, .4) + random_vector(1);

        missile = MagicBullet("orbitalsupport_missile_mp", missile_tag_origin, missile_tag_origin + fire_direction, self);
        missile.vehicle_fired_from = level.orbitalsupport_planeModel;

        self thread playerFireSounds("paladin_missile_shot_2d", "paladin_missile_shot_3d", false, i);
        self PlayRumbleOnEntity("ac130_40mm_fire");

        missile Missile_SetTargetEnt(level.orbitalsupport_targetEnt);
        missile Missile_SetFlightmodeDirect();
        missile thread missilePlayExplodeEffectForPlayer(self);

        wait 0.1;
      }

      remainingRocketShots--;
      self SetClientOmnvar("ui_osp_rockets", remainingRocketShots);

      if(remainingRocketShots == 0) {
        self.reloading_rocket_orbitalsupport_gun = true;
        thread rocketReloadSound(reloadTime);

        wait reloadTime;
        remainingRocketShots = rocketClip;
        self SetClientOmnvar("ui_osp_rockets", remainingRocketShots);
        self notify("rocketReloadComplete");
        continue;
      } else {
        wait 1;
      }
    }
    waitframe();
  }
}

missilePlayExplodeEffectForPlayer(player) {
  player endon("disconnect");
  player endon("orbitalsupport_player_removed");

  self waittill("explode", location);

  fxObj = SpawnFXForClient(getfx("orbitalsupport_rocket_explode_player"), location, player);
  TriggerFX(fxObj);

  wait 5;

  fxObj Delete();
}

updateShootingLocation() {
  self endon("orbitalsupport_player_removed");

  level.orbitalsupport_targetEnt = spawn("script_model", (0, 0, 0));
  level.orbitalsupport_targetEnt setModel("tag_origin");
  level.orbitalsupport_big_turret TurretSetGroundAimEntity(level.orbitalsupport_targetEnt);

  while(true) {
    startpoint = level.orbitalsupport_big_turret GetTagOrigin("tag_player");
    endpoint = level.orbitalsupport_big_turret GetTagOrigin("tag_player") + anglesToForward(level.orbitalsupport_big_turret GetTagAngles("tag_player")) * 20000;
    trace = bulletTrace(startpoint, endpoint, false, level.orbitalsupport_big_turret);

    point = trace["position"];

    level.orbitalsupport_targetEnt.origin = point;
    /#		
    if(GetDvar("scr_paladin_stay_on_ground", "0") != "0" && self == level.player) {
      start = self getEye();
      dir = anglesToForward(self GetPlayerAngles());
      end = start + (dir * 3000);
      trace = bulletTrace(start, end, false, self);
      if(trace["fraction"] < 1) {
        level.orbitalsupport_targetEnt.origin = trace["position"];
      }
    }

    waitframe();
  }
}

rocketReloadSound(reload_time) {
  self endon("rocketReloadComplete");
  self endon("orbitalsupport_player_removed");

  missile_count = 3;

  self PlayLocalSound("warbird_missile_reload_bed");

  wait(0.5);

  while(true) {
    self PlayLocalSound("warbird_missile_reload");
    wait(reload_time / missile_count);
  }
}

showAerialMarker() {
  level.orbitalsupport_planemodel endon("death");

  while(!isDefined(level.orbitalsupport_planeModel.paladinflying)) {
    waitframe();
  }

  level.orbitalsupport_planemodel.showThreatMarker = true;
  level.orbitalsupport_planeModel thread maps\mp\killstreaks\_killstreaks::updateAerialKillStreakMarker();

  level.orbitalsupport_planemodel waittill_either("crashing", "leaving");

  level.orbitalsupport_planemodel.showThreatMarker = false;
  level.orbitalsupport_planeModel thread maps\mp\killstreaks\_killstreaks::updateAerialKillStreakMarker();
}

clouds() {
  self endon("orbitalsupport_player_removed");

  wait 6;
  clouds_create();
  while(true) {
    wait(randomfloatrange(40, 80));
    clouds_create();
  }
}

clouds_create() {
  if((isDefined(level.playerWeapon)) && (issubstr(tolower(level.playerWeapon), "25"))) {
    return;
  }
  playfxontagforclients(level._effect["orbitalsupport_cloud"], level.orbitalsupport_planeModel, "tag_player", level.orbitalsupport_player);
}

shotFired() {
  self endon("orbitalsupport_player_removed");

  while(true) {
    self waittill("projectile_impact", weaponName, position, radius);

    if(issubstr(tolower(weaponName), "105")) {
      earthquake(0.4, 1.0, position, 3500);
    } else if(issubstr(tolower(weaponName), "40")) {
      earthquake(0.2, 0.5, position, 2000);
    } else if(weaponName == "orbitalsupport_missile_mp") {
      earthquake(0.3, 0.5, position, 2000);
    }

    if(getIntProperty("ac130_ragdoll_deaths", 0)) {
      thread shotFiredPhysicsSphere(position, weaponName);
    }

    wait 0.05;
  }
}

shotFiredPhysicsSphere(center, weapon) {
  wait 0.1;
  physicsExplosionSphere(center, level.physicsSphereRadius[weapon], level.physicsSphereRadius[weapon] / 2, level.physicsSphereForce[weapon]);
}

crashPlane(attacker, weapon, meansOfDeath, damage) {
  level.orbitalsupport_planeModel notify("crashing");
  level.orbitalsupport_planeModel.crashed = true;

  level.orbitalsupport_planeModel maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "paladin_destroyed", undefined, "callout_destroyed_orbitalsupport", true);

  thread crashFX();

  level.orbitalsupport_planemodel StopSounds();
  playSoundAtPos(level.orbitalsupport_planemodel.origin, "paladin_ground_death");

  waitframe();

  cleanupOSPEnts();
  level.orbitalsupport_planemodel Delete();
  level.orbitalsupportInUse = false;
}

crashFX() {
  tag_engine_b = getOSPTagInfo("TAG_FX_ENGINE_B");
  tag_origin = getOSPTagInfo("tag_origin");
  tag_belly = getOSPTagInfo("tag_light_belly");
  tag_engine_L1 = getOSPTagInfo("TAG_FX_ENGINE_L_1");
  tag_engine_L2 = getOSPTagInfo("TAG_FX_ENGINE_L_2");
  tag_engine_R1 = getOSPTagInfo("TAG_FX_ENGINE_R_1");
  tag_engine_R2 = getOSPTagInfo("TAG_FX_ENGINE_R_2");

  playFX(getfx("orbitalsupport_explosion"), tag_origin.origin, tag_belly.dir);
  playFX(getfx("orbitalsupport_explosion_jet"), tag_engine_L1.origin, tag_engine_L1.dir);
  playFX(getfx("orbitalsupport_explosion_jet"), tag_engine_L2.origin, tag_engine_L2.dir);
  wait(.05);
  playFX(getfx("orbitalsupport_explosion_jet"), tag_engine_R1.origin, tag_engine_R1.dir);
  playFX(getfx("orbitalsupport_explosion_jet"), tag_engine_R2.origin, tag_engine_R2.dir);
}

getOSPTagInfo(tagName) {
  info = spawnStruct();
  info.origin = level.orbitalsupport_planemodel GetTagOrigin(tagName);
  info.dir = anglesToForward(level.orbitalsupport_planemodel GetTagAngles(tagName));
  return info;
}

handleCoopJoining(player) {
  splashRef = "orbitalsupport_coop_defensive";
  joinText = &"MP_JOIN_ORBITALSUPPORT_DEF";
  buddyJoinedVO = "pilot_sup_mp_paladin";
  joinedVO = "copilot_sup_mp_paladin";
  if(level.orbitalsupport_planeModel.coopOffensive) {
    splashRef = "orbitalsupport_coop_offensive";
    joinText = &"MP_JOIN_ORBITALSUPPORT_OFF";
    buddyJoinedVO = "pilot_aslt_mp_paladin";
    joinedVO = "copilot_aslt_mp_paladin";
  }

  while(true) {
    id = maps\mp\killstreaks\_coop_util::promptForStreakSupport(player.team, joinText, splashRef, "assist_mp_paladin", buddyJoinedVO, player, joinedVO);

    level thread watchForJoin(id, player);

    result = waittillPromptComplete("orbitalsupport_buddy_added");

    maps\mp\killstreaks\_coop_util::stopPromptForStreakSupport(id);

    if(!isDefined(result)) {
      return;
    }

    result = waittillPromptComplete("orbitalsupport_buddy_removed");

    if(!isDefined(result)) {
      return;
    }

    waittillframeend;
  }
}

waittillPromptComplete(text) {
  level endon("orbitalsupport_player_removed");

  level waittill(text);

  return true;
}

watchForJoin(id, player) {
  level endon("orbitalsupport_player_removed");

  buddy = maps\mp\killstreaks\_coop_util::waittillBuddyJoinedStreak(id);

  buddy thread setOrbitalSupportBuddy(player);
}

onOrbitalSupportPlayerConnect() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    player.orbitalsupport_hold_time = 0;
  }
}

setOrbitalSupportBuddy(player) {
  self endon("orbitalsupport_player_removed");

  level.orbitalsupport_buddy = self;
  level.orbitalsupport_buddy.joined = false;
  level.orbitalsupport_buddy_chatter_timer = 0;
  level notify("orbitalsupport_buddy_added");

  player playerSaveAngles();

  setupFlightSounds();

  level thread teamPlayerCardSplash("joined_orbitalsupport", self);

  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(false);
  }

  self thread PlayerDoRideKillstreak();
  self waittill("initRideKillstreak_complete", success);
  if(!success) {
    return;
  }

  self setUsingRemote("orbitalsupport");
  self startAC130();
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();

  self playerSwitchToTurret(level.orbitalsupport_buddy_turret);

  self thread waitSetStatic(0.1);
  self thread waitSetThermal(1.0);
  self thread waitDisableShadows(1.0);
  self thread setOSPVisionAndLightSetPerMap(1.25);

  self thread clouds();

  self.reloading_big_orbitalsupport_gun = false;
  self.reloading_medium_orbitalsupport_gun = false;
  self.reloading_rocket_orbitalsupport_gun = false;
  self.reloading_buddy_medium_orbitalsupport_gun = false;

  if(isDefined(level.orbitalsupport_planeModel) && level.orbitalsupport_planeModel.coopOffensive) {
    self SetClientOmnvar("ui_osp_avail_weapons", 1);
    self SetClientOmnvar("ui_osp_weapon", 1);
    self thread fireBuddyMediumOrbitalSupportGun();
  } else {
    self NotifyOnPlayerCommand("orbitalsupport_fire", "+attack");
    self NotifyOnPlayerCommand("orbitalsupport_fire", "+attack_akimbo_accessible");
    self SetClientOmnvar("ui_osp_weapon", 4);
    self thread fireBuddyThreatGrenades();
  }

  self thread removeOrbitalSupportBuddyOnDisconnect();
  self thread removeOrbitalSupportBuddyOnChangeTeams();
  self thread removeOrbitalSupportBuddyOnSpectate();
  if(!IsBot(self)) {
    self thread removeOrbitalSupportBuddyOnCommand();
  }

  wait(0.5);
  level.orbitalsupport_buddy.joined = true;
  self SetClientOmnvar("ui_osp_toggle", 2);

  self SetClientOmnvar("ui_warbird_countdown", player.orbitalsupport_endtime);

  coop_primary_num = player getEntityNumber();
  self SetClientOmnvar("ui_coop_primary_num", coop_primary_num);
}

playerDoRideKillstreak() {
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("coop");

  if(result != "success") {
    self removeOrbitalSupportBuddy(result == "disconnect");

    self notify("initRideKillstreak_complete", false);
    return;
  }

  self notify("initRideKillstreak_complete", true);
}

removeOrbitalSupportBuddy(disconnected) {
  self notify("orbitalsupport_player_removed");
  level notify("orbitalsupport_buddy_removed");

  if(!disconnected) {
    self playerResetOSPOmnvars();
    self thread removeOSPVisionAndLightSetPerMap(0.5);
    self revertVisionSetForPlayer(0);
    self NotifyOnPlayerCommandRemove("ExitButtonDown", "+activate");
    self NotifyOnPlayerCommandRemove("ExitButtonUp", "-activate");
    self NotifyOnPlayerCommandRemove("ExitButtonDown", "+usereload");
    self NotifyOnPlayerCommandRemove("ExitButtonUp", "-usereload");
    if(!isDefined(level.orbitalsupport_planeModel) || !level.orbitalsupport_planeModel.coopOffensive) {
      self NotifyOnPlayerCommandRemove("orbitalsupport_fire", "+attack");
      self NotifyOnPlayerCommandRemove("orbitalsupport_fire", "+attack_akimbo_accessible");
    }

    self RemoteControlTurretOff(level.orbitalsupport_buddy_turret);
    self Unlink();

    level.orbitalsupport_buddy_turret Hide();

    maps\mp\killstreaks\_aerial_utility::disableOrbitalThermal(self);
    self SetShadowRendering(true);
    self ThermalVisionFOFOverlayOff();
    self setBlurForPlayer(0, 0);
    self maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
    self stopAC130();

    if(getDvarInt("camera_thirdPerson")) {
      self setThirdPersonDOF(true);
    }

    if(isDefined(self.darkScreenOverlay)) {
      self.darkScreenOverlay destroy();
    }

    if(self isUsingRemote()) {
      self clearUsingRemote();
    }
    self.reloading_big_orbitalsupport_gun = undefined;
    self.reloading_medium_orbitalsupport_gun = undefined;
    self.reloading_rocket_orbitalsupport_gun = undefined;
    self.reloading_buddy_medium_orbitalsupport_gun = undefined;

    self playerRestoreAngles();

    self maps\mp\killstreaks\_coop_util::playerResetAfterCoopStreak();
    self playerRemoteKillstreakShowHud();
  }

  level.orbitalsupport_buddy = undefined;

  setupFlightSounds();
}

removeOrbitalSupportBuddyOnDisconnect() {
  self endon("orbitalsupport_player_removed");

  self waittill("disconnect");

  self thread removeOrbitalSupportBuddy(true);
}

removeOrbitalSupportBuddyOnChangeTeams() {
  self endon("orbitalsupport_player_removed");

  self waittill("joined_team");

  self thread removeOrbitalSupportBuddy(false);
}

removeOrbitalSupportBuddyOnSpectate() {
  self endon("orbitalsupport_player_removed");

  self waittill_any("joined_spectators", "spawned");

  self thread removeOrbitalSupportBuddy(false);
}

removeOrbitalSupportBuddyOnCommand() {
  self endon("orbitalsupport_player_removed");

  self NotifyOnPlayerCommand("ExitButtonDown", "+activate");
  self NotifyOnPlayerCommand("ExitButtonUp", "-activate");
  self NotifyOnPlayerCommand("ExitButtonDown", "+usereload");
  self NotifyOnPlayerCommand("ExitButtonUp", "-usereload");

  while(true) {
    self waittill("ExitButtonDown");

    self thread startOSPBuddyExitCommand();
    self thread cancelOSPBuddyExitCommand();
  }
}

startOSPBuddyExitCommand() {
  self endon("orbitalsupport_player_removed");
  self endon("ExitButtonUp");

  self.osp_buddy_exit = true;

  wait(0.5);

  if(self.osp_buddy_exit == true) {
    self thread removeOrbitalSupportBuddy(false);
  }
}

cancelOSPBuddyExitCommand() {
  self endon("orbitalsupport_player_removed");

  self waittill("ExitButtonUp");

  self.osp_buddy_exit = false;
}

setRandomOrbitalSupportStartPosition() {
  height_modifier = level.mapCenter[2] + CONST_ORBITALSUPPORT_HEIGHT;
  radius_modifier = CONST_ORBITALSUPPORT_RADIUS;
  angle_modifier = (0, RandomInt(360), 0);

  if(isDefined(level.orbitalsupportoverrides.spawnAngle)) {
    angle_modifier = (0, level.orbitalsupportoverrides.spawnAngle, 0);
  } else if(isDefined(level.orbitalsupportoverrides.spawnAngleMin) && isDefined(level.orbitalsupportoverrides.spawnAngleMax)) {
    angle_modifier = (0, RandomIntRange(level.orbitalsupportoverrides.spawnAngleMin, level.orbitalsupportoverrides.spawnAngleMax), 0);
  }

  if(isDefined(level.orbitalsupportoverrides.spawnRadius)) {
    radius_modifier = level.orbitalsupportoverrides.spawnRadius;
  }

  if(isDefined(level.orbitalsupportoverrides.spawnHeight)) {
    height_modifier = level.orbitalsupportoverrides.spawnHeight;
  }

  PrintLn("Paladin angle: " + angle_modifier);
  PrintLn("Paladin radius: " + radius_modifier);
  PrintLn("Paladin height: " + height_modifier);
  dvarAngle = GetDvarFloat("scr_paladin_angle", -1.0);
  dvarRadius = GetDvarFloat("scr_paladin_radius", -1.0);
  dvarHeight = GetDvarFloat("scr_paladin_height", -1.0);
  if(dvarAngle > 0) {
    angle_modifier = (0, dvarAngle, 0);
  }
  if(dvarRadius > 0) {
    radius_modifier = dvarRadius;
  }
  if(dvarHeight > 0) {
    height_modifier = dvarHeight;
  }

  level.orbitalsupport_planeModel.angles = angle_modifier;

  level.orbitalsupport_planeModel.origin -= VectorNormalize(-1 * AnglesToRight(level.orbitalsupport_planeModel GetTagAngles("tag_origin"))) * radius_modifier;
  level.orbitalsupport_planemodel.origin += (0, 0, height_modifier);

  if(GetDvar("scr_paladin_center", "0") != "0") {
    level.orbitalsupport_planemodel.origin = (0, 0, height_modifier);
  }

  level.orbitalsupport_planeModel.destination2 = spawnStruct();
  level.orbitalsupport_planeModel.destination2.origin = level.orbitalsupport_planeModel.origin;
  level.orbitalsupport_planeModel.destination2.angles = level.orbitalsupport_planeModel.angles;
  level.orbitalsupport_planeModel.origin += (0, 0, 65000);
}

moveOrbitalSupportToDestination(shouldRotate) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("orbitalsupport_player_removed");

  if(!isDefined(shouldRotate)) {
    shouldRotate = true;
  }

  thread rotatePlane(1, "off");
  level.orbitalsupport_planemodel thread playJetFX();

  thread playEntrySoundDelayed();
  level.orbitalsupport_planemodel ScriptModelPlayAnimDeltaMotion("paladin_ks_callin", "paladin_notetrack");

  if(isDefined(level.orbitalsupport_planemodel.owner)) {
    level.orbitalsupport_planemodel.owner thread playerDelayRumble(1.5);
  }

  level.orbitalsupport_planeModel waittillmatch("paladin_notetrack", "engines_full");

  level.orbitalsupport_planeModel waittillmatch("paladin_notetrack", "downward_stop");
  if(isDefined(level.orbitalsupport_planemodel.owner)) {
    level.orbitalsupport_planemodel.owner StopRumble("orbital_laser_charge");
    level.orbitalsupport_planemodel.owner PlayRumbleOnEntity("ac130_105mm_fire");
    Earthquake(0.2, 2, level.orbitalsupport_planeModel.destination2.origin, 1000);
  }

  level.orbitalsupport_planeModel waittillmatch("paladin_notetrack", "engines_idle");

  if(shouldRotate) {
    level.orbitalsupport_planemodel LinkToSynchronizedParent(level.ospRig, "tag_player");

    thread rotatePlane(level.orbitalsupport_speed);
  }

  level.orbitalsupport_planeModel waittillmatch("paladin_notetrack", "end");

  level.orbitalsupport_planemodel ScriptModelClearAnim();
  level.orbitalsupport_planemodel ScriptModelPlayAnim("paladin_ks_loop", "paladin_notetrack");

  if(isDefined(level.orbitalsupport_planemodel.owner)) {
    level.orbitalsupport_planeModel.closeFlightSound = spawn("script_origin", (0, 0, 0));
    level.orbitalsupport_planeModel.closeFlightSound LinkToSynchronizedParent(level.orbitalsupport_planeModel, "tag_origin", (0, 0, 0), (0, 0, 0));
    level.orbitalsupport_planeModel.closeFlightSound playLoopSound("paladin_flight_loop_near");
  }

  level.orbitalsupport_planeModel.farFlightSound = spawn("script_origin", (0, 0, 0));
  level.orbitalsupport_planeModel.farFlightSound LinkToSynchronizedParent(level.orbitalsupport_planeModel, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.orbitalsupport_planeModel.farFlightSound playLoopSound("paladin_flight_loop_dist");

  setupFlightSounds();

  level.orbitalsupport_planeModel.paladinflying = true;
}

setupFlightSounds() {
  if(isDefined(level.orbitalsupport_planeModel.closeFlightSound)) {
    level.orbitalsupport_planeModel.closeFlightSound Hide();

    if(isDefined(level.orbitalsupport_planemodel.owner)) {
      level.orbitalsupport_planeModel.closeFlightSound ShowToPlayer(level.orbitalsupport_planemodel.owner);
    }

    if(isDefined(level.orbitalsupport_buddy) && !level.splitscreen && !bothPlayersSplitscreen(level.orbitalsupport_planemodel.owner, level.orbitalsupport_buddy)) {
      level.orbitalsupport_planeModel.closeFlightSound ShowToPlayer(level.orbitalsupport_buddy);
    }
  }

  if(isDefined(level.orbitalsupport_planeModel.farFlightSound)) {
    level.orbitalsupport_planeModel.farFlightSound Hide();

    foreach(player in level.players) {
      if(level.splitscreen || (isDefined(level.orbitalsupport_planemodel.owner) && bothPlayersSplitscreen(level.orbitalsupport_planemodel.owner, player))) {
        continue;
      }

      if(isDefined(level.orbitalsupport_planemodel.owner) && player != level.orbitalsupport_planemodel.owner) {
        level.orbitalsupport_planeModel.farFlightSound ShowToPlayer(player);
      }
    }
  }
}

bothPlayersSplitscreen(player1, player2) {
  return (player1 IsSplitscreenPlayer() && player2 IsSplitscreenPlayer());
}

playerDelayRumble(time) {
  self endon("disconnect");
  self endon("orbitalsupport_player_removed");
  wait time;
  self PlayRumbleOnEntity("orbital_laser_charge");
}

playJetFX() {
  level.orbitalsupport_planemodel endon("death");
  level.orbitalsupport_planemodel endon("crashing");
  level endon("game_ended");
  level endon("orbitalsupport_player_removed");
  level.orbitalsupport_planemodel endon("stopEffects");

  playFXOnTag(getfx("orbitalsupport_entry"), level.orbitalsupport_planemodel, "tag_origin");
  waitframe();
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");

  waitframe();

  playFX(getfx("orbitalsupport_entry_flash"), level.orbitalsupport_planeModel.destination2.origin);

  level.orbitalsupport_planeModel waittillmatch("paladin_notetrack", "engines_full");
  playFXOnTag(getfx("orbitalsupport_light"), level.orbitalsupport_planemodel, "tag_light_tail");
  playFXOnTag(getfx("orbitalsupport_entry_complete"), level.orbitalsupport_planemodel, "tag_light_belly");
  waitframe();
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  waitframe();
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  playFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");

  level.orbitalsupport_planeModel waittillmatch("paladin_notetrack", "engines_idle");

  stopFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  stopFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  waitframe();
  stopFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  stopFXOnTag(getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  playFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  stopFXOnTag(getfx("orbitalsupport_entry"), level.orbitalsupport_planemodel, "tag_origin");
}

playEntrySoundDelayed() {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("orbitalsupport_player_removed");

  wait 1;

  playSoundAtPos(level.orbitalsupport_planeModel.destination2.origin, "paladin_orbit_drop");
}

orbitalsupportExit() {
  level.orbitalsupport_planeModel endon("crashing");

  level.orbitalsupport_planemodel notify("leaving");

  level.orbitalsupport_planemodel Unlink();
  level.orbitalsupport_planemodel ScriptModelPlayAnimDeltaMotion("paladin_ks_exit", "paladin_notetrack");

  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  stopFXOnTag(getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  playFXOnTag(getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  playFXOnTag(getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  playFXOnTag(getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_B");

  wait 4.8;

  cleanupOSPEnts();
  level.orbitalsupport_planeModel Delete();
  level.orbitalsupportInUse = false;
}

setupPlayersDuringStreak() {
  level.orbitalsupport_chatter_timer = 0;
  foreach(player in level.players) {
    if(isDefined(player.team) && level.orbitalsupport_planemodel.owner.team == player.team) {
      continue;
    } else if(!isDefined(player.team)) {
      player onPlayerSpawnedDuringStreak();
      continue;
    }

    player thread playerMonitorDeath();
    player thread playerMonitorMarkedTarget();
  }

  level thread onPlayerConnectDuringStreak();
}

onPlayerConnectDuringStreak() {
  level endon("game_ended");
  level.orbitalsupport_planemodel.owner endon("orbitalsupport_player_removed");

  while(true) {
    level waittill("connected", player);

    player thread onPlayerSpawnedDuringStreak();
  }
}

onPlayerSpawnedDuringStreak() {
  self waittill("spawned_player");

  self thread playerMonitorDeath();
  self thread playerMonitorMarkedTarget();

  setupFlightSounds();
}

playerMonitorMarkedTarget() {
  self endon("disconnect");

  level.orbitalsupport_planemodel.owner endon("orbitalsupport_player_removed");

  team = level.orbitalsupport_planemodel.owner.team;

  while(true) {
    self waittill("paint_marked_target", attacker);

    if(self.team == team || !isDefined(attacker)) {
      continue;
    }

    if(isDefined(level.orbitalsupport_buddy) && attacker == level.orbitalsupport_buddy && GetTime() > level.orbitalsupport_buddy_chatter_timer) {
      level.orbitalsupport_buddy_chatter_timer = GetTime() + (CONST_ORBITALSUPPORT_CHATTER_TIME * 1000);
      if(!level.orbitalsupport_planeModel.coopOffensive) {
        attacker leaderDialogOnPlayer("copilot_marked_mp_paladin");
      }
    }
  }
}

playerMonitorDeath() {
  self endon("disconnect");
  level.orbitalsupport_planemodel.owner endon("orbitalsupport_player_removed");

  team = level.orbitalsupport_planemodel.owner.team;

  while(true) {
    self waittill("death", attacker, sMeansOfDeath, sWeapon);

    if(self.team == team || !isDefined(attacker)) {
      continue;
    }

    if(attacker == level.orbitalsupport_planemodel.owner && GetTime() > level.orbitalsupport_chatter_timer) {
      level.orbitalsupport_chatter_timer = GetTime() + (CONST_ORBITALSUPPORT_CHATTER_TIME * 1000);
      attacker leaderDialogOnPlayer("copilot_enemykill_mp_paladin");
    }

    if(isDefined(level.orbitalsupport_buddy) && attacker == level.orbitalsupport_buddy && GetTime() > level.orbitalsupport_buddy_chatter_timer) {
      level.orbitalsupport_buddy_chatter_timer = GetTime() + (CONST_ORBITALSUPPORT_CHATTER_TIME * 1000);
      if(level.orbitalsupport_planeModel.coopOffensive) {
        attacker leaderDialogOnPlayer("copilot_enemykill_mp_paladin");
      }
    }
  }
}

playerFireSounds(sound2d, sound3d, isBuddy, index) {
  turret = level.orbitalsupport_big_turret;
  if(isBuddy) {
    turret = level.orbitalsupport_buddy_turret;
  }

  if(!isDefined(index) || index >= turret.soundEnts.size) {
    index = 0;
  }

  turret.soundEnts[index] PlaySoundOnMovingEnt(sound3d);

  if(GetDvar("scr_paladin_stay_on_ground", "0") != "0") {
    return;
  }

  self PlayLocalSound(sound2d);
}

turretDeleteSoundEnts() {
  foreach(ent in self.soundEnts) {
    ent Delete();
  }
}

playerResetOSPOmnvars() {
  self SetClientOmnvar("ui_killstreak_optic", false);
  self SetClientOmnvar("ui_osp_rockets", 0);
  self SetClientOmnvar("ui_osp_avail_weapons", 0);
  self SetClientOmnvar("ui_osp_weapon", 0);
  self SetClientOmnvar("ui_osp_reload_bitfield", 0);
  self SetClientOmnvar("ui_osp_toggle", 0);
  self SetClientOmnvar("ui_coop_primary_num", 0);
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();
}

rotatePlane(speed, toggle) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(!isDefined(toggle)) {
    toggle = "on";
  }

  if(toggle == "on") {
    level.ospRig rotateyaw(360, speed, 0.5);
    wait speed;

    for(;;) {
      level.ospRig rotateyaw(360, speed);
      wait speed;
    }
  } else if(toggle == "off") {
    slowdownDegrees = 10;
    rotateTime = (speed / 360) * slowdownDegrees;
    level.ospRig rotateyaw(level.ospRig.angles[2] + slowdownDegrees, rotateTime, 0, rotateTime);
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

testOSPFlares(player) {
  player endon("orbitalsupport_player_removed");

  SetDvarIfUninitialized("scr_osp_flares", "0");

  cur = "none";
  while(true) {
    if(GetDvarInt("scr_osp_flares", 0) == 0) {
      waitframe();
      continue;
    }

    SetDvar("scr_osp_flares", "0");

    if(cur == "none") {
      player SetClientOmnvar("ui_warbird_flares", 3);
      cur = "threat";
    } else if(cur == "threat") {
      player SetClientOmnvar("ui_warbird_flares", 1);
      cur = "flare1";
    } else if(cur == "flare1") {
      player SetClientOmnvar("ui_warbird_flares", 2);
      cur = "flare2";
    } else {
      player SetClientOmnvar("ui_warbird_flares", 0);
      cur = "none";
    }

    waitframe();
  }
}
# /