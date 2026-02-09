/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\mg42\prone.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "prone";
  animscripts\utility::UpdateAnimPose();
  self.a.movement = "stop";
  turret = self getTurret();
  turret thread turretInit(self);
  self.primaryTurretAnim = % proneSAWgunner_aim;
  self.additiveTurretIdle = % saw_gunner_prone_idle;
  self.additiveTurretFire = % saw_gunner_prone_firing;
  thread animscripts\saw\common::main(turret);
}
#using_animtree("mg42");
turretInit(owner) {
  self UseAnimTree(#animtree);
  self.additiveTurretIdle = % saw_gunner_prone_idle_mg;
  self.additiveTurretFire = % saw_gunner_prone_firing_mg;
  self endon("death");
  owner waittill("killanimscript");
  self stopUseAnimTree();
}