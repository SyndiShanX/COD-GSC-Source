/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_helicopter.gsc
**************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

precachehelicopter(model, type) {
  if(!isDefined(type)) {
    type = "blackhawk";
  }

  deathfx = loadfx("explosions/tanker_explosion");

  precacheModel(model);
  level.vehicle_deathmodel[model] = model;

  precacheitem("cobra_FFAR_mp");
  precacheitem("hind_FFAR_mp");
  precacheitem("cobra_20mm_mp");

  level.cobra_missile_models = [];
  level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";

  precachemodel(level.cobra_missile_models["cobra_Hellfire"]);

  level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "cobra_helicopter_crash";
  level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level.heli_sound["axis"]["hit"] = "hind_helicopter_hit";
  level.heli_sound["axis"]["hitsecondary"] = "hind_helicopter_secondary_exp";
  level.heli_sound["axis"]["damaged"] = "hind_helicopter_damaged";
  level.heli_sound["axis"]["spinloop"] = "hind_helicopter_dying_loop";
  level.heli_sound["axis"]["spinstart"] = "hind_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "hind_helicopter_crash";
  level.heli_sound["axis"]["missilefire"] = "weap_hind_missile_fire";
}
heli_path_graph() {
  path_start = getEntArray("heli_start", "targetname");
  path_dest = getEntArray("heli_dest", "targetname");
  loop_start = getEntArray("heli_loop_start", "targetname");
  leave_nodes = getEntArray("heli_leave", "targetname");
  crash_start = getEntArray("heli_crash_start", "targetname");

  assertex((isDefined(path_start) && isDefined(path_dest)), "Missing path_start or path_dest");

  for(i = 0; i < path_dest.size; i++) {
    startnode_array = [];

    destnode_pointer = path_dest[i];
    destnode = getent(destnode_pointer.target, "targetname");

    for(j = 0; j < path_start.size; j++) {
      toDest = false;
      currentnode = path_start[j];

      while(isDefined(currentnode.target)) {
        nextnode = getent(currentnode.target, "targetname");
        if(nextnode.origin == destnode.origin) {
          {}
          toDest = true;
          break;
        }

        debug_print3d_simple("+", currentnode, (0, 0, -10));
        if(isDefined(nextnode.target)) {
          debug_line(nextnode.origin, getent(nextnode.target, "targetname").origin, (0.25, 0.5, 0.25));
        }
        if(isDefined(currentnode.script_delay)) {
          debug_print3d_simple("Wait: " + currentnode.script_delay, currentnode, (0, 0, 10));
        }

        currentnode = nextnode;
      }
      if(toDest) {
        startnode_array[startnode_array.size] = getent(path_start[j].target, "targetname");
      }
    }
    assertex((isDefined(startnode_array) && startnode_array.size > 0), "No path(s) to destination");

    level.heli_paths[level.heli_paths.size] = startnode_array;
  }

  for(i = 0; i < loop_start.size; i++) {
    startnode = getent(loop_start[i].target, "targetname");
    level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
  }
  assertex(isDefined(level.heli_loop_paths[0]), "No helicopter loop paths found in map");

  for(i = 0; i < leave_nodes.size; i++) {
    level.heli_leavenodes[level.heli_leavenodes.size] = leave_nodes[i];
  }
  assertex(isDefined(level.heli_leavenodes[0]), "No helicopter leave nodes found in map");

  for(i = 0; i < crash_start.size; i++) {
    crash_start_node = getent(crash_start[i].target, "targetname");
    level.heli_crash_paths[level.heli_crash_paths.size] = crash_start_node;
  }
  assertex(isDefined(level.heli_crash_paths[0]), "No helicopter crash paths found in map");
}

