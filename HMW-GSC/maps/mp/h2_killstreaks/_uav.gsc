#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include scripts\utility;

h2_blockteamradar(team) {
  foreach(player in level.players) {
    if(player.team == team)
      player h2_jamPlayerRadar(true);
  }
}

h2_unblockteamradar(team) {
  foreach(player in level.players) {
    if(player.team == team)
      player h2_jamPlayerRadar(false);
  }
}

h2_jamPlayerRadar(var_0) {
  if(var_0) {
    self.h2_radar_jam = true;
    self setclientomnvar("ui_uav_scrambler_on", 1);
  } else {
    self.h2_radar_jam = undefined;
    self setclientomnvar("ui_uav_scrambler_on", 0);
  }
}

init() {
  precacheModel("vehicle_uav_static_mp");
  precacheModel("tag_origin");

  level.radarViewTime = 30; // time radar remains active
  level.uavBlockTime = 30; // this only seems to be used for the FFA version.

  assert(level.radarViewTime > 7);
  assert(level.uavBlockTime > 7);

  level.uav_fx["explode"] = loadfx("fx/explosions/aerial_explosion");

  level.killStreakFuncs["radar_mp"] = ::tryUseUAV;
  //level.killStreakFuncs["double_uav"] = ::tryUseDoubleUAV;
  level.killStreakFuncs["counter_radar_mp"] = ::tryUseCounterUAV;

  minimapOrigins = getEntArray("minimap_corner", "targetname");
  ac130Origin = getEnt("ac130Origin", "targetname");
  if(isDefined(ac130Origin))
    uavOrigin = ac130Origin.origin;
  else if(miniMapOrigins.size)
    uavOrigin = maps\mp\gametypes\_spawnlogic::findBoxCenter(miniMapOrigins[0].origin, miniMapOrigins[1].origin);
  else
    uavOrigin = (0, 0, 0);

  level.UAVRig = spawn("script_model", uavOrigin);
  level.UAVRig setModel("tag_origin");
  level.UAVRig.angles = (0, 115, 0);
  level.UAVRig hide();

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

    level thread onPlayerConnect();
  }

  level thread UAVTracker();
}

onPlayerConnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", player);

    level.activeUAVs[player.guid] = 0;
    level.activeCounterUAVs[player.guid] = 0;

    level.radarMode[player.guid] = "normal_radar";
  }
}

rotateUAVRig() {
  level endon("game_ended");
  for(;;) {
    self rotateyaw(-360, 60);
    wait(60);
  }
}

launchUAV(owner, team, duration, isCounter) {
  UAVModel = spawn("script_model", level.UAVRig getTagOrigin("tag_origin"));

  UAVModel setModel("vehicle_uav_static_mp");

  UAVModel thread damageTracker(isCounter);
  UAVModel.team = team;
  UAVModel.owner = owner;

  UAVModel thread handleIncomingStinger();

  addUAVModel(UAVModel);

  zOffset = 3000;

  angle = randomInt(360);
  radiusOffset = randomInt(2000) + 5000;

  xOffset = cos(angle) * radiusOffset;
  yOffset = sin(angle) * radiusOffset;

  angleVector = vectorNormalize((xOffset, yOffset, zOffset));
  angleVector = vector_multiply(angleVector, 6000);

  UAVModel linkTo(level.UAVRig, "tag_origin", angleVector, (0, angle - 90, 0));

  UAVModel thread updateUAVModelVisibility();

  if(isCounter)
    UAVModel addActiveCounterUAV();
  else
    UAVModel addActiveUAV();

  level notify("uav_update");

  UAVModel waittill_notify_or_timeout_hostmigration_pause("death", duration - 7);

  if(isDefined(UAVModel.alreadyDead)) {
    forward = vector_multiply(anglesToRight(UAVModel.angles), 200);
    playFX(level.uav_fx["explode"], UAVModel.origin, forward);
  } else {
    UAVModel unlink();

    destPoint = UAVModel.origin + vector_multiply(anglesToForward(UAVModel.angles), 20000);
    UAVModel moveTo(destPoint, 60);

    // this fails for some reason, undefined isn't int??
    //playFXOnTag( level._effect[ "ac130_engineeffect" ] , UAVModel, "tag_origin", 0 );

    UAVModel waittill_notify_or_timeout_hostmigration_pause("death", 3);

    UAVModel moveTo(destPoint, 4, 4, 0.0);

    UAVModel waittill_notify_or_timeout_hostmigration_pause("death", 4);
  }

  if(isCounter)
    UAVModel removeActiveCounterUAV();
  else
    UAVModel removeActiveUAV();

  UAVModel delete();
  removeUAVModel(UAVModel);

  level notify("uav_update");
}

waittill_notify_or_timeout_hostmigration_pause(msg, timer) {
  self endon(msg);

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timer);
}

