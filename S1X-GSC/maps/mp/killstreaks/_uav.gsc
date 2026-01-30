/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_uav.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_UAV_BASE_TIME = 30;
CONST_UAV_MOD_INCREASED_TIME = 15;
CONST_THREAT_DRAW_TIME = 10;

init() {
  assert(CONST_UAV_BASE_TIME > 7);

  level._effect["uav_explode"] = LoadFX("vfx/explosion/vehicle_uav_explosion");
  level._effect["uav_exit"] = LoadFX("vfx/trail/smoketrail_uav");
  level._effect["uav_trail"] = LoadFX("vfx/trail/smoketrail_uav");

  level.killStreakFuncs["uav"] = ::tryUseUAV;
  level.killStreakFuncs["uav_support"] = ::tryUseUAV;
  level.killStreakFuncs["counter_uav"] = ::tryUseUAV;

  minimapOrigins = getEntArray("minimap_corner", "targetname");
  if(miniMapOrigins.size) {
    uavOrigin = maps\mp\gametypes\_spawnlogic::findBoxCenter(miniMapOrigins[0].origin, miniMapOrigins[1].origin);
  } else {
    uavOrigin = (0, 0, 0);
  }

  level.UAVRig = spawn("script_model", uavOrigin);
  level.UAVRig setModel("c130_zoomrig");
  level.UAVRig.angles = (0, 115, 0);
  level.UAVRig hide();

  level.UAVRig.targetname = "uavrig_script_model";

  level.UAVRig thread rotateUAVRig();

  if(level.teamBased) {
    level.radarMode["allies"] = "normal_radar";
    level.radarMode["axis"] = "normal_radar";
    level.activeUAVs["allies"] = 0;
    level.activeUAVs["axis"] = 0;
    level.activeCounterUAVs["allies"] = 0;
    level.activeCounterUAVs["axis"] = 0;
    level.uavModels["allies"] = [];
    level.uavModels["axis"] = [];
  } else {
    level.radarMode = [];
    level.activeUAVs = [];
    level.activeCounterUAVs = [];
    level.uavModels = [];
  }

  level thread onPlayerConnect();
  level thread UAVTracker();

  SetDvarIfUninitialized("scr_uav_timeout", "0");
  SetDvarIfUninitialized("scr_uav_norandom", "0");
  SetDvarIfUninitialized("scr_uav_alwaysshow", "0");
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(!level.teamBased) {
      level.activeUAVs[player.guid] = 0;
      level.activeUAVs[player.guid + "_radarStrength"] = 0;
      level.activeCounterUAVs[player.guid] = 0;

      level.radarMode[player.guid] = "normal_radar";
    }

    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned_player");

    level notify("uav_update");
  }
}

rotateUAVRig() {
  for(;;) {
    self rotateyaw(-360, 60);
    wait(60);
  }
}

debugLocation() {
  self endon("death");

  while(true) {
    Print3d(self.origin, "UAV", (1, 0, 0));
    Print3d(self.origin, "UAV origin: " + self.origin[0] + ", " + self.origin[1] + ", " + self.origin[2], (1, 0, 0));

    Print3d(level.UAVRig.origin, "UAV Rig", (1, 0, 0));
    Print3d(level.UAVRig.origin, "UAV Rig origin: " + level.UAVRig.origin[0] + ", " + level.UAVRig.origin[1] + ", " + level.UAVRig.origin[2], (1, 0, 0));

    Print3d(level.UAVRig.origin - (0, 0, 50), "Distance: " + Distance(level.UAVRig.origin, self.origin), (1, 0, 0));

    Line(level.UAVRig.origin, self.origin, (0, 0, 1));

    anglesForward = anglesToForward(level.players[0].angles);
    scalar = (anglesForward[0] * 200, anglesForward[1] * 200, anglesForward[2]);
    Print3d(level.players[0].origin + scalar, "Distance: " + Distance(level.players[0].origin, self.origin), (1, 0, 0));
    wait(0.05);
  }
}

debugTrace() {
  self endon("death");

  while(true) {
    result = bulletTrace(level.players[0].origin, self.origin, false, undefined);
    if(isDefined(result) && isDefined(result["surfacetype"])) {
      PrintLn("UAV debugTrace: " + result["surfacetype"]);
    }
    wait(1.0);
  }
}

