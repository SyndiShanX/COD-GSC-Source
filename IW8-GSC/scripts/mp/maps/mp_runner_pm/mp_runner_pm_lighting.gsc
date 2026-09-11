/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_runner_pm\mp_runner_pm_lighting.gsc
******************************************************************/

function main() {
  thread hide_brush();
}

function hide_brush() {
  var_0 = getEntArray("DoorShadowBl", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }
}