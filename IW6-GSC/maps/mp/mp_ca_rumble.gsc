/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_rumble.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_ca_rumble_precache::main();
  maps\createart\mp_ca_rumble_art::main();
  maps\mp\mp_ca_rumble_fx::main();

  level thread update_mortars();
  level.air_raid_active = false;
  level.mapCustomCrateFunc = ::rumbleCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::rumbleCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::rumbleCustomBotKillstreakFunc;

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_ca_rumble");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  if(level.ps3) {
    SetDvar("sm_sunShadowScale", "0.55");
    SetDvar("sm_sunsamplesizenear", ".15");
  } else if(level.xenon) {
    SetDvar("sm_sunShadowScale", "0.56" +
      "");
    SetDvar("sm_sunsamplesizenear", ".22");
  } else {
    SetDvar("sm_sunShadowScale", "0.9");
    SetDvar("sm_sunsamplesizenear", ".27");
  }

  setdvar_cg_ng("r_specularColorScale", 1.7, 5);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  fixMLGCameraPosition();

  thread setup_fish();
  thread setup_destructibles();
  thread setup_metal_detectors();
  thread setup_watertanks();
  thread setup_bouys();
  thread setup_dock_boats();
  thread setup_monitors();

  thread update_destroyer();
  thread update_trolley();
  thread update_lighthouse_light();

  thread setup_fountain_fx();

  thread update_artillery_fx();
  thread update_heli_fx();
  thread update_flybyjet_fx();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
  level thread initExtraCollision();
}

initExtraCollision() {
  collision1 = GetEnt("clip128x128x256", "targetname");
  collision1Ent = spawn("script_model", (-459.25, 1848, 487.75));
  collision1Ent.angles = (270, 322.793, 37.2067);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  collision2 = GetEnt("clip256x256x128", "targetname");
  collision2Ent = spawn("script_model", (-1984, 344, -120));
  collision2Ent.angles = (0, 0, 0);
  collision2Ent CloneBrushmodelToScriptmodel(collision2);
}

RUMBLE_MORTARS_WEIGHT = 85;
rumbleCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "warhawk_mortars", RUMBLE_MORTARS_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"KILLSTREAKS_HINTS_WARHAWK_MORTARS");
  level thread watch_for_rumble_mortars_crate();
}

watch_for_rumble_mortars_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "warhawk_mortars") {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "warhawk_mortars", 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "warhawk_mortars", RUMBLE_MORTARS_WEIGHT);
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

rumbleCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Rumble Mortars\" \"set scr_devgivecarepackage warhawk_mortars; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Rumble Mortars\" \"set scr_givekillstreak warhawk_mortars\"\n");

  level.killStreakFuncs["warhawk_mortars"] = ::tryUseRumbleMortars;

  level.killstreakWeildWeapons["warhawk_mortar_mp"] = "warhawk_mortars";
}

rumbleCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Rumble Mortars\" \"set scr_testclients_givekillstreak warhawk_mortars\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("warhawk_mortars", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseRumbleMortars(lifeId, streakName) {
  if(level.air_raid_active) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  game["player_holding_level_killstrek"] = false;
  level notify("rumble_mortar_killstreak", self);

  return true;
}

mortars_activate_at_end_of_match() {
  level endon("rumble_mortar_killstreak");
  level waittill("spawning_intermission");
  level.ending_flourish = true;
  mortar_fire(0.1, 0.3, 6, level.players[0]);
}

update_mortars() {
  level endon("stop_dynamic_events");

  waitframe();

  level.mortar_sources = getstructarray("rumble_mortar_source", "targetname");
  foreach(source in level.mortar_sources) {
    if(!isDefined(source.radius))
      source.radius = 300;
  }

  level.mortar_targets = getstructarray("rumble_mortar_target", "targetname");
  foreach(mortart_target in level.mortar_targets) {
    if(!isDefined(mortart_target.radius))
      mortart_target.radius = 100;
  }

  while(1) {
    level.air_raid_active = false;
    level.air_raid_team_called = "none";
    thread mortars_activate_at_end_of_match();
    level waittill("rumble_mortar_killstreak", player);
    level.air_raid_active = true;
    level.air_raid_team_called = player.team;
    thread mortar_siren(10);
    wait 3;
    mortar_fire(.5, .6, 25, player);
  }
}

mortar_siren(siren_time) {
  if(!isDefined(level.mortar_siren_ent)) {
    level.mortar_siren_ent = getEnt("mortar_siren", "targetname");
  }

  if(isDefined(level.mortar_siren_ent)) {
    level.mortar_siren_ent playSound("mortar_siren");
  }
  wait siren_time;

  if(isDefined(level.mortar_siren_ent)) {
    level.mortar_siren_ent StopSounds();
  }
}

