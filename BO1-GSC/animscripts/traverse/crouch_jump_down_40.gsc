/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\crouch_jump_down_40.gsc
********************************************************/

#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree("generic_human");
main() {
  switch (self.type) {
    case "human":
      human();
      break;
    case "dog":
      dog();
      break;
    case "zombie":
      human();
      break;
    case "zombie_dog":
      dog();
      break;
  }
}

human() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self.a.alertness = "alert";
  self traverseMode("nogravity");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("stepanim", %ai_jump_across_72, %body, 1, .1, 1);
  wait .15;
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("stepanim");
}

dog() {
  dog_jump_down(96, 7);
}