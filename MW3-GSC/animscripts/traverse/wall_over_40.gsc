/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_over_40.gsc
*************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF7("window_40", 40);
  } else {
    _id_4003();
  }
}

#using_animtree("generic_human");

_id_4003() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse40;
  var_0["traverseToCoverAnim"] = % traverse40_2_cover;
  var_0["coverType"] = "Cover Crouch";
  var_0["traverseHeight"] = 40.0;
  var_0["interruptDeathAnim"][0] = animscripts\utility::_id_0C6D( % traverse40_death_start, % traverse40_death_start_2);
  var_0["interruptDeathAnim"][1] = animscripts\utility::_id_0C6D( % traverse40_death_end, % traverse40_death_end_2);
  animscripts\traverse\shared::_id_3FEB(var_0);
}