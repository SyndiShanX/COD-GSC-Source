/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\ac130_art.gsc
****************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\ac130_fog_hdr::main();
  else
    maps\createart\ac130_fog::main();
}