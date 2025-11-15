/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_menendez_blackout.csc
*****************************************************************/

#include character\clientscripts\c_mul_menendez_old_captured;

main() {
  character\clientscripts\c_mul_menendez_old_captured::main();
  self._aitype = "Hero_Menendez_Blackout";
}

precache(ai_index) {
  character\clientscripts\c_mul_menendez_old_captured::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}