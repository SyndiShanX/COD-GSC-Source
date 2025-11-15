/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\homecoming_art.gsc
*********************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\homecoming_fog::main();
}