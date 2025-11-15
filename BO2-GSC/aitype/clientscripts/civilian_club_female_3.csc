/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_female_3.csc
*****************************************************************/

#include character\clientscripts\c_mul_civ_club_short_dress1;
#include character\clientscripts\c_mul_civ_club_short_dress2;
#include character\clientscripts\c_mul_civ_club_short_dress3;
#include character\clientscripts\c_mul_civ_club_short_dress4;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_short_dress1::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_short_dress2::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_club_short_dress3::main();
      break;
    case 3:
      character\clientscripts\c_mul_civ_club_short_dress4::main();
      break;
  }

  self._aitype = "Civilian_Club_Female_3";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_short_dress1::precache();
  character\clientscripts\c_mul_civ_club_short_dress2::precache();
  character\clientscripts\c_mul_civ_club_short_dress3::precache();
  character\clientscripts\c_mul_civ_club_short_dress4::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}