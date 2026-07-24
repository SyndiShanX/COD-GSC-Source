/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_across_100.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::_id_5869("window_40", 20);
    return;
  }

  self._id_5270 = "stand";
  scripts\anim\utility::_id_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self _meth_8148();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = _id_7814();
  self _meth_82E4("jumpanim", var_1, %body, 1, 0.1, 1);
  scripts\anim\shared::donotetracks("jumpanim");
}

_id_7814() {
  var_0 = [];
  var_0[0] = % jump_across_100_spring;
  var_0[1] = % jump_across_100_lunge;
  var_0[2] = % jump_across_100_stumble;
  return var_0[randomint(var_0.size)];
}