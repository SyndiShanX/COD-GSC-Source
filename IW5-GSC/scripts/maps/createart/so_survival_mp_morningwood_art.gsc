/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\so_survival_mp_morningwood_art.gsc
*********************************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\so_survival_mp_morningwood_fog::main();
}