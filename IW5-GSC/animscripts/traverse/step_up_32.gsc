/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\step_up_32.gsc
***********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF9(32.0, 5);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % ch_pragueb_7_5_crosscourt_aimantle_a;
  var_0["traverseHeight"] = 32.0;
  animscripts\traverse\shared::_id_3FEB(var_0);
}