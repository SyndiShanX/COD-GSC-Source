/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_aerial_utility.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

EMP_GRENADE_TIME = 3.5;
CONST_default_height_z = 2032;

CONST_streak_static_disabled = 0;
CONST_streak_static_enabled = 1;
CONST_streak_static_damage = 2;
CONST_streak_static_range1 = 3;
CONST_streak_static_range2 = 4;
CONST_streak_static_range3 = 5;
CONST_streak_static_range4 = 6;
CONST_streak_static_fullnotext = 7;

CONST_VEHICLE_SPAWNFLAG = 16;

init() {
  if(GetDvarInt("virtuallobbyactive", 0)) {
    return;
  }

  if(GetDvar("scr_scorestreak_skip_aerial", "0") != "0") {
    return;
  }

  level.helis = [];
  level.littleBirds = [];

  level.heli_leave_nodes = getEntOrStructArray("heli_leave", "targetname");
  level.heli_crash_nodes = getEntOrStructArray("heli_crash_start", "targetname");

  assertEx(level.heli_leave_nodes.size, "No \"heli_leave\" nodes found in map!");
  assertEx(level.heli_crash_nodes.size, "No \"heli_crash_start\" nodes found in map!");

  level.chopper_fx["explode"]["death"] = [];
  level.chopper_fx["explode"]["air_death"] = [];
  level.chopper_fx["damage"]["light_smoke"] = loadfx("vfx/trail/smoke_trail_white_heli_emitter");
  level.chopper_fx["damage"]["heavy_smoke"] = loadfx("vfx/trail/smoke_trail_black_heli_emitter");
  level.chopper_fx["damage"]["on_fire"] = loadfx("vfx/fire/helicopter_damaged_fire_m");
  level.chopper_fx["explode"]["large"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");

  level.chopper_fx["rocketlaunch"]["warbird"] = LoadFX("vfx/muzzleflash/rocket_launch_air_to_ground");

  level.heli_sound["allies"]["hit"] = "warbird_death_explo";
  level.heli_sound["axis"]["hit"] = "warbird_death_explo";

  level.heli_sound["allies"]["spinloop"] = "warbird_death_spin_loop";
  level.heli_sound["axis"]["spinloop"] = "warbird_death_spin_loop";

  level.heli_sound["allies"]["crash"] = "warbird_air_death";
  level.heli_sound["axis"]["crash"] = "warbird_air_death";

  level._effect["flare"] = loadfx("vfx/lensflare/flares_warbird");

  level.heli_attract_strength = 1000;
  level.heli_attract_range = 4096;
  level.heli_maxhealth = 2000;
  level.heli_targeting_delay = 0.5;
}

makeHeliType(heliType, deathFx, lightFXFunc) {
  level.chopper_fx["explode"]["death"][heliType] = loadFx(deathFX);
  level.lightFxFunc[heliType] = lightFXFunc;
}

addAirExplosion(heliType, explodeFx) {
  level.chopper_fx["explode"]["air_death"][heliType] = loadFx(explodeFx);
}

addToHeliList() {
  level.helis[self getEntityNumber()] = self;
}

removeFromHeliList(entityNumber) {
  level.helis[entityNumber] = undefined;
}

addToLittleBirdList(lbType) {
  level.littleBirds[self GetEntityNumber()] = self;
}

removeFromLittleBirdListOnDeath(lbType) {
  entNum = self GetEntityNumber();

  self waittill("death");

  level.littleBirds[entNum] = undefined;
}

exceededMaxLittlebirds(streakName) {
  if(level.littleBirds.size >= 4) {
    return true;
  } else {
    return false;
  }
}

heli_leave_on_disconnect(owner) {
  self endon("death");
  self endon("helicopter_done");

  owner waittill("disconnect");

  self thread heli_leave();
}

heli_leave_on_changeTeams(owner) {
  self endon("death");
  self endon("helicopter_done");

  owner waittill_any("joined_team", "joined_spectators");

  self thread heli_leave();
}

heli_ModifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = self maps\mp\gametypes\_damage::modifyDamage(attacker, weapon, type, damage);

  if(modifiedDamage > 0) {
    self heli_staticDamage(weapon, type, modifiedDamage);
  }

  return modifiedDamage;
}

heli_addRecentDamage(damage) {
  self endon("death");

  self.recentDamageAmount += damage;

  wait(4.0);

  self.recentDamageAmount -= damage;
}

heli_leave_on_timeout(timeOut) {
  self endon("death");
  self endon("helicopter_done");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeOut);

  self thread heli_leave();
}

heli_leave_on_gameended(owner) {
  self endon("death");
  self endon("helicopter_done");

  level waittill("game_ended");

  self thread heli_leave();
}

