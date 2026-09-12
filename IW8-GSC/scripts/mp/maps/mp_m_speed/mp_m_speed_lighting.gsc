/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_speed\mp_m_speed_lighting.gsc
**************************************************************/

function main() {
  setDvar("sm_sunCascadeSizeMultiplier1", 1);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_sunSampleSizeNear", 0.3);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("r_volumetricDepth", "64 128 256 512");
}