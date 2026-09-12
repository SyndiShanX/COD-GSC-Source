/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_malyshev\mp_malyshev_lighting.gsc
****************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.31);
  setDvar("sm_sunCascadeSizeMultiplier1", 3);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotDistCull", 500);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 6);
}