playTrailFX() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(level._effect["uav_trail"], self, "tag_origin");
}
launchUAV(owner, team, uavType, modules) {
  UAVModel = spawn("script_model", level.UAVRig getTagOrigin("tag_origin"));
  UAVModel.modules = modules;

  if(GetDvarInt("scr_debuguav", 0)) {
    UAVModel thread debugLocation();
    UAVModel thread debugTrace();
  }

  UAVModel.value = 1;

  if(array_contains(UAVModel.modules, "uav_advanced_updates")) {
    UAVModel.value = 2;
  }
  if(array_contains(UAVModel.modules, "uav_enemy_direction")) {
    UAVModel.value = 3;
  }

  if(array_contains(UAVModel.modules, "uav_scrambler")) {
    isScrambler = true;
  } else {
    isScrambler = false;
  }

  UAVModel setModel("uav_drone_static");
  UAVModel thread playTrailFX();

  UAVModel thread maps\mp\gametypes\_damage::setEntityDamageCallback(1000, undefined, ::uavOnDeath, undefined, true);

  UAVModel.team = team;
  UAVModel.owner = owner;
  UAVModel.timeToAdd = 0;
  UAVModel.orbit = array_contains(UAVModel.modules, "uav_orbit");
  UAVModel.paintOutline = array_contains(UAVModel.modules, "uav_paint_outline");
  UAVModel.assistPoints = array_contains(UAVModel.modules, "uav_assist_points");
  UAVModel make_entity_sentient_mp(team);

  UAVModel thread handleIncomingStinger();

  UAVModel.StreakCustomization = owner.StreakCustomization;

  UAVModel addUAVModel();

  thread flyIn(UAVModel);
  UAVModel thread updateUAVModelVisibility();
  UAVModel thread maps\mp\killstreaks\_killstreaks::updateAerialKillStreakMarker();

  UAVModel addActiveUAV();

  if(isScrambler) {
    UAVModel addActiveCounterUAV();
  }

  if(isDefined(level.activeUAVs[team])) {
    foreach(uav in level.UAVModels[team]) {
      if(uav == UAVModel) {
        continue;
      }

      if(isScrambler) {
        uav.timeToAdd += 5;
      } else if(!isScrambler) {
        uav.timeToAdd += 5;
      }
    }
  }

  waitframe();
  level notify("uav_update");

  duration = CONST_UAV_BASE_TIME;
  if(array_contains(UAVModel.modules, "uav_increased_time")) {
    duration += CONST_UAV_MOD_INCREASED_TIME;
  }

  if(GetDvarInt("scr_uav_timeout", 0) != 0) {
    duration = GetDvarInt("scr_uav_timeout");
  }

  UAVModel waittill_notify_or_timeout_hostmigration_pause("death", duration);

  if(UAVModel.damageTaken < UAVModel.maxHealth) {
    UAVModel unlink();

    destPoint = UAVModel.origin + (anglesToForward(UAVModel.angles) * 20000);
    UAVModel moveTo(destPoint, 60);
    playFXOnTag(getfx("uav_exit"), UAVModel, "tag_origin");

    UAVModel waittill_notify_or_timeout_hostmigration_pause("death", 3);

    if(UAVModel.damageTaken < UAVModel.maxHealth) {
      UAVModel notify("leaving");
      UAVModel.isLeaving = true;
      UAVModel moveTo(destPoint, 4, 4, 0.0);
    }

    UAVModel waittill_notify_or_timeout_hostmigration_pause("death", 4 + UAVModel.timeToAdd);
  }

  if(isScrambler) {
    UAVModel removeActiveCounterUAV();
  }

  UAVModel removeActiveUAV();

  UAVModel delete();
  UAVModel removeUAVModel();

  level notify("uav_update");
}

