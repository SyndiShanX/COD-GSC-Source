/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_killhouse_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_killhouse_fog_hdr::main();
  else
    maps\createart\mp_killhouse_fog::main();

  visionsetnaked("mp_killhouse", 0);
}