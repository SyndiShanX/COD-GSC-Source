/**************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_castle2\mp_castle2_lighting.gsc
**************************************************************/

main() {
  setDvar("#x34136b9e1fe3da988", 1);
  level._id_45CE = "mp_castle2";
  level._id_59D6 = "mp_castle2_POTG";
  level._id_10E5E = "mp_castle2_winner";
  level._id_84D1 = "mp_castle2_intro";
  level.infilvisionset = "mp_castle2_infil";
  thread refresh_shadow_cache();
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
}