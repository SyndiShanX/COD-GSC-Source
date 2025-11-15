/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\hesco_barrier_over.gsc
*******************************************************/

main() {
  human_traverse();
}

#using_animtree("generic_human");

human_traverse() {
  var_0 = [ % hc_hesco_climb_a, % hc_hesco_climb_b];
  var_1 = [];
  var_1["traverseAnim"] = var_0[randomint(var_0.size)];
  animscripts\traverse\shared::dotraverse(var_1);
}