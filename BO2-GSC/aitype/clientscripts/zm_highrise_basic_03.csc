/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\zm_highrise_basic_03.csc
*************************************************************/

#include character\clientscripts\c_zom_zombie_soldier;

main() {
  character\clientscripts\c_zom_zombie_soldier::main();
  self._aitype = "zm_highrise_basic_03";
}

#using_animtree("zm_highrise_basic");

precache(ai_index) {
  character\clientscripts\c_zom_zombie_soldier::precache();
  usefootsteptable(ai_index, "default_ai");
  precacheanimstatedef(ai_index, #animtree, "zm_highrise_basic");
  setdemolockonvalues(ai_index, 100, 60, -15, 60, 30, -5, 60);
}