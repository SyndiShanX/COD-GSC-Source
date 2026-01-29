/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jumpdown_96.gsc
************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF8(7, 0.8);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_96;
  animscripts\traverse\shared::_id_3FEB(var_0);
}