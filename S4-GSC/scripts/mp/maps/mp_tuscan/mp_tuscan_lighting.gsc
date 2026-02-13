/************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_tuscan\mp_tuscan_lighting.gsc
************************************************************/

main() {
  level._id_45CE = "mp_tuscan";
  level._id_59D6 = "mp_tuscan_winner";
  level._id_10E5E = "mp_tuscan_winner";
  level._id_84D1 = "mp_tuscan";
  level.infilvisionset = "mp_tuscan_winner";
  thread refresh_shadow_cache();
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
}