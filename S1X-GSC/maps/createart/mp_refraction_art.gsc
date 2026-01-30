/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_refraction_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_refraction_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_refraction_fog::SetupFog();
  }
  VisionSetNaked("mp_refraction", 0);
}