/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\killhouse_art.gsc
********************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\killhouse_fog_hdr::main();
  else
    maps\createart\killhouse_fog::main();
}