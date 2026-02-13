/************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_ftue\mp_m_ftue_lighting.gsc
************************************************************/

main() {
  thread refresh_shadow_cache();
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
}