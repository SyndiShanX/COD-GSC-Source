/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23133.gsc
**************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  maps/createart/hijack_fog::main();
}