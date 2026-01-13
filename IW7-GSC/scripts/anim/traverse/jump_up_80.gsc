/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_up_80.gsc
************************************************/

main() {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self getspectatepoint();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = var_0.var_126D4 - var_0.origin[2];
  thread scripts\anim\traverse\shared::func_11661(var_1 - 80);
  self clearanim( % root, 0.2);
  self _meth_82EA("jump_up_80", level.var_58C7["jump_up_80"], 1, 0.2, 1);
  scripts\anim\shared::donotetracks("jump_up_80");
}