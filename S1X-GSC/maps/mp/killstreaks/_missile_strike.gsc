/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_missile_strike.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

CONST_MISSILE_HEALTH = 10;
CONST_HOSTILE = "hud_fofbox_hostile";
CONST_HOSTIL_LOCK = "hud_fofbox_hostile_ms_target";
CONST_SELF = "hud_fofbox_self";

init() {
  setDvar("missileRemoteSteerPitchRange", "60 87");

  level._missile_strike_setting = [];

  level._missile_strike_setting["Particle_FX"] = spawnStruct();
  level._missile_strike_setting["Particle_FX"].Gas = LoadFX("vfx/unique/vfx_killstreak_missilestrike_dna");
  level._missile_strike_setting["Particle_FX"].GasFriendly = LoadFX("vfx/unique/vfx_killstreak_missilestrike_dna_friendly");

  level._missile_strike_setting["Audio"] = spawnStruct();

  level._missile_strike_setting["Launch_Value"] = spawnStruct();
  mapname = getDvar("mapname");
  if(mapname == "mp_suburbia") {
    level._missile_strike_setting["Launch_Value"].Vert = 7000;
    level._missile_strike_setting["Launch_Value"].Horz = 10000;
    level._missile_strike_setting["Launch_Value"].TargetDest = 2000;
  } else if(mapname == "mp_mainstreet") {
    level._missile_strike_setting["Launch_Value"].Vert = 7000;
    level._missile_strike_setting["Launch_Value"].Horz = 10000;
    level._missile_strike_setting["Launch_Value"].TargetDest = 2000;
  } else {
    level._missile_strike_setting["Launch_Value"].Vert = 24000;
    level._missile_strike_setting["Launch_Value"].Horz = 7000;
    level._missile_strike_setting["Launch_Value"].TargetDest = 1500;
  }

  level.rockets = [];
  level.missile_strike_gas_clouds = [];

  level.killstreakFuncs["missile_strike"] = ::tryUseMissileStrike;

  level.killstreakWieldWeapons["remotemissile_projectile_mp"] = "missile_strike";
  level.killstreakWieldWeapons["remotemissile_projectile_gas_mp"] = "missile_strike";
  level.killstreakWieldWeapons["remotemissile_projectile_cluster_parent_mp"] = "missile_strike";
  level.killstreakWieldWeapons["remotemissile_projectile_cluster_child_mp"] = "missile_strike";
  level.killstreakWieldWeapons["remotemissile_projectile_cluster_child_hellfire_mp"] = "missile_strike";
  level.killstreakWieldWeapons["remotemissile_projectile_secondary_mp"] = "missile_strike";
  level.killstreakWieldWeapons["killstreak_strike_missile_gas_mp"] = "missile_strike";

  level.remotemissile_fx["explode"] = LoadFX("vfx/explosion/rocket_explosion_airburst");

  thread OnPlayerConnect();
}

tryUseMissileStrike(lifeId, modules) {
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("missile_strike");
  if(result != "success") {
    return false;
  }

  self playerSaveAngles();

  self setUsingRemote("missile_strike");
  MissileWeapon = self BuildWeaponSettings(modules);

  if(isDefined(level.isHorde) && level.isHorde) {
    self.missileWeapon = MissileWeapon;

    if(self.killstreakIndexWeapon == 1) {
      self notify("used_horde_missile_strike");
    }
  }

  level thread _fire(lifeId, self, MissileWeapon);

  return true;
}

BuildWeaponSettings(modules) {
  weapon = spawnStruct();

  weapon.modules = modules;

  weapon.name = "remotemissile_projectile_mp";
  weapon.gasMissile = false;
  weapon.clusterMissile = false;
  weapon.clusterHellfire = false;
  weapon.clusterSpiral = false;

  if(array_contains(weapon.modules, "missile_strike_hellfire")) {
    weapon.name = "remotemissile_projectile_cluster_parent_mp";
    weapon.clusterMissile = true;
    weapon.clusterHellfire = true;
  }
  if(array_contains(weapon.modules, "missile_strike_cluster")) {
    weapon.name = "remotemissile_projectile_cluster_parent_mp";
    weapon.clusterMissile = true;
    weapon.clusterSpiral = true;
    thread preSpawnClusterRotationEntities(weapon);
  } else if(array_contains(weapon.modules, "missile_strike_chem")) {
    weapon.name = "remotemissile_projectile_gas_mp";
    weapon.gasMissile = true;
  }

  weapon.RocketAmmo = 1;
  if(array_contains(weapon.modules, "missile_strike_extra_1")) {
    weapon.RocketAmmo++;
  }
  if(array_contains(weapon.modules, "missile_strike_extra_2")) {
    weapon.RocketAmmo++;
  }

  return weapon;
}

preSpawnClusterRotationEntities(MissileWeapon) {
  prespawnOrigin = (0, 0, -1000);

  MissileWeapon.preSpawnedKillcamEnt = spawn("script_model", prespawnOrigin);
  MissileWeapon.preSpawnedKillcamEnt SetContents(0);
  MissileWeapon.preSpawnedKillcamEnt SetScriptMoverKillCam("large explosive");
  waitframe();
  MissileWeapon.preSpawnedRotationEnts = [];
  MissileWeapon.preSpawnedIndex = 0;
  for(i = 0; i < 12; i++) {
    ent = spawn("script_origin", prespawnOrigin);
    MissileWeapon.preSpawnedRotationEnts[MissileWeapon.preSpawnedRotationEnts.size] = ent;
    waitframe();
  }
}

OnPlayerConnect() {
  while(true) {
    level waittill("connected", player);
    player thread WaitingForSpawnDuringStreak();
  }
}

WaitingForSpawnDuringStreak() {
  self waittill("spawned_player");
  self.MissileStrikeGasTime = 0;
  self thread CreateGasTrackingOverlay();
  self thread WaitForGasDamage();
}

