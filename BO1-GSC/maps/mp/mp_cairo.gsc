/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_cairo.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_cairo_fx::main();
  precachemodel("collision_geo_10x10x512");
  precachemodel("collision_wall_128x128x10");
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_cairo_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_cairo");
  }
  maps\mp\mp_cairo_amb::main();
  maps\mp\gametypes\_teamset_cubans::level_init();
  spawncollision("collision_geo_10x10x512", "collider", (2264, -240, -61), (0, 0, 0));
  spawncollision("collision_geo_10x10x512", "collider", (-1437, -529, -61), (0, 0, 0));
  spawncollision("collision_wall_128x128x10", "collider", (716, 1181, 219), (0, 270, 0));
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
}