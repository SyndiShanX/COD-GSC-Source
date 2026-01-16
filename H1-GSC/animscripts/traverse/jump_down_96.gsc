/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\jump_down_96.gsc
*************************************************/

main() {
  if(self.type == "human")
    jump_down_human();
  else if(self.type == "dog")
    animscripts\traverse\shared::dog_jump_down(96, 7);
}

#using_animtree("generic_human");

jump_down_human() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self.a.alertness = "alert";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", % jump_down_96, % body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::donotetracks("stepanim");
  self.a.pose = "crouch";
}