/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_attack_heli.gsc
********************************************************/

#include maps\_utility;
#include maps\_vehicle;
#include common_scripts\utility;

preLoad() {
  PreCacheItem("turret_attackheli");
  PreCacheItem("missile_attackheli");

  thread init();
}

attack_heli_fx() {
  if(GetDvarInt("sm_enable") && getDvar("r_zfeather") != "0") {
    level._effect["_attack_heli_spotlight"] = LoadFX("misc/hunted_spotlight_model");
  } else {
    level._effect["_attack_heli_spotlight"] = LoadFX("misc/spotlight_large");
  }
}

init() {
  if(isDefined(level.attackHeliAIburstSize)) {
    return;
  }
  while(!isDefined(level.gameskill)) {
    wait(0.05);
  }

  if(!isDefined(level.cosine)) {
    level.cosine = [];
  }

  if(!isDefined(level.cosine["25"])) {
    level.cosine["25"] = Cos(25);
  }

  if(!isDefined(level.cosine["35"])) {
    level.cosine["35"] = Cos(35);
  }

  if(!isDefined(level.attackheliRange)) {
    level.attackheliRange = 3500;
  }

  if(!isDefined(level.attackHeliKillsAI)) {
    level.attackHeliKillsAI = false;
  }

  if(!isDefined(level.attackHeliFOV)) {
    level.attackHeliFOV = Cos(30);
  }

  level.attackHeliAIburstSize = 1;
  level.attackHeliMemory = 3;
  level.attackHeliTargetReaquire = 6;
  level.attackHeliMoveTime = 3;
  switch (level.gameSkill) {
    case 0:
      level.attackHeliPlayerBreak = 9;
      level.attackHeliTimeout = 1;
      break;
    case 1:
      level.attackHeliPlayerBreak = 7;
      level.attackHeliTimeout = 2;
      break;
    case 2:
      level.attackHeliPlayerBreak = 5;
      level.attackHeliTimeout = 3;
      break;
    case 3:
      level.attackHeliPlayerBreak = 3;
      level.attackHeliTimeout = 5;
      break;
  }
}

start_attack_heli(sTargetname) {
  if(!isDefined(sTargetname)) {
    sTargetname = "kill_heli";
  }
  eHeli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(sTargetname);
  eHeli = begin_attack_heli_behavior(eHeli);
  return eHeli;
}

