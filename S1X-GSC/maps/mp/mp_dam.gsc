/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_dam.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;
#include maps\mp\_dynamic_events;
#using_animtree("animated_props");
main() {
  PreCacheModel("mp_dam_large_caliber_turret");

  maps\mp\mp_dam_precache::main();
  maps\createart\mp_dam_art::main();
  maps\mp\mp_dam_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_dam_lighting::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_dam");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.aerial_pathnode_offset = 600;

  level.mapCustomKillstreakFunc = ::damCustomKillstreakFunc;

  level.orbitalSupportOverrideFunc = ::damCustomOSPFunc;

  setdvar("r_mpRimColor", "1 1 1");
  setdvar("r_mpRimStrength", "1");
  setdvar("r_mpRimDiffuseTint", "1 1 1");

  thread rotateGenerators();

  thread Crane1Movement();
  thread Crane2Movement();

  thread SetupKillstreakTurrets();

  thread handle_glass_pathing();

  thread DamCustomAirstrike();
}

DamCustomAirstrike() {
  if(!isDefined(level.airstrikeoverrides)) {
    level.airstrikeoverrides = spawnStruct();
  }

  level.airstrikeoverrides.spawnHeight = 1750;
}

damCustomKillstreakFunc() {
  level.killstreakWeildWeapons["mp_dam_railgun"] = true;
  level.killstreakWeildWeapons["dam_turret_mp"] = true;

  level thread maps\mp\killstreaks\streak_mp_dam::init();
}

damCustomOSPFunc() {
  level.orbitalsupportoverrides.spawnOrigin = (1544, 1016, 200);
  level.orbitalsupportoverrides.spawnAngle = 120;
  level.orbitalsupportoverrides.spawnRadius = undefined;
  level.orbitalsupportoverrides.spawnHeight = undefined;
}

SetupKillstreakTurrets() {
  Turrets = [];
  railgun_script_origin = GetEnt("railgun_attachpoint0", "targetname");
  turret = railgun_script_origin SpawnDamTurret("dam_turret_mp", "mp_dam_large_caliber_turret", "tag_player_mp");
  Turrets = array_add(Turrets, turret);

  railgun_script_origin = GetEnt("railgun_attachpoint1", "targetname");
  turret = railgun_script_origin SpawnDamTurret("dam_turret_mp", "mp_dam_large_caliber_turret", "tag_player_mp");
  Turrets = array_add(Turrets, turret);

  level.DamTurrets = Turrets;
}

SpawnDamTurret(turretweaponinfo, modelname, linktotag) {
  spawned_turret = SpawnTurret("misc_turret", self.origin, turretweaponinfo, false);
  spawned_turret.attachpoint = self;
  spawned_turret.angles = flat_angle(self.angles);
  spawned_turret setModel(modelname);
  spawned_turret SetDefaultDropPitch(45.0);
  spawned_turret.health = 99999;
  spawned_turret.maxHealth = 1000;
  spawned_turret.damageTaken = 0;
  spawned_turret.stunned = false;
  spawned_turret.stunnedTime = 0.0;
  spawned_turret setCanDamage(false);
  spawned_turret setCanRadiusDamage(false);
  spawned_turret SetMode("manual");

  level.DamDefaultAimEnt = GetEnt("DamTurretDefaultTarget", "targetname");
  spawned_turret SetTargetEntity(level.DamDefaultAimEnt);

  return spawned_turret;
}

#using_animtree("animated_props");
setupCraneAnimations() {
  PrecacheMpAnim("dam_crane01_idle_l");
  PrecacheMpAnim("dam_crane01_idle_r");
  PrecacheMpAnim("dam_crane01_l_2_r");
  PrecacheMpAnim("dam_crane01_r_2_l");
  PrecacheMpAnim("dam_crane02_idle_l");
  PrecacheMpAnim("dam_crane02_idle_r");
  PrecacheMpAnim("dam_crane02_l_2_r");
  PrecacheMpAnim("dam_crane02_r_2_l");

  PrecacheMpAnim("dam_crane01_tag_idle_l");
  PrecacheMpAnim("dam_crane01_tag_idle_r");
  PrecacheMpAnim("dam_crane01_tag_l_2_r");
  PrecacheMpAnim("dam_crane01_tag_r_2_l");
  PrecacheMpAnim("dam_crane02_tag_idle_l");
  PrecacheMpAnim("dam_crane02_tag_idle_r");
  PrecacheMpAnim("dam_crane02_tag_l_2_r");
  PrecacheMpAnim("dam_crane02_tag_r_2_l");

  PrecacheMpAnim("dam_crane01_collisiontest");
}

