/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\window_divethrough_36.gsc
***********************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_586D("window_40", 40);
    return;
  }

  func_B0CC();
}

func_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_window_m_2_dive;
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}