/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_haiti.csc
***********************************************************/

#include character\clientscripts\c_mul_menendez_old_seal6;

main() {
  character\clientscripts\c_mul_menendez_old_seal6::main();
  self._aitype = "Hero_Menendez_Haiti";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_old_seal6::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}