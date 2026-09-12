/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_petrograd\mp_petrograd_lighting.gsc
******************************************************************/

function main() {
  setDvar("sm_spotDistCull", 2000);
  setDvar("sm_roundRobinPrioritySpotShadows", 12);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 0);
  setDvar("sm_spotShadowScore0Min", 0.3);
  setDvar("sm_spotShadowSampleExtra0", 0.95);
}