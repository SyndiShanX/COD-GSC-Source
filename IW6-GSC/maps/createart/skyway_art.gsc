/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\skyway_art.gsc
*****************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\skyway_fog::main();
}