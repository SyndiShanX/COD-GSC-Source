/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\jump_up_80.gsc
***********************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = var_0.traverse_height - var_0.origin[2];
  thread animscripts\traverse\shared::teleportthread(var_1 - 80);
  self clearanim( % animscript_root, 0.2);
  self setflaggedanimrestart("jump_up_80", anim.dogtraverseanims["jump_up_80"], 1, 0.2, 1);
  animscripts\shared::donotetracks("jump_up_80");
}