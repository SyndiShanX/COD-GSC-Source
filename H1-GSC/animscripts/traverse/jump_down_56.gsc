/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\jump_down_56.gsc
*************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self.a.alertness = "alert";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", % jump_down_56, % body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::donotetracks("stepanim");
  self setanimknoballrestart( % crouch_fastwalk_f, % body, 1, 0.1, 1);
}