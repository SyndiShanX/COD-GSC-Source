/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\8243.gsc
**************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\so_survival_mp_paris_fog::main();
}