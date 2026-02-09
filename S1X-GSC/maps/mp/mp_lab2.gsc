/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_lab2.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_dynamic_events;
#include maps\mp\_audio;

main() {
  maps\mp\mp_lab2_precache::main();
  maps\createart\mp_lab2_art::main();
  maps\mp\mp_lab2_fx::main();
  SetLightingState(1);
  maps\mp\_load::main();

  thread setup_audio();

  thread set_lighting_values();
  thread set_umbra_values();

  level.ospvisionset = "mp_lab2_osp";
  level.osplightset = "mp_lab2_osp";
  level.warbirdvisionset = "mp_lab2_osp";
  level.warbirdlightset = "mp_lab2_osp";
  level.vulcanvisionset = "mp_lab2_osp";
  level.vulcanlightset = "mp_lab2_osp";

  maps\mp\_compass::setupMiniMap("compass_map_mp_lab2");

  setDvar("sm_minSpotLightScore", 0.0007);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  if(level.nextgen) {
    level.aerial_pathnode_group_connect_dist = 350;
  }

  precachemodel("lab2_cannister_holder_01");
  precachemodel("lab2_industrial_crane_01");

  PrecacheMpAnim("lab2_dynamic_event_helicopter_anim");
  PrecacheMpAnim("lab2_dynamic_event_harness_anim");
  PrecacheMpAnim("lab2_dynamic_event_building_anim");
  PrecacheMpAnim("lab2_industrial_crane_anim");
  PrecacheMpAnim("lab2_dynamic_event_harness_invis_anim");

  PreCacheShellShock("mp_lab_gas");
  PreCacheShader("lab_gas_overlay");

  level.MissileParticles = spawnStruct();

  level.MissileParticles.SprayMachine = LoadFX("vfx/water/industrial_hot_water_sprayer");
  level.MissileParticles.SprayMachineDrips = LoadFX("vfx/water/industrial_hot_water_sprayer_drips");
  level.MissileParticles.CanisterDrips = LoadFX("vfx/map/mp_lab/canister_drips");
  level.MissileParticles.CanisterSteam = LoadFX("vfx/map/mp_lab/canister_steam");
  level.MissileParticles.DryMachine = LoadFX("vfx/map/mp_lab/industrial_dryer_fan");
  level.MissileParticles.SparkGreenLoop = LoadFX("vfx/map/mp_lab/flare_sparks_ambient_green");
  level.MissileParticles.GreenCrazyLightLoop = LoadFX("vfx/smoke/smoke_flare_marker_green_windy");
  level.MissileParticles.GreenSmokeLoop = LoadFX("vfx/map/mp_lab/chem_smoke_green");
  level.MissileParticles.MissileExplosion = LoadFX("vfx/explosion/poison_gas_canister_explosion");
  level.MissileParticles.CraneSparks = loadfx("vfx/sparks/crane_scrape_sparks_small_looping");
  level.alarmfx01 = loadfx("vfx/lights/mp_lab2/lab2_crane_red_alarm");

  if(isDefined(level.createFX_enabled) && level.createFX_enabled) {
    return;
  }

  thread SetupCraneChem();
  thread OnPlayerConnectFucntions();
  thread SetupDynamicEvent();
  thread setupRobotArmNotetracks();
  thread FindAndPlayAnims("animated_prop", true);
  thread SpecialGametypeScript();

  setDvar("r_reactivemotionfrequencyscale", .5);
  setDvar("r_reactivemotionamplitudescale", .5);

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  level.LabTempTuner1 = 9;
  level.LabTempTuner2 = 4;
  level.LabTempTuner3 = -2;

  level.orbitalSupportOverrideFunc = ::labPaladinOverrides;
  level.orbitalLaserOverrideFunc = ::lab2CustomLaserStreakFunc;

  thread lab2CustomAirstrike();
}

set_umbra_values() {
  setDvar("r_umbraAccurateOcclusionThreshold", 128);
}

SpecialGametypeScript() {
  thread waitCarryObjects();
}

waitCarryObjects() {
  level endon("game_ended");

  if(level.gameType == "sd") {
    while(!isDefined(level.sdBomb)) {
      wait(0.05);
    }
    level.sdBomb thread watchCarryObjects();
  } else if(level.gameType == "sab") {
    while(!isDefined(level.sabBomb)) {
      wait(0.05);
    }
    level.sabBomb thread watchCarryObjects();
  } else if(level.gameType == "tdef") {
    while(!isDefined(level.gameFlag)) {
      wait(0.05);
    }
    level.gameFlag thread watchCarryObjects();
  } else if(level.gameType == "ball") {
    while(!isDefined(level.balls)) {
      wait(0.05);
    }
    foreach(ball in level.balls) {
      ball thread watchCarryObjects();
    }
  } else if(level.gameType == "ctf") {
    while(!isDefined(level.teamFlags) || !isDefined(level.teamFlags[game["defenders"]]) || !isDefined(level.teamFlags[game["attackers"]])) {
      wait(0.05);
    }
    level.teamFlags[game["defenders"]] thread watchCarryObjects();
    level.teamFlags[game["attackers"]] thread watchCarryObjects();
  }
}

watchCarryObjects() {
  level endon("game_ended");

  while(true) {
    self waittill("dropped");

    wait(0.1);

    if(self isOutOfBounds()) {
      self maps\mp\gametypes\_gameobjects::returnHome();
    } else if(isDefined(level.FlyingBuildingEnt) &&
      level.FlyingBuildingEnt.flying == true &&
      isDefined(level.FlyingBuildingEnt.TriggerHurtLower) &&
      isDefined(level.FlyingBuildingEnt.TriggerHurtUpper)) {
      while(level.FlyingBuildingEnt.flying == true) {
        if(self.visuals[0] istouching(level.FlyingBuildingEnt.TriggerHurtLower) || self.visuals[0] istouching(level.FlyingBuildingEnt.TriggerHurtUpper)) {
          self maps\mp\gametypes\_gameobjects::returnHome();
          break;
        }
        wait(0.05);
      }
    }
  }
}

