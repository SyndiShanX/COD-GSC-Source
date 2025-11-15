/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_debug.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_utility_raven;

main() {}
zombie_temple_devgui(cmd) {}
_zombie_DelaySetHealth(delay) {
  self endon("death");
  if(!isDefined(delay)) {
    delay = 0.5;
  }
  wait(delay);
  health = 2000;
  self.maxhealth = health;
  self.health = health;
}