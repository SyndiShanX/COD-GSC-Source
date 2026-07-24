/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\window_divethrough_36.gsc
***********************************************************/

main() {
  if(self.type == "dog")
    scripts\anim\traverse\shared::_id_586D("window_40", 40);
  else
    _id_B0CC();
}

#using_animtree("generic_human");

_id_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_window_m_2_dive;

  if(getdvarint("ai_iw7", 0) == 0)
    scripts\anim\traverse\shared::_id_5AC3(var_0);
  else
    self waittill("killanimscript");
}