/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_escortairdrop.gsc
**************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
  level.ospreySettings = [];

  if(level.script == "mp_character_room") {
    return;
  }
  level.ospreySettings["escort_airdrop"] = spawnStruct();
  level.ospreySettings["escort_airdrop"].vehicle = "osprey_mp";
  level.ospreySettings["escort_airdrop"].modelBase = "vehicle_v22_osprey_body_mp";
  level.ospreySettings["escort_airdrop"].modelBlades = "vehicle_v22_osprey_blades_mp";
  level.ospreySettings["escort_airdrop"].tagHatchL = "tag_le_door_attach";
  level.ospreySettings["escort_airdrop"].tagHatchR = "tag_ri_door_attach";
  level.ospreySettings["escort_airdrop"].tagDropCrates = "tag_turret_attach";
  level.ospreySettings["escort_airdrop"].prompt = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.ospreySettings["escort_airdrop"].name = &"KILLSTREAKS_ESCORT_AIRDROP";
  level.ospreySettings["escort_airdrop"].weaponInfo = "osprey_minigun_mp";
  level.ospreySettings["escort_airdrop"].heliType = "osprey";
  level.ospreySettings["escort_airdrop"].dropType = "airdrop_escort";
  level.ospreySettings["escort_airdrop"].maxHealth = level.heli_maxhealth * 2;
  level.ospreySettings["escort_airdrop"].timeOut = 60.0;

  level.ospreySettings["osprey_gunner"] = spawnStruct();
  level.ospreySettings["osprey_gunner"].vehicle = "osprey_player_mp";
  level.ospreySettings["osprey_gunner"].modelBase = "vehicle_v22_osprey_body_mp";
  level.ospreySettings["osprey_gunner"].modelBlades = "vehicle_v22_osprey_blades_mp";
  level.ospreySettings["osprey_gunner"].tagHatchL = "tag_le_door_attach";
  level.ospreySettings["osprey_gunner"].tagHatchR = "tag_ri_door_attach";
  level.ospreySettings["osprey_gunner"].tagDropCrates = "tag_turret_attach";
  level.ospreySettings["osprey_gunner"].prompt = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.ospreySettings["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
  level.ospreySettings["osprey_gunner"].weaponInfo = "osprey_player_minigun_mp";
  level.ospreySettings["osprey_gunner"].heliType = "osprey_gunner";
  level.ospreySettings["osprey_gunner"].dropType = "airdrop_osprey_gunner";
  level.ospreySettings["osprey_gunner"].maxHealth = level.heli_maxhealth * 2;
  level.ospreySettings["osprey_gunner"].timeOut = 75.0;

  foreach(ospreyInfo in level.ospreySettings) {
    level.chopper_fx["explode"]["death"][ospreyInfo.modelBase] = LoadFX("fx/explosions/helicopter_explosion_osprey");
    level.chopper_fx["explode"]["air_death"][ospreyInfo.modelBase] = LoadFX("fx/explosions/helicopter_explosion_osprey_air_mp");

    level.chopper_fx["anim"]["blades_anim_up"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_blades_anim_up");
    level.chopper_fx["anim"]["blades_anim_down"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_blades_anim_down");
    level.chopper_fx["anim"]["blades_static_up"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_blades_up");
    level.chopper_fx["anim"]["blades_static_down"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_blades_default");

    level.chopper_fx["anim"]["hatch_left_static_up"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_left_default");
    level.chopper_fx["anim"]["hatch_left_anim_down"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_left_anim_open");
    level.chopper_fx["anim"]["hatch_left_static_down"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_left_up");
    level.chopper_fx["anim"]["hatch_left_anim_up"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_left_anim_close");

    level.chopper_fx["anim"]["hatch_right_static_up"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_right_default");
    level.chopper_fx["anim"]["hatch_right_anim_down"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_right_anim_open");
    level.chopper_fx["anim"]["hatch_right_static_down"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_right_up");
    level.chopper_fx["anim"]["hatch_right_anim_up"][ospreyInfo.modelBase] = LoadFX("fx/props/osprey_bottom_door_right_anim_close");
  }

  level.air_support_locs = [];

  level.killStreakFuncs["escort_airdrop"] = ::tryUseEscortAirdrop;
  level.killStreakFuncs["osprey_gunner"] = ::tryUseOspreyGunner;

  SetDevDvarIfUninitialized("scr_ospreygunner_timeout", level.ospreySettings["osprey_gunner"].timeOut);
}

tryUseEscortAirdrop(lifeId, streakName) {
  numIncomingVehicles = 1;

  if(isDefined(level.chopper)) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  heightEnt = GetEnt("airstrikeheight", "targetname");
  assertEx(isDefined(heightEnt), "NO HEIGHT ENT IN LEVEL:Don't know what this means, ask Ned or Jordan");

  if(!isDefined(heightEnt)) {
    return false;
  }

  if(self isKillStreakDenied()) {
    return false;
  }

  incrementFauxVehicleCount();

  if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
    return true;
  }

  result = self maps\mp\killstreaks\_airdrop::beginAirdropViaMarker(lifeId, "escort_airdrop");
  if(!isDefined(result) || !result) {
    self notify("markerDetermined");

    decrementFauxVehicleCount();

    return false;
  }

  return true;
}

tryUseOspreyGunner(lifeId, streakName) {
  numIncomingVehicles = 1;

  if(isDefined(level.chopper)) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  heightEnt = GetEnt("airstrikeheight", "targetname");
  assertEx(isDefined(heightEnt), "NO HEIGHT ENT IN LEVEL:Don't know what this means, ask Ned or Jordan");

  if(!isDefined(heightEnt)) {
    return false;
  }

  incrementFauxVehicleCount();

  result = self selectDropLocation(lifeId, "osprey_gunner", "compass_objpoint_osprey_friendly", "compass_objpoint_osprey_enemy", &"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
  if(!isDefined(result) || !result) {
    decrementFauxVehicleCount();

    return false;
  }

  self maps\mp\_matchdata::logKillstreakEvent("osprey_gunner", self.origin);

  return true;
}

finishSupportEscortUsage(lifeId, location, directionYaw, ospreyType) {
  self notify("used");

  direction = (0, directionYaw, 0);
  planeHalfDistance = 12000;

  heightEnt = GetEnt("airstrikeheight", "targetname");

  flyHeight = heightEnt.origin[2];

  startNode = level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
  pathStart = startNode.origin;

  pathGoal = (location[0], location[1], flyHeight);

  pathEnd = location + (anglesToForward(direction) * planeHalfDistance);
  forward = vectorToAngles(pathGoal - pathStart);

  guardPosition = location;
  location = (location[0], location[1], flyHeight);

  airShip = createAirship(self, lifeId, pathStart, forward, location, ospreyType);

  pathStart = startNode;
  self useSupportEscortAirdrop(lifeId, airShip, pathStart, pathGoal, pathEnd, flyHeight, guardPosition);
}

finishOspreyGunnerUsage(lifeId, location, directionYaw, ospreyType) {
  self notify("used");

  direction = (0, directionYaw, 0);
  planeHalfDistance = 12000;

  heightEnt = GetEnt("airstrikeheight", "targetname");

  flyHeight = heightEnt.origin[2];

  startNode = level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
  pathStart = startNode.origin;

  pathGoal = (location[0], location[1], flyHeight);

  pathEnd = location + (anglesToForward(direction) * planeHalfDistance);
  forward = vectorToAngles(pathGoal - pathStart);

  location = (location[0], location[1], flyHeight);

  airShip = createAirship(self, lifeId, pathStart, forward, location, ospreyType);

  pathStart = startNode;
  self useOspreyGunner(lifeId, airShip, pathStart, pathGoal, pathEnd, flyHeight);
}

stopSelectionWatcher() {
  self waittill("stop_location_selection", reason);

  switch (reason) {
    case "cancel_location":
    case "death":
    case "disconnect":
    case "emp":
    case "weapon_change":
      self notify("customCancelLocation");
      break;
  }
}

selectDropLocation(lifeId, ospreyType, icon_friendly, icon_enemy, instruction_text) {
  self endon("customCancelLocation");

  locIndex = undefined;
  targetSize = level.mapSize / 6.46875;

  if(level.splitscreen) {
    targetSize *= 1.5;
  }

  self _beginLocationSelection(ospreyType, "map_artillery_selector", false, 500);

  self thread stopSelectionWatcher();
  self waittill("confirm_location", location, directionYaw);
  self stopLocationSelection(false);

  self setUsingRemote(ospreyType);
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(ospreyType);

  if(result != "success") {
    if(result != "disconnect") {
      self clearUsingRemote();
    }

    return false;
  }

  if(isDefined(level.chopper)) {
    self clearUsingRemote();
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount >= maxVehiclesAllowed()) {
    self clearUsingRemote();
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  self thread finishOspreyGunnerUsage(lifeId, location, directionYaw, ospreyType);

  return true;
}

showIcons(icon_friendly, icon_enemy, instruction_text, num_icons) {
  msg = self maps\mp\gametypes\_hud_util::createFontString("bigfixed", 0.5);
  msg maps\mp\gametypes\_hud_util::setPoint("CENTER", "CENTER", 0, -150);
  msg setText(instruction_text);

  self.locationObjectives = [];

  for(i = 0; i < num_icons; i++) {
    self.locationObjectives[i] = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(self.locationObjectives[i], "invisible", (0, 0, 0));
    objective_position(self.locationObjectives[i], level.air_support_locs[level.script][i]["origin"]);
    objective_state(self.locationObjectives[i], "active");
    objective_player(self.locationObjectives[i], self getEntityNumber());
    if(level.air_support_locs[level.script][i]["in_use"] == true) {
      objective_icon(self.locationObjectives[i], icon_enemy);
    } else {
      objective_icon(self.locationObjectives[i], icon_friendly);
    }
  }

  self waittill_any("cancel_location", "picked_location", "stop_location_selection");

  msg destroyElem();
  for(i = 0; i < num_icons; i++) {
    _objective_delete(self.locationObjectives[i]);
  }
}

createAirship(owner, lifeId, pathStart, forward, locIndex, ospreyType) {
  airShip = spawnHelicopter(owner, pathStart, forward, level.ospreySettings[ospreyType].vehicle, level.ospreySettings[ospreyType].modelBase);
  if(!isDefined(airShip)) {
    return undefined;
  }

  airShip.ospreyType = ospreyType;

  airShip.heli_type = level.ospreySettings[ospreyType].modelBase;

  airShip.heliType = level.ospreySettings[ospreyType].heliType;
  airShip.attractor = Missile_CreateAttractorEnt(airShip, level.heli_attract_strength, level.heli_attract_range);
  airShip.lifeId = lifeId;
  airShip.team = owner.pers["team"];
  airShip.pers["team"] = owner.pers["team"];
  airShip.owner = owner;
  airShip SetOtherEnt(owner);
  airShip.maxhealth = level.ospreySettings[ospreyType].maxHealth;
  airShip.zOffset = (0, 0, 0);
  airShip.targeting_delay = level.heli_targeting_delay;
  airShip.primaryTarget = undefined;
  airShip.secondaryTarget = undefined;
  airShip.attacker = undefined;
  airShip.currentstate = "ok";
  airShip.dropType = level.ospreySettings[ospreyType].dropType;
  airShip make_entity_sentient_mp(airShip.team);

  level.chopper = airShip;
  airShip maps\mp\killstreaks\_helicopter::addToHeliList();

  airShip thread maps\mp\killstreaks\_flares::flares_monitor(2);
  airShip thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect(owner);
  airShip thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeTeams(owner);
  airShip thread maps\mp\killstreaks\_helicopter::heli_leave_on_gameended(owner);
  lifeSpan = level.ospreySettings[ospreyType].timeOut;

  lifeSpan = GetDvarFloat("scr_ospreygunner_timeout");

  airShip thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout(lifeSpan);
  airShip thread maps\mp\killstreaks\_helicopter::heli_damage_monitor(ospreyType, false);
  airShip thread maps\mp\killstreaks\_helicopter::heli_health();
  airShip thread maps\mp\killstreaks\_helicopter::heli_existance();
  airShip thread airshipFX();
  airShip thread airshipFXOnConnect();

  if(ospreyType == "escort_airdrop") {
    killCamOrigin = (airShip.origin + ((anglesToForward(airShip.angles) * -200) + (AnglesToRight(airShip.angles) * -200))) + (0, 0, 200);
    airShip.killCamEnt = spawn("script_model", killCamOrigin);
    airShip.killCamEnt SetScriptMoverKillCam("explosive");
    airShip.killCamEnt LinkTo(airShip, "tag_origin");
  }

  return airShip;
}

airshipFX() {
  self endon("death");

  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");

  wait(0.05);
  playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
  wait(0.05);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
  wait(0.05);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
}

airshipFXOnConnect() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    self thread airShipFXOnClient(player);
  }
}

airShipFXOnClient(player) {
  self endon("death");
  level endon("game_ended");
  player endon("disconnect");

  wait(0.05);
  PlayFXOnTagForClients(level.chopper_fx["light"]["tail"], self, "tag_light_tail", player);
  wait(0.05);
  PlayFXOnTagForClients(level.chopper_fx["light"]["belly"], self, "tag_light_belly", player);

  if(isDefined(self.propsState)) {
    if(self.propsState == "up") {
      wait(0.05);
      PlayFXOnTagForClients(level.chopper_fx["anim"]["blades_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH", player);
    } else {
      wait(0.05);
      PlayFXOnTagForClients(level.chopper_fx["anim"]["blades_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH", player);
    }
  } else {
    wait(0.05);
    PlayFXOnTagForClients(level.chopper_fx["anim"]["blades_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH", player);
  }

  if(isDefined(self.hatchState)) {
    if(self.hatchState == "down") {
      wait(0.05);
      PlayFXOnTagForClients(level.chopper_fx["anim"]["hatch_left_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL, player);
      wait(0.05);
      PlayFXOnTagForClients(level.chopper_fx["anim"]["hatch_right_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR, player);
    } else {
      wait(0.05);
      PlayFXOnTagForClients(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL, player);
      wait(0.05);
      PlayFXOnTagForClients(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR, player);
    }
  } else {
    wait(0.05);
    PlayFXOnTagForClients(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL, player);
    wait(0.05);
    PlayFXOnTagForClients(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR, player);
  }
}

useSupportEscortAirdrop(lifeId, airShip, pathStart, pathGoal, pathEnd, flyHeight, guardPosition) {
  airShip thread airshipFlyDefense(self, pathStart, pathGoal, pathEnd, flyHeight, guardPosition);
}

useOspreyGunner(lifeId, airShip, pathStart, pathGoal, pathEnd, flyHeight) {
  self thread rideGunner(lifeId, airShip);

  airShip thread airshipFlyGunner(self, pathStart, pathGoal, pathEnd, flyHeight);
}

rideGunner(lifeId, airShip) {
  self endon("disconnect");
  airShip endon("helicopter_done");

  thread teamPlayerCardSplash("used_osprey_gunner", self);
  self _giveWeapon("heli_remote_mp");
  self SwitchToWeapon("heli_remote_mp");
  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(false);
  }

  airShip VehicleTurretControlOn(self);

  self PlayerLinkWeaponViewToDelta(airship, "tag_player", 1.0, 0, 0, 0, 0, true);
  self setPlayerAngles(airship getTagAngles("tag_player"));

  airShip thread maps\mp\killstreaks\_helicopter::heli_targeting();

  airShip.gunner = self;
  self.heliRideLifeId = lifeId;
  self thread endRideOnAirshipDone(airShip);

  self thread waitSetThermal(1.0, airShip);
  self thread reInitializeThermal(airShip);

  while(true) {
    airShip waittill("turret_fire");
    airShip fireWeapon();
    earthquake(0.2, 1, airShip.origin, 1000);
  }
}

waitSetThermal(delay, airShip) {
  self endon("disconnect");
  airShip endon("death");
  airShip endon("helicopter_done");
  airShip endon("crashing");
  airShip endon("leaving");

  wait(delay);

  self VisionSetThermalForPlayer(level.ac130.enhanced_vision, 0);
  self.lastVisionSetThermal = level.ac130.enhanced_vision;
  self ThermalVisionOn();
  self ThermalVisionFOFOverlayOn();
}

showDefendPrompt(airShip) {
  self endon("disconnect");
  airShip endon("helicopter_done");

  self.escort_prompt = self maps\mp\gametypes\_hud_util::createFontString("bigfixed", 1.5);
  self.escort_prompt setPoint("CENTER", "CENTER", 0, -150);
  self.escort_prompt setText(level.ospreySettings[airShip.ospreyType].prompt);

  wait(6);

  if(isDefined(self.escort_prompt)) {
    self.escort_prompt destroyElem();
  }
}

airShipPitchPropsUp() {
  self endon("crashing");
  self endon("death");

  stopFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_up"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
  wait(1.0);
  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["blades_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
    self.propsState = "up";
  }
}

airShipPitchPropsDown() {
  self endon("crashing");
  self endon("death");

  stopFXOnTag(level.chopper_fx["anim"]["blades_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_down"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
  wait(1.0);
  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, "TAG_BLADES_ATTACH");
    self.propsState = "down";
  }
}

airShipPitchHatchUp() {
  self endon("crashing");
  self endon("death");

  stopFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_anim_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
  stopFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_anim_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
  wait(1.0);
  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
    self.hatchState = "up";
  }
}

airShipPitchHatchDown() {
  self endon("crashing");
  self endon("death");

  stopFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_anim_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
  stopFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_anim_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
  wait(1.0);
  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchL);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.ospreySettings[self.ospreyType].modelBase], self, level.ospreySettings[self.ospreyType].tagHatchR);
    self.hatchState = "down";
  }
  self notify("hatch_down");
}

getBestHeight(centerPoint) {
  self endon("helicopter_removed");
  self endon("heightReturned");

  heightEnt = GetEnt("airstrikeheight", "targetname");

  if(isDefined(heightEnt)) {
    trueHeight = heightEnt.origin[2];
  } else if(isDefined(level.airstrikeHeightScale)) {
    trueHeight = 850 * level.airstrikeHeightScale;
  } else {
    trueHeight = 850;
  }

  self.bestHeight = trueHeight;

  bestHeight = 200;
  offset = 0;
  offset2 = 0;

  for(i = 0; i < 125; i++) {
    wait(0.05);

    turn = i % 8;

    globalOffset = i * 3;

    switch (turn) {
      case 0:
        offset = globalOffset;
        offset2 = globalOffset;
        break;
      case 1:
        offset = globalOffset * -1;
        offset2 = globalOffset * -1;
        break;
      case 2:
        offset = globalOffset * -1;
        offset2 = globalOffset;
        break;
      case 3:
        offset = globalOffset;
        offset2 = globalOffset * -1;
        break;
      case 4:
        offset = 0;
        offset2 = globalOffset * -1;
        break;
      case 5:
        offset = globalOffset * -1;
        offset2 = 0;
        break;
      case 6:
        offset = globalOffset;
        offset2 = 0;
        break;
      case 7:
        offset = 0;
        offset2 = globalOffset;
        break;

      default:
        break;
    }

    trace = bulletTrace(centerPoint + (offset, offset2, 1000), centerPoint + (offset, offset2, -10000), true, self);

    if(trace["position"][2] > bestHeight) {
      bestHeight = trace["position"][2];

    }
  }

  self.bestHeight = bestHeight + 300;

  switch (GetDvar("mapname")) {
    case "mp_morningwood":
      self.bestHeight += 600;
      break;

    case "mp_overwatch":
      spawns = level.spawnPoints;
      lowestSpawn = spawns[0];
      highestSpawn = spawns[0];

      foreach(spawn in spawns) {
        if(spawn.origin[2] < lowestSpawn.origin[2]) {
          lowestSpawn = spawn;
        }
        if(spawn.origin[2] > highestSpawn.origin[2]) {
          highestSpawn = spawn;
        }
      }

      if(bestHeight < lowestSpawn.origin[2] - 100) {
        self.bestHeight = highestSpawn.origin[2] + 900;
      }
      break;
  }

}

airshipFlyDefense(owner, pathStart, pathGoal, pathEnd, flyHeight, guardPosition) {
  self notify("airshipFlyDefense");
  self endon("airshipFlyDefense");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");

  self thread getBestHeight(pathGoal);

  self maps\mp\killstreaks\_helicopter::heli_fly_simple_path(pathStart);

  self.pathGoal = pathGoal;

  dropForward = self.angles;

  self SetYawSpeed(30, 30, 30, .3);

  curOrg = self.origin;
  yaw = self.angles[1];
  forward = self.angles[0];

  self.timeOut = level.ospreySettings[self.ospreyType].timeOut;
  self setVehGoalPos(pathGoal, 1);
  startTime = GetTime();
  self waittill("goal");
  endTime = (GetTime() - startTime) * 0.001;
  self.timeOut -= endTime;

  self thread airShipPitchPropsUp();

  dropPos = pathGoal * (1, 1, 0);
  dropPos += (0, 0, self.bestHeight);

  self Vehicle_SetSpeed(25, 10, 10);
  self SetYawSpeed(20, 10, 10, .3);

  self setVehGoalPos(dropPos, 1);
  startTime = GetTime();
  self waittill("goal");
  endTime = (GetTime() - startTime) * 0.001;
  self.timeOut -= endTime;

  self SetHoverParams(65, 50, 50);
  self ospreyDropCratesLowImpulse(1, level.ospreySettings[self.ospreyType].tagDropCrates, dropPos);

  self thread killGuysNearCrates(guardPosition);

  if(isDefined(owner)) {
    owner waittill_any_timeout(self.timeOut, "disconnect");
  }

  self waittill("leaving");

  self notify("osprey_leaving");

  self thread airShipPitchPropsDown();
}

wait_and_delete(waitTime) {
  self endon("death");
  level endon("game_ended");
  wait(waitTime);
  self delete();
}

killGuysNearCrates(guardPosition) {
  self endon("osprey_leaving");
  self endon("helicopter_removed");
  self endon("death");

  targetCenter = guardPosition;

  for(;;) {
    foreach(player in level.players) {
      wait(0.05);

      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(player)) {
        continue;
      }
      if(!isReallyAlive(player)) {
        continue;
      }
      if(!self.owner isEnemy(player)) {
        continue;
      }
      if(player _hasPerk("specialty_blindeye")) {
        continue;
      }
      if(DistanceSquared(targetCenter, player.origin) > 500000) {
        continue;
      }
      self thread aiShootPlayer(player, targetCenter);

      self waitForConfirmation();
    }
  }
}

aiShootPlayer(targetPlayer, center) {
  self notify("aiShootPlayer");
  self endon("aiShootPlayer");

  self endon("helicopter_removed");
  self endon("leaving");
  targetPlayer endon("death");

  self SetTurretTargetEnt(targetPlayer);
  self SetLookAtEnt(targetPlayer);

  self thread targetDeathWaiter(targetPlayer);

  numShots = 6;
  vollies = 2;

  for(;;) {
    numShots--;
    self FireWeapon("tag_flash", targetPlayer);
    wait(.15);

    if(numShots <= 0) {
      vollies--;
      numShots = 6;

      if(distanceSquared(targetPlayer.origin, center) > 500000 || vollies <= 0 || !isReallyAlive(targetPlayer)) {
        self notify("abandon_target");
        return;
      }

      wait(1);
    }
  }
}

targetDeathWaiter(targetPlayer) {
  self endon("abandon_target");
  self endon("leaving");
  self endon("helicopter_removed");

  targetPlayer waittill("death");
  self notify("target_killed");
}

waitForConfirmation() {
  self endon("helicopter_removed");
  self endon("leaving");
  self endon("target_killed");
  self endon("abandon_target");

  for(;;) {
    wait 0.05;
  }

}

airshipFlyGunner(owner, pathStart, pathGoal, pathEnd, flyHeight) {
  self notify("airshipFlyGunner");
  self endon("airshipFlyGunner");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");

  self thread getBestHeight(pathGoal);

  self maps\mp\killstreaks\_helicopter::heli_fly_simple_path(pathStart);
  self thread maps\mp\killstreaks\_helicopter::heli_leave_on_timeout(level.ospreySettings[self.ospreyType].timeOut);

  dropForward = self.angles;

  self SetYawSpeed(30, 30, 30, .3);

  curOrg = self.origin;
  yaw = self.angles[1];
  forward = self.angles[0];

  self.timeOut = level.ospreySettings[self.ospreyType].timeOut;

  self setVehGoalPos(pathGoal, 1);
  startTime = GetTime();
  self waittill("goal");
  endTime = (GetTime() - startTime) * 0.001;
  self.timeOut -= endTime;

  self thread airShipPitchPropsUp();

  dropPos = pathGoal * (1, 1, 0);
  dropPos += (0, 0, self.bestHeight);

  self Vehicle_SetSpeed(25, 10, 10);
  self SetYawSpeed(20, 10, 10, .3);

  self setVehGoalPos(dropPos, 1);
  startTime = GetTime();
  self waittill("goal");
  endTime = (GetTime() - startTime) * 0.001;
  self.timeOut -= endTime;

  self ospreyDropCrates(1, level.ospreySettings[self.ospreyType].tagDropCrates, dropPos);

  waitTime = 1.0;
  if(isDefined(owner)) {
    owner waittill_any_timeout(waitTime, "disconnect");
  }
  self.timeOut -= waitTime;

  self setVehGoalPos(pathGoal, 1);
  startTime = GetTime();
  self waittill("goal");
  endTime = (GetTime() - startTime) * 0.001;
  self.timeOut -= endTime;

  attackAreas = getEntArray("heli_attack_area", "targetname");
  loopNode = level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];
  if(attackAreas.size) {
    self thread maps\mp\killstreaks\_helicopter::heli_fly_well(attackAreas);
  } else {
    self thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path(loopNode);
  }

  self waittill("leaving");

  self thread airShipPitchPropsDown();
}

ospreyDropCratesLowImpulse(timeBetween, dropFromTag, dropPos) {
  self thread airShipPitchHatchDown();
  self waittill("hatch_down");

  level notify("escort_airdrop_started", self);

  crateType[0] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (randomInt(10), randomInt(10), randomInt(10)), undefined, dropFromTag);
  wait(0.05);
  self notify("drop_crate");

  wait(timeBetween);

  crateType[1] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (RandomInt(100), randomInt(100), randomInt(100)), crateType, dropFromTag);
  wait(0.05);
  self notify("drop_crate");

  wait(timeBetween);

  crateType[2] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (randomInt(50), randomInt(50), randomInt(50)), crateType, dropFromTag);
  wait(0.05);
  self notify("drop_crate");

  wait(timeBetween);

  crateType[3] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (RandomIntRange(-100, 0), RandomIntRange(-100, 0), RandomIntRange(-100, 0)), crateType, dropFromTag);
  wait(0.05);
  self notify("drop_crate");

  wait(timeBetween);

  self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (RandomIntRange(-50, 0), RandomIntRange(-50, 0), RandomIntRange(-50, 0)), crateType, dropFromTag);
  wait(0.05);
  self notify("drop_crate");

  wait(1.0);
  self thread airShipPitchHatchUp();
}

ospreyDropCrates(timeBetween, dropFromTag, dropPos) {
  self thread airShipPitchHatchDown();
  self waittill("hatch_down");

  crateType[0] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (randomInt(10), randomInt(10), randomInt(10)), undefined, dropFromTag);
  wait(0.05);
  self.timeOut -= 0.05;
  self notify("drop_crate");

  wait(timeBetween);
  self.timeOut -= timeBetween;

  crateType[1] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (randomInt(100), randomInt(100), randomInt(100)), crateType, dropFromTag);
  wait(0.05);
  self.timeOut -= 0.05;
  self notify("drop_crate");

  wait(timeBetween);
  self.timeOut -= timeBetween;

  crateType[2] = self thread maps\mp\killstreaks\_airdrop::dropTheCrate(undefined, self.dropType, undefined, false, undefined, self.origin, (randomInt(50), randomInt(50), randomInt(50)), crateType, dropFromTag);
  wait(0.05);
  self.timeOut -= 0.05;
  self notify("drop_crate");

  wait(1.0);
  self thread airShipPitchHatchUp();
}

endRide(airShip) {
  if(isDefined(self.escort_prompt)) {
    self.escort_prompt destroyElem();
  }

  self RemoteCameraSoundscapeOff();
  self ThermalVisionOff();
  self ThermalVisionFOFOverlayOff();
  self unlink();
  self clearUsingRemote();
  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(true);
  }
  self VisionSetThermalForPlayer(game["thermal_vision"], 0);

  if(isDefined(airShip)) {
    airShip VehicleTurretControlOff(self);
  }

  self notify("heliPlayer_removed");

  self SwitchToWeapon(self getLastWeapon());
  self TakeWeapon("heli_remote_mp");
}

endRideOnAirshipDone(airShip) {
  self endon("disconnect");

  airShip waittill("helicopter_done");

  self endRide(airShip);
}