updateUAVModelVisibility() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill_either("joined_team", "uav_update");

    self hide();
    foreach(player in level.players) {
      if(level.teamBased) {
        if(player.team != self.team)
          self showToPlayer(player);
      } else {
        if(isDefined(self.owner) && player == self.owner)
          continue;

        self showToPlayer(player);
      }
    }
  }
}

damageTracker(isCounterUAV) {
  level endon("game_ended");
  self endon("death");

  self.health = 999999; // keep it from dying anywhere in code
  self.maxhealth = 700;
  self.damageTaken = 0; // how much damage has it taken
  self setCanDamage(true);

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, sMeansOfDeath);

    if(!isPlayer(attacker))
      continue;

    self.damageTaken += damage;

    attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("");

    if(attacker _hasPerk("specialty_armorpiercing") && isDefined(self)) {
      damageAdd = damage * level.armorPiercingMod;
      self.damageTaken += int(damageAdd);
    }

    if(self.damageTaken >= self.maxhealth) {
      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        if(isCounterUAV)
          thread teamplayercardsplash("destroyed_counter_radar", attacker);
        else
          thread teamplayercardsplash("destroyed_radar", attacker);

        thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, sMeansOfDeath);
        attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", 50);
        attacker notify("destroyed_killstreak");
      }

      self.alreadyDead = true;
      self notify("death");
      return;
    }
  }
}

tryUseUAV(lifeId) {
  return useUAV("uav");
}

tryUseDoubleUAV(lifeId) {
  return useUAV("double_uav");
}

tryUseCounterUAV(lifeId) {
  return useUAV("counter_uav");
}

useUAV(uavType) {
  self maps\mp\_matchdata::logKillstreakEvent((uavType == "counter_uav" ? "counter_radar_mp" : "radar_mp"), self.origin);

  team = self.pers["team"];
  useTime = level.radarViewTime;

  level thread launchUAV(self, team, useTime, uavType == "counter_uav");

  if(uavType == "counter_uav")
    self notify("used_counter_uav");
  else
    self notify("used_uav");

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

updateTeamUAVStatus(team) {
  activeUAVs = level.activeUAVs[team];
  activeCounterUAVs = level.activeCounterUAVs[level.otherTeam[team]];

  if(!activeCounterUAVs)
    h2_unblockTeamRadar(team);
  else
    h2_blockTeamRadar(team);

  if(!activeUAVs) {
    setTeamRadarWrapper(team, 0);
    return;
  }

  if(activeUAVs > 1)
    level.radarMode[team] = "fast_radar";
  else
    level.radarMode[team] = "normal_radar";

  updateTeamUAVType();
  setTeamRadarWrapper(team, 1);
}

updatePlayersUAVStatus() {
  totalActiveCounterUAVs = 0;
  counterUAVPlayer = undefined;

  foreach(player in level.players) {
    activeUAVs = level.activeUAVs[player.guid];
    activeCounterUAVs = level.activeCounterUAVs[player.guid];

    if(activeCounterUAVs) {
      totalActiveCounterUAVs++;
      counterUAVPlayer = player;
    }

    if(!activeUAVs) {
      player.hasRadar = false;
      player.radarMode = "normal_radar";
      continue;
    }

    if(activeUAVs > 1)
      player.radarMode = "fast_radar";
    else
      player.radarMode = "normal_radar";

    player.hasRadar = true;
  }

  foreach(player in level.players) {
    if(!totalActiveCounterUAVs) {
      player h2_jamPlayerRadar(false);
      continue;
    }

    if(totalActiveCounterUAVs == 1 && player == counterUAVPlayer)
      player h2_jamPlayerRadar(false);
    else
      player h2_jamPlayerRadar(true);
  }
}

blockPlayerUAV() {
  self endon("disconnect");

  self notify("blockPlayerUAV");
  self endon("blockPlayerUAV");

  self h2_jamPlayerRadar(true);

  wait(level.uavBlockTime);

  self h2_jamPlayerRadar(false);

  //self iPrintLn( &"MP_WAR_COUNTER_RADAR_EXPIRED" );
}

updateTeamUAVType() {
  foreach(player in level.players) {
    if(player.team == "spectator")
      continue;

    player.radarMode = level.radarMode[player.team];
  }
}

usePlayerUAV(doubleUAV, useTime) {
  level endon("game_ended");
  self endon("disconnect");

  self notify("usePlayerUAV");
  self endon("usePlayerUAV");

  if(doubleUAV)
    self.radarMode = "fast_radar";
  else
    self.radarMode = "normal_radar";

  self.hasRadar = true;

  wait(useTime);

  self.hasRadar = false;

  //self iPrintLn( &"MP_WAR_RADAR_EXPIRED" );
}

setTeamRadarWrapper(team, value) {
  setTeamRadar(team, value);
  level notify("radar_status_change", team);
}

handleIncomingStinger() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", player, missile, lockTarget);

    if(!isDefined(lockTarget) || (lockTarget != self))
      continue;

    missile thread stingerProximityDetonate(lockTarget, player);
  }
}

