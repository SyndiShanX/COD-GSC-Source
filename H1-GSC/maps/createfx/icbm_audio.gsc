/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createfx\icbm_audio.gsc
****************************************/

main() {
  thread init_animsounds();
}

init_animsounds() {
  waittillframeend;
  maps\_anim::addonstart_animsound("tower", "explosion", "scn_icbm_tower_exp_sweet");
}