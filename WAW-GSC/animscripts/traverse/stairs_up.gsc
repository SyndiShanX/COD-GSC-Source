/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\stairs_up.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self traverseMode("nogravity");
  if(self animscripts\utility::weaponAnims() == "none" || self animscripts\utility::weaponAnims() == "pistol")
    climbAnim = % climbstairs_up;
  else
    climbAnim = % climbstairs_up_armed;
  startnode = self getnegotiationstartnode();
  assert(isDefined(startNode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("climbanim", climbAnim, %body, 1, .1, 1);
  endnode = self getnegotiationendnode();
  assert(isDefined(endnode));
  endPos = self endnode.origin + (0, 0, 1);
  horizontalDelta = (endPos[0] - self.origin[0], endPos[1] - self.origin[1], 0);
  horizontalDistance = length(horizontalDelta);
  cycleDelta = GetMoveDelta(climbAnim, 0, 1);
  cycleDelta = (cycleDelta[0], cycleDelta[1], 0);
  cycleHorDist = length(cycleDelta);
  cycleTime = getanimlength(climbAnim);
  climbingTime = (horizontalDistance / cycleHorDist) * cycleTime;
  self animscripts\shared::DoNoteTracksForTime(climbingTime, "climbanim");
  self.a.movement = "walk";
  self.a.pose = "stand";
  self.a.alertness = "alert";
}