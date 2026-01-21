/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_helicopter.gsc
***********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  path_start = getEntArray("heli_start", "targetname");
  loop_start = getEntArray("heli_loop_start", "targetname");

  if(!path_start.size && !loop_start.size) {
    return;
  }
  level.chopper = undefined;

  level.heli_start_nodes = getEntArray("heli_start", "targetname");
  assertEx(level.heli_start_nodes.size, "No \"heli_start\" nodes found in map!");

  level.heli_loop_nodes = getEntArray("heli_loop_start", "targetname");
  assertEx(level.heli_loop_nodes.size, "No \"heli_loop_start\" nodes found in map!");

  level.strafe_nodes = getStructArray("strafe_path", "targetname");

  level.heli_leave_nodes = getEntArray("heli_leave", "targetname");
  assertEx(level.heli_leave_nodes.size, "No \"heli_leave\" nodes found in map!");

  level.heli_crash_nodes = getEntArray("heli_crash_start", "targetname");
  assertEx(level.heli_crash_nodes.size, "No \"heli_crash_start\" nodes found in map!");

  level.heli_missile_rof = 5;
  level.heli_maxhealth = 2000;
  level.heli_debug = 0;

  level.heli_targeting_delay = 0.5;
  level.heli_turretReloadTime = 1.5;
  level.heli_turretClipSize = 60;
  level.heli_visual_range = 3700;

  level.heli_target_spawnprotection = 5;
  level.heli_target_recognition = 0.5;
  level.heli_missile_friendlycare = 256;
  level.heli_missile_target_cone = 0.3;
  level.heli_armor_bulletdamage = 0.3;

  level.heli_attract_strength = 1000;
  level.heli_attract_range = 4096;

  level.heli_angle_offset = 90;
  level.heli_forced_wait = 0;

  level precacheHelicopterSounds();

  level.chopper_fx["damage"]["light_smoke"] = LoadFX("fx/smoke/smoke_trail_white_heli_emitter");
  level.chopper_fx["damage"]["heavy_smoke"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_helo_damage");
  level.chopper_fx["damage"]["on_fire"] = LoadFX("fx/fire/fire_smoke_trail_L_emitter");

  level.chopper_fx["light"]["left"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_green");
  level.chopper_fx["light"]["right"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_red");
  level.chopper_fx["light"]["belly"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_acraft_light_red_blink");
  level.chopper_fx["light"]["tail"] = LoadFX("vfx/gameplay/mp/killstreaks/vfx_acraft_light_white_blink");

  level.chopper_fx["explode"]["medium"] = LoadFX("fx/explosions/aerial_explosion");
  level.chopper_fx["explode"]["large"] = LoadFX("fx/explosions/helicopter_explosion_secondary_small");

  level.chopper_fx["smoke"]["trail"] = LoadFX("fx/smoke/smoke_trail_white_heli");

  level.chopper_fx["explode"]["death"] = [];
  level.chopper_fx["explode"]["death"]["apache"] = LoadFX("vfx/gameplay/explosions/vehicle/apch_mp/vfx_x_mpapc_primary");
  level.chopper_fx["explode"]["air_death"]["apache"] = LoadFX("vfx/gameplay/explosions/vehicle/apch_mp/vfx_x_mpapc_primary");
  level.lightFxFunc["apache"] = ::defaultLightFX;

  level.chopper_fx["explode"]["death"]["cobra"] = LoadFX("vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary");
  level.chopper_fx["explode"]["air_death"]["cobra"] = LoadFX("vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary");
  level.lightFxFunc["cobra"] = ::defaultLightFX;

  level.chopper_fx["explode"]["death"]["littlebird"] = LoadFX("vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary");
  level.chopper_fx["explode"]["air_death"]["littlebird"] = LoadFX("vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary");
  level.lightFxFunc["littlebird"] = ::defaultLightFX;

  level._effect["vehicle_flares"] = LoadFX("fx/misc/flares_cobra");

  level.chopper_fx["fire"]["trail"]["medium"] = LoadFX("fx/fire/fire_smoke_trail_L_emitter");

  level.killstreakFuncs["helicopter"] = ::useHelicopter;

  level.heliDialog["tracking"][0] = "ac130_fco_moreenemy";
  level.heliDialog["tracking"][1] = "ac130_fco_getthatguy";
  level.heliDialog["tracking"][2] = "ac130_fco_guyrunnin";
  level.heliDialog["tracking"][3] = "ac130_fco_gotarunner";
  level.heliDialog["tracking"][4] = "ac130_fco_personnelthere";
  level.heliDialog["tracking"][5] = "ac130_fco_rightthere";
  level.heliDialog["tracking"][6] = "ac130_fco_tracking";

  level.heliDialog["locked"][0] = "ac130_fco_lightemup";
  level.heliDialog["locked"][1] = "ac130_fco_takehimout";
  level.heliDialog["locked"][2] = "ac130_fco_nailthoseguys";

  level.lastHeliDialogTime = 0;

  level.heliConfigs = [];

  config = spawnStruct();
  config.xpPopup = "destroyed_helicopter";
  config.callout = "callout_destroyed_helicopter";
  config.samDamageScale = 0.09;
  config.engineVFXtag = "tag_engine_left";

  level.heliConfigs["helicopter"] = config;

  config = spawnStruct();
  config.xpPopup = "destroyed_little_bird";
  config.callout = "callout_destroyed_little_bird";
  config.samDamageScale = 0.09;
  config.engineVFXtag = "tag_engine_left";

  level.heliConfigs["airdrop"] = config;

  config = spawnStruct();
  config.xpPopup = "destroyed_pavelow";
  config.callout = "callout_destroyed_helicopter_flares";
  config.samDamageScale = 0.07;
  config.engineVFXtag = "tag_engine_left";

  level.heliConfigs["flares"] = config;

  queueCreate("helicopter");
}

makeHeliType(heliType, deathFx, lightFXFunc) {
  level.chopper_fx["explode"]["death"][heliType] = LoadFX(deathFX);
  level.lightFxFunc[heliType] = lightFXFunc;
}

addAirExplosion(heliType, explodeFx) {
  level.chopper_fx["explode"]["air_death"][heliType] = LoadFX(explodeFx);
}

defaultLightFX() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

useHelicopter(lifeId, streakName) {
  return tryUseHelicopter(lifeId, "helicopter");
}

tryUseHelicopter(lifeId, heliType) {
  numIncomingVehicles = 1;

  if(isDefined(level.chopper))
    shouldQueue = true;
  else
    shouldQueue = false;

  if(isDefined(level.chopper) && shouldQueue) {
    self iPrintLnBold(&"KILLSTREAKS_HELI_IN_QUEUE");

    if(isDefined(heliType) && heliType != "helicopter")
      streakName = "helicopter_" + heliType;
    else
      streakName = "helicopter";

    self thread maps\mp\killstreaks\_killstreaks::updateKillstreaks();

    queueEnt = spawn("script_origin", (0, 0, 0));
    queueEnt hide();
    queueEnt thread deleteOnEntNotify(self, "disconnect");
    queueEnt.player = self;
    queueEnt.lifeId = lifeId;
    queueEnt.heliType = heliType;
    queueEnt.streakName = streakName;

    queueAdd("helicopter", queueEnt);

    lastWeapon = undefined;
    if(!self hasWeapon(self getLastWeapon())) {
      lastWeapon = self maps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();
    } else {
      lastWeapon = self getLastWeapon();
    }
    killstreakWeapon = getKillstreakWeapon("helicopter");
    self thread maps\mp\killstreaks\_killstreaks::waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);

    return false;
  } else if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self iPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  numIncomingVehicles = 1;

  self startHelicopter(lifeId, heliType);
  return true;
}

deleteOnEntNotify(ent, notifyString) {
  self endon("death");
  ent waittill(notifyString);

  self delete();
}

startHelicopter(lifeId, heliType) {
  incrementFauxVehicleCount();
  startNode = undefined;

  if(!isDefined(heliType))
    heliType = "";

  eventType = "helicopter";

  team = self.pers["team"];

  startNode = level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];

  self maps\mp\_matchdata::logKillstreakEvent(eventType, self.origin);

  thread heli_think(lifeId, self, startNode, self.pers["team"], heliType);
}

precacheHelicopterSounds() {
  level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level.heli_sound["axis"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["axis"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

heli_getTeamForSoundClip() {
  teamname = self.team;
  if(level.multiTeamBased) {
    teamname = "axis";
  }
  return teamname;
}

spawn_helicopter(owner, origin, angles, vehicleType, modelName) {
  chopper = spawnHelicopter(owner, origin, angles, vehicleType, modelName);

  if(!isDefined(chopper))
    return undefined;

  if(modelName == "vehicle_battle_hind")
    chopper.heli_type = "cobra";
  else
    chopper.heli_type = level.heli_types[modelName];

  chopper thread[[level.lightFxFunc[chopper.heli_type]]]();

  chopper addToHeliList();

  chopper.zOffset = (0, 0, chopper getTagOrigin("tag_origin")[2] - chopper getTagOrigin("tag_ground")[2]);
  chopper.attractor = Missile_CreateAttractorEnt(chopper, level.heli_attract_strength, level.heli_attract_range);

  return chopper;
}

heliDialog(dialogGroup) {
  if(getTime() - level.lastHeliDialogTime < 6000) {
    return;
  }
  level.lastHeliDialogTime = getTime();

  randomIndex = randomInt(level.heliDialog[dialogGroup].size);
  soundAlias = level.heliDialog[dialogGroup][randomIndex];

  fullSoundAlias = maps\mp\gametypes\_teams::getTeamVoicePrefix(self.team) + soundAlias;

  self playLocalSound(fullSoundAlias);
}

updateAreaNodes(areaNodes) {
  validEnemies = [];

  foreach(node in areaNodes) {
    node.validPlayers = [];
    node.nodeScore = 0;
  }

  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    foreach(node in areaNodes) {
      if(distanceSquared(player.origin, node.origin) > 1048576) {
        continue;
      }
      node.validPlayers[node.validPlayers.size] = player;
    }
  }

  bestNode = areaNodes[0];
  foreach(node in areaNodes) {
    heliNode = getEnt(node.target, "targetname");
    foreach(player in node.validPlayers) {
      node.nodeScore += 1;

      if(bulletTracePassed(player.origin + (0, 0, 32), heliNode.origin, false, player))
        node.nodeScore += 3;
    }

    if(node.nodeScore > bestNode.nodeScore)
      bestNode = node;
  }

  return (getEnt(bestNode.target, "targetname"));
}

heli_think(lifeId, owner, startNode, heli_team, heliType) {
  heliOrigin = startNode.origin;
  heliAngles = startNode.angles;

  vehicleType = "cobra_mp";
  vehicleModel = "vehicle_battle_hind";

  chopper = spawn_helicopter(owner, heliOrigin, heliAngles, vehicleType, vehicleModel);

  if(!isDefined(chopper)) {
    return;
  }
  level.chopper = chopper;

  if(heli_team == "allies")
    level.alliesChopper = chopper;
  else
    level.axisChopper = chopper;

  chopper.heliType = heliType;
  chopper.lifeId = lifeId;
  chopper.team = heli_team;
  chopper.pers["team"] = heli_team;
  chopper.owner = owner;
  chopper SetOtherEnt(owner);
  chopper.startNode = startNode;

  chopper.maxhealth = level.heli_maxhealth;

  chopper.targeting_delay = level.heli_targeting_delay;
  chopper.primaryTarget = undefined;
  chopper.secondaryTarget = undefined;
  chopper.attacker = undefined;
  chopper.currentstate = "ok";
  chopper make_entity_sentient_mp(heli_team);

  chopper.empGrenaded = false;

  if(heliType == "flares" || heliType == "minigun")
    chopper thread maps\mp\killstreaks\_flares::flares_monitor(1);

  chopper thread heli_leave_on_disconnect(owner);
  chopper thread heli_leave_on_changeTeams(owner);
  chopper thread heli_leave_on_gameended(owner);
  chopper thread heli_damage_monitor(heliType);
  chopper thread heli_watchEMPDamage();
  chopper thread heli_watchDeath();
  chopper thread heli_existance();

  chopper endon("helicopter_done");
  chopper endon("crashing");
  chopper endon("leaving");
  chopper endon("death");

  attackAreas = getEntArray("heli_attack_area", "targetname");

  loopNode = undefined;
  loopNode = level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];

  chopper heli_fly_simple_path(startNode);

  chopper thread heli_targeting();
  chopper thread heli_leave_on_timeout(60.0);
  chopper thread heli_fly_loop_path(loopNode);
}

heli_existance() {
  entityNumber = self getEntityNumber();

  self waittill_any("death", "crashing", "leaving");

  self removeFromHeliList(entityNumber);

  self notify("helicopter_done");
  self notify("helicopter_removed");

  player = undefined;
  queueEnt = queueRemoveFirst("helicopter");
  if(!isDefined(queueEnt)) {
    level.chopper = undefined;
    return;
  }

  player = queueEnt.player;
  lifeId = queueEnt.lifeId;
  streakName = queueEnt.streakName;
  heliType = queueEnt.heliType;
  queueEnt delete();

  if(isDefined(player) && (player.sessionstate == "playing" || player.sessionstate == "dead")) {
    player maps\mp\killstreaks\_killstreaks::usedKillstreak(streakName, true);
    player startHelicopter(lifeId, heliType);
  } else {
    level.chopper = undefined;
  }
}

heli_targeting() {
  self notify("heli_targeting");
  self endon("heli_targeting");

  self endon("death");
  self endon("helicopter_done");

  for(;;) {
    targets = [];
    self.primaryTarget = undefined;
    self.secondaryTarget = undefined;

    foreach(player in level.characters) {
      wait 0.05;

      if(!canTarget_turret(player)) {
        continue;
      }
      targets[targets.size] = player;
    }

    if(targets.size) {
      targetPlayer = getBestPrimaryTarget(targets);

      while(!isDefined(targetPlayer)) {
        wait 0.05;
        targetPlayer = getBestPrimaryTarget(targets);
      }

      self.primaryTarget = targetPlayer;
      self notify("primary acquired");
    }

    if(isDefined(self.primaryTarget))
      self fireOnTarget(self.primaryTarget);
    else
      wait .25;
  }
}

canTarget_turret(player) {
  canTarget = true;

  if(!isAlive(player) || isDefined(player.sessionstate) && player.sessionstate != "playing")
    return false;

  if(self.heliType == "remote_mortar") {
    if(player sightConeTrace(self.origin, self) < 1)
      return false;
  }

  if(distance(player.origin, self.origin) > level.heli_visual_range)
    return false;

  if(!(self.owner IsEnemy(player)))
    return false;

  if(isDefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= 5)
    return false;

  if(player _hasPerk("specialty_blindeye"))
    return false;

  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;

  if(player sightConeTrace(heli_turret_point, self) < level.heli_target_recognition)
    return false;

  return canTarget;
}

getBestPrimaryTarget(targets) {
  foreach(player in targets) {
    if(!isDefined(player)) {
      continue;
    }
    update_player_threat(player);
  }

  highest = 0;
  primaryTarget = undefined;

  corners = getEntArray("minimap_corner", "targetname");
  foreach(player in targets) {
    if(!isDefined(player)) {
      continue;
    }
    assertEx(isDefined(player.threatlevel), "Target player does not have threat level");

    if(corners.size == 2) {
      min = corners[0].origin;
      max = corners[0].origin;
      if(corners[1].origin[0] > max[0])
        max = (corners[1].origin[0], max[1], max[2]);
      else
        min = (corners[1].origin[0], min[1], min[2]);
      if(corners[1].origin[1] > max[1])
        max = (max[0], corners[1].origin[1], max[2]);
      else
        min = (min[0], corners[1].origin[1], min[2]);

      if(player.origin[0] < min[0] || player.origin[0] > max[0] || player.origin[1] < min[1] || player.origin[1] > max[1])
        continue;
    }

    if(player.threatlevel < highest) {
      continue;
    }
    if(!BulletTracePassed(player.origin + (0, 0, 32), self.origin, false, self)) {
      wait(0.05);
      continue;
    }

    highest = player.threatlevel;
    primaryTarget = player;
  }

  return (primaryTarget);
}

update_player_threat(player) {
  player.threatlevel = 0;

  dist = distance(player.origin, self.origin);
  player.threatlevel += ((level.heli_visual_range - dist) / level.heli_visual_range) * 100;

  if(isDefined(self.attacker) && player == self.attacker)
    player.threatlevel += 100;

  if(IsPlayer(player))
    player.threatlevel += player.score * 4;

  if(isDefined(player.antithreat))
    player.threatlevel -= player.antithreat;

  if(player.threatlevel <= 0)
    player.threatlevel = 1;
}

heli_reset() {
  self clearTargetYaw();
  self clearGoalYaw();
  self Vehicle_SetSpeed(80, 35);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

addRecentDamage(damage) {
  self endon("death");

  self.recentDamageAmount += damage;

  wait(4.0);
  self.recentDamageAmount -= damage;
}

modifyDamage(attacker, weapon, type, damage) {
  if(isDefined(attacker)) {
    if(

      (isDefined(self.owner) && attacker == self.owner && self.streakName == "heli_sniper") || (isDefined(attacker.class) && attacker.class == "worldspawn") || (attacker == self)) {
      return -1;
    }
  }

  if(isDefined(level.isHorde) && level.isHorde && isDefined(self.streakname) && self.streakname == "heli_sniper")
    return -1;

  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  self thread addRecentDamage(modifiedDamage);
  self notify("heli_damage_fx");

  return modifiedDamage;
}

handleDeathDamage(attacker, weapon, type, damage) {
  if(isDefined(attacker)) {
    config = level.heliConfigs[self.streakName];

    notifyAttacker = self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, config.xpPopup, config.destroyedVO, config.callout);
    if(notifyAttacker) {
      attacker notify("destroyed_helicopter");
      self.killingAttacker = attacker;
    }

    if(weapon == "heli_pilot_turret_mp") {
      attacker maps\mp\gametypes\_missions::processChallenge("ch_enemy_down");
    }

    maps\mp\gametypes\_missions::checkAAChallenges(attacker, self, weapon);
  }
}

heli_damage_monitor(type, shouldRumble) {
  self endon("crashing");
  self endon("leaving");

  self.streakName = type;
  self.recentDamageAmount = 0;

  self thread heli_health();

  self maps\mp\gametypes\_damage::monitorDamage(self.maxHealth, "helicopter", ::handleDeathDamage, ::modifyDamage, true, shouldRumble);
}

heli_watchEMPDamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self.empGrenaded = true;
    if(isDefined(self.mgTurretLeft))
      self.mgTurretLeft notify("stop_shooting");
    if(isDefined(self.mgTurretRight))
      self.mgTurretRight notify("stop_shooting");

    wait(duration);

    self.empGrenaded = false;
    if(isDefined(self.mgTurretLeft))
      self.mgTurretLeft notify("turretstatechange");
    if(isDefined(self.mgTurretRight))
      self.mgTurretRight notify("turretstatechange");
  }
}

