/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\step_up_32.gsc
************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5868(32, 5);
    return;
  }

  func_B0CC();
}

func_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = func_7814();
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}

func_7814() {
  return % ch_pragueb_7_5_crosscourt_aimantle_a;
}