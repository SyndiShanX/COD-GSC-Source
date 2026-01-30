/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_prison_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_prison_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_prison_fog::SetupFog();
  }
  VisionSetNaked("mp_prison", 0);
}