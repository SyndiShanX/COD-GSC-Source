/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_over_high_wall.gsc
*********************************************************/

#using_animtree("generic_human");

main() {
  self._id_5270 = "crouch";
  scripts\anim\utility::_id_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self _meth_8148();
  self orientmode("face angle", var_0.angles[1]);
  self clearanim(%stand_and_crouch, 0.1);
  self _meth_82E4("diveanim", %jump_over_high_wall, %body, 1, 0.1, 1);
  self playSound("dive_wall");
  self waittillmatch("diveanim", "gravity on");
  self _meth_83C4("nogravity");
  self waittillmatch("diveanim", "noclip");
  self _meth_83C4("noclip");
  self waittillmatch("diveanim", "gravity on");
  self _meth_83C4("gravity");
  scripts\anim\shared::donotetracks("diveanim");
}