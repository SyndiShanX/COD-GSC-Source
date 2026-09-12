/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_killhouse\mp_killhouse_lighting.gsc
******************************************************************/

function main() {
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("r_tonemapFocus", 0);
  setDvar("r_compressedSunShadowClipPlanes", 1);
  setDvar("sm_sunDistantShadows", 1);
  setDvar("sm_sunSampleSizeNear", 0.2);
  setDvar("sm_sunCascadeSizeMultiplier1", 1);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotDistCull", 1200);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
}