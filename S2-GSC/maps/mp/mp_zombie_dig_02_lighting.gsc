/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dig_02_lighting.gsc
*************************************************/

func_00F9() {}

func_6B82() {
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 thread setplayerlightset();
  }
}

setplayerlightset() {
  wait(0.5);
  self vignettesetparams(0.65, 1.7, 1.2, 1.2, 0);
  self lightsetforplayer("mp_zombie_dig_02_bright");
}

func_84F8() {
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