/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gameobjects.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;

main(allowed) {
  allowed[allowed.size] = "airdrop_pallet";

  if(isAugmentedGameMode()) {
    allowed[allowed.size] = "boost_add";
  } else {
    allowed[allowed.size] = "boost_remove";
  }

  entitytypes = getEntArray();
  for(i = 0; i < entitytypes.size; i++) {
    if(isDefined(entitytypes[i].script_gameobjectname)) {
      dodelete = true;

      gameobjectnames = strtok(entitytypes[i].script_gameobjectname, " ");

      for(j = 0; j < allowed.size; j++) {
        for(k = 0; k < gameobjectnames.size; k++) {
          if(gameobjectnames[k] == allowed[j]) {
            dodelete = false;
            break;
          }
        }
        if(!dodelete) {
          break;
        }
      }

      if(dodelete) {
        if(isDefined(entitytypes[i].script_exploder)) {
          common_scripts\_createfx::removeFXentWithEntity(entitytypes[i]);
        }
        entitytypes[i] delete();
      }
    }
  }

  boost_walls = getEntArray("boost_jump_border", "targetname");

  if(isDefined(boost_walls)) {
    foreach(wall in boost_walls) {
      wall delete();
    }
  }

}

init() {
  level.numGametypeReservedObjectives = 0;
  level.objIDStart = 0;

  level thread onPlayerConnect();
}

onPlayerConnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    player thread onPlayerSpawned();
    player thread onDisconnect();
  }
}

onPlayerSpawned() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(self.gameObject_fauxSpawn)) {
      self.gameObject_fauxSpawn = undefined;
    } else {
      self init_player_gameobjects();
    }
  }
}

init_player_gameobjects() {
  self thread onDeath();
  self.touchTriggers = [];
  self.carryObject = undefined;
  self.claimTrigger = undefined;
  self.canPickupObject = true;
  self.killedInUse = undefined;
  self.initialized_gameobject_vars = true;
}

onDeath() {
  level endon("game_ended");

  self waittill("death");

  if(isDefined(self.carryObject)) {
    assert(self.carryObject.carrier == self);
    self.carryObject thread setDropped();
  }
}

onDisconnect() {
  level endon("game_ended");

  self waittill("disconnect");

  if(isDefined(self.carryObject)) {
    assert(self.carryObject.carrier == self);
    self.carryObject thread setDropped();
  }
}

createCarryObject(ownerTeam, trigger, visuals, offset) {
  carryObject = spawnStruct();
  carryObject.type = "carryObject";
  carryObject.curOrigin = trigger.origin;
  carryObject.ownerTeam = ownerTeam;
  carryObject.entNum = trigger getEntityNumber();

  if(isSubStr(trigger.classname, "use")) {
    carryObject.triggerType = "use";
  } else {
    carryObject.triggerType = "proximity";
  }

  trigger.baseOrigin = trigger.origin;
  carryObject.trigger = trigger;

  carryObject.useWeapon = undefined;

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  carryObject.offset3d = offset;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseOrigin = visuals[index].origin;
    visuals[index].baseAngles = visuals[index].angles;
  }
  carryObject.visuals = visuals;

  carryObject.compassIcons = [];
  carryObject.objIDAllies = getNextObjID();
  carryObject.objIDAxis = getNextObjID();
  carryObject.objIDMLGSpectator = getNextObjID();
  carryObject.objIDPingFriendly = false;
  carryObject.objIDPingEnemy = false;
  carryObject.objPingDelay = 5.0;
  level.objIDStart += 2;

  objective_add(carryObject.objIDAllies, "invisible", carryObject.curOrigin);
  objective_add(carryObject.objIDAxis, "invisible", carryObject.curOrigin);
  objective_add(carryObject.objIDMLGSpectator, "invisible", carryObject.curOrigin);
  objective_team(carryObject.objIDAllies, "allies");
  objective_team(carryObject.objIDAxis, "axis");
  objective_mlgspectator(carryObject.objIDMLGSpectator);

  carryObject.objPoints["allies"] = maps\mp\gametypes\_objpoints::createTeamObjpoint("objpoint_allies_" + carryObject.entNum, carryObject.curOrigin + offset, "allies", undefined);
  carryObject.objPoints["axis"] = maps\mp\gametypes\_objpoints::createTeamObjpoint("objpoint_axis_" + carryObject.entNum, carryObject.curOrigin + offset, "axis", undefined);
  carryObject.objPoints["mlg"] = maps\mp\gametypes\_objpoints::createTeamObjpoint("objpoint_mlg_" + carryObject.entNum, carryObject.curOrigin + offset, "mlg", undefined);

  carryObject.objPoints["mlg"].archived = false;

  carryObject.objPoints["allies"].alpha = 0;
  carryObject.objPoints["axis"].alpha = 0;

  carryObject.carrier = undefined;

  carryObject.isResetting = false;
  carryObject.interactTeam = "none";
  carryObject.allowWeapons = false;
  carryObject.waterBadTrigger = false;
  carryObject.keepProgress = false;

  carryObject.worldIcons = [];
  carryObject.carrierVisible = false;
  carryObject.visibleTeam = "none";

  carryObject.carryIcon = undefined;

  carryObject.onDrop = undefined;
  carryObject.onPickup = undefined;
  carryObject.onReset = undefined;

  if(carryObject.triggerType == "use") {
    carryObject thread carryObjectUseThink();
  } else {
    carryObject.curProgress = 0;

    carryObject.useTime = 0;
    carryObject.useRate = 0;
    carryObject.mustMaintainClaim = false;
    carryObject.canContestClaim = false;

    carryObject.teamUseTimes = [];
    carryObject.teamUseTexts = [];

    carryObject.numTouching["neutral"] = 0;
    carryObject.numTouching["axis"] = 0;
    carryObject.numTouching["allies"] = 0;
    carryObject.numTouching["none"] = 0;
    carryObject.touchList["neutral"] = [];
    carryObject.touchList["axis"] = [];
    carryObject.touchList["allies"] = [];
    carryObject.touchList["none"] = [];

    carryObject.claimTeam = "none";
    carryObject.claimPlayer = undefined;
    carryObject.lastClaimTeam = "none";
    carryObject.lastClaimTime = 0;

    if(level.multiteambased) {
      foreach(name in level.teamnamelist) {
        carryObject.numTouching[name] = 0;
        carryObject.touchList[name] = [];
      }
    }

    carryObject thread carryObjectProxThink();
  }

  carryObject thread updateCarryObjectOrigin();

  return carryObject;
}

carryObjectUseThink() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", player);

    if(self.isResetting) {
      continue;
    }

    if(!isReallyAlive(player)) {
      continue;
    }

    if(!self canInteractWith(player.pers["team"])) {
      continue;
    }

    if(!player.canPickupObject) {
      continue;
    }

    if(!isDefined(player.initialized_gameobject_vars)) {
      continue;
    }

    if(isDefined(player.throwingGrenade)) {
      continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    self setPickedUp(player);
  }
}

carryObjectProxThink() {
  self thread carryObjectProxThinkDelayed();
}

