/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\wall_hop.gsc
*********************************************/

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_wall_and_window_hop("wallhop", 40);
  else
    wall_hop_human();
}

#using_animtree("generic_human");

wall_hop_human() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_window_quick;
  var_0["traverseHeight"] = 40.0;
  var_1 = isdefined(level.disallowlegswingwallhop) && level.disallowlegswingwallhop == 1;

  if(var_1 || randomint(100) < 30)
    var_0["traverseAnim"] = % traverse_wallhop_3;
  else
    var_0["traverseAnim"] = % traverse_wallhop;

  animscripts\traverse\shared::dotraverse(var_0);
}