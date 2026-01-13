/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\stepup_52_fast.gsc
****************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5868(52, 5);
    return;
  }

  func_B0CC();
}

func_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_stepup_52_fast;
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}