heli_health() {
  self endon("leaving");
  self endon("crashing");

  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);

  damageState = 3;
  self setDamageStage(damageState);

  config = level.heliConfigs[self.streakName];

  while(true) {
    self waittill("heli_damage_fx");

    if(damageState > 0 && self.damageTaken >= self.maxHealth) {
      damageState = 0;
      self setDamageStage(damageState);

      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, config.engineVFXtag);

      self notify("death");

      break;
    } else if(damageState > 1 && self.damageTaken >= (self.maxhealth * 0.66)) {
      damageState = 1;
      self setDamageStage(damageState);
      self.currentstate = "heavy smoke";
      stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, config.engineVFXtag);
      playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, config.engineVFXtag);
    } else if(damageState > 2 && self.damageTaken >= (self.maxhealth * 0.33)) {
      damageState = 2;
      self setDamageStage(damageState);
      self.currentstate = "light smoke";
      playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, config.engineVFXtag);
    }
  }
}

heli_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  if(isDefined(self.largeProjectileDamage) && self.largeProjectileDamage) {
    self thread heli_explode(true);
  } else {
    config = level.heliConfigs[self.streakName];

    playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, config.engineVFXtag);
    self thread heli_crash();
  }
}

heli_crash() {
  self notify("crashing");

  self ClearLookAtEnt();

  crashNode = level.heli_crash_nodes[randomInt(level.heli_crash_nodes.size)];

  if(isDefined(self.mgTurretLeft))
    self.mgTurretLeft notify("stop_shooting");

  if(isDefined(self.mgTurretRight))
    self.mgTurretRight notify("stop_shooting");

  self thread heli_spin(180);
  self thread heli_secondary_explosions();
  self heli_fly_simple_path(crashNode);

  self thread heli_explode();
}