isOutOfBounds() {
  radTriggers = getEntArray("radiation", "targetname");
  for(index = 0; index < radTriggers.size; index++) {
    if(!self.visuals[0] isTouching(radTriggers[index])) {
      continue;
    }

    return true;
  }

  mineTriggers = getEntArray("minefield", "targetname");
  for(index = 0; index < mineTriggers.size; index++) {
    if(!self.visuals[0] isTouching(mineTriggers[index])) {
      continue;
    }

    return true;
  }

  hurtTriggers = getEntArray("trigger_hurt", "classname");
  for(index = 0; index < hurtTriggers.size; index++) {
    if(!self.visuals[0] isTouching(hurtTriggers[index])) {
      continue;
    }

    return true;
  }

  MapBorder = getEntArray("boost_jump_border_trig", "targetname");
  for(index = 0; index < MapBorder.size; index++) {
    if(!self.visuals[0] isTouching(MapBorder[index])) {
      continue;
    }

    return true;
  }

  OutOfBounds = getEntArray("object_out_of_bounds", "targetname");
  for(index = 0; index < OutOfBounds.size; index++) {
    if(!self.visuals[0] isTouching(OutOfBounds[index])) {
      continue;
    }

    return true;
  }

  return false;
}

SetupDynamicEvent() {
  groundShadowPatchBefore = getEntArray("ground_shadow_patch_before", "targetname");
  groundShadowPatchAfter = getEntArray("ground_shadow_patch_after", "targetname");
  fromEnt = GetEnt("teleport_from", "targetname");
  toEnt = GetEnt("teleport_to", "targetname");
  foreach(thing in groundShadowPatchBefore) {
    thing.origin += toent.origin - froment.origin;
  }
  foreach(thing in groundShadowPatchAfter) {
    thing hide();
  }
  SetLightingState(2);

  FlyingBuildingParts = getEntArray("dynamic_building_master_prefab", "targetname");
  FlyingBuildingEnt = undefined;

  parts = [];
  foreach(part in FlyingBuildingParts) {
    if(isDefined(part.script_noteworthy) && part.script_noteworthy == "origin") {
      FlyingBuildingEnt = spawn("script_origin", part.origin);
    } else {
      parts[parts.size] = part;
    }
  }
  if(!isDefined(FlyingBuildingEnt)) {
    FlyingBuildingEnt = spawn("script_origin", FlyingBuildingParts[0].origin);
  }

  FlyingBuildingEnt.radiant_pos = FlyingBuildingEnt.origin;
  FlyingBuildingEnt.flying = false;
  FlyingBuildingEnt.parts = parts;
  FlyingBuildingEnt.TriggerHurtLower = getent("building_hurt_01", "targetname");
  FlyingBuildingEnt.TriggerHurtUpper = getent("building_hurt_02", "targetname");
  FlyingBuildingEnt.TriggerKillVehiclesHeli = getent("vehicle_kill_heli", "targetname");
  FlyingBuildingEnt.TriggerKillVehiclesHeliOffset = (525, 36, 635);

  FlyingBuildingEnt.TriggerKillVehiclesHeli.origin += (0, 0, -10000);
  FlyingBuildingEnt.TriggerKillVehiclesBuilding = getent("vehicle_kill_building", "targetname");

  FlyingBuildingEnt.TriggerKillVehiclesBuildingOffset = (FlyingBuildingEnt.TriggerKillVehiclesBuilding.origin - FlyingBuildingEnt.origin);
  FlyingBuildingEnt.TriggerKillVehiclesBuilding.origin += (0, 0, -10000);

  foreach(part in FlyingBuildingEnt.parts) {
    if(part.classname == "info_null_meter") {
      continue;
    } else if(isDefined(part.script_noteworthy) && part.script_noteworthy == "trigger_origin_01") {
      FlyingBuildingEnt.TriggerLowerOrigin = part;
    } else if(isDefined(part.script_noteworthy) && part.script_noteworthy == "trigger_origin_02") {
      FlyingBuildingEnt.TriggerUpperOrigin = part;
    }
    part LinkToSynchronizedParent(FlyingBuildingEnt);
  }

  FlyingBuildingEnt.DynamicPathBlock = getent("flying_building_paths_unblock", "targetname");

  FlyingBuildingEnt.DynamicPathRampSwitch = getent("flying_building_path_ramp_switch", "targetname");

  FlyingBuildingEnt.DynamicPathBlock LinkToSynchronizedParent(FlyingBuildingEnt);

  FlyingBuildingEnt.OG_spawn = (15959.85, -24712.881, 5209.891);
  FlyingBuildingEnt.OG_heli_spawn = (15940.685, -24711.615, 5888.014);

  FlyingBuildingEnt.origin = FlyingBuildingEnt.OG_spawn;
  wait(0.05);
  FlyingBuildingEnt.TriggerHurtLower.origin = FlyingBuildingEnt.TriggerLowerOrigin.origin;
  FlyingBuildingEnt.TriggerHurtLower.angles = FlyingBuildingEnt.TriggerLowerOrigin.angles;
  FlyingBuildingEnt.TriggerHurtUpper.origin = FlyingBuildingEnt.TriggerUpperOrigin.origin;
  FlyingBuildingEnt.TriggerHurtUpper.angles = FlyingBuildingEnt.TriggerUpperOrigin.angles;

  OpenDynamicBuildingPlatformPath(FlyingBuildingEnt);

  foreach(part in FlyingBuildingEnt.parts) {
    if(part.classname == "info_null_meter") {
      continue;
    }
    part hide();
  }

  FlyingBuildingEnt hide();

  level.FlyingBuildingEnt = FlyingBuildingEnt;

  level thread DynamicEvent(::dynamicEventStartFunc, undefined, ::dynamicEventEndFunc);
}

OpenDynamicBuildingPlatformPath(FlyingBuildingEnt) {
  FlyingBuildingEnt.DynamicPathRampSwitch.origin += (0, 0, -10000);
  FlyingBuildingEnt.DynamicPathBlock ConnectPaths();
  foreach(part in FlyingBuildingEnt.parts) {
    if(isDefined(part.script_noteworthy)) {
      if(part.script_noteworthy == "flying_building_collision_shell" || part.script_noteworthy == "collision" || part.script_noteworthy == "building_brush_geo") {
        part ConnectPaths();
        if(part.script_noteworthy == "flying_building_collision_shell") {
          part SetAISightLineVisible(false);
        }
      }
    }
  }
  if(level.gametype == "dom") {
    wait(0.05);
    maps\mp\gametypes\dom::flagSetup();
  }
}

dynamicEventStartFunc() {
  if(isDefined(level.FlyingBuildingEnt) && !isDefined(level.isHorde)) {
    level.FlyingBuildingEnt MoveFlyingBuilding();
  }
}

