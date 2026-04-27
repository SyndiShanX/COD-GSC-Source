/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\traverse\duck_under_56.gsc
********************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "stand";
  animscripts\utility::UpdateAnimPose();

  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");

  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);

  self setFlaggedAnimKnoballRestart("jumpanim", %gulag_pipe_traverse, %body, 1, .1, 1);
  self waittillmatch("jumpanim", "finish");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("jumpanim");
}