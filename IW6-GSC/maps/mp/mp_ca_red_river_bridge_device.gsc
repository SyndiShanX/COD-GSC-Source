/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_red_river_bridge_device.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#using_animtree("mp_ca_red_river_animtree");

REDRIVER_NUKE_WEIGHT = 85;
redriverCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"])) {
    game["player_holding_level_killstrek"] = false;
  }

  level.allow_level_killstreak = allowLevelKillstreaks();
  if(!level.allow_level_killstreak || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "warhawk_mortars", REDRIVER_NUKE_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"KILLSTREAKS_HINTS_WARHAWK_MORTARS");
  level thread watch_for_redriver_nuke_crate();
}

watch_for_redriver_nuke_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);
    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "warhawk_mortars") {
      disable_redriver_nuke();
      captured = wait_for_capture(dropCrate);
      if(!captured) {
        enable_redriver_nuke();
      } else {
        game["player_holding_level_killstrek"] = true;
        break;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return !isDefined(result);
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("captured");

  dropCrate waittill("death");
  waittillframeend;

  return true;
}

enable_redriver_nuke() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "warhawk_mortars", REDRIVER_NUKE_WEIGHT);
}

disable_redriver_nuke() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "warhawk_mortars", 0);
}

bridge_device_init() {
  self.device_model = GetEnt("bridge_device_model", "targetname");
  if(!isDefined(self.device_model)) {
    PrintLn("ERROR: No bridge_device_model available.");
    return;
  }

  self.mortar_delay_range = 3.0;
  self.end_of_match_volley = false;
  self.device_det_radius = 600;
  self.device_det_splash = 200;

  killcamPos = (-1191, -1126, 394);
  self.device_model.killCamEnt = spawn("script_model", killcamPos);
  self.device_model.killCamEnt SetScriptMoverKillCam("explosive");

  self thread bridge_device_sequence_waitforhit();
}

bridge_extras_init(bridge_device) {
  thread bridge_event_handle_glass(bridge_device);
  thread bridge_event_handle_churchbells(bridge_device.device_model.origin);
  thread bridge_event_handle_bell_sounds();

  vehicles = get_bridge_vehicles();
  if(vehicles.size > 0) {
    thread bridge_event_handle_vehicles(vehicles, bridge_device);
    thread bridge_event_handle_caralarms(vehicles);
  }

  thread bridge_device_scramble_radar(bridge_device);
}

bridge_device_scramble_radar(bridge_device) {
  level endon("bridge_fully_exploded");

  device_scrambler = GetStruct("device_scrambler", "targetname");
  if(!isDefined(device_scrambler)) {
    PrintLn("No Device Radar Scrambler");
    return;
  }

  thread bridge_device_radioactive_sound(device_scrambler.origin + (-5, 0, -155));

  level.device_scrambler_active = true;
  while(1) {
    level waittill("connected", player);
    if(!IsBot(player)) {
      player thread run_func_after_spawn(::bridge_device_static, device_scrambler.origin, bridge_device.device_det_radius);
    }
  }
}

bridge_device_radioactive_sound(position) {
  soundEnt = play_loopsound_in_space("emt_geiger_level1", position);

  level waittill("bridge_fully_exploded");

  soundEnt StopLoopSound();
  soundEnt Delete();
}

run_func_after_spawn(func, device_origin, det_radius) {
  self endon("disconnect");
  self endon("death");

  self waittill("spawned_player");

  self thread[[func]](device_origin, det_radius);
}

bridge_device_sequence_waitforhit() {
  self.device_model playLoopSound("device_stage1_loop");

  wait 2.0;

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "active", self.device_model.origin, "waypoint_radioactive");
  Objective_OnEntity(curObjID, self.device_model);
  self.curObjID = curObjID;

  self thread bridge_device_activate_at_end_of_match();
  level waittill("bridge_device_activate", player);

  disable_redriver_nuke();

  wait 2.0;

  wait 2.0;
  self bridge_device_sequence_volley(player);
}

