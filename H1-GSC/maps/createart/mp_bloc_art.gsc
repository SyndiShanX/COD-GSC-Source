/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_bloc_art.gsc
******************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_bloc_fog_hdr::setupfog();
  else
    maps\createart\mp_bloc_fog::setupfog();

  visionsetnaked("mp_bloc", 0);
}