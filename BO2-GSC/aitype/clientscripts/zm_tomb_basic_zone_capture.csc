/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\zm_tomb_basic_zone_capture.csc
*************************************************************************/

#include character\clientscripts\c_zom_tomb_crusader_zc;

main() {
  character\clientscripts\c_zom_tomb_crusader_zc::main();
  self._aitype = "zm_tomb_basic_zone_capture";
}

#using_animtree("zm_tomb_basic");

precache(ai_index) {
  character\clientscripts\c_zom_tomb_crusader_zc::precache();
  usefootsteptable(ai_index, "fly_step_crusader");
  precacheanimstatedef(ai_index, #animtree, "zm_tomb_basic");
  setdemolockonvalues(ai_index, 100, 60, -15, 60, 30, -5, 60);
}