/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_61eb50466a589dec.gsc
*************************************************/

#using scripts\common\heartbeat;
#using scripts\engine\utility;
#namespace namespace_f388b4b671470a7d;

function main() {
  initcommonheartbeat(&playsoundfunc);

  while(!issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback")) {
    waitframe();
  }

  [[getsharedfunc("aggregator", "registerOnPlayerSpawnCallback")]](&function_767efe0110bfa73a);
}

function function_767efe0110bfa73a() {
  thread function_a9c6f7587066ce13();
}

function playsoundfunc(firstpersonalias) {
  self playsoundtoplayer(firstpersonalias, self);
}