/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\jumpdown_130.gsc
**************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5867(7, 0.7);
    return;
  }

  func_A4DD();
}

func_A4DD() {
  var_0 = [];
  var_0["traverseAnim"] = func_7814();
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}

func_7814() {
  return % traverse_jumpdown_130;
}