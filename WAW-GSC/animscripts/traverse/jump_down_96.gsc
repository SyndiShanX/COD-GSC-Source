/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\jump_down_96.gsc
*****************************************************/

#include animscripts\traverse\shared;

main() {
  if(self.type == "human") {
    jump_down_human();
  } else if(self.type == "dog") {
    dog_jump_down(96, 7);
  }
}

#using_animtree("generic_human");

jump_down_human() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self.a.alertness = "alert";
  self traverseMode("nogravity");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("stepanim", % jump_down_96, % body, 1, .1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("stepanim");
  self.a.pose = "crouch";
}