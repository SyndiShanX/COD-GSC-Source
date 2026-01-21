/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\duck_under_56.gsc
**************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("jumpanim", %gulag_pipe_traverse, %body, 1, 0.1, 1);
  self waittillmatch("jumpanim", "finish");
  self traversemode("gravity");
  animscripts\shared::donotetracks("jumpanim");
}