bridge_device_sequence_volley(player) {
  start_org = GetStruct("mortar_launch_start", "targetname");
  target_org = GetStruct(start_org.target, "targetname");
  while(1) {
    self thread bridge_device_mortar_attack(start_org, target_org, player);
    if(!isDefined(target_org.target)) {
      break;
    }
    target_org = GetStruct(target_org.target, "targetname");
  }
}

bridge_device_activate_at_end_of_match() {
  level endon("bridge_device_activate");
  level waittill("spawning_intermission");
  self.mortar_delay_range = 0.5;
  self.end_of_match_volley = true;
  self bridge_device_sequence_volley(level.players[0]);
}

random_mortars_incoming_sound(org) {
  PlaySoundAtPos(org, "mortar_incoming");
}

bridge_device_mortar_attack(start_org, end_org, owner) {
  wait RandomFloatRange(0.0, self.mortar_delay_range);

  air_time = RandomFloatRange(4.0, 5.0);
  if(self.end_of_match_volley) {
    air_time = 2.5;
  }

  gravity = (0, 0, -800);
  launch_dir = TrajectoryCalculateInitialVelocity(start_org.origin, end_org.origin, gravity, air_time);
  play_fx = true;

  dirt_effect_radius = 350;

  mortar_model = random_mortars_get_model(start_org.origin);
  mortar_model.origin = start_org.origin;
  mortar_model.in_use = true;

  waitframe();
  playFXOnTag(getfx("random_mortars_trail"), mortar_model, "tag_fx");

  mortar_model.angles = VectorToAngles(launch_dir) * (-1, 1, 1);

  PlaySoundAtPos(start_org.origin, "mortar_launch");
  delayThread(air_time - 2.0, ::random_mortars_incoming_sound, end_org.origin);

  mortar_model MoveGravity(launch_dir, air_time);
  mortar_model waittill("movedone");

  if(level.createFX_enabled && !isDefined(level.players)) {
    level.players = [];
  }

  if(!isDefined(owner)) {
    owner = undefined;
  }

  mortar_model RadiusDamage(end_org.origin, 350, 750, 500, owner, "MOD_EXPLOSIVE", "warhawk_mortar_mp");
  PlayRumbleOnPosition("artillery_rumble", end_org.origin);

  dirt_effect_radiusSq = dirt_effect_radius * dirt_effect_radius;
  foreach(player in level.participants) {
    if(player isUsingRemote()) {
      continue;
    }
    if(DistanceSquared(end_org.origin, player.origin) > dirt_effect_radiusSq) {
      continue;
    }
    if(player DamageConeTrace(end_org.origin)) {
      player thread maps\mp\gametypes\_shellshock::dirtEffect(end_org.origin);
    }
  }

  if(play_fx) {
    playFX(getfx("mortar_impact_00"), end_org.origin);
  }

  stopFXOnTag(getfx("random_mortars_trail"), mortar_model, "tag_fx");

  if(isDefined(end_org.script_noteworthy) && (end_org.script_noteworthy == "device_target")) {
    self thread bridge_device_mortar_hit_nuke(owner, mortar_model);
  }
  wait 0.05;
  mortar_model Delete();
}

