/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\airlift_art.gsc
******************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\airlift_fog_hdr::main();
  else
    maps\createart\airlift_fog::main();
}