CraneCollisionTest() {
  Crane2 = getent("Crane_02", "targetname");
  Crane2PipeCollision = getent("crane2PipeCollision", "targetname");
  Crane2PipeCollision linkto(Crane2, "j_tube_01_c");

  while(1) {
    Crane2 ScriptModelPlayAnimDeltaMotion("dam_crane01_collisiontest");
    wait 20;
  }
}

TempCraneIdleSetup() {
  Crane1 = getent("Crane_01", "targetname");
  Crane1PipeCollision = getent("crane1PipeCollision", "targetname");
  Crane1PipeCollision linkto(Crane1, "j_tube_01_c");

  Crane2 = getent("Crane_02", "targetname");
  Crane2PipeCollision = getent("crane2PipeCollision", "targetname");
  Crane2PipeCollision linkto(Crane2, "j_tube_01_c");

  Crane1 ScriptModelPlayAnimDeltaMotion("dam_crane02_idle_l");
  Crane2 ScriptModelPlayAnimDeltaMotion("dam_crane01_idle_l");
}

Crane1Movement() {
  Crane1Tag = GetEnt("Crane_01_TagProxy", "targetname");
  Crane1 = getent("Crane_01", "targetname");
  Crane1PipeCollision = getent("crane1PipeCollision", "targetname");
  Crane1PipeBcsTrigger = getent("crane_01_bcs_trigger", "targetname");

  Crane1TagBase = GetEnt("Crane_01_TagBaseProxy", "targetname");
  Crane1Collision = getent("crane1Collision", "targetname");

  Crane1PipeCollision LinkToSynchronizedParent(Crane1Tag, "tag_origin");
  Crane1PipeBcsTrigger handle_trigger_updateto(Crane1PipeCollision);

  Crane1Collision.angles = Crane1Collision.angles + (0, -249.215, 0);
  Crane1Collision LinkToSynchronizedParent(Crane1TagBase, "tag_origin");

  waittime = 20;
  crane1_aud_org = (2181, -1069, 1407);
  thread aud_play_crane_sfx(crane1_aud_org, waittime, "crane_01");

  while(1) {
    Crane1Tag ScriptModelClearAnim();
    Crane1Tag.origin = Crane1.origin;
    Crane1Tag.angles = Crane1.angles;

    Crane1TagBase ScriptModelClearAnim();

    Crane1 ScriptModelPlayAnimDeltaMotion("dam_crane01_l_2_r");
    Crane1Tag ScriptModelPlayAnimDeltaMotion("dam_crane01_tag_l_2_r");
    Crane1TagBase ScriptModelPlayAnimDeltaMotion("dam_crane01_tag_base_l_2_r");

    wait waittime;

    Crane1Tag ScriptModelClearAnim();
    Crane1Tag.origin = Crane1.origin;
    Crane1Tag.angles = Crane1.angles;

    Crane1TagBase ScriptModelClearAnim();

    Crane1 ScriptModelPlayAnimDeltaMotion("dam_crane01_r_2_l");
    Crane1Tag ScriptModelPlayAnimDeltaMotion("dam_crane01_tag_r_2_l");
    Crane1TagBase ScriptModelPlayAnimDeltaMotion("dam_crane01_tag_base_r_2_l");
    wait waittime;
  }
}

