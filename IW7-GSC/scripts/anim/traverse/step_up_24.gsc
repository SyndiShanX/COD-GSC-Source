/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\step_up_24.gsc
************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5868(24, 5);
    return;
  }

  func_91D4();
}

func_91D4() {
  var_0 = [];
  var_0["traverseAnim"] = func_7814();
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}

func_7814() {
  return % sw_traversal_suspension_on;
}