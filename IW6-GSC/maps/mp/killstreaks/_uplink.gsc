/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_uplink.gsc
*******************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_UPLINK_WEAPON = "killstreak_uplink_mp";
CONST_UPLINK_TIME = 30;
CONST_UPLINK_MIN = 0;
CONST_EYES_ON = 1;
CONST_UPLINK_FULL_RADAR = 2;
CONST_UPLINK_FAST_PING = 3;
CONST_DIRECTIONAL = 4;
CONST_UPLINK_MAX = 4;
CONST_FAST_SWEEP = "fast_radar";
CONST_NORMAL_SWEEP = "normal_radar";
CONST_HEAD_ICON_OFFSET = 42;
CONST_EMP_VFX = "emp_stun";
CONST_EMP_VFX_TAG = "tag_origin";

init() {
  level.uplinks = [];
  level.killstreakFuncs["uplink"] = ::tryUseUpLink;
  level.killstreakFuncs["uplink_support"] = ::tryUseUpLink;

  level.comExpFuncs = [];
  level.comExpFuncs["giveComExpBenefits"] = ::giveComExpBenefits;
  level.comExpFuncs["removeComExpBenefits"] = ::removeComExpBenefits;
  level.comExpFuncs["getRadarStrengthForTeam"] = ::getRadarStrengthForTeam;
  level.comExpFuncs["getRadarStrengthForPlayer"] = ::getRadarStrengthForPlayer;

  unblockTeamRadar("axis");
  unblockTeamRadar("allies");

  level thread upLinkTracker();
  level thread uplinkUpdateEyesOn();

  config = spawnStruct();
  config.streakName = "uplink";
  config.weaponInfo = "ims_projectile_mp";
  config.modelBase = "mp_satcom";

  config.modelPlacement = "mp_satcom_obj";
  config.modelPlacementFailed = "mp_satcom_obj_red";
  config.modelBombSquad = "mp_satcom_bombsquad";
  config.hintString = &"KILLSTREAKS_HINTS_UPLINK_PICKUP";
  config.placeString = &"KILLSTREAKS_HINTS_UPLINK_PLACE";
  config.cannotPlaceString = &"KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
  config.headIconHeight = CONST_HEAD_ICON_OFFSET;
  config.splashName = "used_uplink";
  config.lifeSpan = CONST_UPLINK_TIME;

  config.maxHealth = 500;
  config.allowMeleeDamage = true;
  config.allowEmpDamage = true;
  config.damageFeedback = "trophy";
  config.xpPopup = "destroyed_uplink";
  config.destroyedVO = "satcom_destroyed";

  config.placementHeightTolerance = 30.0;
  config.placementRadius = 16.0;
  config.placementOffsetZ = 16;
  config.onPlacedDelegate = ::onPlaced;
  config.onCarriedDelegate = ::onCarried;
  config.placedSfx = "mp_killstreak_satcom_deploy";
  config.activeSfx = "mp_killstreak_satcom_loop";
  config.onMovingPlatformCollision = ::uplink_override_moving_platform_death;

  config.onDeathDelegate = ::onDeath;
  config.onDestroyedDelegate = ::onDestroyed;
  config.deathVfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");

  level.placeableConfigs["uplink"] = config;
  level.placeableConfigs["uplink_support"] = config;
}

upLinkTracker() {
  level endon("game_ended");

  while(true) {
    level waittill("update_uplink");
    level childthread updateAllUplinkThreads();
  }
}

updateAllUplinkThreads() {
  self notify("updateAllUplinkThreads");
  self endon("updateAllUplinkThreads");

  level childthread comExpNotifyWatcher();

  if(level.teamBased) {
    level childthread updateTeamUpLink("axis");
    level childthread updateTeamUpLink("allies");
  } else {
    level childthread updatePlayerUpLink();
  }

  level childthread updateComExpUpLink();
}

comExpNotifyWatcher() {
  teamsFinished = [];

  if(!level.teamBased) {
    level waittill("radar_status_change_players");
  }
  else {
    while(teamsFinished.size < 2) {
      level waittill("radar_status_change", team);
      teamsFinished[teamsFinished.size] = team;
    }
  }

  level notify("start_com_exp");
}

