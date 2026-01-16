/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_farm_spring_art.gsc
*************************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_farm_spring_fog_hdr::setupfog();
  else
    maps\createart\mp_farm_spring_fog::setupfog();

  visionsetnaked("mp_farm_spring", 0);
}