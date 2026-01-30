/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_emp.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level._effect["emp_third_person_sparks"] = LoadFX("vfx/explosion/electrical_sparks_small_emp_runner");

  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      level.teamEMPed[level.teamNameList[i]] = false;
    }
  } else {
    level.teamEMPed["allies"] = false;
    level.teamEMPed["axis"] = false;
  }
  level.empOwner = undefined;
  level.empPlayer = undefined;
  level.empStreaksDisabled = false;
  level.empEquipmentDisabled = false;
  level.empAssistPoints = false;
  level.empExoDisabled = false;
  level.empTimeRemaining = 0;

  level thread EMP_PlayerTracker();

  level.killstreakFuncs["emp"] = ::EMP_Use;

  level thread onPlayerConnect();

  SetDevDvarIfUninitialized("scr_emp_timeout", 60.0);
  SetDevDvarIfUninitialized("scr_emp_damage_debug", 0);
}

getModuleLineEMP(modules) {
  empStreaksDisabled = array_contains(modules, "emp_streak_kill");
  empEquipmentDisabled = array_contains(modules, "emp_equipment_kill");
  empExoDisabled = array_contains(modules, "emp_exo_kill");

  if(!empStreaksDisabled && !empEquipmentDisabled && !empExoDisabled) {
    return "_01";
  }

  if(empStreaksDisabled && !empEquipmentDisabled && !empExoDisabled) {
    return "_02";
  }

  if(!empStreaksDisabled && empEquipmentDisabled && !empExoDisabled) {
    return "_03";
  }

  if(!empStreaksDisabled && !empEquipmentDisabled && empExoDisabled) {
    return "_04";
  }

  if(empStreaksDisabled && empEquipmentDisabled && !empExoDisabled) {
    return "_05";
  }

  if(empStreaksDisabled && !empEquipmentDisabled && empExoDisabled) {
    return "_06";
  }

  if(!empStreaksDisabled && empEquipmentDisabled && empExoDisabled) {
    return "_07";
  }

  return "_08";
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    if(isSystemHacked() && !self _hasPerk("specialty_empimmune")) {
      self applyEMP();
    }

    self waittill("death");

    if(self.team == "spectator" || self isSystemHacked()) {
      self removeEMP();
    }
  }
}

isSystemHacked() {
  return ((level.teamBased && level.teamEMPed[self.team]) || (!level.teamBased && isDefined(level.empPlayer) && level.empPlayer != self));
}

applyEMP(result) {
  HUDtext = 2;

  if(level.empExoDisabled) {
    HUDtext = 1;

    if(isAugmentedGameMode()) {
      self playerAllowHighJump(false, "emp");
      self playerAllowHighJumpDrop(false, "emp");
      self playerAllowBoostJump(false, "emp");
      self playerAllowPowerSlide(false, "emp");
      self playerAllowDodge(false, "emp");
    }
  }

  self.empScrambleId = maps\mp\gametypes\_scrambler::playerSetHUDEmpScrambled(level.empEndTime, HUDtext, "emp");
  self DigitalDistortSetMaterial("digital_distort_mp");
  self DigitalDistortSetParams(1.0, 1.0);

  self.empOn = true;
  self notify("applyEMPkillstreak");
  self setEMPJammed(true, level.empEquipmentDisabled);

  if(isDefined(result) && (result == "emp_update")) {
    self PlaySoundToPlayer("emp_system_hacked", self);
  }

  self thread dynamicDistortion();
  self thread playerDelayStartSparksEffect();
}

playerDelayStartSparksEffect() {
  self endon("death");
  self endon("disconnect");
  level endon("emp_update");

  if(!isDefined(self.costume)) {
    self waittill("player_model_set");
  }

  if(!isDefined(self.empFX)) {
    self.empFX = SpawnLinkedFx(getfx("emp_third_person_sparks"), self, "j_shoulder_ri");
    TriggerFX(self.empFX);
    SetFXKillOnDelete(self.empFX, true);
  }
}

dynamicDistortion() {
  self notify("dynamicDistortion");

  self endon("death");
  self endon("disconnect");
  self endon("dynamicDistortion");

  wait(0.1);

  fadeTime = 0;
  maxIntensity = 0.55;
  minIntensity = 0.2;
  intensityRange = maxIntensity - minIntensity;
  increment = 0.2;
  empDuration = ((level.empEndTime - gettime()) / 1000) - 0.2;

  while(fadeTime < empDuration) {
    if(isDefined(self.empOn) && !self.empOn) {
      break;
    }

    currentIntensity = (empDuration - fadeTime) / (empDuration);
    self DigitalDistortSetParams((currentIntensity * intensityRange) + minIntensity, 1.0);

    fadeTime += increment;
    wait(increment);
  }

  self DigitalDistortSetParams(0.0, 0.0);
}

