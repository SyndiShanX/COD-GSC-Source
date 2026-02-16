/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_warbird.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_audio;

CONST_rocket_reload_time = 6;
CONST_rocket_fire_interval = 0.05;
CONST_WARBIRD_RELOAD_MASH_TIME_RATIO = (50 / CONST_rocket_reload_time);

CONST_target_aquire_time = 1;
CONST_los_recheck_time = 0.25;
CONST_warbird_move_time_min = 4;
CONST_warbird_move_time_max = 8;

CONST_warbird_timeout = 30;
CONST_warbird_timeout_upgrade = 45;

CONST_cloak_duration = 10;
CONST_cloak_cooldown_min_duration = 5;

CONST_second_warbird_height = 500;

init() {
  level.warbirdSetting = [];
  level.warbirdSetting["Warbird"] = spawnStruct();
  level.warbirdSetting["Warbird"].vehicle = "warbird_player_mp";
  level.warbirdSetting["Warbird"].modelBase = "vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak";
  level.warbirdSetting["Warbird"].heliType = "warbird";
  level.warbirdSetting["Warbird"].maxHealth = level.heli_maxhealth;

  level.killstreakFuncs["warbird"] = ::tryUseWarbird;

  level.killstreakWieldWeapons["warbird_remote_turret_mp"] = "warbird";
  level.killstreakWieldWeapons["warbird_player_turret_mp"] = "warbird";
  level.killstreakWieldWeapons["warbird_missile_mp"] = "warbird";
  level.killstreakWieldWeapons["paint_missile_killstreak_mp"] = "warbird";

  if(!isDefined(level.SpawnedWarbirds)) {
    level.SpawnedWarbirds = [];
  }

  if(!isDefined(level.warbirdInUse)) {
    level.warbirdInUse = false;
  }

  level.chopper_fx["light"]["warbird"] = LoadFX("vfx/lights/air_light_wingtip_red");
  level.chopper_fx["engine"]["warbird"] = LoadFX("vfx/distortion/distortion_warbird_mp");

  maps\mp\killstreaks\_aerial_utility::makeHeliType("warbird", "vfx/explosion/vehicle_warbird_explosion_midair", ::warbirdLightFX);
  maps\mp\killstreaks\_aerial_utility::addAirExplosion("warbird", "vfx/explosion/vehicle_warbird_explosion_midair");

  SetDvarIfUninitialized("scr_player_notarget", 0);
  SetDvarIfUninitialized("scr_warbird_timeout", 0);
  SetDvarIfUninitialized("scr_warbird_testcloak", 0);

  game["dialog"]["assist_mp_warbird"] = "ks_warbird_joinreq";
  game["dialog"]["pilot_sup_mp_warbird"] = "pilot_sup_mp_warbird";
  game["dialog"]["pilot_aslt_mp_warbird"] = "pilot_aslt_mp_warbird";
  game["dialog"]["ks_warbird_destroyed"] = "ks_warbird_destroyed";
}

tryUseWarbird(lifeId, modules) {
  if(!self CanUseWarbird()) {
    self IPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + 1 >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"MP_TOO_MANY_VEHICLES");
    return false;
  }

  incrementFauxVehicleCount();
  level.warbirdInUse = true;

  hasAIOption = array_contains(modules, "warbird_ai_attack") || array_contains(modules, "warbird_ai_follow");
  if(!hasAIOption) {
    self thread playerClearWarbirdOnTeamChange();
    result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak("warbird");
    if(result != "success") {
      decrementFauxVehicleCount();
      level.warbirdInUse = false;
      return false;
    }
    self setUsingRemote("warbird");
  }

  result = self SetupWarbirdKillStreak(lifeId, modules);

  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent("warbird", self.origin);
  }

  return result;
}

playerClearWarbirdOnTeamChange() {
  self endon("rideKillstreakBlack");
  self endon("rideKillstreakFailed");

  self waittill("joined_team");

  level.warbirdInUse = false;
  decrementFauxVehicleCount();
}

CanUseWarbird() {
  return (!level.warbirdInUse);
}

IsControllingWarbird() {
  return (isDefined(self.ControllingWarbird) && self.ControllingWarbird);
}

warbirdMakeVehicleSolidCapsule() {
  self endon("death");

  waitframe();

  self MakeVehicleSolidCapsule(300, -9, 160);
}

setupPlayerCommands(modules) {
  if(IsBot(self)) {
    return;
  }

  self NotifyOnPlayerCommand("SwitchVisionMode", "+actionslot 1");
  self NotifyOnPlayerCommand("SwitchWeapon", "weapnext");
  self NotifyOnPlayerCommand("ToggleControlState", "+activate");
  self NotifyOnPlayerCommand("ToggleControlCancel", "-activate");
  self NotifyOnPlayerCommand("ToggleControlState", "+usereload");
  self NotifyOnPlayerCommand("ToggleControlCancel", "-usereload");
  self NotifyOnPlayerCommand("StartFire", "+attack");
  self NotifyOnPlayerCommand("StartFire", "+attack_akimbo_accessible");
  if(isDefined(modules) && array_contains(modules, "warbird_cloak")) {
    self NotifyOnPlayerCommand("Cloak", "+smoke");
  }
}

disablePlayercommands(warbird) {
  if(IsBot(self)) {
    return;
  }

  self NotifyOnPlayerCommandRemove("SwitchVisionMode", "+actionslot 1");
  self NotifyOnPlayerCommandRemove("SwitchWeapon", "weapnext");
  self NotifyOnPlayerCommandRemove("ToggleControlState", "+activate");
  self NotifyOnPlayerCommandRemove("ToggleControlCancel", "-activate");
  self NotifyOnPlayerCommandRemove("ToggleControlState", "+usereload");
  self NotifyOnPlayerCommandRemove("ToggleControlCancel", "-usereload");
  self NotifyOnPlayerCommandRemove("StartFire", "+attack");
  self NotifyOnPlayerCommandRemove("StartFire", "+attack_akimbo_accessible");
  if(isDefined(warbird) && warbird.canCloak) {
    self NotifyOnPlayerCommandRemove("Cloak", "+smoke");
  }
}

