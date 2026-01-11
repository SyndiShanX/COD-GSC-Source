/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_helicopter_pilot.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.killstreakFuncs["heli_pilot"] = ::tryUseHeliPilot;

  level.heli_pilot = [];

  level.heliPilotSettings = [];

  level.heliPilotSettings["heli_pilot"] = spawnStruct();
  level.heliPilotSettings["heli_pilot"].timeOut = 60.0;
  level.heliPilotSettings["heli_pilot"].maxHealth = 2000;
  level.heliPilotSettings["heli_pilot"].streakName = "heli_pilot";
  level.heliPilotSettings["heli_pilot"].vehicleInfo = "heli_pilot_mp";
  level.heliPilotSettings["heli_pilot"].modelBase = level.littlebird_model;
  level.heliPilotSettings["heli_pilot"].teamSplash = "used_heli_pilot";

  heliPilot_setAirStartNodes();

  level.heli_pilot_mesh = GetEnt("heli_pilot_mesh", "targetname");
  if(!isDefined(level.heli_pilot_mesh)) {
    PrintLn("heli_pilot_mesh doesn't exist in this level: " + level.script);
  } else {
    level.heli_pilot_mesh.origin += getHeliPilotMeshOffset();
  }

  config = spawnStruct();
  config.xpPopup = "destroyed_helo_pilot";

  config.voDestroyed = undefined;
  config.callout = "callout_destroyed_helo_pilot";
  config.samDamageScale = 0.09;
  config.engineVFXtag = "tag_engine_right";

  level.heliConfigs["heli_pilot"] = config;

  SetDevDvarIfUninitialized("scr_helipilot_timeout", 60.0);
}

tryUseHeliPilot(lifeId, streakName) {
  heliPilotType = "heli_pilot";

  numIncomingVehicles = 1;

  if(isDefined(self.underWater) && self.underWater) {
    return false;
  } else if(exceededMaxHeliPilots(self.team)) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  incrementFauxVehicleCount();

  heli = createHeliPilot(heliPilotType);

  if(!isDefined(heli)) {
    decrementFauxVehicleCount();

    return false;
  }

  level.heli_pilot[self.team] = heli;

  result = self startHeliPilot(heli);

  if(!isDefined(result)) {
    result = false;
  }

  return result;
}

exceededMaxHeliPilots(team) {
  if(level.gameType == "dm") {
    if(isDefined(level.heli_pilot[team]) || isDefined(level.heli_pilot[level.otherTeam[team]])) {
      return true;
    } else {
      return false;
    }
  } else {
    if(isDefined(level.heli_pilot[team])) {
      return true;
    } else {
      return false;
    }
  }
}

watchHostMigrationFinishedInit(player) {
  player endon("killstreak_disowned");
  player endon("disconnect");
  levelendon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    player SetClientOmnvar("ui_heli_pilot", 1);
  }
}

createHeliPilot(heliPilotType) {
  closestStartNode = heliPilot_getClosestStartNode(self.origin);
  closestNode = heliPilot_getLinkedStruct(closestStartNode);
  startAng = VectorToAngles(closestNode.origin - closestStartNode.origin);

  forward = anglesToForward(self.angles);
  targetPos = closestNode.origin + (forward * -100);

  startPos = closestStartNode.origin;

  heli = SpawnHelicopter(self, startPos, startAng, level.heliPilotSettings[heliPilotType].vehicleInfo, level.heliPilotSettings[heliPilotType].modelBase);
  if(!isDefined(heli)) {
    return;
  }
  heli MakeVehicleSolidCapsule(18, -9, 18);

  heli maps\mp\killstreaks\_helicopter::addToLittleBirdList();
  heli thread maps\mp\killstreaks\_helicopter::removeFromLittleBirdListOnDeath();

  heli.maxHealth = level.heliPilotSettings[heliPilotType].maxHealth;

  heli.speed = 40;
  heli.owner = self;
  heli SetOtherEnt(self);
  heli.team = self.team;
  heli.heliType = "littlebird";
  heli.heliPilotType = "heli_pilot";
  heli SetMaxPitchRoll(45, 45);
  heli Vehicle_SetSpeed(heli.speed, 40, 40);
  heli SetYawSpeed(120, 60);
  heli SetNearGoalNotifyDist(32);
  heli SetHoverParams(100, 100, 100);
  heli make_entity_sentient_mp(heli.team);

  heli.targetPos = targetPos;
  heli.currentNode = closestNode;

  heli.attract_strength = 10000;
  heli.attract_range = 150;
  heli.attractor = Missile_CreateAttractorEnt(heli, heli.attract_strength, heli.attract_range);

  heli thread maps\mp\killstreaks\_helicopter::heli_damage_monitor("heli_pilot");
  heli thread heliPilot_lightFX();
  heli thread heliPilot_watchTimeout();
  heli thread heliPilot_watchOwnerLoss();
  heli thread heliPilot_watchRoundEnd();
  heli thread heliPilot_watchObjectiveCam();
  heli thread heliPilot_watchDeath();
  heli thread watchHostMigrationFinishedInit(self);

  heli.owner maps\mp\_matchdata::logKillstreakEvent(level.heliPilotSettings[heli.heliPilotType].streakName, heli.targetPos);

  return heli;
}