begin_attack_heli_behavior(eHeli, heli_points) {
  eHeli endon("death");
  eHeli endon("heli_players_dead");

  if((level.gameskill == 0) || (level.gameskill == 1)) {
    org = spawn("script_origin", eHeli.origin + (0, 0, -20));
    org LinkTo(eHeli);
    eHeli thread delete_on_death(org);
    strength = undefined;
    if(level.gameskill == 0) {
      strength = 2800;
    } else {
      strength = 2200;
    }

    if(!isDefined(eHeli.no_attractor)) {
      eHeli.attractor = Missile_CreateAttractorEnt(org, strength, 10000, level.player);

      if(is_coop()) {
        eHeli.attractor2 = Missile_CreateAttractorEnt(org, strength, 10000, level.player2);
      }
    }

  }
  eHeli EnableAimAssist();
  eHeli.startingOrigin = spawn("script_origin", eHeli.origin);
  eHeli thread delete_on_death(eHeli.startingOrigin);
  if(!isDefined(eHeli.circling)) {
    eHeli.circling = false;
  }
  eHeli.allowShoot = true;
  eHeli.firingMissiles = false;
  eHeli.moving = true;
  eHeli.isTakingDamage = false;
  eHeli.heli_lastattacker = undefined;
  eHeli thread notify_disable();
  eHeli thread notify_enable();
  thread kill_heli_logic(eHeli, heli_points);

  eHeli.turrettype = undefined;
  eHeli heli_default_target_setup();

  eheli thread detect_player_death();

  switch (eHeli.vehicletype) {
    case "hind":
      eHeli.turrettype = "default";
      break;
    case "mi28":
      eHeli.turrettype = "default";
      break;
    case "littlebird":
      eHeli SetYawSpeed(90, 30, 20);
      eHeli SetMaxPitchRoll(40, 40);
      eHeli SetHoverParams(100, 20, 5);
      eHeli setup_miniguns();
      break;
    default:
      AssertMsg("Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype);
      break;
  }

  eHeli.eTarget = eHeli.targetdefault;
  if((isDefined(eHeli.script_spotlight)) && (eHeli.script_spotlight == 1) && (!isDefined(eHeli.spotlight))) {
    eHeli thread heli_spotlight_on(undefined, true);
  }

  eHeli thread attack_heli_cleanup();
  return eHeli;
}

detect_player_death() {
  foreach(player in level.players) {
    player add_wait(::waittill_msg, "death");
  }
  do_wait_any();

  self notify("heli_players_dead");
}

heli_default_target_setup() {
  up_offset = undefined;
  forward_offset = undefined;
  switch (self.vehicletype) {
    case "hind":
      forward_offset = 600;
      up_offset = -100;
      break;
    case "mi28":
      forward_offset = 600;
      up_offset = -100;
      break;
    case "littlebird":
      forward_offset = 600;
      up_offset = -204;
      break;
    default:
      AssertMsg("Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype);
      break;
  }
  self.targetdefault = spawn("script_origin", self.origin);
  self.targetdefault.angles = self.angles;
  self.targetdefault.origin = self.origin;

  ent = spawnStruct();
  ent.entity = self.targetdefault;
  ent.forward = forward_offset;
  ent.up = up_offset;
  ent translate_local();
  self.targetdefault LinkTo(self);
  self.targetdefault thread heli_default_target_cleanup(self);
}

get_turrets() {
  if(isDefined(self.turrets)) {
    return self.turrets;
  }

  setup_miniguns();
  return self.turrets;
}

setup_miniguns() {
  AssertEx(!isDefined(self.turrets), ".turrets are already defined");

  self.turrettype = "miniguns";
  self.minigunsspinning = false;
  self.firingguns = false;
  if(!isDefined(self.mgturret)) {
    return;
  }

  self.turrets = self.mgturret;
  array_thread(self.turrets, ::littlebird_turrets_think, self);
}

heli_default_target_cleanup(eHeli) {
  eHeli waittill_either("death", "crash_done");
  if(isDefined(self)) {
    self Delete();
  }
}

start_circling_heli(heli_targetname, heli_points) {
  if(!isDefined(heli_targetname)) {
    heli_targetname = "kill_heli";
  }
  heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(heli_targetname);
  heli.startingOrigin = spawn("script_origin", heli.origin);
  heli thread delete_on_death(heli.startingOrigin);
  heli.circling = true;
  heli.allowShoot = true;
  heli.firingMissiles = false;
  heli thread notify_disable();
  heli thread notify_enable();
  thread kill_heli_logic(heli, heli_points);
  return heli;
}

kill_heli_logic(heli, heli_points) {
  if(!isDefined(heli)) {
    heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
    Assert(isDefined(heli));
    heli.allowShoot = true;
    heli.firingMissiles = false;
    heli thread notify_disable();
    heli thread notify_enable();
  }

  baseSpeed = undefined;
  if(!isDefined(heli.script_airspeed)) {
    baseSpeed = 40;
  } else {
    baseSpeed = heli.script_airspeed;
  }

  if(!isDefined(level.enemy_heli_killed)) {
    level.enemy_heli_killed = false;
  }

  if(!isDefined(level.commander_speaking)) {
    level.commander_speaking = false;
  }

  if(!isDefined(level.enemy_heli_attacking)) {
    level.enemy_heli_attacking = false;
  }

  level.attack_heli_safe_volumes = undefined;
  volumes = getEntArray("attack_heli_safe_volume", "script_noteworthy");
  if(volumes.size > 0) {
    level.attack_heli_safe_volumes = volumes;
  }

  if(!level.enemy_heli_killed) {
    thread dialog_nags_heli(heli);
  }

  if(!isDefined(heli.helicopter_predator_target_shader)) {
    switch (heli.vehicletype) {
      case "mi28":
        Target_Set(heli, (0, 0, -80));
        break;
      case "hind":
        Target_Set(heli, (0, 0, -96));
        break;
      case "littlebird":
        Target_Set(heli, (0, 0, -80));
        break;
      default:
        AssertMsg("Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype);
        break;
    }
    Target_SetJavelinOnly(heli, true);
  }

  heli thread heli_damage_monitor();
  heli thread heli_death_monitor();

  heli endon("death");
  heli endon("heli_players_dead");
  heli endon("returning_home");
  heli SetVehWeapon("turret_attackheli");

  if(!isDefined(heli.circling)) {
    heli.circling = false;
  }
  if(!heli.circling) {
    heli SetNearGoalNotifyDist(100);
    if(!isDefined(heli.dontWaitForPathEnd)) {
      heli waittill("reached_dynamic_path_end");
    }
  } else {
    heli SetNearGoalNotifyDist(500);
    heli waittill("near_goal");
  }

  heli thread heli_shoot_think();
  if(heli.circling) {
    heli thread heli_circling_think(heli_points, baseSpeed);
  } else {
    heli thread heli_goal_think(baseSpeed);
  }
}

heli_circling_think(heli_points, baseSpeed) {
  if(!isDefined(heli_points)) {
    heli_points = "attack_heli_circle_node";
  }

  points = getEntArray(heli_points, "targetname");
  if(!isDefined(points) || (points.size < 1)) {
    points = getStructArray(heli_points, "targetname");
  }

  Assert(isDefined(points));

  heli = self;

  heli endon("stop_circling");
  heli endon("death");
  heli endon("returning_home");
  heli endon("heli_players_dead");

  for(;;) {
    heli Vehicle_SetSpeed(baseSpeed, baseSpeed / 4, baseSpeed / 4);
    heli SetNearGoalNotifyDist(100);
    player = get_closest_player_healthy(heli.origin);
    playerOrigin = player.origin;
    heli SetLookAtEnt(player);

    player_location = getClosest(playerOrigin, points);
    heli_locations = getEntArray(player_location.target, "targetname");
    if(!isDefined(heli_locations) || (heli_locations.size < 1)) {
      heli_locations = getStructArray(player_location.target, "targetname");
    }
    Assert(isDefined(heli_locations));
    goal = heli_locations[RandomInt(heli_locations.size)];
    heli SetVehGoalPos(goal.origin, 1);
    heli waittill("near_goal");

    if(!isDefined(player.is_controlling_UAV)) {
      wait 1;
      wait(RandomFloatRange(0.8, 1.3));
    }
  }
}

heli_goal_think(baseSpeed) {
  self endon("death");
  points = getEntArray("kill_heli_spot", "targetname");
  Assert(isDefined(points));

  heli = self;
  goal = getClosest(heli.origin, points);
  current_node = goal;
  Assert(isDefined(goal));
  heli endon("death");
  heli endon("returning_home");
  heli endon("heli_players_dead");
  eLookAtEnt = undefined;
  for(;;) {
    wait(0.05);

    heli Vehicle_SetSpeed(baseSpeed, baseSpeed / 2, baseSpeed / 10);
    heli SetNearGoalNotifyDist(100);
    player = get_closest_player_healthy(heli.origin);
    playerOrigin = player.origin;

    if((goal == current_node) && (heli.isTakingDamage)) {
      linked = get_linked_points(heli, goal, points, player, playerOrigin);
      goal = getClosest(playerOrigin, linked);
    }

    heli SetVehGoalPos(goal.origin, 1);
    heli.moving = true;

    player = get_closest_player_healthy(heli.origin);

    if((isDefined(self.eTarget)) && (isDefined(self.eTarget.classname)) && (self.eTarget.classname == "script_origin")) {
      eLookAtEnt = player;
    } else if(isDefined(self.eTarget)) {
      eLookAtEnt = self.eTarget;
    } else {
      eLookAtEnt = self.targetdefault;
    }

    heli SetLookAtEnt(eLookAtEnt);

    heli waittill("near_goal");
    heli.moving = false;

    if(!is_coop()) {
      if((level.gameSkill == 0) || (level.gameSkill == 1)) {
        while(player_is_aiming_with_rocket(heli)) {
          wait(.5);
        }
        wait(3);
      }
    }

    player = get_closest_player_healthy(heli.origin);
    playerOrigin = player.origin;

    linked = get_linked_points(heli, goal, points, player, playerOrigin);
    linked[linked.size] = goal;
    current_node = goal;

    player_location = getClosest(playerOrigin, points);
    closest_linked_point = getClosest(playerOrigin, linked);

    foreach(point in linked) {
      if(player SightConeTrace(point.origin, heli) != 1) {
        linked = array_remove(linked, point);
        continue;
      }
    }

    closest_neighbor = getClosest(playerOrigin, linked);

    if(linked.size < 2) {
      goal = closest_linked_point;
    } else if(closest_neighbor != player_location) {
      goal = closest_neighbor;
    } else {
      excluders = [];
      excluders[0] = closest_neighbor;

      linked = get_array_of_closest(playerOrigin, linked, excluders, 2);

      iRand = RandomInt(linked.size);

      if(RandomInt(100) > 50) {
        goal = linked[iRand];
      } else {
        goal = player_location;
      }
    }

    fRand = RandomFloatRange(level.attackHeliMoveTime - 0.5, level.attackHeliMoveTime + 0.5);
    self waittill_notify_or_timeout("damage_by_player", fRand);
  }
}

player_is_aiming_with_rocket(eHeli) {
  if(!level.player usingAntiAirWeapon()) {
    return false;
  }
  if(!level.player adsButtonPressed()) {
    return false;
  }
  playerEye = level.player getEye();
  if(SightTracePassed(playerEye, eHeli.origin, false, level.player)) {
    return true;
  }

  return false;
}

heli_shoot_think() {
  self endon("stop_shooting");
  self endon("death");
  self endon("heli_players_dead");

  self thread heli_missiles_think();
  attackRangeSquared = level.attackheliRange * level.attackheliRange;
  level.attackHeliGracePeriod = false;

  while(isDefined(self)) {
    wait(RandomFloatRange(0.8, 1.3));

    if((!heli_has_target()) || (!heli_has_player_target())) {
      eTarget = self heli_get_target_player_only();
      if(isPlayer(eTarget)) {
        self.eTarget = eTarget;
      }
    }

    if((heli_has_player_target()) && (level.players.size > 1)) {
      closest_player = get_closest_player_healthy(self.origin);
      if(self.eTarget != closest_player) {
        eTarget = self heli_get_target_player_only();
        if(isPlayer(eTarget)) {
          self.eTarget = eTarget;
        }
      }
    }

    if(heli_has_player_target()) {
      if((!heli_can_see_target()) || (level.attackHeliGracePeriod == true)) {
        eTarget = self heli_get_target_ai_only();
        self.eTarget = eTarget;
      }
    }

    if((isDefined(self.heli_lastattacker)) && (isPlayer(self.heli_lastattacker))) {
      self.eTarget = self.heli_lastattacker;
    } else if(!heli_has_target()) {
      eTarget = self heli_get_target_ai_only();
      self.eTarget = eTarget;
    }

    if(!heli_has_target()) {
      continue;
    }

    if(self.eTarget is_hidden_from_heli(self)) {
      continue;
    }

    if((heli_has_target()) && (DistanceSquared(self.eTarget.origin, self.origin) > attackRangeSquared)) {
      continue;
    }

    if((self.turrettype == "default") && (heli_has_player_target())) {
      miss_player(self.eTarget);
      wait(RandomFloatRange(0.8, 1.3));

      miss_player(self.eTarget);
      wait(RandomFloatRange(0.8, 1.3));

      while(can_see_player(self.eTarget) && (!self.eTarget is_hidden_from_heli(self))) {
        fire_guns();
        wait(RandomFloatRange(2.0, 4.0));
      }
    } else {
      if((isPlayer(self.eTarget)) || IsAI(self.eTarget)) {
        fire_guns();
      }

      if(isPlayer(self.eTarget)) {
        thread player_grace_period(self);
      }

      self waittill_notify_or_timeout("damage_by_player", level.attackHeliTargetReaquire);
    }
  }
}

player_grace_period(eHeli) {
  level notify("player_is_heli_target");
  level endon("player_is_heli_target");

  level.attackHeliGracePeriod = true;
  eHeli waittill_notify_or_timeout("damage_by_player", level.attackHeliPlayerBreak);
  level.attackHeliGracePeriod = false;
}

heli_can_see_target() {
  if(!isDefined(self.eTarget)) {
    return false;
  }
  org = self.eTarget.origin + (0, 0, 32);
  if(isPlayer(self.eTarget)) {
    org = self.eTarget getEye();
  }

  tag_flash_loc = self GetTagOrigin("tag_flash");

  can_sight = SightTracePassed(tag_flash_loc, org, false, self);

  return can_sight;
}

heli_has_player_target() {
  if(!isDefined(self.eTarget)) {
    return false;
  }
  if(isPlayer(self.eTarget)) {
    return true;
  } else {
    return false;
  }
}

heli_has_target() {
  if(!isDefined(self.eTarget)) {
    return false;
  }
  if(!isalive(self.eTarget)) {
    return false;
  }
  if(self.eTarget == self.targetdefault) {
    return false;
  } else {
    return true;
  }
}

heli_get_target() {
  eTarget = maps\_helicopter_globals::getEnemyTarget(level.attackheliRange, level.attackHeliFOV, true, true, false, true, level.attackHeliExcluders);

  if((isDefined(eTarget)) && (isPlayer(eTarget))) {
    eTarget = self.targetdefault;
  }
  if(!isDefined(eTarget)) {
    eTarget = self.targetdefault;
  }

  return eTarget;
}

heli_get_target_player_only() {
  aExcluders = GetAIArray("allies");

  eTarget = maps\_helicopter_globals::getEnemyTarget(level.attackheliRange, level.attackHeliFOV, true, false, false, false, aExcluders);

  if(!isDefined(eTarget)) {
    eTarget = self.targetdefault;
  }

  return eTarget;
}

heli_get_target_ai_only() {
  eTarget = maps\_helicopter_globals::getEnemyTarget(level.attackheliRange, level.attackHeliFOV, true, true, false, true, level.players);

  if(!isDefined(eTarget)) {
    eTarget = self.targetdefault;
  }

  return eTarget;
}

heli_missiles_think() {
  if(!isDefined(self.script_missiles)) {
    return;
  }
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_shooting");

  iShots = undefined;
  defaultWeapon = "turret_attackheli";
  weaponName = "missile_attackheli";
  weaponShootDelay = undefined;
  loseTargetDelay = undefined;
  tags = [];

  switch (self.vehicletype) {
    case "mi28":
      iShots = 1;
      weaponShootDelay = 1;
      loseTargetDelay = 0.5;
      tags[0] = "tag_store_L_2_a";
      tags[1] = "tag_store_R_2_a";
      tags[2] = "tag_store_L_2_b";
      tags[3] = "tag_store_R_2_b";
      tags[4] = "tag_store_L_2_c";
      tags[5] = "tag_store_R_2_c";
      tags[6] = "tag_store_L_2_d";
      tags[7] = "tag_store_R_2_d";
      break;
    case "littlebird":
      iShots = 1;
      weaponShootDelay = 1;
      loseTargetDelay = 0.5;
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    default:
      AssertMsg("Missiles have not been setup for helicoper model: " + self.vehicletype);
      break;
  }
  nextMissileTag = -1;

  while(true) {
    wait(0.05);
    self waittill("fire_missiles", other);
    if(!isPlayer(other)) {
      continue;
    }
    player = other;
    if(!player_is_good_missile_target(player)) {
      continue;
    }
    for(i = 0; i < iShots; i++) {
      nextMissileTag++;
      if(nextMissileTag >= tags.size) {
        nextMissileTag = 0;
      }

      self SetVehWeapon(weaponName);
      self.firingMissiles = true;
      eMissile = self FireWeapon(tags[nextMissileTag], player);
      eMissile thread missileLoseTarget(loseTargetDelay);
      eMissile thread missile_earthquake();
      if(i < iShots - 1) {
        wait weaponShootDelay;
      }
    }
    self.firingMissiles = false;
    self SetVehWeapon(defaultWeapon);
    wait(10);
  }
}

player_is_good_missile_target(player) {
  if(self.moving) {
    return false;
  } else {
    return true;
  }
}

missile_earthquake() {
  if(DistanceSquared(self.origin, level.player.origin) > 9000000) {
    return;
  }
  org = self.origin;
  while(isDefined(self)) {
    org = self.origin;
    wait(0.1);
  }
  Earthquake(0.7, 1.5, org, 1600);
}

missileLoseTarget(fDelay) {
  self endon("death");
  self endon("heli_players_dead");
  wait fDelay;
  if(isDefined(self)) {
    self Missile_ClearTarget();
  }
}

get_different_player(player) {
  for(i = 0; i < level.players.size; i++) {
    if(player != level.players[i]) {
      return level.players[i];
    }
  }
  return level.players[0];
}

notify_disable() {
  self notify("notify_disable_thread");
  self endon("notify_disable_thread");
  self endon("death");
  self endon("heli_players_dead");
  for(;;) {
    self waittill("disable_turret");
    self.allowShoot = false;
  }
}

notify_enable() {
  self notify("notify_enable_thread");
  self endon("notify_enable_thread");
  self endon("death");
  self endon("heli_players_dead");
  for(;;) {
    self waittill("enable_turret");
    self.allowShoot = true;
  }
}

fire_guns() {
  switch (self.turrettype) {
    case "default":
      burstsize = RandomIntRange(5, 10);
      fireTime = WeaponFireTime("turret_attackheli");
      self turret_default_fire(self.eTarget, burstsize, fireTime);
      break;
    case "miniguns":
      burstsize = getburstsize(self.eTarget);
      if((self.allowShoot) && (!self.firingMissiles)) {
        self turret_minigun_fire(self.eTarget, burstsize);
      }
      break;
    default:
      AssertMsg("Gun firing logic has not been set up in the _attack_heli.gsc script for helicopter type: " + self.turrettype);
      break;
  }
}

getburstsize(eTarget) {
  burstsize = undefined;
  if(!isPlayer(eTarget)) {
    burstsize = level.attackHeliAIburstSize;
    return burstsize;
  }

  switch (level.gameSkill) {
    case 0:
    case 1:
    case 2:
    case 3:
      burstsize = RandomIntRange(2, 3);
      break;
  }
  return burstsize;
}

fire_missiles(fDelay) {
  self endon("death");
  self endon("heli_players_dead");
  wait(fDelay);
  if(!isPlayer(self.eTarget)) {
    return;
  }
  self notify("fire_missiles", self.eTarget);
}

turret_default_fire(eTarget, burstsize, fireTime) {
  self thread fire_missiles(RandomFloatRange(.2, 2));

  for(i = 0; i < burstsize; i++) {
    self SetTurretTargetEnt(eTarget, randomvector(50) + (0, 0, 32));

    if((self.allowShoot) && (!self.firingMissiles)) {
      self FireWeapon();
    }
    wait fireTime;
  }
}

turret_minigun_fire(eTarget, burstsize, max_warmup_time) {
  self endon("death");
  self endon("heli_players_dead");
  self notify("firing_miniguns");
  self endon("firing_miniguns");

  turrets = self get_turrets();
  array_thread(turrets, ::turret_minigun_target_track, eTarget, self);
  if(!self.minigunsspinning) {
    self.firingguns = true;
    self thread play_sound_on_tag("littlebird_gatling_spinup", "tag_flash");
    wait(2.1);
    self thread play_loop_sound_on_tag("littlebird_minigun_spinloop", "tag_flash");
  }

  self.minigunsspinning = true;

  if(!isDefined(max_warmup_time)) {
    max_warmup_time = 3;
  }

  min_warmup_time = 0.5;
  if(min_warmup_time > max_warmup_time) {
    min_warmup_time = max_warmup_time;
  }

  if(min_warmup_time > 0) {
    wait(RandomFloatRange(min_warmup_time, max_warmup_time));
  }

  minigun_fire(eTarget, burstsize);
  turrets = self get_turrets();
  array_call(turrets, ::StopFiring);

  self thread minigun_spindown(eTarget);
  self notify("stopping_firing");
}

minigun_fire(eTarget, burstsize) {
  self endon("death");
  self endon("heli_players_dead");
  if(isPlayer(eTarget)) {
    self endon("cant_see_player");
  }

  turrets = self get_turrets();
  array_call(turrets, ::StartFiring);

  wait(RandomFloatRange(1, 2));

  if(isPlayer(eTarget)) {
    self thread target_track(eTarget);
  }

  if(isPlayer(eTarget)) {
    fRand = RandomFloatRange(.5, 3);
    self thread fire_missiles(fRand);
  }

  wait(burstsize);
}

target_track(eTarget) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stopping_firing");
  self notify("tracking_player");
  self endon("tracking_player");
  while(true) {
    if(!can_see_player(eTarget)) {
      break;
    }
    wait(.5);
  }
  wait level.attackHeliTimeout;
  self notify("cant_see_player");
}

turret_minigun_target_track(eTarget, eHeli) {
  eHeli endon("death");
  eHeli endon("heli_players_dead");
  self notify("miniguns_have_new_target");
  self endon("miniguns_have_new_target");

  if((!isPlayer(eTarget)) && (IsAI(eTarget)) && (level.attackHeliKillsAI == false)) {
    eFake_AI_Target = spawn("script_origin", eTarget.origin + (0, 0, 100));
    eFake_AI_Target LinkTo(eTarget);
    self thread minigun_AI_target_cleanup(eFake_AI_Target);
    eTarget = eFake_AI_Target;
  }
  while(true) {
    wait(.5);
    self SetTargetEntity(eTarget);
  }
}
minigun_AI_target_cleanup(eFake_AI_Target) {
  self waittill_either("death", "miniguns_have_new_target");
  eFake_AI_Target Delete();
}

minigun_spindown(eTarget) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("firing_miniguns");
  if(isPlayer(eTarget)) {
    wait(RandomFloatRange(3, 4));
  } else {
    wait(RandomFloatRange(1, 2));
  }
  self thread minigun_spindown_sound();
  self.firingguns = false;
}

minigun_spindown_sound() {
  self notify("stop sound" + "littlebird_minigun_spinloop");
  self.minigunsspinning = false;
  self play_sound_on_tag("littlebird_gatling_cooldown", "tag_flash");
}

miss_player(player) {
  PrintLn("_attack_heli.gsc missing player");

  forward = anglesToForward(level.player.angles);
  forwardfar = vector_multiply(forward, 400);
  miss_vec = forwardfar + randomvector(50);

  burstsize = RandomIntRange(10, 20);
  fireTime = WeaponFireTime("turret_attackheli");
  for(i = 0; i < burstsize; i++) {
    miss_vec = forwardfar + randomvector(50);

    self SetTurretTargetEnt(player, miss_vec);
    if(self.allowShoot) {
      self FireWeapon();
    }
    wait fireTime;
  }
}

can_see_player(player) {
  self endon("death");
  self endon("heli_players_dead");
  tag_flash_loc = self GetTagOrigin("tag_flash");

  if(SightTracePassed(tag_flash_loc, player getEye(), false, undefined)) {
    return true;
  } else {
    PrintLn("_attack_heli.gsc---trace failed");
    return false;
  }
}

get_linked_points(heli, goal, points, player, playerOrigin) {
  linked = [];
  tokens = StrTok(goal.script_linkto, " ");
  for(i = 0; i < points.size; i++) {
    for(j = 0; j < tokens.size; j++) {
      if(points[i].script_linkName == tokens[j]) {
        linked[linked.size] = points[i];
      }
    }
  }

  foreach(point in linked) {
    if(point.origin[2] < playerOrigin[2]) {
      linked = array_remove(linked, point);
      continue;
    }
  }

  return linked;
}

heli_damage_monitor() {
  if(!getDvarInt("scr_damagefeedback", 0)) {
    damage_feedback = false;
  } else {
    damage_feedback = true;
  }

  self endon("death");
  self endon("heli_players_dead");
  self endon("crashing");
  self endon("leaving");

  self.damagetaken = 0;
  self.seen_attacker = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, P, type);

    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    self notify("damage_by_player");
    self thread heli_damage_update();
    self thread can_see_attacker_for_a_bit(attacker);
    if(damage_feedback) {
      attacker thread updateDamageFeedback();
    }
  }
}

