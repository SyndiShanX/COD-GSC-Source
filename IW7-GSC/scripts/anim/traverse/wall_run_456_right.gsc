/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\wall_run_456_right.gsc
********************************************************/

main() {
  _id_138D2();
}

_id_138D2() {
  var_0 = [];
  var_0["traverseAnim"] = _id_7814();
  scripts\anim\traverse\shared::_id_5AC3(var_0);
}

#using_animtree("generic_human");

_id_7814() {
  return % asteroid_wallrun_r;
}