/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_detroit.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_audio;

main() {
  maps\mp\mp_detroit_precache::main();
  maps\createart\mp_detroit_art::main();
  maps\mp\mp_detroit_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_detroit_lighting::main();
  maps\mp\mp_detroit_aud::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_detroit");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  maps\mp\_water::SetShallowWaterWeapon("iw5_underwater_mp");
  maps\mp\_water::init();

  level.ospvisionset = "(mp_detroit_osp)";
  level.osplightset = "(mp_detroit_osp)";
  level.droneVisionSet = "(mp_detroit_drone)";
  level.droneLightSet = "(mp_detroit_drone)";
  level.warbirdVisionSet = "(mp_detroit_warbird)";
  level.warbirdLightSet = "(mp_detroit_warbird)";

  level.aerial_pathnode_offset = 425;
  level thread maps\mp\mp_detroit_events::trams();

  level.mapCustomKillstreakFunc = ::detroitCustomKillstreakFunc;
  level.orbitalSupportOverrideFunc = ::detroitPaladinOverrides;

  level thread detroitStrikeHeightOverrides();

  thread set_lighting_values();
}
detroitStrikeHeightOverrides() {
  if(!isDefined(level.airstrikeoverrides)) {
    level.airstrikeoverrides = spawnStruct();
  }
  level.airstrikeoverrides.spawnHeight = 2500;
}
detroitPaladinOverrides() {
  level.orbitalsupportoverrides.spawnAngleMin = 220;
  level.orbitalsupportoverrides.spawnAngleMax = 260;

  if(level.currentgen) {
    level.orbitalsupportoverrides.leftArc = 15;
    level.orbitalsupportoverrides.rightArc = 15;
    level.orbitalsupportoverrides.topArc = -35;
    level.orbitalsupportoverrides.bottomArc = 55;
  }
}
detroitCustomKillstreakFunc() {
  level thread maps\mp\killstreaks\streak_mp_detroit::init();
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0"
      );
    }
  }
}