updateTeamUpLink(team) {
  currentStrengthForTeam = getRadarStrengthForTeam(team);
  shouldBeEyesOn = (currentStrengthForTeam == CONST_EYES_ON);
  shouldBeFullRadar = (currentStrengthForTeam >= CONST_UPLINK_FULL_RADAR);
  shouldBeFastSweep = (currentStrengthForTeam >= CONST_UPLINK_FAST_PING);
  shouldBeDirectional = (currentStrengthForTeam >= CONST_DIRECTIONAL);

  if(shouldBeFullRadar) {
    unblockTeamRadar(team);
  }

  if(shouldBeFastSweep) {
    level.radarMode[team] = CONST_FAST_SWEEP;
  } else {
    level.radarMode[team] = CONST_NORMAL_SWEEP;
  }

  foreach(player in level.participants) {
    if(!isDefined(player)) {
      continue;
    }
    if(player.team != team) {
      continue;
    }
    player.shouldBeEyesOn = shouldBeEyesOn;
    player SetEyesOnUplinkEnabled(shouldBeEyesOn);
    player.radarMode = level.radarMode[player.team];
    player.radarShowEnemyDirection = shouldBeDirectional;
    player updateSatcomActiveOmnvar(team);

    wait(0.05);
  }

  setTeamRadar(team, shouldBeFullRadar);
  level notify("radar_status_change", team);
}

updatePlayerUpLink() {
  foreach(player in level.participants) {
    if(!isDefined(player)) {
      continue;
    }
    currentStrengthForSelf = getRadarStrengthForPlayer(player);
    setPlayerRadarEffect(player, currentStrengthForSelf);
    player updateSatcomActiveOmnvar();

    wait(0.05);
  }

  level notify("radar_status_change_players");
}

updateComExpUpLink() {
  level waittill("start_com_exp");

  foreach(player in level.participants) {
    if(!isDefined(player)) {
      continue;
    }
    player giveComExpBenefits();

    wait(0.05);
  }
}

giveComExpBenefits() {
  if((self _hasPerk("specialty_comexp"))) {
    radarStrength = getRadarStrengthForComExp(self);
    setPlayerRadarEffect(self, radarStrength);
    self updateSatcomActiveOmnvar();
  }
}

updateSatcomActiveOmnvar(team) {
  radarStrength = 0;
  if(isDefined(team)) {
    radarStrength = getRadarStrengthForTeam(team);
  }
  else {
    radarStrength = getRadarStrengthForPlayer(self);
  }

  if(self _hasPerk("specialty_comexp")) {
    radarStrength = getRadarStrengthForComExp(self);
  }

  if(radarStrength > CONST_UPLINK_MIN) {
    self SetClientOmnvar("ui_satcom_active", true);
  }
  else {
    self SetClientOmnvar("ui_satcom_active", false);
  }
}

removeComExpBenefits() {
  self.shouldBeEyesOn = false;
  self SetEyesOnUplinkEnabled(false);
  self.radarShowEnemyDirection = false;
  self.radarMode = CONST_NORMAL_SWEEP;
  self.hasRadar = false;
  self.isRadarBlocked = false;
}

setPlayerRadarEffect(player, radarStrength) {
  shouldBeEyesOn = (radarStrength == CONST_EYES_ON);
  shouldBeFullRadar = (radarStrength >= CONST_UPLINK_FULL_RADAR);
  shouldBeFastSweep = (radarStrength >= CONST_UPLINK_FAST_PING);
  shouldBeDirectional = (radarStrength >= CONST_DIRECTIONAL);

  player.shouldBeEyesOn = shouldBeEyesOn;
  player SetEyesOnUplinkEnabled(shouldBeEyesOn);
  player.radarShowEnemyDirection = shouldBeDirectional;
  player.radarMode = CONST_NORMAL_SWEEP;
  player.hasRadar = shouldBeFullRadar;
  player.isRadarBlocked = false;

  if(shouldBeFastSweep) {
    player.radarMode = CONST_FAST_SWEEP;
  }
}

tryUseUpLink(lifeId, streakName) {
  result = self maps\mp\killstreaks\_placeable::givePlaceable(streakName);

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent("uplink", self.origin);
  }

  self.isCarrying = undefined;

  return result;
}

onCarried(streakName) {
  entNum = self GetEntityNumber();
  if(isDefined(level.uplinks[entNum])) {
    self stopUplink();
  }
}

onPlaced(streakName) {
  config = level.placeableConfigs[streakName];

  self.owner notify("uplink_deployed");

  self setModel(config.modelBase);

  self.immediateDeath = false;
  self SetOtherEnt(self.owner);
  self make_entity_sentient_mp(self.owner.team, true);
  self.config = config;

  self startUplink(true);

  self thread watchEMPDamage();
}