heli_leave(leavePos) {
  self notify("leaving");

  self.isLeaving = true;

  self ClearLookAtEnt();

  leaveNode = undefined;

  if(!isDefined(leavePos)) {
    leaveNode = heli_pick_fly_node(level.heli_leave_nodes);
    leavePos = leaveNode.origin;
  }

  endEnt = spawn("script_origin", leavePos);

  if(isDefined(endEnt)) {
    self SetLookAtEnt(endEnt);
    endEnt thread wait_and_delete(3.0);
  }

  self heli_reset();
  self Vehicle_SetSpeed(100, 45);
  if(isDefined(leaveNode)) {
    if(isDefined(leaveNode.target)) {
      self heli_fly_simple_path(leaveNode);
    } else {
      self _setVehGoalPos(leaveNode.origin, false);
      self waittillmatch("goal");
    }
  } else {
    self _setVehGoalPos(leavePos, false);
    self waittillmatch("goal");
  }
  self notify("death");

  wait(0.05);

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }

  decrementFauxVehicleCount();

  self delete();
}

heli_pick_fly_node(nodes) {
  start = self.origin;
  nextNode = undefined;

  if(GetDvar("scr_heli_pick_fly_node_debug", "0") != "0") {
    foreach(node in nodes) {
      Sphere(node.origin, 100, (0, 1, 0), false, 300);
    }
  }

  for(i = 0; i < nodes.size; i++) {
    end = nodes[i].origin;
    if(flyNodeOrgTracePassed(start, end, self)) {
      dir = end - start;
      dist = Distance(start, end);
      dirRight = RotateVector(dir, (0, 90, 0));
      startWing = start + (dirRight * 100);
      endWing = startWing + (dir * dist);
      if(flyNodeOrgTracePassed(startWing, endWing, self)) {
        dirLeft = RotateVector(dir, (0, -90, 0));
        startWing = start + (dirLeft * 100);
        endWing = startWing + (dir * dist);
        if(flyNodeOrgTracePassed(startWing, endWing, self)) {
          return nodes[i];
        }
      }
    }
  }

  return nodes[RandomInt(nodes.size)];
}

flyNodeOrgTracePassed(start, end, ignoreEnt) {
  trace = bulletTrace(start, end, false, ignoreEnt, false, false, true, false, false);
  passed = (trace["fraction"] >= 1);

  if(GetDvar("scr_heli_pick_fly_node_debug", "0") != "0") {
    if(passed) {
      Line(start, end, (0, 1, 0), 1, false, 300);
    } else {
      Line(start, end, (1, 0, 0), 1, false, 300);
    }
  }

  return passed;
}

wait_and_delete(waitTime) {
  self endon("death");
  level endon("game_ended");

  wait(waitTime);

  self delete();
}

deleteAfterTime(delay) {
  wait(delay);

  self delete();
}

heli_reset() {
  self clearTargetYaw();
  self clearGoalYaw();
  self Vehicle_SetSpeed(60, 25);
  self setyawspeed(100, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(100);
  self setturningability(1.0);
}

_setVehGoalPos(goalPosition, shouldStop) {
  if(!isDefined(shouldStop)) {
    shouldStop = false;
  }

  self SetVehGoalPos(goalPosition, shouldStop);
}

heli_flares_monitor(extraFlares) {
  switch (self.heliType) {
    default:
      self.numFlares = 1;
      break;
  }

  if(isDefined(extraFlares)) {
    self.numFlares += extraFlares;
  }

  self thread handleIncomingStinger();
}

handleIncomingStinger(functionOverride) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("stinger_fired", player, missiles);

    if(!maps\mp\_stingerm7::anyStingerMissileLockedOn(missiles, self)) {
      continue;
    }

    if(!isDefined(missiles)) {
      continue;
    }

    if(isDefined(functionOverride)) {
      level thread[[functionOverride]](missiles, player, player.team);
    } else {
      level thread watchMissileProximity(missiles, player, player.team);
    }
  }
}

watchMissileProximity(missiles, player, missileTeam) {
  foreach(missile in missiles) {
    missile thread missileWatchProximity(player, missileTeam, missile.lockedStingerTarget);
  }
}

