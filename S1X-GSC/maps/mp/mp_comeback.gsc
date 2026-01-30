/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_comeback.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_comeback_precache::main();
  maps\createart\mp_comeback_art::main();
  maps\mp\mp_comeback_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_comeback_lighting::main();
  maps\mp\mp_comeback_aud::main();

  level.aerial_pathnode_offset = 600;
  level.aerial_pathnode_group_connect_dist = 275;

  maps\mp\_compass::setupMiniMap("compass_map_mp_comeback");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.mapCustomKillstreakFunc = ::comebackCustomKillstreakFunc;

  level.orbitalSupportOverrideFunc = ::comebackCustomOSPFunc;

  level thread init_ceiling_fans();
  level thread init_traffic();

  level.ospvisionset = "mp_comeback_osp";
  level.osplightset = "mp_comeback_osp";
  level.droneVisionSet = "mp_comeback_drone";
  level.droneLightSet = "mp_comeback_drone";
  level.warbirdVisionSet = "mp_comeback_warbird";
  level.warbirdLightSet = "mp_comeback_warbird";

  level.goliath_bad_landing_volumes = getEntArray("goliath_bad_landing_volume", "targetname");
}

comebackCustomKillstreakFunc() {
  level thread maps\mp\killstreaks\streak_mp_comeback::init();
}

comebackCustomOSPFunc() {
  if(level.currentgen) {
    level.orbitalsupportoverrides.spawnAngleMin = 30;
    level.orbitalsupportoverrides.spawnAngleMax = 90;
    level.orbitalsupportoverrides.spawnHeight = 9541;

    level.orbitalsupportoverrides.leftArc = 15;
    level.orbitalsupportoverrides.rightArc = 15;
    level.orbitalsupportoverrides.topArc = -40;
    level.orbitalsupportoverrides.bottomArc = 60;
  }
}

init_ceiling_fans() {
  ceiling_fans = getEntArray("ceiling_fan", "targetname");
  array_thread(ceiling_fans, ::ceiling_fan);
}

ceiling_fan() {
  spin_time = 30 * 60;
  degrees_per_second = RandomFloatRange(700, 750);
  while(1) {
    self RotateVelocity((0, degrees_per_second, 0), spin_time);
    wait spin_time;
  }
}

init_traffic() {
  anims = [];
  for(i = 1; i <= 7; i++) {
    trafficAnim = "mp_comeback_vista_cars_0" + i;
    PrecacheMpAnim(trafficAnim);
    anims[anims.size] = trafficAnim;
  }

  cars = getEntArray("traffic", "targetname");
  for(i = 0; i < cars.size && anims.size; i++) {
    cars[i] thread run_traffic(anims[i]);
  }
}

run_traffic(trafficAnim) {
  self ScriptModelPlayAnimDeltaMotionFromPos(trafficAnim, (0, 0, 0), (0, 0, 0));
}