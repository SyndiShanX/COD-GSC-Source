/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\flood_jumpdown_126_v2.gsc
**********************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_down(5, 1.0);
  } else {
    low_wall_human();
  }
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % flood_garage_jump_opfor_02;
  animscripts\traverse\shared::dotraverse(var_0);
}