/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_mortarstrike.gsc
*************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

createMortar(config) {
  level.mortarConfig = config;

  config thread update_mortars();
  level.air_raid_active = false;

  level.mapCustomCrateFunc = ::mortarCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::mortarCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::mortarCustomBotKillstreakFunc;
}

RUMBLE_MORTARS_WEIGHT = 85;
mortarCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"])) {
    game["player_holding_level_killstrek"] = false;
  }

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault",
    level.mortarConfig.id,
    level.mortarConfig.crateWeight,
    maps\mp\killstreaks\_airdrop::killstreakCrateThink,
    maps\mp\killstreaks\_airdrop::get_friendly_crate_model(),
    maps\mp\killstreaks\_airdrop::get_enemy_crate_model(),
    level.mortarConfig.crateHint
  );
  level thread watch_for_mortars_crate();
}

watch_for_mortars_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == level.mortarConfig.id) {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", level.mortarConfig.id, 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", level.mortarConfig.id, level.mortarConfig.crateWeight);
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

mortarCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/" + level.mortarConfig.debugName + "\" \"set scr_devgivecarepackage " + level.mortarConfig.id + "; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/" + level.mortarConfig.debugName + "\" \"set scr_givekillstreak " + level.mortarConfig.id + "\"\n");

  level.killStreakFuncs[level.mortarConfig.id] = ::tryUseMortars;

  level.killstreakWeildWeapons[level.mortarConfig.weaponName] = level.mortarConfig.id;
}

mortarCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/" + level.mortarConfig.debugName + "\" \"set scr_testclients_givekillstreak " + level.mortarConfig.id + "\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func(level.mortarConfig.id, maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseMortars(lifeId, streakName) {
  if(level.air_raid_active) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  game["player_holding_level_killstrek"] = false;
  level notify("mortar_killstreak_used", self);

  if(isDefined(level.mortarConfig.splashName)) {
    self thread teamPlayerCardSplash(level.mortarConfig.splashName, self);
  }

  return true;
}

mortars_activate_at_end_of_match() {
  level endon("mortar_killstreak_used");
  level waittill("spawning_intermission");
  level.ending_flourish = true;

  mortar_fire(0.1, 0.3, 2.5, 2.5, 6, level.players[0]);
}

update_mortars() {
  level endon("stop_dynamic_events");

  waitframe();

  if(isDefined(self.sourceStructs)) {
    self.mortar_sources = getstructarray(self.sourceStructs, "targetname");
  } else if(isDefined(self.sourceEnts)) {
    self.mortar_sources = getEntArray(self.sourceEnts, "targetname");
  }
  foreach(source in self.mortar_sources) {
    if(!isDefined(source.radius)) {
      source.radius = 300;
    }
  }

  self.mortar_targets = getstructarray(self.targetStructs, "targetname");
  foreach(mortar_target in self.mortar_targets) {
    if(!isDefined(mortar_target.radius)) {
      mortar_target.radius = 100;
    }
  }

  while(1) {
    level.air_raid_active = false;
    level.air_raid_team_called = "none";
    self thread mortars_activate_at_end_of_match();

    level waittill("mortar_killstreak_used", player);

    level.air_raid_active = true;
    level.air_raid_team_called = player.team;
    self thread warning_audio();
    wait(self.launchDelay);

    self mortar_fire(self.launchDelayMin, self.launchDelayMax,
      self.launchAirTimeMin, self.launchAirTimeMax,
      self.strikeDuration,
      player
    );

    level notify("mortar_killstreak_end");
  }
}

warning_audio() {
  if(!isDefined(self.warningSfxEntName) || !isDefined(self.warningSfx)) {
    return;
  }
  if(!isDefined(self.warning_sfx_ent)) {
    self.warning_sfx_ent = GetEnt(self.warningSfxEntName, "targetname");
  }

  if(isDefined(self.warning_sfx_ent)) {
    self.warning_sfx_ent playSound(self.warningSfx);

    wait(self.warningSfxDuration);

    self.warning_sfx_ent StopSounds();
  }
}

