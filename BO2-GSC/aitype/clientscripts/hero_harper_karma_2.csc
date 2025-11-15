/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_harper_karma_2.csc
***********************************************************/

#include character\clientscripts\c_usa_unioninsp_harper_cin;

main() {
  character\clientscripts\c_usa_unioninsp_harper_cin::main();
  self._aitype = "Hero_Harper_Karma_2";
}

precache(ai_index) {
  character\clientscripts\c_usa_unioninsp_harper_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}