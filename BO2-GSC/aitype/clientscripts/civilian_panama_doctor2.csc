/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_panama_doctor2.csc
*******************************************************************/

#include character\clientscripts\c_mul_redcross_doctor2;

main() {
  character\clientscripts\c_mul_redcross_doctor2::main();
  self._aitype = "Civilian_Panama_Doctor2";
}

precache(ai_index) {
  character\clientscripts\c_mul_redcross_doctor2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}