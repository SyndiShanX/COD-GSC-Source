/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hideout\mp_hideout_lighting.gsc
**************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.43);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotDistCull", 600);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
}