mortar_fire(delay_min, delay_max, mortar_time_sec, owner) {
  motar_strike_end_time = GetTime() + mortar_time_sec * 1000;

  source_structs = random_mortars_get_source_structs(level.air_raid_team_called);
  if(source_structs.size <= 0) {
    PrintLn("Rumble Mortars: Didn't find any sources: targetname = rumble_mortar_source");
    return;
  }

  air_raid_num = 0;
  while(motar_strike_end_time > GetTime()) {
    mortars_per_loop = 12;
    mortars_launched = 0;
    foreach(player in level.players) {
      if(!isReallyAlive(player)) {
        continue;
      }
      if(level.teamBased) {
        if(player.team == level.air_raid_team_called)
          continue;
      } else {
        if(isDefined(owner) && player == owner)
          continue;
      }

      if(player.spawnTime + 8000 > GetTime()) {
        continue;
      }
      vel = player GetVelocity();

      mortar_air_time = RandomFloatRange(3, 4);

      mortar_target_pos = player.origin + (vel * mortar_air_time);

      nodes_near = GetNodesInRadiusSorted(mortar_target_pos, 100, 0, 60);
      foreach(node in nodes_near) {
        if(NodeExposedToSky(node)) {
          source_struct = random(source_structs);

          if(random_mortars_fire(source_struct.origin, node.origin, undefined, owner, true, true)) {
            wait RandomFloatRange(delay_min, delay_max);
            mortars_launched++;
            break;
          }
        }
      }
    }

    if(level.mortar_targets.size > 0) {
      source_structs = array_randomize(source_structs);
      while(mortars_launched < mortars_per_loop) {
        source_struct = source_structs[air_raid_num];
        air_raid_num++;
        if(air_raid_num >= source_structs.size)
          air_raid_num = 0;

        target_struct = random(level.mortar_targets);

        start = random_point_in_circle(source_struct.origin, source_struct.radius);
        end = random_point_in_circle(target_struct.origin, target_struct.radius);
        thread random_mortars_fire(start, end, undefined, owner, false, true);
        wait RandomFloatRange(delay_min, delay_max);
        mortars_launched++;
      }
    } else {
      break;
    }
  }
}

random_point_in_circle(origin, radius) {
  if(radius > 0) {
    rand_dir = anglesToForward((0, RandomFloatRange(0, 360), 0));
    rand_radius = RandomFloatRange(0, radius);
    origin = origin + (rand_dir * rand_radius);
  }

  return origin;
}

random_mortars_fire(start_org, end_org, air_time, owner, trace_test, play_fx) {
  PlaySoundAtPos(start_org, "mortar_launch");

  gravity = (0, 0, -800);

  if(!isDefined(air_time)) {
    if(isDefined(level.ending_flourish) && level.ending_flourish)
      air_time = 2.5;
    else
      air_time = RandomFloatRange(10.0, 12.0);
  }
  launch_dir = TrajectoryCalculateInitialVelocity(start_org, end_org, gravity, air_time);

  if(isDefined(trace_test) && trace_test) {
    delta_height = TrajectoryComputeDeltaHeightAtTime(launch_dir[2], -1 * gravity[2], air_time / 2);
    trace_point = ((end_org - start_org) / 2) + start_org + (0, 0, delta_height);

    if(BulletTracePassed(trace_point, end_org, false, undefined)) {
      thread random_mortars_fire_run(start_org, end_org, air_time, owner, launch_dir, play_fx);
      return true;
    } else {
      return false;
    }
  }

  random_mortars_fire_run(start_org, end_org, air_time, owner, launch_dir, play_fx);
}

random_mortars_fire_run(start_org, end_org, air_time, owner, launch_dir, play_fx) {
  dirt_effect_radius = 350;

  mortar_model = random_mortars_get_model(start_org);
  mortar_model.origin = start_org;
  mortar_model.in_use = true;

  waitframe();
  playFXOnTag(getfx("random_mortars_trail"), mortar_model, "tag_fx");

  mortar_model.angles = VectorToAngles(launch_dir) * (-1, 1, 1);

  delayThread(air_time - 2.0, ::random_mortars_incoming_sound, end_org);

  mortar_model MoveGravity(launch_dir, air_time - 0.05);
  mortar_model waittill("movedone");

  if(level.createFX_enabled && !isDefined(level.players))
    level.players = [];

  if(isDefined(owner)) {
    mortar_model RadiusDamage(end_org, 250, 750, 500, owner, "MOD_EXPLOSIVE", "warhawk_mortar_mp");
  } else {
    mortar_model RadiusDamage(end_org, 140, 5, 5, undefined, "MOD_EXPLOSIVE", "warhawk_mortar_mp");
  }
  PlayRumbleOnPosition("artillery_rumble", end_org);

  dirt_effect_radiusSq = dirt_effect_radius * dirt_effect_radius;
  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }

    if(DistanceSquared(end_org, player.origin) > dirt_effect_radiusSq) {
      continue;
    }

    if(player DamageConeTrace(end_org)) {
      player thread maps\mp\gametypes\_shellshock::dirtEffect(end_org);
    }
  }

  if(play_fx) {
    playFX(getfx("mortar_impact_00"), end_org);
  }

  mortar_model Delete();
}

