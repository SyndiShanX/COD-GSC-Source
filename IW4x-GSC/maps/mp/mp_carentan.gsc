/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_carentan.gsc
**************************************/

main() {
  maps\mp\mp_carentan_fx::main();
  maps\createart\mp_carentan_art::main();





  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_carentan");


  level.airstrikeHeightScale = 1.4;

  setExpFog(500, 3500, .4, 0.4, 0.35, 0.4, 0);
  ambientPlay("ambient_carentan_ext0");

  game["attackers"] = "axis";
  game["defenders"] = "allies";
}