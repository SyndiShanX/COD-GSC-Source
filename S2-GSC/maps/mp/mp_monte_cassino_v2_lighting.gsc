/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_monte_cassino_v2_lighting.gsc
****************************************************/

func_00F9() {
  setDvar("r_sunshadowscale", 1);
  setDvar("5153", 1);
  if(level.var_1D4 && getDvar("2695") != "true") {
    xbox_optimizations();
  }
}

xbox_optimizations() {
  setDvar("5153", 0);
  setDvar("5156", 1);
  setDvar("r_sunshadowscale", 0.7);
}