heli_damage_update() {
  self notify("taking damage");
  self endon("taking damage");
  self endon("death");
  self endon("heli_players_dead");
  self.isTakingDamage = true;
  wait(1);
  self.isTakingDamage = false;
}

can_see_attacker_for_a_bit(attacker) {
  self notify("attacker_seen");
  self endon("attacker_seen");
  self.seen_attacker = attacker;

  self.heli_lastattacker = attacker;
  wait level.attackHeliMemory;
  self.heli_lastattacker = undefined;

  self.seen_attacker = undefined;
}

is_hidden_from_heli(heli) {
  if(isDefined(heli.seen_attacker)) {
    if(heli.seen_attacker == self) {
      return false;
    }
    if(isDefined(level.attack_heli_safe_volumes)) {}
    foreach(volume in level.attack_heli_safe_volumes) {
      if(self IsTouching(volume)) {
        return true;
      }
    }
  }
  return false;
}

updateDamageFeedback() {
  if(!isPlayer(self)) {
    return;
  }
  self.hud_damagefeedback SetShader("damage_feedback", 24, 48);
  self PlayLocalSound("player_feedback_hit_alert");

  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback FadeOverTime(1);
  self.hud_damagefeedback.alpha = 0;
}

damage_feedback_setup() {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    player.hud_damagefeedback = NewClientHudElem(player);
    player.hud_damagefeedback.horzAlign = "center";
    player.hud_damagefeedback.vertAlign = "middle";
    player.hud_damagefeedback.x = -12;
    player.hud_damagefeedback.y = -12;
    player.hud_damagefeedback.alpha = 0;
    player.hud_damagefeedback.archived = true;
    player.hud_damagefeedback SetShader("damage_feedback", 24, 48);
  }
}