removeEMP(result) {
  if(isAugmentedGameMode()) {
    self playerAllowHighJump(true, "emp");
    self playerAllowHighJumpDrop(true, "emp");
    self playerAllowBoostJump(true, "emp");
    self playerAllowPowerSlide(true, "emp");
    self playerAllowDodge(true, "emp");
  }

  if(isDefined(self.empScrambleId)) {
    maps\mp\gametypes\_scrambler::playerSetHUDEmpScrambledOff(self.empScrambleId);
    self.empScrambleId = undefined;
  } else if(self.team == "spectator") {
    self SetClientOmnvar("ui_exo_reboot_end_time", 0);
    self SetClientOmnvar("ui_exo_reboot_type", 0);
  }

  self DigitalDistortSetParams(0.0, 0.0);

  self.empOn = undefined;
  self notify("removeEMPkillstreak");
  self SetEMPJammed(false);

  if(isDefined(result) && (result == "emp_update")) {
    self PlaySoundToPlayer("emp_system_reboot", self);
  }

  if(isDefined(self.empFX)) {
    self.empFX Delete();
  }
}

EMP_Use(lifeId, modules) {
  assert(isDefined(self));

  myTeam = self.pers["team"];

  if(level.teamBased) {
    otherTeam = level.otherTeam[myTeam];
    self thread EMP_JamTeam(otherTeam, modules);
  } else {
    self thread EMP_JamPlayers(self, modules);
  }

  self maps\mp\_matchdata::logKillstreakEvent("emp", self.origin);
  self maps\mp\gametypes\_missions::processChallenge("ch_streak_emp", 1);

  return true;
}

EMP_GetTimeoutFromModules(modules) {
  timeoutVal = 20.0;
  if(array_contains(modules, "emp_time_1") && array_contains(modules, "emp_time_2")) {
    timeoutVal = 40.0;
  } else if(array_contains(modules, "emp_time_1") || array_contains(modules, "emp_time_2")) {
    timeoutVal = 30.0;
  }
  if(isDefined(level.isHorde) && level.isHorde) {
    return 60.0;
  }

  return timeoutVal;
}

EMP_Artifacts(time) {
  self endon("disconnect");

  self notify("EMP_Artifacts");
  self endon("EMP_Artifacts");

  self SetClientOmnvar("ui_hud_static", 2);

  wait time;

  self SetClientOmnvar("ui_hud_static", 0);
}

EMP_JamTeam(teamName, modules) {
  level endon("game_ended");

  assert(teamName == "allies" || teamName == "axis");

  if(!isDefined(level.isHorde)) {
    thread teamPlayerCardSplash("used_emp", self);
  }

  level notify("EMP_JamTeam" + teamName);
  level endon("EMP_JamTeam" + teamName);

  level.empOwner = self;

  timeoutVal = EMP_GetTimeoutFromModules(modules);

  foreach(player in level.players) {
    player playLocalSound("emp_big_activate");

    if(player.team != teamName) {
      continue;
    }

    if(player _hasPerk("specialty_empimmune")) {
      continue;
    }

    if(player _hasPerk("specialty_localjammer")) {
      player SetMotionTrackerVisible(true);
    }

    player thread EMP_Artifacts(timeoutVal);
  }

  VisionSetNaked("coup_sunblind", 0.1);

  if(array_contains(modules, "emp_flash")) {
    foreach(player in level.players) {
      if(player.team != teamName || !isReallyAlive(player) || isDefined(player.usingRemote)) {
        continue;
      }

      if(player _hasPerk("specialty_empimmune")) {
        continue;
      }

      player thread maps\mp\_flashgrenades::applyFlash(2.5, 0.75);
    }
  }

  wait(0.1);

  VisionSetNaked("coup_sunblind", 0);
  if(isDefined(level.nukeDetonated)) {
    VisionSetNaked(level.nukeVisionSet, 3.0);
  } else {
    VisionSetNaked("", 3.0);
  }

  level.teamEMPed[teamName] = true;

  level.empStreaksDisabled = array_contains(modules, "emp_streak_kill");
  level.empEquipmentDisabled = array_contains(modules, "emp_equipment_kill");
  level.empAssistPoints = array_contains(modules, "emp_assist");
  level.empExoDisabled = array_contains(modules, "emp_exo_kill");

  level notify("emp_update");

  level.empEndTime = getTime() + int(timeoutVal * 1000);

  if(level.empStreaksDisabled) {
    level destroyActiveStreakVehicles(self, teamName);
  }

  if(level.empEquipmentDisabled) {
    level destroyActiveEquipmentVehicles(self, teamName);
  }

  level thread keepEMPTimeRemaining(timeoutVal);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeoutVal);

  level.teamEMPed[teamName] = false;

  foreach(player in level.players) {
    if(player.team != teamName) {
      continue;
    }

    if(player _hasPerk("specialty_localjammer")) {
      player SetMotionTrackerVisible(false);
    }
  }

  level.empOwner = undefined;
  level.empStreaksDisabled = false;
  level.empEquipmentDisabled = false;
  level.empAssistPoints = false;
  level.empExoDisabled = false;

  level notify("emp_update");
}

