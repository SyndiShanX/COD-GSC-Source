/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\766.gsc
**************************************/

main() {
  thread precache_createfx_fx();
}

precache_createfx_fx() {
  level._effect["conference_room_breach_specops_slow"] = loadfx("maps/hijack/conference_room_breach_specops_no_slowmo");
}