/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_pilot_1.csc
*****************************************************/

#include character\clientscripts\c_mul_vtol_pilot1;

main() {
  character\clientscripts\c_mul_vtol_pilot1::main();
  self._aitype = "Civilian_Pilot_1";
}

precache(ai_index) {
  character\clientscripts\c_mul_vtol_pilot1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}