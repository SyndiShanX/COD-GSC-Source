/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\sniperescape_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\sniperescape_fog_hdr::main();
  else
    maps\createart\sniperescape_fog::main();
}