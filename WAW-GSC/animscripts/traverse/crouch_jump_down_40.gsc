/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\crouch_jump_down_40.gsc
*********************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self.a.alertness = "alert";
  self traverseMode("nogravity");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("stepanim", %jump_across_72, %body, 1, .1, 1);
  wait .15;
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("stepanim");
}