getBestSpawnPoint(remoteMissileSpawnPoints) {
  validEnemies = [];

  foreach(spawnPoint in remoteMissileSpawnPoints) {
    spawnPoint.validPlayers = [];
    spawnPoint.spawnScore = 0;
  }

  foreach(player in level.players) {
    if(!isReallyAlive(player)) {
      continue;
    }

    if(player.team == self.team) {
      continue;
    }

    if(player.team == "spectator") {
      continue;
    }

    bestDistance = 999999999;
    bestSpawnPoint = undefined;

    foreach(spawnPoint in remoteMissileSpawnPoints) {
      spawnPoint.validPlayers[spawnPoint.validPlayers.size] = player;

      potentialBestDistance = Distance2D(spawnPoint.targetent.origin, player.origin);

      if(potentialBestDistance <= bestDistance) {
        bestDistance = potentialBestDistance;
        bestSpawnpoint = spawnPoint;
      }
    }

    assertEx(isDefined(bestSpawnPoint), "Closest remote-missile spawnpoint undefined for player: " + player.name);
    bestSpawnPoint.spawnScore += 2;
  }

  bestSpawn = remoteMissileSpawnPoints[0];
  foreach(spawnPoint in remoteMissileSpawnPoints) {
    foreach(player in spawnPoint.validPlayers) {
      spawnPoint.spawnScore += 1;

      if(bulletTracePassed(player.origin + (0, 0, 32), spawnPoint.origin, false, player)) {
        spawnPoint.spawnScore += 3;
      }

      if(spawnPoint.spawnScore > bestSpawn.spawnScore) {
        bestSpawn = spawnPoint;
      } else if(spawnPoint.spawnScore == bestSpawn.spawnScore) {
        if(coinToss()) {
          bestSpawn = spawnPoint;
        }
      }
    }
  }

  return (bestSpawn);
}

_fire(lifeId, player, MissileWeapon) {
  missileType = MissileWeapon.name;

  player playerAddNotifyCommands();

  rocket = fireOrbitalMissile(player, missileType);

  if(isDefined(level.isHorde) && level.isHorde) {
    player.rocket = rocket;
  }

  MissileWeapon.RocketAmmo--;
  if(MissileWeapon.RocketAmmo > 0 || MissileWeapon.clusterMissile) {
    rocket DisableMissileBoosting();
  }

  rocket.owner = player;
  rocket.team = player.team;
  rocket.lifeId = lifeId;
  rocket.type = "remote";
  level.remoteMissileInProgress = true;

  rocket thread maps\mp\gametypes\_damage::setEntityDamageCallback(CONST_MISSILE_HEALTH, undefined, ::missileStrikeOnDeath, undefined, true);

  if(isDefined(level.ishorde) && level.ishorde) {
    rocket thread rocketImpact_droneKillCheck(player);
  }

  rocket SetMissileMinimapVisible(true);
  rocket PlaySoundToTeam("mstrike_entry_npc", getOtherTeam(rocket.team));
  rocket PlaySoundToTeam("mstrike_entry_npc", rocket.team, player);

  MissileEyes(player, rocket, MissileWeapon);
}

rocketImpact_droneKillCheck(player) {
  self waittill("death");

  if(isDefined(level.flying_attack_drones)) {
    foreach(drone in level.flying_attack_drones) {
      if(drone.origin[2] > (self.origin[2]) && drone.origin[2] < (self.origin[2] + 1200) && Distance2DSquared(drone.origin, self.origin) < (40000)) {
        drone DoDamage(350, self.origin, player, player, "MOD_PROJECTILE_SPLASH", "remotemissile_projectile_mp");
      }
    }
  }
}
missileStrikeOnDeath(attacker, weapon, meansOfDeath, damage) {
  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(self.owner)) {
      self.owner.missileWeapon = undefined;
      self.owner.rocket = undefined;
    }
  }

  playFX(level.remotemissile_fx["explode"], self.origin);

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "missile_strike_destroyed", undefined, undefined, false);

  self delete();
}

fireOrbitalMissile(player, missileType) {
  remoteMissileSpawnArray = maps\mp\killstreaks\_aerial_utility::getEntOrStructArray("remoteMissileSpawn", "targetname");

  foreach(spawn in remoteMissileSpawnArray) {
    if(isDefined(spawn.target)) {
      spawn.targetEnt = getEnt(spawn.target, "targetname");
    }
  }

  if(remoteMissileSpawnArray.size > 0) {
    remoteMissileSpawn = player getBestSpawnPoint(remoteMissileSpawnArray);
  } else {
    remoteMissileSpawn = undefined;
  }

  startPos = undefined;
  targetPos = undefined;
  if(isDefined(remoteMissileSpawn)) {
    startPos = remoteMissileSpawn.origin;
    targetPos = remoteMissileSpawn.targetEnt.origin;
    backDist = 24000;
    if(isDefined(level.remote_missile_height_override)) {
      backDist = level.remote_missile_height_override;
    }

    vector = vectorNormalize(startPos - targetPos);
    startPos = (vector * backDist) + targetPos;
  } else {
    upVector = (0, 0, level._missile_strike_setting["Launch_Value"].Vert);
    backDist = level._missile_strike_setting["Launch_Value"].Horz;
    targetDist = level._missile_strike_setting["Launch_Value"].TargetDest;

    forward = anglesToForward(player.angles);
    startpos = player.origin + upVector + forward * backDist * -1;
    targetPos = player.origin + forward * targetDist;
  }

  return MagicBullet(missileType, startpos, targetPos, player);
}

