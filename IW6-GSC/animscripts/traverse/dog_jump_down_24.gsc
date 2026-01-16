/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\dog_jump_down_24.gsc
*****************************************************/

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_jump_down(24.0, 5, "jump_down_24", 1);
  else
    low_wall_human();
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % ch_pragueb_7_5_crosscourt_aimantle_a;
  var_0["traverseHeight"] = 32.0;
  animscripts\traverse\shared::dotraverse(var_0);
}