carryObjectProxThinkDelayed() {
  level endon("game_ended");

  self thread Proxtriggerthink();
  while(true) {
    waittillframeend;
    if(self.useTime && self.curProgress >= self.useTime) {
      self.curProgress = 0;

      creditPlayer = getEarliestClaimPlayer();

      if(isDefined(self.onEndUse)) {
        self[[self.onEndUse]](self getClaimTeam(), creditPlayer, isDefined(creditPlayer));
      }

      if(isDefined(creditPlayer)) {
        self setPickedUp(creditPlayer);
      }

      self setClaimTeam("none");
      self.claimPlayer = undefined;
    }

    if(self.claimTeam != "none") {
      if(self.useTime) {
        if(!self.numTouching[self.claimTeam]) {
          if(isDefined(self.onEndUse)) {
            self[[self.onEndUse]](self getClaimTeam(), self.claimPlayer, false);
          }

          self setClaimTeam("none");
          self.claimPlayer = undefined;
        } else {
          self.curProgress += (50 * self.useRate);
          if(isDefined(self.onUseUpdate)) {
            self[[self.onUseUpdate]](self getClaimTeam(), self.curProgress / self.useTime, (50 * self.useRate) / self.useTime);
          }
        }
      } else {
        if(isReallyAlive(self.claimPlayer)) {
          self setPickedUp(self.claimPlayer);
        }

        self setClaimTeam("none");
        self.claimPlayer = undefined;
      }
    }

    wait(0.05);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
}

pickupObjectDelay(origin) {
  level endon("game_ended");

  self endon("death");
  self endon("disconnect");

  self.canPickupObject = false;

  for(;;) {
    if(distanceSquared(self.origin, origin) > 64 * 64) {
      break;
    }

    wait 0.2;
  }

  self.canPickupObject = true;
}

setPickedUp(player) {
  assert(isReallyAlive(player));

  if(IsAI(player) && isDefined(player.owner)) {
    return;
  }

  if(isDefined(player.carryObject)) {
    if(isDefined(self.onPickupFailed)) {
      self[[self.onPickupFailed]](player);
    }

    return;
  }

  player giveObject(self);

  self setCarrier(player);

  for(index = 0; index < self.visuals.size; index++) {
    self.visuals[index] hide();
  }

  self.trigger.origin += (0, 0, 10000);

  self notify("pickup_object");
  if(isDefined(self.onPickup)) {
    self[[self.onPickup]](player);
  }

  self updateCompassIcons();
  self updateWorldIcons();
}

updateCarryObjectOrigin() {
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curOrigin = self.carrier.origin + (0, 0, 75);
      self.objPoints["allies"] maps\mp\gametypes\_objpoints::updateOrigin(self.curOrigin);
      self.objPoints["axis"] maps\mp\gametypes\_objpoints::updateOrigin(self.curOrigin);

      if((self.visibleTeam == "friendly" || self.visibleTeam == "any") && self isFriendlyTeam("allies") && self.objIDPingFriendly) {
        if(self.objPoints["allies"].isShown) {
          self.objPoints["allies"].alpha = self.objPoints["allies"].baseAlpha;
          self.objPoints["allies"] fadeOverTime(self.objPingDelay + 1.0);
          self.objPoints["allies"].alpha = 0;
        }
        objective_position(self.objIDAllies, self.curOrigin);
      } else if((self.visibleTeam == "friendly" || self.visibleTeam == "any") && self isFriendlyTeam("axis") && self.objIDPingFriendly) {
        if(self.objPoints["axis"].isShown) {
          self.objPoints["axis"].alpha = self.objPoints["axis"].baseAlpha;
          self.objPoints["axis"] fadeOverTime(self.objPingDelay + 1.0);
          self.objPoints["axis"].alpha = 0;
        }
        objective_position(self.objIDAxis, self.curOrigin);
      }

      if((self.visibleTeam == "enemy" || self.visibleTeam == "any") && !self isFriendlyTeam("allies") && self.objIDPingEnemy) {
        if(self.objPoints["allies"].isShown) {
          self.objPoints["allies"].alpha = self.objPoints["allies"].baseAlpha;
          self.objPoints["allies"] fadeOverTime(self.objPingDelay + 1.0);
          self.objPoints["allies"].alpha = 0;
        }
        objective_position(self.objIDAllies, self.curOrigin);
      } else if((self.visibleTeam == "enemy" || self.visibleTeam == "any") && !self isFriendlyTeam("axis") && self.objIDPingEnemy) {
        if(self.objPoints["axis"].isShown) {
          self.objPoints["axis"].alpha = self.objPoints["axis"].baseAlpha;
          self.objPoints["axis"] fadeOverTime(self.objPingDelay + 1.0);
          self.objPoints["axis"].alpha = 0;
        }
        objective_position(self.objIDAxis, self.curOrigin);
      }

      self wait_endon(self.objPingDelay, "dropped", "reset");
    } else {
      self.objPoints["allies"] maps\mp\gametypes\_objpoints::updateOrigin(self.curOrigin + self.offset3d);
      self.objPoints["axis"] maps\mp\gametypes\_objpoints::updateOrigin(self.curOrigin + self.offset3d);

      wait(0.05);
    }
  }
}

hideCarryIconOnGameEnd() {
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  level waittill("game_ended");

  if(isDefined(self.carryIcon)) {
    self.carryIcon.alpha = 0;
  }
}

giveObject(object) {
  assert(!isDefined(self.carryObject));

  self.carryObject = object;
  self thread trackCarrier();

  if(isDefined(object.carryWeapon)) {
    object.carrierWeaponCurrent = self GetCurrentPrimaryWeapon();

    object.carrierHasCarryWeaponInLoadout = self HasWeapon(object.carryWeapon);
    if(isDefined(object.carryWeaponThink)) {
      self thread[[object.carryWeaponThink]]();
    }

    self GiveWeapon(object.carryWeapon);
    self SwitchToWeaponImmediate(object.carryWeapon);
    self DisableWeaponPickup();
    self _disableWeaponSwitch();
  } else if(!object.allowWeapons) {
    self _disableWeapon();
    if(isDefined(object.manualDropThink)) {
      self thread[[object.manualDropThink]]();
    } else {
      self thread manualDropThink();
    }
  }

  if(isDefined(object.carryIcon) && isPlayer(self)) {
    if(level.splitscreen) {
      self.carryIcon = createIcon(object.carryIcon, 33, 33);
      self.carryIcon setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -50, -78);
    } else {
      self.carryIcon = createIcon(object.carryIcon, 50, 50);
      self.carryIcon setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -90, -110);
    }

    self.carryIcon.hidewheninmenu = true;
    self thread hideCarryIconOnGameEnd();
  }

  if(isDefined(object.goliathThink)) {
    self thread[[object.goliathThink]]();
  }
}

returnHome() {
  self.isResetting = true;

  self notify("reset");
  for(index = 0; index < self.visuals.size; index++) {
    self.visuals[index].origin = self.visuals[index].baseOrigin;
    self.visuals[index].angles = self.visuals[index].baseAngles;
    self.visuals[index] show();
  }
  self.trigger.origin = self.trigger.baseOrigin;

  self.curOrigin = self.trigger.origin;

  if(isDefined(self.onReset)) {
    self[[self.onReset]]();
  }

  self clearCarrier();

  updateWorldIcons();
  updateCompassIcons();

  self.isResetting = false;
}

isHome() {
  if(isDefined(self.carrier)) {
    return false;
  }

  if(self.curOrigin != self.trigger.baseOrigin) {
    return false;
  }

  return true;
}

setPosition(origin, angles) {
  self.isResetting = true;

  for(index = 0; index < self.visuals.size; index++) {
    self.visuals[index].origin = origin;
    self.visuals[index].angles = angles;
    self.visuals[index] show();
  }
  self.trigger.origin = origin;

  self.curOrigin = self.trigger.origin;

  self clearCarrier();

  updateWorldIcons();
  updateCompassIcons();

  self.isResetting = false;
}

onPlayerLastStand() {
  if(isDefined(self.carryObject)) {
    assert(self.carryObject.carrier == self);
    self.carryObject thread setDropped();
  }
}

carryobject_overrideMovingPlatformDeath(data) {
  for(index = 0; index < data.carryobject.visuals.size; index++) {
    data.carryobject.visuals[index] Unlink();
  }

  data.carryobject.trigger Unlink();

  data.carryobject notify("stop_pickup_timeout");

  data.carryobject returnHome();
}