MissileEyes(player, rocket, MissileWeapon) {
  player endon("joined_team");
  player endon("joined_spectators");
  MissileWeapon endon("missile_strike_complete");
  player endon("disconnect");

  rocket thread Rocket_CleanupOnDeath();
  player thread Player_CleanupOnGameEnded(rocket, MissileWeapon);
  player thread Player_CleanupOnTeamChange(rocket, MissileWeapon);

  player.ClusterDeployed = false;
  player.MissileBoostUsed = false;

  player CameraLinkTo(rocket, "tag_origin");
  player ControlsLinkTo(rocket);

  if(getDvarInt("camera_thirdPerson")) {
    player setThirdPersonDOF(false);
  }

  player thread init_hud(rocket, MissileWeapon);

  player thread playerWaitReset(MissileWeapon);

  if(MissileWeapon.clusterMissile) {
    player thread WatchForClusterSplit(rocket, MissileWeapon);
  }

  if(MissileWeapon.RocketAmmo <= 0 && !MissileWeapon.clusterMissile) {
    rocket EnableMissileBoosting();
    player thread hud_watch_for_boost_active(rocket, MissileWeapon);
  } else {
    player thread WatchForExtraMissileFire(rocket, MissileWeapon);
  }

  player thread playerWatchForEarlyExit(MissileWeapon);

  rocket waittill("death");

  if(MissileWeapon.gasMissile) {
    if(isDefined(rocket)) {
      player thread ReleaseGas(rocket.origin);
    }
  }

  if(isDefined(rocket)) {
    player maps\mp\_matchdata::logKillstreakEvent("missile_strike", rocket.origin);
  }

  MissileWeapon notify("missile_strike_complete");
}

playerWatchForEarlyExit(MissileWeapon) {
  level endon("game_ended");
  MissileWeapon endon("missile_strike_complete");
  self endon("disconnect");

  while(true) {
    useHold = 0;
    while(self useButtonPressed()) {
      useHold += 0.05;
      if(useHold > 0.5) {
        MissileWeapon notify("ms_early_exit");
        return;
      }
      waitframe();
    }

    waitframe();
  }
}

playerWaitReset(MissileWeapon) {
  MissileWeapon waittill_either("missile_strike_complete", "ms_early_exit");

  self playerReset();
}

playerReset() {
  self endon("disconnect");

  self ControlsUnlink();
  self freezeControlsWrapper(true);
  self playerRemoveNotifyCommands();

  self stopMissileBoostSounds();

  if(!level.gameEnded || isDefined(self.finalKill)) {
    self maps\mp\killstreaks\_aerial_utility::playerShowFullStatic();
  }

  wait(0.5);
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  self remove_hud();

  self CameraUnlink();

  self freezeControlsWrapper(false);

  if(self isUsingRemote()) {
    self clearUsingRemote();
  }

  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(true);
  }

  self playerRestoreAngles();
}

stopMissileBoostSounds() {
  self StopLocalSound("mstrike_boost_shot");
  self StopLocalSound("mstrike_boost_boom");
  self StopLocalSound("mstrike_boost_swoop");
  self StopLocalSound("mstrike_boost_jet");
  self StopLocalSound("mstrike_boost_roar");
}

WatchForExtraMissileFire(MasterRocket, MissileWeapon) {
  MasterRocket endon("death");

  wait(0.5);

  while(true) {
    self waittill("FireButtonPressed");

    if(MissileWeapon.RocketAmmo > 0) {
      self thread FireBabyMissile(MasterRocket, MissileWeapon);
    } else {
      break;
    }

    wait(0.1);
  }
}

EnableBoost(MasterRocket) {
  wait(0.5);
  MasterRocket EnableMissileBoosting();
}

FireBabyMissile(MasterRocket, MissileWeapon) {
  MissileType = MissileWeapon.name;

  offset = (0, 32, 0);
  EvenOrOdd = MissileWeapon.RocketAmmo % 2;
  if(EvenOrOdd == 0) {
    offset = (0, -64, 0);
  }
  BulletTraceTarget = MasterRocket.origin + (anglesToForward(MasterRocket.angles) * 32000);
  TraceArray = bulletTrace(MasterRocket.origin, BulletTraceTarget, false, MasterRocket, false, false, false, true, false);

  startpos = (MasterRocket.origin + offset) + (anglesToForward(MasterRocket.angles) * 750);
  targetPos = TraceArray["position"];

  rocket = MagicBullet("remotemissile_projectile_secondary_mp", startpos, targetPos, self);

  if(!isDefined(rocket)) {
    return;
  }

  MissileWeapon.RocketAmmo--;
  if(MissileWeapon.RocketAmmo <= 0 && !MissileWeapon.clusterMissile) {
    self hud_update_fire_text(rocket, MissileWeapon);
    self thread hud_watch_for_boost_active(MasterRocket, MissileWeapon);
    thread EnableBoost(MasterRocket);
  }

  if(isDefined(MissileType)) {
    if(isDefined(MasterRocket.targets) && MasterRocket.targets.size) {
      rocket Missile_SetTargetEnt(MasterRocket.targets[0]);
    }
  }

  rocket.team = self.team;
  rocket SetMissileMinimapVisible(true);

  self PlayRumbleOnEntity("sniper_fire");
  Earthquake(0.2, 0.2, MasterRocket.origin, 200);

  rocket thread maps\mp\gametypes\_damage::setEntityDamageCallback(CONST_MISSILE_HEALTH, undefined, ::missileStrikeOnDeath, undefined, true);
}

WatchForClusterSplit(rocket, MissileWeapon) {
  MissileWeapon endon("missile_strike_complete");
  self endon("spawned_player");
  rocket endon("death");

  while(MissileWeapon.RocketAmmo > 0) {
    self waittill("FireButtonPressed");
  }

  wait(0.25);

  self waittill("FireButtonPressed");

  self.ClusterDeployed = true;

  self hud_update_fire_text(rocket, MissileWeapon);

  self thread split_rocket(rocket, MissileWeapon);
}

split_rocket(rocket, MissileWeapon) {
  assert(MissileWeapon.clusterMissile);
  if(MissileWeapon.clusterHellfire) {
    self thread split_rocket_hellfire(rocket, MissileWeapon);
  } else {
    assert(MissileWeapon.clusterSpiral);
    self thread split_rocket_spiral(rocket, MissileWeapon);
  }
}

