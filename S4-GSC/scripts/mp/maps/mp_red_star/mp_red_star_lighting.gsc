/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_red_star\mp_red_star_lighting.gsc
****************************************************************/

main() {
  level._id_45CE = "mp_red_star";
  level._id_59D6 = "mp_red_star_winner";
  level._id_10E5E = "mp_red_star_winner";
  level.infilvisionset = "mp_red_star_winner";
  level.sunvfx = "vfx_mp_red_star_sunflare";
  thread refresh_shadow_cache();
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
}