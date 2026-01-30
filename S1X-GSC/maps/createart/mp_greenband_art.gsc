/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_greenband_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_greenband_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_greenband_fog::SetupFog();
  }
  VisionSetNaked("mp_greenband", 0);
}