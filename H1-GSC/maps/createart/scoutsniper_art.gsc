/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\scoutsniper_art.gsc
**********************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\scoutsniper_fog_hdr::main();
  else
    maps\createart\scoutsniper_fog::main();
}