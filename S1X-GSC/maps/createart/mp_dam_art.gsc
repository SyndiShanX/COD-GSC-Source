/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_dam_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_dam_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_dam_fog::SetupFog();
  }
  VisionSetNaked("mp_dam", 0);
}