SetupWarbirdKillStreak(lifeId, modules) {
  self endon("warbirdStreakComplete");

  self setupPlayerCommands(modules);

  self.PossessWarbird = false;
  self.ControllingWarbird = false;
  self.WarbirdInit = true;

  flightPathNodes = BuildValidFlightPaths();
  SpawnPoint = FindBestSpawnLocation(flightPathNodes);
  SpawnPoint = RotateHelispawn(SpawnPoint);

  warbird = SpawnHelicopter(self, SpawnPoint.origin, SpawnPoint.angles, level.warbirdSetting["Warbird"].vehicle, level.warbirdSetting["Warbird"].modelBase);
  warbird.currentNode = SpawnPoint;

  if(!isDefined(warbird)) {
    return false;
  }

  warbird thread warbird_audio();
  warbird Hide();

  warbird thread warbirdMakeVehicleSolidCapsule();

  warbird.TargetEnt = spawn("script_origin", (0, 0, 0));

  warbird.vehicleType = "Warbird";
  warbird.heli_type = level.warbirdSetting["Warbird"].heliType;
  warbird.heliType = level.warbirdSetting["Warbird"].heliType;
  warbird.attractor = Missile_CreateAttractorEnt(warbird, level.heli_attract_strength, level.heli_attract_range);
  warbird.lifeId = lifeId;
  warbird.team = self.pers["team"];
  warbird.pers["team"] = self.pers["team"];
  warbird.owner = self;
  warbird.maxhealth = level.warbirdSetting["Warbird"].maxHealth;
  warbird.zOffset = (0, 0, 0);
  warbird.targeting_delay = level.heli_targeting_delay;
  warbird.primaryTarget = undefined;
  warbird.secondaryTarget = undefined;
  warbird.attacker = undefined;
  warbird.currentstate = "ok";
  warbird.pickNewTarget = true;
  warbird.lineOfSight = false;
  warbird.overheattime = 6;
  warbird.firetime = 0;
  warbird.weaponfire = false;
  warbird.IsMoving = true;
  warbird.CloakCooldown = 0;
  warbird.isCrashing = false;
  warbird.IsPossessed = false;
  warbird.modules = modules;
  warbird.aiAttack = array_contains(warbird.modules, "warbird_ai_attack");
  warbird.aiFollow = array_contains(warbird.modules, "warbird_ai_follow");
  warbird.hasAI = (warbird.aiAttack || warbird.aiFollow);
  warbird.canCloak = array_contains(warbird.modules, "warbird_cloak");
  warbird.hasRockets = array_contains(warbird.modules, "warbird_rockets");
  warbird.coopOffensive = array_contains(warbird.modules, "warbird_coop_offensive");
  warbird.extraFlare = array_contains(warbird.modules, "warbird_flares");

  if(warbird.extraFlare) {
    warbird.numExtraFlares = 1;
  } else {
    warbird.numExtraFlares = 0;
  }

  if(warbird.hasRockets) {
    warbird.RocketClip = 3;
  } else {
    warbird.RocketClip = 0;
  }
  warbird.RemainingRocketShots = warbird.RocketClip;

  if(warbird.hasAI) {
    warbird.UsableEnt = spawn("script_origin", (0, 0, 0));
    warbird.UsableEnt LinkTo(warbird);
    warbird.UsableEnt makeGloballyUsableByType("killstreakRemote", &"MP_WARBIRD_PLAYER_PROMPT", self);
  }

  warbird thread[[level.lightFxFunc["warbird"]]]();

  warbird make_entity_sentient_mp(warbird.team);

  if(!isDefined(level.SpawnedWarbirds)) {
    level.SpawnedWarbirds = [];
  }

  level.SpawnedWarbirds = array_add(level.SpawnedWarbirds, warbird);

  warbird maps\mp\killstreaks\_aerial_utility::addToHeliList();
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor(warbird.numExtraFlares);
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_disconnect(self);
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_changeTeams(self);
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_gameended(self);

  lifeSpan = CONST_warbird_timeout;
  if(array_contains(warbird.modules, "warbird_time")) {
    lifeSpan = CONST_warbird_timeout_upgrade;
  }

  if(self _hasPerk("specialty_blackbox") && isDefined(self.specialty_blackbox_bonus)) {
    lifeSpan *= self.specialty_blackbox_bonus;
  }

  if(getDvar("scr_warbird_timeout", "0") != "0") {
    lifeSpan = GetDvarFloat("scr_warbird_timeout");
  }

  warbird.endTime = GetTime() + (lifeSpan * 1000);
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_timeout(lifeSpan);
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_monitorEMP();
  warbird thread maps\mp\gametypes\_damage::setEntityDamageCallback(warbird.maxhealth, undefined, ::warbirdOnDeath, maps\mp\killstreaks\_aerial_utility::heli_ModifyDamage, true);
  warbird thread warbird_health();
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_existance();

  self thread MonitorAIWarbirdDeathorTimeout(warbird);
  self thread MonitorPlayerDisconnect(warbird);

  warbird.warbirdTurret = warbird spawn_warbird_turret("warbird_remote_turret_mp", "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_player_mp", false);
  warbird.warbirdTurret Hide();
  if(!warbird.aiAttack && !warbird.aiFollow) {
    warbird.warbirdTurret ShowToPlayer(self);
  }

  buddyTurretWeaponInfo = "orbitalsupport_big_turret_mp";

  if(warbird.coopOffensive) {
    buddyTurretWeaponInfo = "warbird_remote_turret_mp";
  }

  warbird.warbirdBuddyTurret = warbird spawn_warbird_turret(buddyTurretWeaponInfo, "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_playerbuddy_mp", true);
  warbird.warbirdBuddyTurret Hide();

  self thread SetupCloaking(warbird);
  thread WarbirdOverheatBarColorMonitor(warbird, warbird.warbirdTurret);

  if(warbird.aiAttack || warbird.aiFollow) {
    self thread playerMonitorWarbirdPossession(warbird);
  } else {
    self thread PlayerControlWarbirdSetup(warbird);
  }

  thread testFlares(self);

  if(isDefined(warbird)) {
    if(level.teamBased) {
      level thread handleCoopJoining(warbird, self);
    }

    return true;
  } else {
    return false;
  }
}

playerMonitorWarbirdPossession(warbird) {
  self endon("warbirdStreakComplete");

  warbird waittill("cloaked");
  waitframe();

  while(true) {
    self MonitorAIWarbirdSwitch(warbird);

    warbird.UsableEnt waittill("trigger");

    self thread manuallyJoinWarbird();
    self PlayerControlWarbirdSetup(warbird);
  }
}

manuallyJoinWarbird() {
  self.manuallyJoiningKillStreak = true;

  self waittill_any("death", "initRideKillstreak_complete", "warbirdStreakComplete");

  self.manuallyJoiningKillStreak = false;
}

warbirdOnDeath(attacker, weapon, meansOfDeath, damage) {
  self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, meansOfDeath, damage, "warbird_destroyed", "ks_warbird_destroyed", "callout_destroyed_warbird", true);
}

SetupCloaking(warbird) {
  warbird.cloakState = 0;
  self CloakingTransition(warbird, true, true);
}

WarbirdRocketHudUpdate(warbird) {
  if(!warbird.hasRockets) {
    return;
  }

  switch (warbird.RemainingRocketShots) {
    case 0:
      self SetClientOmnvar("ui_warbird_missile", 0);
      break;
    case 1:
      self SetClientOmnvar("ui_warbird_missile", 1);
      break;
    case 2:
      self SetClientOmnvar("ui_warbird_missile", 2);
      break;
    case 3:
      self SetClientOmnvar("ui_warbird_missile", 3);
      break;
  }
}

SetupWarbirdHud(warbird, isBuddy, primaryPlayer) {
  self endon("warbirdStreakComplete");
  warbird endon("death");
  self endon("ResumeWarbirdAI");

  if(!isDefined(isBuddy)) {
    isBuddy = false;
  }

  self ForceFirstPersonWhenFollowed();

  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();
  wait(0.05);
  if(isBuddy) {
    self SetClientOmnvar("ui_warbird_toggle", 2);
  } else {
    self SetClientOmnvar("ui_warbird_toggle", 1);
  }
  self maps\mp\killstreaks\_aerial_utility::playerEnableStreakStatic();
  self SetClientOmnvar("ui_warbird_cloak", false);
  self SetClientOmnvar("ui_warbird_countdown", warbird.endTime);
  if(!isBuddy) {
    self WarbirdRocketHudUpdate(warbird);
  }

  if(isBuddy && !warbird.coopOffensive) {
    self SetClientOmnvar("ui_warbird_weapon", 3);
  } else if(isBuddy && warbird.coopOffensive) {
    self SetClientOmnvar("ui_warbird_weapon", 0);
  } else if(warbird.hasRockets) {
    self SetClientOmnvar("ui_warbird_weapon", 1);
  } else {
    self SetClientOmnvar("ui_warbird_weapon", 0);
  }

  if(isBuddy) {
    coop_primary_num = primaryPlayer getEntityNumber();
    self SetClientOmnvar("ui_coop_primary_num", coop_primary_num);
  }

  if(warbird.canCloak && !isBuddy) {
    self SetClientOmnvar("ui_warbird_cloaktext", 1);
  } else {
    self SetClientOmnvar("ui_warbird_cloaktext", 0);
  }

  self SetClientOmnvar("ui_killstreak_optic", false);
}