dynamicEventEndFunc() {
  groundShadowPatchBefore = getEntArray("ground_shadow_patch_before", "targetname");
  groundShadowPatchAfter = getEntArray("ground_shadow_patch_after", "targetname");
  groundShadowPatchAfter[0] show();
  groundShadowPatchBefore[0] hide();

  if(isDefined(level.FlyingBuildingEnt)) {
    level.FlyingBuildingEnt.DynamicPathBlock unlink();
    level.FlyingBuildingEnt.DynamicPathBlock.origin += (0, 0, -10000);

    level.FlyingBuildingEnt DontInterpolate();
    level.FlyingBuildingEnt.origin = level.FlyingBuildingEnt.radiant_pos;

    wait(0.05);

    level.FlyingBuildingEnt.TriggerHurtLower DontInterpolate();
    level.FlyingBuildingEnt.TriggerHurtUpper DontInterpolate();
    level.FlyingBuildingEnt.TriggerHurtLower.origin += (0, 0, -10000);
    level.FlyingBuildingEnt.TriggerHurtUpper.origin += (0, 0, -10000);

    foreach(part in level.FlyingBuildingEnt.parts) {
      part Unlink();
      part show();
      part.unresolved_collision_kill = false;

      if(isDefined(part.script_noteworthy)) {
        if(part.script_noteworthy == "flying_building_collision_shell") {
          part DisconnectPaths();
          part SetAISightLineVisible(true);
        } else if(part.script_noteworthy == "collision") {
          part delete();
        }
      }
    }

    level.FlyingBuildingEnt.DynamicPathRampSwitch ConnectPaths();

    level thread common_scripts\_exploder::activate_clientside_exploder(100);
  }

  if(level.gametype == "dom") {
    dom_b_move();
  }
}

GetNetQuantizedAngle(angle) {
  scaledAngle = angle / 360.0;
  result = (scaledAngle - floor(scaledAngle)) * 360.0;
  result2 = result - 360.0;
  if(result2 >= 0) {
    result = result2;
  }
  compressedAngle = int(floor((result * 4095 / 360) + 0.5));
  angle = (compressedAngle * 360) / 4095.0;
  return angle;
}

dom_b_move() {
  wait(0.05);

  post_event_flag_b_origin = getstruct("dom_point_b_location", "targetname");

  foreach(domFlag in level.flags) {
    if(domFlag.script_label == "_b") {
      domFlag.origin = post_event_flag_b_origin.origin;
      domFlag.useobj.visuals[0].origin = post_event_flag_b_origin.origin + (0, 0, 1.125);
      domFlag.useobj.visuals[0].baseorigin = post_event_flag_b_origin.origin + (0, 0, 1.125);
      domFlag.useobj.curorigin = post_event_flag_b_origin.origin + (0, 0, 1.125);
      domFlag.useobj.baseeffectpos = post_event_flag_b_origin.origin + (0, 0, 1.125);

      domFlag.useObj maps\mp\gametypes\dom::updateVisuals();

      if(isDefined(domflag.useobj.objIDAllies)) {
        Objective_Position(domflag.useobj.objIDAllies, post_event_flag_b_origin.origin);
      }
      if(isDefined(domflag.useobj.objIDAxis)) {
        Objective_Position(domflag.useobj.objIDAxis, post_event_flag_b_origin.origin);
      }

      obj_icon_pos = post_event_flag_b_origin.origin + (0, 0, 100);
      foreach(team in level.teamnamelist) {
        opName = "objpoint_" + team + "_" + domFlag.useObj.entNum;
        objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
        objPoint.x = obj_icon_pos[0];
        objPoint.y = obj_icon_pos[1];
        objPoint.z = obj_icon_pos[2];
      }
    }
  }

  level notify("dom_flags_moved");

  maps\mp\gametypes\dom::flagSetup();
}

#using_animtree("animated_props");
MoveFlyingBuilding() {
  Zoffset = level.LabTempTuner1;
  Yoffset = level.LabTempTuner2;
  Xoffset = level.LabTempTuner3;
  self.heavy_lifter = spawn("script_model", self.OG_heli_spawn + (Xoffset, Yoffset, Zoffset));

  angle = GetNetQuantizedAngle(36.078);
  self.heavy_lifter.angles = (0, 36.044, 0);
  self.heavy_lifter setModel("vehicle_heavy_lift_helicopter_01");

  self.harness = spawn("script_model", self.heavy_lifter GetTagOrigin("tag_crane"));
  self.harness.angles = self.heavy_lifter GetTagAngles("tag_crane") + (0, 0, 0);
  self.harness setModel("heavy_lift_wires");

  self.building_bone = spawn("script_model", self.OG_spawn + (0, 0, Zoffset));
  self.building_bone.angles = self.harness GetTagAngles("tag_cargo") + (0, 180, 0);

  self.building_bone setModel("tag_origin_animate");

  self.flying = true;

  wait(0.05);

  self.TriggerKillVehiclesHeli thread maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig();
  self.TriggerKillVehiclesBuilding thread maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig();

  self thread KillWarbirds(self.TriggerKillVehiclesBuilding);
  self thread KillWarbirds(self.TriggerKillVehiclesHeli);

  foreach(part in self.parts) {
    part show();
  }

  wait(0.05);

  foreach(mesh in self.parts) {
    mesh.unresolved_collision_kill = true;
  }

  self.origin = self.OG_spawn + (0, 0, Zoffset);
  self.angles = self.harness GetTagAngles("tag_cargo") + (0, 180, 0);

  self LinkToSynchronizedParent(self.harness, "tag_cargo");

  wait(0.05);

  self.heavy_lifter ScriptModelPlayAnimDeltaMotion("lab2_dynamic_event_helicopter_anim", "building_unlink_notify");
  self.harness ScriptModelPlayAnimDeltaMotion("lab2_dynamic_event_harness_anim");

  self.heavy_lifter thread aud_transport_chopper();

  self thread MoveBuildingDeathTriggers();

  self.heavy_lifter thread maps\mp\mp_lab2_fx::startHeavyLifterFX();

  self.heavy_lifter waittillmatch("building_unlink_notify", "vfx_heligroundfx_start");
  self.heavy_lifter thread maps\mp\mp_lab2_fx::startHeliGroundFX();

  self.heavy_lifter waittillmatch("building_unlink_notify", "vfx_crane_sparks_start");
  playFXOnTag(getfx("crane_sparks"), self.heavy_lifter, "TAG_CRANE");

  self.heavy_lifter waittillmatch("building_unlink_notify", "helicopter_descend");

  parts = [];
  foreach(part in self.parts) {
    if(isDefined(part.script_noteworthy) && part.script_noteworthy == "collision") {
      part Unlink();
      part delete();
    } else {
      parts[parts.size] = part;
    }
  }
  self.parts = parts;

  self.DynamicPathBlock unlink();
  self.DynamicPathBlock delete();

  self.heavy_lifter thread aud_building_pre_drop();

  self.heavy_lifter waittillmatch("building_unlink_notify", "vfx_crane_sparks_stop");
  stopFXOnTag(getfx("crane_sparks"), self.heavy_lifter, "TAG_CRANE");

  self.heavy_lifter waittillmatch("building_unlink_notify", "vfx_building_land");
  common_scripts\_exploder::activate_clientside_exploder(99);

  self.heavy_lifter waittillmatch("building_unlink_notify", "drop_building");
  self.harness thread maps\mp\mp_lab2_fx::clampReleaseFX();

  self.heavy_lifter thread aud_building_drop();

  groundShadowPatchBefore = getEntArray("ground_shadow_patch_before", "targetname");
  groundShadowPatchAfter = getEntArray("ground_shadow_patch_after", "targetname");
  groundShadowPatchAfter[0] show();
  groundShadowPatchBefore[0] hide();

  self unlink();
  self.flying = false;
  foreach(part in self.parts) {
    if(isDefined(part)) {
      part Unlink();
      part.unresolved_collision_kill = false;
      if(isDefined(part.script_noteworthy)) {
        if(part.script_noteworthy == "flying_building_collision_shell") {
          part DisconnectPaths();
          part SetAISightLineVisible(true);
        }
      }
    }
  }

  self.DynamicPathRampSwitch ConnectPaths();

  if(level.gametype == "dom") {
    dom_b_move();
  }

  common_scripts\_exploder::activate_clientside_exploder(100);

  self.heavy_lifter waittillmatch("building_unlink_notify", "vfx_heligroundfx_stop");
  self.heavy_lifter thread maps\mp\mp_lab2_fx::stopHeliGroundFX();

  self.heavy_lifter waittillmatch("building_unlink_notify", "helicopter_end");

  self.heavy_lifter delete();
  self.harness delete();
}

