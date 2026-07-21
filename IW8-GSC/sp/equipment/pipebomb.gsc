/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\pipebomb.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::pipebombfiremain);
}

pipebombfiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  thread scripts\anim\battlechatter_ai.gsc::evaluateattackevent("frag");
}