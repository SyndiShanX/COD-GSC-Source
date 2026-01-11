/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_battery3.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_battery3_precache::main();
  maps\createart\mp_battery3_art::main();
  maps\mp\mp_battery3_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_battery3");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_specularColorScale", 2.5, 15);
  SetDvar_cg_ng("r_reactiveMotionWindFrequencyScale", 0, 0.1);
  SetDvar_cg_ng("r_reactiveMotionWindAmplitudeScale", 0, 0.5);
  SetDvar_cg_ng("sm_sunSampleSizeNear", .25, .55);

  setdvar("r_dof_hq", 0);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  setupLevelKillstreak();

  thread watersheet_trig_setup();

  debugEvents();
}

setupLevelKillstreak() {
  config = spawnStruct();
  config.crateWeight = 85;
  config.crateHint = &"MP_BATTERY3_VOLCANO_HINT";
  config.debugName = "Volcano";
  config.id = "volcano";
  config.weaponName = "warhawk_mortar_mp";
  config.sourceStructs = "volcano_source";

  config.targetStructs = "volcano_small_target";

  config.launchDelay = 3;

  config.projectilePerLoop = 12;

  config.model = "ruins_volcano_rock_03";

  config.launchDelayMin = 0.05;
  config.launchDelayMax = 0.2;
  config.launchAirTimeMin = 6;
  config.launchAirTimeMax = 8;
  config.strikeDuration = 0.5;

  config.rotateProjectiles = true;
  config.minRotatation = -90;
  config.maxRotation = 90;

  config.incomingSfx = "volcano_incoming";
  config.trailVfx = "med_meteor_trail";

  config.impactVfx = "med_meteor_impact";
  config.impactSfx = "volcano_explosion_dirt";

  level._effect["med_meteor_impact"] = loadfx("vfx/moments/mp_battery3/vfx_ground_impact_medium");
  level._effect["med_meteor_trail"] = loadfx("vfx/moments/mp_battery3/vfx_smoketrail_meteor_med");
  level._effect["large_meteor_impact"] = loadfx("vfx/moments/mp_battery3/vfx_ground_impact_large");
  level._effect["large_meteor_trail"] = loadfx("vfx/moments/mp_battery3/vfx_smoketrail_meteor_large");

  maps\mp\killstreaks\_mortarstrike::createMortar(config);

  maps\mp\killstreaks\_juggernaut_predator::juggPredatorInit();
  thread waitForPredatorDeath();

  level.mapCustomKillstreakFunc = ::battery3CustomKillstreak;
  level.mapCustomCrateFunc = ::battery3CustomCrate;
  level.mapCustomBotKillstreakFunc = ::battery3CustomBotKillstreakFunc;

  level thread volcanoWaitForUse(config.sourceStructs);

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
}

battery3CustomKillstreak() {
  maps\mp\killstreaks\_mortarstrike::mortarCustomKillstreakFunc();
  maps\mp\killstreaks\_juggernaut_predator::customKillstreakFunc();
}

battery3CustomCrate() {
  tempVolcanoWeight = level.mortarConfig.crateWeight;
  level.mortarConfig.crateWeight = 0;
  maps\mp\killstreaks\_mortarstrike::mortarCustomCrateFunc();
  level.mortarConfig.crateWeight = tempVolcanoWeight;

  maps\mp\killstreaks\_juggernaut_predator::customCrateFunc();
}

battery3CustomBotKillstreakFunc() {
  maps\mp\killstreaks\_mortarstrike::mortarCustomBotKillstreakFunc();
  maps\mp\killstreaks\_juggernaut_predator::customBotKillstreakFunc();
}

waitForPredatorDeath() {
  level waittill("jugg_predator_killed", predator);

  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", level.mortarConfig.id, level.mortarConfig.crateWeight);
}

VOLCANO_RUMBLE_RADIUS = 15000;
volcanoWaitForUse(volcanoSourceName) {
  level endon("game_ended");

  volcanoSource = getstruct(volcanoSourceName, "targetname");

  while(true) {
    level waittill("mortar_killstreak_used", owner);

    wait(1.0);

    PlaySoundAtPos(volcanosource.origin, "volcano_rumble_start");
    Earthquake(0.1, 5.0, level.mapCenter, VOLCANO_RUMBLE_RADIUS);

    level waittill("mortar_killstreak_start");

    smallDebrisCfg = level.mortarConfig;

    PlaySoundAtPos(volcanoSource.origin, "volcano_eruption_primary");
    exploder(1);
    Earthquake(0.3, 2.0, level.mapCenter, VOLCANO_RUMBLE_RADIUS);
    playRumble("artillery_rumble");

    delay = RandomFloatRange(2, 3);
    wait(delay);

    volcanoSounds[0] = "volcano_eruption_second";
    volcanoSounds[1] = "volcano_eruption_third";
    volcanoSounds[2] = "volcano_eruption_fourth";

    for(i = 0; i < 3; i++) {
      smallDebrisCfg maps\mp\killstreaks\_mortarstrike::mortar_fire(smallDebrisCfg.launchDelayMin, smallDebrisCfg.launchDelayMax,
        smallDebrisCfg.launchAirTimeMin, smallDebrisCfg.launchAirTimeMax,
        smallDebrisCfg.strikeDuration,
        owner
      );
      PlaySoundAtPos(volcanoSource.origin, volcanoSounds[i]);
      exploder(1);
      Earthquake(0.3, 2.0, level.mapCenter, VOLCANO_RUMBLE_RADIUS);
      playRumble("damage_light");

      delay = RandomFloatRange(1.0, 2.0);
      wait(delay);
    }

  }
}

