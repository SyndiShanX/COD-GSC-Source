/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_mrsiartillery.gsc
**************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

KILLSTREAK_NAME = "mrsiartillery";

init() {
  level.killstreakFuncs[KILLSTREAK_NAME] = ::tryUseStrike;

  configData = spawnStruct();
  configData.weaponName = "airdrop_marker_mp";
  configData.projectileName = "mrsiartillery_projectile_mp";

  configData.numStrikes = 6;
  configData.initialDelay = 1.0;
  configData.minFireDelay = 0.375;
  configdata.maxFireDelay = 0.5;
  configData.strikeRadius = 150;

  if(!isDefined(level.killstreakConfigData)) {
    level.killstreakConfigData = [];
  }
  level.killstreakConfigData[KILLSTREAK_NAME] = configData;
}

tryUseStrike(lifeId, streakName) {
  configData = level.killStreakConfigData[KILLSTREAK_NAME];
  result = self maps\mp\killstreaks\_designator_grenade::designator_Start(KILLSTREAK_NAME, configData.weaponName, ::onTargetAcquired);

  if((!isDefined(result) || !result)) {
    return false;
  } else {
    return true;
  }
}

onTargetAcquired(killstreakName, designatorEnt) {
  configData = level.killStreakConfigData[killstreakName];

  owner = designatorEnt.owner;
  endPos = designatorEnt.origin;

  designatorEnt Detonate();

  doStrike(owner, killstreakName, owner.origin, endPos);
}

doStrike(owner, killstreakName, startPosition, endPosition) {
  configData = level.killStreakConfigData[killstreakName];

  dir = endPosition - startPosition;
  xyDir = (dir[0], dir[1], 0);
  dir = VectorNormalize(dir);

  strikeTarget = endPosition;

  strikeOrigin = maps\mp\killstreaks\_killstreaks::findUnobstructedFiringPoint(owner, endPosition + (0, 0, 10), 10000);

  if(isDefined(strikeOrigin)) {
    IPrintLn("Firing Motar!");

    wait(configData.initialDelay);

    wait(RandomFloatRange(configData.minFireDelay, configData.maxFireDelay));
    projectile = MagicBullet(configData.projectileName, strikeOrigin, strikeTarget, owner);

    for(i = 1; i < configData.numStrikes; i++) {
      wait(RandomFloatRange(configData.minFireDelay, configData.maxFireDelay));

      randomTarget = pickRandomTargetPoint(strikeTarget, configData.strikeRadius);

      projectile = MagicBullet(configData.projectileName, strikeOrigin, randomTarget, owner);
    }
  } else {
    IPrintLn("Mortar LOS blocked!");
  }
}

pickRandomTargetPoint(targetPoint, strikeRadius) {
  x = RandomFloatRange(-1 * strikeRadius, strikeRadius);
  y = RandomFloatRange(-1 * strikeRadius, strikeRadius);
  return targetPoint + (x, y, 0);
}