heliPilot_lightFX() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_nose");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
}

startHeliPilot(heli) {
  level endon("game_ended");
  heli endon("death");

  self setUsingRemote(heli.heliPilotType);

  if(GetDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(false);
  }

  self.restoreAngles = self.angles;

  heli thread maps\mp\killstreaks\_flares::ks_setup_manual_flares(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");

  self thread watchIntroCleared(heli);

  self freezeControlsWrapper(true);
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(heli.heliPilotType);
  if(result != "success") {
    if(isDefined(self.disabledWeapon) && self.disabledWeapon) {
      self _enableWeapon();
    }
    heli notify("death");

    return false;
  }

  self freezeControlsWrapper(false);

  traceOffset = getHeliPilotTraceOffset();
  traceStart = (heli.currentNode.origin) + (getHeliPilotMeshOffset() + traceOffset);
  traceEnd = (heli.currentNode.origin) + (getHeliPilotMeshOffset() - traceOffset);
  traceResult = bulletTrace(traceStart, traceEnd, false, undefined, false, false, true);
  if(!isDefined(traceResult["entity"])) {
    self thread drawSphere(traceResult["position"] - getHeliPilotMeshOffset(), 32, 10000, (1, 0, 0));
    self thread drawSphere(heli.currentNode.origin, 16, 10000, (0, 1, 0));
    self thread drawLine(traceStart - getHeliPilotMeshOffset(), traceEnd - getHeliPilotMeshOffset(), 10000, (0, 0, 1));

    AssertMsg("The trace didn't hit the heli_pilot_mesh. Please grab an MP scripter.");
  }

  targetOrigin = (traceResult["position"] - getHeliPilotMeshOffset()) + (0, 0, 250);
  targetNode = spawn("script_origin", targetOrigin);

  self RemoteControlVehicle(heli);

  heli thread heliGoToStartPosition(targetNode);
  heli thread heliPilot_watchADS();

  level thread teamPlayerCardSplash(level.heliPilotSettings[heli.heliPilotType].teamSplash, self);

  heli.killCamEnt = spawn("script_origin", self GetViewOrigin());

  return true;
}

heliGoToStartPosition(targetNode) {
  self endon("death");
  level endon("game_ended");

  self RemoteControlVehicleTarget(targetNode);
  self waittill("goal_reached");
  self RemoteControlVehicleTargetOff();

  targetNode delete();
}

watchIntroCleared(heli) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  heli endon("death");

  self waittill("intro_cleared");
  self SetClientOmnvar("ui_heli_pilot", 1);

  id = outlineEnableForPlayer(self, "cyan", self, false, "killstreak");
  self removeOutline(id, heli);

  foreach(player in level.participants) {
    if(!isReallyAlive(player) || player.sessionstate != "playing") {
      continue;
    }
    if(self isEnemy(player)) {
      if(!player _hasPerk("specialty_noplayertarget")) {
        id = outlineEnableForPlayer(player, "orange", self, false, "killstreak");
        player removeOutline(id, heli);
      } else {
        player thread watchForPerkRemoval(heli);
      }
    }
  }

  heli thread watchPlayersSpawning();

  self thread watchEarlyExit(heli);
}

watchForPerkRemoval(heli) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");

  self endon("death");

  self waittill("removed_specialty_noplayertarget");
  id = outlineEnableForPlayer(self, "orange", heli.owner, false, "killstreak");
  self removeOutline(id, heli);
}

watchPlayersSpawning() {
  self endon("leaving");
  self endon("death");

  while(true) {
    level waittill("player_spawned", player);
    if(player.sessionstate == "playing" && self.owner isEnemy(player)) {
      player thread watchForPerkRemoval(self);
    }
  }
}

removeOutline(id, heli) {
  self thread heliRemoveOutline(id, heli);
  self thread playerRemoveOutline(id, heli);
}

