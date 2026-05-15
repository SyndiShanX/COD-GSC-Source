/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\stepup_38.gsc
**********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_up(38.0, 5);
  } else {
    low_wall_human();
  }
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_stepup_52;
  var_0["traverseHeight"] = 38.0;
  animscripts\traverse\shared::dotraverse(var_0);
}