WarbirdOverheatBarColorMonitor(warbird, warbirdTurret) {
  self endon("warbirdStreakComplete");
  warbird endon("death");

  while(true) {
    warbirdTurret.heat_level = warbirdTurret GetTurretHeat();
    self SetClientOmnvar("ui_warbird_heat", warbirdTurret.heat_level);

    isOverheated = false;
    if(isDefined(warbirdTurret)) {
      isOverheated = warbirdTurret IsTurretOverheated();
    }

    if(isOverheated) {
      self SetClientOmnvar("ui_warbird_fire", 1);
    } else if(warbirdTurret.heat_level > 0.7) {
      self SetClientOmnvar("ui_warbird_fire", 2);
    } else {
      self SetClientOmnvar("ui_warbird_fire", 0);
    }

    while(isOverheated) {
      wait 0.05;
      isOverheated = warbirdTurret IsTurretOverheated();
      warbirdTurret.heat_level = warbirdTurret GetTurretHeat();
      self SetClientOmnvar("ui_warbird_heat", warbirdTurret.heat_level);
    }

    self notify("overheatFinished");

    waitframe();
  }
}

spawn_warbird_turret(turretweaponinfo, modelname, linktotag, isBuddy) {
  spawned_turret = SpawnTurret("misc_turret", self GetTagOrigin(linktotag), turretweaponinfo, false);
  spawned_turret.angles = self GetTagAngles(linktotag);
  spawned_turret setModel(modelname);
  spawned_turret SetDefaultDropPitch(45.0);
  spawned_turret LinkTo(self, linktotag, (0, 0, 0), (0, 0, 0));
  spawned_turret.owner = self.owner;
  spawned_turret.health = 99999;
  spawned_turret.maxHealth = 1000;
  spawned_turret.damageTaken = 0;
  spawned_turret.stunned = false;
  spawned_turret.stunnedTime = 0.0;
  spawned_turret setCanDamage(false);
  spawned_turret setCanRadiusDamage(false);
  spawned_turret.team = self.team;
  spawned_turret.pers["team"] = self.team;
  if(level.teamBased) {
    spawned_turret SetTurretTeam(self.team);
  }
  spawned_turret SetMode("sentry_manual");
  spawned_turret SetSentryOwner(self.owner);
  spawned_turret SetTurretMinimapVisible(false);
  spawned_turret.chopper = self;

  if(isBuddy) {
    spawned_turret.fireSoundent = spawn("script_model", self GetTagOrigin(linktotag));
    spawned_turret.fireSoundent setModel("tag_origin");
    spawned_turret.fireSoundent LinkToSynchronizedParent(self, linktotag, (0, 0, 0), (0, 0, 0));
  }

  return spawned_turret;
}

takeover_warbird_turret_buddy(warbird) {
  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(false);
  }

  warbird.warbirdBuddyTurret.owner = self;
  warbird.warbirdBuddyTurret SetMode("sentry_manual");
  warbird.warbirdBuddyTurret SetSentryOwner(self);

  self PlayerLinkWeaponViewToDelta(warbird.warbirdBuddyTurret, "tag_player", 0, 180, 180, -20, 180, false);
  self PlayerLinkedSetViewZNear(false);
  self PlayerLinkedSetUseBaseAngleForViewClamp(true);

  self RemoteControlTurret(warbird.warbirdBuddyTurret, 45, warbird.angles[1]);
}

FindBestSpawnLocation(AttackPoints) {
  SpawnPoints = get_array_of_closest(self.origin, AttackPoints);
  return SpawnPoints[0];
}

RotateHelispawn(SpawnPoint) {
  MapCenter = maps\mp\killstreaks\_aerial_utility::getHeliAnchor();

  SpawnPointForward = anglesToForward(SpawnPoint.angles);

  VectorToCenter = MapCenter.origin - SpawnPoint.origin;

  NewOrientation = VectorToAngles(VectorToCenter);

  SpawnPoint.angles = NewOrientation;

  return SpawnPoint;
}

BuildValidFlightPaths() {
  self endon("warbirdStreakComplete");

  if(!isDefined(level.warbirdFlightPathNodes)) {
    level.warbirdFlightPathNodes = [];
  } else {
    return level.warbirdFlightPathNodes;
  }

  firstNode = maps\mp\killstreaks\_aerial_utility::getEntOrStruct("heli_loop_start", "targetname");
  prevNode = firstNode;
  warbirdHeight = maps\mp\killstreaks\_aerial_utility::getHeliAnchor();
  heightOriginZ = warbirdHeight.origin[2];

  while(true) {
    nextNode = maps\mp\killstreaks\_aerial_utility::getEntOrStruct(prevNode.target, "targetname");
    prevNode.next = nextNode;
    nextNode.prev = prevNode;
    nextNode.origin = (nextNode.origin[0], nextNode.origin[1], heightOriginZ);
    if(IsInArray(level.warbirdFlightPathNodes, nextNode)) {
      break;
    }

    level.warbirdFlightPathNodes = array_add(level.warbirdFlightPathNodes, nextNode);
    prevNode = nextNode;
  }

  foreach(node in level.warbirdflightPathNodes) {
    Assert(isDefined(node.next));
    assert(isDefined(node.prev));
  }

  return level.warbirdFlightPathNodes;
}

IsInArray(array, Ent) {
  if(isDefined(array)) {
    foreach(Index in array) {
      if(Index == Ent) {
        return true;
      }
    }
  }
  return false;
}

MonitorWarbirdSafeArea(warbird) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  self thread maps\mp\killstreaks\_aerial_utility::playerHandleBoundaryStatic(warbird, "warbirdStreakComplete", "ResumeWarbirdAI");

  warbird waittill("outOfBounds");

  wait 2;
  warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave();
}

WarbirdAIAttack(warbird) {
  self thread WarbirdFire(warbird);
  self thread WarbirdLookAtEnemy(warbird);
  self thread WarbirdMoveToAttackPoint(warbird);
}

WarbirdMoveToAttackPoint(warbird) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");

  baseSpeed = 40;
  warbird Vehicle_SetSpeed(baseSpeed, baseSpeed / 4, baseSpeed / 4);
  warbird SetNearGoalNotifyDist(100);

  nextNode = warbird.currentNode;

  if(!isDefined(nextNode)) {
    SortedNodes = get_array_of_closest(warbird.origin, BuildValidFlightPaths());

    start = warbird.origin;
    for(i = 0; i < SortedNodes.size; i++) {
      end = SortedNodes[i].origin;
      if(maps\mp\killstreaks\_aerial_utility::flyNodeOrgTracePassed(start, end, warbird)) {
        dir = end - start;
        dist = Distance(start, end);
        dirRight = RotateVector(dir, (0, 90, 0));
        startWing = start + (dirRight * 100);
        endWing = startWing + (dir * dist);
        if(maps\mp\killstreaks\_aerial_utility::flyNodeOrgTracePassed(startWing, endWing, warbird)) {
          dirLeft = RotateVector(dir, (0, -90, 0));
          startWing = start + (dirLeft * 100);
          endWing = startWing + (dir * dist);
          if(maps\mp\killstreaks\_aerial_utility::flyNodeOrgTracePassed(startWing, endWing, warbird)) {
            nextNode = SortedNodes[i];
            break;
          }
        }
      }
      waitframe();
    }
  } else {
    nextNode = nextNode.next;
  }

  if(!isDefined(nextNode)) {
    return;
  }

  while(true) {
    stopAtNode = false;
    if(warbird.aiFollow) {
      stopAtNode = true;
    }
    warbird SetVehGoalPos(nextNode.origin, stopAtNode);

    warbird.IsMoving = true;

    warbird waittill("near_goal");

    warbird.currentNode = nextNode;
    warbird.IsMoving = false;

    nextNode = waitUntilMoveReturnNode(warbird);

    warbird.currentNode = undefined;
  }
}

