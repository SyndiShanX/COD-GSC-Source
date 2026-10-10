/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\heartbeat_sp.gsc
***********************************************/

#using scripts\common\heartbeat;
#namespace heartbeat_sp;

function main() {
  function_94461e6fd9196c6a(&playsoundfunc);
}

function function_767efe0110bfa73a() {
  thread function_a9c6f7587066ce13();
}

function playsoundfunc(firstpersonalias, thirdpersonalias, soundsource) {
  self playlocalsound(firstpersonalias);
}