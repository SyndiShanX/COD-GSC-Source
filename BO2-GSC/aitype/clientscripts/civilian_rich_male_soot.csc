/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_rich_male_soot.csc
*******************************************************************/

#include character\clientscripts\c_mul_civ_rich_male_soot_1;
#include character\clientscripts\c_mul_civ_rich_male_soot_1_2;
#include character\clientscripts\c_mul_civ_rich_male_soot_2;
#include character\clientscripts\c_mul_civ_rich_male_soot_2_2;
#include character\clientscripts\c_mul_civ_rich_male_soot_3;
#include character\clientscripts\c_mul_civ_rich_male_soot_3_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_rich_male_soot_1::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_rich_male_soot_1_2::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_rich_male_soot_2::main();
      break;
    case 3:
      character\clientscripts\c_mul_civ_rich_male_soot_2_2::main();
      break;
    case 4:
      character\clientscripts\c_mul_civ_rich_male_soot_3::main();
      break;
    case 5:
      character\clientscripts\c_mul_civ_rich_male_soot_3_2::main();
      break;
  }

  self._aitype = "Civilian_Rich_Male_Soot";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_rich_male_soot_1::precache();
  character\clientscripts\c_mul_civ_rich_male_soot_1_2::precache();
  character\clientscripts\c_mul_civ_rich_male_soot_2::precache();
  character\clientscripts\c_mul_civ_rich_male_soot_2_2::precache();
  character\clientscripts\c_mul_civ_rich_male_soot_3::precache();
  character\clientscripts\c_mul_civ_rich_male_soot_3_2::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}