/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_crossfire_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\mp_crossfire_fog_hdr::main();
  else
    maps\createart\mp_crossfire_fog::main();
}