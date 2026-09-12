/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_wallco2\mp_m_wallco2_lighting.gsc
******************************************************************/

function main() {
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotDistCull", 800);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.4);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("r_volumetricDepth", "64 256 512 1024");
  setDvar("sm_spotUpdateLimit", 6);
}