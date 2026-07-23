/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jumpdown_130.gsc
*************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_down(7, 0.7);
  } else {
    jumpdown_130_human();
  }
}

#using_animtree("generic_human");

jumpdown_130_human() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_130;
  animscripts\traverse\shared::dotraverse(var_0);
}