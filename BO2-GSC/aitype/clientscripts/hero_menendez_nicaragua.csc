/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_nicaragua.csc
*******************************************************************/

#include character\clientscripts\c_mul_menendez_young_scar;

main() {
  character\clientscripts\c_mul_menendez_young_scar::main();
  self._aitype = "Hero_Menendez_Nicaragua";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_young_scar::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}