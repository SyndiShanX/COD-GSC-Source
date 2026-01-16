/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\ambush_art.gsc
*****************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\ambush_fog_hdr::main();
  else
    maps\createart\ambush_fog::main();
}