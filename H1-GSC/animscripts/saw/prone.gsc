/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\saw\prone.gsc
********************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "prone";
  animscripts\utility::updateanimpose();
  self.a.movement = "stop";
  var_0 = self getturret();
  var_0 thread turretinit(self);
  self.primaryturretanim = % pronesawgunner_aim;
  self.additiveturretidle = % saw_gunner_prone_idle;
  self.additiveturretfire = % saw_gunner_prone_firing;
  thread animscripts\saw\common::main(var_0);
}

#using_animtree("mg42");

turretinit(var_0) {
  self useanimtree(#animtree);
  self.additiveturretidle = % saw_gunner_prone_idle_mg;
  self.additiveturretfire = % saw_gunner_prone_firing_mg;
  self endon("death");
  var_0 waittill("killanimscript");
  self stopuseanimtree();
}