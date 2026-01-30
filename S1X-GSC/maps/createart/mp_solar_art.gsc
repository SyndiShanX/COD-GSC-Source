/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_solar_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_solar_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_solar_fog::SetupFog();
  }
  VisionSetNaked("mp_solar", 0);
}