init() {
  path_start = getEntArray("heli_start", "targetname");
  loop_start = getEntArray("heli_loop_start", "targetname");

  if(!path_start.size && !loop_start.size) {
    return;
  }

  precachehelicopter("vehicle_cobra_helicopter_fly");
  precachehelicopter("vehicle_mi24p_hind_desert");

  level.chopper = undefined;
  level.heli_paths = [];
  level.heli_loop_paths = [];
  level.heli_leavenodes = [];
  level.heli_crash_paths = [];

  thread heli_update_global_dvars();

  level.chopper_fx["explode"]["death"] = loadfx("explosions/helicopter_explosion_cobra");
  level.chopper_fx["explode"]["large"] = loadfx("explosions/aerial_explosion_large");
  level.chopper_fx["explode"]["medium"] = loadfx("explosions/aerial_explosion");
  level.chopper_fx["smoke"]["trail"] = loadfx("smoke/smoke_trail_white_heli");
  level.chopper_fx["fire"]["trail"]["medium"] = loadfx("smoke/smoke_trail_black_heli");
  level.chopper_fx["fire"]["trail"]["large"] = loadfx("fire/fire_smoke_trail_L");

  heli_path_graph();
}
heli_update_global_dvars() {
  for(;;) {
    level.heli_loopmax = heli_get_dvar_int("scr_heli_loopmax", "1");
    level.heli_missile_rof = heli_get_dvar_int("scr_heli_missile_rof", "5");
    level.heli_armor = heli_get_dvar_int("scr_heli_armor", "500");
    level.heli_rage_missile = heli_get_dvar("scr_heli_rage_missile", "5");
    level.heli_maxhealth = heli_get_dvar_int("scr_heli_maxhealth", "1100");
    level.heli_missile_max = heli_get_dvar_int("scr_heli_missile_max", "3");
    level.heli_dest_wait = heli_get_dvar_int("scr_heli_dest_wait", "2");
    level.heli_debug = heli_get_dvar_int("scr_heli_debug", "0");

    level.heli_targeting_delay = heli_get_dvar("scr_heli_targeting_delay", "0.5");
    level.heli_turretReloadTime = heli_get_dvar("scr_heli_turretReloadTime", "1.5");
    level.heli_turretClipSize = heli_get_dvar_int("scr_heli_turretClipSize", "40");
    level.heli_visual_range = heli_get_dvar_int("scr_heli_visual_range", "3500");
    level.heli_health_degrade = heli_get_dvar_int("scr_heli_health_degrade", "0");

    level.heli_target_spawnprotection = heli_get_dvar_int("scr_heli_target_spawnprotection", "5");
    level.heli_turret_engage_dist = heli_get_dvar_int("scr_heli_turret_engage_dist", "1000");
    level.heli_missile_engage_dist = heli_get_dvar_int("scr_heli_missile_engage_dist", "2000");
    level.heli_missile_regen_time = heli_get_dvar("scr_heli_missile_regen_time", "10");
    level.heli_turret_spinup_delay = heli_get_dvar("scr_heli_turret_spinup_delay", "0.75");
    level.heli_target_recognition = heli_get_dvar("scr_heli_target_recognition", "0.5");
    level.heli_missile_friendlycare = heli_get_dvar_int("scr_heli_missile_friendlycare", "256");
    level.heli_missile_target_cone = heli_get_dvar("scr_heli_missile_target_cone", "0.3");
    level.heli_armor_bulletdamage = heli_get_dvar("scr_heli_armor_bulletdamage", "0.3");

    level.heli_attract_strength = heli_get_dvar("scr_heli_attract_strength", "1000");
    level.heli_attract_range = heli_get_dvar("scr_heli_attract_range", "4096");

    wait 1;
  }
}

heli_get_dvar_int(dvar, def) {
  return int(heli_get_dvar(dvar, def));
}
heli_get_dvar(dvar, def) {
  if(getDvar(dvar) != "") {
    return getdvarfloat(dvar);
  } else {
    setDvar(dvar, def);
    return def;
  }
}

