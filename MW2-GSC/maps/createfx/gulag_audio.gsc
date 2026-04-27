/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createfx\gulag_audio.gsc
********************************************************/

#include maps\_anim;

main() {
  thread init_animsounds();
}

init_animsounds() {
  waittillframeend;
  addNotetrack_animSound("playerview", "crash", "sfx", "scn_suv_crash");
}