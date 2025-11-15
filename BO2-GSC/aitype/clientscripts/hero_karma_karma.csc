/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_karma_karma.csc
*****************************************************/

#include character\clientscripts\c_usa_chloe_cin;

main() {
  character\clientscripts\c_usa_chloe_cin::main();
  self._aitype = "Hero_Karma_Karma";
}

precache(ai_index) {
  character\clientscripts\c_usa_chloe_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}