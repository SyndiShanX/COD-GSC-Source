/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\ship_graveyard_art.gsc
*************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\ship_graveyard_fog::main();
}