KillWarbirds(trigger) {
  if(isDefined(trigger)) {
    while(self.flying == true) {
      if(isDefined(level.SpawnedWarbirds)) {
        foreach(warbird in level.SpawnedWarbirds) {
          if(isDefined(warbird)) {
            if(warbird IsTouching(trigger)) {
              warbird thread maps\mp\killstreaks\_aerial_utility::heli_explode(true);
            }
          }
        }
      }
      wait(0.05);
    }
  }
}

MoveBuildingDeathTriggers() {
  while(self.flying == true) {
    self.TriggerHurtLower.origin = self.TriggerLowerOrigin.origin;
    self.TriggerHurtLower.angles = self.TriggerLowerOrigin.angles;

    self.TriggerHurtUpper.origin = self.TriggerUpperOrigin.origin;
    self.TriggerHurtUpper.angles = self.TriggerUpperOrigin.angles;

    heli_angles = self.heavy_lifter GetTagAngles("body_animate_jnt");
    heli_angles_x = 360 - heli_angles[0];
    heli_angles_y = heli_angles[1] + 180;
    heli_angles_z = 360 - heli_angles[2];

    self.TriggerKillVehiclesHeli.angles = (heli_angles_x, heli_angles_y, heli_angles_z);
    self.TriggerKillVehiclesHeli.origin = self.heavy_lifter.origin + self.TriggerKillVehiclesHeliOffset;

    self.TriggerKillVehiclesBuilding.origin = self.origin + self.TriggerKillVehiclesBuildingOffset;
    self.TriggerKillVehiclesBuilding.angles = self.angles;

    wait(0.05);
  }
  self.TriggerHurtLower DontInterpolate();
  self.TriggerHurtUpper DontInterpolate();
  self.TriggerKillVehiclesHeli DontInterpolate();
  self.TriggerKillVehiclesBuilding DontInterpolate();
  self.TriggerHurtLower.origin += (0, 0, -10000);
  self.TriggerHurtUpper.origin += (0, 0, -10000);
  self.TriggerKillVehiclesHeli.origin += (0, 0, -10000);
  self.TriggerKillVehiclesBuilding.origin += (0, 0, -10000);
}

labPaladinOverrides() {
  level.orbitalsupportoverrides.spawnAngleMin = 70;
  level.orbitalsupportoverrides.spawnAngleMax = 150;
  level.orbitalsupportoverrides.spawnHeight = 7500;
  level.orbitalsupportoverrides.spawnRadius = 5000;
  level.orbitalsupportoverrides.leftArc = 30;
  level.orbitalsupportoverrides.rightArc = 30;
  level.orbitalsupportoverrides.topArc = -42;
  level.orbitalsupportoverrides.bottomArc = 67;
}

lab2CustomLaserStreakFunc() {
  heliAnchor = maps\mp\killstreaks\_aerial_utility::getHeliAnchor();
  level.orbitallaseroverrides.spawnHeight = heliAnchor.origin[2] + 2724;
}

lab2CustomAirstrike() {
  if(!isDefined(level.airstrikeoverrides)) {
    level.airstrikeoverrides = spawnStruct();
  }

  level.airstrikeoverrides.spawnHeight = 1700;
}

OnPlayerConnectFucntions() {
  level endon("game_ended");
  while(true) {
    level waittill("connected", player);
    {
      player.GasTime = 0;
      player thread CreateGasTrackingOverlay();
    }
  }
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1");
    }
  }
}

RotateMeshes(time) {
  while(1) {
    self RotateYaw(360, time);
    wait(time);
  }
}