bridge_device_mortar_hit_nuke(owner, mortar_model) {
  level notify("bridge_trigger_explode");

  Objective_Delete(self.curObjID);
  Earthquake(0.85, .5, self.device_model.origin, 2500);

  det_radius = self.device_det_radius;
  splash_radius = det_radius + self.device_det_splash;
  oversplash_radius = det_radius + 3.0 * self.device_det_splash;

  foreach(agent in level.participants) {
    if(IsPlayer(agent) && (agent.sessionstate != "playing")) {
      continue;
    }
    agent thread update_bridge_event_player_effects(self.device_model.origin, det_radius, oversplash_radius, self.end_of_match_volley);

    agent_distanceSq = DistanceSquared(self.device_model.origin, agent.origin);
    if(agent_distanceSq > splash_radius * splash_radius) {
      continue;
    }
    damage_owner = owner;
    if(!isDefined(damage_owner)) {
      damage_owner = undefined;
    } else if(isDefined(damage_owner.team) && isDefined(agent.team) && damage_owner.team == agent.team) {
      damage_owner = mortar_model;
    }

    if(agent_distanceSq > det_radius * det_radius) {
      agent DoDamage(agent.maxhealth * 0.9, self.device_model.origin, damage_owner, self.device_model, "MOD_EXPLOSIVE");
    } else {
      agent DoDamage(1000, self.device_model.origin, damage_owner, self.device_model, "MOD_EXPLOSIVE");
    }
  }

  splashRadiusSq = splash_radius * splash_radius;
  dogs = maps\mp\agents\_agent_utility::getActiveAgentsOfType("dog");
  foreach(dog in dogs) {
    dog_distanceSq = DistanceSquared(self.device_model.origin, dog.origin);
    if(dog_distanceSq <= splashRadiusSq) {
      dog maps\mp\agents\_agent_utility::killDog();
    }
  }

  destroyTargetArray(self.device_model.origin, splashRadiusSq, level.remote_uav);

  foreach(boxType in level.deployable_box) {
    destroyTargetArray(self.device_model.origin, splashRadiusSq, boxtype);
  }

  destroyTargetArray(self.device_model.origin, splashRadiusSq, level.turrets);
  destroyTargetArray(self.device_model.origin, splashRadiusSq, level.uplinks);
  destroyTargetArray(self.device_model.origin, splashRadiusSq, level.placedIMS);
  destroyTargetArray(self.device_model.origin, splashRadiusSq, level.mines);

  self.device_model StopLoopSound("device_stage1_loop");
  self.device_model NotSolid();
  self.device_model Hide();
  self.device_model maps\mp\_movers::notify_moving_platform_invalid();
  if(!self.end_of_match_volley) {
    VisionSetNaked("mp_ca_red_river_exploding", 0.5);
  }

  PhysicsExplosionSphere(self.device_model.origin, splash_radius, det_radius, 1.0);

  wait 0.5;

  level notify("bridge_fully_exploded");
  maps\mp\_compass::setupMiniMap("compass_map_mp_ca_red_river_exploded");
  SetExpFog(6.6, 5530, 0.78, 0.81, 0.75, 0.87, 0.77);
  if(!self.end_of_match_volley) {
    if(isDefined(level.nukeDetonated)) {
      VisionSetNaked("", 3.0);
      maps\mp\killstreaks\_nuke::setNukeAftermathVision(0);
    } else {
      VisionSetNaked("mp_ca_red_river_exploded", 3.0);
    }
  }

}

destroyTargetArray(refPos, explosionRadiusSq, targetList) {
  foreach(target in targetList) {
    distSq = DistanceSquared(refPos, target.origin);
    if(distSq < explosionRadiusSq) {
      target notify("death");
    }
  }
}

update_bridge_event_player_effects(refPoint, det_distance, splash_distance, skip_shock) {
  self PlayRumbleOnEntity("artillery_rumble");
  wait 0.3;

  if(!skip_shock && !(self isUsingRemote())) {
    shock_time = 0.0;
    playerDistSq = DistanceSquared(self.origin, refPoint);
    if(playerDistSq < splash_distance * splash_distance) {
      shock_time = 8.0;
      if(playerDistSq > det_distance * det_distance) {
        shock_time = shock_time * (1 - ((sqrt(playerDistSq) - det_distance) / (splash_distance - det_distance)));
      }
    }
    if(shock_time > 0.0) {
      self shellshock("mp_ca_red_river_event", shock_time);
    }
  }

  wait 1.0;
  self PlayRumbleOnEntity("artillery_rumble");
  wait 1.3;
  self PlayRumbleOnEntity("artillery_rumble");
}

