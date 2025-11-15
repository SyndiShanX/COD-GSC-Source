/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_gas_airstrike.gsc
**************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

KS_NAME = "gas_airstrike";

init() {
  precacheLocationSelector("map_artillery_selector");

  config = spawnStruct();
  config.modelNames = [];
  config.modelNames["allies"] = "vehicle_mig29_desert";
  config.modelNames["axis"] = "vehicle_mig29_desert";
  config.inboundSfx = "veh_mig29_dist_loop";

  config.compassIconFriendly = "compass_objpoint_airstrike_friendly";
  config.compassIconEnemy = "compass_objpoint_airstrike_busy";

  config.speed = 5000;
  config.halfDistance = 15000;
  config.heightRange = 500;

  config.outboundFlightAnim = "airstrike_mp_roll";
  config.onAttackDelegate = ::dropBombs;
  config.onFlybyCompleteDelegate = ::cleanupFlyby;
  config.chooseDirection = true;
  config.selectLocationVO = "KS_hqr_airstrike";
  config.inboundVO = "KS_ast_inbound";
  config.bombModel = "projectile_cbu97_clusterbomb";
  config.numBombs = 3;

  config.distanceBetweenBombs = 350;
  config.effectRadius = 200;
  config.effectHeight = 120;

  config.effectVFX = LoadFX("fx/smoke/poisonous_gas_linger_medium_thick_killer_instant");
  config.effectMinDelay = 0.25;
  config.effectMaxDelay = 0.5;
  config.effectLifeSpan = 13;
  config.effectCheckFrequency = 1.0;
  config.effectDamage = 10;
  config.obitWeapon = "gas_strike_mp";
  config.killCamOffset = (0, 0, 60);

  level.planeConfigs[KS_NAME] = config;

  level.killstreakFuncs[KS_NAME] = ::onUse;
}

onUse(lifeId, streakName) {
  assert(isDefined(self));

  otherTeam = getOtherTeam(self.team);

  if(isDefined(level.numGasStrikeActive)) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else {
    result = maps\mp\killstreaks\_plane::selectAirstrikeLocation(lifeId, KS_NAME, ::doStrike);

    return (isDefined(result) && result);
  }
}

doStrike(lifeId, location, directionYaw, streakName) {
  level.numGasStrikeActive = 0;

  wait(1);

  planeFlyHeight = maps\mp\killstreaks\_plane::getPlaneFlyHeight();

  dirVector = anglesToForward((0, directionYaw, 0));

  doOneFlyby(streakName, lifeId, location, dirVector, planeFlyHeight);

  self waittill("gas_airstrike_flyby_complete");
}

doOneFlyby(streakName, lifeId, targetPos, dir, flyHeight) {
  config = level.planeConfigs[streakName];

  flightPath = maps\mp\killstreaks\_plane::getFlightPath(targetPos, dir, config.halfDistance, true, flyHeight, config.speed, 0, streakName);

  level thread maps\mp\killstreaks\_plane::doFlyby(lifeId, self, lifeId,
    flightPath["startPoint"] + (0, 0, randomInt(config.heightRange)),
    flightPath["endPoint"] + (0, 0, randomInt(config.heightRange)),
    flightPath["attackTime"],
    flightPath["flyTime"],
    dir,
    streakName);
}

cleanupFlyby(owner, plane, streakName) {
  owner notify("gas_airstrike_flyby_complete");
}

dropBombs(pathEnd, flyTime, beginAttackTime, owner, streakName) {
  self endon("death");

  wait(beginAttackTime);

  config = level.planeConfigs[streakName];

  numBombsLeft = config.numBombs;
  timeBetweenBombs = config.distanceBetweenBombs / config.speed;

  while(numBombsLeft > 0) {
    self thread dropOneBomb(owner, streakName);

    numBombsLeft--;
    wait(timeBetweenBombs);
  }

}

dropOneBomb(owner, streakName) {
  level.numGasStrikeActive++;

  plane = self;

  config = level.planeConfigs[streakName];

  planeDir = anglesToForward(plane.angles);

  bomb = spawnBomb(config.bombModel, plane.origin, plane.angles);
  bomb MoveGravity((planeDir * (config.speed / 1.5)), 3.0);

  newBomb = spawn("script_model", bomb.origin);
  newBomb setModel("tag_origin");
  newBomb.origin = bomb.origin;
  newBomb.angles = bomb.angles;

  bomb setModel("tag_origin");
  wait(0.10);

  bombOrigin = newBomb.origin;
  bombAngles = newBomb.angles;
  if(level.splitscreen) {
    playFXOnTag(level.airstrikessfx, newBomb, "tag_origin");
  } else {
    playFXOnTag(level.airstrikefx, newBomb, "tag_origin");
  }

  wait(1.0);

  trace = bulletTrace(newBomb.origin, newBomb.origin + (0, 0, -1000000), false, undefined);
  impactPosition = trace["position"];

  bomb onBombImpact(owner, impactPosition, streakName);

  newBomb delete();
  bomb delete();

  level.numGasStrikeActive--;
  if(level.numGasStrikeActive == 0) {
    level.numGasStrikeActive = undefined;
  }
}

spawnBomb(modelName, origin, angles) {
  bomb = spawn("script_model", origin);
  bomb.angles = angles;
  bomb setModel(modelname);

  return bomb;
}

onBombImpact(owner, position, streakName) {
  config = level.planeConfigs[streakName];

  effectArea = spawn("trigger_radius", position, 0, config.effectRadius, config.effectHeight);
  effectArea.owner = owner;

  effectRadius = config.effectRadius;
  vfx = SpawnFx(config.effectVFX, position);
  TriggerFX(vfx);

  wait(RandomFloatRange(config.effectMinDelay, config.effectMaxDelay));

  timeRemaining = config.effectLifeSpan;

  killCamEnt = spawn("script_model", position + config.killCamOffset);
  killCamEnt LinkTo(effectArea);
  self.killCamEnt = killCamEnt;

  while(timeRemaining > 0.0) {
    foreach(character in level.characters) {
      character applyGasEffect(owner, position, effectArea, self, config.effectDamage);
    }

    wait(config.effectCheckFrequency);
    timeRemaining -= config.effectCheckFrequency;
  }

  self.killCamEnt Delete();

  effectArea Delete();
  vfx Delete();
}

applyGasEffect(attacker, position, trigger, inflictor, damage) {
  if((attacker isEnemy(self)) && IsAlive(self) && self IsTouching(trigger)) {
    inflictor RadiusDamage(self.origin, 1, damage, damage, attacker, "MOD_RIFLE_BULLET", "gas_strike_mp");

    if(!(self isUsingRemote())) {
      duration = maps\mp\perks\_perkfunctions::applyStunResistence(2.0);
      self ShellShock("default", duration);
    }
  }
}