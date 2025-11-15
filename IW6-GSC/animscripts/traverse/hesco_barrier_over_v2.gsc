/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\hesco_barrier_over_v2.gsc
**********************************************************/

main() {
  human_traverse();
}

#using_animtree("generic_human");

human_traverse() {
  var_0 = [];
  var_0["traverseAnim"] = % hc_hesco_climb_c;
  animscripts\traverse\shared::dotraverse(var_0);
}