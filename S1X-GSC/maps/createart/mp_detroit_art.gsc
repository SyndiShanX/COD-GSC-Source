/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_detroit_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_detroit_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_detroit_fog::SetupFog();
  }
  VisionSetNaked("mp_detroit", 0);
}