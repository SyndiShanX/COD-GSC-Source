/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\dog_jump_over_40.gsc
*****************************************************/

main() {
  if(self.type == "dog") {
    var_0 = [];
    var_0["traverseAnim"] = "dog_jump_over_40";
    var_0["linkMe"] = 1;

    if(!animscripts\dog\dog_kill_traversal::check_kill_traversal(var_0)) {
      return animscripts\traverse\shared::dog_wall_and_window_hop("window_40", 40);
      return;
    }
  } else
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
  animscripts\traverse\shared::dotraverse(var_0);
}