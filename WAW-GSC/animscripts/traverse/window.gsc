/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\window.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self setFlaggedAnimKnoballRestart("diveanim", % windowclimb, % body, 1, .1, 1);
  self waittillmatch("diveanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("diveanim");
  self.a.movement = "run";
  self.a.alertness = "casual";
  while(self getGroundEntType() == "none")
    wait 0.05;
  self setAnimKnobAllRestart(animscripts\run::GetCrouchRunAnim(), % body, 1, 0.1, 1);
  thread animscripts\run::MakeRunSounds("killSoundThread");
}