EMP_JamPlayers(owner, modules) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");

  assert(isDefined(owner));
  level.empOwner = owner;

  timeoutVal = EMP_GetTimeoutFromModules(modules);

  foreach(player in level.players) {
    player playLocalSound("emp_big_activate");

    if(player == owner) {
      continue;
    }

    if(player _hasPerk("specialty_localjammer")) {
      player SetMotionTrackerVisible(true);
    }

    player thread EMP_Artifacts(timeoutVal);
  }

  VisionSetNaked("coup_sunblind", 0.1);

  if(array_contains(modules, "emp_flash")) {
    foreach(player in level.players) {
      if(player == owner || !isReallyAlive(player) || isDefined(player.usingRemote)) {
        continue;
      }

      player thread maps\mp\_flashgrenades::applyFlash(2.5, 0.75);
    }
  }

  wait(0.1);

  VisionSetNaked("coup_sunblind", 0);
  if(isDefined(level.nukeDetonated)) {
    VisionSetNaked(level.nukeVisionSet, 3.0);
  } else {
    VisionSetNaked("", 3.0);
  }

  level notify("emp_update");

  level.empPlayer = owner;
  level.empPlayer thread empPlayerFFADisconnect();

  level.empStreaksDisabled = array_contains(modules, "emp_streak_kill");
  level.empEquipmentDisabled = array_contains(modules, "emp_equipment_kill");
  level.empAssistPoints = array_contains(modules, "emp_assist");
  level.empExoDisabled = array_contains(modules, "emp_exo_kill");
  level.empEndTime = getTime() + int(timeoutVal * 1000);

  if(level.empStreaksDisabled) {
    level destroyActiveStreakVehicles(owner);
  }

  if(level.empEquipmentDisabled) {
    level destroyActiveEquipmentVehicles(owner);
  }

  level notify("emp_update");

  level thread keepEMPTimeRemaining(timeoutVal);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeoutVal);

  foreach(player in level.players) {
    if(player == owner) {
      continue;
    }

    if(player _hasPerk("specialty_localjammer")) {
      player SetMotionTrackerVisible(false);
    }
  }

  level.empPlayer = undefined;
  level.empOwner = undefined;
  level.empStreaksDisabled = false;
  level.empEquipmentDisabled = false;
  level.empAssistPoints = false;
  level.empExoDisabled = false;

  level notify("emp_update");
  level notify("emp_ended");
}

keepEMPTimeRemaining(timeoutVal) {
  level notify("keepEMPTimeRemaining");
  level endon("keepEMPTimeRemaining");

  level endon("emp_ended");

  level.empTimeRemaining = int(timeoutVal);
  while(level.empTimeRemaining) {
    wait(1.0);
    level.empTimeRemaining--;
  }
}

empPlayerFFADisconnect() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");

  self waittill("disconnect");
  level notify("emp_update");
}

EMP_PlayerTracker() {
  for(;;) {
    result = level waittill_any_return_no_endon_death("joined_team", "emp_update", "game_ended");

    foreach(player in level.players) {
      if(player.team == "spectator") {
        spectatingPlayer = player GetSpectatingPlayer();
        if(!isDefined(spectatingPlayer) || !spectatingPlayer isSystemHacked()) {
          player removeEMP(result);
        }
        continue;
      }

      if(player _hasPerk("specialty_empimmune")) {
        continue;
      }

      if(isReallyAlive(player) && player isSystemHacked() && !level.gameEnded) {
        player applyEMP(result);
      } else {
        player removeEMP(result);
      }
    }

    if(level.gameEnded) {
      return;
    }
  }
}

