/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\aftermath_art.gsc
********************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\aftermath_fog_hdr::main();
  else
    maps\createart\aftermath_fog::main();
}