split_rocket_hellfire(rocket, MissileWeapon) {
  waitFrames = 2;

  targets = [];

  if(isDefined(rocket.targets) && rocket.targets.size) {
    targets = rocket.targets;
  }

  self thread fire_straight_bomblet(rocket, 0, MissileWeapon);

  foreach(target in targets) {
    self thread fire_targeted_bomblet(rocket, target, waitFrames, MissileWeapon);
    waitFrames++;
  }

  for(i = targets.size; i <= 8; i++) {
    self thread fire_random_bomblet(rocket, i % 6, waitFrames, MissileWeapon);
    waitFrames++;
  }

  self PlayRumbleOnEntity("sniper_fire");
  Earthquake(0.2, 0.2, rocket.origin, 200);

  rocket SetMissileCoasting(true);

  self thread fade_to_white();

  self thread bomblet_camera_waiter(rocket, MissileWeapon);
}

split_rocket_spiral(rocket, MissileWeapon) {
  MissileWeapon endon("missile_strike_complete");
  self endon("spawned_player");
  rocket endon("death");

  self thread fade_to_white();

  self waittill("full_white");

  self thread freezeControlsWrapper(true);

  if(!isDefined(rocket)) {
    return;
  }

  self.StrikeRocketStoredPosition = rocket.origin;
  self.StrikeRocketStoredAngles = rocket.angles;
  DistanceToScale = Distance(rocket.origin, self.origin) + 10000;

  RocketStoredForwardPosition = rocket.origin + (anglesToForward(rocket.angles) * DistanceToScale);
  ClusterStartPoint = self.StrikeRocketStoredPosition;
  RotationStartPoint = rocket.origin + (anglesToForward(rocket.angles) * 3250);

  rocket SetMissileCoasting(true);

  self thread bomblet_camera_waiter(rocket, MissileWeapon);

  self thread SpawnClusterChildren(RocketStoredForwardPosition, self.StrikeRocketStoredPosition, RotationStartPoint, MissileWeapon);

  self waittill("fade_white_over");

  wait(9);

  self freezeControlsWrapper(false);
}

fire_straight_bomblet(rocket, waitFrames, MissileWeapon) {
  MissileWeapon endon("missile_strike_complete");

  origin = rocket.origin;
  angles = rocket.angles;
  owner = rocket.owner;

  if(waitFrames > 0) {
    wait(waitFrames * 0.05);
  }

  bomblet = MagicBullet("remotemissile_projectile_cluster_child_hellfire_mp", origin, origin + anglesToForward(angles) * 1000, self);
  bomblet.team = self.team;
  bomblet.killCamEnt = self;

  bomblet SetMissileMinimapVisible(true);

  bomblet thread bomblet_explosion_waiter(self, MissileWeapon);
}

fire_targeted_bomblet(rocket, target, waitFrames, MissileWeapon) {
  MissileWeapon endon("missile_strike_complete");

  origin = rocket.origin;
  angles = rocket.angles;
  owner = rocket.owner;
  target_origin = target.origin;

  wait(waitFrames * 0.05);

  if(isDefined(target) && Distance2DSquared(target.origin, target_origin) < (240.0 * 240.0)) {
    target_origin = target.origin;
  }

  bomblet = MagicBullet("remotemissile_projectile_cluster_child_hellfire_mp", origin, target_origin, self);
  bomblet.team = self.team;
  bomblet.killCamEnt = self;

  if(isDefined(target)) {
    bomblet Missile_SetTargetEnt(target);
  }

  bomblet SetMissileMinimapVisible(true);

  bomblet thread bomblet_explosion_waiter(self, MissileWeapon);
}

fire_random_bomblet(rocket, index, waitFrames, MissileWeapon) {
  MissileWeapon endon("missile_strike_complete");

  targeting_radius = 600;

  origin = rocket.origin;
  angles = rocket.angles;
  owner = rocket.owner;
  aimTarget = rocket.aimtarget;

  wait(waitFrames * 0.05);

  angle = RandomIntRange(10 + (60 * index), 50 + (60 * index));
  radius = RandomIntRange(200, targeting_radius + 100);
  x = min(radius, targeting_radius - 50) * Cos(angle);
  y = min(radius, targeting_radius - 50) * Sin(angle);

  bomblet = MagicBullet("remotemissile_projectile_cluster_child_hellfire_mp", origin, aimtarget + (x, y, 0), self);
  bomblet.team = self.team;
  bomblet.killCamEnt = self;

  bomblet SetMissileMinimapVisible(true);

  bomblet thread bomblet_explosion_waiter(self, MissileWeapon);
}

bomblet_explosion_waiter(player, MissileWeapon) {
  player endon("disconnect");
  MissileWeapon endon("ms_early_exit");
  MissileWeapon endon("missile_strike_complete");
  level endon("game_ended");

  self waittill("death");

  MissileWeapon notify("bomblet_exploded");
}

bomblet_camera_waiter(rocket, MissileWeapon) {
  self endon("disconnect");
  MissileWeapon endon("ms_early_exit");
  MissileWeapon endon("missile_strike_complete");
  rocket endon("death");
  level endon("game_ended");

  MissileWeapon waittill("bomblet_exploded");

  wait(1.0);

  self thread bomblet_camera_waiter_complete(rocket, MissileWeapon);
}

bomblet_camera_waiter_complete(rocket, MissileWeapon) {
  rocket notify("death");
  MissileWeapon notify("missile_strike_complete");
}

getPrespawnedClusterRotationEnt(MissileWeapon, newOrigin) {
  while(MissileWeapon.preSpawnedRotationEnts.size < (MissileWeapon.preSpawnedIndex + 1)) {
    waitframe();
  }

  newEnt = MissileWeapon.preSpawnedRotationEnts[MissileWeapon.preSpawnedIndex];
  MissileWeapon.preSpawnedIndex++;
  if(isDefined(newOrigin)) {
    newEnt.origin = newOrigin;
  }
  return newEnt;
}

