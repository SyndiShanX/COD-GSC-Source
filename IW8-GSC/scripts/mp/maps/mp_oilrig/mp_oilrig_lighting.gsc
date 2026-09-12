/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_oilrig\mp_oilrig_lighting.gsc
************************************************************/

function main() {
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 10);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("r_compressedSunShadowClipPlanes", 1);
  setDvar("sm_sunSampleSizeNear", 0.2);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
}