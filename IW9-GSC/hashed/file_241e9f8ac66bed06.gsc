/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_241e9f8ac66bed06.gsc
***********************************************/

main() {
  thread lighting_setup_dvars();
}

lighting_setup_dvars() {
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("sm_sunCascadeSizeMultiplier1", 1);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_sunDistantShadows", 1);
  setDvar("r_screenspaceshadowssunsceneenabled", 1);
  setDvar("sm_spotDistCull", 1000);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
}