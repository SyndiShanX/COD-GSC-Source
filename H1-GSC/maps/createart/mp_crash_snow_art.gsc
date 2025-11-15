/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_crash_snow_art.gsc
************************************************/

main() {
  level.tweakfile = 1;
  maps\createart\mp_crash_snow_fog_hdr::setupfog();
  visionsetnaked("mp_crash_snow", 0);
}