bridge_device_static(static_center, static_dist) {
  self endon("disconnect");

  wait RandomFloat(0.5);

  self maps\mp\killstreaks\_emp_common::staticFieldInit();
  self childthread bridge_device_static_update(static_center, static_dist);

  level waittill("bridge_fully_exploded");

  self maps\mp\killstreaks\_emp_common::staticFieldSetStrength(0);
}

bridge_device_static_update(static_center, static_dist) {
  level endon("bridge_trigger_explode");

  static_dist_squared = static_dist * static_dist;
  while(1) {
    in_range = Length2DSquared(self.origin - static_center) < static_dist_squared;

    self maps\mp\killstreaks\_emp_common::staticFieldSetStrength(in_range);

    wait(0.5);
  }
}

random_mortars_get_model(origin) {
  mortar_model = spawn("script_model", origin);
  mortar_model setModel("projectile_rpg7");
  return mortar_model;
}

get_bridge_vehicles() {
  vehicles = GetScriptableArray("vehicle_pickup_destructible_mp_rr", "targetname");

  if(vehicles.size <= 0) {
    PrintLn("No destructable vehicles found.");
  }

  return vehicles;
}

bridge_event_handle_vehicles(vehicles, bridge_device) {
  blow_distanceSq = bridge_device.device_det_radius + (bridge_device.device_det_splash * 2.0);
  blow_distanceSq = blow_distanceSq * blow_distanceSq;
  device_origin = bridge_device.device_model.origin;

  foreach(vehicle in vehicles) {
    if(DistanceSquared(vehicle.origin, device_origin) <= blow_distanceSq) {
      vehicle thread bridge_event_handle_vehicle();
    }
  }
}

bridge_event_handle_vehicle() {
  self endon("death");

  level waittill("bridge_fully_exploded");

  self SetScriptablePartState(0, 3);
}

bridge_event_handle_caralarms(vehicles) {
  array_thread(vehicles, ::bridge_event_update_caralarm);
}

bridge_event_update_caralarm() {
  self endon("death");

  level waittill("bridge_fully_exploded");

  wait RandomFloatRange(0.75, 1.25);

  self thread bridge_event_play_caralarm();
}

bridge_event_play_caralarm() {
  sound_ent = play_loopsound_in_space("rr_car_alarm", self GetTagOrigin("tag_engine"));

  alarm_time = RandomFloatRange(12.0, 16.0);
  self waittill_any_timeout(alarm_time, "death");

  sound_ent StoploopSound("rr_car_alarm");
  sound_ent playSound("rr_car_alarm_off");

  wait(5);
  sound_ent Delete();
}

bridge_event_handle_glass(bridge_device) {
  windows = GetGlassArray("bridge_event_glass");
  if(windows.size <= 0) {
    PrintLn("No Windows found");
    return;
  }

  blast_origin = bridge_device.device_model.origin;
  level waittill("bridge_fully_exploded");
  foreach(window in windows) {
    DestroyGlass(window, GetGlassOrigin(window) - blast_origin);
  }
}

bridge_event_handle_churchbells(device_origin) {
  bells = getEntArray("church_bell", "targetname");
  if(bells.size <= 0) {
    PrintLn("No church bells found.");
    return;
  }

  level.small_bells = 0;
  array_thread(bells, ::redriver_detecthit_churchbell);
  array_thread(bells, ::bridge_event_update_churchbell, device_origin);
}

redriver_detecthit_churchbell() {
  self setCanDamage(true);
  self.is_swaying = false;
  sound_alias = bell_sound_alias(self.script_noteworthy);
  while(1) {
    self waittill("damage", amount, attacker, direction_vec, hit_point, type);
    if(!isDefined(attacker) || !IsPlayer(attacker)) {
      continue;
    }
    current_weapon = attacker GetCurrentWeapon();
    if(!isDefined(current_weapon) || (WeaponClass(current_weapon) != "sniper")) {
      continue;
    }
    self playSound(sound_alias);
    self thread redriver_update_hitsway_churchbell(attacker);
    wait 0.5;
  }
}