setDropped() {
  if(isDefined(self.setDropped)) {
    if([[self.setDropped]]()) {
      return;
    }
  }

  self.isResetting = true;

  self notify("dropped");

  if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    if(isDefined(self.carrier.body)) {
      trace = playerPhysicsTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), self.carrier.body);
      angleTrace = bulletTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), false, self.carrier.body);
    } else {
      trace = playerPhysicsTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000));
      angleTrace = bulletTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), false);
    }
  } else {
    trace = playerPhysicsTrace(self.safeOrigin + (0, 0, 20), self.safeOrigin - (0, 0, 20));
    angleTrace = bulletTrace(self.safeOrigin + (0, 0, 20), self.safeOrigin - (0, 0, 20), false, undefined);
  }

  droppingPlayer = self.carrier;

  if(isDefined(trace)) {
    tempAngle = randomfloat(360);

    dropOrigin = trace;
    if(isDefined(self.visualGroundOffset)) {
      dropOrigin += self.visualGroundOffset;
    }

    if(angleTrace["fraction"] < 1 && distance(angleTrace["position"], trace) < 10.0) {
      forward = (cos(tempAngle), sin(tempAngle), 0);
      forward = VectorNormalize(forward - (angleTrace["normal"] * VectorDot(forward, angleTrace["normal"])));
      dropAngles = vectortoangles(forward);
    } else {
      dropAngles = (0, tempAngle, 0);
    }

    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index].origin = dropOrigin;
      self.visuals[index].angles = dropAngles;
      self.visuals[index] show();
    }
    self.trigger.origin = dropOrigin;

    self.curOrigin = self.trigger.origin;

    data = spawnStruct();
    data.carryobject = self;
    data.deathOverrideCallback = ::carryobject_overrideMovingPlatformDeath;
    self.trigger thread maps\mp\_movers::handle_moving_platforms(data);

    self thread pickupTimeout();
  }

  if(!isDefined(trace)) {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index].origin = self.visuals[index].baseOrigin;
      self.visuals[index].angles = self.visuals[index].baseAngles;
      self.visuals[index] show();
    }
    self.trigger.origin = self.trigger.baseOrigin;

    self.curOrigin = self.trigger.baseOrigin;
  }

  if(isDefined(self.onDrop)) {
    self[[self.onDrop]](droppingPlayer);
  }

  self clearCarrier();

  self updateCompassIcons();
  self updateWorldIcons();

  self.isResetting = false;
}

setCarrier(carrier) {
  self.carrier = carrier;

  self thread updateVisibilityAccordingToRadar();
}

clearCarrier() {
  if(!isDefined(self.carrier)) {
    return;
  }

  self.carrier takeObject(self);

  self.carrier = undefined;

  self notify("carrier_cleared");
}

pickupTimeout() {
  self endon("pickup_object");
  self endon("stop_pickup_timeout");

  wait(0.05);

  if(isTouchingBadTrigger()) {
    self returnHome();
    return;
  }

  if(isDefined(self.autoResetTime)) {
    wait(self.autoResetTime);

    if(!isDefined(self.carrier)) {
      self returnHome();
    }
  }
}

isTouchingBadTrigger() {
  BoundaryTriggers = getEntArray("out_of_bounds", "targetname");
  for(index = 0; index < BoundaryTriggers.size; index++) {
    if(!self.visuals[0] isTouching(BoundaryTriggers[index])) {
      continue;
    }

    return true;
  }

  if(!self.visuals[0] PhysicsIsActive()) {
    boundaryTriggers = getEntArray("out_of_bounds_at_rest", "targetname");
    for(index = 0; index < BoundaryTriggers.size; index++) {
      if(!self.visuals[0] isTouching(BoundaryTriggers[index])) {
        continue;
      }

      return true;
    }
  }

  hurtTriggers = getEntArray("trigger_hurt", "classname");
  for(index = 0; index < hurtTriggers.size; index++) {
    if(!self.visuals[0] isTouching(hurtTriggers[index])) {
      continue;
    }

    return true;
  }

  if(self.waterBadTrigger) {
    waterTriggers = getEntArray("trigger_underwater", "targetname");
    for(index = 0; index < waterTriggers.size; index++) {
      if(!self.visuals[0] isTouching(waterTriggers[index])) {
        continue;
      }

      return true;
    }
  }

  return false;
}

getCarrierWeaponCurrent(object) {
  if(isDefined(object.carrierWeaponCurrent) && self HasWeapon(object.carrierWeaponCurrent)) {
    return object.carrierWeaponCurrent;
  }

  carrierWeapons = self GetWeaponsListPrimaries();
  return carrierWeapons[0];
}

takeObject(object) {
  if(isDefined(self.carryIcon)) {
    self.carryIcon destroyElem();
  }

  if(isDefined(self)) {
    self.carryObject = undefined;
  }

  self notify("drop_object");

  if(object.triggerType == "proximity") {
    self thread pickupObjectDelay(object.trigger.origin);
  }

  if(isReallyAlive(self)) {
    if(isDefined(object.carryWeapon)) {
      keepWeapon = isDefined(object.keepCarryWeapon) && object.keepCarryWeapon;
      if(!object.carrierHasCarryWeaponInLoadout && !keepWeapon) {
        self TakeWeapon(object.carryWeapon);
      }

      weapon = getCarrierWeaponCurrent(object);
      self SwitchToWeapon(weapon);

      self EnableWeaponPickup();
      self _enableWeaponSwitch();
    } else if(!object.allowWeapons) {
      self _enableWeapon();
    }
  }
}

trackCarrier() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  while(isDefined(self.carryObject) && isReallyAlive(self)) {
    if(self isOnGround()) {
      trace = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), false, undefined);
      if(trace["fraction"] < 1) {
        self.carryObject.safeOrigin = trace["position"];
      }
    }
    wait(0.05);
  }
}

manualDropThink() {
  level endon("game_ended");

  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryOffhandbuttonPressed() || self meleeButtonPressed()) {
      wait .05;
    }

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryOffhandbuttonPressed() && !self meleeButtonPressed()) {
      wait .05;
    }

    if(isDefined(self.carryObject) && !self useButtonPressed()) {
      self.carryObject thread setDropped();
    }
  }
}