spawn_helicopter(owner, origin, angles, model, targetname) {
  chopper = spawnHelicopter(owner, origin, angles, model, targetname);
  chopper.attractor = Missile_CreateAttractorEnt(chopper, level.heli_attract_strength, level.heli_attract_range);
  return chopper;
}
heli_think(owner, startnode, heli_team, requiredDeathCount) {
  heliOrigin = startnode.origin;
  heliAngles = startnode.angles;

  if(heli_team == "allies") {
    chopper = spawn_helicopter(owner, heliOrigin, heliAngles, "cobra_mp", "vehicle_cobra_helicopter_fly");
    chopper playLoopSound("mp_cobra_helicopter");
  } else {
    chopper = spawn_helicopter(owner, heliOrigin, heliAngles, "cobra_mp", "vehicle_mi24p_hind_desert");
    chopper playLoopSound("mp_hind_helicopter");
  }

  chopper.requiredDeathCount = owner.deathCount;

  chopper.team = heli_team;
  chopper.pers["team"] = heli_team;

  chopper.owner = owner;
  chopper thread heli_existance();

  level.chopper = chopper;

  chopper.reached_dest = false;
  chopper.maxhealth = level.heli_maxhealth;
  chopper.waittime = level.heli_dest_wait;
  chopper.loopcount = 0;
  chopper.evasive = false;
  chopper.health_bulletdamageble = level.heli_armor;
  chopper.health_evasive = level.heli_armor;
  chopper.health_low = level.heli_maxhealth * 0.8;
  chopper.targeting_delay = level.heli_targeting_delay;
  chopper.primaryTarget = undefined;
  chopper.secondaryTarget = undefined;
  chopper.attacker = undefined;
  chopper.missile_ammo = level.heli_missile_max;
  chopper.currentstate = "ok";
  chopper.lastRocketFireTime = -1;

  chopper thread heli_fly(startnode);
  chopper thread heli_damage_monitor();
  chopper thread heli_health();
  chopper thread attack_targets();
  chopper thread heli_targeting();
  chopper thread heli_missile_regen();
}

heli_existance() {
  self waittill_any("death", "crashing", "leaving");
  level notify("helicopter gone");
}

