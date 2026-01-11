/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\icbm_art.gsc
***************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];

  if(isusinghdr()) {
    maps\createart\icbm_fog_hdr::main();
  }
  else {
    maps\createart\icbm_fog::main();
  }
}