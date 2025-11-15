/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\ladder_up.gsc
**********************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;
#include animscripts\utility;
#include animscripts\shared;
#include animscripts\run;
#using_animtree("generic_human");

main() {
  preparefortraverse();
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("noclip");
  startanim = animarray("ladder_start", "move");
  climbanim = animarray("ladder_climb", "move");
  endanim = animarray("ladder_end", "move");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self animscripts\traverse\shared::traversestartragdolldeath();
  self setflaggedanimknoballrestart("climbanim", startanim, % body, 1, 0.1, 1);
  self animscripts\shared::donotetracks("climbanim");
  self setflaggedanimknoballrestart("climbanim", climbanim, % body, 1, 0.1, 1);
  endanimdelta = getmovedelta(endanim, 0, 1);
  endnode = self getnegotiationendnode();
  assert(isDefined(endnode));
  endpos = endnode.origin - endanimdelta + (0, 0, 1);
  cycledelta = getmovedelta(climbanim, 0, 1);
  climbrate = cycledelta[2] / getanimlength(climbanim);
  climbingtime = (endpos[2] - self.origin[2]) / climbrate;

  if(climbingtime > 0) {
    self animscripts\shared::donotetracksfortime(climbingtime, "climbanim");
    self setflaggedanimknoballrestart("climbanim", endanim, % body, 1, 0.1, 1);
    self animscripts\shared::donotetracks("climbanim");
  }

  self animscripts\traverse\shared::traversestopragdolldeath();
  self traversemode("gravity");
  self.a.movement = "run";
  self.a.pose = "crouch";
  self.a.alertness = "alert";
  self setanimknoballrestart(animscripts\run::getcrouchrunanim(), % body, 1, 0.1, 1);
}