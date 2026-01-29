/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_divethrough_36.gsc
**********************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF7("window_40", 40);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_window_m_2_dive;
  var_0["traverseStopsAtEnd"] = 1;
  var_0["traverseHeight"] = 36.0;
  animscripts\traverse\shared::_id_3FEB(var_0);
}