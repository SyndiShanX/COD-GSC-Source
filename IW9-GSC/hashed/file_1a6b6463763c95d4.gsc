/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1a6b6463763c95d4.gsc
***********************************************/

main() {
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 0);
  _id_101BCF35486C6FCD();
}

_id_101BCF35486C6FCD() {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  models = getEntArray("capture_only", "targetname");

  foreach(model in models)
  model hide();
}