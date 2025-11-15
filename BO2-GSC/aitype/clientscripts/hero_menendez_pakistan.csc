/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_pakistan.csc
*****************************************************************/

#include character\clientscripts\c_mul_menendez_suit;

main() {
  character\clientscripts\c_mul_menendez_suit::main();
  self._aitype = "Hero_Menendez_Pakistan";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_suit::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}