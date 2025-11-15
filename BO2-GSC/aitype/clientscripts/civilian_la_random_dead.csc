/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_la_random_dead.csc
*******************************************************************/

#include character\clientscripts\c_mul_civ_rich_female_shot_1;
#include character\clientscripts\c_mul_civ_rich_female_shot_2;
#include character\clientscripts\c_mul_civ_rich_male_shot_1;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_rich_female_shot_1::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_rich_female_shot_2::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_rich_male_shot_1::main();
      break;
  }

  self._aitype = "Civilian_LA_Random_Dead";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_rich_female_shot_1::precache();
  character\clientscripts\c_mul_civ_rich_female_shot_2::precache();
  character\clientscripts\c_mul_civ_rich_male_shot_1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}