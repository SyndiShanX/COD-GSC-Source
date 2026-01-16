/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_overgrown_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_overgrown_fog_hdr::main();
  else
    maps\createart\mp_overgrown_fog::main();

  visionsetnaked("mp_overgrown", 0);
}