/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\berlin_jumpdown_28.gsc
*******************************************************/

main() {
  low_wall_human();
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % berlin_traverse_jumpdown_28;
  animscripts\traverse\shared::dotraverse(var_0);
}