startUplink(playOpenAnim) {
  addUplinkToLevelList(self);

  self thread playUplinkAnimations(playOpenAnim);

  self playLoopSound(self.config.activeSfx);
}

stopUplink() {
  self maps\mp\gametypes\_weapons::stopBlinkingLight();

  self ScriptModelClearAnim();

  if(isDefined(self.bombSquadModel)) {
    self.bombSquadModel ScriptModelClearAnim();
  }

  removeUplinkFromLevelList(self);

  self StopLoopSound();
}

#using_animtree("animated_props");

playUplinkAnimations(playOpenAnim) {
  self endon("emp_damage");
  self endon("death");
  self endon("carried");

  if(playOpenAnim) {
    waitTime = GetNotetrackTimes( % Satcom_killStreak, "stop anim");
    animLength = GetAnimLength( % Satcom_killStreak);

    self ScriptModelPlayAnim("Satcom_killStreak");
    if(isDefined(self.bombSquadModel)) {
      self.bombSquadModel ScriptModelPlayAnim("Satcom_killStreak");
    }

    wait(waitTime[0] * animLength);
  }

  self ScriptModelPlayAnim("Satcom_killStreak_idle");
  if(isDefined(self.bombSquadModel)) {
    self.bombSquadModel ScriptModelPlayAnim("Satcom_killStreak_idle");
  }

  self thread maps\mp\gametypes\_weapons::doBlinkingLight("tag_fx");
}

onDestroyed(streakName, attacker, owner, sMeansOfDeath) {
  attacker notify("destroyed_equipment");
}

onDeath(streakName, attacker, owner, sMeansOfDeath) {
  self maps\mp\gametypes\_weapons::stopBlinkingLight();

  self maps\mp\gametypes\_weapons::equipmentDeathVfx();

  removeUplinkFromLevelList(self);

  self ScriptModelClearAnim();

  if(!self.immediateDeath) {
    wait(3.0);
  }

  self maps\mp\gametypes\_weapons::equipmentDeleteVfx();
}

addUplinkToLevelList(obj) {
  entNum = obj GetEntityNumber();
  level.uplinks[entNum] = obj;
  level notify("update_uplink");
}

removeUplinkFromLevelList(obj) {
  entNum = obj GetEntityNumber();
  level.uplinks[entNum] = undefined;
  level notify("update_uplink");
}

getRadarStrengthForTeam(team) {
  currentRadarStrength = 0;

  foreach(satellite in level.uplinks) {
    if(isDefined(satellite) && (satellite.team == team)) {
      currentRadarStrength++;
    }
  }

  if(currentRadarStrength == 0 &&
    isDefined(level.heliSniperEyesOn) &&
    level.heliSniperEyesOn.team == team
  ) {
    currentRadarStrength++;
  }

  return clamp(currentRadarStrength, CONST_UPLINK_MIN, CONST_UPLINK_MAX);
}

getRadarStrengthForPlayer(player) {
  currentRadarStrength = 0;

  foreach(satellite in level.uplinks) {
    if(isDefined(satellite)) {
      if(isDefined(satellite.owner)) {
        if(satellite.owner.guid == player.guid) {
          currentRadarStrength++;
        }
      } else {
        entNum = satellite GetEntityNumber();
        level.uplinks[entNum] = undefined;
      }
    }
  }

  if(!level.teamBased && currentRadarStrength > 0) {
    currentRadarStrength++;
  }

  return clamp(currentRadarStrength, CONST_UPLINK_MIN, CONST_UPLINK_MAX);
}

getRadarStrengthForComExp(player) {
  currentRadarStrength = 0;

  foreach(satellite in level.uplinks) {
    if(isDefined(satellite)) {
      currentRadarStrength++;
    }
  }

  if(!level.teamBased && currentRadarStrength > 0) {
    currentRadarStrength++;
  }

  return clamp(currentRadarStrength, CONST_UPLINK_MIN, CONST_UPLINK_MAX);
}

uplink_override_moving_platform_death(data) {
  self.immediateDeath = true;
  self notify("death");
}

watchEMPDamage() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self maps\mp\gametypes\_weapons::equipmentEmpStunVfx();

    self stopUplink();

    wait(duration);

    self startUplink(false);
  }
}

uplinkUpdateEyesOn() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    eyesOn = (isDefined(player.shouldBeEyesOn) && player.shouldBeEyesOn);
    player SetEyesOnUplinkEnabled(eyesOn);
  }
}