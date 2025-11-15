/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_female_light_4.csc
*****************************************************************************/

#include character\clientscripts\c_mul_civ_club_female_light10;
#include character\clientscripts\c_mul_civ_club_skirt_pants;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_female_light10::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_skirt_pants::main();
      break;
  }

  self._aitype = "Civilian_Club_Female_Light_4";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_female_light10::precache();
  character\clientscripts\c_mul_civ_club_skirt_pants::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}