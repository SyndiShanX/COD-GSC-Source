/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_village2\mp_village2_lighting.gsc
****************************************************************/

function main() {
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.32);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("sm_roundRobinPrioritySpotShadows", 10);
  setDvar("sm_spotDistCull", 1000);
}