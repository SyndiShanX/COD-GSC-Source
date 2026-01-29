/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\so_survival_mp_terminal_cls_art.gsc
**********************************************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps\createart\so_survival_mp_terminal_cls_fog::main();
}