heli_missile_regen() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    debug_print3d("Missile Ammo: " + self.missile_ammo, (0.5, 0.5, 1), self, (0, 0, -100), 0);

    if(self.missile_ammo >= level.heli_missile_max) {
      self waittill("missile fired");
    } else {
      if(self.currentstate == "heavy smoke") {
        wait(level.heli_missile_regen_time / 4);
      } else if(self.currentstate == "light smoke") {
        wait(level.heli_missile_regen_time / 2);
      } else {
        wait(level.heli_missile_regen_time);
      }
    }
    if(self.missile_ammo < level.heli_missile_max) {
      self.missile_ammo++;
    }
  }
}
heli_targeting() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    targets = [];

    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(canTarget_turret(player)) {
        if(isDefined(player)) {
          targets[targets.size] = player;
        }
      } else {
        continue;
      }
    }

    if(targets.size == 0) {
      self.primaryTarget = undefined;
      self.secondaryTarget = undefined;
      debug_print_target();
      wait(self.targeting_delay);
      continue;
    } else if(targets.size == 1) {
      update_player_threat(targets[0]);
      self.primaryTarget = targets[0];
      self notify("primary acquired");
      self.secondaryTarget = undefined;
      debug_print_target();
      wait(self.targeting_delay);
      continue;
    } else if(targets.size > 1) {
      assignTargets(targets);
    }

    debug_print_target();
  }
}
canTarget_turret(player) {
  canTarget = true;

  if(!isalive(player) || player.sessionstate != "playing") {
    return false;
  }

  if(distance(player.origin, self.origin) > level.heli_visual_range) {
    return false;
  }

  if(!isDefined(player.pers["team"])) {
    return false;
  }

  if(level.teamBased && player.pers["team"] == self.team) {
    return false;
  }

  if(player == self.owner) {
    return false;
  }

  if(player.pers["team"] == "spectator") {
    return false;
  }

  if(isDefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
    return false;
  }

  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;

  if(player sightConeTrace(heli_turret_point, self) < level.heli_target_recognition) {
    return false;
  }

  return canTarget;
}
assignTargets(targets) {
  for(idx = 0; idx < targets.size; idx++) {
    update_player_threat(targets[idx]);
  }

  assertex(targets.size >= 2, "Not enough targets to assign primary and secondary");

  highest = 0;
  second_highest = 0;
  primaryTarget = undefined;
  secondaryTarget = undefined;

  for(idx = 0; idx < targets.size; idx++) {
    assertex(isDefined(targets[idx].threatlevel), "Target player does not have threat level");
    if(targets[idx].threatlevel >= highest) {
      highest = targets[idx].threatlevel;
      primaryTarget = targets[idx];
    }
  }
  for(idx = 0; idx < targets.size; idx++) {
    assertex(isDefined(targets[idx].threatlevel), "Target player does not have threat level");
    if(targets[idx].threatlevel >= second_highest && targets[idx] != primaryTarget) {
      second_highest = targets[idx].threatlevel;
      secondaryTarget = targets[idx];
    }
  }

  assertex(isDefined(primaryTarget), "Targets exist, but none was assigned as primary");
  self.primaryTarget = primaryTarget;
  self notify("primary acquired");

  assertex(isDefined(secondaryTarget), "2+ targets exist, but none was assigned as secondary");
  self.secondaryTarget = secondaryTarget;
  self notify("secondary acquired");

  assertex(self.secondaryTarget != self.primaryTarget, "Primary and secondary targets are the same");

  wait(self.targeting_delay);
}
update_player_threat(player) {
  player.threatlevel = 0;

  dist = distance(player.origin, self.origin);
  player.threatlevel += ((level.heli_visual_range - dist) / level.heli_visual_range) * 100;

  if(isDefined(self.attacker) && player == self.attacker) {
    player.threatlevel += 100;
  }

  if(isDefined(player.pers["class"]) && (player.pers["class"] == "CLASS_ASSAULT" || player.pers["class"] == "CLASS_RECON")) {
    player.threatlevel += 200;
  }

  player.threatlevel += player.score * 4;

  if(isDefined(player.antithreat)) {
    player.threatlevel -= player.antithreat;
  }

  if(player.threatlevel <= 0) {
    player.threatlevel = 1;
  }
}
heli_reset() {
  self clearTargetYaw();
  self clearGoalYaw();
  self setspeed(60, 25);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

heli_wait(waittime) {
  self endon("death");
  self endon("crashing");
  self endon("evasive");

  wait(waittime);
}
heli_hover() {
  self endon("death");
  self endon("stop hover");
  self endon("evasive");
  self endon("leaving");
  self endon("crashing");

  original_pos = self.origin;
  original_angles = self.angles;
  self setyawspeed(10, 45, 45);

  x = 0;
  y = 0;
}
heli_damage_monitor() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  self.damageTaken = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, P, type);

    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }

    heli_friendlyfire = maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker);

    if(!heli_friendlyfire) {
      continue;
    }

    if(isDefined(self.owner) && attacker == self.owner) {
      continue;
    }

    if(level.teamBased) {
      isValidAttacker = (isDefined(attacker.pers["team"]) && attacker.pers["team"] != self.team);
    } else {
      isValidAttacker = true;
    }

    if(!isValidAttacker) {
      continue;
    }

    attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
    self.attacker = attacker;

    if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET") {
      if(self.damageTaken >= self.health_bulletdamageble) {
        self.damageTaken += damage;
      } else {
        self.damageTaken += damage * level.heli_armor_bulletdamage;
      }
    } else {
      self.damageTaken += damage;
    }

    if(self.damageTaken > self.maxhealth) {
      attacker notify("destroyed_helicopter");
    }
  }
}

