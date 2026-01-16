/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\coup_art.gsc
***************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\coup_fog_hdr::main();
  else
    maps\createart\coup_fog::main();
}