volcanoInitLargeChunks() {
  level.volcanoLargeChunks = getEntArray("volcano_bigchunk", "targetname");

  foreach(chunk in level.volcanoLargeChunks) {
    chunk clearPath();
  }
}

volcanoDoLargeChunks(numChunks, owner) {
  if(level.volcanoLargeChunks.size == 0) {
    return;
  }
  assert(numChunks <= level.volcanoLargeChunks.size);

  selectedChunks = [];

  volcanoSource = getstruct(level.mortarConfig.sourceStructs, "targetname");

  for(i = 0; i < numChunks; i++) {
    index = RandomInt(level.volcanoLargeChunks.size);
    while(isDefined(selectedChunks[index])) {
      index = RandomInt(level.volcanoLargeChunks.size);
    }

    selectedChunks[index] = true;

    level.volcanoLargeChunks[index] thread volcanoLaunchLargeChunk(volcanoSource.origin, owner);

    delay = RandomIntRange(0, 3) * 0.05;
    wait(delay);
  }
}

volcanoLaunchLargeChunk(startPos, owner) {
  gravity = (0, 0, -800);

  air_time = RandomFloatRange(9.0, 12.0);
  launch_dir = TrajectoryCalculateInitialVelocity(startPos, self.origin, gravity, air_time);

  self.weaponName = level.mortarConfig.weaponName;

  self.impactVfx = "large_meteor_impact";
  self.rotateProjectiles = true;
  self.minRotatation = -150;
  self.maxRotation = 150;

  self maps\mp\killstreaks\_mortarstrike::random_mortars_fire_run(startPos, self.origin, air_time, owner, launch_dir, true);

  self blockPath();

  RadiusDamage(self.origin, 80, 1000, 1000, undefined, "MOD_CRUSH");
  crushAllObjects(self.origin, 80);
}

volcano_activate_at_end_of_match() {
  level endon("mortar_killstreak_used");
  level waittill("spawning_intermission");
  level.ending_flourish = true;

  level.mortarConfig maps\mp\killstreaks\_mortarstrike::mortar_fire(0.1, 0.3, 2.5, 2.5, 6, level.players[0]);
  volcanoSource = getstruct(level.mortarConfig.sourceStructs, "targetname");

  effectFwd = anglesToForward(VectorNormalize(volcanoSource.origin - level.mapCenter));
  effectUp = AnglesToUp((0, 0, 0));

  playFX(getfx("volcano_explode_01"), volcanoSource.origin, effectUp, effectFwd);
  Earthquake(0.3, 2.0, level.mapCenter, VOLCANO_RUMBLE_RADIUS);
  playRumble("artillery_rumble");
}

volcanoRumble(sourcePos, magnitude, duration) {
  level endon("mortar_killstreak_start");
  level endon("mortar_killstreak_end");

  timeStamp = GetTime() + duration * 1000;

  while(GetTime() < timeStamp) {
    rumbleDuration = RandomFloatRange(0.5, 1.0);
    Earthquake(magnitude, rumbleDuration, sourcePos, VOLCANO_RUMBLE_RADIUS);

    playRumble("damage_light");

    wait(2.0 * rumbleDuration);
  }
}

setupTemple() {
  pre = getEntArray("temple_pre", "targetname");

  post = getEntArray("temple_post", "targetname");
  foreach(model in post) {
    model clearPath();
  }

  animModels = getEntArray("temple_anim", "targetname");
  foreach(animModel in animModels) {
    animModel Hide();
  }

  temple = spawnStruct();
  temple.postCollapse = post;
  temple.preCollapse = pre;
  temple.animModels = animModels;

  temple thread templeCollapse();
}

