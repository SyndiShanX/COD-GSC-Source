/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_landlord_2\cp_landlord_2_lighting.gsc
********************************************************************/

function main() {
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("r_compressedSunShadowClipPlanes", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.35);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_spotDistCull", 1000);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
}