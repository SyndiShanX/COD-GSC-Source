/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\stepup_38.gsc
***********************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::_id_5868(38.0, 5);
  } else {
    _id_B0CC();
  }
}

#using_animtree("generic_human");

_id_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_stepup_52;
  var_0["traverseHeight"] = 38.0;
  scripts\anim\traverse\shared::_id_5AC3(var_0);
}