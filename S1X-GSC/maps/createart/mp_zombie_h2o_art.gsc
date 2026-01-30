/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_zombie_h2o_art.gsc
************************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr()) {
    maps\createart\mp_zombie_h2o_fog_hdr::setupfog();
  } else {
    maps\createart\mp_zombie_h2o_fog::setupfog();
  }

  visionsetnaked("mp_zombie_h2o", 0);
}