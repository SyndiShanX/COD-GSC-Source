/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_rust\mp_rust_lighting.gsc
********************************************************/

function main() {
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.3);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_spotDistCull", 500);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 6);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 1);
}