heli_death_monitor() {
  self waittill("death");
  level notify("attack_heli_destroyed");
  level.enemy_heli_killed = true;
  wait 15;
  level.enemy_heli_attacking = false;
}

dialog_nags_heli(heli) {
  heli endon("death");
  heli endon("heli_players_dead");
  wait 30;

  if(!level.enemy_heli_attacking) {
    return;
  }
  commander_dialog("co_cf_cmd_heli_small_fire");

  return;
}
commander_dialog("co_cf_cmd_rpg_stinger");

if(!level.enemy_heli_attacking) {
  return;
}
commander_dialog("co_cf_cmd_heli_wonders");

commander_dialog(dialog_line) {
  while(level.commander_speaking) {
    wait 1;
  }

  level.commander_speaking = true;
  level.player playSound(dialog_line, "sounddone");
  level.player waittill("sounddone");
  wait .5;
  level.commander_speaking = false;
}

usingAntiAirWeapon() {
  weapon = self GetCurrentWeapon();

  if(!isDefined(weapon)) {
    return false;
  }

  if(IsSubStr(ToLower(weapon), "rpg")) {
    return true;
  }

  if(IsSubStr(ToLower(weapon), "stinger")) {
    return true;
  }

  if(IsSubStr(ToLower(weapon), "at4")) {
    return true;
  }

  return false;
}

