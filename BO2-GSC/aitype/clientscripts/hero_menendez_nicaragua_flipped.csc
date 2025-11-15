/***********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_nicaragua_flipped.csc
***********************************************************************************/

#include character\clientscripts\c_mul_menendez_young_scar_flipped;

main() {
  character\clientscripts\c_mul_menendez_young_scar_flipped::main();
  self._aitype = "Hero_Menendez_Nicaragua_Flipped";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_young_scar_flipped::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}