waitUntilMoveReturnNode(warbird) {
  if(warbird.aiFollow && isDefined(warbird.owner)) {
    curNode = warbird.currentNode;
    prevNode = curNode.next;
    nextNode = curNode.prev;
    while(isDefined(warbird.owner)) {
      curDistSq = Distance2DSquared(warbird.owner.origin, curNode.origin);
      prevDistSq = Distance2DSquared(warbird.owner.origin, prevNode.origin);
      nextDistSq = Distance2DSquared(warbird.owner.origin, nextNode.origin);

      if(prevDistSq < curDistSq && prevDistSq < nextDistSq) {
        return prevNode;
      } else if(nextDistSq < curDistSq && nextDistSq < prevDistSq) {
        return nextNode;
      }

      waitframe();
    }
  } else {
    return warbird.currentNode.next;
  }
}

WarbirdLookAtEnemy(warbird) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");

  while(1) {
    if(isDefined(warbird.enemy_target)) {
      MonitorLookAtEnt(warbird);
      warbird.warbirdTurret ClearTargetEntity();
    }

    waitframe();
  }
}

MonitorLookAtEnt(warbird) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");
  warbird endon("pickNewTarget");

  warbird SetLookAtEnt(warbird.enemy_target);
  warbird.warbirdTurret SetTargetEntity(warbird.enemy_target);

  warbird.enemy_target waittill_either("death", "disconnect");
  warbird.pickNewTarget = true;
  warbird.lineOfSight = false;
}

WarbirdFire(warbird) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");

  thread FireAi(warbird);

  while(true) {
    if(warbird.pickNewTarget) {
      allGuys = level.participants;
      enemyTargets = [];

      foreach(guy in allGuys) {
        if(!IsAI(guy) && getDvar("scr_player_notarget", 0) != "0") {
          continue;
        }

        if(guy.team != self.team) {
          enemyTargets = array_add(enemyTargets, guy);
        }
      }

      if(warbird.aiAttack) {
        enemyTargets = SortByDistance(enemyTargets, warbird.origin);
      } else {
        enemyTargets = SortByDistance(enemyTargets, self.origin);
      }

      enemy_target = undefined;

      foreach(guy in enemyTargets) {
        if(!isDefined(guy)) {
          continue;
        }

        if(!IsAlive(guy)) {
          continue;
        }

        if(guy _hasPerk("specialty_blindeye")) {
          continue;
        }

        if(isDefined(guy.spawntime) && (((GetTime() - guy.spawntime) / 1000) < 5)) {
          continue;
        }

        enemy_target = guy;
        warbird.enemy_target = enemy_target;

        CheckWarbirdTargetLos(warbird);

        break;
      }
    }

    warbird notify("LostLOS");

    wait(0.05);
  }
}

FireAi(warbird) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");

  warbird.RemainingRocketShots = warbird.RocketClip;

  while(true) {
    waitframe();

    if(!isDefined(warbird.enemy_target) || !IsAlive(warbird.enemy_target) || !warbird.lineOfSight) {
      continue;
    }

    if(warbird.hasRockets && warbird.RemainingRocketShots) {
      FireAiRocket(warbird);
    }

    warbird.warbirdTurret ShootTurret();
  }
}

FireAiRocket(warbird) {
  missile_tag_origin = warbird GetTagOrigin("tag_missile_right");
  player_forward = VectorNormalize(anglesToForward(warbird.angles));
  warbird_velocity = warbird Vehicle_GetVelocity();
  missile = MagicBullet("warbird_missile_mp", missile_tag_origin + warbird_velocity / 10, self getEye() + warbird_velocity + player_forward * 1000, self);
  missile.killCamEnt = warbird;
  playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], warbird, "tag_missile_right");

  missile Missile_SetTargetEnt(warbird.enemy_target);
  missile Missile_SetFlightmodeDirect();

  warbird.RemainingRocketShots--;

  if(warbird.RemainingRocketShots <= 0) {
    thread WarbirdAiRocketReload(warbird);
  }

  waittillRocketDeath(warbird, missile);
}

WarbirdAiRocketReload(warbird) {
  warbird endon("warbirdStreakComplete");

  wait CONST_rocket_reload_time;

  warbird.RemainingRocketShots = warbird.RocketClip;
}

waittillRocketDeath(warbird, missile) {
  warbird.enemy_target endon("death");
  warbird.enemy_target endon("disconnect");

  missile waittill("death");
}

CheckWarbirdTargetLos(warbird) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");
  warbird.enemy_target endon("death");
  warbird.enemy_target endon("disconnect");

  while(true) {
    turret_flash_pos = warbird GetTagOrigin("TAG_FLASH1");
    target_pos = warbird.enemy_target getEye();
    target_dir = VectorNormalize(target_pos - turret_flash_pos);
    start_pos = turret_flash_pos + (target_dir * 20);

    trace = bulletTrace(start_pos, target_pos, false, warbird, false, false, false, false, false);
    if(!CheckTargetIsInVision(warbird) && trace["fraction"] < 1) {
      warbird.lineOfSight = false;
      warbird.pickNewTarget = true;
      warbird.enemy_target = undefined;
      warbird notify("pickNewTarget");
      return;
    }

    warbird.lineOfSight = true;

    wait CONST_los_recheck_time;
  }
}

CheckTargetIsInVision(warbird) {
  WarbirdForward = anglesToForward(warbird.angles);
  WarbirdToEnemyLocation = warbird.enemy_target.origin - warbird.origin;
  DotProductToEnemyLocation = VectorDot(WarbirdForward, WarbirdToEnemyLocation);
  return DotProductToEnemyLocation < 0;
}

