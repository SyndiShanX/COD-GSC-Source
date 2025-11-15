/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\loki_art.gsc
***************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\loki_fog::main();
}