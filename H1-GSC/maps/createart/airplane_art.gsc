/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\airplane_art.gsc
*******************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\airplane_fog_hdr::main();
  else
    maps\createart\airplane_fog::main();
}