heli_spotlight_cleanup(sTag) {
  self waittill_any("death", "crash_done", "turn_off_spotlight");
  self.spotlight = undefined;
  if(isDefined(self)) {
    stopFXOnTag(getfx("_attack_heli_spotlight"), self, sTag);
  }
}

heli_spotlight_aim() {
  self endon("death");
  self endon("heli_players_dead");

  if(self.vehicletype != "littlebird") {
    return;
  }
  self thread heli_spotlight_think();
  eSpotlightTarget = undefined;
  while(true) {
    wait(.05);
    switch (self.vehicletype) {
      case "littlebird":
        eSpotlightTarget = self.spotTarget;
        break;
      default:
        eSpotlightTarget = self.eTarget;
        break;
    }
    if(isDefined(eSpotlightTarget)) {
      self SetTurretTargetEnt(eSpotlightTarget, (0, 0, 0));
    }
  }
}

heli_spotlight_think() {
  self endon("death");
  self endon("heli_players_dead");
  original_ent = self.targetdefault;
  original_ent.targetname = "original_ent";

  self.left_ent = spawn("script_origin", original_ent.origin);
  self.left_ent.origin = original_ent.origin;
  self.left_ent.angles = original_ent.angles;
  self.left_ent.targetname = "left_ent";

  self.right_ent = spawn("script_origin", original_ent.origin);
  self.right_ent.origin = original_ent.origin;
  self.right_ent.angles = original_ent.angles;
  self.right_ent.targetname = "right_ent";

  ent = spawnStruct();
  ent.entity = self.left_ent;
  ent.right = 250;
  ent translate_local();
  self.left_ent LinkTo(self);

  ent2 = spawnStruct();
  ent2.entity = self.right_ent;
  ent2.right = -250;
  ent2 translate_local();
  self.right_ent LinkTo(self);

  aim_ents = [];
  aim_ents[0] = original_ent;
  aim_ents[1] = self.left_ent;
  aim_ents[2] = self.right_ent;

  self.spotTarget = original_ent;

  array_thread(aim_ents, ::heli_spotlight_aim_ents_cleanup, self);

  while(true) {
    wait(RandomFloatRange(1, 3));

    if((heli_has_player_target()) && (!self within_player_fov())) {
      self.spotTarget = self.eTarget;
    } else {
      iRand = RandomInt(aim_ents.size);
      self.targetdefault = aim_ents[iRand];
      self.spotTarget = self.targetdefault;
    }
  }
}

