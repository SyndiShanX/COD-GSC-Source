/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_haiti_girl.csc
***********************************************************/

#include character\clientscripts\c_mul_civ_haitian_girl1;

main() {
  character\clientscripts\c_mul_civ_haitian_girl1::main();
  self._aitype = "Civilian_Haiti_Girl";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_haitian_girl1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}