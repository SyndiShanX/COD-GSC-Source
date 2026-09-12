/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_showers\mp_m_showers_lighting.gsc
******************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 10);
  setDvar("sm_spotDistCull", 1500);
}