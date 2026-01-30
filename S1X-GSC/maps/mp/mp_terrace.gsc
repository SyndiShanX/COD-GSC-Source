/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_terrace.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_dynamic_events;

main() {
  maps\mp\mp_terrace_precache::main();
  maps\createart\mp_terrace_art::main();
  maps\mp\mp_terrace_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_terrace_lighting::main();
  maps\mp\mp_terrace_aud::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_terrace");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.allow_swimming = false;

  level thread maps\mp\_water::init();

  level.aerial_pathnode_group_connect_dist = 400;

  level.mapCustomKillstreakFunc = ::terraceCustomKillstreakFunc;

  level thread init_turbines();
  level thread init_blimps();
  level thread init_bells();

  level.orbitalSupportOverrideFunc = ::terraceCustomOSPFunc;

  level.ospvisionset = "mp_terrace_osp";
  level.osplightset = "mp_terrace_osp";
  level.droneVisionSet = "mp_terrace_drone";
  level.droneLightSet = "mp_terrace_drone";
  level.warbirdVisionSet = "mp_terrace_warbird";
  level.warbirdLightSet = "mp_terrace_warbird";
}

terraceCustomOSPFunc() {
  level.orbitalsupportoverrides.spawnAngleMin = 180;
  level.orbitalsupportoverrides.spawnAngleMax = 270;

  if(level.currentgen) {
    level.orbitalsupportoverrides.leftArc = 17.5;
    level.orbitalsupportoverrides.rightArc = 17.5;
    level.orbitalsupportoverrides.topArc = -35;
    level.orbitalsupportoverrides.bottomArc = 60;
  }
}

terraceCustomKillstreakFunc() {
  level thread maps\mp\killstreaks\streak_mp_terrace::init();
}

init_turbines() {
  turbines = getEntArray("turbine_blades", "targetname");
  array_thread(turbines, ::turbine_spin);
}

turbine_spin() {
  spin_time = 30 * 60;
  degrees_per_second = RandomFloatRange(30, 60);
  while(1) {
    self RotateVelocity((0, degrees_per_second, 0), spin_time);
    wait spin_time;
  }
}

init_blimps() {
  blimps = getEntArray("blimp", "targetname");
  array_thread(blimps, ::blimp_run);
}

blimp_run() {
  move_time = 10 * 60;

  next = self;

  while(isDefined(next.target)) {
    next = getstruct(next.target, "targetname");
    if(!isDefined(next)) {
      return;
    }

    self MoveTo(next.origin, move_time, move_time * 0.1, move_time * 0.1);
    self RotateTo(next.angles, move_time, move_time * 0.1, move_time * 0.1);
    wait move_time;
  }
}

init_bells() {
  bells = getEntArray("bell_collision", "targetname");
  array_thread(bells, ::bell_run);
}

bell_run() {
  self setCanDamage(true);
  self Ghost();
  while(1) {
    self.health = 1000;
    self waittill("damage");

    self playSound("physics_bell_default");
  }
}