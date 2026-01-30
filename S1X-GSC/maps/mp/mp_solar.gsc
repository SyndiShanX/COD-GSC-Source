/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_solar.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;
#include maps\mp\_dynamic_events;

CONST_EVENT_START_DELAY = 5 * 60;
CONST_EVENT_PISTON_RAISE_TIME = 7;

main() {
  maps\mp\mp_solar_precache::main();
  maps\createart\mp_solar_art::main();
  maps\mp\mp_solar_fx::main();
  maps\mp\mp_solar_aud::main();
  maps\mp\mp_solar_lighting::main();

  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_solar");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.mapCustomKillstreakFunc = ::solarCustomKillstreakFunc;

  level thread setup_audio();

  level.orbitalSupportOverrideFunc = ::solarPaladinOverrides;

  level thread init_fans();

  level.ospvisionset = "mp_solar_osp";
  level.ospLightSet = "mp_solar_osp";

  level.warbirdVisionSet = "mp_solar_warbird";
  level.warbirdLightSet = "mp_solar_warbird";

  level.droneVisionSet = "mp_solar_drone";
  level.droneLightSet = "mp_solar_drone";

  if(level.nextgen) {
    SetDvar("sm_polygonOffsetPreset", 2);
  }

  maps\mp\_water::init();
}

solarCustomKillstreakFunc() {
  level thread maps\mp\killstreaks\streak_mp_solar::init();
}

setup_audio() {
  AmbientPlay("amb_mp_solar_ext");
}

solarPaladinOverrides() {
  level.orbitalsupportoverrides.spawnHeight = 9079;
}

init_fans() {
  fans = getEntArray("solar_fan", "targetname");
  array_thread(fans, ::run_fan);
}

run_fan() {
  spin_time = 30 * 60;
  degrees_per_second = RandomFloatRange(700, 750);
  while(1) {
    self RotateVelocity((degrees_per_second, 0, 0), spin_time);
    wait spin_time;
  }
}