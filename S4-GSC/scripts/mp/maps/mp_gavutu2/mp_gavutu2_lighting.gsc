/**************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_gavutu2\mp_gavutu2_lighting.gsc
**************************************************************/

main() {
  level._id_45CE = "mp_gavutu2";
  level._id_59D6 = "mp_gavutu_POTG";
  level._id_10E5E = "mp_gavutu_winner";
  level._id_84D1 = "mp_gavutu_intro";
  level.sunvfx = "vfx_mp_gavutu_sunflare";
  thread refresh_shadow_cache();
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
  setDvar("#x35b675136cc3e593d", 64);
}