/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_recovery_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_recovery_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_recovery_fog::SetupFog();
  }
  VisionSetNaked("mp_recovery", 0);
}