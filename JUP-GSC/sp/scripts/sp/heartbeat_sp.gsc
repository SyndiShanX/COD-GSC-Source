/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\heartbeat_sp.gsc
***********************************************/



#using scripts\common\heartbeat;
#namespace heartbeat_sp;

function main() {
  initcommonheartbeat(&playsoundfunc);
}

function function_767efe0110bfa73a() {
  thread function_a9c6f7587066ce13();
}

function playsoundfunc(firstpersonalias, thirdpersonalias, soundsource) {
  self playlocalsound(firstpersonalias);
}