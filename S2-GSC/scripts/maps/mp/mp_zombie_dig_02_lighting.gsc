/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dig_02_lighting.gsc
*********************************************************/

main() {}

onplayerspawned() {
  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 thread setplayerlightset();
  }
}

setplayerlightset() {
  wait 0.5;
  self digitaldistortsetparams(0.65, 1.7, 1.2, 1.2, 0);
  self lightsetforplayer("mp_zombie_dig_02_bright");
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 0);
  setDvar("1533", 3);
  setDvar("2387", 1);
  setDvar("5156", 1);
  setDvar("2428", "2");
  setDvar("4087", "2");
  setDvar("5142", 2);
  setDvar("3357", 2);
}