heli_secondary_explosions() {
  teamname = self heli_getTeamForSoundClip();

  config = level.heliConfigs[self.streakName];

  playFXOnTag(level.chopper_fx["explode"]["large"], self, config.engineVFXtag);
  self playSound(level.heli_sound[teamname]["hitsecondary"]);

  wait(3.0);

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["explode"]["large"], self, config.engineVFXtag);
  self playSound(level.heli_sound[teamname]["hitsecondary"]);
}

heli_spin(speed) {
  self endon("death");

  teamname = self heli_getTeamForSoundClip();

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
  teamname = self heli_getTeamForSoundClip();
  self stopLoopSound();
  wait .05;
  self playLoopSound(level.heli_sound[teamname]["spinloop"]);
  wait .05;
  self playLoopSound(level.heli_sound[teamname]["spinstart"]);
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

  teamname = self heli_getTeamForSoundClip();
  self playSound(level.heli_sound[teamname]["crash"]);

  wait(0.05);

  if(isDefined(self.killCamEnt))
    self.killCamEnt delete();

  decrementFauxVehicleCount();

  self delete();
}

check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    self thread heli_leave();

    return false;
  }

  return true;
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

  if(bot_is_fireteam_mode()) {
    return;
  }
  owner waittill_any("joined_team", "joined_spectators");

  self thread heli_leave();
}