random_mortars_incoming_sound(org) {
  PlaySoundAtPos(org, "mortar_incoming");
}

random_mortars_get_model(origin) {
  mortar_model = spawn("script_model", origin);
  mortar_model setModel("projectile_rpg7");
  return mortar_model;
}

random_mortars_get_source_structs(owner_team) {
  source_structs = [];

  if(level.teamBased) {
    foreach(struct in level.mortar_sources) {
      if(isDefined(struct.script_team) && struct.script_team == owner_team)
        source_structs[source_structs.size] = struct;
    }
  }

  if(source_structs.size == 0)
    source_structs = level.mortar_sources;

  return source_structs;
}

setup_destructibles() {
  orcas = getEntArray("dest_orca", "targetname");
  sharks = getEntArray("dest_shark", "targetname");
  if(sharks.size) {
    foreach(shark in sharks)
    shark thread update_destructibles(level._effect["vfx_mp_ca_rumble_shark_hit"], level._effect["vfx_mp_ca_rumble_shark_death"]);
  }
  if(orcas.size) {
    foreach(orca in orcas)
    orca thread update_destructibles(level._effect["vfx_mp_ca_rumble_orca_hit"], level._effect["vfx_mp_ca_rumble_orca_death"]);
  }
}

update_destructibles(effect_id, death_effect_id) {
  self Show();
  self setCanDamage(true);
  explosionDirection = undefined;

  hitCounter = RandomIntRange(2, 4);
  while(hitCounter > 0) {
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);

    hitCounter--;
    explosionDirection = direction_vec;
    thread play_hit(effect_id, hit_point, direction_vec);

    if(IsSubStr(damage_type, "MELEE") || IsSubStr(damage_type, "GRENADE")) {
      hitCounter = 0;
    } else if(IsSubStr(damage_type, "BULLET")) {
      if(amount > 60.0) {
        hitCounter = 0;
      } else {
        if(isDefined(attacker) && isDefined(attacker GetCurrentWeapon()) && (WeaponClass(attacker GetCurrentWeapon()) == "sniper")) {
          hitCounter = 0;
        }
      }
    }
  }

  if(!isDefined(explosionDirection))
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);
  else
    direction_vec = explosionDirection;

  self Hide();
  self setCanDamage(false);

  thread play_hit(death_effect_id, self GetOrigin(), direction_vec);
}

play_hit(effect_id, spawn_point, spawn_dir) {
  vfx_ent = SpawnFx(effect_id, spawn_point, anglesToForward(spawn_dir), AnglesToUp(spawn_dir));
  TriggerFX(vfx_ent);
  wait 5.0;
  vfx_ent Delete();
}

#using_animtree("mp_ca_rumble_animtree");
setup_fish() {
  fish = GetEnt("bannerfish", "targetname");

  if(isDefined(fish)) {
    fish thread update_fish();
  }

}

update_fish() {
  while(1) {
    testInt = RandomInt(3);
    self ScriptModelClearAnim();
    if(testInt == 0) {
      self ScriptModelPlayAnim("mp_ca_rumble_fish_swim_anim");
      wait(GetAnimLength( % mp_ca_rumble_fish_swim_anim));
    } else if(testInt == 1) {
      self ScriptModelPlayAnim("mp_ca_rumble_fish_swim_anim_b");
      wait(GetAnimLength( % mp_ca_rumble_fish_swim_anim_b));
    } else {
      self ScriptModelPlayAnim("mp_ca_rumble_fish_swim_anim_c");
      wait(GetAnimLength( % mp_ca_rumble_fish_swim_anim_c));
    }
  }
}

setup_metal_detectors() {
  metal_detectors = getEntArray("metal_detector_trigger", "targetname");
  if(metal_detectors.size > 0)
    array_thread(metal_detectors, ::update_metal_detector);
}

update_metal_detector() {
  self endon("detector_destroyed");

  my_devices = [];
  detector_devices = getEntArray("metal_detector_device", "targetname");
  foreach(device in detector_devices) {
    if(DistanceSquared(device.origin, self.origin) < 10000.0) {
      device.md_health = 100.0;
      device.light_on = GetEnt(device.target, "targetname");
      device.light_off = GetEnt(device.light_on.target, "targetname");
      device.light_broke = GetEnt(device.light_off.target, "targetname");
      device thread metal_detector_damage_monitor(self);
      my_devices = array_add(my_devices, device);
    }
  }

  self thread metal_detector_monitor_alive(my_devices);
  while(1) {
    foreach(device in my_devices)
    device thread metal_detector_on();

    self waittill("trigger");

    foreach(device in my_devices)
    device thread metal_detector_off();

    wait 5.0;
  }
}

