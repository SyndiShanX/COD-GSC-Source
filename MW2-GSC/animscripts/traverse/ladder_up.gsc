/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\traverse\ladder_up.gsc
********************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();

  self endon("killanimscript");

  self traverseMode("noclip");

  climbAnim = % ladder_climbup;
  endAnim = % ladder_climboff;

  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);

  self setFlaggedAnimKnoballRestart("climbanim", climbAnim, %body, 1, .1, 1);

  endAnimDelta = GetMoveDelta(endAnim, 0, 1);

  endNode = self getnegotiationendnode();
  assert(isDefined(endnode));
  endPos = endnode.origin - endAnimDelta + (0, 0, 1);

  cycleDelta = GetMoveDelta(climbAnim, 0, 1);
  climbRate = cycleDelta[2] / getanimlength(climbAnim);

  climbingTime = (endPos[2] - self.origin[2]) / climbRate;
  if(climbingTime > 0) {
    self.allowpain = true;
    self animscripts\shared::DoNoteTracksForTime(climbingTime, "climbanim");

    self setFlaggedAnimKnoballRestart("climbanim", endAnim, %body, 1, .1, 1);
    self animscripts\shared::DoNoteTracks("climbanim");
  }

  self traverseMode("gravity");
  self.a.movement = "run";
  self.a.pose = "crouch";
}