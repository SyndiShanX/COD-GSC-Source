/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\traverse\zombie_jump_up.gsc
*****************************************************/

#include animscripts\traverse\shared;
#include maps\_utility;
#include animscripts\Utility;

main() {
  if(isDefined(self.is_zombie) && self.is_zombie && self.type != "dog") {
    zombie_jump_up();
  }
}

#using_animtree("generic_human");

zombie_jump_up() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  self clearanim( % stand_and_crouch, 0.1);
  self setFlaggedAnimKnoballRestart("diveanim", % ai_zombie_jump_up, % body, 1, .1, 1);
  self playsound("dive_wall");
  self waittillmatch("diveanim", "gravity on");
  self traverseMode("nogravity");
  self waittillmatch("diveanim", "noclip");
  self traverseMode("noclip");
  self waittillmatch("diveanim", "gravity on");
  self traverseMode("gravity");
  self animscripts\shared::DoNoteTracks("diveanim");
  self.a.movement = "run";
  self.a.alertness = "casual";
}