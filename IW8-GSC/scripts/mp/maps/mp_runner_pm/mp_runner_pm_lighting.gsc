/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_runner_pm\mp_runner_pm_lighting.gsc
******************************************************************/

function main() {
  thread hide_brush();
}

function hide_brush() {
  var0 = getEntArray("DoorShadowBl", "targetname");

  foreach(var2 in var0) {
    var2 hide();
  }
}