missileWatchProximity(player, missileTeam, missileTarget) {
  self endon("death");
  missileTarget endon("death");

  flaresTime = 5.0;
  flaresDistance = 4000;

  while(true) {
    if(!isDefined(missileTarget)) {
      break;
    }

    center = missileTarget GetPointInBounds(0, 0, 0);

    curDist = distance(self.origin, center);

    if(isDefined(missileTarget.player)) {
      missileTarget.player thread doProximityAlarm(self, missileTarget);
    }

    if(curDist < flaresDistance) {
      if(missileTarget.numFlares > 0 || isDefined(missileTarget.flaresTarget)) {
        if(isDefined(missileTarget.owner) && IsWarbird(missileTarget)) {
          if(missileTarget.numFlares == 2) {
            missileTarget.owner SetClientOmnvar("ui_warbird_flares", 1);
          } else if(missileTarget.numFlares == 1) {
            missileTarget.owner SetClientOmnvar("ui_warbird_flares", 2);
          }
          missileTarget.owner PlayLocalSound("paladin_deploy_flares");
        }
        newTarget = missileTarget deployFlares(flaresTime);
        playFXOnTag(getfx("flare"), newTarget, "tag_origin");
        if(!isDefined(missileTarget.flaresTarget)) {
          missileTarget.numFlares--;
          level thread handleFlaresTimer(missileTarget, newTarget, flaresTime);
        }
        self Missile_SetTargetEnt(newTarget);
        return;
      }
    }
    wait(0.05);
  }
}

deployFlares(time) {
  org = (self GetTagOrigin("tag_origin")) + (0, 0, -50);
  flareObject = spawn("script_model", org);
  flareObject setModel("tag_origin");
  flareObject.angles = self.angles;

  if(!isDefined(self.flaresDeployedYaw)) {
    self.flaresDeployedYaw = RandomFloatRange(-180, 180);
  } else {
    self.flaresDeployedYaw = self.flaresDeployedYaw + 90;
  }

  vel = anglesToForward((self.angles[0], self.flaresDeployedYaw, self.angles[2]));
  vel = vehicleModifyFlareVector(vel);

  flareObject MoveGravity(vel, time);

  flareObject thread deleteAfterTime(time);

  return flareObject;
}

vehicleModifyFlareVector(velocityVec) {
  if(self.vehicleType == "warbird") {
    return (VectorNormalize(velocityVec + (0, 0, -0.2)) * 300);
  } else if(self.vehicleType == "paladin") {
    return (VectorNormalize(velocityVec + (0, 0, -0.5)) * 2000);
  } else {
    return (VectorNormalize(velocityVec + (0, 0, -0.4)) * 1000);
  }
}

handleFlaresTimer(missileTarget, flaresTarget, flaresTime) {
  missileTarget endon("death");

  missileTarget.flaresTarget = flaresTarget;

  wait flaresTime;

  missileTarget.flaresTarget = undefined;

  if(isDefined(missileTarget.owner) && IsWarbird(missileTarget)) {
    missileTarget.owner SetClientOmnvar("ui_warbird_flares", 0);
  }
}

HasTag(model, tag) {
  partCount = GetNumParts(model);
  for(i = 0; i < partCount; i++) {
    if(toLower(GetPartName(model, i)) == toLower(tag)) {
      return true;
    }
  }
  return false;
}

IsWarbird(heli) {
  return isDefined(heli.heli_type) && (heli.heli_type == "warbird");
}

doProximityAlarm(missile, heli) {
  self endon("disconnect");

  if(shouldStopProximityAlarm(missile, heli) || isDefined(heli.incomingMissileSound)) {
    return;
  }

  if(IsWarbird(heli)) {
    self SetClientOmnvar("ui_warbird_flares", 3);
  }

  self PlayLocalSound("mp_aerial_enemy_locked");
  heli.incomingMissileSound = true;

  while(true) {
    if(shouldStopProximityAlarm(missile, heli)) {
      self StopLocalSound("mp_aerial_enemy_locked");
      heli.incomingMissileSound = undefined;
      return;
    }

    waitframe();
  }
}

playerFakeShootPaintMissile(soundEnt) {
  dir = VectorNormalize(anglesToForward(self GetPlayerAngles()));
  right = VectorNormalize(AnglesToRight(self GetPlayerAngles()));
  start = self getEye() + (dir * 100);
  end = start + (dir * 20000);
  trace = bulletTrace(start, end, false);

  if(trace["fraction"] == 1) {
    return;
  }

  Earthquake(0.1, 1, self getEye(), 500);

  start = self getEye() + right * -1 * 50;
  end = trace["position"];

  rocket = MagicBullet("paint_missile_killstreak_mp", start, end, self);
  rocket.owner = self;
  rocket thread watchPaintGrenade();
  self thread playerFireSounds(soundEnt, "paladin_threat_bomb_shot_2d", "paladin_threat_bomb_shot_3d");
}