SpawnClusterChildren(RocketStoredForwardPosition, ClusterStartPoint, RotationStartPoint, MissileWeapon) {
  RandomX = RandomIntRange(16, 64);
  if(RandomInt(100) > 50) {
    RandomX = RandomX * -1;
  }
  RandomY = RandomIntRange(16, 64);
  if(RandomInt(100) > 50) {
    RandomY = RandomY * -1;
  }
  RandomPosition = ClusterStartPoint + (RandomX, RandomY, 0);
  RandomTargetPosition = RotationStartPoint + (RandomX, RandomY, 0);

  RotatingCenterEnt = getPrespawnedClusterRotationEnt(MissileWeapon, RotationStartPoint);
  RotatingCenterEnt.RotatingLinkArray = [];
  RotatingCenterEnt.RotatingLinkArray[0] = getPrespawnedClusterRotationEnt(MissileWeapon, RandomTargetPosition);
  RotatingCenterEnt.RotatingLinkArray[0] LinkToSynchronizedParent(RotatingCenterEnt);

  rocket = MagicBullet("remotemissile_projectile_cluster_child_mp", RandomPosition, RandomTargetPosition, self);
  rocket Missile_SetTargetEnt(RotatingCenterEnt.RotatingLinkArray[0]);
  rocket Missile_SetFlightmodeDirect();
  rocket.owner = self;
  rocket.team = self.team;
  rocket SetMissileMinimapVisible(true);
  rocket thread bomblet_explosion_waiter(self, MissileWeapon);

  view_offset = RandomTargetPosition - RandomPosition;
  view_offset = VectorNormalize((view_offset[0], view_offset[1], 0));
  view_offset *= -30;
  view_offset += (0, 0, 200);

  killcam = MissileWeapon.preSpawnedKillcamEnt;
  killcam.origin = RandomPosition + view_offset;
  killcam.killCamStartTime = GetTime();
  killcam LinkTo(rocket);
  killcam thread killCamRocketDeath(rocket);

  rocket.killCamEnt = killcam;

  ChildrenRockets = 10;
  MissileWeapon.RotatingLinkArrayIndex = RotatingCenterEnt.RotatingLinkArray.size;
  for(i = 0; i < ChildrenRockets; i++) {
    Index = RotatingCenterEnt.RotatingLinkArray.size;
    RotatingCenterEnt.RotatingLinkArray[Index] = getPrespawnedClusterRotationEnt(MissileWeapon);
  }

  rocket endon("death");
  self thread DeleteRotationEnts(RotatingCenterEnt, rocket);
  self thread RotateTargets(RotatingCenterEnt, rocket);
  self thread MoveTargets(RotatingCenterEnt, rocket);

  waitframe();

  for(i = 1; i <= ChildrenRockets; i++) {
    rotateEnt = getMissilePosition(ClusterStartPoint, RotationStartPoint, RotatingCenterEnt, MissileWeapon);
    RandomTargetPosition = rotateEnt.origin;
    RandomPosition = rotateEnt.RandomPosition;
    child_rocket = MagicBullet("remotemissile_projectile_cluster_child_mp", RandomPosition, RandomTargetPosition, self);
    child_rocket Missile_SetTargetEnt(RotatingCenterEnt.RotatingLinkArray[i]);
    child_rocket Missile_SetFlightmodeDirect();
    child_rocket.owner = self;
    child_rocket.team = self.team;
    child_rocket.killCamEnt = killcam;
    child_rocket SetMissileMinimapVisible(true);
    child_rocket thread bomblet_explosion_waiter(self, MissileWeapon);
    waitframe();
  }
}

getMissilePosition(ClusterStartPoint, RotationStartPoint, RotatingCenterEnt, MissileWeapon) {
  rotateEnt = RotatingCenterEnt.RotatingLinkArray[MissileWeapon.RotatingLinkArrayIndex];
  MissileWeapon.RotatingLinkArrayIndex++;

  offset = RotatingCenterEnt.origin - RotationStartPoint;
  ClusterStartPoint = ClusterStartPoint + offset;

  RandomStartX = RandomIntRange(64, 500);
  RandomTargetStartX = RandomStartX + 0;
  if(RandomInt(100) > 50) {
    RandomStartX = RandomStartX * -1;
    RandomTargetStartX = RandomStartX - 0;
  }

  RandomStartY = RandomIntRange(64, 500);
  RandomTargetStartY = RandomStartY + 0;
  if(RandomInt(100) > 50) {
    RandomStartY = RandomStartY * -1;
    RandomTargetStartY = RandomStartY - 0;
  }
  RandomPosition = ClusterStartPoint + (RandomStartX, RandomStartY, 0);
  RandomTargetPosition = RotatingCenterEnt.origin + (RandomTargetStartX, RandomTargetStartY, 0);
  rotateEnt.origin = RandomTargetPosition;
  rotateEnt.RandomPosition = RandomPosition;
  rotateEnt LinkToSynchronizedParent(RotatingCenterEnt);
  return rotateEnt;
}

killCamRocketDeath(rocket) {
  self endon("death");

  rocket waittill("death");

  self Unlink();
  self.origin += (0, 0, 50);
  wait 3;
  self Delete();
}

RotateTargets(RotatingCenterEnt, MasterRocket) {
  MasterRocket endon("death");

  Time = 10;
  while(true) {
    RotatingCenterEnt RotateVelocity((0, 120, 0), Time);
    wait(Time);
  }
}

MoveTargets(RotatingCenterEnt, MasterRocket) {
  MasterRocket endon("death");

  StoredMasterRocketPos = MasterRocket.origin;
  ConstDistanceBetween = Distance(MasterRocket.origin, RotatingCenterEnt.origin);
  StoredAngles = self.StrikeRocketStoredAngles;
  StoredPosition = self.StrikeRocketStoredPosition;

  while(true) {
    DistanceBetweenStart = Distance(MasterRocket.origin, StoredMasterRocketPos);
    NewPosition = StoredPosition + (anglesToForward(StoredAngles) * (ConstDistanceBetween + DistanceBetweenStart));
    RotatingCenterEnt.origin = NewPosition;
    waitframe();
  }
}

DeleteRotationEnts(RotatingCenterEnt, MasterRocket) {
  MasterRocket waittill("death");

  if(isDefined(RotatingCenterEnt)) {
    foreach(Ent in RotatingCenterEnt.RotatingLinkArray) {
      Ent delete();
    }

    RotatingCenterEnt delete();
  }
}

