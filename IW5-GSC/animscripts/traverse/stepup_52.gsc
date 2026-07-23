/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\stepup_52.gsc
**********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF9(52.0, 5);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_stepup_52;
  var_0["traverseHeight"] = 52.0;
  animscripts\traverse\shared::_id_3FEB(var_0);
}