playerFakeShootPaintGrenadeAtTarget(soundEnt, startPos, targetPos, stunPlayers, vehicle) {
  GRENADE_SPEED = 5000;

  Earthquake(0.2, 1, self GetViewOrigin(), 300);

  grenadeForward = VectorNormalize(targetPos - startPos);
  grenadeVelocity = grenadeForward * GRENADE_SPEED;

  grenade = MagicGrenadeManual("paint_grenade_killstreak_mp", startPos, grenadeVelocity, 2, self);
  grenade.owner = self;
  grenade thread watchPaintGrenade(stunPlayers, vehicle);

  self thread playerFireSounds(soundEnt, "recon_drn_launcher_shot_plr", "recon_drn_launcher_shot_npc");
  self playRumbleOnEntity("damage_heavy");
}

playerFakeShootEmpGrenadeAtTarget(soundEnt, startPos, targetPos) {
  GRENADE_SPEED = 5000;

  Earthquake(0.2, 1, self GetViewOrigin(), 300);

  grenadeForward = VectorNormalize(targetPos - startPos);
  grenadeVelocity = grenadeForward * GRENADE_SPEED;

  grenade = MagicGrenadeManual("emp_grenade_killstreak_mp", startPos, grenadeVelocity, 2, self);
  grenade.owner = self;

  self thread playerFireSounds(soundEnt, "recon_drn_launcher_shot_plr", "recon_drn_launcher_shot_npc");
  self playRumbleOnEntity("damage_heavy");
}

playerFireSounds(soundEnt, sound2d, sound3d) {
  if(isDefined(sound3d)) {
    soundEnt PlaySoundOnMovingEnt(sound3d);
  }

  if(GetDvar("scr_paladin_stay_on_ground", "0") != "0") {
    return;
  }

  if(isDefined(sound2d)) {
    self PlayLocalSound(sound2d);
  }
}

watchPaintGrenade(stunPlayers, vehicle) {
  if(!isDefined(stunPlayers)) {
    stunPlayers = false;
  }

  owner = self.owner;
  owner endon("disconnect");
  owner endon("death");

  self waittill("explode", position);

  if(owner isEMPed() && isDefined(level.empEquipmentDisabled) && level.empEquipmentDisabled) {
    return;
  }

  detectionGrenadeThink(position, owner, stunPlayers, vehicle);
}

detectionGrenadeThink(position, owner, stunPlayers, vehicle) {
  if(!isDefined(stunPlayers)) {
    stunPlayers = false;
  }

  assert(isDefined(owner));

  foreach(guy in level.players) {
    if(!isDefined(guy) || !isReallyAlive(guy) || !IsAlliedSentient(owner, guy)) {
      continue;
    }

    thread maps\mp\_threatdetection::detection_grenade_hud_effect(guy, position, 1.0, 400);
    thread maps\mp\_threatdetection::detection_highlight_hud_effect(guy, 5);
  }

  teamPlayers = getPlayersOnTeam(owner.team);

  foreach(guy in level.players) {
    if(!isDefined(guy) || !isReallyAlive(guy) || IsAlliedSentient(owner, guy) || guy _hasPerk("specialty_coldblooded")) {
      continue;
    }

    if(Distance(guy.origin, position) < 400) {
      guy maps\mp\_threatdetection::addThreatEvent(teamPlayers, 5, "PAINT_GRENADE", true, false);
      owner maps\mp\gametypes\_damagefeedback::updateDamageFeedback("paint");
      guy thread detectionGrenadeWatch(owner, 5);
      guy notify("paint_marked_target", owner);
      if(stunPlayers) {
        maps\mp\gametypes\_weapons::flashbangPlayer(guy, position, owner);
      }
      if(isDefined(vehicle) && vehicle.VehName == "recon_uav") {
        owner maps\mp\gametypes\_missions::processChallenge("ch_streak_recon");
      }
    }
  }
}

detectionGrenadeWatch(owner, time) {
  level endon("game_ended");
  self notify("detectionGrenadeWatch");
  self endon("detectionGrenadeWatch");

  if(!isDefined(self.tagMarkedBy) || self.tagMarkedBy != owner) {
    owner thread maps\mp\_events::killStreakTagEvent();
    owner playRumbleOnEntity("damage_heavy");
  }

  self DesignateFoFTarget(true);
  self.tagMarkedBy = owner;

  self waittill_any_timeout(time, "death", "disconnect");

  if(isDefined(self)) {
    self DesignateFoFTarget(false);
    self.tagMarkedBy = undefined;
  }

}

getPlayersOnTeam(team) {
  teammates = [];
  foreach(player in level.players) {
    if(player.hasSpawned && isAlive(player) && team == player.team && (!IsPlayer(self) || player != self)) {
      teammates[teammates.size] = player;
    }
  }

  return teammates;
}

shouldStopProximityAlarm(missile, heli) {
  return (!isDefined(heli) || !isDefined(heli.player) || !isDefined(missile) || isDefined(heli.flaresTarget) || !isReallyAlive(self) || isDefined(heli.crashed) || isDefined(heli.isCrashing));
}

