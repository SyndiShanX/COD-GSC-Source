/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_rich_female_shot.csc
***********************************************************************/

#include character\clientscripts\c_mul_civ_rich_female_shot_1;
#include character\clientscripts\c_mul_civ_rich_female_shot_2;
#include character\clientscripts\c_mul_civ_rich_female_shot_3;
#include character\clientscripts\c_mul_civ_rich_female_shot_4;
#include character\clientscripts\c_mul_civ_rich_female_shot_5;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_rich_female_shot_1::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_rich_female_shot_2::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_rich_female_shot_3::main();
      break;
    case 3:
      character\clientscripts\c_mul_civ_rich_female_shot_4::main();
      break;
    case 4:
      character\clientscripts\c_mul_civ_rich_female_shot_5::main();
      break;
  }

  self._aitype = "Civilian_Rich_Female_Shot";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_rich_female_shot_1::precache();
  character\clientscripts\c_mul_civ_rich_female_shot_2::precache();
  character\clientscripts\c_mul_civ_rich_female_shot_3::precache();
  character\clientscripts\c_mul_civ_rich_female_shot_4::precache();
  character\clientscripts\c_mul_civ_rich_female_shot_5::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}