/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\step_down.gsc
*****************************************************/

#include animscripts\traverse\shared;
#using_animtree("generic_human");

main() {
  if(self.type == "human") {
    step_down_human();
  }
  else if(self.type == "dog") {
    dog_jump_down(40, 3);
  }
}

step_down_human() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self.a.alertness = "alert";
  self traverseMode("nogravity");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("stepanim", % step_down_low_wall, % body, 1, .1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("stepanim");
  self setAnimKnobAllRestart( % crouch_fastwalk_F, % body, 1, 0.1, 1);
}