heli_staticDamage(weapon, damageType, modifiedDamage) {
  if(modifiedDamage > 0 && isDefined(self.owner)) {
    self.owner thread maps\mp\killstreaks\_aerial_utility::playerShowStreakStaticForDamage();
  }

  if(modifiedDamage > 0 && isDefined(self.warbirdBuddyTurret) && isDefined(self.warbirdBuddyTurret.owner)) {
    self.warbirdBuddyTurret.owner thread maps\mp\killstreaks\_aerial_utility::playerShowStreakStaticForDamage();
  }
}

heli_monitorEMP() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  while(true) {
    self waittill("emp_damage");

    self thread heli_EMPGrenaded();
  }
}

heli_EMPGrenaded() {
  self notify("heli_EMPGrenaded");
  self endon("heli_EMPGrenaded");

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  self.empGrenaded = true;

  if(isDefined(self.mgTurretLeft)) {
    self.mgTurretLeft notify("stop_shooting");
  }

  if(isDefined(self.mgTurretRight)) {
    self.mgTurretRight notify("stop_shooting");
  }

  wait(EMP_GRENADE_TIME);

  self.empGrenaded = false;

  if(isDefined(self.mgTurretLeft)) {
    self.mgTurretLeft notify("turretstatechange");
  }

  if(isDefined(self.mgTurretRight)) {
    self.mgTurretRight notify("turretstatechange");
  }
}

heli_existance() {
  entityNumber = self getEntityNumber();

  self waittill_any("death", "crashing", "leaving");

  self removeFromHeliList(entityNumber);

  self notify("helicopter_done");
}

heli_crash() {
  self notify("crashing");

  self ClearLookAtEnt();
  self.isCrashing = true;

  crashNode = heli_pick_fly_node(level.heli_crash_nodes);

  if(isDefined(self.mgTurretLeft)) {
    self.mgTurretLeft notify("stop_shooting");
  }

  if(isDefined(self.mgTurretRight)) {
    self.mgTurretRight notify("stop_shooting");
  }

  self thread heli_spin(180);
  self thread heli_secondary_explosions();
  self Vehicle_SetSpeed(100, 45);
  if(isDefined(crashNode.target)) {
    self heli_fly_simple_path(crashNode);
  } else {
    self _setVehGoalPos(crashNode.origin, false);
    self waittillmatch("goal");
  }
  self thread heli_explode();
}

heli_secondary_explosions() {
  teamname = self.team;

  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
  if(isDefined(level.heli_sound[teamname]["hitsecondary"])) {
    self playSound(level.heli_sound[teamname]["hitsecondary"]);
  }

  wait(3.0);

  if(!isDefined(self)) {
    return;
  }

  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
  if(isDefined(level.heli_sound[teamname]["hitsecondary"])) {
    self playSound(level.heli_sound[teamname]["hitsecondary"]);
  }
}

heli_spin(speed) {
  self endon("death");

  teamname = self.team;

  self playSound(level.heli_sound[teamname]["hit"]);

  self thread spinSoundShortly();

  self setyawspeed(speed, speed, speed);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + (speed * 0.9));
    wait(1);
  }
}

spinSoundShortly() {
  self endon("death");

  wait .25;
  teamname = self.team;
  self stopLoopSound();
  wait .05;
  self playLoopSound(level.heli_sound[teamname]["spinloop"]);
  wait .05;
  if(isDefined(level.heli_sound[teamname]["spinstart"])) {
    self playLoopSound(level.heli_sound[teamname]["spinstart"]);
  }
}

heli_explode(altStyle) {
  self notify("death");

  if(isDefined(altStyle) && isDefined(level.chopper_fx["explode"]["air_death"][self.heli_type])) {
    deathAngles = self getTagAngles("tag_deathfx");

    playFX(level.chopper_fx["explode"]["air_death"][self.heli_type], self getTagOrigin("tag_deathfx"), anglesToForward(deathAngles), anglesToUp(deathAngles));
  } else {
    org = self.origin;
    forward = (self.origin + (0, 0, 1)) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.heli_type], org, forward);
  }

  teamname = self.team;
  self playSound(level.heli_sound[teamname]["crash"]);

  wait(0.05);

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }

  decrementFauxVehicleCount();

  self delete();
}

