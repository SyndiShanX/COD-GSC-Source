/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_bog_art.gsc
*****************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_bog_fog_hdr::setupfog();
  else
    maps\createart\mp_bog_fog::setupfog();

  visionsetnaked("mp_bog", 0);
}