deleteUseObject() {
  if(isDefined(self.objIDAllies) && isDefined(self.objIDAxis)) {
    _objective_delete(self.objIDAllies);
    _objective_delete(self.objIDAxis);
    _objective_delete(self.objIDMLGSpectator);
  }

  if(isDefined(self.objPoints)) {
    maps\mp\gametypes\_objpoints::deleteObjPoint(self.objPoints["allies"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(self.objPoints["axis"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(self.objPoints["mlg"]);
  }

  self.trigger = undefined;

  self notify("deleted");
}

createUseObject(ownerTeam, trigger, visuals, offset, skipObjective) {
  useObject = spawnStruct();
  useObject.type = "useObject";
  useObject.curOrigin = trigger.origin;
  useObject.ownerTeam = ownerTeam;
  useObject.entNum = trigger getEntityNumber();
  useObject.keyObject = undefined;

  if(isSubStr(trigger.classname, "use")) {
    useObject.triggerType = "use";
  } else {
    useObject.triggerType = "proximity";
  }

  useObject.trigger = trigger;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseOrigin = visuals[index].origin;
    visuals[index].baseAngles = visuals[index].angles;
  }
  useObject.visuals = visuals;

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  useObject.offset3d = offset;

  if(!isDefined(skipObjective) || !skipObjective) {
    useObject.compassIcons = [];
    useObject.objIDAllies = getNextObjID();
    useObject.objIDAxis = getNextObjID();
    useObject.objIDMLGSpectator = getNextObjID();

    objective_add(useObject.objIDAllies, "invisible", useObject.curOrigin);
    objective_add(useObject.objIDAxis, "invisible", useObject.curOrigin);
    objective_add(useObject.objIDMLGSpectator, "invisible", useObject.curOrigin);
    objective_team(useObject.objIDAllies, "allies");
    objective_team(useObject.objIDAxis, "axis");
    objective_mlgspectator(useObject.objIDMLGSpectator);

    useObject.objPoints["allies"] = maps\mp\gametypes\_objpoints::createTeamObjpoint("objpoint_allies_" + useObject.entNum, useObject.curOrigin + offset, "allies", undefined);
    useObject.objPoints["axis"] = maps\mp\gametypes\_objpoints::createTeamObjpoint("objpoint_axis_" + useObject.entNum, useObject.curOrigin + offset, "axis", undefined);
    useObject.objPoints["mlg"] = maps\mp\gametypes\_objpoints::createTeamObjpoint("objpoint_mlg_" + useObject.entNum, useObject.curOrigin + offset, "mlg", undefined);

    useObject.objPoints["mlg"].archived = false;

    useObject.objPoints["allies"].alpha = 0;
    useObject.objPoints["axis"].alpha = 0;
    useObject.objPoints["mlg"].alpha = 0;
  }

  useObject.interactTeam = "none";
  useObject.keepProgress = false;

  useObject.worldIcons = [];
  useObject.visibleTeam = "none";

  useObject.onUse = undefined;
  useObject.onCantUse = undefined;

  useObject.useText = "default";
  useObject.useTime = 10000;
  useObject.curProgress = 0;

  if(useObject.triggerType == "proximity") {
    useObject.teamUseTimes = [];
    useObject.teamUseTexts = [];

    useObject.numTouching["neutral"] = 0;
    useObject.numTouching["axis"] = 0;
    useObject.numTouching["allies"] = 0;
    useObject.numTouching["none"] = 0;
    useObject.touchList["neutral"] = [];
    useObject.touchList["axis"] = [];
    useObject.touchList["allies"] = [];
    useObject.touchList["none"] = [];
    useObject.useRate = 0;
    useObject.claimTeam = "none";
    useObject.claimPlayer = undefined;
    useObject.lastClaimTeam = "none";
    useObject.lastClaimTime = 0;
    useObject.mustMaintainClaim = false;
    useObject.canContestClaim = false;

    if(level.multiteambased) {
      foreach(name in level.teamnamelist) {
        useObject.numTouching[name] = 0;
        useObject.touchList[name] = [];
      }
    }

    useObject thread useObjectProxThink();
  } else {
    useObject.useRate = 1;
    useObject thread useObjectUseThink();
  }

  return useObject;
}

move_use_object(dest_origin, objPoint_offset) {
  if(!isDefined(objPoint_offset)) {
    objPoint_offset = (0, 0, 0);
  }

  if(isDefined(self.trigger)) {
    self.trigger DontInterpolate();
    self.trigger.origin = dest_origin;
  }

  if(isDefined(self.trigger.baseOrigin)) {
    self.trigger.baseOrigin = dest_origin;
  }

  if(isDefined(self.levelflag)) {
    self.levelflag DontInterpolate();
    self.levelflag.origin = dest_origin;
  }

  if(isDefined(self.visuals)) {
    foreach(visual in self.visuals) {
      visual DontInterpolate();
      visual.origin = dest_origin;
      visual.baseorigin = dest_origin;
    }
  }

  if(isDefined(self.origin)) {
    self.origin = dest_origin;
  }

  if(isDefined(self.curOrigin)) {
    self.curOrigin = dest_origin;
  }

  if(isDefined(self.goal)) {
    if(isDefined(self.goal.score_fx)) {
      foreach(fx in self.goal.score_fx) {
        fx.origin = dest_origin;
      }
    }

    if(isDefined(self.goal.origin)) {
      self.goal.origin = dest_origin;
    }
  }

  if(isDefined(self.objPoints)) {
    foreach(objPoint in self.objPoints) {
      objPoint maps\mp\gametypes\_objpoints::updateOrigin(dest_origin + objPoint_offset);
    }
  }

  if(isDefined(self.objIDAllies)) {
    Objective_Position(self.objIDAllies, dest_origin);
  }
  if(isDefined(self.objIDAxis)) {
    Objective_Position(self.objIDAxis, dest_origin);
  }
  if(isDefined(self.objIDMLGSpectator)) {
    Objective_Position(self.objIDMLGSpectator, dest_origin);
  }

  if(isDefined(self.baseeffect)) {
    self.baseeffect delete();

    traceStart = self.visuals[0].origin + (0, 0, 32);
    traceEnd = self.visuals[0].origin + (0, 0, -32);
    trace = bulletTrace(traceStart, traceEnd, false, undefined);
    upangles = vectorToAngles(trace["normal"]);

    self.baseeffectforward = anglesToForward(upangles);
    self.baseeffectright = anglesToRight(upangles);
    self.baseeffectpos = trace["position"];

    if(level.gameType == "dom") {
      self maps\mp\gametypes\dom::updateVisuals();
    }
  }
}

setKeyObject(object) {
  self.keyObject = object;
}

useObjectUseThink() {
  level endon("game_ended");
  self endon("deleted");

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isReallyAlive(player)) {
      continue;
    }

    if(!self canInteractWith(player.pers["team"])) {
      continue;
    }

    if(!player isOnGround()) {
      continue;
    }

    if(player IsDodging()) {
      continue;
    }

    currentWeapon = player GetCurrentPrimaryWeapon();
    if(!player isJuggernaut() && isKillstreakWeapon(currentWeapon) && !IsSubStr(currentWeapon, "turrethead")) {
      continue;
    }

    if(!checkKeyObject(player)) {
      if(isDefined(self.onCantUse)) {
        self[[self.onCantUse]](player);
      }
      continue;
    }

    if(!player isWeaponEnabled()) {
      continue;
    }

    result = true;
    if(self.useTime > 0) {
      if(isDefined(self.onBeginUse)) {
        self[[self.onBeginUse]](player);
      }

      if(!isDefined(self.keyObject)) {
        self thread cantUseHintThink();
      }

      team = player.pers["team"];

      result = self useHoldThink(player);

      self notify("finished_use");

      if(isDefined(self.onEndUse)) {
        self[[self.onEndUse]](team, player, result);
      }
    }

    if(!result) {
      continue;
    }

    if(isDefined(self.onUse)) {
      self[[self.onUse]](player);
    }
  }
}

checkKeyObject(player) {
  if(!isDefined(self.keyObject)) {
    return true;
  }

  if(!isDefined(player.carryObject)) {
    return false;
  }

  keyObjects = self.keyObject;
  if(!IsArray(keyObjects)) {
    keyObjects = [keyObjects];
  }

  foreach(key in keyObjects) {
    if(key == player.carryObject) {
      return true;
    }
  }

  return false;
}

cantUseHintThink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isReallyAlive(player)) {
      continue;
    }

    if(!self canInteractWith(player.pers["team"])) {
      continue;
    }

    if(isDefined(self.onCantUse)) {
      self[[self.onCantUse]](player);
    }
  }
}

getEarliestClaimPlayer() {
  assert(self.claimTeam != "none");
  team = self.claimTeam;

  if(isReallyAlive(self.claimPlayer)) {
    earliestPlayer = self.claimPlayer;
  } else {
    earliestPlayer = undefined;
  }

  if(self.touchList[team].size > 0) {
    earliestTime = undefined;
    players = getArrayKeys(self.touchList[team]);
    for(index = 0; index < players.size; index++) {
      touchdata = self.touchList[team][players[index]];
      if(isReallyAlive(touchdata.player) && (!isDefined(earliestTime) || touchdata.starttime < earliestTime)) {
        earliestPlayer = touchdata.player;
        earliestTime = touchdata.starttime;
      }
    }
  }

  return earliestPlayer;
}

