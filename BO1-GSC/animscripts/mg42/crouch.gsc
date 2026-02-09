/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\mg42\crouch.gsc
***************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "crouch";
  animscripts\utility::UpdateAnimPose();
  self.a.movement = "stop";
  turret = self getTurret();
  turret thread turretInit(self);
  self.primaryTurretAnim = % crouchSAWgunner_aim;
  self.additiveTurretIdle = % saw_gunner_lowwall_idle;
  self.additiveTurretFire = % saw_gunner_lowwall_firing;
  thread animscripts\saw\common::main(turret);
}
#using_animtree("mg42");
turretInit(owner) {
  self UseAnimTree(#animtree);
  self.additiveTurretIdle = % saw_gunner_lowwall_idle_mg;
  self.additiveTurretFire = % saw_gunner_lowwall_firing_mg;
  self endon("death");
  owner waittill("killanimscript");
  self stopUseAnimTree();
}