heli_fly_simple_path(startNode) {
  self endon("death");
  self endon("leaving");

  self notify("flying");
  self endon("flying");

  heli_reset();

  currentNode = startNode;
  while(isDefined(currentNode.target)) {
    nextNode = getEntOrStruct(currentNode.target, "targetname");
    assertEx(isDefined(nextNode), "Next node in path is undefined, but has targetname. Bad Node Position: " + currentNode.origin);

    if(isDefined(currentNode.script_airspeed) && isDefined(currentNode.script_accel)) {
      heli_speed = currentNode.script_airspeed;
      heli_accel = currentNode.script_accel;
    } else {
      heli_speed = 30 + randomInt(20);
      heli_accel = 15 + randomInt(15);
    }

    if(isDefined(self.isAttacking) && self.isAttacking) {
      wait(0.05);
      continue;
    }

    if(isDefined(self.isPerformingManeuver) && self.isPerformingManeuver) {
      wait(0.05);
      continue;
    }

    self Vehicle_SetSpeed(heli_speed, heli_accel);

    if(!isDefined(nextNode.target)) {
      self _setVehGoalPos(nextNode.origin + (self.zOffset), false);
      self waittill("near_goal");
    } else {
      self _setVehGoalPos(nextNode.origin + (self.zOffset), false);
      self waittill("near_goal");

      self setGoalYaw(nextNode.angles[1]);

      self waittillmatch("goal");
    }

    currentNode = nextNode;
  }

  printLn(currentNode.origin);
  printLn(self.origin);
}

handle_player_starting_aerial_view() {
  self notify("player_start_aerial_view");
}

handle_player_ending_aerial_view() {
  self notify("player_stop_aerial_view");
}

getHeliAnchor() {
  if(isDefined(level.heliAnchor)) {
    return level.heliAnchor;
  }

  warbirdAnchor = getEntOrStruct("warbird_anchor", "targetname");

  if(!isDefined(warbirdAnchor)) {
    PrintLn("WARNING: need a struct or entity with targetname warbird_anchor in the center of the map.");
    warbirdAnchor = spawnStruct();
    warbirdAnchor.origin = (0, 0, CONST_default_height_z);
    warbirdAnchor.targetname = "warbird_anchor";
  }

  if(!isDefined(warbirdAnchor.script_noteworthy)) {
    warbirdAnchor.script_noteworthy = 3500;
  }

  level.heliAnchor = warbirdAnchor;

  return level.heliAnchor;
}

playerHandleBoundaryStatic(vehicle, endonString1, endonString2) {
  if(isDefined(endonString1)) {
    self endon(endonString1);
  }
  if(isDefined(endonString2)) {
    self endon(endonString2);
  }

  outOfBoundsTriggers = getEntArray("remote_heli_range", "targetname");
  if(!isDefined(vehicle.vehicleType) || outOfBoundsTriggers.size == 0) {
    self playerHandleBoundaryStaticRadius(vehicle, endonString1, endonString2);
    return;
  }

  while(true) {
    leaving = vehicle vehicleTouchingAnyTrigger(outOfBoundsTriggers);

    if(leaving) {
      self thread playerStartOutOfBoundsStatic(vehicle, endonString1, endonString2);
      while(true) {
        waitframe();
        if(!isDefined(vehicle.alwaysStaticOut) || !vehicle.alwaysStaticOut) {
          back = !vehicle vehicleTouchingAnyTrigger(outOfBoundsTriggers);
          if(back) {
            vehicle notify("staticDone");
            self thread playerStaticToNormal(vehicle, endonString1, endonString2);
            break;
          }
        }
      }
    }

    waitframe();
  }
}

vehicleTouchingAnyTrigger(triggers) {
  foreach(trigger in triggers) {
    if(self IsTouching(trigger)) {
      return true;
    }
  }

  return false;
}

playerStaticToNormal(vehicle, endonString1, endonString2) {
  if(isDefined(endonString1)) {
    self endon(endonString1);
  }
  if(isDefined(endonString2)) {
    self endon(endonString2);
  }

  vehicle endon("staticStarting");
  vehicle.staticLevel--;

  while(vehicle.staticLevel > 0) {
    self playerShowStreakStaticForRange(vehicle.staticLevel);
    if(isDefined(vehicle.buddy)) {
      vehicle.buddy playerShowStreakStaticForRange(vehicle.staticLevel);
    }
    wait 0.5;
    vehicle.staticLevel--;
  }

  self playerShowStreakStaticForRange(0);
  if(isDefined(vehicle.buddy)) {
    vehicle.buddy playerShowStreakStaticForRange(0);
  }
}

playerStartOutOfBoundsStatic(vehicle, endonString1, endonString2) {
  if(isDefined(endonString1)) {
    self endon(endonString1);
  }
  if(isDefined(endonString2)) {
    self endon(endonString2);
  }

  vehicle notify("staticStarting");
  vehicle endon("staticDone");

  if(!isDefined(vehicle.staticLevel) || vehicle.staticLevel == 0) {
    vehicle.staticLevel = 1;
  }

  while(vehicle.staticLevel < 4) {
    self playerShowStreakStaticForRange(vehicle.staticLevel);
    if(isDefined(vehicle.buddy)) {
      vehicle.buddy playerShowStreakStaticForRange(vehicle.staticLevel);
    }

    if(isDefined(vehicle.PlayerAttachPoint)) {
      vehicle.PlayerAttachPoint playSound("mp_warbird_outofbounds_warning");
    }

    if(isDefined(vehicle.staticLevelWaitTime)) {
      wait vehicle.staticLevelWaitTime;
    } else {
      wait 2;
    }
    vehicle.staticLevel++;
  }

  vehicle notify("outOfBounds");
}

