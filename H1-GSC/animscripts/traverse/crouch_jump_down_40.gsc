/********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\crouch_jump_down_40.gsc
********************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", % jump_across_72, % body, 1, 0.1, 1);
  wait 0.15;
  self traversemode("gravity");
  animscripts\shared::donotetracks("stepanim");
}