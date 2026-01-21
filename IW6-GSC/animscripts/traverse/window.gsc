/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window.gsc
*******************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("diveanim", %windowclimb, %body, 1, 0.1, 1);
  self waittillmatch("diveanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::donotetracks("diveanim");
}