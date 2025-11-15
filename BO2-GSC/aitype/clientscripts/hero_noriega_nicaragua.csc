/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_noriega_nicaragua.csc
*****************************************************************/

#include character\clientscripts\c_pan_noriega_military;

main() {
  character\clientscripts\c_pan_noriega_military::main();
  self._aitype = "Hero_Noriega_Nicaragua";
}

precache(ai_index) {
  character\clientscripts\c_pan_noriega_military::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}