playerHandleBoundaryStaticRadius(vehicle, endonString1, endonString2) {
  if(isDefined(endonString1)) {
    self endon(endonString1);
  }
  if(isDefined(endonString2)) {
    self endon(endonString2);
  }

  WarbirdAnchor = getHeliAnchor();
  levelBoundaryRadius = Int(WarbirdAnchor.script_noteworthy);

  while(true) {
    DistanceFromCenter = Distance(WarbirdAnchor.origin, vehicle.origin);

    if(DistanceFromCenter < levelBoundaryRadius) {
      self playerShowStreakStaticForRange(0);
    } else if(DistanceFromCenter > levelBoundaryRadius && DistanceFromCenter < levelBoundaryRadius + 500) {
      self playerShowStreakStaticForRange(1);
      if(isDefined(vehicle.PlayerAttachPoint)) {
        vehicle.PlayerAttachPoint playSound("mp_warbird_outofbounds_warning");
      }
    } else if(DistanceFromCenter > levelBoundaryRadius + 500 && DistanceFromCenter < levelBoundaryRadius + 1000) {
      self playerShowStreakStaticForRange(2);
      if(isDefined(vehicle.PlayerAttachPoint)) {
        vehicle.PlayerAttachPoint playSound("mp_warbird_outofbounds_warning");
      }
    } else if(DistanceFromCenter > levelBoundaryRadius + 1000 && DistanceFromCenter < levelBoundaryRadius + 1500) {
      self playerShowStreakStaticForRange(3);
      if(isDefined(vehicle.PlayerAttachPoint)) {
        vehicle.PlayerAttachPoint playSound("mp_warbird_outofbounds_warning");
      }
    } else {
      self playerShowStreakStaticForRange(4);
      vehicle notify("outOfBounds");
    }

    wait 0.5;
  }
}

playerEnableStreakStatic() {
  self notify("playerUpdateStreakStatic");
  self SetClientOmnvar("ui_streak_overlay_state", CONST_streak_static_enabled);
}

playerDisableStreakStatic() {
  self notify("playerUpdateStreakStatic");
  self SetClientOmnvar("ui_streak_overlay_state", CONST_streak_static_disabled);
}

playerShowFullStatic() {
  self notify("playerUpdateStreakStatic");
  self SetClientOmnvar("ui_streak_overlay_state", CONST_streak_static_fullnotext);
}

playerShowStreakStaticForDamage() {
  self endon("disconnect");

  if(self GetClientOmnvar("ui_streak_overlay_state") != CONST_streak_static_enabled) {
    return;
  }

  self notify("playerUpdateStreakStatic");
  self endon("playerUpdateStreakStatic");

  self SetClientOmnvar("ui_streak_overlay_state", CONST_streak_static_damage);
  wait(1);
  self SetClientOmnvar("ui_streak_overlay_state", CONST_streak_static_enabled);
}

playerShowStreakStaticForRange(rangeIndex) {
  assert(rangeIndex >= 0 && rangeIndex <= 4);

  targetIndex = CONST_streak_static_enabled;
  switch (rangeIndex) {
    case 0:
      targetIndex = CONST_streak_static_enabled;
      break;
    case 1:
      targetIndex = CONST_streak_static_range1;
      break;
    case 2:
      targetIndex = CONST_streak_static_range2;
      break;
    case 3:
      targetIndex = CONST_streak_static_range3;
      break;
    case 4:
      targetIndex = CONST_streak_static_range4;
      break;
    default:
      AssertMsg("Unhandled range for playerShowStreakStaticForRange");
  }

  self notify("playerUpdateStreakStatic");
  self SetClientOmnvar("ui_streak_overlay_state", targetIndex);
}

getEntOrStruct(name, type) {
  ent = GetEnt(name, type);
  if(isDefined(ent)) {
    return ent;
  }
  return getstruct(name, type);
}

getEntOrStructArray(name, type) {
  structArray = getstructarray(name, type);
  entArray = getEntArray(name, type);
  if(entArray.size > 0) {
    structArray = array_combine(structArray, entArray);
  }
  return structArray;
}

