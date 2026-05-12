/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dnk_lighting.gsc
**********************************************/

func_00F9() {
  func_84F8();
  if(level.var_1D4 && getDvar("2695") != "true") {
    xbox_optimizations();
  }
}

func_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
  setDvar("5153", 1);
}

xbox_optimizations() {
  setDvar("5153", 0);
}