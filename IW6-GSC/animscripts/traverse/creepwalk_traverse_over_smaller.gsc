/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\creepwalk_traverse_over_smaller.gsc
********************************************************************/

main() {
  creepwalk_traverse_over_smaller();
}

#using_animtree("generic_human");

creepwalk_traverse_over_smaller() {
  var_0 = [];
  var_0["traverseAnim"] = % creepwalk_traverse_over_smaller;
  animscripts\traverse\shared::dotraverse(var_0);
}