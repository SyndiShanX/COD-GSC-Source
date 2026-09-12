/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_gun_course\mp_t_gun_course_lighting.gsc
************************************************************************/

function main() {
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_sunSampleSizeNear", 0.24);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotDistCull", 400);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
}