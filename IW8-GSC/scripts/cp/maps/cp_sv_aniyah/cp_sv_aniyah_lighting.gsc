/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_aniyah\cp_sv_aniyah_lighting.gsc
******************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.3);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_spotDistCull", 500);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("r_compressedSunShadowFiltering", 0);
  setsaveddvar("sm_spotUpdateLimit", 8);
}