flyIn(UAVModel) {
  UAVModel Hide();

  zOffset = RandomIntRange(3000, 5000);

  if(isDefined(level.spawnpoints)) {
    spawns = level.spawnPoints;
  } else {
    spawns = level.startSpawnPoints;
  }

  lowestSpawn = spawns[0];
  foreach(Spawn in spawns) {
    if(Spawn.origin[2] < lowestSpawn.origin[2]) {
      lowestSpawn = Spawn;
    }
  }
  lowestZ = lowestSpawn.origin[2];
  UAVRigZ = level.UAVRig.origin[2];
  if(lowestZ < 0) {
    UAVRigZ += lowestZ * -1;
    lowestZ = 0;
  }
  diffZ = UAVRigZ - lowestZ;
  AssertEx(diffZ < 8100.0, "The lowest spawn and the UAV node are more than 8100 z units apart, please notify MP Design.");
  if(diffZ + zOffset > 8100.0) {
    zOffset -= ((diffZ + zOffset) - 8100.0);
  }

  angle = RandomInt(360);
  radiusOffset = RandomInt(2000) + 5000;

  if(GetDvarInt("scr_uav_norandom", 0) != 0) {
    angle = 0;
    radiusOffset = 5000;
  }

  xOffset = Cos(angle) * radiusOffset;
  yOffset = Sin(angle) * radiusOffset;

  angleVector = VectorNormalize((xOffset, yOffset, zOffset));
  angleVector = (angleVector * RandomIntRange(6000, 7000));

  UAVModel LinkTo(level.UAVRig, "tag_origin", angleVector, (0, angle - 90, 135));

  waitframe();

  destination = UAVModel.origin;
  UAVModel Unlink();

  UAVModel.origin = destination + (anglesToForward(UAVModel.angles) * -20000);
  UAVModel MoveTo(destination, 4, 0, 2);
  wait 4;

  if(isDefined(UAVModel)) {
    UAVModel LinkTo(level.UAVRig, "tag_origin");
  }
}

waittill_notify_or_timeout_hostmigration_pause(msg, timer) {
  self endon(msg);

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timer);
}

updateUAVModelVisibility() {
  self endon("death");

  if(GetDvarInt("scr_uav_alwaysshow", 0) != 0) {
    waitframe();
    self Show();
    return;
  }

  for(;;) {
    level waittill_either("joined_team", "uav_update");

    self hide();
    foreach(player in level.players) {
      if(level.teamBased) {
        if((player.team != self.team) && !self.orbit) {
          self showToPlayer(player);
        }
      } else {
        if((isDefined(self.owner) && player == self.owner) || self.orbit) {
          continue;
        }

        self showToPlayer(player);
      }
    }
  }
}

uavOnDeath(attacker, weapon, meansOfDeath, damage) {
  self Hide();
  self notify("death");

  forward = (AnglesToRight(self.angles) * 200);
  playFX(getfx("uav_explode"), self.origin, forward);
  playSoundAtPos(self.origin, "uav_air_death");

  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "uav_destroyed", undefined, "callout_destroyed_uav", true);
}

tryUseUAV(lifeId, modules) {
  if(isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName)) {
    StreakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
  } else {
    StreakName = "uav_support";
  }

  if(isDefined(level.isHorde) && level.isHorde && self.killstreakIndexWeapon == 1) {
    self notify("used_horde_uav");
  }

  return useUAV(streakname, modules);
}

useUAV(uavType, modules) {
  self maps\mp\_matchdata::logKillstreakEvent(uavType, self.origin);

  team = self.pers["team"];

  level thread launchUAV(self, team, uavType, modules);

  return true;
}

UAVTracker() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teamBased) {
      updateTeamUAVStatus("allies");
      updateTeamUAVStatus("axis");
    } else {
      updatePlayersUAVStatus();
    }
  }
}

_getRadarStrength(team, fastSweep, enemyDirection) {
  activeUAVs = 0;
  activeCounterUAVs = 0;

  foreach(uav in level.UAVModels[team]) {
    activeUAVs += uav.value;
  }

  foreach(uav in level.UAVModels[level.otherTeam[team]]) {
    if(uav.uavType != "counter") {
      continue;
    }

    activeCounterUAVs += uav.value;
  }

  if(activeCounterUAVs > 0) {
    radarStrength = -3;
  } else {
    radarStrength = activeUAVs;
  }

  strengthMin = GetUAVStrengthMin();
  strengthMax = GetUAVStrengthMax();

  if(radarStrength <= strengthMin) {
    radarStrength = strengthMin;
  } else if(radarStrength >= strengthMax) {
    radarStrength = strengthMax;
  }

  return radarStrength;
}