heli_health() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);

  for(;;) {
    if(self.health_bulletdamageble > self.health_low) {
      if(self.damageTaken >= self.health_bulletdamageble) {
        self.currentstate = "heavy smoke";
      } else if(self.damageTaken >= self.health_low) {
        self.currentstate = "light smoke";
      }
    } else {
      if(self.damageTaken >= self.health_low) {
        self.currentstate = "heavy smoke";
      } else if(self.damageTaken >= self.health_bulletdamageble) {
        self.currentstate = "light smoke";
      }
    }

    if(self.currentstate == "light smoke" && self.laststate != "light smoke") {
      self setdamagestage(2);
      self.laststate = self.currentstate;
    }
    if(self.currentstate == "heavy smoke" && self.laststate != "heavy smoke") {
      self setdamagestage(1);
      self notify("stop body smoke");
      self.laststate = self.currentstate;
    }

    if(self.currentstate == "heavy smoke") {
      self.damageTaken += level.heli_health_degrade;
      level.heli_rage_missile = 20;
    }
    if(self.currentstate == "light smoke") {
      self.damageTaken += level.heli_health_degrade / 2;
      level.heli_rage_missile = 10;
    }

    if(self.damageTaken >= self.health_evasive) {
      if(!self.evasive) {
        self thread heli_evasive();
      }
    }

    if(self.damageTaken > self.maxhealth) {
      self thread heli_crash();
    }

    if(self.damageTaken <= level.heli_armor) {
      debug_print3d_simple("Armor: " + (level.heli_armor - self.damageTaken), self, (0, 0, 100), 20);
    } else {
      debug_print3d_simple("Health: " + (self.maxhealth - self.damageTaken), self, (0, 0, 100), 20);
    }

    wait 1;
  }
}
heli_evasive() {
  self notify("evasive");

  self.evasive = true;

  loop_startnode = level.heli_loop_paths[0];
  self thread heli_fly(loop_startnode);
}
heli_crash() {
  self notify("crashing");

  self thread heli_fly(level.heli_crash_paths[0]);

  self thread heli_spin(180);

  self waittill("path start");

  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
  self playSound(level.heli_sound[self.team]["hitsecondary"]);

  self setdamagestage(0);
  self thread trail_fx(level.chopper_fx["fire"]["trail"]["large"], "tag_engine_left", "stop body fire");

  self waittill("destination reached");
  self thread heli_explode();
}
heli_spin(speed) {
  self endon("death");

  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  self playSound(level.heli_sound[self.team]["hit"]);

  self thread spinSoundShortly();

  self thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");

  self setyawspeed(speed, speed, speed);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + (speed * 0.9));
    wait(1);
  }
}

spinSoundShortly() {
  self endon("death");

  wait .25;

  self stopLoopSound();
  wait .05;
  self playLoopSound(level.heli_sound[self.team]["spinloop"]);
  wait .05;
  self playSound(level.heli_sound[self.team]["spinstart"]);
}
trail_fx(trail_fx, trail_tag, stop_notify) {
  self notify(stop_notify);
  self endon(stop_notify);
  self endon("death");

  for(;;) {
    playFXOnTag(trail_fx, self, trail_tag);
    wait(0.05);
  }
}
heli_explode() {
  self notify("death");

  forward = (self.origin + (0, 0, 100)) - self.origin;
  playFX(level.chopper_fx["explode"]["death"], self.origin, forward);

  self playSound(level.heli_sound[self.team]["crash"]);

  level.chopper = undefined;
  self delete();
}
heli_leave() {
  self notify("desintation reached");
  self notify("leaving");

  random_leave_node = randomInt(level.heli_leavenodes.size);
  leavenode = level.heli_leavenodes[random_leave_node];

  heli_reset();
  self setspeed(100, 45);
  self setvehgoalpos(leavenode.origin, 1);
  self waittillmatch("goal");
  self notify("death");

  level.chopper = undefined;
  self delete();
}

