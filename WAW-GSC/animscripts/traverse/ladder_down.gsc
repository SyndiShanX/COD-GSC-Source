/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\ladder_down.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  endnode = self getnegotiationendnode();
  assert(isDefined(endnode));
  endPos = endnode.origin;
  self animscripts\traverse\shared::TraverseStartRagdollDeath();
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("climbanim", %ladder_climbon, %body, 1, .1, 1);
  self animscripts\shared::DoNoteTracks("climbanim");
  climbAnim = % ladder_climbdown;
  self setFlaggedAnimKnoballRestart("climbanim", climbAnim, %body, 1, .1, 1);
  cycleDelta = GetMoveDelta(climbAnim, 0, 1);
  climbRate = cycleDelta[2] / getanimlength(climbAnim);
  climbingTime = (endPos[2] - self.origin[2]) / climbRate;
  self animscripts\shared::DoNoteTracksForTime(climbingTime, "climbanim");
  self animscripts\traverse\shared::TraverseStopRagdollDeath();
  self traverseMode("gravity");
  self.a.movement = "stop";
  self.a.pose = "stand";
  self.a.alertness = "alert";
}