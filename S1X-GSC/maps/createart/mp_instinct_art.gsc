/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_instinct_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_instinct_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_instinct_fog::SetupFog();
  }
  VisionSetNaked("mp_instinct", 0);
}