/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_female_light_3.csc
*****************************************************************************/

#include character\clientscripts\c_mul_civ_club_female_light6;
#include character\clientscripts\c_mul_civ_club_female_light7;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_female_light6::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_female_light7::main();
      break;
  }

  self._aitype = "Civilian_Club_Female_Light_3";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_female_light6::precache();
  character\clientscripts\c_mul_civ_club_female_light7::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}