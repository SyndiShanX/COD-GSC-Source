/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_creek_art.gsc
*******************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_creek_fog_hdr::main();
  else
    maps\createart\mp_creek_fog::main();

  visionsetnaked("mp_creek", 0);
}