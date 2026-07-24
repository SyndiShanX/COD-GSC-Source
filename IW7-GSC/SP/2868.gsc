/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2868.gsc
**************************************/

_id_95F7() {
  if(level.script == level._id_B8D2._id_ABFA[0].name && !level.player _meth_8139("hasEverPlayed_SP")) {
    scripts\engine\utility::delaythread(0.1, ::_id_12DC3);
  }
}

_id_12DC3() {
  level.player _meth_8302("hasEverPlayed_SP", 1);
  updategamerprofile();
}