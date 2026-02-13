/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_growhouse\mp_growhouse_lighting.gsc
******************************************************************/

main() {
  level._id_45CE = "mp_growhouse";
  level._id_59D6 = "mp_growhouse_infil";
  level._id_10E5E = "mp_growhouse_infil";
  level._id_84D1 = "mp_growhouse";
  level.infilvisionset = "mp_growhouse_infil";
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.45);
  setDvar("sm_suncascadesizemultiplier1", 2);
  setDvar("sm_suncascadesizemultiplier2", 3);
}