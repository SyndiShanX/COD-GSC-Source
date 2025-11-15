/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createfx\armada_audio.gsc
******************************************/

main() {
  thread init_animsounds();
}

init_animsounds() {
  waittillframeend;
  maps\_anim::addonstart_animsound("razorwire_guy", "razor_setup", "armada_wire_drag");
}