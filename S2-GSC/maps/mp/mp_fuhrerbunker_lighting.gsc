/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_fuhrerbunker_lighting.gsc
************************************************/

func_00F9() {
  if(level.var_1D4 && getDvar("2695") != "true") {
    xbox_optimizations();
  }
}

xbox_optimizations() {
  setDvar("1578", 0);
  setDvar("5156", 0);
}