metal_detector_monitor_alive(my_devices) {
  self waittill("detector_damaged");
  foreach(device in my_devices)
  device DoDamage(10000, device.origin);

  self notify("detector_destroyed");
}

metal_detector_damage_monitor(metal_detector) {
  self.light_on thread metal_detectorpart_damage_monitor(self);
  self.light_off thread metal_detectorpart_damage_monitor(self);

  self setCanDamage(true);
  while(self.md_health > 0.0) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(IsPlayer(attacker))
      self.maintain_fx = true;
    self.md_health -= amount;
  }

  self thread metal_detector_broke(metal_detector);
}

metal_detectorpart_damage_monitor(parent) {
  parent endon("detector_destroyed");

  self setCanDamage(true);
  while(1) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    parent DoDamage(10000, parent.origin);
  }
}

metal_detector_on() {
  if(self.md_health <= 0.0)
    return;
  self.light_on Show();
  self.light_off Hide();
  self.light_broke Hide();
  self playSound("metaldetector_reset");
}

metal_detector_off() {
  if(self.md_health <= 0.0)
    return;
  self.light_on Hide();
  self.light_off Show();
  self.light_broke Hide();
  self playSound("metaldetector_alarm");
}

metal_detector_broke(metal_detector) {
  metal_detector notify("detector_damaged");
  self.light_on Hide();
  self.light_off Hide();
  self.light_broke Show();

  if(isDefined(self.maintain_fx) && (self.maintain_fx == true)) {
    while(1) {
      self.light_broke playSound("metaldetector_sparks");
      playFX(level._effect["vfx_metaldetector_explosion"], self.light_broke.origin + (0.0, 0.0, 7.5));
      wait RandomFloatRange(45.0, 150.0);
    }
  }
}

setup_bouys() {
  bouys = getEntArray("harbor_bouy", "targetname");
  if(bouys.size <= 0) {
    PrintLn("No bouys found");
    return;
  }

  array_thread(bouys, ::update_bouy);
}

update_bouy() {
  start_point = self.origin;
  start_rot = self.angles;

  bob_rateSq = 15.0 * 15.0;
  while(1) {
    offset = (10.0, 10.0, 0.0) + randomvector(10.0);
    offset *= (3.0, 3.0, 2.0);

    dest = start_point + offset;
    time = Max(3.0, DistanceSquared(self.origin, dest) / bob_rateSq);

    self RotateTo(VectorToAngles(dest - start_point), time, 1.5, 1.5);
    self MoveTo(dest, time, 1.5, 1.5);
    wait time;
  }
}

setup_dock_boats() {
  boats = getEntArray("dock_boats", "targetname");
  if(boats.size <= 0) {
    PrintLn("No dock boats found");
    return;
  }

  array_thread(boats, ::update_dock_boat);
}

update_dock_boat() {
  start_rot = self.angles;

  bobbing_down = true;
  tilt_rate = 1.5;
  while(1) {
    tilt = (0.0, 0.0, RandomFloatRange(6.0, 8.0));
    time = Max(2.0, tilt[2] / tilt_rate);

    if(bobbing_down)
      tilt *= -1.0;
    bobbing_down = !bobbing_down;

    self RotateTo(start_rot + tilt, time, 1.0, 1.0);
    wait time;
  }
}

setup_monitors() {
  monitors = getEntArray("rumble_monitor", "targetname");
  if(monitors.size <= 0) {
    PrintLn("No monitors found");
    return;
  }

  array_thread(monitors, ::update_monitor);
}

update_monitor() {
  damage_state = GetEnt(self.target, "targetname");
  if(!isDefined(damage_state)) {
    PrintLn("No monitor damage state found.");
    return;
  }

  self Show();
  self setCanDamage(true);
  damage_state Hide();

  self waittill("damage");

  self Hide();
  damage_state Show();
  damage_state playSound("flatscreen_sparks");
  playFX(level._effect["vfx_flatscreen_explosion"], damage_state.origin);
}

setup_watertanks() {
  level.tank_hitfx_throttle = 600;
  level.tank_hitfx_throttle_max = 1200;
  level.next_tank_hitfx_time = -1.0;

  watertanks = getEntArray("watertank_glass", "targetname");
  if(watertanks.size > 0) {
    for(i = 0; i < watertanks.size; i++)
      watertanks[i] thread update_watertank(i);
  }

  watertanks = getEntArray("watertank_invulnerable", "targetname");
  array_thread(watertanks, ::update_watertank_invulnerable);
}