heli_leave_on_spawned(owner) {
  self endon("death");
  self endon("helicopter_done");

  owner waittill("spawned");

  self thread heli_leave();
}

heli_leave_on_gameended(owner) {
  self endon("death");
  self endon("helicopter_done");

  level waittill("game_ended");

  self thread heli_leave();
}

heli_leave_on_timeout(timeOut) {
  self endon("death");
  self endon("helicopter_done");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeOut);

  self thread heli_leave();
}

fireOnTarget(targetPlayer) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  DistanceToMoveFromTarget = 15;

  loopsCount = 0;
  totalHeight = 0;

  foreach(node in level.heli_loop_nodes) {
    loopsCount++;
    totalHeight += node.origin[2];
  }
  averageHeliHeight = totalHeight / loopsCount;

  self notify("newTarget");

  if(isDefined(self.secondaryTarget) && self.secondaryTarget.damageTaken < self.secondaryTarget.maxHealth) {
    return;
  }
  if(isDefined(self.isPerformingManeuver) && self.isPerformingManeuver) {
    return;
  }
  currentTarget = self.primaryTarget;
  currentTarget.antithreat = 0;

  target2dPos = self.primaryTarget.origin * (1, 1, 0);
  currentZpos = self.origin * (0, 0, 1);
  targetAirPos = target2dPos + currentZpos;
  targetDistance2d = Distance2D(self.origin, currentTarget.origin);

  if(targetDistance2d < 1000)
    DistanceToMoveFromTarget = 600;

  angleToApproach = anglesToForward(currentTarget.angles);
  angleToApproach *= (1, 1, 0);
  moveIntoPosition = (targetAirPos + distanceToMoveFromTarget * angleToApproach);
  attackVector = moveIntoPosition - targetAirPos;
  attackAngle = VectorToAngles(attackVector);
  attackAngle *= (1, 1, 0);

  self thread attackGroundTarget(currentTarget);

  self Vehicle_SetSpeed(80);

  if(Distance2D(self.origin, moveIntoPosition) < 1000) {
    moveIntoPosition *= 1.5;
  }

  moveIntoPosition *= (1, 1, 0);
  moveIntoPosition += (0, 0, averageHeliHeight);

  self _setVehGoalPos(moveIntoPosition, true, true);
  self waittill("near_goal");

  if(!isDefined(currentTarget) || !isAlive(currentTarget)) {
    return;
  }
  self SetLookAtEnt(currentTarget);
  self thread isFacing(10, currentTarget);
  self waittill_any_timeout(4, "facing");

  if(!isDefined(currentTarget) || !isAlive(currentTarget)) {
    return;
  }
  self ClearLookAtEnt();
  endOfAttackPosition = targetAirPos + distanceToMoveFromTarget * anglesToForward(attackAngle);

  self SetMaxPitchRoll(40, 30);
  self _setVehGoalPos(endOfAttackPosition, true, true);

  self SetMaxPitchRoll(30, 30);

  if(isDefined(currentTarget) && isAlive(currentTarget)) {
    if(isDefined(currentTarget.antithreat)) {
      currentTarget.antithreat += 100;
    } else {
      currentTarget.antithreat = 100;
    }
  }

  self waittill_any_timeout(3, "near_goal");
}

