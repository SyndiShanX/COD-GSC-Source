/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_crisis.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_crisis_fx::main();
  precachemodel("collision_geo_128x128x10");
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_crisis_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_crisis");
  }
  maps\mp\gametypes\_teamset_cubans::level_init();
  spawncollision("collision_geo_128x128x10", "collider", (2891, 1282.5, 72.5), (3.6, 36.48, -1.65));
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}