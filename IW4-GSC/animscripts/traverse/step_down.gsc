/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\traverse\step_down.gsc
********************************************************/

#include animscripts\traverse\shared;
#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    dog_jump_down(40, 3);
  } else {
    step_down_human();
  }
}

step_down_human() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();

  self endon("killanimscript");
  self.a.movement = "walk";
  self traverseMode("nogravity");

  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);

  self setFlaggedAnimKnoballRestart("stepanim", %step_down_low_wall, %body, 1, .1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("stepanim");
}