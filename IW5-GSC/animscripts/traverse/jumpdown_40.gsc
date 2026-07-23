/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jumpdown_40.gsc
************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF8(3, 1.0);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_40;
  animscripts\traverse\shared::_id_3FEB(var_0);
}