SetupCraneChem() {
  level.AlarmSystem = spawnStruct();
  level.AlarmSystem.SpinnerArray = getEntArray("horizontal_spinner", "targetname");
  level.AlarmSystem.AlarmSoundEnt = GetEnt("alarm_missile_sound01", "targetname");

  level.GasMachine = spawnStruct();
  level.GasMachine.TotalSpawned = [];
  level.GasMachine.CraneCollisionTotal = [];
  level.GasMachine.CraneChemCollisionTotal = [];
  level.GasMachine.ExplosionOffset = 72;
  level.GasMachine.ExplosionAngleOffset = (-90, 0, 0);
  level.GasMachine.MachineSparkArray = getEntArray("sparkgroup", "targetname");
  level.GasMachine.SprayerDripArray = getEntArray("dripgroup", "targetname");
  level.GasMachine.PartcileDryLocation = getstruct("particle_dryer", "targetname");

  level.GasMachine.chemical_rackPauseTime = 0;
  level.GasMachine.chemical_racksActive = true;
  level.GasMachine.chemical_rackGotosArray = getstructarray("missile_rack_start01", "targetname");

  level.GasMachine.DamageRadius = 375;
  level.GasMachine.MaxDamageAmount = 300;
  level.GasMachine.MinDamageAmount = 75;

  level.GasMachine.SpraySheetState = 1;
  level.GasMachine.TotalChemCanHealth = 100;
  level.GasMachine.ParticleSpawnOriginOffset = (0, 0, 0);
  level.GasMachine.DryerFan = GetEnt("dryer_fan", "targetname");
  level.GasMachine.DryerFanRotateVelocity = (0, 1400, 0);
  level.GasMachine.GasRange = 170;

  CurrentStruct = level.GasMachine.chemical_rackGotosArray[0];
  while(true) {
    if(isDefined(CurrentStruct.target)) {
      FoundStruct = getstruct(CurrentStruct.target, "targetname");
      level.GasMachine.chemical_rackGotosArray = add_to_array(level.GasMachine.chemical_rackGotosArray, FoundStruct);
      CurrentStruct = FoundStruct;
      continue;
    } else {
      break;
    }
    wait(0.05);
  }

  level.GasMachine.CraneCollisionTotal = getEntArray("crane_collision01", "targetname");
  level.GasMachine.CraneCollision = level.GasMachine.CraneCollisionTotal;
  foreach(mesh in level.GasMachine.CraneCollisionTotal) {
    mesh.unresolved_collision_kill = true;
  }

  level.GasMachine.CraneChemCollisionTotal = getEntArray("rack_collision01", "targetname");
  level.GasMachine.CraneChemCollision = level.GasMachine.CraneChemCollisionTotal;
  foreach(mesh in level.GasMachine.CraneChemCollisionTotal) {
    mesh.unresolved_collision_kill = true;
  }

  CraneThink(level.GasMachine.chemical_rackGotosArray);
}

AddToTotalSpawned() {
  level.GasMachine.TotalSpawned = add_to_array(level.GasMachine.TotalSpawned, self);
}
RemoveFromTotalSpawned() {
  wait(0.05);
  level.GasMachine.TotalSpawned = array_removeUndefined(level.GasMachine.TotalSpawned);
}

CraneThink(RackGotos) {
  Movetime = 5;
  WaitTime = 5;

  while(true) {
    if(level.GasMachine.chemical_racksActive == true) {
      if(level.GasMachine.CraneCollision.size > 0) {
        RandomNum = RandomInt(100);
        if(RandomNum > 40) {
          Crane = SpawnCrane(RackGotos, true);
          if(isDefined(Crane)) {
            Crane thread StartNoteListen(WaitTime, Movetime);
          }
        }

      }
      wait(Movetime + WaitTime + RandomFloatRange(3.0, 7.0));
    } else {
      wait(1);
    }
  }
}
StartNoteListen(WaitTime, Movetime) {
  self thread WatchCraneNoteTrack(WaitTime, Movetime);
}
#using_animtree("animated_props");
WatchCraneNoteTrack(WaitTime, Movetime) {
  self endon("death");
  self endon("deleted");
  while(1) {
    self waittill("crane_note_track", note);

    if(note == "crane_move_start") {
      if(level.GasMachine.chemical_racksActive == false) {
        if(isDefined(self) && self.paused == false) {
          self ScriptModelPauseAnim(true);
          self.paused = true;
          self CheckForUnpause();
        }
      } else {
        thread snd_play_linked("emt_conveyor_belt_gears", self);
        thread snd_play_linked("emt_conveyor_belt_sparks", self);
        playFXOnTag(level.MissileParticles.CraneSparks, self, "TAG_ORIGIN");
      }
    } else if(note == "crane_move_stop") {
      self thread StopCraneSound();
      stopFXOnTag(level.MissileParticles.CraneSparks, self, "TAG_ORIGIN");
    } else if(note == "crane_wiggle_stop") {} else if(note == "crane_particle_01" || note == "crane_particle_02" || note == "crane_particle_03") {
      self thread SprayCans(WaitTime, note);
    } else if(note == "rotate_start") {
      self thread RotateThink(WaitTime);
    } else if(note == "rotate_stop") {
      self thread StopCraneSound();
    } else if(note == "crane_finish") {
      self thread RemoveRack();
    }
  }
}
CheckForUnpause() {
  self endon("death");
  self endon("deleted");
  while(true) {
    if(isDefined(self)) {
      if(level.GasMachine.chemical_racksActive == true) {
        if(self.paused == true) {
          self ScriptModelPauseAnim(false);
          self.paused = false;

          thread snd_play_linked("emt_conveyor_belt_gears", self);
          thread snd_play_linked("emt_conveyor_belt_sparks", self);
          playFXOnTag(level.MissileParticles.CraneSparks, self, "TAG_ORIGIN");

          break;
        }
      }
    } else {
      break;
    }
    wait(0.5);
  }
}
setupRobotArmNotetracks() {
  robotArms = getEntArray("lab2_robot_arm", "targetname");
  foreach(arm in robotArms) {
    wait(RandomFloatRange(0.0, 1));
    arm ScriptModelPlayAnimDeltaMotion("lab2_robot_arm_01_idle_anim", "emt_servo_sparks");
    arm thread WatchRobotArmNotetrack();
  }
}

WatchRobotArmNotetrack() {
  self endon("death");
  self endon("deleted");
  while(1) {
    self waittill("emt_servo_sparks", note);
    if(isDefined(note) && note == "robot_arm_sparks_on") {
      playFXOnTag(getfx("welding_sparks"), self, "wristSwivel");
    } else if(isDefined(note) && note == "emt_servo_sparks") {
      thread snd_play_linked("emt_servo_sparks", self);
    }
  }
}

StopCraneSound() {
  self StopSounds();
  wait(0.05);
  thread snd_play_linked("mp_lab_missilerack_stop01", self);
}
RotateThink(WaitTime) {
  if(self.has_chemicals == true) {
    if(level.GasMachine.chemical_racksActive == true) {
      thread snd_play_in_space("emt_air_blast_turn", level.GasMachine.PartcileDryLocation.origin);
      thread snd_play_in_space("emt_air_blast_clean", level.GasMachine.PartcileDryLocation.origin);
      level.GasMachine.PartcileDryLocation thread ParticleSpray(level.MissileParticles.DryMachine, level.GasMachine.PartcileDryLocation.angles, 3);
      self thread StartCanisterFX(level.MissileParticles.CanisterSteam, WaitTime);
      thread RotateDryerFan();
    }
  }
}

