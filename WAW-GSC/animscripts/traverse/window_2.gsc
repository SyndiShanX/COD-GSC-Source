/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\window_2.gsc
*****************************************************/

#include animscripts\traverse\shared;
#using_animtree("generic_human");

main() {
  if(self.type == "human")
    self advancedWindowTraverse( % windowclimb, 35);
  else if(self.type == "dog")
    dog_wall_and_window_hop("wallhop", 40);
}

advancedWindowTraverse(traverseAnim, normalHeight) {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self.old_anim_movement = self.a.movement;
  self.old_anim_alertness = self.a.alertness;
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  realHeight = startnode.traverse_height - startnode.origin[2];
  self setFlaggedAnimKnoballRestart("traverse", traverseAnim, % body, 1, 0.15, 1);
  wait 0.7;
  self thread teleportThread(realHeight - normalHeight);
  wait 0.9;
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("traverse");
  self.a.movement = self.old_anim_movement;
  self.a.alertness = self.old_anim_alertness;
  self setAnimKnobAllRestart(animscripts\run::GetRunAnim(), % body, 1, 0.2, 1);
  thread animscripts\run::MakeRunSounds("killSoundThread");
}