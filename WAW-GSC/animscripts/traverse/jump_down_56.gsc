/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\jump_down_56.gsc
*****************************************************/

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
  self animscripts\traverse\shared::TraverseStartRagdollDeath();
  self setFlaggedAnimKnoballRestart("stepanim", % jump_down_56, % body, 1, .1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\traverse\shared::TraverseStopRagdollDeath();
  self animscripts\shared::DoNoteTracks("stepanim");
  self setAnimKnobAllRestart( % crouch_fastwalk_F, % body, 1, 0.1, 1);
}