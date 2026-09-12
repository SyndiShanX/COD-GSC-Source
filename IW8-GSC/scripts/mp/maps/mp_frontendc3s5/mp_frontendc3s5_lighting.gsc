/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_lighting.gsc
************************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("sm_sunCascadeSizeMultiplier1", 3);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_spotDistCull", 750);
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("sm_roundRobinPrioritySpotShadows", 10);
  waitframe();
  setDvar("sm_spotUpdateLimit", 8);
}