heliRemoveOutline(id, heli) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");

  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");

  wait_array = ["leaving", "death"];
  heli waittill_any_in_array_return_no_endon_death(wait_array);

  if(isDefined(self)) {
    outlineDisable(id, self);
    self notify("outline_removed");
  }
}

playerRemoveOutline(id, heli) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");

  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");

  wait_array = ["death"];
  self waittill_any_in_array_return_no_endon_death(wait_array);

  outlineDisable(id, self);
  self notify("outline_removed");
}

heliPilot_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner heliPilot_EndRide(self);
  }

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }

  self thread maps\mp\killstreaks\_helicopter::lbOnKilled();
}

heliPilot_watchObjectiveCam() {
  level endon("game_ended");
  self endon("gone");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  level waittill("objective_cam");

  self thread maps\mp\killstreaks\_helicopter::lbOnKilled();
  if(isDefined(self.owner)) {
    self.owner heliPilot_EndRide(self);
  }
}

heliPilot_watchTimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  timeout = level.heliPilotSettings[self.heliPilotType].timeOut;

  timeout = GetDvarFloat("scr_helipilot_timeout");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeout);

  self thread heliPilot_leave();
}

heliPilot_watchOwnerLoss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self thread heliPilot_leave();
}

heliPilot_watchRoundEnd() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  level waittill_any("round_end_finished", "game_ended");

  self thread heliPilot_leave();
}

heliPilot_leave() {
  self endon("death");
  self notify("leaving");

  if(isDefined(self.owner)) {
    self.owner heliPilot_EndRide(self);
  }

  flyHeight = self maps\mp\killstreaks\_airdrop::getFlyHeightOffset(self.origin);
  targetPos = self.origin + (0, 0, flyHeight);
  self Vehicle_SetSpeed(140, 60);
  self SetMaxPitchRoll(45, 180);
  self SetVehGoalPos(targetPos);
  self waittill("goal");

  targetPos = targetPos + anglesToForward(self.angles) * 15000;

  endEnt = spawn("script_origin", targetPos);
  if(isDefined(endEnt)) {
    self SetLookAtEnt(endEnt);
    endEnt thread wait_and_delete(3.0);
  }
  self SetVehGoalPos(targetPos);
  self waittill("goal");

  self notify("gone");
  self maps\mp\killstreaks\_helicopter::removeLittlebird();
}

wait_and_delete(waitTime) {
  self endon("death");
  level endon("game_ended");
  wait(waitTime);
  self delete();
}

heliPilot_EndRide(heli) {
  if(isDefined(heli)) {
    self SetClientOmnvar("ui_heli_pilot", 0);

    heli notify("end_remote");

    if(self isUsingRemote()) {
      self clearUsingRemote();
    }

    if(GetDvarInt("camera_thirdPerson")) {
      self setThirdPersonDOF(true);
    }

    self RemoteControlVehicleOff(heli);

    self SetPlayerAngles(self.restoreAngles);

    self thread heliPilot_FreezeBuffer();
  }
}

heliPilot_FreezeBuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

heliPilot_watchADS() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");

  already_set = false;
  while(true) {
    if(isDefined(self.owner)) {
      if(self.owner AdsButtonPressed()) {
        if(!already_set) {
          self.owner SetClientOmnvar("ui_heli_pilot", 2);
          already_set = true;
        }
      } else {
        if(already_set) {
          self.owner SetClientOmnvar("ui_heli_pilot", 1);
          already_set = false;
        }
      }
    }

    wait(0.1);
  }
}

heliPilot_setAirStartNodes() {
  level.air_start_nodes = getstructarray("chopper_boss_path_start", "targetname");
}

heliPilot_getLinkedStruct(struct) {
  if(isDefined(struct.script_linkTo)) {
    linknames = struct get_links();
    for(i = 0; i < linknames.size; i++) {
      ent = getstruct(linknames[i], "script_linkname");
      if(isDefined(ent)) {
        return ent;
      }
    }
  }

  return undefined;
}

heliPilot_getClosestStartNode(pos) {
  closestNode = undefined;
  closestDistance = 999999;

  foreach(loc in level.air_start_nodes) {
    nodeDistance = Distance(loc.origin, pos);
    if(nodeDistance < closestDistance) {
      closestNode = loc;
      closestDistance = nodeDistance;
    }
  }

  return closestNode;
}

watchEarlyExit(heli) {
  level endon("game_ended");
  heli endon("death");
  self endon("leaving");

  heli thread maps\mp\killstreaks\_killstreaks::allowRideKillstreakPlayerExit();

  heli waittill("killstreakExit");

  heli thread heliPilot_leave();
}