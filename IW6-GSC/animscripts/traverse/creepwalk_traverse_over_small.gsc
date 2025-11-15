/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\creepwalk_traverse_over_small.gsc
******************************************************************/

main() {
  creepwalk_traverse_over_small();
}

#using_animtree("generic_human");

creepwalk_traverse_over_small() {
  var_0 = [];
  var_0["traverseAnim"] = % creepwalk_traverse_over_small;
  animscripts\traverse\shared::dotraverse(var_0);
}