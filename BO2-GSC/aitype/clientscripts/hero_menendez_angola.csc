/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_angola.csc
*************************************************************/

#include character\clientscripts\c_mul_menendez_young;

main() {
  character\clientscripts\c_mul_menendez_young::main();
  self._aitype = "Hero_Menendez_Angola";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_young::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}