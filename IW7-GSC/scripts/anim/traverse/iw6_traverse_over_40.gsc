/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\iw6_traverse_over_40.gsc
**********************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_586D("window_40", 40);
    return;
  }

  func_B0CC();
}

func_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_over_40_a_iw6;
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}