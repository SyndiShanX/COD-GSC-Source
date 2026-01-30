/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_levity_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_levity_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_levity_fog::SetupFog();
  }
  VisionSetNaked("mp_levity", 0);
}