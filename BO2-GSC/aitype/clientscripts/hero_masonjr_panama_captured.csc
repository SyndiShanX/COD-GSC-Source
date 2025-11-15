/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_masonjr_panama_captured.csc
*****************************************************************************/

#include character\clientscripts\c_usa_masonjr_child;

main() {
  character\clientscripts\c_usa_masonjr_child::main();
  self._aitype = "Hero_MasonJR_Panama_Captured";
}

precache(ai_index) {
  character\clientscripts\c_usa_masonjr_child::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}