ReleaseGas(LastRocketPos) {
  GasPosition = LastRocketPos + (0, 0, 40);

  GasCloud = spawn("script_model", GasPosition);
  GasCloud setModel("tag_origin");
  killCamEnt = spawn("script_model", GasCloud.origin);
  GasCloud.killCamEnt = killCamEnt;
  GasCloud.killCamEnt SetScriptMoverKillCam("explosive");
  GasCloud.killCamEnt LinkToSynchronizedParent(GasCloud);

  gas_center = spawnStruct();
  gas_center.origin = GasPosition;
  gas_center.team = self.team;

  level.missile_strike_gas_clouds[level.missile_strike_gas_clouds.size] = gas_center;

  GasCloud thread showGasCloud(self);

  GasCloud.objIDEnemy = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(GasCloud.objIDEnemy, "active", GasCloud.origin, "hud_gas_enemy");
  Objective_PlayerEnemyTeam(GasCloud.objIDEnemy, self GetEntityNumber());

  GasCloud.objIDFriendly = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(GasCloud.objIDFriendly, "active", GasCloud.origin, "hud_gas_friendly");
  Objective_PlayerTeam(GasCloud.objIDFriendly, self GetEntityNumber());

  self thread ChemDamageThink(GasCloud, GasPosition, self);

  self waittill_any_timeout_no_endon_death(20, "joined_team", "joined_spectators", "disconnect");

  _objective_delete(GasCloud.objIDEnemy);
  _objective_delete(GasCloud.objIDFriendly);

  wait(2);
  GasCloud friendlyEnemyEffectsStop();
  GasCloud.killCamEnt delete();
  GasCloud delete();

  found = false;
  newarray = [];
  for(i = 0; i < level.missile_strike_gas_clouds.size; i++) {
    if(!found && level.missile_strike_gas_clouds[i].origin == GasPosition) {
      found = true;
      continue;
    }

    newarray[newarray.size] = level.missile_strike_gas_clouds[i];
  }
  assert(found);
  assert(newarray.size == level.missile_strike_gas_clouds.size - 1);
  level.missile_strike_gas_clouds = newarray;
}

showGasCloud(owner) {
  friendlyFxId = level._missile_strike_setting["Particle_FX"].GasFriendly;
  enemyFxId = level._missile_strike_setting["Particle_FX"].Gas;
  origin = self GetTagOrigin("tag_origin");
  fwd = (1, 0, 0);
  self.friendlyFX = spawnFXShowToTeam(friendlyFxId, owner.team, origin, fwd);
  self.enemyFX = spawnFXShowToTeam(enemyFxId, getOtherTeam(owner.team), origin, fwd);
}

friendlyEnemyEffectsStop() {
  if(isDefined(self.friendlyFX)) {
    self.friendlyFX Delete();
  }
  if(isDefined(self.enemyFX)) {
    self.enemyFX Delete();
  }
}

CreateGasTrackingOverlay() {
  if(!isDefined(self.StrikeGasTrackingOverlay)) {
    self.StrikeGasTrackingOverlay = newClientHudElem(self);
    self.StrikeGasTrackingOverlay.x = 0;
    self.StrikeGasTrackingOverlay.y = 0;
    self.StrikeGasTrackingOverlay setshader("lab_gas_overlay", 640, 480);
    self.StrikeGasTrackingOverlay.alignX = "left";
    self.StrikeGasTrackingOverlay.alignY = "top";
    self.StrikeGasTrackingOverlay.horzAlign = "fullscreen";
    self.StrikeGasTrackingOverlay.vertAlign = "fullscreen";
    self.StrikeGasTrackingOverlay.alpha = 0;
  }
}

ChemDamageThink(GasCloud, GasPosition, attacker) {
  GasCloud endon("death");
  attacker endon("joined_team");
  attacker endon("joined_spectators");
  attacker endon("disconnect");

  Radius = 200;
  Damage = 20;

  while(true) {
    if(!isDefined(attacker)) {
      return;
    }

    GasCloud.killCamEnt RadiusDamage(GasPosition, Radius, Damage, Damage, attacker, "MOD_TRIGGER_HURT", "killstreak_strike_missile_gas_mp", false);

    wait(1);
  }
}

WaitForGasDamage() {
  while(1) {
    self waittill("damage", amount, attacker, direction, point, means_of_death, model, tag, part_name, damage_flags, weapon_name);
    {
      if(isDefined(attacker) && (self == attacker)) {
        continue;
      }

      if(self _hasPerk("specialty_stun_resistance")) {
        continue;
      }

      if(isDefined(weapon_name) && (weapon_name == "killstreak_strike_missile_gas_mp")) {
        self thread ShockThink();
      }
    }
  }
}

ShockThink() {
  if(self.MissileStrikeGasTime <= 0) {
    self thread fadeInOutGasTrackingOverlay();
    self thread RemoveOverlayDeath();
  }
  self.MissileStrikeGasTime = 2;
  self shellshock("mp_lab_gas", 1);
  while(self.MissileStrikeGasTime > 0) {
    self.MissileStrikeGasTime--;
    wait(1);
  }
  self notify("missile_strike_gas_end");
  self EndGasTrackingOverlay();
}

fadeInOutGasTrackingOverlay() {
  level endon("game_ended");
  self endon("missile_strike_gas_end");
  self endon("death");

  if(isDefined(self.StrikeGasTrackingOverlay)) {
    while(true) {
      self.StrikeGasTrackingOverlay FadeOverTime(0.4);
      self.StrikeGasTrackingOverlay.alpha = 1;
      wait(0.5);
      self.StrikeGasTrackingOverlay FadeOverTime(0.4);
      self.StrikeGasTrackingOverlay.alpha = 0.5;
      wait(0.5);
    }
  }
}

EndGasTrackingOverlay() {
  if(isDefined(self.StrikeGasTrackingOverlay)) {
    self.StrikeGasTrackingOverlay FadeOverTime(0.2);
    self.StrikeGasTrackingOverlay.alpha = 0.0;
  }
}

EndGasTrackingOverlayDeath() {
  if(isDefined(self.StrikeGasTrackingOverlay)) {
    self.StrikeGasTrackingOverlay.alpha = 0.0;
  }
}

