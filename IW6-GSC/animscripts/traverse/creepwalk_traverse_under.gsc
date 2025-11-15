/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\creepwalk_traverse_under.gsc
*************************************************************/

main() {
  creepwalk_traverse_under();
}

#using_animtree("generic_human");

creepwalk_traverse_under() {
  var_0 = [];
  var_0["traverseAnim"] = % creepwalk_traverse_under;
  animscripts\traverse\shared::dotraverse(var_0);
}