Crane2Movement() {
  Crane2Tag = GetEnt("Crane_02_TagProxy", "targetname");
  Crane2 = getent("Crane_02", "targetname");
  Crane2PipeCollision = getent("crane2PipeCollision", "targetname");
  Crane2PipeBcsTrigger = getent("crane_02_bcs_trigger", "targetname");

  Crane2TagBase = GetEnt("Crane_02_TagBaseProxy", "targetname");
  Crane2Collision = getent("crane2Collision", "targetname");

  waittime = 20;
  crane2_aud_org = (849, 2315, 1455);
  thread aud_play_crane_sfx(crane2_aud_org, waittime, "crane_02");

  Crane2PipeCollision LinkToSynchronizedParent(Crane2Tag, "tag_origin");
  Crane2PipeBcsTrigger handle_trigger_updateto(Crane2PipeCollision);

  Crane2Collision.angles = Crane2Collision.angles + (0, -117.312, 0);
  Crane2Collision LinkToSynchronizedParent(Crane2TagBase, "tag_origin");

  while(1) {
    Crane2Tag ScriptModelClearAnim();
    Crane2Tag.origin = Crane2.origin;
    Crane2Tag.angles = Crane2.angles;

    Crane2TagBase ScriptModelClearAnim();

    Crane2 ScriptModelPlayAnimDeltaMotion("dam_crane02_l_2_r");
    Crane2Tag ScriptModelPlayAnimDeltaMotion("dam_crane02_tag_l_2_r");
    Crane2TagBase ScriptModelPlayAnimDeltaMotion("dam_crane02_tag_base_l_2_r");
    wait waittime;

    Crane2Tag ScriptModelClearAnim();
    Crane2Tag.origin = Crane2.origin;
    Crane2Tag.angles = Crane2.angles;

    Crane2TagBase ScriptModelClearAnim();

    Crane2 ScriptModelPlayAnimDeltaMotion("dam_crane02_r_2_l");
    Crane2Tag ScriptModelPlayAnimDeltaMotion("dam_crane02_tag_r_2_l");
    Crane2TagBase ScriptModelPlayAnimDeltaMotion("dam_crane02_tag_base_r_2_l");
    wait waittime;
  }
}

handle_trigger_updateto(parent) {
  assertex(isDefined(parent), "must have a parent entity to know where the water trigger should be");

  level endon("game_ended");

  parent_offset = self.origin - parent.origin;
  parent_offset_angles = self.angles - parent.angles;
  self childthread MoveTrig(parent, parent_offset, parent_offset_angles);
}

MoveTrig(parent, offset, offset_angles) {
  while(true) {
    self.origin = (parent.origin + offset);
    self.angles = (parent.angles - offset_angles);
    wait(.05);
  }
}

aud_play_crane_sfx(org, waittime, crane_inst) {
  crane_motor_pos = org;
  crane_ent = spawn("script_origin", crane_motor_pos);
}

rotateGenerators() {
  fans = getEntArray("generator_fan", "targetname");

  foreach(fan in fans) {
    fan thread rotateFan();
  }
}

rotateFan() {
  if(!isDefined(level.genrotatespeed)) {
    level.genrotatespeed = -180;
  }

  previousgenrotatespeed = 0;
  while(1) {
    if(previousgenrotatespeed != level.genrotatespeed) {
      self RotateVelocity((0, level.genrotatespeed, 0), 3600);
      previousgenrotatespeed = level.genrotatespeed;
    }
    wait 0.5;
  }
}

