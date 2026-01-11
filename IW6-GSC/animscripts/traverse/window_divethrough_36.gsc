/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_divethrough_36.gsc
**********************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_wall_and_window_hop("window_40", 40);
  }
  else {
    low_wall_human();
  }
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_window_m_2_dive;
  var_0["traverseStopsAtEnd"] = 1;
  var_0["traverseHeight"] = 36.0;
  animscripts\traverse\shared::dotraverse(var_0);
}