useObjectProxThink() {
  level endon("game_ended");
  self endon("deleted");

  self thread proxTriggerThink();

  while(true) {
    if(self.useTime && self.curProgress >= self.useTime) {
      self.curProgress = 0;

      creditPlayer = getEarliestClaimPlayer();

      if(isDefined(self.onEndUse)) {
        self[[self.onEndUse]](self getClaimTeam(), creditPlayer, isDefined(creditPlayer));
      }

      if(isDefined(creditPlayer) && isDefined(self.onUse)) {
        self[[self.onUse]](creditPlayer);
      }

      if(!self.mustMaintainClaim) {
        self setClaimTeam("none");
        self.claimPlayer = undefined;
      }
    }

    if(self.claimTeam != "none") {
      if(self.useTime &&
        (!self.mustMaintainClaim || (self getOwnerTeam() != self getClaimTeam()))) {
        if(!self.numTouching[self.claimTeam]) {
          if(isDefined(self.onEndUse)) {
            self[[self.onEndUse]](self getClaimTeam(), self.claimPlayer, false);
          }

          self setClaimTeam("none");
          self.claimPlayer = undefined;
        } else {
          self.curProgress += (50 * self.useRate);
          if(self.curProgress <= 0) {
            self.curProgress *= -1;
            self.lastClaimTeam = self.claimTeam;
            self updateUseRate();
          }
          if(isDefined(self.onUseUpdate)) {
            self[[self.onUseUpdate]](self getClaimTeam(), self.curProgress / self.useTime, (50 * self.useRate) / self.useTime);
          }
        }
      } else if(!self.mustMaintainClaim) {
        if(isDefined(self.onUse)) {
          self[[self.onUse]](self.claimPlayer);
        }

        if(!self.mustMaintainClaim) {
          self setClaimTeam("none");
          self.claimPlayer = undefined;
        }
      } else if(!self.numTouching[self.claimTeam]) {
        if(isDefined(self.onUnoccupied)) {
          self[[self.onUnoccupied]]();
        }

        self setClaimTeam("none");
        self.claimPlayer = undefined;
      } else if(self.canContestClaim) {
        numOther = getNumTouchingExceptTeam(self.claimTeam);

        if(numOther > 0) {
          if(isDefined(self.onContested)) {
            self[[self.onContested]]();
          }

          self setClaimTeam("none");
          self.claimPlayer = undefined;
        }
      }
    } else {
      if(self.mustMaintainClaim && (self getOwnerTeam() != "none")) {
        if(!self.numTouching[self getOwnerTeam()]) {
          if(isDefined(self.onUnoccupied)) {
            self[[self.onUnoccupied]]();
          }
        } else if(self.canContestClaim && self.lastClaimTeam != "none" && self.numTouching[self.lastClaimTeam]) {
          numOther = getNumTouchingExceptTeam(self.lastClaimTeam);

          if(numOther == 0) {
            if(isDefined(self.onUncontested)) {
              self[[self.onUncontested]](self.lastClaimTeam);
            }
          }
        }
      }
    }

    wait(0.05);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }
}

canClaim(player) {
  if(isDefined(self.carrier)) {
    return false;
  }

  if(self.canContestClaim) {
    numOther = getNumTouchingExceptTeam(player.pers["team"]);

    if(numOther != 0) {
      return false;
    }
  }

  if(checkKeyObject(player)) {
    return true;
  }

  return false;
}

proxTriggerThink() {
  level endon("game_ended");
  self endon("deleted");

  entityNumber = self.entNum;

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isReallyAlive(player)) {
      continue;
    }

    if(!IsGameParticipant(player)) {
      continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }

    if(player isUsingRemote() || isDefined(player.spawningAfterRemoteDeath) || player isInRemoteTransition()) {
      continue;
    }

    if(isDefined(player.classname) && player.classname == "script_vehicle") {
      continue;
    }

    if(!isDefined(player.initialized_gameobject_vars)) {
      continue;
    }

    if(isDefined(self.nextUseTime) && self.nextUseTime > GetTime()) {
      continue;
    }

    if(isDefined(self.canUseObject) && ![[self.canUseObject]](player)) {
      continue;
    }

    if(self canInteractWith(player.pers["team"], player) && self.claimTeam == "none") {
      if(self canClaim(player)) {
        if(!self proxTriggerLOS(player, self.visuals)) {
          continue;
        }

        setClaimTeam(player.pers["team"]);
        self.claimPlayer = player;

        relativeTeam = self getRelativeTeam(player.pers["team"]);
        if(isDefined(self.teamUseTimes[relativeTeam])) {
          self.useTime = self.teamUseTimes[relativeTeam];
        }

        if(self.useTime && isDefined(self.onBeginUse)) {
          self[[self.onBeginUse]](self.claimPlayer);
        }
      } else {
        if(isDefined(self.onCantUse)) {
          self[[self.onCantUse]](player);
        }
      }
    }

    if(isReallyAlive(player) && !isDefined(player.touchTriggers[entityNumber])) {
      player thread triggerTouchThink(self);
    }
  }
}

proxTriggerLOS(player, ignoreEnts) {
  if(!isDefined(self.requiresLOS) || !self.requiresLOS) {
    return true;
  }

  offsets = [32, 16, 0];

  ignoreEnt = undefined;
  if(isDefined(ignoreEnts) && ignoreEnts.size) {
    if(ignoreEnts.size > 1) {
      AssertMsg("proxTriggerLOS check on gameobject with multiple visual ents, BulletTrace only supports a single ignoreEnt\n");
    }
    ignoreEnt = ignoreEnts[0];
  }

  dir_offset = player.origin - self.trigger.origin;
  dir_offset = (dir_offset[0], dir_offset[1], 0);
  dir_offset = VectorNormalize(dir_offset);
  dir_offset = dir_offset * 5;

  foreach(z_offset in offsets) {
    traceStart = player getEye();
    traceEnd = self.trigger.origin + dir_offset + (0, 0, z_offset);
    trace = bulletTrace(traceStart, traceEnd, false, ignoreEnt, 0, 0, 0, 0, 1, 0, 0);
    if(trace["fraction"] == 1) {
      return true;
    }
  }

  return false;
}

setClaimTeam(newTeam) {
  assert(newTeam != self.claimTeam);
  if(self.keepProgress) {
    if(self.lastClaimTeam == "none") {
      self.lastClaimTeam = newTeam;
    }

    self.claimTeam = newTeam;
  } else {
    if(self.claimTeam == "none" && getTime() - self.lastClaimTime > 1000) {
      self.curProgress = 0;
    } else if(newTeam != "none" && newTeam != self.lastClaimTeam) {
      self.curProgress = 0;
    }

    self.lastClaimTeam = self.claimTeam;
  }

  self.lastClaimTime = getTime();
  self.claimTeam = newTeam;

  self updateUseRate();
}

getClaimTeam() {
  return self.claimTeam;
}

triggerTouchThink(object) {
  team = self.pers["team"];

  object.numTouching[team]++;

  touchName = self.guid;
  struct = spawnStruct();
  struct.player = self;
  struct.starttime = gettime();
  object.touchList[team][touchName] = struct;

  if(!isDefined(object.noUseBar)) {
    object.noUseBar = false;
  }

  self.touchTriggers[object.entNum] = object.trigger;

  object updateUseRate();

  while(isReallyAlive(self) && isDefined(object.trigger) && (self isTouching(object.trigger) || isBoostingAboveTriggerRadius(object.trigger)) && !level.gameEnded) {
    if(isPlayer(self) && object.useTime) {
      self updateUIProgress(object, true);
      self updateProxBar(object, false);
    }
    wait(0.05);
  }

  if(isDefined(self) && isDefined(self.touchTriggers)) {
    if(isPlayer(self) && object.useTime) {
      self updateUIProgress(object, false);
      self updateProxBar(object, true);
    }
    self.touchTriggers[object.entNum] = undefined;
  }

  if(level.gameEnded) {
    return;
  }

  object.touchList[team][touchName] = undefined;

  object.numTouching[team]--;
  object updateUseRate();
}

isBoostingAboveTriggerRadius(triggerRadius) {
  if(!isDefined(level.allowBoostingAboveTriggerRadius) || !level.allowBoostingAboveTriggerRadius) {
    return false;
  }

  if(!isAugmentedGameMode()) {
    return false;
  }

  if(!self IsHighJumping()) {
    return false;
  }

  distanceFromTriggerSQ = Distance2DSquared(self.origin, triggerRadius.origin);

  if(distanceFromTriggerSQ < (triggerRadius.radius * triggerRadius.radius)) {
    return true;
  }

  return false;
}

