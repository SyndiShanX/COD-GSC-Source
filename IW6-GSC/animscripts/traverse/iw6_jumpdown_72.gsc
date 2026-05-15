/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\iw6_jumpdown_72.gsc
****************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_down(7, 0.7);
  } else {
    human_traverse();
  }
}

#using_animtree("generic_human");

human_traverse() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_72_iw6;
  animscripts\traverse\shared::dotraverse(var_0);
}