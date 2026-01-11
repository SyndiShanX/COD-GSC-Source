/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_2.gsc
*********************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_wall_and_window_hop("wallhop", 40);
  }
  else {
    advancedwindowtraverse( % windowclimb, 35);
  }
}

advancedwindowtraverse(var_0, var_1) {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2.traverse_height - var_2.origin[2];
  self setflaggedanimknoballrestart("traverse", var_0, % body, 1, 0.15, 1);
  wait 0.7;
  thread animscripts\traverse\shared::teleportthread(var_3 - var_1);
  wait 0.9;
  self traversemode("gravity");
  animscripts\shared::donotetracks("traverse");
}