/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_defalco_karma.csc
*********************************************************/

#include character\clientscripts\c_mul_defalco_karma_cin;

main() {
  character\clientscripts\c_mul_defalco_karma_cin::main();
  self._aitype = "Hero_Defalco_Karma";
}

precache(ai_index) {
  character\clientscripts\c_mul_defalco_karma_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}