_getTeamPaintOutline(team) {
  paintOutlineUavs = 0;
  paintOutline = false;

  foreach(uav in level.UAVModels[team]) {
    if(uav.paintOutline) {
      paintOutlineUavs += uav.value;
    }
  }

  if(paintOutlineUavs > 0) {
    paintOutline = true;
  } else {
    paintOutline = false;
  }

  return paintOutline;
}

_getPaintOutline(player) {
  paintOutlineUavs = 0;
  paintOutline = false;

  foreach(uav in level.UAVModels) {
    if(isDefined(uav.owner) && uav.owner == player && uav.paintOutline) {
      paintOutlineUavs += uav.value;
    }
  }

  if(paintOutlineUavs > 0) {
    paintOutline = true;
  } else {
    paintOutline = false;
  }

  return paintOutline;
}

updateTeamUAVStatus(team) {
  radarStrength = _getRadarStrength(team);
  hasPaintOutline = _getTeamPaintOutline(team);

  updateTeamPaintOutline(team, hasPaintOutline);

  setTeamRadarStrength(team, radarStrength);

  if(radarStrength >= GetUAVStrengthLevelNeutral()) {
    updateTeamRadarBlocked(team, false);
    unblockTeamRadar(team);
  } else {
    updateTeamRadarBlocked(team, true);
    blockTeamRadar(team);
  }

  if(radarStrength <= GetUAVStrengthLevelNeutral()) {
    setTeamRadarWrapper(team, 0);
    updateTeamUAVType(team);
    return;
  }

  if(radarStrength >= GetUAVStrengthLevelShowEnemyFastSweep()) {
    level.radarMode[team] = "fast_radar";
  } else {
    level.radarMode[team] = "normal_radar";
  }

  updateTeamUAVType(team);
  setTeamRadarWrapper(team, 1);
}

updatePlayersUAVStatus() {
  strengthMin = GetUAVStrengthMin();
  strengthMax = GetUAVStrengthMax();
  strengthDirectional = GetUAVStrengthLevelShowEnemyDirectional();

  foreach(player in level.players) {
    radarStrength = level.activeUAVs[player.guid + "_radarStrength"];
    hasPaintOutline = _getPaintOutline(player);

    updatePaintOutline(player, hasPaintOutline);

    foreach(enemyPlayer in level.players) {
      if(enemyPlayer == player) {
        continue;
      }

      activeCounterUAVs = level.activeCounterUAVs[enemyPlayer.guid];
      if(activeCounterUAVs > 0) {
        radarStrength = -3;
        break;
      }
    }

    if(radarStrength <= strengthMin) {
      radarStrength = strengthMin;
    } else if(radarStrength >= strengthMax) {
      radarStrength = strengthMax;
    }

    player.radarstrength = radarStrength;

    if(radarStrength >= GetUAVStrengthLevelNeutral()) {
      updatePlayerRadarBlocked(player, false);
      player.isRadarBlocked = false;
    } else {
      updatePlayerRadarBlocked(player, true);
      player.isRadarBlocked = true;
    }

    if(radarStrength <= GetUAVStrengthLevelNeutral()) {
      player.hasRadar = false;
      player.radarShowEnemyDirection = false;
      continue;
    }

    if(radarStrength >= GetUAVStrengthLevelShowEnemyFastSweep()) {
      player.radarMode = "fast_radar";
    } else {
      player.radarMode = "normal_radar";
    }

    player.radarShowEnemyDirection = radarStrength >= strengthDirectional;

    player.hasRadar = true;
  }
}

updateTeamUAVType(team, ShowEnemyDirection) {
  shouldBeDirectional = _getRadarStrength(team) >= GetUAVStrengthLevelShowEnemyDirectional();

  foreach(player in level.players) {
    if(player.team == "spectator") {
      continue;
    }

    enemyTeam = maps\mp\gametypes\_gameobjects::getEnemyTeam(player.team);
    player.radarMode = level.radarMode[player.team];
    player.enemyRadarMode = level.radarMode[enemyTeam];

    if(player.team == team) {
      player.radarShowEnemyDirection = shouldBeDirectional;
    }
  }
}

updateTeamPaintOutline(team, on) {
  level endon("game_ended");

  foreach(player in level.players) {
    if(isDefined(player) && player.team == team) {
      player playerSetupUAVPaintOutline(on);
    }
  }
}

updatePaintOutline(player, on) {
  level endon("game_ended");

  player playerSetupUAVPaintOutline(on);
}

