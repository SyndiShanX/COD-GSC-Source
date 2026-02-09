/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_moon_gravity\.csc
*************************************************/

#include clientscripts\_utility;
#include clientscripts\_zombiemode;

init() {
  level.low_gravity_default = -136;
}
zombie_low_gravity(local_client_num, set, newEnt) {
  self endon("death");
  self endon("entityshutdown");
  if(set) {
    self SetPhysicsGravity(level.low_gravity_default);
    self.in_low_g = true;
  } else {
    self ClearPhysicsGravity();
    self.in_low_g = false;
  }
}