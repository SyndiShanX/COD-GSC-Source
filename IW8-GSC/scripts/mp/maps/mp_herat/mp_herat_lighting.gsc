/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_herat\mp_herat_lighting.gsc
**********************************************************/

function main() {
  setDvar("sm_sunSampleSizeNear", 0.4);
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 0);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("r_compressedSunShadowClipPlanes", 1);
}