update_watertank(index) {
  water_surface = GetEnt(self.target, "targetname");
  if(!isDefined(water_surface)) {
    PrintLn("Water tank is missing a water_surface");
    return;
  }

  water_bottom = GetEnt(water_surface.target, "targetname");
  if(!isDefined(water_bottom)) {
    PrintLn("Water tank is missing a water_bottom");
    return;
  }

  broken_glass = GetEnt(water_bottom.target, "targetname");
  if(!isDefined(broken_glass)) {
    PrintLn("Water tank is missing a broken glass mesh");
    return;
  }

  water_surface thread update_watertank_fish();
  water_surface.destroyExplosiveOnCollision = false;

  broken_glass Hide();
  self setCanDamage(true);
  self.tank_damage = 0;
  surface_offset = 41.5;
  lowest_hit_z = water_surface.origin[2] + surface_offset;
  drain_rate = 2.0;
  drain_time = 4.0;
  start_time = 1.0;
  stop_time = 2.0;

  while(self.tank_damage < 1200.0) {
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);

    self.tank_damage += amount;

    if(!IsSubStr(damage_type, "BULLET")) {
      continue;
    }
    if(!can_allocate_new_tank_crack()) {
      continue;
    }
    current_surface = water_surface.origin[2] + surface_offset;
    if(hit_point[2] >= current_surface) {
      continue;
    }
    hit_angles = get_watertank_hit_angle(attacker, direction_vec, hit_point);
    if(!isDefined(hit_angles)) {
      continue;
    }
    drain_limit = Min(drain_time * drain_rate, current_surface - water_bottom.origin[2]);
    actual_move_z = Max(water_bottom.origin[2], Max(hit_point[2], current_surface - drain_limit));
    move_dist = actual_move_z - current_surface;

    move_time = Abs(move_dist) / drain_rate;
    move_time = Max(move_time, start_time + stop_time);

    self thread spawn_watertank_hit(level._effect["vfx_watertank_bullet_hit"], attacker, hit_angles, hit_point, move_time, water_surface, surface_offset);

    if(actual_move_z >= lowest_hit_z) {
      continue;
    }
    lowest_hit_z = actual_move_z;
    water_surface MoveZ(move_dist, move_time, start_time, stop_time);
  }

  self playSound("water_tank_splash");

  water_surface notify("tank_destroyed");
  wait 0.05;

  attachedExplosives = self GetLinkedChildren();
  foreach(explosive in attachedExplosives) {
    explosive notify("detonateExplosive");
  }

  self Delete();
  water_surface Delete();

  broken_glass Show();
  broken_glass ScriptModelPlayAnim("mp_ca_rumble_glass_anim");
  if(index == 0) {
    playFX(level._effect["vfx_glass_shatter_splash"], (-46.0003, 1409.25, 138.056), anglesToForward((0, 0, 0)), AnglesToUp((0, 0, 0)));
    playFX(level._effect["vfx_glass_ground_splash"], (-39.7033, 1414.08, 89), anglesToForward((270, 0, 0)), AnglesToUp((0, 0, 0)));
  } else {
    playFX(level._effect["vfx_glass_shatter_splash"], (-47.9208, 1144.29, 141.575), anglesToForward((0, 0, 0)), AnglesToUp((0, 0, 0)));
    playFX(level._effect["vfx_glass_ground_splash"], (-51.5828, 1139.69, 89), anglesToForward((270, 0, 0)), AnglesToUp((0, 0, 0)));
  }
}

update_watertank_fish() {
  self endon("death");

  wait 2.0;
  effect_id = level._effect["vfx_fish_school"];
  fish_ent = spawn("script_model", self.origin);
  fish_ent setModel("tag_origin");
  fish_ent LinkTo(self);

  self thread maintain_watertank_fish(effect_id, fish_ent);

  self waittill("tank_destroyed");

  KillFXOnTag(effect_id, fish_ent, "tag_origin");
  wait 0.05;
  fish_ent Delete();
}

maintain_watertank_fish(effect_id, fish_ent) {
  self endon("tank_destroyed");

  while(1) {
    playFXOnTag(effect_id, fish_ent, "tag_origin");
    wait 5.0;
    stopFXOnTag(effect_id, fish_ent, "tag_origin");
    wait 1.0;
  }
}

spawn_watertank_hit(effect_id, attacker, hit_angles, hit_point, drain_time, water_surface, surface_offset) {
  allocate_new_tank_crack();

  water_fx_ent = SpawnFx(effect_id, hit_point, hit_angles);
  TriggerFX(water_fx_ent);
  water_fx_ent playSound("water_tank_hit");

  stop_time = GetTime() + drain_time * 1000.0;
  water_fx_ent monitor_watertank_hit(water_surface, stop_time, surface_offset);

  water_fx_ent StopSounds();
  wait 0.05;
  water_fx_ent Delete();
}

