/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\iw6_traverse_over_40_b.gsc
************************************************************/

main() {
  if(self.type == "dog")
    scripts\anim\traverse\shared::_id_586D("window_40", 40);
  else
    _id_B0CC();
}

#using_animtree("generic_human");

_id_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_over_40_b_iw6;
  var_0["traverseToCoverAnim"] = % traverse40_2_cover;
  var_0["coverType"] = "Cover Crouch";
  var_0["traverseHeight"] = 40.0;
  var_0["interruptDeathAnim"][0] = scripts\anim\utility::_id_2274(%traverse40_death_start, %traverse40_death_start_2);
  var_0["interruptDeathAnim"][1] = scripts\anim\utility::_id_2274(%traverse40_death_end, %traverse40_death_end_2);
  scripts\anim\traverse\shared::_id_5AC3(var_0);
}