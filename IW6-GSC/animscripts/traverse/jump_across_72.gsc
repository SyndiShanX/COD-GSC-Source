/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_across_72.gsc
***************************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_long_jump("wallhop", 20);
    return;
  }

  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("jumpanim", %jump_across_72, %body, 1, 0.1, 1);
  self waittillmatch("jumpanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::donotetracks("jumpanim");
}