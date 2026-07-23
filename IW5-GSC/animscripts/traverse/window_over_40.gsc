/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_over_40.gsc
***************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF7("window_40", 40);
  } else {
    _id_3FFE();
  }
}

#using_animtree("generic_human");

_id_3FFE() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_window_m_2_run;
  var_0["traverseToCoverAnim"] = % traverse_window_m_2_stop;
  var_0["coverType"] = "Cover Crouch";
  var_0["traverseHeight"] = 36.0;
  var_0["interruptDeathAnim"][0] = animscripts\utility::_id_0C6D(%traverse_window_death_start);
  var_0["interruptDeathAnim"][1] = animscripts\utility::_id_0C6D(%traverse_window_death_end);
  animscripts\traverse\shared::_id_3FEB(var_0);
}