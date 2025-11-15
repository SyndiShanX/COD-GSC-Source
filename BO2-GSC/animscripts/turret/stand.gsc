/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\turret\stand.gsc
****************************************/

#include animscripts\turret\turret;

main() {
  self.desired_anim_pose = "stand";
  self.a.movement = "stop";
  self thread animscripts\turret\turret::main();
}