/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_zombie_ark_art.gsc
************************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr()) {
    maps\createart\mp_zombie_ark_fog_hdr::setupfog();
  } else {
    maps\createart\mp_zombie_ark_fog::setupfog();
  }

  visionsetnaked("mp_zombie_ark", 0);
}