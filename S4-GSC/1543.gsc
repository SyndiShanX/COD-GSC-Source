/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1543.gsc
*************************************************/

#using_animtree("zombie");

main() {
  _id_06C4::_id_D5FB(xmodelalias\s4_cp_zm_base_zombie_bodies::main());
  self._id_24FB = 0;
  self._id_18F3 = "zombie";
  self._id_189C = "zombie";
  self._id_10691 = "russian";
  self _meth_8300("vestlight");
  self _meth_884E("millghtgr");

  if(_func_011D(self)) {
    self _meth_84C4("c8_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

_id_0340() {
  _id_06C4::_id_BB6B(xmodelalias\s4_cp_zm_base_zombie_bodies::main());
}

_id_9967() {
  self._id_189C = "zombie";
  self._id_10691 = "russian";
  _id_06C4::_id_D5FB(xmodelalias\s4_cp_zm_base_zombie_bodies::main());
}

_id_BB60(var_0) {
  level._id_11ED[var_0]["animclass"] = "zombie";
}