/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\jeepride_art.gsc
*******************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\jeepride_fog_hdr::main();
  else
    maps\createart\jeepride_fog::main();
}