mortar_fire(delay_min, delay_max, airtime_min, airtime_max, mortar_time_sec, owner) {
  motar_strike_end_time = GetTime() + mortar_time_sec * 1000;

  source_structs = self random_mortars_get_source_structs(level.air_raid_team_called);
  if(source_structs.size <= 0) {
    PrintLn("Mortars: Didn't find any sources: targetname = " + self.sourceStructs);
    return;
  }

  level notify("mortar_killstreak_start");

  air_raid_num = 0;
  while(motar_strike_end_time > GetTime()) {
    mortars_per_loop = self.projectilePerLoop;
    mortars_launched = 0;
    foreach(player in level.players) {
      if(!isReallyAlive(player)) {
        continue;
      }
      if(level.teamBased) {
        if(player.team == level.air_raid_team_called) {
          continue;
        }
      } else {
        if(isDefined(owner) && player == owner) {
          continue;
        }
      }

      if(player.spawnTime + 8000 > GetTime()) {
        continue;
      }
      vel = player GetVelocity();

      mortar_air_time = airtime_min;
      if(airtime_max > airtime_min) {
        mortar_air_time = RandomFloatRange(airtime_min, airtime_max);
      }

      mortar_target_pos = player.origin + (vel * mortar_air_time);

      nodes_near = GetNodesInRadiusSorted(mortar_target_pos, 100, 0, 60);
      foreach(node in nodes_near) {
        if(NodeExposedToSky(node)) {
          source_struct = random(source_structs);

          if(self random_mortars_fire(source_struct.origin, node.origin, mortar_air_time, owner, true, true, source_struct)) {
            wait RandomFloatRange(delay_min, delay_max);
            mortars_launched++;
            break;
          }
        }
      }
    }

    if(self.mortar_targets.size > 0) {
      source_structs = array_randomize(source_structs);
      while(mortars_launched < mortars_per_loop) {
        source_struct = source_structs[air_raid_num];
        air_raid_num++;
        if(air_raid_num >= source_structs.size) {
          air_raid_num = 0;
        }

        target_struct = random(self.mortar_targets);

        mortar_air_time = airtime_min;
        if(airtime_max > airtime_min) {
          mortar_air_time = RandomFloatRange(airtime_min, airtime_max);
        }

        start = random_point_in_circle(source_struct.origin, source_struct.radius);
        end = random_point_in_circle(target_struct.origin, target_struct.radius);
        self thread random_mortars_fire(start, end, mortar_air_time, owner, false, true, source_struct);
        wait RandomFloatRange(delay_min, delay_max);
        mortars_launched++;
      }
    } else {
      break;
    }

    if(isDefined(self.delayBetweenVolleys)) {
      level notify("mortar_volleyFinished");

      wait(self.delayBetweenVolleys);
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

random_mortars_fire(start_org, end_org, air_time, owner, trace_test, play_fx, sourceObj) {
  if(isDefined(self.launchSfx)) {
    PlaySoundAtPos(start_org, self.launchSfx);
  } else if(isDefined(self.launchSfxArray) && self.launchSfxArray.size > 0 && isDefined(self.launchSfxStartId)) {
    if(self.launchSfxStartId >= self.launchSfxArray.size) {
      self.launchSfxStartId = 0;
    }

    PlaySoundAtPos(start_org, self.launchSfxArray[self.launchSfxStartId]);
    self.launchSfxStartId++;
  }

  gravity = (0, 0, -800);

  launch_dir = TrajectoryCalculateInitialVelocity(start_org, end_org, gravity, air_time);

  if(isDefined(self.launchVfx)) {
    if(isDefined(sourceObj) && sourceObj.classname != "struct") {
      playFXOnTag(getfx(self.launchVfx), sourceObj, "tag_origin");
    } else {
      playFX(getfx(self.launchVfx), start_org, launch_dir);
    }
  }

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

  mortar_model = createProjectileEntity(start_org, self.model);
  mortar_model.in_use = true;

  waitframe();
  if(isDefined(self.trailVfx)) {
    playFXOnTag(getfx(self.trailVfx), mortar_model, "tag_fx");
  }

  mortar_model.angles = VectorToAngles(launch_dir) * (-1, 1, 1);

  if(isDefined(self.incomingSfx)) {
    thread playSoundAtPosInTime(self.incomingSfx, end_org, air_time - 2.0);
  }

  mortar_model MoveGravity(launch_dir, air_time - 0.05);

  if(isDefined(self.rotateProjectiles) && self.rotateProjectiles) {
    mortar_model RotateVelocity(randomvectorrange(self.minRotatation, self.maxRotation), air_time, 2, 0);
  }

  mortar_model waittill("movedone");

  if(level.createFX_enabled && !isDefined(level.players)) {
    level.players = [];
  }

  if(isDefined(owner)) {
    mortar_model RadiusDamage(end_org, 250, 750, 500, owner, "MOD_EXPLOSIVE", self.weaponName);
  } else {
    mortar_model RadiusDamage(end_org, 140, 5, 5, undefined, "MOD_EXPLOSIVE", self.weaponName);
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
    if(isDefined(self.impactVfx)) {
      playFX(getfx(self.impactVfx), end_org);
    }

    if(isDefined(self.impactSfx)) {
      PlaySoundAtPos(end_org, self.impactSfx);
    }
  }

  mortar_model Delete();
}

playSoundAtPosInTime(sound, pos, delay) {
  wait(delay);

  playSoundAtPos(pos, sound);
}

createProjectileEntity(origin, modelName) {
  mortar_model = spawn("script_model", origin);
  mortar_model setModel(modelName);
  return mortar_model;
}

random_mortars_get_source_structs(owner_team) {
  source_structs = [];

  if(level.teamBased) {
    foreach(struct in self.mortar_sources) {
      if(isDefined(struct.script_team) && struct.script_team == owner_team) {
        source_structs[source_structs.size] = struct;
      }
    }
  }

  if(source_structs.size == 0) {
    source_structs = self.mortar_sources;
  }

  return source_structs;
}