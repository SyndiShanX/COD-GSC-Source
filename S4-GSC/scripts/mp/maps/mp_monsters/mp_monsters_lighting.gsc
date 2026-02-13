/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_monsters\mp_monsters_lighting.gsc
****************************************************************/

main() {
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.45);
  setDvar("sm_suncascadesizemultiplier1", 2);
  setDvar("sm_suncascadesizemultiplier2", 3);
  level._id_45CE = "mp_monsters";
  level._id_10E5E = "mp_monsters_winner";
  level._id_59D6 = "mp_monsters_winner";
  level.infilvisionset = "mp_monsters_infil";
}