/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_king\mp_m_king_lighting.gsc
************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_sunStageBounds", 0);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("r_sunIntensityHeatOverride", 0.01);
}