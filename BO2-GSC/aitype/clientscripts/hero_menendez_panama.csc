/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_panama.csc
*************************************************************/

#include character\clientscripts\c_mul_menendez_drugged;

main() {
  character\clientscripts\c_mul_menendez_drugged::main();
  self._aitype = "Hero_Menendez_Panama";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_drugged::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}