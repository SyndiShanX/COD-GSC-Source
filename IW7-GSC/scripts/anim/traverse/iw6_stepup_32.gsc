/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\iw6_stepup_32.gsc
***************************************************/

main() {
  _id_B0CC();
}

_id_B0CC() {
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
  return % flood_traverse_stepup_32_v1;
}