attackGroundTarget(currentTarget) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self StopLoopSound();

  self.isAttacking = true;

  self setTurretTargetEnt(currentTarget);
  self waitOnTargetOrDeath(currentTarget, 3.0);

  if(!isAlive(currentTarget)) {
    self.isAttacking = false;
    return;
  }

  dist2Dsq = Distance2DSquared(self.origin, currentTarget.origin);

  if(dist2Dsq < 640000) {
    self thread dropBombs(currentTarget);
    self.isAttacking = false;
    return;
  } else if(checkIsFacing(50, currentTarget) && cointoss()) {
    self thread fireMissile(currentTarget);
    self.isAttacking = false;
    return;
  } else {
    weaponShootTime = weaponFireTime("cobra_20mm_mp");

    shotsSinceLastSighting = 0;
    loopSoundPlaying = false;

    for(i = 0; i < level.heli_turretClipSize; i++) {
      if(!isDefined(self)) {
        break;
      }

      if(self.empGrenaded) {
        break;
      }

      if(!isDefined(currentTarget)) {
        break;
      }

      if(!isAlive(currentTarget)) {
        break;
      }

      if(self.damageTaken >= self.maxhealth) {
        continue;
      }
      if(!checkIsFacing(55, currentTarget)) {
        self stopLoopSound();
        loopSoundPlaying = false;

        wait weaponShootTime;
        i--;
        continue;
      }

      if(i < level.heli_turretClipSize - 1)
        wait weaponShootTime;

      if(!isDefined(currentTarget) || !isAlive(currentTarget)) {
        break;
      }

      if(!loopSoundPlaying) {
        self playLoopSound("weap_hind_20mm_fire_npc");
        loopSoundPlaying = true;
      }

      self setVehWeapon("cobra_20mm_mp");
      self fireWeapon("tag_flash", currentTarget);
    }

    if(!isDefined(self)) {
      return;
    }
    self stopLoopSound();
    loopSoundPlaying = false;

    self.isAttacking = false;
  }
}

