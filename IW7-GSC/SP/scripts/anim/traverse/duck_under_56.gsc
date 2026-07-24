/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\duck_under_56.gsc
***************************************************/

#using_animtree("generic_human");

main() {
  self._id_5270 = "stand";
  scripts\anim\utility::_id_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self _meth_8148();
  self orientmode("face angle", var_0.angles[1]);
  self _meth_82E4("jumpanim", %gulag_pipe_traverse, %body, 1, 0.1, 1);
  self waittillmatch("jumpanim", "finish");
  self _meth_83C4("gravity");
  scripts\anim\shared::donotetracks("jumpanim");
}