/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\trench_jumpout.gsc
***************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", %gully_trenchjump, %body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::donotetracks("stepanim");
  self setanimknoballrestart(animscripts\run::getcrouchrunanim(), %body, 1, 0.1, 1);
}