updateProxBar(object, forceRemove) {
  self_pers_team = self.pers["team"];
  if(forceRemove || !object canInteractWith(self_pers_team) || self_pers_team != object.claimTeam || object.noUseBar) {
    if(isDefined(self.proxBar)) {
      self.proxBar hideElem();
    }

    if(isDefined(self.proxBarText)) {
      self.proxBarText hideElem();
    }
    return;
  }

  if(!isDefined(self.proxBar)) {
    self.proxBar = createPrimaryProgressBar();
    self.proxBar.lastUseRate = undefined;
    self.proxBar.lastHostMigrationState = false;
  }

  if(self.proxBar.hidden) {
    self.proxBar showElem();
    self.proxBar.lastUseRate = undefined;
    self.proxBar.lastHostMigrationState = false;
  }

  if(!isDefined(self.proxBarText)) {
    self.proxBarText = createPrimaryProgressBarText();

    relativeTeam = object getRelativeTeam(self_pers_team);

    if(isDefined(object.teamUseTexts[relativeTeam])) {
      self.proxBarText setText(object.teamUseTexts[relativeTeam]);
    } else {
      self.proxBarText setText(object.useText);
    }
  }

  if(self.proxBarText.hidden) {
    self.proxBarText showElem();

    relativeTeam = object getRelativeTeam(self_pers_team);

    if(isDefined(object.teamUseTexts[relativeTeam])) {
      self.proxBarText setText(object.teamUseTexts[relativeTeam]);
    } else {
      self.proxBarText setText(object.useText);
    }
  }

  if(!isDefined(self.proxBar.lastUseRate) || self.proxBar.lastUseRate != object.useRate || self.proxBar.lastHostMigrationState != isDefined(level.hostMigrationTimer)) {
    if(object.curProgress > object.useTime) {
      object.curProgress = object.useTime;
    }

    progress = object.curProgress / object.useTime;
    rate = (1000 / object.useTime) * object.useRate;
    if(isDefined(level.hostMigrationTimer)) {
      rate = 0;
    }

    if(object.keepProgress && !progress && rate < 0) {
      rate = 0;
    }

    self.proxBar updateBar(progress, rate);

    self.proxBar.lastUseRate = object.useRate;

    self.proxBar.lastHostMigrationState = isDefined(level.hostMigrationTimer);
  }
}

getNumTouchingExceptTeam(ignoreTeam) {
  return self.numTouching[getOtherTeam(ignoreTeam)];
}

updateUIProgress(object, securing) {
  gametype = level.gametype;
  id = object.id;
  contested = false;

  if(!isDefined(level.hostMigrationTimer)) {
    if(object.curProgress > object.useTime) {
      object.curProgress = object.useTime;
    }

    progress = object.curProgress / object.useTime;

    if((gametype == "dom") && isDefined(id) && (id == "domFlag")) {
      if(securing && isDefined(object.staleMate) && object.staleMate) {
        playerCapping = object getEarliestClaimPlayer();

        contested = true;

        if(isDefined(playerCapping) && (playerCapping.team != self.team)) {
          progress = 0.01;
        }
      }

      if(!securing) {
        progress = 0.01;
      }

      if(progress != 0) {
        self SetClientOmnvar("ui_capture_progress", progress);
      }
    }

    if((gametype == "sd" || gametype == "sr") && isDefined(id) && (id == "bombZone" || id == "defuseObject")) {
      if(!securing) progress = 0;
      progress = max(0.01, progress);
      if(progress != 0) {
        self SetClientOmnvar("ui_capture_progress", progress);
      }
    }

    if(gametype == "twar" && isDefined(id) && id == "twarZone") {
      if(!securing) progress = 0;
      progress = max(0.01, progress);
      if(progress != 0) {
        self SetClientOmnvar("ui_capture_progress", progress);
      }
    }

  }

  if((gametype == "dom") && isDefined(id) && (id == "domFlag")) {
    if(securing && object.ownerTeam == self.team) {
      securing = false;
    }

    if(!securing) {
      self SetClientOmnvar("ui_capture_icon", 0);
    } else {
      if(!contested) {
        if(object.label == "_a") {
          self SetClientOmnvar("ui_capture_icon", 1);
        } else if(object.label == "_b") {
          self SetClientOmnvar("ui_capture_icon", 2);
        } else if(object.label == "_c") {
          self SetClientOmnvar("ui_capture_icon", 3);
        }
      } else {
        self SetClientOmnvar("ui_capture_icon", 4);
      }
    }
  }

  if((gametype == "sd" || gametype == "sr") && isDefined(id) && (id == "bombZone" || id == "defuseObject")) {
    if(!securing) {
      self SetClientOmnvar("ui_capture_icon", 0);
    } else if(object maps\mp\gametypes\_gameobjects::isFriendlyTeam(self.pers["team"])) {
      self SetClientOmnvar("ui_capture_icon", 2);
    } else {
      self SetClientOmnvar("ui_capture_icon", 1);
    }
  }

  if(gametype == "twar" && isDefined(id) && id == "twarZone") {
    if(!securing || (isDefined(object.staleMate) && object.staleMate)) {
      self SetClientOmnvar("ui_capture_icon", 0);
    } else {
      self SetClientOmnvar("ui_capture_icon", 1);
    }
  }

}

updateUseRate() {
  if(isDefined(self.onUpdateUseRate)) {
    self[[self.onUpdateUseRate]]();
  } else {
    self updateUseRate_internal();
  }
}

updateUseRate_internal() {
  numClaimants = self.numTouching[self.claimTeam];
  numOther = 0;
  hasObjScale = 0;

  if(level.multiTeamBased) {
    foreach(teamName in level.teamNameList) {
      if(self.claimTeam != teamName) {
        numOther += self.numTouching[teamName];
      }
    }
  } else {
    if(self.claimTeam != "axis") {
      numOther += self.numTouching["axis"];
    }
    if(self.claimTeam != "allies") {
      numOther += self.numTouching["allies"];
    }
  }

  foreach(struct in self.touchList[self.claimteam]) {
    if(!isDefined(struct.player)) {
      continue;
    }

    if(struct.player.pers["team"] != self.claimteam) {
      continue;
    }

    if(struct.player.objectiveScaler == 1) {
      continue;
    }

    numClaimants *= struct.player.objectiveScaler;
    hasObjScale = struct.player.objectiveScaler;
  }

  self.useRate = 0;
  self.staleMate = numClaimants && numOther;

  if(numClaimants && !numOther) {
    self.useRate = min(numClaimants, 4);
  }

  if(isDefined(self.isArena) && self.isArena && hasObjScale != 0) {
    self.useRate = 1 * hasObjScale;
  } else if(isDefined(self.isArena) && self.isArena) {
    self.useRate = 1;
  }

  if(self.keepProgress && self.lastclaimteam != self.claimTeam) {
    self.useRate *= -1;
  }
}

attachUseModel() {
  self endon("death");
  self endon("disconnect");
  self endon("done_using");

  wait 0.7;

  self attach("npc_search_dstry_bomb", "tag_inhand", true);
  self.attachedUseModel = "npc_search_dstry_bomb";
}

useHoldThink(player) {
  player notify("use_hold");
  if(isPlayer(player)) {
    player playerLinkTo(self.trigger);
  } else {
    player LinkTo(self.trigger);
  }

  player PlayerLinkedOffsetEnable();
  player clientClaimTrigger(self.trigger);
  player.claimTrigger = self.trigger;

  useWeapon = self.useWeapon;
  lastWeapon = player getCurrentWeapon();

  if(isDefined(useWeapon)) {
    assert(isDefined(lastWeapon));
    if(lastWeapon == useWeapon) {
      assert(isDefined(player.lastNonUseWeapon));
      lastWeapon = player.lastNonUseWeapon;
    }
    assert(lastWeapon != useWeapon);

    player.lastNonUseWeapon = lastWeapon;

    player _giveWeapon(useWeapon);
    player setWeaponAmmoStock(useWeapon, 0);
    player setWeaponAmmoClip(useWeapon, 0);
    player switchToWeapon(useWeapon);

    if(!isDefined(self.attachDefault3pModel) || self.attachDefault3pModel == true) {
      player thread attachUseModel();
    }
  } else {
    player _disableWeapon();
  }

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;

  if(isPlayer(player)) {
    player thread personalUseBar(self);
  }

  result = useHoldThinkLoop(player, lastWeapon);

  if(isDefined(player)) {
    player detachUseModels();
    player notify("done_using");
  }

  if(isDefined(useWeapon) && isDefined(player)) {
    player thread takeUseWeapon(useWeapon);
  }

  if(isDefined(result) && result) {
    return true;
  }

  if(isDefined(player)) {
    player.claimTrigger = undefined;
    if(isDefined(useWeapon)) {
      if(lastWeapon != "none") {
        player switch_to_last_weapon(lastWeapon);
      } else {
        player takeWeapon(useWeapon);
      }
    } else {
      player _enableWeapon();
    }

    player unlink();

    if(!isReallyAlive(player)) {
      player.killedInUse = true;
    }
  }

  self.inUse = false;
  self.trigger releaseClaimedTrigger();
  return false;
}