redriver_update_hitsway_churchbell(attacker) {
  level endon("bridge_fully_exploded");

  if(self.is_swaying) {
    return;
  }
  vec = AnglesToRight(self.angles);
  vec2 = VectorNormalize(attacker.origin - self.origin);
  swing_dir = vectordot(vec, vec2) * 2.0;
  if(swing_dir > 0.0) {
    swing_dir = Max(0.3, swing_dir);
  } else {
    swing_dir = Min(-0.3, swing_dir);
  }

  self.is_swaying = true;
  self RotateRoll(15 * swing_dir, 1.0, 0, 0.5);
  wait 1;
  self RotateRoll(-25 * swing_dir, 2.0, 0.5, 0.5);
  wait 2;
  self RotateRoll(15 * swing_dir, 1.5, 0.5, 0.5);
  wait 1.5;
  self RotateRoll(-5 * swing_dir, 1.0, 0.5, 0.5);
  wait 1.0;
  self.is_swaying = false;
}

bridge_event_handle_bell_sounds() {
  level waittill("bridge_device_activate");

  PlaySoundAtPos((-510, -1617, 556), "scn_church_bells_long_large");
  PlaySoundAtPos((-480, -1986, 423), "scn_church_bells_long_small");
}

bridge_event_update_churchbell(blast_origin) {
  sound_alias = bell_sound_alias(self.script_noteworthy);

  level waittill("bridge_device_activate");

  vec = AnglesToRight(self.angles);
  vec2 = VectorNormalize(blast_origin - self.origin);
  swing_dir = vectordot(vec, vec2) * 2.0;
  if(swing_dir > 0.0) {
    swing_dir = Max(0.7, swing_dir);
  } else {
    swing_dir = Min(-0.7, swing_dir);
  }

  ring_offset = RandomFloatRange(0.1, 0.8);

  self.is_swaying = true;
  self.angles = (self.angles[0], self.angles[1], 0);
  self RotateRoll(40 * swing_dir, ring_offset, 0, ring_offset);
  wait ring_offset;

  self RotateRoll(-70 * swing_dir, 2.0, 0.5, 0.5);
  wait 1.75;
  wait 0.25;

  self RotateRoll(60 * swing_dir, 2.0, 0.5, 0.5);
  wait 1.75;
  wait 0.25;

  self RotateRoll(-50 * swing_dir, 2.0, 0.5, 0.5);
  wait 1.75;
  wait 0.25;

  self RotateRoll(40 * swing_dir, 2.0, 0.5, 0.5);
  wait 1.75;
  wait 0.25;

  self RotateRoll(-30 * swing_dir, 2.0, 0.5, 0.5);
  wait 1.75;
  wait 0.25;

  self RotateRoll(20 * swing_dir, 1.5, 0.5, 0.5);
  wait 1.5;
  self RotateRoll(-15 * swing_dir, 1.3, 0.5, 0.5);
  wait 1.3;
  self RotateRoll(5 * swing_dir, 1.0, 0.5, 0.5);
  wait 1.0;

  self.is_swaying = false;
}

bell_sound_alias(bell_info) {
  sound_alias = "rr_church_bell";
  if(isDefined(bell_info) && (bell_info == "small")) {
    if(!isDefined(level.small_bells)) {
      level.small_bells = 0;
    }

    level.small_bells++;
    if(level.small_bells == 1) {
      sound_alias = "rr_church_bell_smallest";
    } else if(level.small_bells == 2) {
      sound_alias = "rr_church_bell_smaller";
    } else {
      sound_alias = "rr_church_bell_small";
    }
  }
  return sound_alias;
}