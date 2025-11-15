/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createfx\cargoship_audio.gsc
*********************************************/

main() {
  thread init_animsounds();
}

init_animsounds() {
  waittillframeend;
  maps\_anim::addonstart_animsound("end_hands", "player_rescue", "cargoship_jumpforheli");
}