within_player_fov() {
  self endon("death");
  self endon("heli_players_dead");
  if(!isDefined(self.eTarget)) {
    return false;
  }
  if(!isPlayer(self.eTarget)) {
    return false;
  }
  player = self.eTarget;
  bInFOV = within_fov(player getEye(), player GetPlayerAngles(), self.origin, level.cosine["35"]);
  return bInFOV;
}

heli_spotlight_aim_ents_cleanup(eHeli) {
  eHeli waittill_either("death", "crash_done");
  if(isDefined(self)) {
    self Delete();
  }
}

littlebird_turrets_think(eHeli) {
  eTurret = self;
  eTurret turret_set_default_on_mode("manual");
  if(isDefined(eHeli.targetdefault)) {
    eTurret SetTargetEntity(eHeli.targetdefault);
  }

  eTurret SetMode("manual");

  eHeli waittill("death");
  if((isDefined(eHeli.firingguns)) && (eHeli.firingguns == true)) {
    self thread minigun_spindown_sound();
  }
}

attack_heli_cleanup() {
  self waittill_either("death", "crash_done");
  if(isDefined(self.attractor)) {
    Missile_DeleteAttractor(self.attractor);
  }

  if(isDefined(self.attractor2)) {
    Missile_DeleteAttractor(self.attractor2);
  }
}

