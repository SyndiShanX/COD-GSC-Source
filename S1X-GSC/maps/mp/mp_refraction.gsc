/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_refraction.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_audio;
#include maps\mp\_dynamic_events;

main() {
  maps\mp\mp_refraction_precache::main();
  maps\createart\mp_refraction_art::main();
  maps\mp\mp_refraction_lighting::main();
  maps\mp\mp_refraction_fx::main();

  level.aerial_pathnode_offset = 600;
  level.aerial_pathnode_group_connect_dist = 300;

  level.ospvisionset = "mp_refraction_osp";
  level.osplightset = "mp_refraction_osp";
  level.warbirdvisionset = "mp_refraction_osp";
  level.warbirdlightset = "mp_refraction_osp";
  level.vulcanvisionset = "mp_refraction_osp";
  level.vulcanlightset = "mp_refraction_osp";

  maps\mp\_load::main();
  level.alarmfx = loadfx("vfx/lights/light_red_pulse_fast");
  level.rain = loadfx("vfx/rain/rain_volume_windy");
  level thread common_scripts\_exploder::activate_clientside_exploder(10);

  maps\mp\_water::init();

  maps\mp\_compass::setupMiniMap("compass_map_mp_refraction");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  thread set_lighting_values();

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.mapCustomKillstreakFunc = ::refractionCustomKillstreakFunc;

  level.orbitalSupportOverrideFunc = ::refractionCustomOSPFunc;

  level.remote_missile_height_override = 16000;

  level.orbitalLaserOverrideFunc = ::refractionVulcanCustomFunc;

  array_thread(getEntArray("com_radar_dish", "targetname"), ::radar_dish_rotate);
}

refractionCustomKillstreakFunc() {
  level.killstreakWeildWeapons["refraction_turret_mp"] = true;

  level thread maps\mp\killstreaks\streak_mp_refraction::init();
}

refractionCustomOSPFunc() {
  level.orbitalsupportoverrides.spawnAngleMin = 260;
  level.orbitalsupportoverrides.spawnAngleMax = 350;
  level.orbitalsupportoverrides.turretPitch = 50;
  level.orbitalsupportoverrides.topArc = -38;
  level.orbitalsupportoverrides.spawnHeight = 10426;
}

refractionVulcanCustomFunc() {
  level.orbitallaseroverrides.spawnPoint = (20, -500, 0);
}

radar_dish_rotate() {
  speed = 0;
  time = 40000;

  speed_multiplier = 1.0;
  if(isDefined(self.speed)) {
    speed_multiplier = self.speed;
  }

  speed = 70;

  if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "lockedspeed")) {
    wait 0;
  } else {
    wait randomfloatrange(0, 1);
  }

  while(true) {
    self rotatevelocity((0, speed, 0), time);
    wait time;
  }
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1"
      );
    }
  }
}