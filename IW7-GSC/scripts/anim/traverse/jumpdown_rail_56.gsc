/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\jumpdown_rail_56.gsc
******************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5867(7, 0.7);
    return;
  }

  func_91D4();
}

func_91D4() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_rail_56;
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}