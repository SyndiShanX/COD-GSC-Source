/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_venus.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_audio;

main() {
  maps\mp\mp_venus_precache::main();
  maps\createart\mp_venus_art::main();
  maps\mp\mp_venus_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_venus_lighting::main();
  maps\mp\mp_venus_aud::main();

  level.aerial_pathnode_offset = 600;
  level.aerial_pathnode_group_connect_dist = 300;
  level.aerial_pathnodes_force_connect[0] = spawnStruct();
  level.aerial_pathnodes_force_connect[0].origin = (-618, -1166, 1123);
  level.aerial_pathnodes_force_connect[0].radius = 250;
  level.aerial_pathnodes_force_connect[1] = spawnStruct();
  level.aerial_pathnodes_force_connect[1].origin = (-944, 845, 1245);
  level.aerial_pathnodes_force_connect[1].radius = 300;

  maps\mp\_compass::setupMiniMap("compass_map_mp_venus");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  maps\mp\_water::init();

  level.ospvisionset = "mp_venus_osp";
  level.warbirdvisionset = "mp_venus_osp";
  level.vulcanvisionset = "mp_venus_osp";

  pool_nodes = GetNodeArray("pool_nodes", "targetname");
  foreach(node in pool_nodes) {
    NodeSetNotUsable(node, true);
  }

  level.orbitalSupportOverrideFunc = ::venusCustomOSPFunc;

  thread handle_glass_pathing();

  level.goliath_bad_landing_volumes = getEntArray("goliath_bad_landing_volume", "targetname");
}

venusCustomOSPFunc() {
  level.orbitalsupportoverrides.topArc = -39;
  level.orbitalsupportoverrides.spawnHeight = 9563.06;

  if(level.currentgen) {
    level.orbitalsupportoverrides.leftArc = 20;
    level.orbitalsupportoverrides.rightArc = 20;
    level.orbitalsupportoverrides.topArc = -35;
    level.orbitalsupportoverrides.bottomArc = 60;
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