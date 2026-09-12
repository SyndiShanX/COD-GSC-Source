/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_quarry2\mp_quarry2_lighting.gsc
**************************************************************/

function main() {
  level.tweakfile = 1;
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("r_compressedSunShadowClipPlanes", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.35);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotDistCull", 1000);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
}