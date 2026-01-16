/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_over_high_wall.gsc
***********************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;
#include animscripts\utility;
#include animscripts\shared;
#using_animtree("generic_human");

main() {
  preparefortraverse();
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self clearanim( % stand_and_crouch, 0.1);
  self setflaggedanimknoballrestart("diveanim", animarray("jump_over_high_wall", "move"), % body, 1, 0.1, 1);
  self playsound("dive_wall");
  self waittillmatch("diveanim", "gravity on");
  self traversemode("nogravity");
  self waittillmatch("diveanim", "noclip");
  self traversemode("noclip");
  self waittillmatch("diveanim", "gravity on");
  self traversemode("gravity");
  self animscripts\shared::donotetracks("diveanim");
  self.a.movement = "run";
  self.a.alertness = "casual";
}