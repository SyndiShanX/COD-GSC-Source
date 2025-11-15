/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_rich_female_2.csc
*****************************************************************/

#include character\clientscripts\c_mul_civ_rich_female_2;

main() {
  character\clientscripts\c_mul_civ_rich_female_2::main();
  self._aitype = "Civilian_Rich_Female_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_rich_female_2::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}