checkIsFacing(tolerance, currentTarget) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance))
    tolerance = 10;

  heliForwardVector = anglesToForward(self.angles);
  heliToTarget = currentTarget.origin - self.origin;
  heliForwardVector *= (1, 1, 0);
  heliToTarget *= (1, 1, 0);

  heliToTarget = VectorNormalize(heliToTarget);
  heliForwardVector = VectorNormalize(heliForwardVector);

  targetCosine = VectorDot(heliToTarget, heliForwardVector);
  facingCosine = Cos(tolerance);

  if(targetCosine >= facingCosine) {
    return true;
  } else {
    return false;
  }
}

isFacing(tolerance, currentTarget) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance))
    tolerance = 10;

  while(IsAlive(currentTarget)) {
    heliForwardVector = anglesToForward(self.angles);
    heliToTarget = currentTarget.origin - self.origin;
    heliForwardVector *= (1, 1, 0);
    heliToTarget *= (1, 1, 0);

    heliToTarget = VectorNormalize(heliToTarget);
    heliForwardVector = VectorNormalize(heliForwardVector);

    targetCosine = VectorDot(heliToTarget, heliForwardVector);
    facingCosine = Cos(tolerance);

    if(targetCosine >= facingCosine) {
      self notify("facing");
      break;
    }

    wait(0.1);
  }
}

waitOnTargetOrDeath(target, timeOut) {
  self endon("death");
  self endon("helicopter_done");

  target endon("death");
  target endon("disconnect");

  self waittill_notify_or_timeout("turret_on_target", timeOut);
}

fireMissile(missileTarget) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  assert(self.health > 0);

  if(level.ps3)
    roundsToFire = 1;
  else
    roundsToFire = 2;

  for(i = 0; i < roundsToFire; i++) {
    if(!isDefined(missileTarget)) {
      return;
    }
    if(cointoss()) {
      missile = MagicBullet("hind_missile_mp", self GetTagOrigin("tag_missile_right") - (0, 0, 64), missileTarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    } else {
      missile = MagicBullet("hind_missile_mp", self GetTagOrigin("tag_missile_left") - (0, 0, 64), missileTarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    }

    missile Missile_SetTargetEnt(missileTarget);
    missile.owner = self;
    missile Missile_SetFlightmodeDirect();
    wait 0.50 / roundsToFire;
  }
}

dropBombs(missileTarget) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(missileTarget)) {
    return;
  }
  for(i = 0; i < randomIntRange(2, 5); i++) {
    if(cointoss()) {
      missile = MagicBullet("hind_bomb_mp", self GetTagOrigin("tag_missile_left") - (0, 0, 45), missileTarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    } else {
      missile = MagicBullet("hind_bomb_mp", self GetTagOrigin("tag_missile_right") - (0, 0, 45), missileTarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    }

    wait(randomFloatRange(0.35, 0.65));
  }
}

getOriginOffsets(goalNode) {
  startOrigin = self.origin;
  endOrigin = goalNode.origin;

  numTraces = 0;
  maxTraces = 40;

  traceOffset = (0, 0, -196);

  traceOrigin = bulletTrace(startOrigin + traceOffset, endOrigin + traceOffset, false, self);

  while(DistanceSquared(traceOrigin["position"], endOrigin + traceOffset) > 10 && numTraces < maxTraces) {
    println("trace failed: " + DistanceSquared(traceOrigin["position"], endOrigin + traceOffset));

    if(startOrigin[2] < endOrigin[2]) {
      startOrigin += (0, 0, 128);
    } else if(startOrigin[2] > endOrigin[2]) {
      endOrigin += (0, 0, 128);
    } else {
      startOrigin += (0, 0, 128);
      endOrigin += (0, 0, 128);
    }

    numTraces++;

    traceOrigin = bulletTrace(startOrigin + traceOffset, endOrigin + traceOffset, false, self);
  }

  offsets = [];
  offsets["start"] = startOrigin;
  offsets["end"] = endOrigin;
  return offsets;
}

travelToNode(goalNode) {
  originOffets = getOriginOffsets(goalNode);

  if(originOffets["start"] != self.origin) {
    self Vehicle_SetSpeed(75, 35);
    self _setVehGoalPos(originOffets["start"] + (0, 0, 30), false);

    self setgoalyaw(goalNode.angles[1] + level.heli_angle_offset);

    self waittill("goal");
  }

  if(originOffets["end"] != goalNode.origin) {
    if(isDefined(goalNode.script_airspeed) && isDefined(goalNode.script_accel)) {
      heli_speed = goalNode.script_airspeed;
      heli_accel = goalNode.script_accel;
    } else {
      heli_speed = 30 + randomInt(20);
      heli_accel = 15 + randomInt(15);
    }

    self Vehicle_SetSpeed(75, 35);
    self _setVehGoalPos(originOffets["end"] + (0, 0, 30), false);

    self setgoalyaw(goalNode.angles[1] + level.heli_angle_offset);

    self waittill("goal");
  }
}

_setVehGoalPos(goalPosition, shouldStop, adhereToMesh) {
  if(!isDefined(shouldStop))
    shouldStop = false;

  adhereToMesh = false;

  if(adhereToMesh) {
    self thread _setVehGoalPosAdhereToMesh(goalPosition, shouldStop);
  } else {
    self SetVehGoalPos(goalPosition, shouldStop);
  }
}

_setVehGoalPosAdhereToMesh(goalPosition, shouldStop) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  finalGoalPosition = goalPosition;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(distance_2d_squared(self.origin, finalGoalPosition) < 65536) {
      self SetVehGoalPos(finalGoalPosition, shouldStop);
      println("Helicopter hit macro goal");
      break;
    }

    vecAngles = vectorToAngles(finalGoalPosition - self.origin);
    vecForward = anglesToForward(vecAngles);

    microGoalTempPosition = self.origin + (vecForward * (1, 1, 0)) * 250;

    traceOffset = (0, 0, 2500);
    traceStart = (microGoalTempPosition) + (getHeliPilotMeshOffset() + traceOffset);
    traceEnd = (microGoalTempPosition) + (getHeliPilotMeshOffset() - traceOffset);

    tracePos = bulletTrace(traceStart, traceEnd, false, self, false, false, true);

    microGoalPosition = tracePos;

    if(isDefined(tracePos["entity"]) && tracePos["entity"] == self && tracePos["normal"][2] > .1) {
      tracePosZ = (tracePos["position"][2] - 4400);
      zChange = (tracePosZ - self.origin[2]);

      if(zChange > 256) {
        tracePos["position"] *= (1, 1, 0);
        tracePos["position"] += (0, 0, self.origin[2] + 256);
      } else if(zChange < -256) {
        tracePos["position"] *= (1, 1, 0);
        tracePos["position"] += (0, 0, self.origin[2] - 256);
      }

      microGoalPosition = (tracePos["position"]) - getHeliPilotMeshOffset() + (0, 0, 600);
    } else {
      microGoalPosition = finalGoalPosition;
    }

    self SetVehGoalPos(microGoalPosition, false);
    wait(.15);
  }
}

