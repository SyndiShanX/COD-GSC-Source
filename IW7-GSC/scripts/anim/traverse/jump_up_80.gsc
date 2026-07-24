/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_up_80.gsc
************************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self _meth_8148();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = var_0._id_126D4 - var_0.origin[2];
  thread scripts\anim\traverse\shared::_id_11661(var_1 - 80);
  self clearanim(%root, 0.2);
  self _meth_82EA("jump_up_80", anim._id_58C7["jump_up_80"], 1, 0.2, 1);
  scripts\anim\shared::donotetracks("jump_up_80");
}