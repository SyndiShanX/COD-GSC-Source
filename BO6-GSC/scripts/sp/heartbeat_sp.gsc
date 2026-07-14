/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\heartbeat_sp.gsc
***************************************/

#using scripts\common\heartbeat;
#namespace heartbeat_sp;

function main() {
  heartbeat::initcommonheartbeat(&playsoundfunc);
}

function function_201d919eac18da03() {
  thread heartbeat::function_d34358e241e5f2ee();
}

function playsoundfunc(firstpersonalias, thirdpersonalias, soundsource) {
  self playlocalsound(firstpersonalias);
}