heli_fly(currentnode) {
  self endon("death");

  self notify("flying");
  self endon("flying");

  self endon("abandoned");

  self.reached_dest = false;
  heli_reset();

  pos = self.origin;
  wait(2);

  while(isDefined(currentnode.target)) {
    nextnode = getent(currentnode.target, "targetname");
    assertex(isDefined(nextnode), "Next node in path is undefined, but has targetname");

    pos = nextnode.origin + (0, 0, 30);

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      heli_speed = currentnode.script_airspeed;
      heli_accel = currentnode.script_accel;
    } else {
      heli_speed = 30 + randomInt(20);
      heli_accel = 15 + randomInt(15);
    }

    if(!isDefined(nextnode.target)) {
      stop = 1;
    } else {
      stop = 0;
    }

    debug_line(currentnode.origin, nextnode.origin, (1, 0.5, 0.5), 200);

    if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke") {
      self setspeed(heli_speed, heli_accel);
      self setvehgoalpos((pos), stop);

      self waittill("near_goal");
      self notify("path start");
    } else {
      if(isDefined(nextnode.script_delay)) {
        stop = 1;
      }

      self setspeed(heli_speed, heli_accel);
      self setvehgoalpos((pos), stop);

      if(!isDefined(nextnode.script_delay)) {
        self waittill("near_goal");
        self notify("path start");
      } else {
        self setgoalyaw(nextnode.angles[1]);

        self waittillmatch("goal");
        heli_wait(nextnode.script_delay);
      }
    }

    for(index = 0; index < level.heli_loop_paths.size; index++) {
      if(level.heli_loop_paths[index].origin == nextnode.origin) {
        self.loopcount++;
      }
    }
    if(self.loopcount >= level.heli_loopmax) {
      self thread heli_leave();
      return;
    }
    currentnode = nextnode;
  }

  self setgoalyaw(currentnode.angles[1]);
  self.reached_dest = true;
  self notify("destination reached");
  heli_wait(self.waittime);

  if(isDefined(self)) {
    self thread heli_evasive();
  }
}

fire_missile(sMissileType, iShots, eTarget) {
  if(!isDefined(iShots)) {
    iShots = 1;
  }
  assert(self.health > 0);

  weaponName = undefined;
  weaponShootTime = undefined;
  defaultWeapon = "cobra_20mm_mp";
  tags = [];
  switch (sMissileType) {
    case "ffar":
      if(self.team == "allies") {
        weaponName = "cobra_FFAR_mp";
      } else {
        weaponName = "hind_FFAR_mp";
      }

      tags[0] = "tag_store_r_2";
      break;
    default:
      assertMsg("Invalid missile type specified. Must be ffar");
      break;
  }
  assert(isDefined(weaponName));
  assert(tags.size > 0);

  weaponShootTime = weaponfiretime(weaponName);
  assert(isDefined(weaponShootTime));

  self setVehWeapon(weaponName);
  nextMissileTag = -1;
  for(i = 0; i < iShots; i++) {
    nextMissileTag++;
    if(nextMissileTag >= tags.size) {
      nextMissileTag = 0;
    }

    if(isDefined(eTarget)) {
      eMissile = self fireWeapon(tags[nextMissileTag], eTarget);
    } else {
      eMissile = self fireWeapon(tags[nextMissileTag]);
    }
    self.lastRocketFireTime = gettime();

    if(i < iShots - 1) {
      wait weaponShootTime;
    }
  }
}

check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    self notify("abandoned");
    self thread heli_leave();
  }
}

