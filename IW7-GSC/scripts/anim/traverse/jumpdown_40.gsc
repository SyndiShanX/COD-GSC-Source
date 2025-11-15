/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\jumpdown_40.gsc
*************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5867(3, 1);
    return;
  }

  if(self.unittype == "seeker") {
    scripts\anim\traverse\shared::func_F163();
    return;
  }

  func_B0CC();
}

func_B0CC() {
  var_00 = [];
  var_00["traverseAnim"] = % traverse_jumpdown_40;
  scripts\anim\traverse\shared::func_5AC3(var_00);
}