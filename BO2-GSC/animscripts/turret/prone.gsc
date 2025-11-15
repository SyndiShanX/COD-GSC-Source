/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\turret\prone.gsc
****************************************/

#include animscripts\turret\turret;

main() {
  self.desired_anim_pose = "prone";
  self.a.movement = "stop";
  self thread animscripts\turret\turret::main();
}