monitor_watertank_hit(water_surface, stop_time, surface_offset) {
  water_surface endon("tank_destroyed");

  while(GetTime() < stop_time) {
    if(self.origin[2] >= ((water_surface.origin[2] + surface_offset) - 1.0)) {
      break;
    }
    wait 0.05;
  }
}

update_watertank_invulnerable() {
  self setCanDamage(true);
  while(1) {
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);

    if(!IsSubStr(damage_type, "BULLET")) {
      continue;
    }
    if(!can_allocate_new_tank_crack()) {
      continue;
    }
    hit_angles = get_watertank_hit_angle(attacker, direction_vec, hit_point);
    if(!isDefined(hit_angles)) {
      continue;
    }
    allocate_new_tank_crack();
    hit_angles = VectorToAngles(hit_angles);
    playFX(level._effect["vfx_watertank_bullet_hit"], hit_point, anglesToForward(hit_angles), AnglesToUp(hit_angles));
    PlaySoundAtPos(hit_point, "water_tank_hit");
  }
}

get_watertank_hit_angle(attacker, direction_vec, hit_point) {
  E = attacker.origin;
  temp_vec = hit_point - E;

  trace = bulletTrace(E, E + 1.5 * temp_vec, false, attacker, false);
  if(isDefined(trace["normal"]) && isDefined(trace["entity"]) && (trace["entity"] == self))
    return trace["normal"];

  return undefined;
}

can_allocate_new_tank_crack() {
  if(GetTime() < level.next_tank_hitfx_time)
    return false;
  return true;
}

allocate_new_tank_crack() {
  level.next_tank_hitfx_time = GetTime() + RandomFloatRange(level.tank_hitfx_throttle, level.tank_hitfx_throttle_max);
}

update_trolley() {
  waitframe();

  trolley = GetEnt("moving_trolley", "targetname");
  if(!isDefined(trolley)) {
    PrintLn("Trolley is missing.");
    return;
  }

  trolley.destroyAirdropOnCollision = true;
  trolley.destroyDroneOnCollision = false;

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "active", trolley.origin, "waypoint_trolley");
  Objective_OnEntityWithRotation(curObjID, trolley);
  self.curObjID = curObjID;

  trolley_lights = getstructarray("trolley_light", "targetname");
  array_thread(trolley_lights, ::trolley_attach_lights, trolley);

  trolley_mesh = getent("moving_trolley_mesh", "targetname");
  if(isDefined(trolley_mesh))
    trolley_mesh linkto(trolley);

  trolley_mesh_extras = getEntArray("moving_trolley_extras", "targetname");
  if(trolley_mesh_extras.size > 0) {
    foreach(extra in trolley_mesh_extras)
    extra linkto(trolley);
  }

  trolley_wheels = getEntArray("moving_trolley_wheel", "targetname");
  if(trolley_wheels.size <= 0) {
    Println("Trolley is missing wheels.");
    return;
  }

  wheel_offsets = [];
  wheel_rotations = [];
  for(i = 0; i < trolley_wheels.size; i++) {
    wheel_offsets[i] = trolley.origin - trolley_wheels[i].origin;
    wheel_rotations[i] = trolley.angles - trolley_wheels[i].angles;
  }

  current_point = GetEnt("trolley_path_start", "targetname");
  if(!isDefined(current_point)) {
    PrintLn("No trolley path to follow.");
    return;
  }

  trolley.origin = current_point.origin;
  trolley.angles = current_point.angles;
  for(i = 0; i < trolley_wheels.size; i++) {
    trolley_wheels[i].origin = current_point.origin - RotateVector(wheel_offsets[i], current_point.angles);
    trolley_wheels[i].angles = current_point.angles + wheel_rotations[i];
  }

  trolley.enabled = true;
  trolley thread monitor_trolley_dvar();

  default_speed = 140.0;
  stop_time = 0.0;
  start_time = 0.0;
  if(isDefined(current_point.script_accel))
    start_time = current_point.script_accel;

  current_point = GetEnt(current_point.target, "targetname");
  while(isDefined(current_point)) {
    if(!trolley.enabled) {
      wait 0.05;
      continue;
    }

    stop_time = 0.0;
    if(isDefined(current_point.script_decel))
      stop_time = current_point.script_decel;

    move_speed = default_speed;
    move_speed /= Max(1, GetDvarInt("trolley_throttle", 1));

    if(isDefined(current_point.script_physics))
      move_speed *= current_point.script_physics;
    move_time = Distance(trolley.origin, current_point.origin) / move_speed;
    move_time = Max(move_time, stop_time + start_time);

    trolley MoveTo(current_point.origin, move_time, start_time, stop_time);
    trolley RotateTo(current_point.angles, move_time, start_time, stop_time);

    wheel_speed = move_speed * 2.1;
    if(isDefined(current_point.script_anglevehicle) && (current_point.script_anglevehicle == 1))
      wheel_speed *= -1.0;

    point_angle = current_point.angles[1];
    for(i = 0; i < trolley_wheels.size; i++) {
      wheel_spot = current_point.origin - RotateVector(wheel_offsets[i], current_point.angles);
      trolley_wheels[i] MoveTo(wheel_spot, move_time, start_time, stop_time);
      wheel_turn = (point_angle + wheel_rotations[i][1] - trolley_wheels[i].angles[1]) / move_time;
      specific_wheel_speed = wheel_speed;
      if(isDefined(trolley_wheels[i].script_index) && (trolley_wheels[i].script_index == 1))
        specific_wheel_speed *= -1.0;
      trolley_wheels[i] RotateVelocity((0, wheel_turn, specific_wheel_speed), move_time, start_time, stop_time);
    }

    if(start_time > 0.0) {
      trolley_mesh PlaySoundOnMovingEnt("trolley_bell");
      trolley_mesh PlaySoundOnMovingEnt("trolley_start");
      wait(start_time - 0.2);
      trolley_mesh playLoopSound("trolley_motor");
      wait 0.2;
    }

    wait move_time - (start_time + stop_time);

    if(stop_time > 0.0) {
      trolley_mesh PlaySoundOnMovingEnt("trolley_stop");
      wait 0.2;
      trolley_mesh StopLoopSound("trolley_motor");
      wait(stop_time - 0.2);
    }

    if(isDefined(current_point.script_node_pausetime))
      wait current_point.script_node_pausetime;

    for(i = 0; i < trolley_wheels.size; i++)
      trolley_wheels[i].angles = (trolley_wheels[i].angles[0], point_angle + wheel_rotations[i][1], trolley_wheels[i].angles[2]);

    start_time = 0.0;
    if(isDefined(current_point.script_accel))
      start_time = current_point.script_accel;

    if(isDefined(current_point.script_index))
      trolley_mesh PlaySoundOnMovingEnt("trolley_corner");

    current_point = GetEnt(current_point.target, "targetname");
  }
}