playerHandleKillVehicle(vehicle, endonString1, endonString2) {
  if(isDefined(endonString1)) {
    self endon(endonString1);
  }
  if(isDefined(endonString2)) {
    self endon(endonString2);
  }

  if(!isDefined(level.vehicle_kill_triggers)) {
    return;
  }

  while(true) {
    inDeathTrigger = vehicle vehicleTouchingAnyTrigger(level.vehicle_kill_triggers);

    if(inDeathTrigger) {
      vehicle notify("death");
    }

    waitframe();
  }
}

setup_kill_drone_trig(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::setup_kill_drone_trig_proc);
  } else if(self isVehicleKillTrigger()) {
    self setup_kill_drone_trig_proc();
  }
}

setup_kill_drone_trig_proc() {
  if(self isVehicleKillTrigger()) {
    if(!isDefined(level.vehicle_kill_triggers)) {
      level.vehicle_kill_triggers = [];
    }

    level.vehicle_kill_triggers[level.vehicle_kill_triggers.size] = self;
  }
}

isVehicleKillTrigger() {
  if(isDefined(self.classname) && IsSubStr(self.classname, "trigger_multiple") && isDefined(self.spawnflags) && (self.spawnflags &CONST_VEHICLE_SPAWNFLAG)) {
    return true;
  }

  return false;
}

vehicleIsCloaked() {
  return (isDefined(self.cloakstate) && self.cloakstate < 1);
}

thermalVision(endonString, adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed) {
  self endon(endonString);

  inverted = false;

  disableOrbitalThermal(self);
  self VisionSetThermalForPlayer("default", 0.25);
  self SetClientOmnvar("ui_killstreak_optic", false);

  if(IsBot(self)) {
    return;
  }

  self notifyOnPlayerCommand("switch thermal", "+actionslot 1");
  self thread playerCleanupThermalVisionCommands(endonString);

  while(true) {
    self waittill("switch thermal");

    if(!inverted) {
      enableOrbitalThermal(self, endonString, adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed);
      self SetClientOmnvar("ui_killstreak_optic", true);
      self PlayLocalSound("paladin_toggle_flir_plr");
    } else {
      disableOrbitalThermal(self);
      self SetClientOmnvar("ui_killstreak_optic", false);
      self PlayLocalSound("paladin_toggle_flir_plr");
    }

    inverted = !inverted;
  }
}

playerCleanupThermalVisionCommands(endonString) {
  self endon("disconnect");

  self waittill(endonString);

  self NotifyOnPlayerCommandRemove("switch thermal", "+actionslot 1");
}

disableOrbitalThermal(ent) {
  ent ThermalVisionOff();
  ent notify("thermal_vision_off");
  ent DisablePhysicalDepthOfFieldScripting();

  ent.orbitalThermalMode = false;
}

enableOrbitalThermal(ent, endonString, adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed) {
  ent endon("disconnect");
  ent endon("death");
  ent endon("faux_spawn");
  ent endon(endonString);

  if(!isDefined(ent.opticsThermalEnabled)) {
    ent.opticsThermalEnabled = false;
  }
  if(!isDefined(ent.orbitalThermalMode)) {
    ent.orbitalThermalMode = false;
  }

  ent.orbitalThermalMode = true;
  while(ent.opticsThermalEnabled) {
    wait 0.05;
  }

  ent ThermalVisionOn();
  ent EnablePhysicalDepthOfFieldScripting(3);
  ent thread setThermalDOF(endonString, adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed);
}

setThermalDOF(endonString, adsAperature, adsFocalDistance, normalAperature, normalFocalDistance, focusSpeed, aperatureSpeed) {
  self endon(endonString);
  self endon("disconnect");
  self endon("thermal_vision_off");

  while(1) {
    adsAmt = self playerAds();
    aperature = float_lerp(normalAperature, adsAperature, adsAmt);
    focalDistance = float_lerp(normalFocalDistance, adsFocalDistance, adsAmt);
    self SetPhysicalDepthOfField(aperature, focalDistance, focusSpeed, aperatureSpeed);
    wait 0.1;
  }
}

float_lerp(start, end, percent) {
  return (start + percent * (end - start));
}

patchHeliLoopNode(nodeOrigin, newNodeOrigin) {
  checkedNodes = [];
  nextNode = getEntOrStruct("heli_loop_start", "targetname");

  while(true) {
    if(array_contains(checkedNodes, nextNode)) {
      break;
    }

    if(nextNode.origin == nodeOrigin) {
      nextNode.origin = newNodeOrigin;
      return;
    }

    checkedNodes[checkedNodes.size] = nextNode;

    nextNode = getEntOrStruct(nextNode.target, "targetname");
  }

  AssertMsg("Could not patch node with origin " + nodeOrigin + " because it can't be found.");
}