heli_default_missiles_on(customMissiles) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_default_heli_missiles");
  self.preferredTarget = undefined;
  while(isDefined(self)) {
    wait(0.05);
    eTarget = undefined;
    iShots = undefined;
    delay = undefined;
    self.preferredTarget = undefined;
    eNextNode = undefined;

    if((isDefined(self.currentnode)) && (isDefined(self.currentnode.target))) {
      eNextNode = getent_or_struct(self.currentnode.target, "targetname");
    }

    if((isDefined(eNextNode)) && (isDefined(eNextNode.script_linkTo))) {
      self.preferredTarget = getent_or_struct(eNextNode.script_linkTo, "script_linkname");
    }

    if(isDefined(self.preferredTarget)) {
      eTarget = self.preferredTarget;
      iShots = eTarget.script_shotcount;
      delay = eTarget.script_delay;
      eNextNode waittill("trigger");
    } else
      self waittill_any("near_goal", "goal");

    if(isDefined(eTarget)) {
      self thread heli_fire_missiles(eTarget, iShots, delay, customMissiles);
    }
  }
}

heli_default_missiles_off() {
  self notify("stop_default_heli_missiles");
}

heli_spotlight_on(sTag, bUseAttackHeliBehavior) {
  if(!isDefined(sTag)) {
    sTag = "tag_barrel";
  }
  if(!isDefined(bUseAttackHeliBehavior)) {
    bUseAttackHeliBehavior = false;
  }

  playFXOnTag(getfx("_attack_heli_spotlight"), self, sTag);
  self.spotlight = 1;
  self thread heli_spotlight_cleanup(sTag);

  if(bUseAttackHeliBehavior) {
    self endon("death");
    self endon("heli_players_dead");
    spawn_origin = self GetTagOrigin("tag_origin");

    if(!isDefined(self.targetdefault)) {
      self heli_default_target_setup();
    }
    self SetTurretTargetEnt(self.targetdefault);
    self thread heli_spotlight_aim();
  }
}

