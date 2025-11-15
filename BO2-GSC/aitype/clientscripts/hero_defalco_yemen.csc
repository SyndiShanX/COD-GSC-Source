/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_defalco_yemen.csc
*********************************************************/

#include character\clientscripts\c_mul_yemen_defalco;

main() {
  character\clientscripts\c_mul_yemen_defalco::main();
  self._aitype = "Hero_Defalco_Yemen";
}

precache(ai_index) {
  character\clientscripts\c_mul_yemen_defalco::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}