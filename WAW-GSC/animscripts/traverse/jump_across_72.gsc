/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\jump_across_72.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  self.desired_anim_pose = "stand";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self animscripts\traverse\shared::TraverseStartRagdollDeath();
  self setFlaggedAnimKnoballRestart("jumpanim", % jump_across_72, % body, 1, .1, 1);
  self waittillmatch("jumpanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("jumpanim");
  self.a.movement = "run";
  self.a.alertness = "casual";
  self animscripts\traverse\shared::TraverseStopRagdollDeath();
  self setAnimKnobAllRestart(animscripts\run::GetRunAnim(), % body, 1, 0.2, 1);
}