detachUseModels() {
  if(isDefined(self.attachedUseModel)) {
    self detach(self.attachedUseModel, "tag_inhand");
    self.attachedUseModel = undefined;
  }
}

takeUseWeapon(useWeapon) {
  self endon("use_hold");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(self getCurrentWeapon() == useWeapon && !isDefined(self.throwingGrenade)) {
    wait(0.05);
  }

  self takeWeapon(useWeapon);
}

usetest(player, waitForWeapon, timedOut, maxWaitTime) {
  if(!isReallyAlive(player)) {
    return false;
  }

  if(!player isTouching(self.trigger)) {
    return false;
  }

  if(!player useButtonPressed()) {
    return false;
  }

  if(isDefined(player.throwingGrenade)) {
    return false;
  }

  if(player meleeButtonPressed()) {
    return false;
  }

  if(self.curProgress >= self.useTime) {
    return false;
  }

  if(!self.useRate && !waitForWeapon) {
    return false;
  }

  if(waitForWeapon && timedOut > maxWaitTime) {
    return false;
  }

  return true;
}

useHoldThinkLoop(player, lastWeapon) {
  level endon("game_ended");
  self endon("disabled");

  useWeapon = self.useWeapon;
  waitForWeapon = true;
  timedOut = 0;

  maxWaitTime = 1.5;

  while(usetest(player, waitForWeapon, timedOut, maxWaitTime)) {
    timedOut += 0.05;

    if(!isDefined(useWeapon) || player getCurrentWeapon() == useWeapon) {
      self.curProgress += (50 * self.useRate);
      self.useRate = 1 * player.objectiveScaler;
      waitForWeapon = false;
    } else {
      self.useRate = 0;
    }

    if(self.curProgress >= self.useTime) {
      self.inUse = false;
      player clientReleaseTrigger(self.trigger);
      player.claimTrigger = undefined;

      if(isDefined(useWeapon)) {
        player setWeaponAmmoStock(useWeapon, 1);
        player setWeaponAmmoClip(useWeapon, 1);
        if(lastWeapon != "none") {
          player switch_to_last_weapon(lastWeapon);
        } else {
          player takeWeapon(useWeapon);
        }
      } else {
        player _enableWeapon();
      }
      player unlink();

      return isReallyAlive(player);
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  }

  return false;
}

personalUseBar(object) {
  self endon("disconnect");

  useBar = undefined;
  if(!isDefined(object.noUseBar) || !object.noUseBar) {
    useBar = createPrimaryProgressBar();
  }

  useBarText = undefined;
  if(isDefined(useBar) && isDefined(object.useText)) {
    useBarText = createPrimaryProgressBarText();
    useBarText setText(object.useText);
  }

  lastRate = -1;
  lastHostMigrationState = isDefined(level.hostMigrationTimer);
  while(isReallyAlive(self) && object.inUse && !level.gameEnded) {
    if(lastRate != object.useRate || lastHostMigrationState != isDefined(level.hostMigrationTimer)) {
      if(object.curProgress > object.useTime) {
        object.curProgress = object.useTime;
      }

      progress = object.curProgress / object.useTime;
      rate = (1000 / object.useTime) * object.useRate;
      if(isDefined(level.hostMigrationTimer)) {
        rate = 0;
      }

      if(isDefined(useBar)) {
        useBar updateBar(progress, rate);

        if(!object.useRate) {
          useBar hideElem();
          if(isDefined(useBarText)) {
            useBarText hideElem();
          }
        } else {
          useBar showElem();
          if(isDefined(useBarText)) {
            useBarText showElem();
          }
        }
      }
    }
    lastRate = object.useRate;
    lastHostMigrationState = isDefined(level.hostMigrationTimer);
    updateUIProgress(object, true);
    wait(0.05);
  }

  updateUIProgress(object, false);
  if(isDefined(useBar)) {
    useBar destroyElem();
  }
  if(isDefined(useBarText)) {
    useBarText destroyElem();
  }
}

updateTrigger() {
  if(self.triggerType != "use") {
    return;
  }

  if(self.interactTeam == "none") {
    self.trigger.origin -= (0, 0, 50000);
  } else if(self.interactTeam == "any") {
    self.trigger.origin = self.curOrigin;
    self.trigger setTeamForTrigger("none");
  } else if(self.interactTeam == "friendly") {
    self.trigger.origin = self.curOrigin;
    if(self.ownerTeam == "allies") {
      self.trigger setTeamForTrigger("allies");
    } else if(self.ownerTeam == "axis") {
      self.trigger setTeamForTrigger("axis");
    } else {
      self.trigger.origin -= (0, 0, 50000);
    }
  } else if(self.interactTeam == "enemy") {
    self.trigger.origin = self.curOrigin;
    if(self.ownerTeam == "allies") {
      self.trigger setTeamForTrigger("axis");
    } else if(self.ownerTeam == "axis") {
      self.trigger setTeamForTrigger("allies");
    } else {
      self.trigger setTeamForTrigger("none");
    }
  }
}

updateWorldIcons() {
  if(self.visibleTeam == "any") {
    updateWorldIcon("friendly", true);
    updateWorldIcon("enemy", true);
  } else if(self.visibleTeam == "friendly") {
    updateWorldIcon("friendly", true);
    updateWorldIcon("enemy", false);
  } else if(self.visibleTeam == "enemy") {
    updateWorldIcon("friendly", false);
    updateWorldIcon("enemy", true);
  } else {
    updateWorldIcon("friendly", false);
    updateWorldIcon("enemy", false);
  }

  updateWorldIcon("mlg", true);
}

updateWorldIcon(relativeTeam, showIcon) {
  if(!isDefined(self.worldIcons[relativeTeam])) {
    showIcon = false;
  }

  updateTeams = getUpdateTeams(relativeTeam);

  for(index = 0; index < updateTeams.size; index++) {
    opName = "objpoint_" + updateTeams[index] + "_" + self.entNum;
    objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);

    objPoint notify("stop_flashing_thread");
    objPoint thread maps\mp\gametypes\_objpoints::stopFlashing();

    if(showIcon) {
      objPoint setShader(self.worldIcons[relativeTeam], level.objPointSize, level.objPointSize);
      objPoint fadeOverTime(0.05);
      objPoint.alpha = objPoint.baseAlpha;
      objPoint.isShown = true;

      if(isDefined(self.compassIcons[relativeTeam])) {
        objPoint setWayPoint(true, true);
      } else {
        objPoint setWayPoint(true, false);
      }

      if(self.type == "carryObject") {
        if(isDefined(self.carrier) && !shouldPingObject(relativeTeam)) {
          objPoint SetTargetEnt(self.carrier);
        } else if(!isDefined(self.carrier) && isDefined(self.objectiveOnVisuals) && self.objectiveOnVisuals) {
          objPoint SetTargetEnt(self.visuals[0]);
        } else {
          objPoint ClearTargetEnt();
        }
      }
    } else {
      objPoint fadeOverTime(0.05);
      objPoint.alpha = 0;
      objPoint.isShown = false;
      objPoint ClearTargetEnt();
    }

    objPoint thread hideWorldIconOnGameEnd();
  }
}

hideWorldIconOnGameEnd() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");

  level waittill("game_ended");

  if(isDefined(self)) {
    self.alpha = 0;
  }
}

updateTimer(seconds, showIcon) {}

updateCompassIcons() {
  if(self.visibleTeam == "any") {
    updateCompassIcon("friendly", true);
    updateCompassIcon("enemy", true);
  } else if(self.visibleTeam == "friendly") {
    updateCompassIcon("friendly", true);
    updateCompassIcon("enemy", false);
  } else if(self.visibleTeam == "enemy") {
    updateCompassIcon("friendly", false);
    updateCompassIcon("enemy", true);
  } else {
    updateCompassIcon("friendly", false);
    updateCompassIcon("enemy", false);
  }

  updateCompassIcon("mlg", true);
}

