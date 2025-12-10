/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_killhouse.gsc
**************************************/

main() {
  maps\createart\mp_killhouse_art::main();

  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_killhouse");

  ambientPlay("ambient_scoutsniper_ext0");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setdvar("compassmaxrange", "2200");
  setdvar("r_specularcolorscale", "1");
  setdvar("sm_sunSampleSizeNear", "0.35");
}