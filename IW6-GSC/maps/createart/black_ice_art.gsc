/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\black_ice_art.gsc
********************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\black_ice_fog::main();
}