/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\deer_hunt_art.gsc
********************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\deer_hunt_fog::main();
}