updateCompassIcon(relativeTeam, showIcon) {
  if(!isDefined(self.compassIcons)) {
    return;
  }

  updateTeams = getUpdateTeams(relativeTeam);

  for(index = 0; index < updateTeams.size; index++) {
    showIconThisTeam = showIcon;
    if(!showIconThisTeam && shouldShowCompassDueToRadar(updateTeams[index])) {
      showIconThisTeam = true;
    }

    objId = self.objIDAllies;
    if(updateTeams[index] == "axis") {
      objId = self.objIDAxis;
    }
    if(updateTeams[index] == "mlg") {
      objId = self.objIDMLGSpectator;
    }

    if(!isDefined(self.compassIcons[relativeTeam]) || !showIconThisTeam) {
      objective_state(objId, "invisible");
      continue;
    }

    objective_icon(objId, self.compassIcons[relativeTeam]);
    objective_state(objId, "active");

    if(self.type == "carryObject") {
      if(isReallyAlive(self.carrier) && !shouldPingObject(relativeTeam)) {
        objective_onentity(objId, self.carrier);
      } else if(isDefined(self.objectiveOnVisuals) && self.objectiveOnVisuals) {
        objective_onentity(objId, self.visuals[0]);
      } else {
        objective_position(objId, self.curOrigin);
      }
    }
  }
}

shouldPingObject(relativeTeam) {
  if(relativeTeam == "friendly" && self.objIDPingFriendly) {
    return true;
  } else if(relativeTeam == "enemy" && self.objIDPingEnemy) {
    return true;
  }

  return false;
}

getUpdateTeams(relativeTeam) {
  updateTeams = [];
  if(relativeTeam == "friendly") {
    if(self isFriendlyTeam("allies")) {
      updateTeams[updateTeams.size] = "allies";
    }

    if(self isFriendlyTeam("axis")) {
      updateTeams[updateTeams.size] = "axis";
    }
  } else if(relativeTeam == "enemy") {
    if(!self isFriendlyTeam("allies")) {
      updateTeams[updateTeams.size] = "allies";
    }

    if(!self isFriendlyTeam("axis")) {
      updateTeams[updateTeams.size] = "axis";
    }
  } else if(relativeTeam == "mlg") {
    updateTeams[updateTeams.size] = "mlg";
  }

  return updateTeams;
}

shouldShowCompassDueToRadar(team) {
  if(team == "mlg") {
    return false;
  }

  if(!isDefined(self.carrier)) {
    return false;
  }

  if(self.carrier _hasPerk("specialty_radarimmune")) {
    return false;
  }

  return getTeamRadar(team);
}

updateVisibilityAccordingToRadar() {
  self endon("death");
  self endon("carrier_cleared");

  while(1) {
    level waittill("radar_status_change");
    self updateCompassIcons();
  }
}

setOwnerTeam(team) {
  self.ownerTeam = team;
  self updateTrigger();
  self updateCompassIcons();
  self updateWorldIcons();
}

getOwnerTeam() {
  return self.ownerTeam;
}

setUseTime(time) {
  self.useTime = int(time * 1000);
}

setUseText(text) {
  self.useText = text;
}

setTeamUseTime(relativeTeam, time) {
  self.teamUseTimes[relativeTeam] = int(time * 1000);
}

setTeamUseText(relativeTeam, text) {
  self.teamUseTexts[relativeTeam] = text;
}

setUseHintText(text) {
  self.trigger setHintString(text);
}

allowCarry(relativeTeam) {
  self.interactTeam = relativeTeam;
}

allowUse(relativeTeam) {
  self.interactTeam = relativeTeam;
  updateTrigger();
}

setVisibleTeam(relativeTeam) {
  self.visibleTeam = relativeTeam;

  updateCompassIcons();
  updateWorldIcons();
}

setModelVisibility(visibility) {
  if(visibility) {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] show();
      if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
        foreach(player in level.players) {
          if(player isTouching(self.visuals[index])) {
            player _suicide();
          }
        }
        self.visuals[index] thread makeSolid();
      }
    }
  } else {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] hide();
      if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
        self.visuals[index] notify("changing_solidness");
        self.visuals[index] notsolid();
      }
    }
  }
}

makeSolid() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  while(1) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] isTouching(self)) {
        break;
      }
    }
    if(i == level.players.size) {
      self solid();
      break;
    }
    wait .05;
  }
}

setCarrierVisible(relativeTeam) {
  self.carrierVisible = relativeTeam;
}

setCanUse(relativeTeam) {
  self.useTeam = relativeTeam;
}

set2DIcon(relativeTeam, shader) {
  self.compassIcons[relativeTeam] = shader;
  updateCompassIcons();
}

set3DIcon(relativeTeam, shader) {
  self.worldIcons[relativeTeam] = shader;
  updateWorldIcons();
}

set3DUseIcon(relativeTeam, shader) {
  self.worldUseIcons[relativeTeam] = shader;
}

setCarryIcon(shader) {
  self.carryIcon = shader;
}

disableObject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier)) {
      self.carrier takeObject(self);
    }

    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] hide();
    }
  }

  self.trigger common_scripts\utility::trigger_off();
  self setVisibleTeam("none");
}

enableObject() {
  if(self.type == "carryObject") {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] show();
    }
  }

  self.trigger common_scripts\utility::trigger_on();
  self setVisibleTeam("any");
}

getRelativeTeam(team) {
  if(team == self.ownerTeam) {
    return "friendly";
  } else {
    return "enemy";
  }
}

isFriendlyTeam(team) {
  claimTeam = getClaimTeam();

  if((self.ownerTeam == "neutral") && (claimTeam != "none") && (claimTeam != team)) {
    return true;
  }

  if(self.ownerTeam == "any") {
    return true;
  }

  if(self.ownerTeam == team) {
    return true;
  }

  return false;
}

canInteractWith(team, player) {
  switch (self.interactTeam) {
    case "none":
      return false;

    case "any":
      return true;

    case "friendly":
      if(team == self.ownerTeam) {
        return true;
      } else {
        return false;
      }

    case "enemy":
      if(team != self.ownerTeam) {
        return true;
      } else {
        return false;
      }

    default:
      assertEx(0, "invalid interactTeam");
      return false;
  }
}

isTeam(team) {
  if(team == "neutral") {
    return true;
  }
  if(team == "allies") {
    return true;
  }
  if(team == "axis") {
    return true;
  }
  if(team == "any") {
    return true;
  }
  if(team == "none") {
    return true;
  }

  foreach(teamname in level.teamnamelist) {
    if(team == teamname) {
      return true;
    }
  }

  return false;
}

isRelativeTeam(relativeTeam) {
  if(relativeTeam == "friendly") {
    return true;
  }
  if(relativeTeam == "enemy") {
    return true;
  }
  if(relativeTeam == "any") {
    return true;
  }
  if(relativeTeam == "none") {
    return true;
  }

  return false;
}

getEnemyTeam(team) {
  if(level.multiteambased) {
    assert("getEnemyTeam should not be called in multiteam settings");
  }

  if(team == "neutral") {
    return "none";
  } else if(team == "allies") {
    return "axis";
  } else {
    return "allies";
  }
}

getNextObjID() {
  if(!isDefined(level.reclaimedReservedObjectives) || level.reclaimedReservedObjectives.size < 1) {
    nextID = level.numGametypeReservedObjectives;
    level.numGametypeReservedObjectives++;
  } else {
    nextId = level.reclaimedReservedObjectives[level.reclaimedReservedObjectives.size - 1];
    level.reclaimedReservedObjectives[level.reclaimedReservedObjectives.size - 1] = undefined;
  }

  if(nextId > 31) {
    AssertMsg("Surpassed Total Minimap objIDs");
    nextId = 31;
  }

  return nextID;
}

getLabel() {
  label = self.trigger.script_label;
  if(!isDefined(label)) {
    label = "";
    return label;
  }

  if(label[0] != "_") {
    return ("_" + label);
  }

  return label;
}

initializeTagPathVariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = false;
  self.on_path_grid = undefined;
}

mustMaintainClaim(enabled) {
  self.mustMaintainClaim = enabled;
}

canContestClaim(enabled) {
  self.canContestClaim = enabled;
}

fake_loot_dispensation_logic() {
  self endon("disconnect");
  level endon("game_ended");

  time = 120;
  randomTime = RandomIntRange(30, 90);
  time += randomTime;

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(time);

  self waittill("show_loot_notification");
}