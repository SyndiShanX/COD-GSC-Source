/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\launchfacility_b_art.gsc
***************************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\launchfacility_b_fog_hdr::main();
  else
    maps\createart\launchfacility_b_fog::main();
}