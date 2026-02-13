/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1336.gsc
*************************************************/

#using_animtree("dog");

main() {
  self setModel("c_s4_doberman_03");
  self._id_24FB = 0;
  self._id_18F3 = "dog";
  self._id_189C = "dog";
  self._id_10691 = "unitednations";
  self _meth_8300("vestlight");
  self _meth_884E("millghtgr");

  if(_func_011D(self)) {
    self _meth_84C4("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

_id_0340() {
  precachemodel("c_s4_doberman_03");
}

_id_9967() {
  self._id_189C = "dog";
  self._id_10691 = "unitednations";
  self setModel("c_s4_doberman_03");
}

_id_BB60(var_0) {
  level._id_11ED[var_0]["animclass"] = "dog";
}