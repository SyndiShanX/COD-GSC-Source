/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_across_100.gsc
****************************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_long_jump("window_40", 20);
    return;
  }

  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = [];
  var_1[0] = % jump_across_100_spring;
  var_1[1] = % jump_across_100_lunge;
  var_1[2] = % jump_across_100_stumble;
  var_2 = var_1[randomint(var_1.size)];
  self setflaggedanimknoballrestart("jumpanim", var_2, % body, 1, 0.1, 1);
  animscripts\shared::donotetracks("jumpanim");
}