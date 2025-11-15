/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_pilot_2.csc
*****************************************************/

#include character\clientscripts\c_mul_vtol_pilot2;

main() {
  character\clientscripts\c_mul_vtol_pilot2::main();
  self._aitype = "Civilian_Pilot_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_vtol_pilot2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}