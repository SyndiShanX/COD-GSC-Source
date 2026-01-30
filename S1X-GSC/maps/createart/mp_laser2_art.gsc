/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_laser2_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_laser2_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_laser2_fog::SetupFog();
  }
  VisionSetNaked("mp_laser2", 0);
}