/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\pipebomb.gsc
***********************************************/

function precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, &pipebombfiremain);
}

function pipebombfiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  thread scripts\anim\battlechatter_ai::evaluateattackevent("frag");
}