destroyActiveVehicles(attacker, teamEMPed) {
  thread destroyActiveStreakVehicles(attacker, teamEMPed);
  thread destroyActiveEquipmentVehicles(attacker, teamEMPed);
}

destroyActiveStreakVehicles(attacker, teamEMPed) {
  thread destroyActiveHelis(attacker, teamEMPed);
  thread destroyActiveLittleBirds(attacker, teamEMPed);
  thread destroyActiveTurrets(attacker, teamEMPed);
  thread destroyActiveRockets(attacker, teamEMPed);
  thread destroyActiveUAVs(attacker, teamEMPed);
  thread destroyActiveUGVs(attacker, teamEMPed);
  thread destroyActiveOrbitalLasers(attacker, teamEMPed);
  thread destroyActiveGoliaths(attacker, teamEMPed);
}

destroyActiveEquipmentVehicles(attacker, teamEMPed) {
  thread destroyActiveDrones(attacker, teamEMPed);
}

destroyEMPObjectsInRadius(attacker, teamEMPed, empOrigin, empRadius) {
  thread destroyActiveHelis(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveLittleBirds(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveTurrets(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveRockets(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveUAVs(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveUGVs(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveOrbitalLasers(attacker, teamEMPed, empOrigin, empRadius);
  thread destroyActiveDrones(attacker, teamEMPed, empOrigin, empRadius);
}

destroyActiveHelis(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  activeHelis = level.helis;

  if(isDefined(level.orbitalsupport_planemodel)) {
    activeHelis[activeHelis.size] = level.orbitalsupport_planemodel;
  }

  foreach(heli in activeHelis) {
    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(heli.team) && heli.team != teamEMPed) {
        continue;
      }
    } else {
      if(isDefined(heli.owner) && heli.owner == attacker) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(heli.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    damage = heli.maxhealth + 1;

    heli DoDamage(damage, heli.origin, attacker, attacker, meansOfDeath, weapon);

    wait(0.05);
  }
}

destroyActiveLittleBirds(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  thingsToKill = array_combine(level.planes, level.littleBirds);

  foreach(drone in level.carepackageDrones) {
    if(isDefined(drone.crate)) {
      thingsToKill[thingsToKill.size] = drone.crate;
    }
  }

  foreach(lb in thingsToKill) {
    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(lb.team) && lb.team != teamEMPed) {
        continue;
      }
    } else {
      if(isDefined(lb.owner) && lb.owner == attacker) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(lb.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    damage = lb.maxhealth + 1;

    if(isDefined(lb.crateType)) {
      lb = lb.enemyModel;
    }

    lb DoDamage(damage, lb.origin, attacker, attacker, meansOfDeath, weapon);

    wait(0.05);
  }
}

destroyActiveTurrets(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  foreach(turret in level.turrets) {
    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(turret.team) && turret.team != teamEMPed) {
        continue;
      }
    } else {
      if(isDefined(turret.owner) && turret.owner == attacker) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(turret.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    damage = turret.maxhealth + 1;

    turret DoDamage(damage, turret.origin, attacker, attacker, meansOfDeath, weapon);
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    foreach(player in level.players) {
      if(isDefined(player.isCarrying) && player.isCarrying) {
        player notify("force_cancel_placement");
      }
    }
  }
}

destroyActiveRockets(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  foreach(rocket in level.rockets) {
    if(isDefined(rocket.weaponName) && skipRocketEMP(rocket.weaponName)) {
      continue;
    }

    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(rocket.team) && rocket.team != teamEMPed) {
        continue;
      }
    } else {
      if(isDefined(rocket.owner) && rocket.owner == attacker) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(rocket.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    if(shouldDamageRocket(rocket)) {
      damage = rocket.maxhealth + 1;
      rocket DoDamage(damage, rocket.origin, attacker, attacker, meansOfDeath, weapon);
    } else {
      playFX(level.remotemissile_fx["explode"], rocket.origin);
      rocket delete();
    }

    wait(0.05);
  }
}

shouldDamageRocket(rocket) {
  return isDefined(rocket.damageCallback);
}

skipRocketEMP(weaponName) {
  return (weaponName == "orbital_carepackage_pod_mp");
}

destroyActiveUAVs(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  uavArray = level.uavModels;

  if(level.teamBased && isDefined(teamEMPed)) {
    uavArray = level.uavModels[teamEMPed];
  }

  foreach(uav in uavArray) {
    if(level.teamBased && isDefined(teamEMPed)) {} else {
      if(isDefined(uav.owner) && uav.owner == attacker) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(uav.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    damage = uav.maxhealth + 1;

    uav DoDamage(damage, uav.origin, attacker, attacker, meansOfDeath, weapon);

    wait(0.05);
  }
}

destroyActiveUGVs(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  foreach(ugv in level.ugvs) {
    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(ugv.team) && ugv.team != teamEMPed) {
        continue;
      }
    } else {
      if(isDefined(ugv.owner) && ugv.owner == attacker) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(ugv.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    damage = ugv.maxhealth + 1;

    ugv DoDamage(damage, ugv.origin, attacker, attacker, meansOfDeath, weapon);

    wait(0.05);
  }
}

destroyActiveDrones(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";
  damage = 5000;

  droneList = array_combine(level.trackingDrones, level.explosiveDrones);

  foreach(activeDrone in droneList) {
    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(activeDrone.team) && (activeDrone.team != teamEMPed)) {
        continue;
      }
    } else {
      if(isDefined(activeDrone.owner) && (activeDrone.owner == attacker)) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(activeDrone.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    damage = activeDrone.maxhealth + 1;

    activeDrone DoDamage(damage, activeDrone.origin, attacker, attacker, meansOfDeath, weapon);
  }

  foreach(grenade in level.grenades) {
    if(!isDefined(grenade.weaponName) || !IsSubStr(grenade.weaponName, "explosive_drone_mp")) {
      continue;
    }

    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(grenade.team) && (grenade.team != teamEMPed)) {
        continue;
      }
    } else {
      if(isDefined(grenade.owner) && (grenade.owner == attacker)) {
        continue;
      }
    }

    if(isDefined(empOrigin) && isDefined(empRadius)) {
      point = empOrigin;
      if(DistanceSquared(grenade.origin, empOrigin) > (empRadius * empRadius)) {
        continue;
      }
    }

    grenade thread maps\mp\_explosive_drone::explosiveGrenadeDeath();
  }
}

destroyActiveOrbitalLasers(attacker, teamEMPed, empOrigin, empRadius) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "killstreak_emp_mp";

  damage = 5000;
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelName = "";
  tagName = "";
  partName = "";
  iDFlags = undefined;

  foreach(laser in level.orbital_lasers) {
    if(level.teamBased && isDefined(teamEMPed)) {
      if(isDefined(laser.team) && laser.team != teamEMPed) {
        continue;
      }
    } else {
      if(isDefined(laser.owner) && laser.owner == attacker) {
        continue;
      }
    }

    laser notify("death", attacker, meansOfDeath, weapon);

    wait(0.05);
  }
}

destroyActiveGoliaths(attacker, teamEMPed) {
  foreach(player in level.players) {
    if(player isJuggernaut()) {
      if(level.teamBased && isDefined(teamEMPed)) {
        if(isDefined(player.team) && player.team != teamEMPed) {
          continue;
        }
      }

      if(isDefined(level.isHorde) && level.isHorde) {
        player maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
        playFX(getfx("goliath_self_destruct"), player.origin, AnglesToUp(player.angles));
        player thread[[level.hordeHandleJuggDeath]]();
      } else {
        player thread maps\mp\killstreaks\_juggernaut::playerKillHeavyExo(player.origin, attacker, "MOD_EXPLOSIVE", "killstreak_goliathsd_mp");
      }
    }
  }
}

drawEMPDamageOrigin(pos, ang, radius) {
  while(GetDvarInt("scr_emp_damage_debug")) {
    Line(pos, pos + (anglesToForward(ang) * radius), (1, 0, 0));
    Line(pos, pos + (AnglesToRight(ang) * radius), (0, 1, 0));
    Line(pos, pos + (AnglesToUp(ang) * radius), (0, 0, 1));

    Line(pos, pos - (anglesToForward(ang) * radius), (1, 0, 0));
    Line(pos, pos - (AnglesToRight(ang) * radius), (0, 1, 0));
    Line(pos, pos - (AnglesToUp(ang) * radius), (0, 0, 1));

    wait(0.05);
  }
}
# /