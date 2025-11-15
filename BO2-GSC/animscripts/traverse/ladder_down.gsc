/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\ladder_down.gsc
************************************************/

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
  endnode = self getnegotiationendnode();
  assert(isDefined(endnode));
  endpos = endnode.origin;
  self animscripts\traverse\shared::traversestartragdolldeath();
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self setflaggedanimknoballrestart("climbanim", animarray("ladder_climbon", "move"), % body, 1, 0.1, 1);
  self animscripts\shared::donotetracks("climbanim");
  climbanim = animarray("ladder_climbdown", "move");
  self setflaggedanimknoballrestart("climbanim", climbanim, % body, 1, 0.1, 1);
  cycledelta = getmovedelta(climbanim, 0, 1);
  climbrate = cycledelta[2] / getanimlength(climbanim);
  climbingtime = (endpos[2] - self.origin[2]) / climbrate;
  self animscripts\shared::donotetracksfortime(climbingtime, "climbanim");
  self animscripts\traverse\shared::traversestopragdolldeath();
  self traversemode("gravity");
  self.a.movement = "stop";
  self.a.pose = "stand";
  self.a.alertness = "alert";
}