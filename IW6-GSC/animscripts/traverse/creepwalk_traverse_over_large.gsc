/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\creepwalk_traverse_over_large.gsc
******************************************************************/

main() {
  creepwalk_traverse_over_large();
}

#using_animtree("generic_human");

creepwalk_traverse_over_large() {
  var_0 = [];
  var_0["traverseAnim"] = % creepwalk_traverse_over_large;
  animscripts\traverse\shared::dotraverse(var_0);
}