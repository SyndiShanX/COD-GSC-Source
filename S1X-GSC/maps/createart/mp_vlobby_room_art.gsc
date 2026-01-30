/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\createart\mp_vlobby_room_art.gsc
***************************************************/

main() {
  level.tweakfile = true;

  if(IsUsingHDR()) {
    maps\createart\mp_vlobby_room_fog_hdr::SetupFog();
  } else {
    maps\createart\mp_vlobby_room_fog::SetupFog();
  }
  VisionSetNaked("mp_vlobby_room", 0);
}