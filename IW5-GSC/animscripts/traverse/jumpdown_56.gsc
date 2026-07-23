/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jumpdown_56.gsc
************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF8(5, 1.0);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_56;
  animscripts\traverse\shared::_id_3FEB(var_0);
}