#using_animtree("vfx_dlc2");
CONST_TEMPLE_DAMAGE_RADIUS = 500;
templeCollapse() {
  level waittill("mortar_killstreak_start");

  wait(2.0);

  exploder(55);
  wait(2.0);

  foreach(chunk in self.preCollapse) {
    chunk clearPath();
  }

  animLength = 7.5;
  if((level.ps3) || (level.xenon)) {
    animLength = GetAnimLength( % mp_ruins_td_01_cg_anim);
  } else {
    animLength = GetAnimLength( % mp_ruins_temple_debris_01_anim);
  }

  foreach(animModel in self.animModels) {
    animModel Show();

    animName = animModel.script_noteworthy;
    if(!isDefined(animName)) {
      animName = "mp_ruins_td_01_cg_anim";

    }

    animModel ScriptModelPlayAnim(animName);
  }

  PlaySoundAtPos(self.preCollapse[0].origin, "scn_battery3_temple_collapse");

  wait(1.5);

  impactPoint = undefined;
  foreach(rubble in self.postCollapse) {
    if(isDefined(rubble.clip)) {
      impactPoint = rubble.clip.origin;
      break;
    }
  }

  Earthquake(0.25, 0.5, impactPoint, CONST_TEMPLE_DAMAGE_RADIUS);
  RadiusDamage(impactPoint, CONST_TEMPLE_DAMAGE_RADIUS, 500, 500, undefined, "MOD_CRUSH");
  crushAllObjects(impactPoint, CONST_TEMPLE_DAMAGE_RADIUS);

  wait(2);

  foreach(model in self.postCollapse) {
    model blockPath();
  }

  wait(animLength - 3.5);

  foreach(animModel in self.animModels) {
    animModel Hide();
  }

}

playRumble(rumbleType) {
  foreach(player in level.players) {
    player PlayRumbleOnEntity(rumbleType);
  }
}

clearPath() {
  self Hide();
  self NotSolid();

  if(isDefined(self.target)) {
    clip = GetEnt(self.target, "targetname");
    self.clip = clip;

    clip ConnectPaths();
    clip NotSolid();
    clip Hide();
  }
}

blockPath() {
  self Show();
  self Solid();

  if(isDefined(self.clip)) {
    self.clip Show();
    self.clip Solid();
    self.clip DisconnectPaths();
  }
}

crushAllObjects(refPos, radius) {
  radiusSq = radius * radius;

  crushObjects(refPos, radiusSq, "death", level.turrets);
  crushObjects(refPos, radiusSq, "death", level.placedIMS);
  crushObjects(refPos, radiusSq, "death", level.uplinks);
  crushObjects(refPos, radiusSq, "detonateExplosive", level.mines);

  foreach(boxList in level.deployable_box) {
    crushObjects(refPos, radiusSq, "death", boxList);
  }
}

crushObjects(refPos, radiusSq, notifyStr, targets) {
  foreach(target in targets) {
    if(DistanceSquared(refPos, target.origin) < radiusSq) {
      target notify(notifyStr);

    }
  }
}

watersheet_trig_setup() {
  level endon("game_ended");

  trig = GetEnt("watersheet", "targetname");

  while(true) {
    trig waittill("trigger", player);

    if(IsPlayer(player) && !IsAI(player) && !(isDefined(player.inWater) && player.inWater)) {
      player thread playerTrackWaterSheet(trig);
    }
  }
}

playerTrackWaterSheet(waterTrig) {
  self endon("disconnect");

  self.inWater = true;

  self notify("predator_force_uncloak");

  self SetWaterSheeting(1);

  while(isReallyAlive(self) && self IsTouching(waterTrig) && !level.gameEnded) {
    wait(0.5);
  }

  self SetWaterSheeting(0);

  self.inWater = false;
}

debugEvents() {
  SetDvarIfUninitialized("scr_dbg_fx", 0);
  SetDvarIfUninitialized("scr_dbg_temple", 0);

  while(true) {
    checkDbgDvar("scr_dbg_fx", ::dbgFireFx, undefined);
    checkDbgDvar("scr_dbg_temple", ::dbgTemple, undefined);

    wait(0.1);
  }
}

checkDbgDvar(dvarName, callback, notifyStr) {
  if(GetDvarInt(dvarName) > 0) {
    if(isDefined(callback)) {
      [[callback]](GetDvarInt(dvarName));
    }

    if(isDefined(notifyStr)) {
      level notify(notifyStr);
    }

    SetDvar(dvarName, 0);
  }
}

dbgFireFx(fxId) {
  exploder(fxId);
}

dbgTemple(repeats) {
  level endon("game_ended");

  while(repeats != 0) {
    pre = getEntArray("temple_pre", "targetname");
    foreach(chunk in pre) {
      if(isDefined(chunk.clip)) {
        chunk blockPath();
      }
    }

    setupTemple();

    level notify("mortar_killstreak_start");

    wait(12);
    repeats--;
  }
}
# /