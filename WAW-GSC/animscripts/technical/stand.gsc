/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: \animscripts\technical\stand.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "stand";
  animscripts\utility::UpdateAnimPose();
  self.a.movement = "stop";
  turret = self getTurret();
  turret thread turretInit(self);
  self.primaryTurretAnim = % technicalGunner_aim;
  self.additiveTurretIdle = % saw_gunner_idle;
  self.additiveTurretFire = % saw_gunner_firing_add;
  thread animscripts\saw\common::main(turret);
}

#using_animtree("mg42");

turretInit(owner) {
  self UseAnimTree(#animtree);
  self.additiveTurretIdle = % saw_gunner_idle_mg;
  self.additiveTurretFire = % saw_gunner_firing_mg_add;
  self endon("death");
  owner waittill("killanimscript");
  self stopUseAnimTree();
}