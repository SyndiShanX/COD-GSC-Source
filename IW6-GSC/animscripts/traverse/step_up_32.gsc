/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\step_up_32.gsc
***********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_up(32.0, 5);
  }
  else {
    low_wall_human();
  }
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % ch_pragueb_7_5_crosscourt_aimantle_a;
  var_0["traverseHeight"] = 32.0;
  animscripts\traverse\shared::dotraverse(var_0);
}