heli_spotlight_off() {
  self notify("turn_off_spotlight");
}

heli_spotlight_random_targets_on() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_spotlight_random_targets");

  if(!isDefined(self.targetdefault)) {
    self thread heli_default_target_setup();
  }

  if(!isDefined(self.left_ent)) {
    self thread heli_spotlight_think();
  }

  wait(.05);
  self SetTurretTargetEnt(self.targetdefault, (0, 0, 0));
}
}

heli_spotlight_random_targets_off() {
  self notify("stop_spotlight_random_targets");
}

heli_fire_missiles(eTarget, iShots, delay, customMissiles) {
  self endon("death");
  self endon("heli_players_dead");
  if(isDefined(self.defaultWeapon)) {
    defaultWeapon = self.defaultWeapon;
  } else {
    defaultWeapon = "turret_attackheli";
  }
  weaponName = "missile_attackheli";
  if(isDefined(customMissiles)) {
    weaponName = customMissiles;
  }
  loseTargetDelay = undefined;
  tags = [];
  self SetVehWeapon(defaultWeapon);
  if(!isDefined(iShots)) {
    iShots = 1;
  }
  if(!isDefined(delay)) {
    delay = 1;
  }

  if(!isDefined(eTarget.classname)) {
    if(!isDefined(self.dummyTarget)) {
      self.dummyTarget = spawn("script_origin", eTarget.origin);
      self thread delete_on_death(self.dummyTarget);
    }
    self.dummyTarget.origin = eTarget.origin;
    eTarget = self.dummyTarget;
  }

  switch (self.vehicletype) {
    case "mi28":
      loseTargetDelay = 0.5;
      tags[0] = "tag_store_L_2_a";
      tags[1] = "tag_store_R_2_a";
      tags[2] = "tag_store_L_2_b";
      tags[3] = "tag_store_R_2_b";
      tags[4] = "tag_store_L_2_c";
      tags[5] = "tag_store_R_2_c";
      tags[6] = "tag_store_L_2_d";
      tags[7] = "tag_store_R_2_d";
      break;
    case "littlebird":
      loseTargetDelay = 0.5;
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    default:
      AssertMsg("Missiles have not been setup for helicoper model: " + self.vehicletype);
      break;
  }
  nextMissileTag = -1;

  for(i = 0; i < iShots; i++) {
    nextMissileTag++;
    if(nextMissileTag >= tags.size) {
      nextMissileTag = 0;
    }

    self SetVehWeapon(weaponName);
    self.firingMissiles = true;
    eMissile = self FireWeapon(tags[nextMissileTag], eTarget);

    eMissile thread missile_earthquake();
    if(i < iShots - 1) {
      wait delay;
    }
  }
  self.firingMissiles = false;
  self SetVehWeapon(defaultWeapon);
}

boneyard_style_heli_missile_attack() {
  self waittill("trigger", vehicle);
  struct_arr = getStructArray(self.target, "targetname");
  struct_arr = array_index_by_script_index(struct_arr);

  boneyard_fire_at_targets(vehicle, struct_arr);
}

boneyard_style_heli_missile_attack_linked() {
  self waittill("trigger", vehicle);

  struct_arr = self get_linked_structs();
  struct_arr = array_index_by_script_index(struct_arr);

  boneyard_fire_at_targets(vehicle, struct_arr);
}

boneyard_fire_at_targets(vehicle, struct_arr) {
  tags = [];
  tags[0] = "tag_missile_right";
  tags[1] = "tag_missile_left";

  if(level.script == "roadkill") {
    tags[0] = "tag_flash_2";
    tags[1] = "tag_flash_11";
  }

  if(vehicle.vehicletype == "cobra") {
    tags[0] = "tag_store_L_1_a";
    tags[1] = "tag_store_R_1_a";
  }

  ents = [];

  for(i = 0; i < struct_arr.size; i++) {
    AssertEx(isDefined(struct_arr[i]), "boneyard_style_heli_missile_attack requires script_index key/value to start at 0 and not have any gaps.");

    ents[i] = spawn("script_origin", struct_arr[i].origin);

    vehicle SetVehWeapon("littlebird_FFAR");
    vehicle SetTurretTargetEnt(ents[i]);
    missile = vehicle FireWeapon(tags[i % tags.size], ents[i], (0, 0, 0));

    missile delayCall(1, ::Missile_ClearTarget);

    wait RandomFloatRange(0.2, 0.3);
  }

  wait 2;
  foreach(ent in ents) {
    ent Delete();
  }
}