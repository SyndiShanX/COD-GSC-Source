/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_helicopter.gsc
**************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_airsupport;

precachehelicopter(model, type) {
  if(!isDefined(type)) {
    type = "blackhawk";
  }
  deathfx = loadfx("explosions/fx_exp_tanker");
  precacheModel(model);
  level.vehicle_deathmodel[model] = model;
  PreCacheItem("cobra_20mm_mp");
  precacheitem("cobra_20mm_comlink_mp");
  PreCacheString(&"MP_DESTROYED_HELICOPTER");
  level.cobra_missile_models = [];
  level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
  precachemodel(level.cobra_missile_models["cobra_Hellfire"]);
  level.heli_sound["allies"]["hit"] = "evt_helicopter_hit";
  level.heli_sound["allies"]["hitsecondary"] = "evt_helicopter_hit";
  level.heli_sound["allies"]["damaged"] = "null";
  level.heli_sound["allies"]["spinloop"] = "evt_helicopter_spin_loop";
  level.heli_sound["allies"]["spinstart"] = "evt_helicopter_spin_start";
  level.heli_sound["allies"]["crash"] = "evt_helicopter_midair_exp";
  level.heli_sound["allies"]["missilefire"] = "wpn_hellfire_fire_npc";
  level.heli_sound["axis"]["hit"] = "evt_helicopter_hit";
  level.heli_sound["axis"]["hitsecondary"] = "evt_helicopter_hit";
  level.heli_sound["axis"]["damaged"] = "null";
  level.heli_sound["axis"]["spinloop"] = "evt_helicopter_spin_loop";
  level.heli_sound["axis"]["spinstart"] = "evt_helicopter_spin_start";
  level.heli_sound["axis"]["crash"] = "evt_helicopter_midair_exp";
  level.heli_sound["axis"]["missilefire"] = "wpn_hellfire_fire_npc";
  level.fx_heli_dust = loadfx("vehicle/treadfx/fx_heli_dust_default");
  level.fx_heli_water = loadfx("vehicle/treadfx/fx_heli_water_spray");
  level.fx_heli_flare = loadfx("vehicle/vexplosion/fx_hind_chaff");
  level.fx_heli_chaff = loadfx("vehicle/vexplosion/fx_heli_chaff");
  level._effect["chinook_light"]["friendly"] = loadfx("vehicle/light/fx_chinook_exterior_lights_grn_mp");
  level._effect["chinook_light"]["enemy"] = loadfx("vehicle/light/fx_chinook_exterior_lights_red_mp");
  level._effect["cobra_light"]["friendly"] = loadfx("vehicle/light/fx_cobra_exterior_lights_red_mp");
  level._effect["cobra_light"]["enemy"] = loadfx("vehicle/light/fx_cobra_exterior_lights_red_mp");
  level._effect["hind_light"]["friendly"] = loadfx("vehicle/light/fx_hind_exterior_lights_grn_mp");
  level._effect["hind_light"]["enemy"] = loadfx("vehicle/light/fx_hind_exterior_lights_red_mp");
  level._effect["huey_light"]["friendly"] = loadfx("vehicle/light/fx_huey_exterior_lights_grn_mp");
  level._effect["huey_light"]["enemy"] = loadfx("vehicle/light/fx_huey_exterior_lights_red_mp");
}
useKillstreakHelicopter(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  if((!isDefined(level.heli_paths) || !level.heli_paths.size)) {
    iprintlnbold("Need to add helicopter paths to the level");
    return false;
  }
  if(hardpointType == "helicopter_comlink_mp") {
    result = self maps\mp\_helicopter::selectHelicopterLocation(hardpointType);
    if(!isDefined(result) || result == false) {
      return false;
    }
  }
  destination = 0;
  missilesEnabled = false;
  if(hardpointType == "helicopter_x2_mp") {
    missilesEnabled = true;
  }
  assertex(level.heli_paths.size > 0, "No non-primary helicopter paths found in map");
  random_path = randomint(level.heli_paths[destination].size);
  startnode = level.heli_paths[destination][random_path];
  protectLocation = undefined;
  armored = false;
  if(hardpointType == "helicopter_comlink_mp") {
    protectLocation = (level.helilocation[0], level.helilocation[1], startnode.origin[2]);
    armored = true;
    startnode = getValidProtectLocationStart(random_path, protectLocation, destination);
  }
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointType, self.team) == false) {
    return false;
  }
  self thread announceHelicopterInbound(hardpointType);
  thread maps\mp\_helicopter::heli_think(self, startnode, self.team, missilesEnabled, protectLocation, hardpointType, armored);
  return true;
}
announceHelicopterInbound(hardpointType) {
  team = self.team;
  otherTeam = level.otherTeam[team];
  self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog(hardpointType, team, true);
  statAddType = "";
  reference = "";
  switch (hardpointtype) {
    case "helicopter_player_mp":
    case "helicopter_player_firstperson_mp":
      reference = "killstreak_helicopter_player_firstperson";
      statAddType = "HELICOPTER_PLAYER_USED";
      break;
    case "helicopter_gunner_mp":
      reference = "killstreak_helicopter_gunner";
      statAddType = "HELICOPTER_GUNNER_USED";
      break;
    case "helicopter_mp":
    case "helicopter_x2_mp":
      reference = "killstreak_helicopter";
      statAddType = "HELICOPTER_USED";
      break;
    case "helicopter_comlink_mp":
      reference = "killstreak_helicopter_comlink";
      statAddType = "HELICOPTER_COMLINK_USED";
      break;
  }
  if(statAddType != "") {
    self maps\mp\gametypes\_persistence::statAdd(statAddType, 1, false);
    level.globalKillstreaksCalled++;
    self maps\mp\gametypes\_globallogic_score::incItemStatByReference(reference, 1, "used");
  }
}
heli_path_graph() {
  path_start = getEntArray("heli_start", "targetname");
  path_dest = getEntArray("heli_dest", "targetname");
  loop_start = getEntArray("heli_loop_start", "targetname");
  gunner_loop_start = getEntArray("heli_gunner_loop_start", "targetname");
  leave_nodes = getEntArray("heli_leave", "targetname");
  crash_start = getEntArray("heli_crash_start", "targetname");
  assertex((isDefined(path_start) && isDefined(path_dest)), "Missing path_start or path_dest");
  for(i = 0; i < path_dest.size; i++) {
    startnode_array = [];
    isPrimaryDest = false;
    destnode_pointer = path_dest[i];
    destnode = getent(destnode_pointer.target, "targetname");
    for(j = 0; j < path_start.size; j++) {
      toDest = false;
      currentnode = path_start[j];
      while(isDefined(currentnode.target)) {
        nextnode = getent(currentnode.target, "targetname");
        if(nextnode.origin == destnode.origin) {
          toDest = true;
          break;
        }
        debug_print3d_simple("+", currentnode, (0, 0, -10));
        if(isDefined(nextnode.target)) {
          debug_line(nextnode.origin, getent(nextnode.target, "targetname").origin, (0.25, 0.5, 0.25), 5);
        }
        if(isDefined(currentnode.script_delay)) {
          debug_print3d_simple("Wait: " + currentnode.script_delay, currentnode, (0, 0, 10));
        }
        currentnode = nextnode;
      }
      if(toDest) {
        startnode_array[startnode_array.size] = getent(path_start[j].target, "targetname");
        if(isDefined(path_start[j].script_noteworthy) && (path_start[j].script_noteworthy == "primary")) {
          isPrimaryDest = true;
        }
      }
    }
    assertex((isDefined(startnode_array) && startnode_array.size > 0), "No path(s) to destination");
    if(isPrimaryDest) {
      level.heli_primary_path = startnode_array;
    }
    else {
      level.heli_paths[level.heli_paths.size] = startnode_array;
    }
  }
  for(i = 0; i < loop_start.size; i++) {
    startnode = getent(loop_start[i].target, "targetname");
    level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
  }
  assertex(isDefined(level.heli_loop_paths[0]), "No helicopter loop paths found in map");
  for(i = 0; i < gunner_loop_start.size; i++) {
    startnode = getent(gunner_loop_start[i].target, "targetname");
    startnode.isGunnerPath = true;
    level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
  }
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
  thread heli_update_global_dvars();
  if(!path_start.size && !loop_start.size) {
    return;
  }
  level.chaff_offset["attack"] = (-130, 0, -140);
  level.chopperComlinkFriendly = "vehicle_cobra_helicopter_mp_light";
  level.chopperComlinkEnemy = "vehicle_cobra_helicopter_mp_dark";
  level.chopperRegular = "t5_veh_helo_hind_killstreak";
  precachehelicopter(level.chopperRegular);
  precachehelicopter(level.chopperComlinkFriendly);
  precachehelicopter(level.chopperComlinkEnemy);
  PrecacheVehicle("heli_ai_mp");
  level.heli_paths = [];
  level.heli_loop_paths = [];
  level.heli_leavenodes = [];
  level.heli_crash_paths = [];
  level.chopper_fx["explode"]["death"] = loadfx("vehicle/vexplosion/fx_vexplode_helicopter_exp_mp");
  level.chopper_fx["explode"]["large"] = loadfx("vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm");
  level.chopper_fx["explode"]["medium"] = loadfx("explosions/fx_exp_aerial");
  level.chopper_fx["damage"]["light_smoke"] = loadfx("trail/fx_trail_heli_killstreak_engine_smoke_33");
  level.chopper_fx["damage"]["heavy_smoke"] = loadfx("trail/fx_trail_heli_killstreak_engine_smoke_66");
  level.chopper_fx["smoke"]["trail"] = loadfx("trail/fx_trail_heli_killstreak_tail_smoke");
  level.chopper_fx["fire"]["trail"]["medium"] = loadfx("trail/fx_trail_heli_black_smoke");
  level.chopper_fx["fire"]["trail"]["large"] = loadfx("trail/fx_trail_heli_killstreak_engine_smoke");
  level.coptermainrotor_fx = loadfx("vehicle/props/fx_cobra_rotor_main_run_mp");
  level.coptertailrotor_fx = loadfx("vehicle/props/fx_cobra_rotor_small_run_mp");
  level.coptertailrotordamaged_fx = loadfx("vehicle/props/fx_huey_small_blade_dmg");
  heli_path_graph();
  precacheLocationSelector("compass_objpoint_helicopter");
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowhelicopter_comlink")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("helicopter_comlink_mp", "helicopter_comlink_mp", "killstreak_helicopter_comlink", "helicopter_used", ::useKillstreakHelicopter, true);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("helicopter_comlink_mp", &"KILLSTREAK_EARNED_HELICOPTER_COMLINK", &"KILLSTREAK_HELICOPTER_COMLINK_NOT_AVAILABLE", &"KILLSTREAK_HELICOPTER_COMLINK_INBOUND");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("helicopter_comlink_mp", "mpl_killstreak_heli", "kls_cobra_used", "", "kls_cobra_enemy", "", "kls_cobra_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("helicopter_comlink_mp", "scr_givehelicopter_comlink");
    maps\mp\gametypes\_hardpoints::registerKillstreakAltWeapon("helicopter_comlink_mp", "cobra_20mm_comlink_mp");
  }
}
heli_update_global_dvars() {
  for(;;) {
    level.heli_loopmax = heli_get_dvar_int("scr_heli_loopmax", "2");
    level.heli_missile_rof = heli_get_dvar_int("scr_heli_missile_rof", "2");
    level.heli_armor = heli_get_dvar_int("scr_heli_armor", "500");
    level.heli_maxhealth = heli_get_dvar_int("scr_heli_maxhealth", "1500");
    level.heli_amored_maxhealth = heli_get_dvar_int("scr_heli_armored_maxhealth", "1500");
    level.heli_missile_max = heli_get_dvar_int("scr_heli_missile_max", "20");
    level.heli_dest_wait = heli_get_dvar_int("scr_heli_dest_wait", "8");
    level.heli_debug = heli_get_dvar_int("scr_heli_debug", "0");
    level.heli_debug_crash = heli_get_dvar_int("scr_heli_debug_crash", "0");
    level.heli_targeting_delay = heli_get_dvar("scr_heli_targeting_delay", "0.5");
    level.heli_turretReloadTime = heli_get_dvar("scr_heli_turretReloadTime", "1.5");
    level.heli_turretClipSize = heli_get_dvar_int("scr_heli_turretClipSize", "20");
    level.heli_visual_range = heli_get_dvar_int("scr_heli_visual_range", "3500");
    level.heli_missile_range = heli_get_dvar_int("scr_heli_missile_range", "100000");
    level.heli_health_degrade = heli_get_dvar_int("scr_heli_health_degrade", "0");
    level.heli_turret_angle_tan = heli_get_dvar_int("scr_heli_turret_angle_tan", "1");
    level.heli_turret_target_cone = heli_get_dvar("scr_heli_turret_target_cone", "0.6");
    level.heli_target_spawnprotection = heli_get_dvar_int("scr_heli_target_spawnprotection", "5");
    level.heli_missile_regen_time = heli_get_dvar("scr_heli_missile_regen_time", "10");
    level.heli_turret_spinup_delay = heli_get_dvar("scr_heli_turret_spinup_delay", "0.75");
    level.heli_target_recognition = heli_get_dvar("scr_heli_target_recognition", "0.5");
    level.heli_missile_friendlycare = heli_get_dvar_int("scr_heli_missile_friendlycare", "512");
    level.heli_missile_target_cone = heli_get_dvar("scr_heli_missile_target_cone", "0.6");
    level.heli_valid_target_cone = heli_get_dvar("scr_heli_missile_valid_target_cone", "0.7");
    level.heli_armor_bulletdamage = heli_get_dvar("scr_heli_armor_bulletdamage", "0.3");
    level.heli_attract_strength = heli_get_dvar("scr_heli_attract_strength", "1000");
    level.heli_attract_range = heli_get_dvar("scr_heli_attract_range", "20000");
    level.helicopterTurretMaxAngle = heli_get_dvar_int("scr_helicopterTurretMaxAngle", "35");
    level.heli_protect_time = heli_get_dvar("scr_heli_protect_time", "60");
    level.heli_protect_pos_time = heli_get_dvar("scr_heli_protect_pos_time", "12");
    level.heli_protect_radius = heli_get_dvar_int("scr_heli_protect_radius", "2000");
    level.heli_missile_reload_time = heli_get_dvar("scr_heli_missile_reload_time", "5.0");
    level.heli_warning_distance = heli_get_dvar_int("scr_heli_warning_distance", "500");
    wait 1;
  }
}
heli_get_dvar_int(dvar, def) {
  return int(heli_get_dvar(dvar, def));
}
heli_get_dvar(dvar, def) {
  if(getdvar(dvar) != "") {
    return getdvarfloat(dvar);
  }
  else {
    setdvar(dvar, def);
    return def;
  }
}
spawn_helicopter(owner, origin, angles, model, targetname, target_offset, hardpointType) {
  chopper = spawnHelicopter(owner, origin, angles, model, targetname);
  chopper.attackers = [];
  chopper.attackerData = [];
  chopper.attackerDamage = [];
  chopper.destroyFunc = ::destroyHelicopter;
  chopper.hardpointType = hardpointType;
  if(!isDefined(target_offset)) {
    target_offset = (0, 0, 0);
  }
  Target_Set(chopper, target_offset);
  return chopper;
}
explodeOnContact(hardpointtype) {
  self endon("death");
  wait(10);
  for(;;) {
    self waittill("touch");
    self thread heli_explode();
  }
}
getValidProtectLocationStart(random_path, protectLocation, destination) {
  startnode = level.heli_paths[destination][random_path];
  path_index = (random_path + 1) % level.heli_paths[destination].size;
  noFlyZone = crossesNoFlyZone(startnode.origin, protectLocation);
  while(isDefined(noFlyZone) && path_index != random_path) {
    startnode = level.heli_paths[destination][path_index];
    noFlyZone = crossesNoFlyZone(startnode.origin, protectLocation);
    path_index = (path_index + 1) % level.heli_paths[destination].size;
  }
  return level.heli_paths[destination][path_index];
}
getValidRandomLeaveNode(start) {
  random_leave_node = randomInt(level.heli_leavenodes.size);
  leavenode = level.heli_leavenodes[random_leave_node];
  path_index = (random_leave_node + 1) % level.heli_leavenodes.size;
  noFlyZone = crossesNoFlyZone(leavenode.origin, start);
  while(isDefined(noFlyZone) && path_index != random_leave_node) {
    leavenode = level.heli_leavenodes[path_index];
    noFlyZone = crossesNoFlyZone(leavenode.origin, start);
    path_index = (path_index + 1) % level.heli_leavenodes.size;
  }
  return level.heli_leavenodes[path_index];
}
getValidRandomCrashNode(start) {
  random_leave_node = randomInt(level.heli_crash_paths.size);
  leavenode = level.heli_crash_paths[random_leave_node];
  path_index = (random_leave_node + 1) % level.heli_crash_paths.size;
  noFlyZone = crossesNoFlyZone(leavenode.origin, start);
  while(isDefined(noFlyZone) && path_index != random_leave_node) {
    leavenode = level.heli_crash_paths[path_index];
    noFlyZone = crossesNoFlyZone(leavenode.origin, start);
    path_index = (path_index + 1) % level.heli_crash_paths.size;
  }
  return level.heli_crash_paths[path_index];
}
heli_think(owner, startnode, heli_team, missilesEnabled, protectLocation, hardpointType, armored) {
  heliOrigin = startnode.origin;
  heliAngles = startnode.angles;
  if(hardpointType == "helicopter_comlink_mp") {
    chopperModelFriendly = level.chopperComlinkFriendly;
    chopperModelEnemy = level.chopperComlinkEnemy;
  } else {
    chopperModelFriendly = level.chopperRegular;
    chopperModelEnemy = level.chopperRegular;
  }
  chopper = spawn_helicopter(owner, heliOrigin, heliAngles, "heli_ai_mp", chopperModelFriendly, (0, 0, -100), hardpointType);
  chopper setEnemyModel(chopperModelEnemy);
  chopper thread watchForEarlyLeave(hardpointtype);
  Target_SetTurretAquire(chopper, false);
  chopper thread SAMTurretWatcher();
  if(hardpointType == "helicopter_comlink_mp") {
    chopper.defaultWeapon = "cobra_20mm_comlink_mp";
  }
  else {
    chopper.defaultWeapon = "cobra_20mm_mp";
  }
  chopper.requiredDeathCount = owner.deathCount;
  chopper.chaff_offset = level.chaff_offset["attack"];
  rearRotor = spawn("script_model", chopper.origin);
  rearRotor setModel("tag_origin");
  rearRotor linkto(chopper, "tail_rotor_jnt", (0, 0, 0), (0, 0, 0));
  chopper.rearRotor = rearRotor;
  rearRotor SetClientFlag(level.const_flag_copterrotor);
  minigun_snd_ent = spawn("script_origin", chopper GetTagOrigin("tag_flash"));
  minigun_snd_ent LinkTo(chopper, "tag_flash", (0, 0, 0), (0, 0, 0));
  chopper.minigun_snd_ent = minigun_snd_ent;
  minigun_snd_ent thread AutoStopSound();
  chopper.team = heli_team;
  chopper setteam(heli_team);
  chopper.owner = owner;
  chopper setowner(owner);
  chopper thread heli_existance();
  level.chopper = chopper;
  chopper.crashType = "explode";
  chopper.reached_dest = false;
  if(armored) {
    chopper.maxhealth = level.heli_amored_maxhealth;
  }
  else {
    chopper.maxhealth = level.heli_maxhealth;
  }
  chopper.rocketDamageOneShot = level.heli_maxhealth + 1;
  chopper.rocketDamageTwoShot = (level.heli_maxhealth / 2) + 1;
  chopper.chaffcount = 1;
  chopper.waittime = level.heli_dest_wait;
  chopper.loopcount = 0;
  chopper.evasive = false;
  chopper.health_bulletdamageble = level.heli_armor;
  chopper.health_evasive = level.heli_armor;
  chopper.health_low = chopper.maxhealth * 0.8;
  chopper.targeting_delay = level.heli_targeting_delay;
  chopper.primaryTarget = undefined;
  chopper.secondaryTarget = undefined;
  chopper.attacker = undefined;
  chopper.missile_ammo = level.heli_missile_max;
  chopper.currentstate = "ok";
  chopper.lastRocketFireTime = -1;
  if(isDefined(protectLocation)) {
    chopper thread heli_protect(startNode, protectLocation, hardpointType, heli_team);
    chopper.chaffcount = 1;
  } else {
    chopper thread heli_fly(startnode, 2.0, hardpointType);
  }
  chopper thread heli_damage_monitor(hardpointtype);
  chopper thread heli_kill_monitor(hardpointtype);
  chopper thread heli_health(hardpointType);
  chopper thread attack_targets(missilesEnabled, hardpointType);
  chopper thread heli_targeting(missilesEnabled, hardpointType);
  chopper thread heli_missile_regen();
  chopper thread heli_missile_incoming();
  chopper maps\mp\gametypes\_spawning::create_helicopter_influencers(heli_team);
}
AutoStopSound() {
  self endon("death");
  level waittill("game_ended");
  self StopLoopSound();
}
heli_existance() {
  self waittill("leaving");
  self maps\mp\gametypes\_spawning::remove_helicopter_influencers();
}
heli_missile_regen() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    debug_print3d("Missile Ammo: " + self.missile_ammo, (0.5, 0.5, 1), self, (0, 0, -100), 0);
    if(self.missile_ammo >= level.heli_missile_max) {
      self waittill("missile fired");
    }
    else {
      if(self.currentstate == "heavy smoke") {
        wait(level.heli_missile_regen_time / 4);
      }
      else if(self.currentstate == "light smoke") {
        wait(level.heli_missile_regen_time / 2);
      }
      else {
        wait(level.heli_missile_regen_time);
      }
    }
    if(self.missile_ammo < level.heli_missile_max) {
      self.missile_ammo++;
    }
  }
}
heli_targeting(missilesEnabled, hardpointType) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    targets = [];
    targetsMissile = [];
    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(self canTargetPlayer_turret(player, hardpointType)) {
        if(isDefined(player)) {
          targets[targets.size] = player;
        }
      }
      if(missilesEnabled && (self canTargetPlayer_missile(player, hardpointType))) {
        if(isDefined(player)) {
          targetsMissile[targetsMissile.size] = player;
        }
      } else
        continue;
    }
    if(isDefined(level.dogs)) {
      for(i = 0; i < level.dogs.size; i++) {
        dog = level.dogs[i];
        if(self canTargetDog_turret(dog)) {
          if(isDefined(dog)) {
            targets[targets.size] = dog;
          }
        }
        if(missilesEnabled && (self canTargetDog_missile(dog))) {
          if(isDefined(dog)) {
            targetsMissile[targetsMissile.size] = dog;
          }
        } else
          continue;
      }
    }
    if(targets.size == 0 && targetsMissile.size == 0) {
      self.primaryTarget = undefined;
      self.secondaryTarget = undefined;
      debug_print_target();
      wait(self.targeting_delay);
      continue;
    }
    if(targets.size == 1) {
      if(isDefined(targets[0].type) && targets[0].type == "dog") {
        update_dog_threat(targets[0]);
      } else {
        update_player_threat(targets[0]);
      }
      self.primaryTarget = targets[0];
      self notify("primary acquired");
      self.secondaryTarget = undefined;
      debug_print_target();
    } else if(targets.size > 1)
      assignPrimaryTargets(targets);
    if(targetsMissile.size == 1) {
      if(!isDefined(targetsMissile[0].type) || targetsMissile[0].type != "dog") {
        self update_missile_player_threat(targetsMissile[0]);
      } else if(targetsMissile[0].type == "dog") {
        self update_missile_dog_threat(targetsMissile[0]);
      }
      self.secondaryTarget = targetsMissile[0];
      self notify("secondary acquired");
      debug_print_target();
    } else if(targetsMissile.size > 1)
      assignSecondaryTargets(targetsMissile);
    wait(self.targeting_delay);
    debug_print_target();
  }
}
canTargetPlayer_turret(player, hardpointType) {
  canTarget = true;
  if(!isalive(player) || player.sessionstate != "playing") {
    return false;
  }
  if(player == self.owner) {
    self check_owner(hardpointType);
    return false;
  }
  if(player HasPerk("specialty_nottargetedbyai")) {
    return false;
  }
  if(distance(player.origin, self.origin) > level.heli_visual_range) {
    return false;
  }
  if(!isDefined(player.team)) {
    return false;
  }
  if(level.teamBased && player.team == self.team) {
    return false;
  }
  if(player.team == "spectator") {
    return false;
  }
  if(isDefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
    return false;
  }
  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  visible_amount = player sightConeTrace(heli_turret_point, self);
  if(visible_amount < level.heli_target_recognition) {
    return false;
  }
  return canTarget;
}
getVerticalTan(startOrigin, endOrigin) {
  vector = endOrigin - startOrigin;
  opposite = startOrigin[2] - endOrigin[2];
  if(opposite < 0) {
    opposite *= 1;
  }
  adjacent = distance2d(startOrigin, endOrigin);
  if(adjacent < 0) {
    adjacent *= 1;
  }
  if(adjacent < 0.01) {
    adjacent = 0.01;
  }
  tangent = opposite / adjacent;
  return tangent;
}
canTargetPlayer_missile(player, hardpointType) {
  canTarget = true;
  if(!isalive(player) || player.sessionstate != "playing") {
    return false;
  }
  if(player == self.owner) {
    self check_owner(hardpointType);
    return false;
  }
  if(player HasPerk("specialty_nottargetedbyai")) {
    return false;
  }
  if(distance(player.origin, self.origin) > level.heli_missile_range) {
    return false;
  }
  if(!isDefined(player.team)) {
    return false;
  }
  if(level.teamBased && player.team == self.team) {
    return false;
  }
  if(player.team == "spectator") {
    return false;
  }
  if(isDefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
    return false;
  }
  if(self target_cone_check(player, level.heli_missile_target_cone) == false) {
    return false;
  }
  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  if(!isDefined(player.lastHit)) {
    player.lastHit = 0;
  }
  player.lastHit = self HeliTurretSightTrace(heli_turret_point, player, player.lastHit);
  if(player.lastHit != 0) {
    return false;
  }
  return canTarget;
}
canTargetDog_turret(dog) {
  canTarget = true;
  if(!isDefined(dog)) {
    return false;
  }
  if(distance(dog.origin, self.origin) > level.heli_visual_range) {
    return false;
  }
  if(!isDefined(dog.aiteam)) {
    return false;
  }
  if(level.teamBased && (dog.aiteam == self.team)) {
    return false;
  }
  if(isDefined(dog.script_owner) && self.owner == dog.script_owner) {
    return false;
  }
  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  if(!isDefined(dog.lastHit)) {
    dog.lastHit = 0;
  }
  dog.lastHit = self HeliTurretDogTrace(heli_turret_point, dog, dog.lastHit);
  if(dog.lastHit != 0) {
    return false;
  }
  return canTarget;
}
canTargetDog_missile(dog) {
  canTarget = true;
  if(!isDefined(dog)) {
    return false;
  }
  if(distance(dog.origin, self.origin) > level.heli_missile_range) {
    return false;
  }
  if(!isDefined(dog.aiteam)) {
    return false;
  }
  if(level.teamBased && (dog.aiteam == self.team)) {
    return false;
  }
  if(isDefined(dog.script_owner) && self.owner == dog.script_owner) {
    return false;
  }
  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  if(!isDefined(dog.lastHit)) {
    dog.lastHit = 0;
  }
  dog.lastHit = self HeliTurretDogTrace(heli_turret_point, dog, dog.lastHit);
  if(dog.lastHit != 0) {
    return false;
  }
  return canTarget;
}
assignPrimaryTargets(targets) {
  for(idx = 0; idx < targets.size; idx++) {
    if(isDefined(targets[idx].type) && targets[idx].type == "dog") {
      update_dog_threat(targets[idx]);
    } else {
      update_player_threat(targets[idx]);
    }
  }
  assertex(targets.size >= 2, "Not enough targets to assign primary and secondary");
  highest = 0;
  second_highest = 0;
  primaryTarget = undefined;
  for(idx = 0; idx < targets.size; idx++) {
    assertex(isDefined(targets[idx].threatlevel), "Target player does not have threat level");
    if(targets[idx].threatlevel >= highest) {
      highest = targets[idx].threatlevel;
      primaryTarget = targets[idx];
    }
  }
  assertex(isDefined(primaryTarget), "Targets exist, but none was assigned as primary");
  self.primaryTarget = primaryTarget;
  self notify("primary acquired");
}
assignSecondaryTargets(targets) {
  for(idx = 0; idx < targets.size; idx++) {
    if(!isDefined(targets[idx].type) || targets[idx].type != "dog") {
      self update_missile_player_threat(targets[idx]);
    } else if(targets[idx].type == "dog") {
      update_missile_dog_threat(targets[idx]);
    }
  }
  assertex(targets.size >= 2, "Not enough targets to assign primary and secondary");
  highest = 0;
  second_highest = 0;
  primaryTarget = undefined;
  secondaryTarget = undefined;
  for(idx = 0; idx < targets.size; idx++) {
    assertex(isDefined(targets[idx].missilethreatlevel), "Target player does not have threat level");
    if(targets[idx].missilethreatlevel >= highest) {
      highest = targets[idx].missilethreatlevel;
      secondaryTarget = targets[idx];
    }
  }
  assertex(isDefined(secondaryTarget), "1+ targets exist, but none was assigned as secondary");
  self.secondaryTarget = secondaryTarget;
  self notify("secondary acquired");
}
update_player_threat(player) {
  player.threatlevel = 0;
  dist = distance(player.origin, self.origin);
  player.threatlevel += ((level.heli_visual_range - dist) / level.heli_visual_range) * 100;
  if(isDefined(self.attacker) && player == self.attacker) {
    player.threatlevel += 100;
  }
  if(isDefined(player.carryObject)) {
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
update_missile_player_threat(player) {
  player.missilethreatlevel = 0;
  dist = distance(player.origin, self.origin);
  player.missilethreatlevel += ((level.heli_missile_range - dist) / level.heli_missile_range) * 100;
  if(self missile_valid_target_check(player) == false) {
    player.missilethreatlevel = 1;
    return;
  }
  if(isDefined(self.attacker) && player == self.attacker) {
    player.missilethreatlevel += 100;
  }
  player.missilethreatlevel += player.score * 4;
  if(isDefined(player.antithreat)) {
    player.missilethreatlevel -= player.antithreat;
  }
  if(player.missilethreatlevel <= 0) {
    player.missilethreatlevel = 1;
  }
}
update_dog_threat(dog) {
  dog.threatlevel = 0;
  dist = distance(dog.origin, self.origin);
  dog.threatlevel += ((level.heli_visual_range - dist) / level.heli_visual_range) * 100;
}
update_missile_dog_threat(dog) {
  dog.missilethreatlevel = 1;
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
  self thread heli_hover();
  wait(waittime);
  heli_reset();
  self notify("stop hover");
}
heli_hover() {
  self endon("death");
  self endon("stop hover");
  self endon("evasive");
  self endon("leaving");
  self endon("crashing");
  randInt = randomint(360);
  self setgoalyaw(self.angles[1] + randInt, 90, 90);
}
heli_missile_incoming() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    self waittill("stinger_fired_at_me", missile, weap, attacker);
    _incomingMissile(missile);
    self heli_fire_chaff(missile, attacker);
    wait(1.0);
  }
}
_incomingMissile(missile) {
  if(!isDefined(self.incoming_missile)) {
    self.incoming_missile = 0;
  }
  self.incoming_missile++;
  self thread _incomingMissileTracker(missile);
}
_incomingMissileTracker(missile) {
  self endon("death");
  missile waittill("death");
  self.incoming_missile--;
  assert(self.incoming_missile >= 0);
}
isMissileIncoming() {
  if(!isDefined(self.incoming_missile)) {
    return false;
  }
  if(self.incoming_missile) {
    return true;
  }
  return false;
}
debug_tracker(target) {
  target endon("death");
  while(1) {
    debug_sphere(target.origin, 10, (1, 0, 0), 1, 1);
    wait(0.05);
  }
}
heli_fire_chaff(missile, attacker) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(isDefined(self.chaffcount) && self.chaffcount > 0) {
    if(!isDefined(missile)) {
      return;
    }
    self.chaffcount--;
    if(isDefined(attacker) && isplayer(attacker)) {
      self trackAssists(attacker, 1);
    }
    vec_toForward = anglesToForward(self.angles);
    vec_toRight = AnglesToRight(self.angles);
    self.chaff_fx = spawn("script_model", self.origin);
    self.chaff_fx.angles = (0, 180, 0);
    self.chaff_fx setModel("tag_origin");
    self.chaff_fx LinkTo(self, "tag_origin", self.chaff_offset, (0, 0, 0));
    delta = self.origin - missile.origin;
    dot = VectorDot(delta, vec_toRight);
    sign = 1;
    if(dot > 0) {
      sign = -1;
    }
    chaff_dir = VectorNormalize(vector_scale(vec_toForward, -0.2) + vector_scale(vec_toRight, sign));
    velocity = vector_scale(chaff_dir, RandomIntRange(400, 600));
    velocity = (velocity[0], velocity[1], velocity[2] - RandomIntRange(10, 100));
    self.chaff_target = spawn("script_model", self.chaff_fx.origin);
    self.chaff_target setModel("tag_origin");
    self.chaff_target MoveGravity(velocity, 5.0);
    self thread debug_tracker(self.chaff_target);
    self.chaff_fx thread deleteAfterTime(5.0);
    wait(0.1);
    playFXOnTag(level.fx_heli_chaff, self.chaff_fx, "tag_origin");
    if(isDefined(self.owner)) {
      self playsoundtoplayer("veh_huey_chaff_drop_plr", self.owner);
    }
    self playSound("veh_huey_chaff_explo_npc");
    missile Missile_SetTarget(self.chaff_target);
    wait(0.5);
    if(isDefined(self.chaff_target)) {
      self.chaff_target Delete();
    }
    if(isDefined(missile)) {
      missile Missile_SetTarget(undefined);
    }
    wait(1.0);
    if(isDefined(missile)) {
      missile detonate();
    }
  }
}
heli_kill_monitor(hardpointtype) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.damageTaken = 0;
  last_kill_vo = 0;
  kill_vo_spacing = 2000;
  for(;;) {
    self waittill("killed", victim);
    PrintLn("got killed notify");
    if(!isDefined(self.owner)) {
      continue;
    }
    if(self.owner == victim) {
      continue;
    }
    if(level.teamBased && self.owner.team == victim.team) {
      continue;
    }
    if(last_kill_vo + kill_vo_spacing < GetTime()) {
      PrintLn("playing kill vo");
      self.owner PlayLocalSound(level.heli_vo[self.team]["kill"]);
      last_kill_vo = GetTime();
    }
  }
}
heli_damage_monitor(hardpointtype) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.damageTaken = 0;
  last_hit_vo = 0;
  hit_vo_spacing = 6000;
  for(;;) {
    self waittill("damage", damage, attacker, direction, point, type, tagName, modelName, partname, weapon);
    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    heli_friendlyfire = maps\mp\gametypes\_weaponobjects::friendlyFireCheck(self.owner, attacker);
    if(!heli_friendlyfire) {
      continue;
    }
    if(!level.hardcoreMode) {
      if(isDefined(self.owner) && attacker == self.owner) {
        continue;
      }
      if(level.teamBased) {
        isValidAttacker = (isDefined(attacker.team) && attacker.team != self.team);
      }
      else {
        isValidAttacker = true;
      }
      if(!isValidAttacker) {
        continue;
      }
    }
    if(isPlayer(attacker)) {
      if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weapon, attacker)) {
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
      }
      attacker thread maps\mp\_properks::shotAirplane(self.owner, weapon, type);
      if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET") {
        if(attacker HasPerk("specialty_armorpiercing")) {
          damage += int(damage * level.cac_armorpiercing_data);
        }
        damage *= level.heli_armor_bulletdamage;
      }
      self trackAssists(attacker, damage);
    }
    self.attacker = attacker;
    if(type == "MOD_PROJECTILE") {
      switch (weapon) {
        case "tow_turret_mp":
          if(isDefined(self.rocketDamageTwoShot)) {
            self.damageTaken += self.rocketDamageTwoShot;
          } else if(isDefined(self.rocketDamageOneShot)) {
            self.damageTaken += self.rocketDamageOneShot;
          } else {
            self.damageTaken += damage;
          }
          break;
        default:
          if(isDefined(self.rocketDamageOneShot)) {
            self.damageTaken += self.rocketDamageOneShot;
          } else {
            self.damageTaken += damage;
          }
          break;
      }
    } else
      self.damageTaken += damage;
    if(self.damageTaken > self.maxhealth &&
      !isDefined(self.xpGiven) &&
      (!isDefined(self.owner) || attacker != self.owner)) {
      self.xpGiven = true;
      value = maps\mp\gametypes\_rank::getScoreInfoValue("helicopterkill");
      attacker thread maps\mp\gametypes\_rank::giveRankXP("helicopterkill", value);
      switch (hardpointtype) {
        case "helicopter_gunner_mp":
        case "helicopter_player_firstperson_mp":
          attacker maps\mp\_medals::destroyerHelicopterPlayer(weapon);
          break;
        case "helicopter_comlink_mp":
        case "helicopter_mp":
        case "helicopter_x2_mp":
        case "supply_drop_mp":
          attacker maps\mp\_medals::destroyerHelicopter(weapon);
          break;
      }
      attacker maps\mp\_properks::destroyedKillstreak();
      weaponStatName = "destroyed";
      switch (weapon) {
        case "auto_tow_mp":
        case "tow_turret_mp":
        case "tow_turret_drop_mp":
          weaponStatName = "kills";
          break;
      }
      attacker maps\mp\gametypes\_globallogic_score::setWeaponStat(weapon, 1, weaponStatName);
      killstreakReference = undefined;
      switch (hardpointtype) {
        case "helicopter_gunner_mp":
          killstreakReference = "killstreak_helicopter_gunner";
          break;
        case "helicopter_player_firstperson_mp":
          killstreakReference = "killstreak_helicopter_player_firstperson";
          break;
        case "helicopter_comlink_mp":
        case "helicopter_mp":
        case "helicopter_x2_mp":
          killstreakReference = "killstreak_helicopter_comlink";
          break;
        case "supply_drop_mp":
          killstreakReference = "killstreak_supply_drop";
          break;
      }
      if(isDefined(killstreakReference)) {
        level.globalKillstreaksDestroyed++;
        attacker maps\mp\gametypes\_globallogic_score::incItemStatByReference(killstreakReference, 1, "destroyed");
      }
      for(i = 0; i < level.players.size; i++) {
        level.players[i] DisplayTeamMessage(&"KILLSTREAK_DESTROYED_HELICOPTER", attacker, "uin_alert_slideout");
      }
      if(isDefined(self.attackers)) {
        for(j = 0; j < self.attackers.size; j++) {
          player = self.attackers[j];
          if(!isDefined(player)) {
            continue;
          }
          if(player == attacker) {
            continue;
          }
          damage_done = self.attackerDamage[player.clientId];
          player thread processCopterAssist(self, damage_done);
        }
        self.attackers = [];
      }
      attacker notify("destroyed_helicopter");
      Target_remove(self);
    } else if(isDefined(self.owner)) {
      if(last_hit_vo + hit_vo_spacing < GetTime()) {
        if(type == "MOD_PROJECTILE" || RandomIntRange(0, 3) == 0) {
          self.owner PlayLocalSound(level.heli_vo[self.team]["hit"]);
          last_hit_vo = GetTime();
        }
      }
    }
  }
}
trackAssists(attacker, damage) {
  if(!isDefined(self.attackerData[attacker.clientid])) {
    self.attackerDamage[attacker.clientid] = damage;
    self.attackers[self.attackers.size] = attacker;
    self.attackerData[attacker.clientid] = false;
  } else {
    self.attackerDamage[attacker.clientid] += damage;
  }
}
heli_health(hardpointType, player, playerNotify) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);
  damageState = 3;
  for(;;) {
    if(self.damageTaken > self.maxhealth) {
      damageState = 0;
      self setDamageStage(damageState);
      self thread heli_crash(hardpointType, player, playerNotify);
    } else if(self.damageTaken >= (self.maxhealth * 0.66) && damageState >= 2) {
      self setdamagestage(1);
      damageState = 1;
      self.currentstate = "heavy smoke";
      self.evasive = true;
      self notify("damage state");
    } else if(self.damageTaken >= (self.maxhealth * 0.33) && damageState == 3) {
      self setdamagestage(2);
      damageState = 2;
      self.currentstate = "light smoke";
      self notify("damage state");
    }
    if(self.damageTaken <= level.heli_armor) {
      debug_print3d_simple("Armor: " + (level.heli_armor - self.damageTaken), self, (0, 0, 100), 20);
    }
    else {
      debug_print3d_simple("Health: " + (self.maxhealth - self.damageTaken), self, (0, 0, 100), 20);
    }
    wait 1;
  }
}
heli_evasive(hardpointType) {
  self notify("evasive");
  self.evasive = true;
  loop_startnode = level.heli_loop_paths[0];
  gunnerPathFound = true;
  if(hardpointType == "helicopter_gunner_mp") {
    gunnerPathFound = false;
    for(i = 0; i < level.heli_loop_paths.size; i++) {
      if(isDefined(level.heli_loop_paths[i].isGunnerPath) && level.heli_loop_paths[i].isGunnerPath) {
        loop_startnode = level.heli_loop_paths[i];
        gunnerPathFound = true;
        break;
      }
    }
  }
  assertex(gunnerPathFound, "No chopper gunner loop paths found in map");
  startwait = 2;
  if(isDefined(self.doNotStop) && self.doNotStop) {
    startwait = 0;
  }
  self thread heli_fly(loop_startnode, startwait, hardpointType);
}
notify_player(player, playerNotify, delay) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(playerNotify)) {
    return;
  }
  player endon("disconnect");
  player endon(playerNotify);
  wait(delay);
  player notify(playerNotify);
}
play_going_down_vo(delay) {
  self endon("disconnect");
  self.heli endon("death");
  wait(delay);
  self PlayLocalSound(level.heli_vo[self.team]["down"]);
}
heli_crash(hardpointType, player, playerNotify) {
  self endon("death");
  self notify("crashing");
  self maps\mp\gametypes\_spawning::remove_helicopter_influencers();
  self stoploopsound(0);
  if(isDefined(self.minigun_snd_ent)) {
    self.minigun_snd_ent StopLoopSound();
  }
  if(isDefined(self.alarm_snd_ent)) {
    self.alarm_snd_ent StopLoopSound();
  }
  crashTypes = [];
  crashTypes[0] = "crashOnPath";
  crashTypes[1] = "spinOut";
  crashType = crashTypes[randomInt(2)];
  self SetClientFlag(level.const_flag_crashing);
  if(isDefined(self.crashType)) {
    crashType = self.crashType;
  }
  switch (crashType) {
    case "explode": {
      thread notify_player(player, playerNotify, 0);
      self thread heli_explode();
    }
    break;
    case "crashOnPath": {
      if(isDefined(player)) {
        player thread play_going_down_vo(0.5);
      }
      if(isDefined(self.rearRotor)) {
        self thread damagedRotorFX();
      }
      thread notify_player(player, playerNotify, 4);
      self clear_client_flags();
      self thread crashOnNearestCrashPath(hardpointType);
    }
    break;
    case "spinOut": {
      if(isDefined(player)) {
        player thread play_going_down_vo(0.5);
      }
      thread notify_player(player, playerNotify, 4);
      self clear_client_flags();
      if(isDefined(self.rearRotor)) {
        self thread damagedRotorFX();
      }
      heli_reset();
      heli_speed = 30 + randomInt(50);
      heli_accel = 10 + randomInt(25);
      leavenode = getValidRandomCrashNode(self.origin);
      self setspeed(heli_speed, heli_accel);
      self setvehgoalpos((leavenode.origin), 0);
      rateOfSpin = 45 + randomint(90);
      thread heli_secondary_explosions();
      self thread heli_spin(rateOfSpin);
      self waittill("near_goal");
      if(isDefined(player) && isDefined(playerNotify)) {
        player notify(playerNotify);
      }
      self thread heli_explode();
    }
    break;
  }
  self thread explodeOnContact(hardpointtype);
  time = randomInt(15);
  self thread waitThenExplode(time);
}
damagedRotorFX() {
  self endon("death");
  damagedRearRotor = spawn("script_model", self.origin);
  damagedRearRotor setModel("tag_origin");
  damagedRearRotor linkto(self, "tail_rotor_jnt", (0, 0, 0), (0, 0, 0));
  damagedRearRotor SetClientFlag(level.const_flag_copterdamaged);
  self.rearRotor delete();
  self.rearRotor = damagedRearRotor;
}
waitThenExplode(time) {
  self endon("death");
  wait(time);
  self thread heli_explode();
}
crashOnNearestCrashPath(hardpointType) {
  crashPathDistance = -1;
  crashPath = level.heli_crash_paths[0];
  for(i = 0; i < level.heli_crash_paths.size; i++) {
    currentDistance = distance(self.origin, level.heli_crash_paths[i].origin);
    if(crashPathDistance == -1 || crashPathDistance > currentDistance) {
      crashPathDistance = currentDistance;
      crashPath = level.heli_crash_paths[i];
    }
  }
  heli_speed = 30 + randomInt(50);
  heli_accel = 10 + randomInt(25);
  self setspeed(heli_speed, heli_accel);
  thread heli_secondary_explosions();
  self thread heli_fly(crashPath, 0, hardpointType);
  rateOfSpin = 45 + randomint(90);
  self thread heli_spin(rateOfSpin);
  self waittill("path start");
  self waittill("destination reached");
  self thread heli_explode();
}
heli_secondary_explosions() {
  self endon("death");
  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
  self playSound(level.heli_sound[self.team]["hit"]);
  self thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setdamagestage(0);
  self thread trail_fx(level.chopper_fx["fire"]["trail"]["large"], "tag_engine_left", "stop body fire");
  wait(3.0);
  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
  self playSound(level.heli_sound[self.team]["hitsecondary"]);
}
heli_spin(speed) {
  self endon("death");
  self thread spinSoundShortly();
  self setyawspeed(speed, speed / 3, speed / 3);
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
  {
    playFXOnTag(trail_fx, self, trail_tag);
  }
}
destroyHelicopter() {
  team = self.team;
  self maps\mp\gametypes\_spawning::remove_helicopter_influencers();
  if(isDefined(self.interior_model)) {
    self.interior_model Delete();
    self.interior_model = undefined;
  }
  if(isDefined(self.rearRotor)) {
    self.rearRotor Delete();
    self.rearRotor = undefined;
  }
  if(isDefined(self.minigun_snd_ent)) {
    self.minigun_snd_ent StopLoopSound();
    self.minigun_snd_ent Delete();
    self.minigun_snd_ent = undefined;
  }
  if(isDefined(self.alarm_snd_ent)) {
    self.alarm_snd_ent Delete();
    self.alarm_snd_ent = undefined;
  }
  self delete();
  maps\mp\_killstreakrules::killstreakStop(self.hardpointType, team);
}
heli_explode() {
  self death_notify_wrapper();
  forward = (self.origin + (0, 0, 100)) - self.origin;
  playFX(level.chopper_fx["explode"]["death"], self.origin, forward);
  self playSound(level.heli_sound[self.team]["crash"]);
  wait(0.1);
  assert(isDefined(self.destroyFunc));
  self[[self.destroyFunc]]();
}
clear_client_flags() {
  self ClearClientFlag(level.const_flag_warn_fired);
  self ClearClientFlag(level.const_flag_warn_targeted);
  self ClearClientFlag(level.const_flag_warn_locked);
}
heli_leave(hardpointType) {
  self notify("desintation reached");
  self notify("leaving");
  self clear_client_flags();
  leavenode = getValidRandomLeaveNode(self.origin);
  heli_reset();
  self setspeed(105, 45);
  self setvehgoalpos(leavenode.origin, 1);
  self waittillmatch("goal");
  self stoploopsound(1);
  self death_notify_wrapper();
  if(isDefined(self.alarm_snd_ent)) {
    self.alarm_snd_ent StopLoopSound();
    self.alarm_snd_ent Delete();
    self.alarm_snd_ent = undefined;
  }
  if(Target_IsTarget(self)) {
    Target_remove(self);
  }
  assert(isDefined(self.destroyFunc));
  self[[self.destroyFunc]]();
}
heli_fly(currentnode, startwait, hardpointType) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  self endon("abandoned");
  self.reached_dest = false;
  heli_reset();
  pos = self.origin;
  wait(startwait);
  while(isDefined(currentnode.target)) {
    nextnode = getent(currentnode.target, "targetname");
    assertex(isDefined(nextnode), "Next node in path is undefined, but has targetname");
    pos = nextnode.origin + (0, 0, 30);
    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      heli_speed = currentnode.script_airspeed;
      heli_accel = currentnode.script_accel;
    } else {
      heli_speed = 30 + randomInt(20);
      heli_accel = 10 + randomInt(5);
    }
    if(isDefined(self.pathSpeedScale)) {
      heli_speed *= self.pathSpeedScale;
      heli_accel *= self.pathSpeedScale;
    }
    if(!isDefined(nextnode.target)) {
      stop = 1;
    }
    else {
      stop = 0;
    }
    debug_line(currentnode.origin, nextnode.origin, (1, 0.5, 0.5), 200);
    if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke") {
      self setspeed(heli_speed, heli_accel);
      self setvehgoalpos((pos), stop);
      self waittill("near_goal");
      self notify("path start");
    } else {
      if(isDefined(nextnode.script_delay) && !isDefined(self.doNotStop)) {
        stop = 1;
      }
      self setspeed(heli_speed, heli_accel);
      self setvehgoalpos((pos), stop);
      if(!isDefined(nextnode.script_delay) || isDefined(self.doNotStop)) {
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
      self thread heli_leave(hardpointType);
      return;
    }
    currentnode = nextnode;
  }
  self setgoalyaw(currentnode.angles[1]);
  self.reached_dest = true;
  self notify("destination reached");
  if(isDefined(self.waittime) && self.waittime > 0) {
    heli_wait(self.waittime);
  }
  if(isDefined(self)) {
    self thread heli_evasive(hardpointType);
  }
}
heli_random_point_in_radius(protectDest, nodeHeight) {
  min_distance = Int(level.heli_protect_radius * .2);
  direction = randomintrange(0, 360);
  distance = randomintrange(min_distance, level.heli_protect_radius - min_distance);
  x = cos(direction);
  y = sin(direction);
  x = x * distance;
  y = y * distance;
  return (protectDest[0] + x, protectDest[1] + y, nodeHeight);
}
heli_get_protect_spot(protectDest, nodeHeight) {
  protect_spot = heli_random_point_in_radius(protectDest, nodeHeight);
  tries = 3;
  noFlyZone = crossesNoFlyZone(protectDest, protect_spot);
  while(tries != 0 && isDefined(noFlyZone)) {
    protect_spot = heli_random_point_in_radius(protectDest, nodeHeight);
    tries--;
    noFlyZone = crossesNoFlyZone(protectDest, protect_spot);
  }
  noFlyZoneHeight = getNoFlyZoneHeightCrossed(protectDest, protect_spot, nodeHeight);
  return (protect_spot[0], protect_spot[1], noFlyZoneHeight);
}
wait_or_waittill(time, msg1, msg2) {
  self endon(msg1);
  self endon(msg2);
  wait(time);
  return true;
}
set_heli_speed_normal() {
  self setmaxpitchroll(30, 30);
  heli_speed = 30 + randomInt(20);
  heli_accel = 10 + randomInt(5);
  self setspeed(heli_speed, heli_accel);
  self setyawspeed(75, 45, 45);
}
set_heli_speed_evasive() {
  self setmaxpitchroll(30, 90);
  heli_speed = 50 + randomInt(20);
  heli_accel = 30 + randomInt(5);
  self setspeed(heli_speed, heli_accel);
  self setyawspeed(100, 75, 75);
}
set_heli_speed_hover() {
  self setmaxpitchroll(0, 90);
  self setspeed(20, 10);
  self setyawspeed(55, 25, 25);
}
is_targeted() {
  if(isDefined(self.locking_on) && self.locking_on) {
    return true;
  }
  if(isDefined(self.locked_on) && self.locked_on) {
    return true;
  }
  return false;
}
heli_protect(startNode, protectDest, hardpointType, heli_team) {
  self endon("death");
  self notify("flying");
  self endon("flying");
  self endon("abandoned");
  self.reached_dest = false;
  heli_reset();
  self SetHoverParams(50, 100, 50);
  wait(2);
  currentDest = protectDest;
  nodeHeight = protectDest[2];
  nextnode = startNode;
  while(isDefined(nextnode.target)) {
    currentnode = nextnode;
    nextnode = getent(currentnode.target, "targetname");
    if(nodeHeight < nextnode.origin[2]) {
      nodeHeight = nextnode.origin[2];
    }
  }
  heightOffset = 0;
  if(heli_team == "axis") {
    heightOffset = 800;
  }
  protectDest = (protectDest[0], protectDest[1], nodeHeight);
  noFlyZoneHeight = getNoFlyZoneHeight(protectDest);
  protectDest = (protectDest[0], protectDest[1], noFlyZoneHeight + heightOffset);
  currentDest = protectDest;
  startTime = gettime();
  endTime = startTime + (level.heli_protect_time * 1000);
  heli_speed = 30 + randomInt(20);
  heli_accel = 10 + randomInt(5);
  self thread updateTargetYaw();
  while(getTime() < endTime) {
    stop = 1;
    self updateSpeed();
    self setvehgoalpos((currentDest), stop);
    self thread updateSpeedOnLock();
    self waittill_any("near_goal", "locking on");
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
    self notify("path start");
    if(!self is_targeted()) {
      waittillframeend;
      time = level.heli_protect_pos_time;
      if(self.evasive == true) {
        time = 2.0;
      }
      set_heli_speed_hover();
      wait_or_waittill(time, "locking on", "damage state");
    }
    prevDest = currentDest;
    currentDest = heli_get_protect_spot(protectDest, nodeHeight);
    noFlyZoneHeight = getNoFlyZoneHeight(currentDest);
    currentDest = (currentDest[0], currentDest[1], noFlyZoneHeight + heightOffset);
    noFlyZones = crossesNoFlyZones(prevDest, currentDest);
    if(isDefined(noFlyZones) && (noFlyZones.size > 0)) {
      currentDest = prevDest;
    }
  }
  self thread heli_leave(hardpointType);
}
updateSpeedOnLock() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self waittill_any("near_goal", "locking on");
  self updateSpeed();
}
updateSpeed() {
  if(self is_targeted() || (isDefined(self.evasive) && self.evasive)) {
    set_heli_speed_evasive();
  } else {
    set_heli_speed_normal();
  }
}
updateTargetYaw() {
  self notify("endTargetYawUpdate");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("endTargetYawUpdate");
  for(;;) {
    if(isDefined(self.primaryTarget)) {
      yaw = get2DYaw(self.origin, self.primaryTarget.origin);
      self setTargetYaw(yaw);
    }
    wait(1);
  }
}
fire_missile(sMissileType, iShots, eTarget) {
  if(!isDefined(iShots)) {
    iShots = 1;
  }
  assert(self.health > 0);
  weaponName = undefined;
  weaponShootTime = undefined;
  tags = [];
  switch (sMissileType) {
    case "ffar":
      weaponName = "hind_FFAR_mp";
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
    eMissile.killcament = self;
    self.lastRocketFireTime = gettime();
    if(i < iShots - 1) {
      wait weaponShootTime;
    }
  }
}
check_owner(hardpointType) {
  if(!isDefined(self.owner) || !isDefined(self.owner.team) || self.owner.team != self.team) {
    self notify("abandoned");
    self thread heli_leave(hardpointType);
  }
}
attack_targets(missilesEnabled, hardpointType) {
  self thread attack_primary(hardpointType);
  if(missilesEnabled) {
    self thread attack_secondary(hardpointType);
  }
}
attack_secondary(hardpointType) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    if(isDefined(self.secondaryTarget)) {
      self.secondaryTarget.antithreat = undefined;
      self.missileTarget = self.secondaryTarget;
      antithreat = 0;
      while(isDefined(self.missileTarget) && isalive(self.missileTarget)) {
        if(self target_cone_check(self.missileTarget, level.heli_missile_target_cone)) {
          self thread missile_support(self.missileTarget, level.heli_missile_rof, true, undefined);
        }
        else {
          break;
        }
        antithreat += 100;
        self.missileTarget.antithreat = antithreat;
        wait level.heli_missile_rof;
        if(!isDefined(self.secondaryTarget) || (isDefined(self.secondaryTarget) && self.missileTarget != self.secondaryTarget)) {
          break;
        }
      }
      if(isDefined(self.missileTarget)) {
        self.missileTarget.antithreat = undefined;
      }
    }
    self waittill("secondary acquired");
    self check_owner(hardpointType);
  }
}
turret_target_check(turretTarget, attackAngle) {
  targetYaw = get2DYaw(self.origin, turretTarget.origin);
  chopperYaw = self.angles[1];
  if(targetYaw < 0) {
    targetYaw = targetYaw * -1;
  }
  targetYaw = int(targetYaw) % 360;
  if(chopperYaw < 0) {
    chopperYaw = chopperYaw * -1;
  }
  chopperYaw = int(chopperYaw) % 360;
  if(chopperYaw > targetYaw) {
    difference = chopperYaw - targetYaw;
  }
  else {
    difference = targetYaw - chopperYaw;
  }
  return (difference <= attackAngle);
}
target_cone_check(target, coneCosine) {
  heli2target_normal = vectornormalize(target.origin - self.origin);
  heli2forward = anglesToForward(self.angles);
  heli2forward_normal = vectornormalize(heli2forward);
  heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
  if(heli_dot_target >= coneCosine) {
    debug_print3d_simple("Cone sight: " + heli_dot_target, self, (0, 0, -40), 40);
    return true;
  }
  return false;
}
missile_valid_target_check(missiletarget) {
  heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
  heli2forward = anglesToForward(self.angles);
  heli2forward_normal = vectornormalize(heli2forward);
  heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
  if(heli_dot_target >= level.heli_valid_target_cone) {
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
        if(isDefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
          debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
          self notify("missile ready");
          return;
        }
      }
    } else {
      player = self.owner;
      if(isDefined(player) && isDefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
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
attack_primary(hardpointType) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  for(;;) {
    if(isDefined(self.primaryTarget)) {
      self.primaryTarget.antithreat = undefined;
      self.turretTarget = self.primaryTarget;
      antithreat = 0;
      last_pos = undefined;
      while(isDefined(self.turretTarget) && isalive(self.turretTarget)) {
        helicopterTurretMaxAngle = heli_get_dvar_int("scr_helicopterTurretMaxAngle", level.helicopterTurretMaxAngle);
        while(self turret_target_check(self.turretTarget, helicopterTurretMaxAngle) == false && isDefined(self.turretTarget) && isalive(self.turretTarget)) {
          wait(0.1);
        }
        if(!isDefined(self.turretTarget) || !isalive(self.turretTarget)) {
          break;
        }
        self setTurretTargetEnt(self.turretTarget, (0, 0, 50));
        self waittill("turret_on_target");
        maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();
        self notify("turret_on_target");
        self thread turret_target_flag(self.turretTarget);
        wait(level.heli_turret_spinup_delay);
        weaponShootTime = weaponfiretime(self.defaultWeapon);
        self setVehWeapon(self.defaultWeapon);
        for(i = 0; i < level.heli_turretClipSize; i++) {
          if(isDefined(self.turretTarget) && isDefined(self.primaryTarget)) {
            if(self.primaryTarget != self.turretTarget) {
              self setTurretTargetEnt(self.primaryTarget, (0, 0, 40));
            }
          } else {
            if(isDefined(self.targetlost) && self.targetlost && isDefined(self.turret_last_pos)) {
              self setturrettargetvec(self.turret_last_pos);
            } else {
              self clearturrettarget();
            }
          }
          if(gettime() != self.lastRocketFireTime) {
            self setVehWeapon(self.defaultWeapon);
            miniGun = self fireWeapon("tag_flash");
            self.minigun_snd_ent playLoopSound("wpn_hind_pilot_fire_loop_npc");
          }
          if(i < level.heli_turretClipSize - 1) {
            wait weaponShootTime;
          }
        }
        self.minigun_snd_ent StopLoopSound();
        self notify("turret reloading");
        wait(level.heli_turretReloadTime);
        if(isDefined(self.turretTarget) && isalive(self.turretTarget)) {
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
    self check_owner(hardpointType);
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
    assertex(isDefined(turrettarget.origin), "turrettarget.origin is undefined after isDefined check");
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
      if(isDefined(self.primaryTarget.type) && self.primaryTarget.type == "dog") {
        name = "dog";
      }
      else {
        name = self.primaryTarget.name;
      }
      primary_msg = "Primary: " + name + " : " + self.primaryTarget.threatlevel;
    } else
      primary_msg = "Primary: ";
    if(isDefined(self.secondaryTarget) && isDefined(self.secondaryTarget.threatlevel)) {
      if(isDefined(self.secondaryTarget.type) && self.secondaryTarget.type == "dog") {
        name = "dog";
      }
      else {
        name = self.secondaryTarget.name;
      }
      secondary_msg = "Secondary: " + name + " : " + self.secondaryTarget.threatlevel;
    } else
      secondary_msg = "Secondary: ";
    frames = int(self.targeting_delay * 20) + 1;
    thread draw_text(primary_msg, (1, 0.6, 0.6), self, (0, 0, 40), frames);
    thread draw_text(secondary_msg, (1, 0.6, 0.6), self, (0, 0, 0), frames);
  }
}
improved_sightconetrace(helicopter) {
  heli_centroid = helicopter.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(helicopter.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  debug_line(heli_turret_point, self.origin, (1, 1, 1), 5);
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
    debug_line(point[1], point[2], (1, 1, 1), 1);
    debug_line(point[2], point[3], (1, 1, 1), 1);
    debug_line(point[3], point[4], (1, 1, 1), 1);
    debug_line(point[4], point[1], (1, 1, 1), 1);
    if(bullettracepassed(start, point[i], true, self)) {
      debug_line(start, point[i], (randomInt(10) / 10, randomInt(10) / 10, randomInt(10) / 10), 1);
      yes++;
    }
    waittillframeend;
  }
  return yes / 5;
}
selectHelicopterLocation(hardpointtype) {
  self beginLocationComlinkSelection("compass_objpoint_helicopter", 1500);
  self.selectingLocation = true;
  self thread endSelectionThink();
  self waittill("confirm_location", location);
  if(!isDefined(location)) {
    return false;
  }
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  level.helilocation = location;
  return finishHardpointLocationUsage(location, ::nullCallback);
}
nullCallback(arg1, arg2) {
  return true;
}
processCopterAssist(destroyedCopter, damagedone) {
  self endon("disconnect");
  destroyedCopter endon("disconnect");
  wait .05;
  maps\mp\gametypes\_globallogic_utils::WaitTillSlowProcessAllowed();
  if(self.team != "axis" && self.team != "allies") {
    return;
  }
  if(self.team == destroyedCopter.team) {
    return;
  }
  assist_level = "helicopterassist";
  assist_level_value = int(floor((damagedone / destroyedCopter.maxhealth) * 4));
  if(assist_level_value > 0) {
    if(assist_level_value > 3) {
      assist_level_value = 3;
    }
    assist_level = assist_level + "_" + (assist_level_value * 25);
  }
  self maps\mp\_medals::assistAircraftTakedown();
  self thread maps\mp\gametypes\_rank::giveRankXP(assist_level);
}
SAMTurretWatcher() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self waittill_any("turret_on_target", "path start", "near_goal");
  Target_SetTurretAquire(self, true);
}
watchForEarlyLeave(hardpointtype) {
  self endon("heli_timeup");
  self waittill_any("joined_team", "disconnect");
  heli_leave(hardpointtype);
}