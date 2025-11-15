/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_farid_blackout.csc
***********************************************************/

#include character\clientscripts\c_mul_farid_cc;

main() {
  character\clientscripts\c_mul_farid_cc::main();
  self._aitype = "Hero_Farid_Blackout";
}

precache(ai_index) {
  character\clientscripts\c_mul_farid_cc::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}