attack_targets() {
  self thread attack_primary();
  self thread attack_secondary();
}
attack_secondary() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    if(isDefined(self.secondaryTarget)) {
      self.secondaryTarget.antithreat = undefined;
      self.missileTarget = self.secondaryTarget;

      antithreat = 0;

      while(isDefined(self.missileTarget) && isalive(self.missileTarget)) {
        if(self missile_target_sight_check(self.missileTarget)) {
          self thread missile_support(self.missileTarget, level.heli_missile_rof, true, undefined);
        } else {
          break;
        }

        antithreat += 100;
        self.missileTarget.antithreat = antithreat;

        self waittill("missile ready");

        if(!isDefined(self.secondaryTarget) || (isDefined(self.secondaryTarget) && self.missileTarget != self.secondaryTarget)) {
          break;
        }
      }

      if(isDefined(self.missileTarget)) {
        self.missileTarget.antithreat = undefined;
      }
    }
    self waittill("secondary acquired");

    self check_owner();
  }
}
missile_target_sight_check(missiletarget) {
  heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
  heli2forward = anglesToForward(self.angles);
  heli2forward_normal = vectornormalize(heli2forward);

  heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);

  if(heli_dot_target >= level.heli_missile_target_cone) {
    debug_print3d_simple("Missile sight: " + heli_dot_target, self, (0, 0, -40), 40);
    return true;
  }
  return false;
}
missile_support(target_player, rof, instantfire, endon_notify) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isDefined(endon_notify)) {
    self endon(endon_notify);
  }

  self.turret_giveup = false;

  if(!instantfire) {
    wait(rof);
    self.turret_giveup = true;
    self notify("give up");
  }

  if(isDefined(target_player)) {
    if(level.teambased) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if(isDefined(player.pers["team"]) && player.pers["team"] == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
          {}
          debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
          self notify("missile ready");
          return;
        }
      }
    } else {
      player = self.owner;
      if(isDefined(player) && isDefined(player.pers["team"]) && player.pers["team"] == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
        debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
        self notify("missile ready");
        return;
      }
    }
  }

  if(self.missile_ammo > 0 && isDefined(target_player)) {
    self fire_missile("ffar", 1, target_player);
    self.missile_ammo--;
    self notify("missile fired");
  } else {
    return;
  }

  if(instantfire) {
    wait(rof);
    self notify("missile ready");
  }
}
attack_primary() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    if(isDefined(self.primaryTarget)) {
      self.primaryTarget.antithreat = undefined;
      self.turretTarget = self.primaryTarget;

      antithreat = 0;
      last_pos = undefined;

      while(isDefined(self.turretTarget) && isalive(self.turretTarget)) {
        self setTurretTargetEnt(self.turretTarget, (0, 0, 40));

        if(self missile_target_sight_check(self.turretTarget)) {
          self thread missile_support(self.turretTarget, 10 / level.heli_rage_missile, false, "turret on target");
        }

        self waittill("turret_on_target");

        self notify("turret on target");

        self thread turret_target_flag(self.turretTarget);

        wait(level.heli_turret_spinup_delay);

        weaponShootTime = weaponfiretime("cobra_20mm_mp");
        self setVehWeapon("cobra_20mm_mp");

        for(i = 0; i < level.heli_turretClipSize; i++) {
          {}

          if(isDefined(self.turretTarget) && isDefined(self.primaryTarget)) {
            if(self.primaryTarget != self.turretTarget) {
              self setTurretTargetEnt(self.primaryTarget, (0, 0, 40));
            }
          } else {
            if(isDefined(self.targetlost) && self.targetlost && isDefined(self.turret_last_pos)) {
              {}

              self setturrettargetvec(self.turret_last_pos);
            } else {
              {}
              self clearturrettarget();
            }
          }
          if(gettime() != self.lastRocketFireTime) {
            self setVehWeapon("cobra_20mm_mp");
            miniGun = self fireWeapon("tag_flash");
          }

          if(i < level.heli_turretClipSize - 1) {
            wait weaponShootTime;
          }
        }
        self notify("turret reloading");

        wait(level.heli_turretReloadTime);

        if(isDefined(self.turretTarget) && isalive(self.turretTarget)) {
          {}
          antithreat += 100;
          self.turretTarget.antithreat = antithreat;
        }

        if(!isDefined(self.primaryTarget) || (isDefined(self.turretTarget) && isDefined(self.primaryTarget) && self.primaryTarget != self.turretTarget)) {
          break;
        }
      }

      if(isDefined(self.turretTarget)) {
        self.turretTarget.antithreat = undefined;
      }
    }
    self waittill("primary acquired");

    self check_owner();
  }
}
turret_target_flag(turrettarget) {
  self notify("flag check is running");
  self endon("flag check is running");

  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("turret reloading");

  turrettarget endon("death");
  turrettarget endon("disconnect");

  self.targetlost = false;
  self.turret_last_pos = undefined;

  while(isDefined(turrettarget)) {
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglesToForward(self.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;

    sight_rec = turrettarget sightconetrace(heli_turret_point, self);
    if(sight_rec < level.heli_target_recognition) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(turrettarget) && isDefined(turrettarget.origin)) {
    assertex(isDefined(turrettarget.origin), "turrettarget.origin is undefined after isdefined check");
    self.turret_last_pos = turrettarget.origin + (0, 0, 40);
    assertex(isDefined(self.turret_last_pos), "self.turret_last_pos is undefined after setting it #1");
    self setturrettargetvec(self.turret_last_pos);
    assertex(isDefined(self.turret_last_pos), "self.turret_last_pos is undefined after setting it #2");
    debug_print3d_simple("Turret target lost at: " + self.turret_last_pos, self, (0, 0, -70), 60);
    self.targetlost = true;
  } else {
    self.targetlost = undefined;
    self.turret_last_pos = undefined;
  }
}
debug_print_target() {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isDefined(self.primaryTarget) && isDefined(self.primaryTarget.threatlevel)) {
      primary_msg = "Primary: " + self.primaryTarget.name + " : " + self.primaryTarget.threatlevel;
    } else {
      primary_msg = "Primary: ";
    }

    if(isDefined(self.secondaryTarget) && isDefined(self.secondaryTarget.threatlevel)) {
      secondary_msg = "Secondary: " + self.secondaryTarget.name + " : " + self.secondaryTarget.threatlevel;
    } else {
      secondary_msg = "Secondary: ";
    }

    frames = int(self.targeting_delay * 20) + 1;

    thread draw_text(primary_msg, (1, 0.6, 0.6), self, (0, 0, 40), frames);
    thread draw_text(secondary_msg, (1, 0.6, 0.6), self, (0, 0, 0), frames);
  }
}

