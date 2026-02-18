/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_306215d6cfd5f1f4.gsc
***********************************************/

#using scripts\core_common\territory;
#namespace namespace_99c84a33;

function function_99652b58(name, index, team = # "none") {
  cameras = territory::function_1f583d2e(name, "targetname");

  if(cameras.size) {
    addobjectivecamerapoint(name, index, team, cameras[0].origin, cameras[0].angles);
    return true;
  }

  return false;
}

function function_67b65e2a(name, index, team, origin, angles) {
  addobjectivecamerapoint(name, index, team, origin, angles);
  function_e795803(name, 1);
}

function function_99c84a33(index) {
  self.spectatorclient = -1;
  self function_eccd0b1c(index);
}