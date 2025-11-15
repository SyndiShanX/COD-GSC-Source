/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\enemyhq_art.gsc
******************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\enemyhq_fog::main();
}