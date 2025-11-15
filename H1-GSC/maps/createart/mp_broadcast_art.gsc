/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_broadcast_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_broadcast_fog_hdr::setupfog();

  visionsetnaked("mp_broadcast", 0);
}