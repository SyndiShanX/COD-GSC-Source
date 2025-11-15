/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_secretary_la.csc
*******************************************************/

#include character\clientscripts\c_usa_gov_tressec_cin;

main() {
  character\clientscripts\c_usa_gov_tressec_cin::main();
  self._aitype = "Hero_Secretary_LA";
}

precache(ai_index) {
  character\clientscripts\c_usa_gov_tressec_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}