trolley_attach_lights(trolley) {
  light_mount = spawn("script_model", self.origin);
  light_mount.angles = self.angles;
  light_mount setModel("tag_origin");
  light_mount LinkTo(trolley);

  while(1) {
    playFXOnTag(level._effect["vfx_pot_lights_trolley"], light_mount, "tag_origin");
    wait RandomFloatRange(4.0, 6.0);
    stopFXOnTag(level._effect["vfx_pot_lights_trolley"], light_mount, "tag_origin");
    waitframe();
  }
}

monitor_trolley_dvar() {
  dvar_name = "trolley_toggle";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);

  dvar_throttle = "trolley_throttle";
  default_throttle = 1;
  SetDevDvarIfUninitialized(dvar_throttle, default_throttle);

  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(value == default_value) {
      waitframe();
    } else {
      SetDevDvar(dvar_name, default_value);
      self.enabled = !self.enabled;
    }
  }
}

update_destroyer() {
  ship = GetEnt("roaming_destroyer", "targetname");
  if(!isDefined(ship)) {
    PrintLn("No roaming_destroyer ship.");
    return;
  }

  current_point = GetEnt(ship.target, "targetname");
  if(!isDefined(current_point)) {
    PrintLn("No roaming_destroyer ship path to follow.");
    return;
  }

  ship.origin = current_point.origin;
  ship.angles = current_point.angles;

  default_speed = 500.0;
  accel_time = 0.0;
  decel_time = 0.0;

  current_point = GetEnt(current_point.target, "targetname");
  if(isDefined(current_point.script_decel))
    decel_time = current_point.script_decel;

  while(isDefined(current_point)) {
    move_speed = default_speed;
    if(isDefined(current_point.script_physics))
      move_speed = current_point.script_physics;
    accel_time = 0.0;
    if(isDefined(current_point.script_accel))
      accel_time = current_point.script_accel;

    base_move_time = Distance(ship.origin, current_point.origin) / move_speed;
    move_time = Max(base_move_time, accel_time + decel_time);

    ship MoveTo(current_point.origin, move_time, accel_time, decel_time);
    ship RotateTo(current_point.angles, move_time, accel_time, decel_time);
    wait move_time;

    next_point = GetEnt(current_point.target, "targetname");
    if(isDefined(next_point)) {
      if(isDefined(next_point.script_node_pausetime))
        wait next_point.script_node_pausetime;
      decel_time = 0.0;
      if(isDefined(next_point.script_decel))
        decel_time = next_point.script_decel;
    }

    current_point = next_point;
  }
}

