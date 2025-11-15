/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2868.gsc
************************/

func_95F7() {
  if(level.script == level.var_B8D2.var_ABFA[0].name && !level.player _meth_8139("hasEverPlayed_SP")) {
    scripts\engine\utility::delaythread(0.1, ::func_12DC3);
  }
}

func_12DC3() {
  level.player _meth_8302("hasEverPlayed_SP", 1);
  updategamerprofile();
}