/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_rich_female_4.csc
*****************************************************************/

#include character\clientscripts\c_mul_civ_rich_female_4;

main() {
  character\clientscripts\c_mul_civ_rich_female_4::main();
  self._aitype = "Civilian_Rich_Female_4";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_rich_female_4::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}