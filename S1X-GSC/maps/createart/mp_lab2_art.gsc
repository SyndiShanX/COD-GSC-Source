/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_lab2_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_lab2_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_lab2_fog::SetupFog();
  }
  VisionSetNaked("mp_lab2", 0);
}