/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_piccadilly\mp_piccadilly_lighting.gsc
********************************************************************/

function main() {
  setDvar("sm_roundRobinPrioritySpotShadows", 10);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_spotDistCull", 2000);
}