rotateCrane() {
  level endon("game_ended");

  while(1) {
    self.cab RotateTo((0, GetDvarInt(self.end_angle_dvar, 180), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.platform RotateTo((0, GetDvarInt(self.end_angle_dvar, 180), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.pipe RotateTo((0, GetDvarInt(self.end_angle_dvar, 180), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.pulley RotateTo((0, GetDvarInt(self.end_angle_dvar, 180), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.hook RotateTo((0, GetDvarInt(self.end_angle_dvar, 180), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.heightOscillator MoveTo((0, 0, GetDvarInt(self.pipe_end_height_dvar, 0)), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.radiusOscillator MoveTo((0, 0, GetDvarInt(self.pipe_end_radius_dvar, 0)), GetDvarInt(self.time_dvar, 10), 1, 1);

    wait(GetDvarInt(self.time_dvar, 10) + 5);

    self.cab RotateTo((0, GetDvarInt(self.start_angle_dvar, 130), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.platform RotateTo((0, GetDvarInt(self.start_angle_dvar, 130), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.pipe RotateTo((0, GetDvarInt(self.start_angle_dvar, 130), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.pulley RotateTo((0, GetDvarInt(self.start_angle_dvar, 130), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.hook RotateTo((0, GetDvarInt(self.start_angle_dvar, 130), 0), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.heightOscillator MoveTo((0, 0, GetDvarInt(self.pipe_start_height_dvar, 0)), GetDvarInt(self.time_dvar, 10), 1, 1);

    self.radiusOscillator MoveTo((0, 0, GetDvarInt(self.pipe_start_radius_dvar, 0)), GetDvarInt(self.time_dvar, 10), 1, 1);

    wait(GetDvarInt(self.time_dvar, 10) + 5);
  }
}

moveCranePipe() {
  level endon("game_ended");

  while(1) {
    temp_origin_vec = (Cos(self.platform.angles[1] + 90) * self.radiusoscillator.origin[2] + self.cab.origin[0], Sin(self.platform.angles[1] + 90) * self.radiusoscillator.origin[2] + self.cab.origin[1], self.heightOscillator.origin[2]);

    self.pipe MoveTo(temp_origin_vec, 0.05, 0.025, 0.025);

    self.pulley MoveTo((temp_origin_vec[0], temp_origin_vec[1], self.pulley.origin[2]), 0.05, 0.025, 0.025);

    self.hook MoveTo(temp_origin_vec + (0, 0, 270), 0.05, 0.025, 0.025);

    wait(0.05);
  }
}

handlePowerSurge() {
  while(true) {
    wait(GetDvarInt("mp_dam_surge_interval", 50));

    foreach(sparktag in level.spark_origin_tags) {
      playFXOnTag(level.mp_dam_fx["dam_surge_sparks"], sparktag, "tag_origin");
    }
    foreach(pasystemtag in level.surge_vo_origin_tags) {
      pasystemtag thread play_sound_on_tag(level.pa_warning0, "tag_origin");
    }

    wait(GetDvarInt("mp_dam_surge_delay", 7));

    level.power_surge_active = true;

    level.genrotatespeed = level.genrotatespeed * 2;

    foreach(sparktag in level.spark_origin_tags) {
      playFXOnTag(level.mp_dam_fx["dam_surge_arcs"], sparktag, "tag_origin");
    }
    foreach(smoketag in level.smoke_origin_tags) {}
    foreach(sparksfxtag in level.elec_sparks_origin_tags) {
      sparksfxtag thread play_loop_sound_on_entity(level.surge_sparks_noise);
    }
    foreach(pasystemtag in level.surge_vo_origin_tags) {
      pasystemtag thread play_sound_on_tag(level.pa_warning1, "tag_origin");
    }

    wait(GetDvarInt("mp_dam_surge_duration", 30));

    level.power_surge_active = false;

    level.genrotatespeed = level.genrotatespeed / 2;

    foreach(sparktag in level.spark_origin_tags) {
      stopFXOnTag(level.mp_dam_fx["dam_surge_sparks"], sparktag, "tag_origin");
      stopFXOnTag(level.mp_dam_fx["dam_surge_arcs"], sparktag, "tag_origin");
    }
    foreach(smoketag in level.smoke_origin_tags) {}
    foreach(sparksfxtag in level.elec_sparks_origin_tags) {
      sparksfxtag thread stop_loop_sound_on_entity(level.surge_sparks_noise);
    }

    wait(0.05);
  }
}

handlePowerSurgeDamage() {
  while(true) {
    if(level.power_surge_active == true) {
      foreach(player in level.players) {
        foreach(trigmult in level.dam_surge_triggers) {
          if(player IsTouching(trigmult)) {
            player PlayRumbleOnEntity("damage_heavy");
            player shellshock("orbital_laser_mp", 1);
            player DoDamage(5, player.origin);
          }
        }
      }
    }
    wait(0.05);
  }
}

handle_glass_pathing() {
  skylights = GetGlassArray("skylights");
  skylight_ents = getEntArray("skylights", "targetname");
  pathnode_orgs = getEntArray("glass_pathing", "targetname");

  if(!isDefined(skylight_ents)) {
    return false;
  }

  threashold = 8;

  foreach(skylight in skylights) {
    origin = GetGlassOrigin(skylight);
    foreach(skylight_ent in skylight_ents) {
      if(distance(origin, skylight_ent.origin) <= threashold) {
        skylight_ent.glass_id = skylight;
        break;
      }
    }
  }

  array_thread(skylight_ents, ::handle_pathing_on_glass);
}

handle_pathing_on_glass() {
  level endon("game_ended");

  pathing_blocker = GetEnt(self.target, "targetname");
  if(!isDefined(pathing_blocker)) {
    return false;
  }

  pathing_blocker trigger_off();
  pathing_blocker ConnectPaths();

  waittill_glass_break(self.glass_id);

  pathing_blocker trigger_on();
  pathing_blocker DisconnectPaths();
  pathing_blocker trigger_off();
}

waittill_glass_break(skylight) {
  level endon("game_ended");

  while(true) {
    if(IsGlassDestroyed(skylight)) {
      return true;
    }
    wait(.05);
  }
}