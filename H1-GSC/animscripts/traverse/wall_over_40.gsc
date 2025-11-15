/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\wall_over_40.gsc
*************************************************/

main() {
  if(self.type == "dog")
    animscripts\traverse\shared::dog_wall_and_window_hop("window_40", 40);
  else
    low_wall_human();
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse40;
  var_0["traverseToCoverAnim"] = % traverse40_2_cover;
  var_0["coverType"] = "Cover Crouch";
  var_0["traverseHeight"] = 40.0;
  var_0["interruptDeathAnim"][0] = animscripts\utility::array( % traverse40_death_start, % traverse40_death_start_2);
  var_0["interruptDeathAnim"][1] = animscripts\utility::array( % traverse40_death_end, % traverse40_death_end_2);
  var_0["traverseSound"] = "npc_wall_over_40";
  animscripts\traverse\shared::dotraverse(var_0);
}