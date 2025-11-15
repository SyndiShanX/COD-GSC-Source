/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\jungle_ghosts_art.gsc
************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\jungle_ghosts_fog::main();
}