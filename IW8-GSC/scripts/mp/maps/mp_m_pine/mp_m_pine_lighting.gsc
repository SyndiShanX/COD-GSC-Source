/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_pine\mp_m_pine_lighting.gsc
************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.2);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_spotDistCull", 500);
  setDvar("r_vertexDeformCutOffDist", 380);
  setDvar("r_vertexDeformFadeDist", 190);
}