RotateDryerFan() {
  level.GasMachine.DryerFan RotateVelocity(level.GasMachine.DryerFanRotateVelocity, 7, 1, 5);
}

SprayCans(WaitTime, note) {
  if(self.has_chemicals == true) {
    if(level.GasMachine.chemical_racksActive == true) {
      thread ParticleSprayMultipleNode(note, WaitTime);

      self thread StartCanisterFX(level.MissileParticles.CanisterDrips, WaitTime);
    }
  }
}
SpawnCrane(RackGotos, HasCans) {
  SpawnZOffset = -210;

  Crane = spawn("script_model", RackGotos[0].origin + (0, 0, SpawnZOffset));

  Crane PlayCraneSpawnVfX();

  CollisionData = GetCollision(level.GasMachine.CraneCollision);
  if(isDefined(CollisionData) && isDefined(CollisionData.Collision)) {
    Crane setModel("lab2_industrial_crane_01");
    Crane.paused = false;
    Crane.CraneCollision = CollisionData.Collision;
    level.GasMachine.CraneCollision = CollisionData.pool;
    Crane.CraneCollision.origin = Crane.origin;
    Crane.CraneCollision.angles = Crane.angles;
    Crane.CraneCollision LinkToSynchronizedParent(Crane);
    Crane Solid();
  } else {
    if(isDefined(Crane)) {
      Crane delete();
    }
    return undefined;
  }

  Crane AddToTotalSpawned();

  wait 0.5;
  playFXOnTag(getfx("lab_crane_arm_01_lights"), Crane, "TAG_ORIGIN");
  playFXOnTag(level.MissileParticles.CraneSparks, Crane, "TAG_ORIGIN");

  if(HasCans == true) {
    CollisionData = GetCollision(level.GasMachine.CraneChemCollision);
    if(isDefined(CollisionData) && isDefined(CollisionData.Collision)) {
      Crane.chemical_rack = spawn("script_model", Crane GetTagOrigin("tag_cargo"));
      Crane.exploding = false;
      Crane.chemical_rack setModel("lab2_cannister_holder_01");
      Crane.chemical_rack linkto(Crane, "tag_cargo");
      Crane.chemical_rack AddToTotalSpawned();
      Crane.has_chemicals = true;
      Crane.chemical_rack solid();

      thread PlayOrangeGoo(Crane.chemical_rack);

      Crane.chemical_rack.DamageRadius = level.GasMachine.DamageRadius;
      Crane.chemical_rack.MaxDamageAmount = level.GasMachine.MaxDamageAmount;
      Crane.chemical_rack.MinDamageAmount = level.GasMachine.MinDamageAmount;

      Crane.chemical_rack thread WatchDamageChemical(Crane);

      Crane.chemical_rack.CraneChemCollision = CollisionData.Collision;
      level.GasMachine.CraneChemCollision = CollisionData.pool;
      Crane.chemical_rack.CraneChemCollision thread entity_path_disconnect_thread(1);
      Crane.chemical_rack.CraneChemCollision.origin = Crane.chemical_rack.origin;
      Crane.chemical_rack.CraneChemCollision.angles = Crane.chemical_rack.angles;
      Crane.chemical_rack.CraneChemCollision LinkToSynchronizedParent(Crane.chemical_rack);
    } else {
      Crane.has_chemicals = false;
    }
  } else {
    Crane.has_chemicals = false;
  }

  Crane ScriptModelPlayAnimDeltaMotion("lab2_industrial_crane_anim", "crane_note_track");

  return Crane;
}

PlayOrangeGoo(chemical_rack) {
  waitframes = 3;

  for(i = 0; i < waitframes; i++) {
    wait(0.05);
    if(isDefined(chemical_rack) && !IsRemovedEntity(chemical_rack)) {
      chemical_rack show();
      if(i == 2) {
        vfx = playFXOnTag(getfx("lab_canister_liquid_orange"), chemical_rack, "tag_origin");
        chemical_rack show();
      }
    } else {
      return;
    }
  }
}

PlayCraneSpawnVfX() {
  TimeToWaitBeforeMeshSpawn = 0.05;
  origin_offset = level.GasMachine.ParticleSpawnOriginOffset;

  wait(0.05);

  if(!isDefined(self)) {
    return;
  }

  vfx_origin = self.origin + origin_offset;

  wait(TimeToWaitBeforeMeshSpawn);

  return;
}
GetCollision(pool) {
  if(pool.size > 0) {
    CollisionData = spawnStruct();
    CollisionData.Collision = pool[pool.size - 1];
    pool = array_remove(pool, CollisionData.Collision);
    pool = array_remove_duplicates(pool);
    CollisionData.pool = pool;
    return CollisionData;
  } else {
    return;
  }
}
AddCollisionToPool(pool) {
  self notify("entity_path_disconnect_thread");
  self unlink();
  self.origin = (0, 0, -5000);
  pool = add_to_array(pool, self);
  return pool;
}
WatchDamageChemical(Crane) {
  self endon("deleted");
  self endon("death");

  self.health = 10000000;
  self.fakehealth = level.GasMachine.TotalChemCanHealth;
  self setCanDamage(true);
  self setCanRadiusDamage(true);
  self.leaking = false;

  while(true) {
    if(isDefined(self)) {
      self waittill("damage", amount, attacker, direction, point, means_of_death, model, tag, part_name, damage_flags, weapon_name);
      if(isDefined(weapon_name)) {
        shortWeaponName = maps\mp\_utility::strip_suffix(weapon_name, "_lefthand");

        switch (shortWeaponName) {
          case "concussion_grenade_mp":
          case "flash_grenade_mp":
          case "smoke_grenade_mp":
          case "mp_lab_gas":
          case "mp_lab_gas_explosion":
          case "paint_grenade_mp":
            continue;
        }

        if(IsSubStr(weapon_name, "m990")) {
          if(means_of_death == "MOD_PISTOL_BULLET") {
            amount = 50;
          } else if(means_of_death == "MOD_EXPLOSIVE") {
            amount = 100;
          }
        }
      }
      if(isDefined(means_of_death)) {
        if(isMeleeMOD(means_of_death) || means_of_death == "MOD_TRIGGER_HURT") {
          continue;
        }
      }

      if(isDefined(attacker)) {
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("standard");
      }

      if(Crane.exploding == false) {
        self.fakehealth = self.fakehealth + (amount * -1);
        if(self.fakehealth <= 0) {
          thread PauseRackSystem();
          self thread BlowItUp(Crane, attacker);
          level notify("Chemical_Exploded");
          break;
        }
      } else if(Crane.exploding == true) {
        break;
      }
    } else if(!isDefined(self)) {
      break;
    }
  }
}