playerSetupUAVPaintOutline(on) {
  if(on) {
    if(!isDefined(self.uav_paint_effect)) {
      self.uav_paint_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self, -1);
    }
    self SetPerk("specialty_uav_paint", true, false);
  } else {
    if(isDefined(self.uav_paint_effect)) {
      maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.uav_paint_effect);
      self.uav_paint_effect = undefined;
    }
    self UnSetPerk("specialty_uav_paint", true);
  }
}

updateTeamRadarBlocked(team, isBlocked) {
  foreach(player in level.players) {
    if(isDefined(player) && player.team == team) {
      updatePlayerRadarBlocked(player, isBlocked);
    }
  }
}

updatePlayerRadarBlocked(player, isBlocked) {
  if(!isBlocked || !player _hasPerk("specialty_class_hardwired")) {
    player SetClientOmnvar("ui_uav_scrambler_on", isBlocked);
  }
}

setTeamRadarWrapper(team, value) {
  setTeamRadar(team, value);
  level notify("radar_status_change", team);
}

handleIncomingStinger() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", player, missiles);

    if(!maps\mp\_stingerm7::anyStingerMissileLockedOn(missiles, self)) {
      continue;
    }

    foreach(missile in missiles) {
      if(!isDefined(missile)) {
        continue;
      }

      missile thread stingerProximityDetonate(missile.lockedStingerTarget, player);
    }
  }
}

stingerProximityDetonate(targetEnt, player) {
  self endon("death");

  minDist = distance(self.origin, targetEnt GetPointInBounds(0, 0, 0));
  lastCenter = targetEnt GetPointInBounds(0, 0, 0);

  for(;;) {
    if(!isDefined(targetEnt)) {
      center = lastCenter;
    } else {
      center = targetEnt GetPointInBounds(0, 0, 0);
    }

    lastCenter = center;

    curDist = distance(self.origin, center);

    if(curDist < minDist) {
      minDist = curDist;
    }

    if(curDist > minDist) {
      if(curDist > 1536) {
        return;
      }

      RadiusDamage(self.origin, 1536, 600, 600, player, "MOD_EXPLOSIVE", "stinger_mp");
      playFX(level.stingerFXid, self.origin);

      self hide();

      self notify("deleted");
      wait(0.05);
      self delete();
      player notify("killstreak_destroyed");
    }

    wait(0.05);
  }
}

addUAVModel() {
  if(level.teamBased) {
    level.UAVModels[self.team][level.UAVModels[self.team].size] = self;
  } else {
    level.UAVModels[self.owner.guid + "_" + getTime()] = self;
  }
}

removeUAVModel() {
  UAVModels = [];

  if(level.teamBased) {
    team = self.team;

    foreach(uavModel in level.UAVModels[team]) {
      if(!isDefined(uavModel)) {
        continue;
      }

      UAVModels[UAVModels.size] = uavModel;
    }

    level.UAVModels[team] = UAVModels;
  } else {
    foreach(uavModel in level.UAVModels) {
      if(!isDefined(uavModel)) {
        continue;
      }

      UAVModels[UAVModels.size] = uavModel;
    }

    level.UAVModels = UAVModels;
  }
}

addActiveUAV() {
  self.uavType = "standard";

  if(level.teamBased) {
    level.activeUAVs[self.team]++;
  } else {
    level.activeUAVs[self.owner.guid]++;
    level.activeUAVs[self.owner.guid + "_radarStrength"] += self.value;
  }
}

addActiveCounterUAV() {
  self.uavType = "counter";

  if(level.teamBased) {
    level.activeCounterUAVs[self.team]++;
  } else {
    level.activeCounterUAVs[self.owner.guid]++;
  }
}

removeActiveUAV() {
  if(level.teamBased) {
    level.activeUAVs[self.team]--;

    if(!level.activeUAVs[self.team]) {}
  } else if(isDefined(self.owner)) {
    level.activeUAVs[self.owner.guid]--;
    level.activeUAVs[self.owner.guid + "_radarStrength"] -= self.value;
  }
}

removeActiveCounterUAV() {
  if(level.teamBased) {
    level.activeCounterUAVs[self.team]--;

    if(!level.activeCounterUAVs[self.team]) {}
  } else if(isDefined(self.owner)) {
    level.activeCounterUAVs[self.owner.guid]--;
  }
}