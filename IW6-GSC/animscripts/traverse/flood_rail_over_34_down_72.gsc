/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\flood_rail_over_34_down_72.gsc
***************************************************************/

main() {
  if(self.type == "dog")
    return;
  else
    low_wall_human();
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % flood_rail_over_34_down_72;
  var_0["traverseHeight"] = 34.0;
  animscripts\traverse\shared::dotraverse(var_0);
}