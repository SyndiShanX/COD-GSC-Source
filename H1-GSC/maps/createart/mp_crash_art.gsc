/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_crash_art.gsc
*******************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_crash_fog_hdr::setupfog();
  else
    maps\createart\mp_crash_fog::setupfog();

  visionsetnaked("mp_crash", 0);
}