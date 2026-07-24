/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jumpdown_130.gsc
**************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::_id_5867(7, 0.7);
  } else {
    _id_A4DD();
  }
}

_id_A4DD() {
  var_0 = [];
  var_0["traverseAnim"] = _id_7814();

  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::_id_5AC3(var_0);
  } else {
    self waittill("killanimscript");
  }
}

#using_animtree("generic_human");

_id_7814() {
  return % traverse_jumpdown_130;
}