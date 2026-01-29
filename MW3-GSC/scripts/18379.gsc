/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18379.gsc
**************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\so_survival_mp_dome_fog::main();
}