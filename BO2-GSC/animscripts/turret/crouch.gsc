/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\turret\crouch.gsc
*****************************************/

#include animscripts\turret\turret;

main() {
  self.desired_anim_pose = "crouch";
  self.a.movement = "stop";
  self thread animscripts\turret\turret::main();
}