heli_fly_simple_path(startNode) {
  self endon("death");
  self endon("leaving");

  self notify("flying");
  self endon("flying");

  heli_reset();

  currentNode = startNode;
  while(isDefined(currentNode.target)) {
    nextNode = getEnt(currentNode.target, "targetname");
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

    self Vehicle_SetSpeed(75, 35);

    if(!isDefined(nextNode.target)) {
      self _setVehGoalPos(nextNode.origin + (self.zOffset), true);
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

heli_fly_loop_path(startNode) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  self notify("flying");
  self endon("flying");

  heli_reset();

  self thread heli_loop_speed_control(startNode);

  currentNode = startNode;
  while(isDefined(currentNode.target)) {
    nextNode = getEnt(currentNode.target, "targetname");
    assertEx(isDefined(nextNode), "Next node in path is undefined, but has targetname. Bad Node Position: " + currentNode.origin);

    if(isDefined(self.isPerformingManeuver) && self.isPerformingManeuver) {
      wait .25;
      continue;
    }

    if(isDefined(self.isAttacking) && self.isAttacking) {
      wait .1;
      continue;
    }

    if(isDefined(currentNode.script_airspeed) && isDefined(currentNode.script_accel)) {
      self.desired_speed = currentNode.script_airspeed;
      self.desired_accel = currentNode.script_accel;
    } else {
      self.desired_speed = 30 + randomInt(20);
      self.desired_accel = 15 + randomInt(15);
    }

    if(self.heliType == "flares") {
      self.desired_speed *= 0.5;
      self.desired_accel *= 0.5;
    }

    if(isDefined(nextNode.script_delay) && isDefined(self.primaryTarget) && !self heli_is_threatened()) {
      self _setVehGoalPos(nextNode.origin + (self.zOffset), true, true);
      self waittill("near_goal");

      wait(nextNode.script_delay);
    } else {
      self _setVehGoalPos(nextNode.origin + (self.zOffset), false, true);
      self waittill("near_goal");

      self setGoalYaw(nextNode.angles[1]);

      self waittillmatch("goal");
    }

    currentNode = nextNode;
  }
}

heli_loop_speed_control(currentNode) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isDefined(currentNode.script_airspeed) && isDefined(currentNode.script_accel)) {
    self.desired_speed = currentNode.script_airspeed;
    self.desired_accel = currentNode.script_accel;
  } else {
    self.desired_speed = 30 + randomInt(20);
    self.desired_accel = 15 + randomInt(15);
  }

  lastSpeed = 0;
  lastAccel = 0;

  while(1) {
    goalSpeed = self.desired_speed;
    goalAccel = self.desired_accel;

    if(isDefined(self.isAttacking) && self.isAttacking) {
      wait(0.05);
      continue;
    }

    if(self.heliType != "flares" && isDefined(self.primaryTarget) && !self heli_is_threatened())
      goalSpeed *= 0.25;

    if(lastSpeed != goalSpeed || lastAccel != goalAccel) {
      self Vehicle_SetSpeed(75, 35);

      lastSpeed = goalSpeed;
      lastAccel = goalAccel;
    }

    wait(0.05);
  }
}

heli_is_threatened() {
  if(self.recentDamageAmount > 50)
    return true;

  if(self.currentState == "heavy smoke")
    return true;

  return false;
}

heli_fly_well(destNodes) {
  self notify("flying");
  self endon("flying");

  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    if(isDefined(self.isAttacking) && self.isAttacking) {
      wait(0.05);
      continue;
    }

    currentNode = self get_best_area_attack_node(destNodes);
    travelToNode(currentNode);

    if(isDefined(currentNode.script_airspeed) && isDefined(currentNode.script_accel)) {
      heli_speed = currentNode.script_airspeed;
      heli_accel = currentNode.script_accel;
    } else {
      heli_speed = 30 + randomInt(20);
      heli_accel = 15 + randomInt(15);
    }

    self Vehicle_SetSpeed(75, 35);
    self _setVehGoalPos(currentNode.origin + self.zOffset, 1);
    self setgoalyaw(currentNode.angles[1] + level.heli_angle_offset);

    if(level.heli_forced_wait != 0) {
      self waittill("near_goal");
      wait(level.heli_forced_wait);
    } else if(!isDefined(currentNode.script_delay)) {
      self waittill("near_goal");

      wait(5 + randomInt(5));
    } else {
      self waittillmatch("goal");
      wait(currentNode.script_delay);
    }
  }
}

