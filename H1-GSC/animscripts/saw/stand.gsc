/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\saw\stand.gsc
********************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self.a.movement = "stop";
  var_0 = self getturret();
  var_0 thread turretinit(self);
  self.primaryturretanim = % standsawgunner_aim;
  self.additiveturretidle = % saw_gunner_idle;
  self.additiveturretfire = % saw_gunner_firing_add;
  thread animscripts\saw\common::main(var_0);
}

#using_animtree("mg42");

turretinit(var_0) {
  self useanimtree(#animtree);
  self.additiveturretidle = % saw_gunner_idle_mg;
  self.additiveturretfire = % saw_gunner_firing_mg_add;
  self endon("death");
  var_0 waittill("killanimscript");
  self stopuseanimtree();
}