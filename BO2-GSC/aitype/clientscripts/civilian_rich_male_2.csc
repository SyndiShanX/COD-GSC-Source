/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_rich_male_2.csc
*************************************************************/

#include character\clientscripts\c_mul_civ_rich_male_2;
#include character\clientscripts\c_mul_civ_rich_male_2_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_rich_male_2::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_rich_male_2_2::main();
      break;
  }

  self._aitype = "Civilian_Rich_Male_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_rich_male_2::precache();
  character\clientscripts\c_mul_civ_rich_male_2_2::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}