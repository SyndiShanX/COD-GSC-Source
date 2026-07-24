/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\wall_run_curved_90_668_left.gsc
*****************************************************************/

main() {
  _id_138BB();
}

_id_138BB() {
  var_0 = [];
  var_0["traverseAnim"] = _id_7814();
  scripts\anim\traverse\shared::_id_5AC3(var_0);
}

#using_animtree("generic_human");

_id_7814() {
  if(scripts\engine\utility::cointoss())
    return % moon_curved_wallrun_1;
  else
    return % moon_curved_wallrun_2;
}