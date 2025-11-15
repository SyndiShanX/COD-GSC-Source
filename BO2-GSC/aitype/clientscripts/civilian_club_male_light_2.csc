/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_light_2.csc
*************************************************************************/

#include character\clientscripts\c_mul_civ_club_male_light7;
#include character\clientscripts\c_mul_civ_club_male_light8;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_male_light7::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_male_light8::main();
      break;
  }

  self._aitype = "Civilian_Club_Male_Light_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_light7::precache();
  character\clientscripts\c_mul_civ_club_male_light8::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}