PlayerControlWarbirdSetup(warbird) {
  self endon("warbirdStreakComplete");

  self.PossessWarbird = true;
  self.ControllingWarbird = true;

  warbird.player = self;
  warbird.currentNode = undefined;
  self playerSaveAngles();

  waitframe();

  self notify("warbirdPlayerControlled");
  warbird.IsPossessed = true;

  warbird.killCamStartTime = undefined;
  warbird.warbirdTurret.killCamEnt = undefined;

  if(self.WarbirdInit != true) {
    self _giveWeapon("killstreak_predator_missile_mp");
    self SwitchToWeapon("killstreak_predator_missile_mp");

    while(self GetCurrentWeapon() != "killstreak_predator_missile_mp") {
      waitframe();
    }

    self thread PlayerDoRideKillstreak(warbird, false);
    self waittill("initRideKillstreak_complete", success);
    if(!success) {
      return;
    }
    self setUsingRemote("Warbird");
  }

  self thread SetupWarbirdHud(warbird);
  self thread MonitorWarbirdSafeArea(warbird);

  self thread waitSetThermal(0.5);
  self thread setWarbirdVisionSetPerMap(0.5);

  self EnableSlowAim(.3, .3);

  self pauseWarbirdEngineFXForPlayer(warbird);

  warbird.PlayerAttachPoint = spawn("script_model", (0, 0, 0));
  warbird.PlayerAttachPoint setModel("tag_player");
  warbird.PlayerAttachPoint Hide();

  WarbirdPlayerTagOrigin = (warbird GetTagOrigin("tag_origin"));
  WarbirdPlayerTagAngles = warbird GetTagAngles("tag_origin");
  forward = anglesToForward(WarbirdPlayerTagAngles);

  WarbirdPlayerTagOrigin = WarbirdPlayerTagOrigin + (forward * 165);
  WarbirdPlayerTagOrigin += (0, 0, -10);

  warbird.PlayerAttachPoint.origin = WarbirdPlayerTagOrigin;
  warbird.PlayerAttachPoint.angles = WarbirdPlayerTagAngles;

  warbird.PlayerAttachPoint LinkTo(warbird, "tag_player_mp");

  self Unlink();

  warbird CancelAIMove(warbird);

  self thread WarbirdRocketDamageIndicator(warbird);

  self RemoteControlVehicle(warbird);

  self thread WeaponSetup(warbird);
  self thread PlayerCloakReady(warbird);
  warbird.warbirdTurret SetMode("sentry_manual");
  self RemoteControlTurret(warbird.warbirdTurret, 45);

  while(self.PossessWarbird) {
    self ExitWarbirdControlState(warbird);
  }

  self playerRestoreAngles();

  if(!warbird.aiAttack && !warbird.aiFollow) {
    warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave();
  }
}

setWarbirdVisionSetPerMap(delay) {
  self endon("disconnect");
  self endon("warbirdStreakComplete");

  wait(delay);

  if(isDefined(level.warbirdVisionSet)) {
    self SetClientTriggerVisionSet(level.warbirdVisionSet, 0);
  }
}

removeWarbirdVisionSetPerMap(delay) {
  self SetClientTriggerVisionSet("", delay);
}

PlayerDoRideKillstreak(warbird, isBuddy) {
  if(!isDefined(isBuddy)) {
    isBuddy = false;
  }

  type = "warbird";
  if(isBuddy) {
    type = "coop";
  }
  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(type);

  if(result != "success" || (isBuddy && !level.warbirdInUse) || !isDefined(warbird) || (isDefined(warbird.isleaving) && warbird.isleaving)) {
    if(isBuddy) {
      self removeWarbirdBuddy(warbird, result == "disconnect");
    } else if(result != "disconnect") {
      self playerReset(warbird);
    }

    self notify("initRideKillstreak_complete", false);
    return;
  }

  self notify("initRideKillstreak_complete", true);
}

ExitWarbirdControlState(warbird) {
  self endon("warbirdStreakComplete");

  self waittill("ToggleControlState");

  self thread CancelExitButtonPressMonitor();
  self.PossessWarbird = false;

  wait 0.5;

  self notify("ExitHoldTimeComplete");
}

CancelExitButtonPressMonitor() {
  self endon("warbirdStreakComplete");
  self endon("ExitHoldTimeComplete");

  self waittill("ToggleControlCancel");

  self.PossessWarbird = true;
}

waitSetThermal(delay) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  wait(delay);

  self ThermalVisionFOFOverlayOn();
  self SetBlurForPlayer(1.1, 0);

  adsAperature = 135;
  adsFocalDistance = 0;
  normalAperature = 60;
  normalFocalDistance = 0;
  focusSpeed = 12;
  aperatureSpeed = 5;
  self maps\mp\killstreaks\_aerial_utility::thermalVision("warbirdThermalOff", adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed);
}

PlayerCloakReady(warbird, init) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  if(getDvar("scr_warbird_testcloak", 0) != "0") {
    self thread playerTestCloak();
  }

  if(isDefined(self.WarbirdInit) && self.WarbirdInit == true) {
    warbird waittill("cloaked");
    self waittill_any_return_no_endon_death("ForceUncloak", "Cloak", "ResumeWarbirdAI");

    self SwitchToVisible(warbird);
    warbird.PlayerAttachPoint play_sound_on_entity("warbird_cloak_deactivate");
  }

  while(true) {
    thread PlayerCloakActivated(warbird);
    thread PlayerCloakCooldown(warbird);

    if(warbird.CloakCooldown != 0) {
      self SetClientOmnvar("ui_warbird_cloaktext", 3);
      wait warbird.CloakCooldown;
    }

    self thread CloakReadyDialog();
    if(warbird.canCloak) {
      self SetClientOmnvar("ui_warbird_cloaktext", 1);
    }

    self waittill("Cloak");

    self notify("ActivateCloak");

    warbird play_sound_on_entity("warbird_cloak_activate");

    if(getDvar("scr_warbird_testcloak", 0) != "0") {
      continue;
    }

    self waittill("CloakCharged");
  }
}

playerTestCloak() {
  self endon("warbirdStreakComplete");

  while(true) {
    if(level.player SecondaryOffhandbuttonPressed()) {
      self notify("Cloak");
      wait 3;
    }

    waitframe();
  }
}

PlayerCloakActivated(warbird) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  self waittill("ActivateCloak");

  cloakMS = CONST_cloak_duration * 1000;
  self SetClientOmnvar("ui_warbird_cloaktime", cloakMS + GetTime());

  self SwitchToCloaked(warbird);
  self thread CloakActivatedDialog(warbird);

  self SetClientOmnvar("ui_warbird_cloaktext", 2);

  warbird.CloakCooldown = CONST_cloak_cooldown_min_duration;
  thread CloakCooldown(warbird);
  self thread PlayerCloakWaitForExit(warbird);
}

PlayerCloakCooldown(warbird) {
  self endon("warbirdStreakComplete");
  self waittill("UnCloak");

  self thread PlayCloakOverheatDialog(warbird);
  self SwitchToVisible(warbird);

  self SetClientOmnvar("ui_warbird_cloaktext", 3);

  self thread CloakDeactivatedDialog(warbird);
}

CloakCooldown(warbird) {
  self endon("warbirdStreakComplete");
  self waittill("UnCloak");

  while(warbird.CloakCooldown > 0) {
    warbird.CloakCooldown -= 0.5;
    wait 0.5;
  }

  warbird.CloakCooldown = 0;
  self notify("CloakCharged");
}

PlayerCloakWaitForExit(warbird) {
  self endon("warbirdStreakComplete");

  start = GetTime();
  self waittill_any_timeout_no_endon_death(CONST_cloak_duration, "ForceUncloak", "Cloak", "ResumeWarbirdAI");
  end = GetTime();
  cooldownDuration = max((end - start), CONST_cloak_cooldown_min_duration * 1000);
  warbird.CloakCooldown = cooldownDuration / 1000;

  cooldownEnd = GetTime() + cooldownDuration;
  self SetClientOmnvar("ui_warbird_cloakdur", cooldownEnd);

  self notify("UnCloak");
}

SwitchToCloaked(warbird) {
  if(isDefined(warbird)) {
    thread CloakingTransition(warbird, true);
    Missile_DeleteAttractor(warbird.attractor);
    self SetClientOmnvar("ui_warbird_cloak", true);

    thread MonitorDamageWhileCloaking(warbird);
  }
}

