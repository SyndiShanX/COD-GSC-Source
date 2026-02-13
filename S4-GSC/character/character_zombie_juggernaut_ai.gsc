/********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: character\character_zombie_juggernaut_ai.gsc
********************************************************/

#using_animtree("zombie_juggernaut");

main() {
  self setModel("zom_juggernaut_wholebody");
  self._id_24FB = 0;
  self._id_18F3 = "zombie_juggernaut";
  self._id_189C = "zombie_juggernaut";
  self._id_10691 = "russian";
  self _meth_8300("vestlight");
  self _meth_884E("millghtgr");

  if(_func_011D(self)) {
    self _meth_84C4("c8_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

_id_0340() {
  precachemodel("zom_juggernaut_wholebody");
}

_id_9967() {
  self._id_189C = "zombie_juggernaut";
  self._id_10691 = "russian";
  self setModel("zom_juggernaut_wholebody");
}

_id_BB60(var_0) {
  level._id_11ED[var_0]["animclass"] = "zombie_juggernaut";
}