/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\las_vegas_art.gsc
********************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\las_vegas_fog::main();
}