SwitchToVisible(warbird) {
  if(isDefined(warbird)) {
    thread CloakingTransition(warbird, false);
    warbird.attractor = Missile_CreateAttractorEnt(warbird, level.heli_attract_strength, level.heli_attract_range);
    self SetClientOmnvar("ui_warbird_cloak", false);
  }
}

CloakingTransition(warbird, enable, init) {
  warbird notify("cloaking_transition");
  warbird endon("cloaking_transition");
  warbird endon("warbirdStreakComplete");

  if(enable) {
    if(warbird.cloakState == -2) {
      return;
    }
    warbird.cloakState = -1;
    warbird CloakingEnable();
    warbird.warbirdTurret CloakingEnable();
    if(warbird.coopOffensive) {
      warbird.warbirdBuddyTurret CloakingEnable();
    }
    warbird Vehicle_SetMinimapVisible(false);
    if(!isDefined(init) || !init) {
      wait 0.2;
    } else {
      wait 1.5;
    }
    warbird Show();
    warbird.warbirdTurret Show();
    if(warbird.coopOffensive) {
      warbird.warbirdBuddyTurret Show();
    }
    warbird.cloakState = -2;

    warbird notify("cloaked");
    warbird stopWarbirdEngineFX();
  } else {
    if(warbird.cloakState == 2) {
      return;
    }
    warbird.cloakState = 1;
    warbird CloakingDisable();
    warbird Vehicle_SetMinimapVisible(true);
    warbird.warbirdTurret CloakingDisable();
    if(warbird.coopOffensive) {
      warbird.warbirdBuddyTurret CloakingDisable();
    }
    wait 2.2;
    warbird.cloakState = 2;
    warbird playWarbirdEngineFX();
  }
}

CloakDeactivatedDialog(warbird) {
  self endon("CloakCharged");
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  while(true) {
    self waittill("Cloak");

    warbird.PlayerAttachPoint play_sound_on_entity("warbird_cloak_notready");

    wait 1;
  }
}

CloakReadyDialog() {}

CloakActivatedDialog(warbird) {}

PlayCloakOverheatDialog(warbird) {
  warbird.PlayerAttachPoint play_sound_on_entity("warbird_cloak_deactivate");
}

CloakWarbirdExit(warbird, player) {
  if(isDefined(warbird) && warbird.isCrashing == false) {
    if(isDefined(player)) {
      player notify("ActivateCloak");
    }
    thread CloakingTransition(warbird, true);
    Missile_DeleteAttractor(warbird.attractor);
  }
}

MonitorDamageWhileCloaking(warbird) {
  self endon("UnCloak");
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  wait 1;

  warbird waittill("damage", Amount, Attacker, DirectionVec, Point, DamageType);
  self notify("ForceUncloak");
}

WarbirdRocketDamageIndicator(warbird) {
  self endon("ResumeWarbirdAI");
  self endon("warbirdStreakComplete");

  while(1) {
    warbird waittill("damage", Amount, Attacker, DirectionVec, Point, DamageType);
    if(DamageType == "MOD_PROJECTILE") {
      Earthquake(.75, 1, warbird.origin, 1000);
      self ShellShock("frag_grenade_mp", 0.5);
    }
  }
}

UpdateShootingLocation(warbird) {
  self endon("warbirdStreakComplete");
  level endon("ResumeWarbirdAI");

  while(true) {
    angles = self GetPlayerAngles();

    eye = warbird.PlayerAttachPoint.origin;

    forward = anglesToForward(angles);
    TargetPos = eye + (forward * 4000);

    warbird.TargetEnt.origin = TargetPos;

    wait 0.05;
  }
}

MonitorWeaponSelection(warbird) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  self.current_warbird_weapon = "turret";
  warbird.warbirdTurret TurretFireEnable();

  if(!warbird.hasRockets) {
    return;
  }

  while(1) {
    self waittill("SwitchWeapon");

    if(self.current_warbird_weapon == "turret") {
      self.current_warbird_weapon = "missiles";
      warbird.warbirdTurret TurretFireDisable();
      self SetClientOmnvar("ui_warbird_weapon", 2);
    } else if(self.current_warbird_weapon == "missiles") {
      self.current_warbird_weapon = "turret";
      warbird.warbirdTurret TurretFireEnable();
      self SetClientOmnvar("ui_warbird_weapon", 1);
    }

    self PlayLocalSound("warbird_weapon_cycle_plr");
  }
}

WeaponSetup(warbird) {
  if(warbird.hasRockets) {
    self thread FireWarbirdRockets(warbird);
  }

  self thread MonitorWeaponSelection(warbird);

  self thread UpdateShootingLocation(warbird);

  self thread force_uncloak_on_fire(warbird);
}

waittillTurretFired(warbird) {
  warbird endon("warbirdStreakComplete");

  warbird.warbirdTurret endon("turret_fire");

  if(warbird.coopOffensive) {
    warbird.warbirdBuddyTurret endon("turret_fire");
  }

  level waittill("forever");
}

force_uncloak_on_fire(warbird) {
  level endon("game_ended");
  self endon("warbirdStreakComplete");

  while(true) {
    waittillTurretFired(warbird);
    self notify("ForceUncloak");

    wait(0.05);
  }
}

FireWarbirdThreatGrenades(warbird) {
  warbird endon("warbirdStreakComplete");
  self endon("warbirdStreakComplete");
  self endon("warbird_player_removed");

  while(true) {
    self waittill("StartFire");

    self maps\mp\killstreaks\_aerial_utility::playerFakeShootPaintMissile(warbird.warbirdBuddyTurret.fireSoundent);

    playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], warbird, "tag_origin");

    wait 2;
  }
}

FireWarbirdRockets(warbird) {
  self endon("ResumeWarbirdAI");
  self endon("warbirdStreakComplete");

  warbird.RemainingRocketShots = warbird.RocketClip;

  while(true) {
    if(self.guid == "bot0" || self.guid == "bot1" || self.guid == "bot2" || self.guid == "bot3") {
      wait(3);
    } else {
      self waittill("StartFire");
    }

    if(self.current_warbird_weapon == "missiles" || (self.guid == "bot0" || self.guid == "bot1" || self.guid == "bot2" || self.guid == "bot3")) {
      Earthquake(0.4, 1, warbird.origin, 1000);
      self PlayRumbleOnEntity("ac130_105mm_fire");
      missile_tag_origin = warbird GetTagOrigin("tag_missile_right");
      player_forward = VectorNormalize(anglesToForward(self GetPlayerAngles()));
      warbird_velocity = warbird GetEntityVelocity();
      missile = MagicBullet("warbird_missile_mp", missile_tag_origin + warbird_velocity / 10, self getEye() + warbird_velocity + player_forward * 1000, self);
      playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], warbird, "tag_missile_right");

      missile Missile_SetTargetEnt(warbird.TargetEnt);
      missile Missile_SetFlightmodeDirect();

      warbird.RemainingRocketShots--;

      self notify("ForceUncloak");

      WarbirdRocketHudUpdate(warbird);

      if(warbird.RemainingRocketShots == 0) {
        thread WarbirdRocketReloadSound(warbird, CONST_rocket_reload_time);

        wait CONST_rocket_reload_time;
        warbird.RemainingRocketShots = warbird.RocketClip;
        self notify("rocketReloadComplete");
        WarbirdRocketHudUpdate(warbird);
      } else {
        wait CONST_rocket_fire_interval;
      }
    }
  }
}

WarbirdRocketReloadSound(warbird, reload_time) {
  self endon("rocketReloadComplete");
  self endon("ResumeWarbirdAI");
  self endon("warbirdStreakComplete");

  missile_count = 3;

  self PlayLocalSound("warbird_missile_reload_bed");

  wait(0.5);

  while(true) {
    self PlayLocalSound("warbird_missile_reload");
    wait(reload_time / missile_count);
  }
}

