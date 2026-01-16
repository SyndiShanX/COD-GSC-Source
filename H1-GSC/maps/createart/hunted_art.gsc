/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\hunted_art.gsc
*****************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\hunted_fog_hdr::main();
  else
    maps\createart\hunted_fog::main();
}