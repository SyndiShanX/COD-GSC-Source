/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_harbor\mp_harbor_lighting.gsc
************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.33);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_cachedSunShadowLODBias", 0.4);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotDistCull", 500);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 1);
  setDvar("r_compressedSunShadowClipPlanes", 1);
}