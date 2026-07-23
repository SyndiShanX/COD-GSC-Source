/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\step_up.gsc
********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_up(40, 3);
  } else {
    step_up_human();
  }
}

#using_animtree("generic_human");

step_up_human() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self.a.movement = "walk";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", %step_up_low_wall, %body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::donotetracks("stepanim");
  self setanimknoballrestart(animscripts\run::getcrouchrunanim(), %body, 1, 0.1, 1);
}