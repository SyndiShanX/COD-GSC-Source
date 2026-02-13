/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: character\character_zombie_trickster_ai.gsc
*******************************************************/

#using_animtree("zombie_trickster");

main() {
  self setModel("c_s4_zmb_demon_trickster");
  self._id_24FB = 0;
  self._id_18F3 = "zombie_trickster";
  self._id_189C = "zombie_trickster";
  self._id_10691 = "russian";
  self _meth_8300("vestlight");
  self _meth_884E("millghtgr");

  if(_func_011D(self)) {
    self _meth_84C4("c8_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

_id_0340() {
  precachemodel("c_s4_zmb_demon_trickster");
}

_id_9967() {
  self._id_189C = "zombie_trickster";
  self._id_10691 = "russian";
  self setModel("c_s4_zmb_demon_trickster");
}

_id_BB60(var_0) {
  level._id_11ED[var_0]["animclass"] = "zombie_trickster";
}