/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\jumpdown_56.gsc
*************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5867(5, 1);
    return;
  }

  if(self.unittype == "seeker") {
    scripts\anim\traverse\shared::func_F163();
    return;
  }

  func_B0CC();
}

func_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_56;
  scripts\anim\traverse\shared::func_5AC3(var_0);
}