TimeBomb(attacker) {
  self endon("deleted");
  self endon("death");
  self thread TimeBombParticle(level.MissileParticles.SparkGreenLoop);
  DamageValue = level.GasMachine.TotalChemCanHealth * 0.05;
  DamageValue = Int(DamageValue);
  while(isDefined(self)) {
    wait(1);
    self notify("damage", DamageValue, attacker);
  }
}
TimeBombParticle(Particle) {
  self thread play_loop_sound_on_entity("mp_lab_gas_leak_loop01", (0, 0, 64));

  playFXOnTag(Particle, self, "tag_origin");
}
BlowItUp(Crane, attacker) {
  Crane endon("death");

  DeleteDelay = 0.1;
  Crane.exploding = true;

  RackOrigin = self.origin;

  if(isDefined(self) && !IsRemovedEntity(self)) {
    if(isDefined(self.CraneChemCollision)) {
      self notify("entity_path_disconnect_thread");
      self.CraneChemCollision ConnectPaths();
    }
  }

  offset = level.GasMachine.ExplosionOffset;
  angle_offset = level.GasMachine.ExplosionAngleOffset;
  ExplosionTag = thread spawn_tag_origin();
  ExplosionTag show();
  ExplosionTag DontInterpolate();
  ExplosionTag.origin = Crane.origin + (0, 0, offset);
  ExplosionTag.angles = angle_offset;
  ExplosionTag LinkToSynchronizedParent(Crane, "tag_origin");

  playFXOnTag(level.MissileParticles.MissileExplosion, ExplosionTag, "tag_origin");
  ExplosionTag thread DeleteExplosionTag(crane, self, 0.05);

  sfx_pos = Crane.origin + (0, 0, offset);
  thread aud_play_tank_explosion(sfx_pos);

  wait(0.05);

  if(isDefined(self) && !IsRemovedEntity(self)) {
    if(isDefined(self.CraneChemCollision)) {
      level.GasMachine.CraneChemCollision = self.CraneChemCollision AddCollisionToPool(level.GasMachine.CraneChemCollision);
    }
    killfxontag(getfx("lab_canister_liquid_orange"), self, "tag_origin");

    self delayThread(DeleteDelay, ::unlinkAndDelete);
  }
  if(isDefined(Crane) && !IsRemovedEntity(Crane)) {
    Crane.has_chemicals = false;
  }

  wait(DeleteDelay + 0.05);

  thread MissileExplosion(attacker, RackOrigin);
  thread MissileChem(level.MissileParticles.GreenSmokeLoop, RackOrigin + (0, 0, -70), attacker);
}

DeleteExplosionTag(crane, rack, time) {
  rack waittill_any("death", "deleted");
  wait(time);
  if(isDefined(self) && !IsRemovedEntity(self)) {
    self delete();
  }
}

KillChemRackVFX() {
  self endon("death");
  wait(0.05);
  if(isDefined(self) && !IsRemovedEntity(self)) {
    killfxontag(getfx("lab_canister_liquid_orange"), self, "tag_origin");
    wait(0.05);
    if(isDefined(self) && !IsRemovedEntity(self)) {
      self delete();
    }
  }
}
unlinkAndDelete() {
  if(isDefined(self) && !IsRemovedEntity(self)) {
    self Unlink();
    self delete();
  }
}

MissileExplosion(attacker, RackOrigin) {
  if(isDefined(attacker)) {
    RadiusDamage(RackOrigin + (0, 0, -44), level.GasMachine.DamageRadius, level.GasMachine.MaxDamageAmount, level.GasMachine.MinDamageAmount, attacker, "MOD_EXPLOSIVE", "mp_lab_gas_explosion");
  } else {
    RadiusDamage(RackOrigin + (0, 0, -44), level.GasMachine.DamageRadius, level.GasMachine.MaxDamageAmount, level.GasMachine.MinDamageAmount, undefined, "MOD_EXPLOSIVE", "mp_lab_gas_explosion");
  }
}
MissileChem(Particle, ChemicalOrigin, attacker) {
  level.GasParticleTime = level.PauseTime * 0.15;
  SpawnedFX = SpawnFx(Particle, ChemicalOrigin + (0, 0, 0));

  GasCloud = spawn("script_origin", ChemicalOrigin);
  thread ChemDamageThink(GasCloud, ChemicalOrigin, attacker);

  wait(level.GasParticleTime);

  wait(5);
  GasCloud notify("Gas_Particle_Gone");
  wait(1);

  GasCloud DeleteDefined();
  SpawnedFX DeleteDefined();
}
DeleteDefined() {
  if(isDefined(self)) {
    self delete();
  }
}
ChemDamageThink(GasCloud, ChemicalOrigin, attacker) {
  GasCloud endon("Gas_Particle_Gone");
  while(true) {
    if(isDefined(attacker)) {
      attacker RadiusDamage(ChemicalOrigin, level.GasMachine.GasRange, 10, 10, attacker, "MOD_TRIGGER_HURT", "mp_lab_gas");
    } else {
      RadiusDamage(ChemicalOrigin, level.GasMachine.GasRange, 10, 10, undefined, "MOD_TRIGGER_HURT", "mp_lab_gas");
    }
    thread FindShockVictims(ChemicalOrigin);

    wait(1);
  }
}
FindShockVictims(location) {
  damageRange = level.GasMachine.GasRange * level.GasMachine.GasRange;

  foreach(player in level.players) {
    if(!player isUsingRemote()) {
      Dist2 = DistanceSquared(player.origin, location);

      if((Dist2 < damageRange) && (!player _hasPerk("specialty_stun_resistance"))) {
        player thread ShockThink();
      }
    }
  }
}
ShockThink() {
  if(self.GasTime <= 0) {
    self thread fadeInOutGasTrackingOverlay();
    self thread RempveOverlayDeath();
  }
  self.GasTime = 2;
  self shellshock("mp_lab_gas", 1);
  while(self.GasTime > 0) {
    self.GasTime--;
    wait(1);
  }
  self notify("gas_end");
  self EndGasTrackingOverlay();
}
RempveOverlayDeath() {
  self endon("gas_end");
  self waittill("death");
  self thread EndGasTrackingOverlayDeath();
}

