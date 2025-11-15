/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\oilrocks_art.gsc
*******************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\oilrocks_fog::main();
}