RemoveOverlayDeath() {
  self endon("missile_strike_gas_end");
  self waittill("death");
  self thread EndGasTrackingOverlayDeath();
}

Player_CleanupOnTeamChange(rocket, MissileWeapon) {
  rocket endon("death");
  self endon("disconnect");

  self waittill_any("joined_team", "joined_spectators");

  MissileWeapon notify("missile_strike_complete");

  level.remoteMissileInProgress = undefined;
}

Rocket_CleanupOnDeath() {
  entityNumber = self getEntityNumber();
  level.rockets[entityNumber] = self;
  self waittill("death");

  level.rockets[entityNumber] = undefined;

  level.remoteMissileInProgress = undefined;
}

Player_CleanupOnGameEnded(rocket, MissileWeapon) {
  rocket endon("death");
  self endon("disconnect");

  level waittill("game_ended");

  MissileWeapon notify("missile_strike_complete");
}

player_is_valid_target(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(IsAlliedSentient(player, self)) {
    return false;
  }

  if(!IsAlive(player)) {
    return false;
  }

  if(player _hasPerk("specialty_blindeye")) {
    return false;
  }

  if(isDefined(player.spawntime) && (((GetTime() - player.spawntime) / 1000) < 5)) {
    return false;
  }

  return true;
}

getEnemyTargets() {
  enemyPlayers = [];

  foreach(player in level.players) {
    if(!player_is_valid_target(player)) {
      continue;
    }

    enemyPlayers[enemyPlayers.size] = player;
  }

  return enemyPlayers;
}

getValidTargetsSorted(rocket, shouldTrace, MissileWeapon) {
  missileType = MissileWeapon.name;

  targeting_radius = 600;
  targeting_radius_squared = targeting_radius * targeting_radius;

  targets = [];

  forward = anglesToForward(rocket.angles);

  rocketZ = rocket.origin[2];
  mapCenterZ = level.mapCenter[2];
  diff = mapCenterZ - rocketZ;

  ratio = diff / forward[2];

  aimTarget = rocket.origin + forward * ratio;
  rocket.aimTarget = aimTarget;

  maxTargets = 0;

  if(MissileWeapon.RocketAmmo > 0) {
    maxTargets = 1;
  } else if(MissileWeapon.clusterMissile && MissileWeapon.clusterHellfire && !self.ClusterDeployed) {
    maxTargets = 10;
  } else {
    return targets;
  }

  enemies = self getEnemyTargets();

  foreach(player in enemies) {
    if(Distance2DSquared(player.origin, aimTarget) < targeting_radius_squared) {
      if(shouldTrace) {
        if(BulletTracePassed(player.origin + (0, 0, 60), player.origin + (0, 0, 180), false, player)) {
          targets[targets.size] = player;
        }
      } else {
        targets[targets.size] = player;
      }
    }
  }

  sorted_targets = get_array_of_closest(rocket.aimTarget, targets, undefined, maxTargets);

  return sorted_targets;
}

targeting_hud_init() {
  self targeting_hud_destroy();

  max_targeting_icons = 10;

  self.missile_target_icons = [];

  for(i = 0; i < max_targeting_icons; i++) {
    newIcon = NewClientHudElem(self);
    newIcon.x = 0;
    newIcon.y = 0;
    newIcon.z = 0;
    newIcon.alpha = 0;
    newIcon.archived = false;
    newIcon.shader = CONST_HOSTILE;
    newIcon SetShader(CONST_HOSTILE, 450, 450);
    newIcon SetWayPoint(false, false, false, false);
    newIcon SetWaypointIconFadeAtCenter(false);
    newIcon SetWaypointAerialTargeting(true);

    self.missile_target_icons[i] = newIcon;
  }
}

targeting_hud_destroy() {
  if(!isDefined(self.missile_target_icons)) {
    return;
  }

  max_targeting_icons = 10;

  for(i = 0; i < max_targeting_icons; i++) {
    if(isDefined(self.missile_target_icons[i])) {
      self.missile_target_icons[i] Destroy();
    }
  }

  self.missile_target_icons = undefined;
}

targeting_hud_think(rocket, MissileWeapon) {
  self endon("disconnect");
  MissileWeapon endon("ms_early_exit");
  MissileWeapon endon("missile_strike_complete");
  rocket endon("death");
  level endon("game_ended");

  wait(1);

  missileType = MissileWeapon.name;
  rocket.targets = self getValidTargetsSorted(rocket, true, MissileWeapon);

  max_targeting_icons = 10;

  framesBetweenTargetScans = 5;
  framesSinceTargetScan = 0;
  player_z_offset = 47;

  while(true) {
    foreach(icon in self.missile_target_icons) {
      icon.alpha = 0;
    }

    framesSinceTargetScan++;

    if(framesSinceTargetScan > framesBetweenTargetScans) {
      rocket.targets = self getValidTargetsSorted(rocket, true, MissileWeapon);
      framesSinceTargetScan = 0;
    }

    HUDicon = self.missile_target_icons[0];
    HUDicon.x = self.origin[0];
    HUDicon.y = self.origin[1];
    HUDicon.z = self.origin[2];
    HUDicon.alpha = 1;

    if(HUDicon.shader != CONST_SELF) {
      HUDicon.shader = CONST_SELF;
      HUDicon SetShader(CONST_SELF, 450, 450);
      HUDicon SetWayPoint(false, false, false, false);
      HUDicon SetWaypointIconFadeAtCenter(false);
      HUDicon SetWaypointAerialTargeting(true);
    }

    valid_target_index = 1;
    newTargets = 0;

    agents = level.agentArray;
    if(!isDefined(agents)) {
      agents = [];
    }
    potentialTargets = array_combine(level.players, agents);

    rocket.targets = array_removeUndefined(rocket.targets);
    nonTargets = array_remove_array(potentialTargets, rocket.targets);
    validNonTargets = [];
    foreach(ent in nonTargets) {
      if(player_is_valid_target(ent)) {
        validNonTargets[validNonTargets.size] = ent;
      }
    }

    sortedNonTargets = get_array_of_closest(rocket.aimTarget, validNonTargets, undefined, undefined);

    potentialTargets = array_combine(rocket.targets, sortedNonTargets);

    foreach(player in potentialTargets) {
      if(!isDefined(player)) {
        continue;
      }

      HUDicon = self.missile_target_icons[valid_target_index];
      if(!isDefined(HUDicon)) {
        break;
      }

      if((isPlayer(player) || IsAgent(player)) && player_is_valid_target(player)) {
        HUDicon.x = player.origin[0];
        HUDicon.y = player.origin[1];
        HUDicon.z = player.origin[2];
        HUDicon.alpha = 1;
        valid_target_index++;

        if(array_contains(rocket.targets, player) && (HUDicon.shader == CONST_HOSTILE)) {
          HUDicon.shader = CONST_HOSTIL_LOCK;
          HUDicon SetShader(CONST_HOSTIL_LOCK, 450, 450);
          HUDicon SetWayPoint(false, false, false, false, false);
          HUDicon fadeOverTime(0.05);
          HUDicon SetWaypointIconFadeAtCenter(false);
          HUDicon SetWaypointAerialTargeting(true);
          newTargets++;
        } else if(!array_contains(rocket.targets, player) && (HUDicon.shader == CONST_HOSTIL_LOCK)) {
          HUDicon.shader = CONST_HOSTILE;
          HUDicon SetShader(CONST_HOSTILE, 450, 450);
          HUDicon SetWayPoint(false, false, false, false);
          HUDicon fadeOverTime(0.05);
          HUDicon SetWaypointIconFadeAtCenter(false);
          HUDicon SetWaypointAerialTargeting(true);
        }
      }
    }

    if(newTargets == 1) {
      rocket PlaySoundToPlayer("mstrike_locked_on_single", rocket.owner);
    }

    if(newTargets > 1) {
      rocket PlaySoundToPlayer("mstrike_locked_on_multiple", rocket.owner);
    }

    waitframe();
  }
}

