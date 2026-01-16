/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_countdown_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_countdown_fog_hdr::setupfog();
  else
    maps\createart\mp_countdown_fog::setupfog();

  visionsetnaked("mp_countdown", 0);
}