debug_print3d(message, color, ent, origin_offset, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    self thread draw_text(message, color, ent, origin_offset, frames);
  }
}

debug_print3d_simple(message, ent, offset, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isDefined(frames)) {
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, frames);
    } else {
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
    }
  }
}

debug_line(from, to, color, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0 && !isDefined(frames)) {
    thread draw_line(from, to, color);
  } else if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    thread draw_line(from, to, color, frames);
  }
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
improved_sightconetrace(helicopter) {
  heli_centroid = helicopter.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(helicopter.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  draw_line(heli_turret_point, self.origin, (1, 1, 1), 5);
  start = heli_turret_point;
  yes = 0;
  point = [];

  for(i = 0; i < 5; i++) {
    if(!isDefined(self)) {
      break;
    }

    half_height = self.origin + (0, 0, 36);

    tovec = start - half_height;
    tovec_angles = vectortoangles(tovec);
    forward_norm = anglesToForward(tovec_angles);
    side_norm = anglestoright(tovec_angles);

    point[point.size] = self.origin + (0, 0, 36);
    point[point.size] = self.origin + side_norm * (15, 15, 0) + (0, 0, 10);
    point[point.size] = self.origin + side_norm * (-15, -15, 0) + (0, 0, 10);
    point[point.size] = point[2] + (0, 0, 64);
    point[point.size] = point[1] + (0, 0, 64);

    draw_line(point[1], point[2], (1, 1, 1), 1);
    draw_line(point[2], point[3], (1, 1, 1), 1);
    draw_line(point[3], point[4], (1, 1, 1), 1);
    draw_line(point[4], point[1], (1, 1, 1), 1);

    if(bullettracepassed(start, point[i], true, self)) {
      draw_line(start, point[i], (randomInt(10) / 10, randomInt(10) / 10, randomInt(10) / 10), 1);
      yes++;
    }
    waittillframeend;
  }
  return yes / 5;
}