stingerProximityDetonate(targetEnt, player) {
  self endon("death");
  level endon("game_ended");

  minDist = distance(self.origin, targetEnt GetPointInBounds(0, 0, 0));
  lastCenter = targetEnt GetPointInBounds(0, 0, 0);

  for(;;) {
    // UAV already destroyed
    if(!isDefined(targetEnt))
      center = lastCenter;
    else
      center = targetEnt GetPointInBounds(0, 0, 0);

    lastCenter = center;

    curDist = distance(self.origin, center);

    if(curDist < minDist)
      minDist = curDist;

    if(curDist > minDist) {
      if(curDist > 1536)
        return;

      radiusDamage(self.origin, 1536, 600, 600, player);
      playFX(level.stingerFXid, self.origin);

      //self playSound( "remotemissile_explode" );
      self hide();

      self notify("deleted");
      wait(0.05);
      self delete();
      player notify("killstreak_destroyed");
    }

    wait(0.05);
  }
}

addUAVModel(UAVModel) {
  if(level.teamBased)
    level.UAVModels[UAVModel.team][level.UAVModels[UAVModel.team].size] = UAVModel;
  else
    level.UAVModels[UAVModel.owner.guid + "_" + getTime()] = UAVModel;
}

removeUAVModel(UAVModel) {
  UAVModels = [];

  if(level.teamBased) {
    team = UAVModel.team;

    foreach(uavModel in level.UAVModels[team]) {
      if(!isDefined(uavModel))
        continue;

      UAVModels[UAVModels.size] = uavModel;
    }

    level.UAVModels[team] = UAVModels;
  } else {
    foreach(uavModel in level.UAVModels) {
      if(!isDefined(uavModel))
        continue;

      UAVModels[UAVModels.size] = uavModel;
    }

    level.UAVModels = UAVModels;
  }
}

addActiveUAV() {
  if(level.teamBased)
    level.activeUAVs[self.team]++;
  else
    level.activeUAVs[self.owner.guid]++;
  /*
  if( level.teamBased )
  {
  foreach ( player in level.players )
  {
  if( player.team == self.team )
  player iPrintLn( &"MP_WAR_RADAR_ACQUIRED", self.owner, level.radarViewTime );
  else if( player.team == level.otherTeam[self.team] )
  player iPrintLn( &"MP_WAR_RADAR_ACQUIRED_ENEMY", level.radarViewTime);
  }
  }	
  else
  {
  foreach ( player in level.players )
  {
  if( player == self.owner )
  player iPrintLn( &"MP_WAR_RADAR_ACQUIRED", self.owner, level.radarViewTime );
  else
  player iPrintLn( &"MP_WAR_RADAR_ACQUIRED_ENEMY", level.radarViewTime );
  }
  }
  */
}

addActiveCounterUAV() {
  if(level.teamBased)
    level.activeCounterUAVs[self.team]++;
  else
    level.activeCounterUAVs[self.owner.guid]++;
  /*
  if( level.teamBased )
  {
  foreach ( player in level.players )
  {
  if( player.team == self.team )
  player iPrintLn( &"MP_WAR_COUNTER_RADAR_ACQUIRED", self.owner, level.uavBlockTime );
  else if( player.team == level.otherTeam[self.team] )
  player iPrintLn( &"MP_WAR_COUNTER_RADAR_ACQUIRED_ENEMY", level.uavBlockTime );
  }
  }	
  else
  {
  foreach ( player in level.players )
  {
  if( player == self.owner )
  player iPrintLn( &"MP_WAR_COUNTER_RADAR_ACQUIRED", self.owner, level.uavBlockTime );
  else
  player iPrintLn( &"MP_WAR_COUNTER_RADAR_ACQUIRED_ENEMY", level.uavBlockTime );
  }
  }
  */
}

removeActiveUAV() {
  if(level.teamBased) {
    level.activeUAVs[self.team]--;

    if(!level.activeUAVs[self.team]) {
      //printOnTeam( &"MP_WAR_RADAR_EXPIRED", self.team );
      //printOnTeam( &"MP_WAR_RADAR_EXPIRED_ENEMY", level.otherTeam[self.team] );
    }
  } else if(isDefined(self.owner)) {
    level.activeUAVs[self.owner.guid]--;
  }
}

removeActiveCounterUAV() {
  if(level.teamBased) {
    level.activeCounterUAVs[self.team]--;

    if(!level.activeCounterUAVs[self.team]) {
      //printOnTeam( &"MP_WAR_COUNTER_RADAR_EXPIRED", self.team );
      //printOnTeam( &"MP_WAR_COUNTER_RADAR_EXPIRED_ENEMY", level.otherTeam[self.team] );
    }
  } else if(isDefined(self.owner)) {
    level.activeCounterUAVs[self.owner.guid]--;
  }
}