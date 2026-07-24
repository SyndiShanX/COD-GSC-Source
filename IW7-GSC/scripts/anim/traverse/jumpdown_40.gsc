/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jumpdown_40.gsc
*************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::_id_5867(3, 1.0);
  } else if(self.unittype == "seeker") {
    scripts\anim\traverse\shared::_id_F163();
  } else {
    _id_B0CC();
  }
}

#using_animtree("generic_human");

_id_B0CC() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_jumpdown_40;
  scripts\anim\traverse\shared::_id_5AC3(var_0);
}