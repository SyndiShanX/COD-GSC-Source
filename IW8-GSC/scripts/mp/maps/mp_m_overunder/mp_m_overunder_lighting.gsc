/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_overunder\mp_m_overunder_lighting.gsc
**********************************************************************/

function main() {
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.5);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 4);
}