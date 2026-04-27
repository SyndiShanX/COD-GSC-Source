/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createfx\oilrig_audio.gsc
********************************************************/

#include maps\_anim;

main() {
  thread init_animsounds();
}

init_animsounds() {
  waittillframeend;
  addOnStart_animSound("sdv02_pilot", "stealth_kill", "scn_oilrig_npc_waterkill");
  addOnStart_animSound("player_rig", "player_stealth_kill", "scn_oilrig_plr_waterkill");
}