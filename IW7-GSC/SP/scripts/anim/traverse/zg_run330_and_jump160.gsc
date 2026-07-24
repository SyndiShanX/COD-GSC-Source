/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\zg_run330_and_jump160.gsc
***********************************************************/

main() {
  _id_13EF5();
}

_id_13EF5() {
  var_0 = [];
  var_0["traverseAnim"] = _id_7814();
  scripts\anim\traverse\shared::_id_5AC3(var_0);
}

#using_animtree("generic_human");

_id_7814() {
  return % hm_zg_red_exposed_traversal_step_01;
}