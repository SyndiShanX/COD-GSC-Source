/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_bog_summer_art.gsc
************************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_bog_summer_fog_hdr::setupfog();
  else
    maps\createart\mp_bog_summer_fog::setupfog();

  visionsetnaked("mp_bog_summer", 0);
}