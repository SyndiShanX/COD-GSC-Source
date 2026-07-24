/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\step_up_24.gsc
************************************************/

main() {
  if(self.type == "dog")
    scripts\anim\traverse\shared::_id_5868(24.0, 5);
  else
    _id_91D4();
}

_id_91D4() {
  var_0 = [];
  var_0["traverseAnim"] = _id_7814();

  if(getdvarint("ai_iw7", 0) == 0)
    scripts\anim\traverse\shared::_id_5AC3(var_0);
  else
    self waittill("killanimscript");
}

#using_animtree("generic_human");

_id_7814() {
  return % sw_traversal_suspension_on;
}