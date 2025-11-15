/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\window_2.gsc
*********************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_wall_and_window_hop("wallhop", 40);
  else
    advancedwindowtraverse( % windowclimb, 35);
}

advancedwindowtraverse(var_0, var_1) {
  var_2 = [];
  var_2["traverseAnim"] = var_0;
  var_2["traverseHeight"] = var_1;
  var_2["traverseSound"] = "npc_wall_over_40";
  animscripts\traverse\shared::dotraverse(var_2);
}