/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_up_80.gsc
***********************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\shared;
#using_animtree("dog");

main() {
  assert(self.isdog, "Only dogs can do this traverse currently.");
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  realheight = startnode.traverse_height - startnode.origin[2];
  self thread teleportthread(realheight - 80);
  self clearanim( % root, 0.2);
  self setflaggedanimrestart("jump_up_80", anim.dogtraverseanims["jump_up_80"], 1, 0.2, 1);
  self animscripts\shared::donotetracks("jump_up_80");
  self.traversecomplete = 1;
}