ParticleSprayMultipleNode(note, Time) {
  foreach(pos in level.GasMachine.MachineSparkArray) {
    if(pos.script_noteworthy == note) {
      self playSound("emt_water_spray_hard");
      pos thread ParticleSpray(level.MissileParticles.SprayMachine, pos.angles, Time);
    }
  }

  foreach(pos in level.GasMachine.SprayerDripArray) {
    if(pos.script_noteworthy == note) {
      pos thread SprayerDrip(level.MissileParticles.SprayMachineDrips, pos.angles, Time);
    }
  }
}

StartCanisterFX(fx, waitTime) {
  wait waitTime;

  dripTime = 0;
  loopTime = 0.1;

  while(dripTime < 4.25) {
    if(isDefined(self) && self.has_chemicals == true) {
      fxOrg = self.origin + (0, 0, -8);
      fxAngle = self.angles + (270, 0, 0);
      playFX(fx, fxOrg, anglesToForward(fxAngle), AnglesToUp(fxAngle));
      wait loopTime;
      dripTime += loopTime;
    } else {
      return;
    }
  }
}

ParticleSpray(Particle, ParticleAngles, Time) {
  SpawnedFX = SpawnFx(Particle, self.origin, anglesToForward(ParticleAngles), AnglesToUp(ParticleAngles));
  TriggerFX(SpawnedFX);

  if(isDefined(Time)) {
    wait(Time);
  }

  if(isDefined(SpawnedFX)) {
    SpawnedFX delete();
  }
}

SprayerDrip(Particle, ParticleAngles, Time) {
  if(isDefined(Time)) {
    wait(Time);
  }

  playFX(Particle, self.origin, anglesToForward(ParticleAngles), AnglesToUp(ParticleAngles));
}

RemoveRack() {
  if(isDefined(self) && !IsRemovedEntity(self)) {
    if(isDefined(self.chemical_rack) && !IsRemovedEntity(self.chemical_rack)) {
      KillFXOnTag(getfx("lab_canister_liquid_orange"), self.chemical_rack, "tag_origin");
    }
    wait(0.05);

    if(isDefined(self) && !IsRemovedEntity(self)) {
      if(isDefined(self.chemical_rack) && !IsRemovedEntity(self.chemical_rack)) {
        if(isDefined(self.chemical_rack.CraneChemCollision)) {
          level.GasMachine.CraneChemCollision = self.chemical_rack.CraneChemCollision AddCollisionToPool(level.GasMachine.CraneChemCollision);
        }

        self.chemical_rack unlink();
        self.chemical_rack delete();
      }
      level.GasMachine.CraneCollision = self.CraneCollision AddCollisionToPool(level.GasMachine.CraneCollision);
      self notify("deleted");
      self delete();
    }
  }
  thread RemoveFromTotalSpawned();
}
PauseRackSystem() {
  if(!isDefined(level.PauseTime)) {
    level.PauseTime = 20;
  }

  level.GasMachine.chemical_rackPauseTime = level.PauseTime;
  if(level.GasMachine.chemical_racksActive == true) {
    array_thread(level.AlarmSystem.SpinnerArray, ::SpinAlarmsStart);
  }

  if(level.GasMachine.chemical_racksActive == true) {
    thread PlayAlarmLoop();
  } else {
    return;
  }

  level.GasMachine.chemical_racksActive = false;

  while(level.GasMachine.chemical_rackPauseTime > 0) {
    wait(1);
    level.GasMachine.chemical_rackPauseTime--;
  }

  array_thread(level.AlarmSystem.SpinnerArray, ::SpinAlarmsStop);
  level.GasMachine.chemical_racksActive = true;
  level notify("Restarting_System");
}

SpinAlarmsStart() {
  self hide();

  level thread common_scripts\_exploder::activate_clientside_exploder(200);
}

SpinAlarmsStop() {
  self show();

  StopClientExploder(200);
}

PlayAlarmLoop() {
  TempSoundEnt = spawn("script_origin", level.AlarmSystem.AlarmSoundEnt.origin);
  TempSoundEnt playLoopSound("mp_lab_alarm_shutdown01");
  wait(5);
  TempSoundEnt StopSounds();
  wait(0.05);
  TempSoundEnt delete();
}

CreateGasTrackingOverlay() {
  if(!isDefined(self.GasTrackingOverlay)) {
    self.GasTrackingOverlay = newClientHudElem(self);
    self.GasTrackingOverlay.x = 0;
    self.GasTrackingOverlay.y = 0;
    self.GasTrackingOverlay setshader("lab_gas_overlay", 640, 480);
    self.GasTrackingOverlay.alignX = "left";
    self.GasTrackingOverlay.alignY = "top";
    self.GasTrackingOverlay.horzAlign = "fullscreen";
    self.GasTrackingOverlay.vertAlign = "fullscreen";
    self.GasTrackingOverlay.alpha = 0;
  }
}
fadeInOutGasTrackingOverlay() {
  level endon("game_ended");
  self endon("gas_end");
  self endon("death");

  if(isDefined(self.GasTrackingOverlay)) {
    while(true) {
      self.GasTrackingOverlay FadeOverTime(0.4);
      self.GasTrackingOverlay.alpha = 1;
      wait(0.5);
      self.GasTrackingOverlay FadeOverTime(0.4);
      self.GasTrackingOverlay.alpha = 0.5;
      wait(0.5);
    }
  }
}
EndGasTrackingOverlay() {
  if(isDefined(self.GasTrackingOverlay)) {
    self.GasTrackingOverlay FadeOverTime(0.2);
    self.GasTrackingOverlay.alpha = 0.0;
  }
}
EndGasTrackingOverlayDeath() {
  if(isDefined(self.GasTrackingOverlay)) {
    self.GasTrackingOverlay.alpha = 0.0;
  }
}

setup_audio() {}

aud_play_tank_explosion(sfx_pos) {
  thread snd_play_in_space("lab2_tank_exp", sfx_pos);
}

aud_transport_chopper() {
  heli_ent = self;
  heli_sfx_loop = "veh_drone_heavy_lifter_lp";
  thread snd_play_linked_loop(heli_sfx_loop, heli_ent);
  heli_ent thread aud_warning_vo();
}

aud_warning_vo() {
  wait(32);

  thread snd_play_linked("vo_heli_warn_ext", self);

  wait(6.5);

  thread snd_play_linked("vo_heli_warn_ext", self);
}
aud_building_pre_drop() {
  thread snd_play_linked("lab2_building_sway", self);
}

aud_building_drop() {
  thread snd_play_linked("lab2_building_drop", self);
}