/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_elalamein\mp_elalamein_lighting.gsc
******************************************************************/

main() {
  thread refresh_shadow_cache();
  level._id_45CE = "mp_elalamein";
  level._id_59D6 = "mp_elalamein_winner";
  level._id_10E5E = "mp_elalamein_winner";
  level._id_84D1 = "mp_elalamein";
  level.infilvisionset = "mp_elalamein_winner";
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
}