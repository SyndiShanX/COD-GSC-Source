/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_vacant_art.gsc
********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_vacant_fog_hdr::setupfog();
  else
    maps\createart\mp_vacant_fog::setupfog();

  visionsetnaked("mp_vacant", 0);
}