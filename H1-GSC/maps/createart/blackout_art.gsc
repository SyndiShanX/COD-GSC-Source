/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\blackout_art.gsc
*******************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\blackout_fog_hdr::main();
  else
    maps\createart\blackout_fog::main();
}