/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\zm_tomb_giant_robot.csc
***********************************************************/

#include character\clientscripts\c_zom_giant_robot;

main() {
  character\clientscripts\c_zom_giant_robot::main();
  self._aitype = "zm_tomb_giant_robot";
}

#using_animtree("zm_tomb_giant_robot");

precache(ai_index) {
  character\clientscripts\c_zom_giant_robot::precache();
  usefootsteptable(ai_index, "default_ai");
  precacheanimstatedef(ai_index, #animtree, "zm_tomb_giant_robot");
  setdemolockonvalues(ai_index, 100, 60, -15, 60, 30, -5, 60);
}