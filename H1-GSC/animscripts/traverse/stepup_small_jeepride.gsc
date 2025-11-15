/**********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\stepup_small_jeepride.gsc
**********************************************************/

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_jump_up(38.0, 5);
  else
    low_wall_human();
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % h1_traverse_stepup_small;
  var_0["traverseHeight"] = 38.0;
  var_0["traverseSound"] = "npc_step_up_38";
  animscripts\traverse\shared::dotraverse(var_0);
}