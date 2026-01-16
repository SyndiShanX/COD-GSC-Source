/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_citystreets_art.gsc
*************************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_citystreets_fog_hdr::setupfog();
  else
    maps\createart\mp_citystreets_fog::setupfog();

  visionsetnaked("mp_citystreets", 0);
}