handleCoopJoining(warbird, player) {
  splashRef = "warbird_coop_defensive";
  joinText = &"MP_JOIN_WARBIRD_DEF";
  buddyJoinedVO = "pilot_sup_mp_warbird";
  joinedVO = "copilot_sup_mp_paladin";
  if(warbird.coopOffensive) {
    splashRef = "warbird_coop_offensive";
    joinText = &"MP_JOIN_WARBIRD_OFF";
    buddyJoinedVO = "pilot_aslt_mp_warbird";
    joinedVO = "copilot_aslt_mp_paladin";
  }

  while(true) {
    id = maps\mp\killstreaks\_coop_util::promptForStreakSupport(player.team, joinText, splashRef, "assist_mp_warbird", buddyJoinedVO, player, joinedVO);

    level thread watchForJoin(id, warbird, player);

    result = waittillPromptComplete(warbird, "buddyJoinedStreak");

    maps\mp\killstreaks\_coop_util::stopPromptForStreakSupport(id);

    if(!isDefined(result)) {
      return;
    }

    result = waittillPromptComplete(warbird, "buddyLeftWarbird");

    if(!isDefined(result)) {
      return;
    }
  }
}

waittillPromptComplete(warbird, text) {
  warbird endon("warbirdStreakComplete");

  warbird waittill(text);

  return true;
}

watchForJoin(id, warbird, player) {
  warbird endon("warbirdStreakComplete");

  buddy = maps\mp\killstreaks\_coop_util::waittillBuddyJoinedStreak(id);

  warbird notify("buddyJoinedStreak");
  buddy thread buddyJoinWarbirdSetup(warbird, player);
}

buddyJoinWarbirdSetup(warbird, primaryPlayer) {
  warbird endon("warbirdStreakComplete");
  self endon("warbirdStreakComplete");
  self endon("warbird_player_removed");

  self thread WarbirdOverheatBarColorMonitor(warbird, warbird.warbirdBuddyTurret);

  warbird.buddy = self;

  self.ControllingWarbird = true;

  self thread PlayerDoRideKillstreak(warbird, true);
  self waittill("initRideKillstreak_complete", success);
  if(!success) {
    return;
  }

  self setUsingRemote("Warbird");
  self playerSaveAngles();

  self thread SetupWarbirdHud(warbird, true, primaryPlayer);
  self thread MonitorBuddyWarbirdDeathorTimeout(warbird);
  self thread MonitorBuddyDisconnect(warbird);

  self thread waitSetThermal(0.5);
  self thread setWarbirdVisionSetPerMap(0.5);

  self pauseWarbirdEngineFXForPlayer(warbird);

  self thread WarbirdRocketDamageIndicator(warbird);

  self takeover_warbird_turret_buddy(warbird);

  self setupPlayerCommands();

  if(!warbird.coopOffensive) {
    self thread FireWarbirdThreatGrenades(warbird);
  }

  if(!IsBot(self)) {
    self thread removeWarbirdBuddyOnCommand(warbird);
  }
}

removeWarbirdBuddy(warbird, disconnected) {
  self notify("warbird_player_removed");

  if(!disconnected) {
    self playerResetWarbirdOmnvars();
    self SetBlurForPlayer(0, 0);
    self notify("warbirdThermalOff");
    maps\mp\killstreaks\_aerial_utility::disableOrbitalThermal(self);
    self thread removeWarbirdVisionSetPerMap(1.5);
    self ThermalVisionFOFOverlayOff();
    if(isDefined(warbird.warbirdBuddyTurret) && self IsControllingWarbird()) {
      self RemoteControlTurretOff(warbird.warbirdBuddyTurret);
    }
    self.ControllingWarbird = undefined;
    self EnableWeapons();
    self Unlink();
    self maps\mp\killstreaks\_coop_util::playerResetAfterCoopStreak();
    self DisableSlowAim();
    self disablePlayercommands(warbird);
    self restartWarbirdEngineFXForPlayer(warbird);
    if(self isUsingRemote()) {
      self clearUsingRemote();
    }
    self playerRemoteKillstreakShowHud();
    self playerRestoreAngles();
  }

  warbird notify("buddyLeftWarbird");
  warbird.buddy = undefined;
}

MonitorBuddyWarbirdDeathorTimeout(warbird) {
  self endon("disconnect");

  warbird waittill_any("leaving", "death", "crashing");

  self notify("warbirdStreakComplete");
  self notify("StopWaitForDisconnect");

  waittillframeend;
  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  self thread removeWarbirdBuddy(warbird, false);
}

MonitorBuddyDisconnect(warbird) {
  self endon("StopWaitForDisconnect");

  self waittill("disconnect");

  thread removeWarbirdBuddy(warbird, true);
}

removeWarbirdBuddyOnCommand(warbird) {
  self endon("warbird_player_removed");

  while(true) {
    self waittill("ToggleControlState");

    self thread startWarbirdBuddyExitCommand(warbird);
    self thread cancelWarbirdBuddyExitCommand();
  }
}

startWarbirdBuddyExitCommand(warbird) {
  self endon("warbird_player_removed");
  self endon("ToggleControlCancel");

  self.warbird_buddy_exit = true;

  wait(0.5);

  if(self.warbird_buddy_exit == true) {
    self thread removeWarbirdBuddy(warbird, false);
  }
}

cancelWarbirdBuddyExitCommand() {
  self endon("warbird_player_removed");

  self waittill("ToggleControlCancel");

  self.warbird_buddy_exit = false;
}

MonitorAIWarbirdSwitch(warbird, init) {
  self endon("warbirdStreakComplete");

  self.WarbirdInit = false;

  self notify("ResumeWarbirdAI");
  self notify("warbirdThermalOff");
  warbird.IsPossessed = false;
  self thread CloakingTransition(warbird, false);

  warbird.warbirdTurret SetMode("auto_nonai");
  self playerResetWarbirdOmnvars();

  waittillframeend;

  self thread WarbirdAIAttack(warbird);

  warbird.killCamStartTime = GetTime();
  warbird.warbirdTurret.killCamEnt = warbird;

  warbird.player = undefined;

  if(self isUsingRemote()) {
    self playerReset(warbird);
  }

  waitframe();
}

MonitorAIWarbirdDeathorTimeout(warbird) {
  self endon("disconnect");

  thread CheckForCrashing(warbird);

  result = warbird waittill_any_return("leaving", "death", "crashing");

  self playerResetAfterWarbird(warbird);
  level thread warbirdCleanup(warbird, self, (result != "death"));
}

warbirdCleanup(warbird, player, waitUntilDeath) {
  level.SpawnedWarbirds = array_remove(level.SpawnedWarbirds, warbird);
  level.warbirdInUse = false;

  if(isDefined(warbird.UsableEnt)) {
    warbird.UsableEnt makeGloballyUnusableByType();
  }

  thread CloakWarbirdExit(warbird, player);

  if(isDefined(warbird.attractor)) {
    Missile_DeleteAttractor(warbird.attractor);
  }

  if(isDefined(warbird.PlayerAttachPoint)) {
    warbird.PlayerAttachPoint Delete();
  }

  warbird.enemy_target = undefined;

  if(waitUntilDeath) {
    warbird waittill("death");
  } else {
    waittillframeend;
  }

  result = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
  if(result != 0) {
    waitframe();
  }

  warbird.warbirdTurret Delete();

  if(isDefined(warbird.warbirdBuddyTurret)) {
    if(isDefined(warbird.warbirdBuddyTurret.fireSoundent)) {
      warbird.warbirdBuddyTurret.fireSoundent Delete();
    }
    warbird.warbirdBuddyTurret Delete();
  }

  if(isDefined(warbird.UsableEnt)) {
    warbird.UsableEnt Delete();
  }
}