init_hud(rocket, MissileWeapon) {
  self endon("disconnect");

  self thread targeting_hud_init();
  self thread targeting_hud_think(rocket, MissileWeapon);

  self SetClientOmnvar("ui_predator_missile", 1);
  self SetClientOmnvar("ui_predator_missile_count", MissileWeapon.RocketAmmo);

  missileType = MissileWeapon.name;

  if(missileType == "remotemissile_projectile_mp") {
    self SetClientOmnvar("ui_predator_missile_type", 1);
  } else if(missileType == "remotemissile_projectile_gas_mp") {
    self SetClientOmnvar("ui_predator_missile_type", 2);
  } else if(missileType == "remotemissile_projectile_cluster_parent_mp") {
    if(MissileWeapon.clusterHellfire) {
      self SetClientOmnvar("ui_predator_missile_type", 4);
    } else {
      self SetClientOmnvar("ui_predator_missile_type", 3);
    }
  }

  waitframe();

  self hud_update_fire_text(rocket, MissileWeapon);
  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
}

remove_hud() {
  self SetClientOmnvar("ui_predator_missile", 0);
  self SetClientOmnvar("ui_predator_missile_text", 0);
  self SetClientOmnvar("ui_predator_missile_type", 0);
  self SetClientOmnvar("ui_predator_missile_count", 0);
  self targeting_hud_destroy();

  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();
}

hud_update_fire_text(rocket, MissileWeapon) {
  self SetClientOmnvar("ui_predator_missile_count", MissileWeapon.RocketAmmo);
  if(MissileWeapon.RocketAmmo > 0) {
    assert(MissileWeapon.RocketAmmo <= 2);

    self SetClientOmnvar("ui_predator_missile_text", MissileWeapon.RocketAmmo);
  } else if(MissileWeapon.clusterMissile) {
    if(!self.ClusterDeployed) {
      self SetClientOmnvar("ui_predator_missile_text", 5);
    } else {
      self SetClientOmnvar("ui_predator_missile_text", 6);
    }
  } else {
    if(!self.MissileBoostUsed) {
      self SetClientOmnvar("ui_predator_missile_text", 3);
    } else {
      self SetClientOmnvar("ui_predator_missile_text", 4);
    }
  }
}

hud_watch_for_boost_active(rocket, MissileWeapon) {
  self endon("disconnect");
  MissileWeapon endon("missile_strike_complete");
  MissileWeapon endon("ms_early_exit");

  self waittill("FireButtonPressed");

  self PlayRumbleOnEntity("sniper_fire");

  self.MissileBoostUsed = true;

  self hud_update_fire_text(rocket, MissileWeapon);
}

fade_to_white() {
  self endon("disconnect");

  if(!isDefined(self.StrikeWhiteFade)) {
    self.StrikeWhiteFade = newClientHudElem(self);
    self.StrikeWhiteFade.x = 0;
    self.StrikeWhiteFade.y = 0;
    self.StrikeWhiteFade setshader("white", 640, 480);
    self.StrikeWhiteFade.alignX = "left";
    self.StrikeWhiteFade.alignY = "top";
    self.StrikeWhiteFade.horzAlign = "fullscreen";
    self.StrikeWhiteFade.vertAlign = "fullscreen";
    self.StrikeWhiteFade.alpha = 0;
  }

  self.StrikeWhiteFade FadeOverTime(0.15);
  self.StrikeWhiteFade.alpha = 1;

  wait(0.15);

  self notify("full_white");

  self.StrikeWhiteFade FadeOverTime(0.2);
  self.StrikeWhiteFade.alpha = 0;

  wait(0.2);

  self notify("fade_white_over");

  self.StrikeWhiteFade Destroy();
}

playerAddNotifyCommands() {
  self NotifyOnPlayerCommand("FireButtonPressed", "+attack");
  self NotifyOnPlayerCommand("FireButtonPressed", "+attack_akimbo_accessible");
}

playerRemoveNotifyCommands() {
  self NotifyOnPlayerCommandRemove("FireButtonPressed", "+attack");
  self NotifyOnPlayerCommandRemove("FireButtonPressed", "+attack_akimbo_accessible");
}