get_best_area_attack_node(destNodes) {
  return updateAreaNodes(destNodes);
}

heli_leave(leavePos) {
  self notify("leaving");

  self ClearLookAtEnt();

  if(isDefined(self.heliType) && self.heliType == "osprey" && isDefined(self.pathGoal)) {
    self _setVehGoalPos(self.pathGoal, 1);
    self waittill_any_timeout(5, "goal");
  }

  if(!isDefined(leavePos)) {
    leaveNode = level.heli_leave_nodes[randomInt(level.heli_leave_nodes.size)];
    leavePos = leaveNode.origin;
  }

  endEnt = spawn("script_origin", leavePos);
  if(isDefined(endEnt)) {
    self SetLookAtEnt(endEnt);
    endEnt thread wait_and_delete(3.0);
  }

  farLeavPos = (leavePos - self.origin) * 2000;

  self heli_reset();
  self Vehicle_SetSpeed(180, 45);
  self _setVehGoalPos(farLeavPos, 1);

  self waittill_any_timeout(12, "goal");
  self notify("gone");
  self notify("death");

  wait(0.05);

  if(isDefined(self.killCamEnt))
    self.killCamEnt delete();

  decrementFauxVehicleCount();

  self delete();
}

wait_and_delete(waitTime) {
  self endon("death");
  level endon("game_ended");
  wait(waitTime);
  self delete();
}

debug_print3d(message, color, ent, origin_offset, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    self thread draw_text(message, color, ent, origin_offset, frames);
}

debug_print3d_simple(message, ent, offset, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isDefined(frames))
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, frames);
    else
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
  }
}

debug_line(from, to, color, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0 && !isDefined(frames)) {
    thread draw_line(from, to, color);
  } else if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_line(from, to, color, frames);
}

draw_text(msg, color, ent, offset, frames) {
  if(frames == 0) {
    while(isDefined(ent)) {
      print3d(ent.origin + offset, msg, color, 0.5, 4);
      wait 0.05;
    }
  } else {
    for(i = 0; i < frames; i++) {
      if(!isDefined(ent)) {
        break;
      }
      print3d(ent.origin + offset, msg, color, 0.5, 4);
      wait 0.05;
    }
  }
}

draw_line(from, to, color, frames) {
  if(isDefined(frames)) {
    for(i = 0; i < frames; i++) {
      line(from, to, color);
      wait 0.05;
    }
  } else {
    for(;;) {
      line(from, to, color);
      wait 0.05;
    }
  }
}

addToHeliList() {
  level.helis[self getEntityNumber()] = self;
}

removeFromHeliList(entityNumber) {
  level.helis[entityNumber] = undefined;
}

addToLittleBirdList(lbType) {
  if(isDefined(lbType) && lbType == "lbSniper")
    level.lbSniper = self;

  level.littleBirds[self GetEntityNumber()] = self;
}

removeFromLittleBirdListOnDeath(lbType) {
  entNum = self GetEntityNumber();

  self waittill("death");

  if(isDefined(lbType) && lbType == "lbSniper")
    level.lbSniper = undefined;

  level.littleBirds[entNum] = undefined;
}

exceededMaxLittlebirds(streakName) {
  if(level.littleBirds.size >= 4 || (level.littleBirds.size >= 2 && streakName == "littlebird_flock")) {
    return true;
  } else
    return false;
}

pavelowMadeSelectionVO() {
  self endon("death");
  self endon("disconnect");

  self PlayLocalSound(game["voice"][self.team] + "KS_hqr_pavelow");
  wait(3.5);
  self PlayLocalSound(game["voice"][self.team] + "KS_pvl_inbound");
}

lbOnKilled() {
  self endon("gone");

  if(!isDefined(self)) {
    return;
  }
  self notify("crashing");

  if(isDefined(self.largeProjectileDamage) && self.largeProjectileDamage) {
    waitframe();
  } else {
    self Vehicle_SetSpeed(25, 5);
    self thread lbSpin(RandomIntRange(180, 220));

    wait(RandomFloatRange(1.0, 2.0));
  }

  lbExplode();
}

lbSpin(speed) {
  self endon("explode");

  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  self thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");

  self setyawspeed(speed, speed, speed);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + (speed * 0.9));
    wait(1);
  }
}

lbExplode() {
  forward = (self.origin + (0, 0, 1)) - self.origin;

  deathAngles = self GetTagAngles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self GetTagOrigin("tag_deathfx"), anglesToForward(deathAngles), AnglesToUp(deathAngles));

  self playSound("exp_helicopter_fuel");
  self notify("explode");

  self removeLittlebird();
}

trail_fx(trail_fx, trail_tag, stop_notify) {
  self notify(stop_notify);
  self endon(stop_notify);
  self endon("death");

  while(true) {
    playFXOnTag(trail_fx, self, trail_tag);
    wait(0.05);
  }
}

removeLittlebird() {
  if(isDefined(self.mgTurretLeft)) {
    if(isDefined(self.mgTurretLeft.killCamEnt))
      self.mgTurretLeft.killCamEnt delete();
    self.mgTurretLeft delete();
  }
  if(isDefined(self.mgTurretRight)) {
    if(isDefined(self.mgTurretRight.killCamEnt))
      self.mgTurretRight.killCamEnt delete();
    self.mgTurretRight delete();
  }

  if(isDefined(self.marker)) {
    self.marker delete();
  }

  if(isDefined(level.heli_pilot[self.team]) && level.heli_pilot[self.team] == self) {
    level.heli_pilot[self.team] = undefined;
  }

  decrementFauxVehicleCount();

  self delete();
}