/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_panama_nurse.csc
***************************************************************/

#include character\clientscripts\c_mul_redcross_nurse;

main() {
  character\clientscripts\c_mul_redcross_nurse::main();
  self._aitype = "Civilian_Panama_Nurse";
}

precache(ai_index) {
  character\clientscripts\c_mul_redcross_nurse::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}