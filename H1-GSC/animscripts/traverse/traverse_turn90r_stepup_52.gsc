/***************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\traverse_turn90r_stepup_52.gsc
***************************************************************/

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_jump_up(52.0, 5);
  else
    low_wall_human();
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % h1_traverse_turn90r_stepup_52;
  var_0["traverseHeight"] = 52.0;
  var_0["traverseSound"] = "npc_step_up_52";
  animscripts\traverse\shared::dotraverse(var_0);
}