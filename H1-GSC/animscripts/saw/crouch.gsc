/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\saw\crouch.gsc
********************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self.a.movement = "stop";
  var_0 = self getturret();
  var_0 thread turretinit(self);
  self.primaryturretanim = % crouchsawgunner_aim;
  self.additiveturretidle = % saw_gunner_lowwall_idle;
  self.additiveturretfire = % saw_gunner_lowwall_firing;
  thread animscripts\saw\common::main(var_0);
}

#using_animtree("mg42");

turretinit(var_0) {
  self useanimtree(#animtree);
  self.additiveturretidle = % saw_gunner_lowwall_idle_mg;
  self.additiveturretfire = % saw_gunner_lowwall_firing_mg;
  self endon("death");
  var_0 waittill("killanimscript");
  self stopuseanimtree();
}