playerResetAfterWarbird(warbird) {
  self notify("warbirdStreakComplete");
  warbird notify("warbirdStreakComplete");

  waittillframeend;

  self playerResetWarbirdOmnvars();

  if(warbird.IsPossessed && !self isInRemoteTransition()) {
    self playerReset(warbird);
    warbird.IsPossessed = false;
  }

  self disablePlayerCommands(warbird);

  self notify("StopWaitForDisconnect");
}

playerReset(warbird) {
  self SetBlurForPlayer(0, 0);
  maps\mp\killstreaks\_aerial_utility::disableOrbitalThermal(self);
  self ThermalVisionFOFOverlayOff();
  self thread removeWarbirdVisionSetPerMap(1.5);

  self RemoteControlVehicleOff();
  if(isDefined(warbird.warbirdTurret) && self IsControllingWarbird()) {
    self RemoteControlTurretOff(warbird.warbirdTurret);
  }
  self.ControllingWarbird = undefined;
  self.PossessWarbird = undefined;
  self EnableWeapons();
  self Unlink();
  if(self isUsingRemote()) {
    self clearUsingRemote();
  } else {
    curWeapon = self getCurrentWeapon();
    if(curWeapon == "none" || isKillstreakWeapon(curWeapon)) {
      self switchToWeapon(self Getlastweapon());
    }

    self playerRemoteKillstreakShowHud();
  }
  self thread playerDelayControl();
  if(warbird.hasAI) {
    self maps\mp\killstreaks\_killstreaks::takeKillstreakWeaponIfNoDupe("killstreak_predator_missile_mp");
  }
  self EnableWeaponSwitch();
  self DisableSlowAim();
  if(!isDefined(warbird.isleaving) || !warbird.isleaving) {
    self restartWarbirdEngineFXForPlayer(warbird);
  }
  self playerRestoreAngles();
}

playerDelayControl() {
  self endon("disconnect");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

CheckForCrashing(warbird) {
  warbird waittill_any("crashing", "death");
  warbird.isCrashing = true;
}

MonitorPlayerDisconnect(warbird) {
  self endon("StopWaitForDisconnect");

  self waittill("disconnect");

  warbird notify("warbirdStreakComplete");
  self notify("warbirdStreakComplete");
  self notify("warbirdThermalOff");

  warbird thread maps\mp\killstreaks\_aerial_utility::heli_leave();

  level thread warbirdCleanup(warbird, self, true);
}

play_sound_on_entity(alias) {
  self playSound(alias);
}

warbird_health() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);

  damageState = 3;
  self setDamageStage(damageState);

  for(;;) {
    if(self.damageTaken >= (self.maxhealth * 0.33) && damageState == 3) {
      damageState = 2;
      self setDamageStage(damageState);
      self.currentstate = "light smoke";
      playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, "tag_static_main_rotor_l");
    } else if(self.damageTaken >= (self.maxhealth * 0.66) && damageState == 2) {
      damageState = 1;
      self setDamageStage(damageState);
      self.currentstate = "heavy smoke";
      stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, "tag_static_main_rotor_l");
      playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_static_main_rotor_l");
    } else if(self.damageTaken >= self.maxhealth) {
      damageState = 0;
      self setDamageStage(damageState);

      if(isDefined(self.largeProjectileDamage) && self.largeProjectileDamage) {
        self thread maps\mp\killstreaks\_aerial_utility::heli_explode(true);
      } else {
        playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, "TAG_TAIL_FX");
        self thread maps\mp\killstreaks\_aerial_utility::heli_crash();
      }
    }

    wait 0.05;
  }
}

playerResetWarbirdOmnvars() {
  self SetClientOmnvar("ui_warbird_heat", 0);
  self SetClientOmnvar("ui_warbird_flares", 0);
  self SetClientOmnvar("ui_warbird_fire", 0);
  self SetClientOmnvar("ui_warbird_cloak", false);
  self SetClientOmnvar("ui_warbird_cloaktime", 0);
  self SetClientOmnvar("ui_warbird_cloakdur", 0);
  self SetClientOmnvar("ui_warbird_countdown", 0);
  self SetClientOmnvar("ui_warbird_missile", -1);
  self SetClientOmnvar("ui_warbird_weapon", 0);
  self SetClientOmnvar("ui_warbird_cloaktext", 0);
  self SetClientOmnvar("ui_warbird_toggle", 0);
  self SetClientOmnvar("ui_coop_primary_num", 0);
  self maps\mp\killstreaks\_aerial_utility::playerDisableStreakStatic();

  self DisableForceFirstPersonWhenFollowed();
}

playWarbirdEngineFX() {
  playFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_r");
  playFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_l");

  if(isDefined(self.player)) {
    self.player pauseWarbirdEngineFXForPlayer(self);
  }

  if(isDefined(self.buddy)) {
    self.buddy pauseWarbirdEngineFXForPlayer(self);
  }
}

stopWarbirdEngineFX() {
  stopFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_r");
  stopFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_l");
}

pauseWarbirdEngineFXForPlayer(warbird) {
  if(!isDefined(warbird)) {
    return;
  }

  StopFXOnTagForClient(level.chopper_fx["engine"]["warbird"], warbird, "tag_static_main_rotor_r", self);
  StopFXOnTagForClient(level.chopper_fx["engine"]["warbird"], warbird, "tag_static_main_rotor_l", self);
}

restartWarbirdEngineFXForPlayer(warbird) {
  if(!isDefined(warbird)) {
    return;
  }

  if(maps\mp\killstreaks\_aerial_utility::vehicleIsCloaked()) {
    return;
  }

  PlayFXOnTagForClients(level.chopper_fx["engine"]["warbird"], warbird, "tag_static_main_rotor_r", self);
  PlayFXOnTagForClients(level.chopper_fx["engine"]["warbird"], warbird, "tag_static_main_rotor_l", self);
}

warbird_audio() {
  if(isDefined(self)) {}
}

warbirdLightFX() {
  self endon("death");

  while(true) {
    self.owner waittill("UnCloak");

    playFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_L");
    wait(0.05);
    playFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_R");
    wait(0.05);
    playFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_tail");

    self.owner waittill("ActivateCloak");

    stopFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_L");
    wait(0.05);
    stopFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_R");
    wait(0.05);
    stopFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_tail");
  }
}

testFlares(player) {
  player endon("warbirdStreakComplete");

  SetDvarIfUninitialized("scr_warbird_flares", "0");

  cur = "none";
  while(true) {
    if(GetDvarInt("scr_warbird_flares", 0) == 0) {
      waitframe();
      continue;
    }

    setDvar("scr_warbird_flares", "0");

    if(cur == "none") {
      player SetClientOmnvar("ui_warbird_flares", 3);
      cur = "threat";
    } else if(cur == "threat") {
      player SetClientOmnvar("ui_warbird_flares", 1);
      cur = "flare1";
    } else if(cur == "flare1") {
      player SetClientOmnvar("ui_warbird_flares", 2);
      cur = "flare2";
    } else {
      player SetClientOmnvar("ui_warbird_flares", 0);
      cur = "none";
    }

    waitframe();
  }
}
# /