update_lighthouse_light() {
  lighthouse_light = GetEnt("lighthouse_light", "targetname");
  if(!isDefined(lighthouse_light)) {
    PrintLn("No lighthouse light.");
    return;
  }

  if(!isDefined(lighthouse_light.animation)) {
    PrintLn("No animation for the lighthouse light.");
    return;
  }

  lighthouse_light ScriptModelPlayAnim("mp_ca_rumble_lighthouse_rotate");
}

update_artillery_fx() {
  fx_alias = level._effect["vfx_battleship_firing_timing"];
  fx_pos = (14701.5, -17741.3, 854.587);
  fx_rot = anglesToForward((354.236, 135.865, 13.443));
  fx_up = AnglesToUp((354.236, 135.865, 13.443));

  sound_ent = spawn("script_model", fx_pos);
  sound_ent setModel("tag_origin");
  sound_alias = "emt_rumb_dist_arty_fire";

  wait RandomFloatRange(5.0, 20.0);
  while(1) {
    next_shot = 30.0 + RandomFloat(20.0);

    sound_ent.origin = fx_pos + (0, 0, 1000);
    sound_ent MoveTo(sound_ent.origin + (-55000, -60000, 16000), LookupSoundLength(sound_alias) * 0.001, 0.2);
    sound_ent PlaySoundOnMovingEnt(sound_alias);

    playFX(fx_alias, fx_pos, fx_rot, fx_up);

    wait next_shot;
  }
}

update_heli_fx() {
  fx_alias = level._effect["vfx_heli_timing"];
  fx_pos = (19354.8, -24794.2, 539.564);
  fx_rot = anglesToForward((0, 190, 0));
  fx_up = AnglesToUp((0, 190, 0));

  sound_ent = spawn("script_model", fx_pos);
  sound_ent setModel("tag_origin");
  sound_alias = "scn_rumb_chopper_by";

  wait RandomFloatRange(5.0, 20.0);
  while(1) {
    next_heli = 60.0 + RandomFloat(30.0);

    sound_ent.origin = fx_pos + (0, 0, 700);
    sound_ent MoveTo(sound_ent.origin + (-55000, -10000, 3000), 40.0, 10.0);
    sound_ent PlaySoundOnMovingEnt(sound_alias);

    playFX(fx_alias, fx_pos, fx_rot, fx_up);

    wait next_heli;
  }
}

update_flybyjet_fx() {
  fx_alias = level._effect["vfx_jet_flyby_timing"];
  fx_pos = (22547.9, -308.47, 1440.73);
  fx_rot = anglesToForward((0.855041, 223.034, -0.529352));
  fx_up = AnglesToUp((0.855041, 223.034, -0.529352));

  sound_ent = spawn("script_model", fx_pos);
  sound_ent setModel("tag_origin");
  sound_alias = "scn_rumb_jets_by";

  wait RandomFloatRange(5.0, 20.0);
  while(1) {
    next_plane = 90.0 + RandomFloat(30.0);

    sound_ent.origin = fx_pos + (0, 0, 1000);
    sound_ent MoveTo(sound_ent.origin + (-55000, -55000, 0), 20.0, 0.6);
    sound_ent PlaySoundOnMovingEnt(sound_alias);

    playFX(fx_alias, fx_pos, fx_rot, fx_up);

    wait next_plane;
  }
}

setup_fountain_fx() {
  thread update_fountain_fx((200.517, 631.669, 12), 1.1);
  thread update_fountain_fx((-47.933, 575.054, 26));
  thread update_fountain_fx((-300.421, 633.173, 8), 1.1);

  wait 1.0;
  while(1) {
    level notify("spawn_stair_fountain_fx");
    wait 8.0;
  }
}

update_fountain_fx(fx_pos, fx_delay) {
  fx_alias = level._effect["vfx_water_fountain"];

  sound_alias = "emt_rumb_fount_spray";

  while(1) {
    level waittill("spawn_stair_fountain_fx");
    if(isDefined(fx_delay) && (fx_delay > 0.0))
      wait fx_delay;

    playFX(fx_alias, fx_pos, anglesToForward((0, 0, 0)), AnglesToUp((0, 0, 0)));

    PlaySoundAtPos(fx_pos, sound_alias);
    wait 1.1;
    PlaySoundAtPos(fx_pos + (0.0, 32.0, 36.0), sound_alias);
    wait 1.1;
    PlaySoundAtPos(fx_pos + (0.0, 80.0, 68.0), sound_alias);
    wait 1.1;
    PlaySoundAtPos(fx_pos + (0.0, 120.0, 96.0), sound_alias);
  }
}

fixMLGCameraPosition() {
  mlgcameras = getEntArray("mp_mlg_camera", "classname");
  if(isDefined(mlgcameras) && mlgcameras.size) {
    foreach(camEnt in mlgcameras) {
      if(camEnt.origin == (-1064, -224, 272)) {
        camEnt.origin = (-632, -1712, 368);
        camEnt.angles = (10, 113, -1.174);
        break;
      }
    }
  }
}