/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_emporium\mp_emporium_lighting.gsc
****************************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.4);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_spotDistCull", 1000);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
}