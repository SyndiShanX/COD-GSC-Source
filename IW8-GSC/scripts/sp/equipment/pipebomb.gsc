/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\pipebomb.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &pipebombfiremain);
}

function pipebombfiremain(var0) {
  if(!isDefined(var0)) {
    return;
  }

  thread scripts\anim\battlechatter_ai::evaluateattackevent("frag");
}