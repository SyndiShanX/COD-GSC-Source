/********************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_orbital_carepackage.gsc
********************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\killstreaks\_orbital_util;

NODE_OFFSET = (0, 0, 70);
FLY_NODE_OFFSET = (0, 0, 40);
DROPPOINT_DISTANCE_SQ = 22500;

init() {
  level._orbital_care_pod = [];
  level.orbitalDropMarkers = [];
  level._effect["ocp_death"] = LoadFX("vfx/explosion/exo_droppod_explosion");
  level._effect["ocp_midair"] = LoadFX("vfx/explosion/exo_droppod_split");
  level._effect["ocp_ground_marker"] = LoadFX("vfx/unique/vfx_marker_killstreak_guide_carepackage");
  level._effect["ocp_ground_marker_bad"] = LoadFX("vfx/unique/vfx_marker_killstreak_guide_carepackage_fizzle");
  level._effect["ocp_exhaust"] = LoadFX("vfx/vehicle/vehicle_ocp_exhaust");
  level._effect["ocp_thruster_small"] = LoadFX("vfx/vehicle/vehicle_ocp_thrusters_small");
  level._effect["vfx_ocp_steam"] = LoadFX("vfx/steam/vfx_ocp_steam");
  level._effect["vfx_ocp_steam2"] = LoadFX("vfx/steam/vfx_ocp_steam2");
  level._effect["ocp_glow"] = LoadFX("vfx/unique/orbital_carepackage_glow");

  level.killStreakFuncs["orbital_carepackage"] = ::tryUseDefaultOrbitalCarePackage;
  level.killstreakWieldWeapons["orbital_carepackage_pod_mp"] = "orbital_carepackage";
  level.killstreakFuncs["orbital_carepackage_juggernaut_exosuit"] = ::tryUseOrbitalJuggernautExosuit;

  PrecacheMpAnim("orbital_care_package_open");
  PrecacheMpAnim("orbital_care_package_fan_spin");

  level thread debugDestroyCarepackages();
}

tryUseDefaultOrbitalCarePackage(lifeId, modules) {
  return tryUseOrbitalCarePackage(lifeId, "orbital_carepackage", modules);
}

tryUseOrbitalJuggernautExosuit(lifeId, modules) {
  return tryUseOrbitalCarePackage(lifeId, "orbital_carepackage_juggernaut_exosuit", modules);
}

tryUseOrbitalCarePackage(lifeId, streakName, modules) {
  if(array_contains(modules, "orbital_carepackage_drone") && currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + 1 >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_TOO_MANY_VEHICLES");
    return false;
  }

  result = self playerLaunchCarepackage(streakName, modules);

  if(!isDefined(result) || !result) {
    return false;
  }

  if(streakName == "orbital_carepackage") {
    self maps\mp\gametypes\_missions::processChallenge("ch_streak_orbitalcare", 1);
  }

  return true;
}

playerLaunchCarepackage(streakName, modules) {
  outsideNode = self playerGetOutsideNode("carepackage");
  outsidePosition = undefined;

  if(isDefined(outsideNode)) {
    outsidePosition = outsideNode.origin;
  } else {
    if(isDefined(level.isHorde) && level.isHorde) {
      outsideNode = [[level.hordeGetOutsidePosition]]();
      outsidePosition = outsideNode.origin;
    } else {
      self thread playerPlayInvalidPositionEffect(getfx("ocp_ground_marker_bad"));
      self SetClientOmnvar("ui_invalid_orbital_care_package", 1);
      return false;
    }
  }

  drone = undefined;
  if(array_contains(modules, "orbital_carepackage_drone")) {
    drone = SpawnHelicopter(self, outsidePosition + (0, 0, 200), (0, 0, 0), "orbital_carepackage_drone_mp", "orbital_carepackage_pod_01_vehicle");
    if(!isDefined(drone)) {
      return false;
    }
    drone Hide();
  }

  result = FirePod("orbital_carepackage_pod_mp", self, outsideNode, streakName, modules, drone, undefined, undefined, true);

  return isDefined(result);
}

FirePod(weaponType, player, node, streakName, modules, drone, startPos, excludedCrateTypes, giveBackCarepackage) {
  if(!isDefined(startPos)) {
    startPos = player playerGetOrbitalStartPos(node, "carepackage");
  }
  targetPos = node.origin;

  if(!isDefined(excludedCrateTypes)) {
    excludedCrateTypes = [];
  }

  debugPlacementLine(startPos, targetPos, (0, 1, 0));
  podrocket = MagicBullet(weaponType, startPos, targetPos, player);

  if(!isDefined(podrocket)) {
    return;
  }

  podrocket thread SetMissileSpecialClipmaskDelayed(3.0);
  podrocket thread trajectory_kill(player);

  DropPod = player createPlayerDropPod(podrocket);
  DropPod.streakName = streakName;
  DropPod.modules = modules;
  DropPod.dropPoint = node.origin;
  DropPod.drone = drone;
  DropPod.giveBackCarepackage = giveBackCarepackage;

  podrocket.team = player.team;
  podrocket.owner = player;
  podrocket.type = "remote";

  return monitorDrop(player, podrocket, DropPod, streakName, excludedCrateTypes, weaponType);
}

trajectory_kill(player) {
  self endon("death");

  lastOrigin = self.origin;

  while(isDefined(self)) {
    if(!level.teamBased) {
      capsule_damage(10000, self.origin, lastOrigin, 30, undefined, player);
    } else {
      capsule_damage(10000, self.origin, lastOrigin, 30, level.otherTeam[player.team], player);
    }
    lastOrigin = self.origin;
    wait 0.05;
  }
}

capsule_damage(damage, origin1, origin2, radius, killTeam, attacker) {
  assert(radius > 0);

  delta = origin2 - origin1;
  deltaNml = VectorNormalize(delta);
  dist = Length(delta);
  radiusSq = radius * radius;

  foreach(enemy in level.characters) {
    if(!IsAlive(enemy)) {
      continue;
    }

    if(enemy != attacker && isDefined(killTeam) && isDefined(enemy.team) && enemy.team != killTeam) {
      continue;
    }

    deltaEnemy = enemy.origin - origin1;
    dot = VectorDot(deltaEnemy, deltaNml);

    if(dot > (radius * -1) && dot < dist + radius) {
      closestPoint = origin1 + (deltaNml * dot);
      distEnemySq = DistanceSquared(closestPoint, enemy.origin);
      if(distEnemySq <= radiusSq) {
        enemy DoDamage(damage, closestPoint, attacker, self, "MOD_EXPLOSIVE", "orbital_carepackage_pod_mp");
      }
    }
  }
}

SetMissileSpecialClipmaskDelayed(delayTime) {
  self endon("death");
  wait delayTime;
  self SetMissileSpecialClipmask(true);
}

createPlayerDropPod(podrocket) {
  PodNum = 0;

  if(!isDefined(level._orbital_care_pod)) {
    level._orbital_care_pod = [];
  } else {
    level._orbital_care_pod = cleanArray(level._orbital_care_pod);
    PodNum = level._orbital_care_pod.size;
  }
  level._orbital_care_pod[PodNum] = spawnStruct();
  level._orbital_care_pod[PodNum].HasLeftCam = false;
  level._orbital_care_pod[PodNum].podrocket = podrocket;
  level._orbital_care_pod[PodNum].podrocket.maxhealth = 100;
  level._orbital_care_pod[PodNum].podrocket.health = 100;
  level._orbital_care_pod[PodNum].podrocket.damageTaken = 0;
  level._orbital_care_pod[PodNum].podrocket.isPodRocket = true;
  level._orbital_care_pod[PodNum].owner = self;
  level._orbital_care_pod[PodNum].alive = true;
  return level._orbital_care_pod[PodNum];
}

Rocket_CleanupOnDeath() {
  entityNumber = self getEntityNumber();
  level.rockets[entityNumber] = self;
  self waittill("death");

  level.rockets[entityNumber] = undefined;

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt Unlink();
    self.killCamEnt.origin += (0, 0, 300);
  }
}

getDropTypeFromStreakName(streakName) {
  switch (streakName) {
    case "orbital_carepackage_juggernaut_exosuit":
      return "orbital_carepackage_juggernaut_exosuit";
    case "airdrop_reinforcement_common":
      return "airdrop_reinforcement_common";
    case "airdrop_reinforcement_uncommon":
      return "airdrop_reinforcement_uncommon";
    case "airdrop_reinforcement_rare":
      return "airdrop_reinforcement_rare";
    case "airdrop_reinforcement_practice":
      return "airdrop_reinforcement_practice";
    case "horde_support_drop":
      return "horde_support_drop";
    default:
      return "airdrop_assault";
  }
}

allowDroneDelivery(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(level.teamBased && level.teamEMPed[player.team]) {
    return false;
  }

  if(!level.teamBased && isDefined(level.empPlayer) && level.empPlayer != player) {
    return false;
  }

  return true;
}

monitorDrop(player, podrocket, DropPod, streakName, excludedCrateTypes, weaponType) {
  droptype = getDropTypeFromStreakName(streakName);
  if(droptype == "airdrop_assault" && array_contains(DropPod.modules, "orbital_carepackage_odds")) {
    droptype = "airdrop_assault_odds";
  }
  if(isDefined(level.getCrateForDropType)) {
    crateType = [[level.getCrateForDropType]](dropType);
  } else {
    crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType(droptype);
  }

  thread monitorDropInternal(player, podrocket, DropPod, droptype, crateType, weaponType);

  return crateType;
}

monitorDropInternal(player, podrocket, DropPod, droptype, crateType, weaponType) {
  level endon("game_ended");

  podrocket thread Rocket_CleanupOnDeath();

  hasTrap = array_contains(DropPod.modules, "orbital_carepackage_trap");
  dropCrate = player maps\mp\killstreaks\_airdrop::createAirDropCrate(player, droptype, crateType, podrocket.origin, undefined, hasTrap, false);
  dropCrate.moduleTrap = array_contains(DropPod.modules, "orbital_carepackage_trap");
  dropCrate.moduleHide = array_contains(DropPod.modules, "orbital_carepackage_hide");
  dropCrate.moduleRoll = array_contains(DropPod.modules, "orbital_carepackage_roll");
  dropCrate.modulePickup = array_contains(DropPod.modules, "orbital_carepackage_fast_pickup");
  dropCrate.angles = (0, 0, 0);

  podrocket.killCamEnt = dropCrate.killCamEnt;

  if(weaponType == "orbital_carepackage_pod_plane_mp") {
    podrocket.killCamEnt.killCamStartTime = GetTime();
  }

  droneDelivery = array_contains(DropPod.modules, "orbital_carepackage_drone");

  marker = spawn("script_model", DropPod.dropPoint + (0, 0, 5));
  marker.angles = (-90, 0, 0);
  marker setModel("tag_origin");
  marker Hide();
  marker ShowToPlayer(player);
  playFXOnTag(getfx("ocp_ground_marker"), marker, "tag_origin");
  marker thread carePackageSetupMinimap(DropPod.modules, player);

  maps\mp\killstreaks\_orbital_util::addDropMarker(marker);

  if(droneDelivery) {
    player thread playerMonitorForDroneDelivery(podrocket, DropPod, marker, dropCrate);
  }

  dropCrate LinkTo(podrocket, "tag_origin", (0, 0, 0), (-90, 0, 0));

  podrocket waittill("death", attacker_ent, means_of_death, weapon_name);

  if(isDefined(podrocket) && !droneDelivery && podrocket.origin[2] > DropPod.dropPoint[2] && DistanceSquared(podrocket.origin, DropPod.dropPoint) > DROPPOINT_DISTANCE_SQ) {
    if(DropPod.giveBackCarepackage) {
      if(isDefined(level.isHorde) && level.isHorde) {
        outsidePosition = [[level.hordeGetOutsidePosition]]();
        FirePod("orbital_carepackage_pod_mp", self, outsidePosition, "horde_support_drop", DropPod.modules, false, undefined, undefined, true);
      } else {
        if(isDefined(player)) {
          player playerGiveBackCarepackage(DropPod);
        }
      }
    }
    level thread cleanupCarepackage(DropPod, dropCrate, marker);
    return;
  }

  if(droneDelivery && allowDroneDelivery(player) && isDefined(DropPod.drone)) {
    DropPod.drone Show();
  } else {
    Earthquake(0.4, 1, DropPod.dropPoint, 800);
    PlayRumbleOnPosition("artillery_rumble", DropPod.dropPoint);
  }

  KillFXOnTag(getfx("ocp_ground_marker"), marker, "tag_origin");

  DropPod.alive = false;

  if(droneDelivery && allowDroneDelivery(player) && isDefined(DropPod.drone)) {
    DropPod.drone waittill("delivered");
    dropCrate SetContents(dropCrate.oldContents);
    dropCrate.oldContents = undefined;
  }

  marker thread carepackageCleanup(dropCrate);

  dropCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);

  dropCrate.droppingToGround = true;

  dropCrate Unlink();
  dropCrate PhysicsLaunchServer((0, 0, 0));
  dropCrate thread crateDetectStopPhysics();
  dropCrate thread orbitalPhysicsWaiter(droptype, crateType, player);

  level thread RemovePod(dropCrate, DropPod);
}

crateImpactCleanup(player) {
  if(!isDefined(player)) {
    return;
  }

  nearestNodes = GetNodesInRadiusSorted(self.origin, 300, 0, 300);

  foreach(character in level.characters) {
    if(!IsAlive(character)) {
      continue;
    }

    if(IsAlliedSentient(character, player)) {
      if(character IsTouching(self)) {
        foreach(node in nearestNodes) {
          if(DistanceSquared(node.origin, self.origin) > 100 * 100) {
            character SetOrigin(node.origin, true);
            nearestNodes = array_remove(nearestNodes, node);
            break;
          }
        }
      }
    }
  }
}

crateDetectStopPhysics() {
  self endon("physics_finished");
  self endon("death");

  SECONDS_TO_STOP_PHYSICS = 4;
  NUM_FRAMES_TO_STOP_PHYSICS = SECONDS_TO_STOP_PHYSICS / 0.05;
  DIST_NOT_MOVING_SQ = 5 * 5;

  numFrames = 0;
  lastOrigin = self.origin;
  while(true) {
    waitframe();

    distSq = DistanceSquared(lastOrigin, self.origin);
    if(distSq < DIST_NOT_MOVING_SQ) {
      numFrames++;
    } else {
      numFrames = 0;
    }

    lastOrigin = self.origin;

    if(numFrames >= NUM_FRAMES_TO_STOP_PHYSICS) {
      self PhysicsStop();
      return;
    }
  }
}

playerGiveBackCarepackage(DropPod) {
  streakVal = self maps\mp\killstreaks\_killstreaks::getStreakCost("orbital_carepackage");
  slotIndex = self maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex("orbital_carepackage", false);
  self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify("orbital_carepackage", streakVal, undefined, DropPod.modules, slotIndex);
  self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("orbital_carepackage", false, false, self, DropPod.modules);
}

cleanupCarepackage(DropPod, dropCrate, marker) {
  if(isDefined(dropCrate)) {
    self thread RemovePod(dropCrate, DropPod);
    dropCrate Delete();
  }

  if(isDefined(DropPod.drone)) {
    DropPod.drone maps\mp\killstreaks\_drone_carepackage::carepackageDrone_remove();
  }

  if(isDefined(marker)) {
    if(isDefined(marker.objIdFriendly)) {
      _objective_delete(marker.objIdFriendly);
    }
    if(isDefined(marker.objIdEnemy)) {
      _objective_delete(marker.objIdEnemy);
    }
    KillFXOnTag(getfx("ocp_ground_marker"), marker, "tag_origin");
    waitframe();
    marker Delete();
  }
}

orbitalPhysicsWaiter(droptype, crateType, player) {
  self endon("death");
  self maps\mp\killstreaks\_airdrop::physicsWaiter(droptype, crateType);

  self playSound("orbital_pkg_panel");

  if(isDefined(self.enemymodel)) {
    self.enemymodel thread orbitalAnimate();
    self.enemyModel Solid();
  }
  if(isDefined(self.friendlymodel)) {
    self.friendlymodel thread orbitalAnimate();
    self.friendlymodel Solid();
  }

  self thread crateImpactCleanup(player);
}

orbitalAnimate(alreadyOpen) {
  self endon("death");

  if(!isDefined(alreadyOpen) || !alreadyOpen) {
    wait .75;
  }

  if(isDefined(alreadyOpen) && alreadyOpen) {
    self ScriptModelPlayAnim("orbital_care_package_open_loop");
  } else {
    self ScriptModelPlayAnim("orbital_care_package_open");
  }

  playFXOnTag(getfx("ocp_glow"), self, "TAG_ORIGIN");

  if(!isDefined(alreadyOpen) || !alreadyOpen) {
    waitframe();

    playFXOnTag(getfx("vfx_ocp_steam2"), self, "TAG_FX_PANEL_F");
    playFXOnTag(getfx("vfx_ocp_steam2"), self, "TAG_FX_PANEL_K");

    waitframe();

    playFXOnTag(getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_FR");
    playFXOnTag(getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_KL");

    waitframe();

    playFXOnTag(getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_FL");
    playFXOnTag(getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_KR");
  }
}

delayCleanupDropPod(dropPod) {
  wait 5;
  dropPod Delete();
}

RemovePod(Crate, DropPod) {
  Crate waittill("death");
  wait(15);
  for(i = 0; i < level._orbital_care_pod.size; i++) {
    if(isDefined(level._orbital_care_pod[i]) && level._orbital_care_pod[i] == DropPod) {
      if(level._orbital_care_pod[i].alive == false) {
        level._orbital_care_pod[i] = undefined;
      }
    }
  }
  if(isDefined(DropPod)) {
    DropPod = undefined;
  }
}

carePackageSetupMinimap(modules, carrier) {
  self endon("death");

  if(array_contains(modules, "orbital_carepackage_hide")) {
    return;
  }

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "invisible", (0, 0, 0));
  Objective_Position(curObjID, self.origin);
  Objective_State(curObjID, "active");

  shaderName = "compass_objpoint_ammo_friendly";
  Objective_Icon(curObjID, shaderName);

  if(!level.teamBased) {
    Objective_PlayerTeam(curObjId, carrier GetEntityNumber());
  } else {
    Objective_Team(curObjID, carrier.team);
  }

  self.objIdFriendly = curObjID;

  if(!(isDefined(level.isHorde) && level.isHorde)) {
    curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
    Objective_Add(curObjID, "invisible", (0, 0, 0));
    Objective_Position(curObjID, self.origin);
    Objective_State(curObjID, "active");
    Objective_Icon(curObjID, "compass_objpoint_ammo_enemy");

    if(!level.teamBased) {
      Objective_PlayerEnemyTeam(curObjId, carrier GetEntityNumber());
    } else {
      Objective_Team(curObjID, level.otherTeam[carrier.team]);
    }

    self.objIdEnemy = curObjID;
  }

  if(array_contains(modules, "orbital_carepackage_drone")) {
    self waittill("linkedToDrone");

    Objective_OnEntity(self.objIdFriendly, self);
    if(isDefined(self.objIdEnemy)) {
      Objective_OnEntity(self.objIdEnemy, self);
      self Show();
    }
  }
}

carepackageCleanup(dropCrate) {
  dropCrate waittill_any("physics_finished", "death");

  if(isDefined(self.objIdFriendly)) {
    _objective_delete(self.objIdFriendly);
  }

  if(isDefined(self.objIdEnemy)) {
    _objective_delete(self.objIdEnemy);
  }

  KillFXOnTag(getfx("ocp_glow"), self, "TAG_ORIGIN");

  if(isDefined(level.isHorde) && level.isHorde) {
    dropCrate notify("drop_pod_cleared");
  }

  waitframe();

  self Delete();
}

setupDamageCallback(crate) {
  crate.health = 500;
  crate.maxhealth = crate.health;
  crate.readyToDie = false;
  setupDamageCallbackInternal(crate.friendlyModel);
  setupDamageCallbackInternal(crate.enemyModel);
}

setupDamageCallbackInternal(crate) {
  crate thread maps\mp\gametypes\_damage::setEntityDamageCallback(9999, undefined, undefined, ::crateHandleDamageCallback, true);
}

disableDamageCallback(crate) {
  disableDamageCallbackInternal(crate.friendlyModel);
  disableDamageCallbackInternal(crate.enemyModel);
}

disableDamageCallbackInternal(crate) {
  crate.damageCallback = undefined;
  crate setCanDamage(false);
  crate SetDamageCallbackOn(false);
}

crateHandleDamageCallback(attacker, weapon, type, damage) {
  parentCrate = self;
  if(isDefined(self.parentCrate)) {
    parentCrate = self.parentCrate;
  }

  finalDamage = self maps\mp\gametypes\_damage::modifyDamage(attacker, weapon, type, damage);

  parentCrate.health -= finalDamage;

  if(parentCrate.health <= 0) {
    disableDamageCallback(parentCrate);
    parentCrate notify("disabled");
  }

  return 0;
}

playerMonitorForDroneDelivery(podRocket, dropPod, marker, dropCrate) {
  self endon("disconenct");;
  self endon("joined_team");
  self endon("joined_spectators");

  SCR_CONST_REACHED_NODE_RADIUS_SQ = 24 * 24;
  DIST_TO_GROUND_SQ = 500 * 500;
  targetPos = dropPod.dropPoint;
  curPos = podRocket.origin;
  distToGroundSq = DistanceSquared(curPos, targetPos);

  setupDamageCallback(dropCrate);
  drone = dropPod.drone;
  drone thread carepackageDroneWatchCrateDeath(dropCrate);
  dropCrate.oldContents = dropCrate SetContents(0);
  dropCrate.friendlyModel Solid();
  dropCrate.enemyModel Solid();

  while(true) {
    if(!isDefined(podRocket)) {
      break;
    }

    curPos = podRocket.origin;
    distToGroundSq = DistanceSquared(curPos, targetPos);

    if(distToGroundSq <= DIST_TO_GROUND_SQ) {
      break;
    }

    waitframe();
  }

  if(distToGroundSq > DIST_TO_GROUND_SQ) {
    if(dropPod.giveBackCarepackage && allowDroneDelivery(self)) {
      self playerGiveBackCarepackage(dropPod);
    }
    level thread cleanupCarepackage(dropPod, dropCrate, marker);
    return;
  }

  if(!isDefined(self)) {
    level thread cleanupCarepackage(dropPod, dropCrate, marker);
    return;
  }

  if(!allowDroneDelivery(self)) {
    level thread cleanupCarepackage(dropCrate, undefined, undefined);
    return;
  }

  drone thread carepackageDroneWatchDeath();
  drone endon("death");

  drone Vehicle_Teleport(dropCrate.origin, dropCrate.angles, false, false);
  dropCrate LinkTo(drone, "tag_origin", (0, 0, 0), (0, 0, 0));
  dropCrate.friendlyModel ScriptModelPlayAnim("orbital_care_package_fan_spin", "nothing");
  dropCrate.enemyModel ScriptModelPlayAnim("orbital_care_package_fan_spin", "nothing");
  maps\mp\killstreaks\_drone_carepackage::setupCarepackageDrone(drone, true);
  drone.crate = dropCrate;
  if(isDefined(podRocket)) {
    curPos = podRocket.origin;
    podRocket notify("death");
    podRocket Delete();
  }
  playSoundAtPos(curPos, "orbital_pkg_pod_midair_exp");
  playFX(getfx("ocp_midair"), curPos, GetDvarVector("scr_ocp_forward", (0, 0, -1)));
  drone thread drone_thrusterFX();

  goalPos = DropPod.dropPoint + NODE_OFFSET;

  drone SetVehGoalPos(goalPos, true);
  drone Vehicle_SetSpeedImmediate(GetDvarFloat("scr_ocp_dropspeed", 30), GetDvarFloat("scr_ocp_dropa", 20), GetDvarFloat("scr_ocp_dropd", 1));
  drone SetHoverParams(30, 5, 5);
  drone SetMaxPitchRoll(15, 15);

  while(DistanceSquared(drone.origin, goalPos) > SCR_CONST_REACHED_NODE_RADIUS_SQ && dropCrate.health > 0) {
    waitframe();
  }

  if(dropCrate.health > 0) {
    wait 1;
  }

  if(dropCrate.health > 0) {
    marker LinkTo(drone, "tag_origin");
    marker notify("linkedToDrone");

    drone thread maps\mp\killstreaks\_drone_carepackage::carepackageDrone_deleteOnActivate();
    drone carepackageDroneFindOwner();
  }

  disableDamageCallback(dropCrate);
  dropCrate PlaySoundOnMovingEnt("orbital_pkg_drone_jets_off");

  if(isDefined(drone)) {
    drone drone_stopThrusterEffects();
  }
  dropCrate.friendlyModel ScriptModelClearAnim("orbital_care_package_fan_spin", "nothing");
  dropCrate.enemyModel ScriptModelClearAnim("orbital_care_package_fan_spin", "nothing");

  waitframe();

  if(isDefined(drone)) {
    drone maps\mp\killstreaks\_drone_carepackage::carepackageDrone_Delete();
  }
}

carepackageDroneWatchDeath() {
  self endon("delivered");

  self waittill("death");
  self notify("delivered");
}

carepackageDroneWatchCrateDeath(crate) {
  self endon("delivered");

  crate waittill("disabled");
  self notify("delivered");
}

carepackageDroneDebugPathing() {
  owner = self.owner;
  owner endon("disconnect");
  self endon("death");
  self endon("delivered");

  toOwner = true;
  goalClient = self.owner;

  SetDvarIfUninitialized("scr_ocp_debugDeliveryNext", "0");

  DIST_BEFORE_DELIVERY_SQ = (150 * 150);

  restartPathing = true;
  nextGoalTime = GetTime();

  while(getDvar("scr_ocp_debugDelivery", "0") != "0") {
    while(true) {
      alive = isReallyAlive(goalClient);
      if(!alive) {
        restartPathing = true;
        waitframe();
      }

      if(nextGoalTime < GetTime() || restartPathing) {
        restartPathing = false;
        self SetDroneGoalPos(goalClient, FLY_NODE_OFFSET + (0, -100, 0));
        nextGoalTime = GetTime() + 1000;
      }

      distSq = DistanceSquared(self.origin, goalClient.origin + FLY_NODE_OFFSET);

      if(distSq < DIST_BEFORE_DELIVERY_SQ) {
        break;
      }

      waitframe();
    }

    while(getDvar("scr_ocp_debugDeliveryNext") == "0") {
      waitframe();
    }

    setDvar("scr_ocp_debugDeliveryNext", "0");

    toOwner = !toOwner;

    if(!toOwner && isDefined(level.players[1])) {
      goalClient = level.players[1];
    } else {
      goalClient = owner;
      toOwner = true;
    }
  }
}

carepackageDroneFindOwner() {
  owner = self.owner;
  owner endon("disconnect");
  self endon("death");
  self endon("delivered");

  if(getDvar("scr_ocp_debugDelivery", "0") != "0") {
    self carepackageDroneDebugPathing();
  }

  DIST_BEFORE_DELIVERY_SQ = (150 * 150);

  restartPathing = true;
  nextGoalTime = GetTime();

  while(true) {
    ownerAlive = isReallyAlive(owner);
    if(!ownerAlive) {
      restartPathing = true;
      waitframe();
    }

    if(nextGoalTime < GetTime() || restartPathing) {
      restartPathing = false;
      self SetDroneGoalPos(owner, FLY_NODE_OFFSET + (0, -100, 0));
      nextGoalTime = GetTime() + 1000;
    }

    distSq = DistanceSquared(self.origin, owner.origin + FLY_NODE_OFFSET);

    if(distSq < DIST_BEFORE_DELIVERY_SQ) {
      wait GetDvarFloat("scr_ocp_waitDeliver", 1);
      self notify("delivered");
      return;
    }

    waitframe();
  }
}

drone_thrusterFX() {
  self endon("death");

  playFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_fl");
  playFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_fr");
  playFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_kl");
  playFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_kr");
  waitframe();
  waitframe();
  if(isDefined(self)) {
    playFXOnTag(getfx("ocp_exhaust"), self, "tag_fx");
  }

  while(true) {
    level waittill("connected", player);

    self thread drone_thrusterPlayerConnected(player);
  }
}

drone_thrusterPlayerConnected(player) {
  player endon("disconnect");

  player waittill("spawned_player");

  if(isDefined(player) && isDefined(self)) {
    self drone_thrusterPlayer(player);
  }
}

drone_thrusterPlayer(player) {
  player endon("disconnect");
  self endon("death");

  PlayFXOnTagForClients(getfx("ocp_thruster_small"), self, "j_thruster_fl", player);
  PlayFXOnTagForClients(getfx("ocp_thruster_small"), self, "j_thruster_fr", player);
  PlayFXOnTagForClients(getfx("ocp_thruster_small"), self, "j_thruster_kl", player);
  PlayFXOnTagForClients(getfx("ocp_thruster_small"), self, "j_thruster_kr", player);
  waitframe();
  waitframe();
  if(isDefined(self)) {
    PlayFXOnTagForClients(getfx("ocp_exhaust"), self, "tag_fx", player);
  }
}

drone_stopThrusterEffects() {
  KillFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_fl");
  KillFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_fr");
  KillFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_kl");
  KillFXOnTag(getfx("ocp_thruster_small"), self, "j_thruster_kr");
  waitframe();
  waitframe();
  if(isDefined(self)) {
    KillFXOnTag(getfx("ocp_exhaust"), self, "tag_fx");
  }
}

debugDestroyCarepackages() {
  while(true) {
    if(getDvar("scr_ocp_destroyall", "0") != "0") {
      setDvar("scr_ocp_destroyall", "0");
      foreach(crate in level.carePackages) {
        crate maps\mp\killstreaks\_airdrop::deleteCrate();
      }
    }

    waitframe();
  }
}
# /