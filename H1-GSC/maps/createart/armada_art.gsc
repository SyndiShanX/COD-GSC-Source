/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\armada_art.gsc
*****************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\armada_fog_hdr::main();
  else
    maps\createart\armada_fog::main();
}