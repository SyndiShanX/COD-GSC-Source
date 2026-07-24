/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_across_72.gsc
****************************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::_id_5869("wallhop", 20);
    return;
  }

  self._id_5270 = "stand";
  scripts\anim\utility::_id_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self _meth_8148();
  self orientmode("face angle", var_0.angles[1]);
  self _meth_82E4("jumpanim", %jump_across_72, %body, 1, 0.1, 1);
  self waittillmatch("jumpanim", "gravity on");
  self _meth_83C4("gravity");
  scripts\anim\shared::donotetracks("jumpanim");
}