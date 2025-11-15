/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_la_random_light.csc
*********************************************************************/

#include character\clientscripts\c_mul_civ_club_female_light1;
#include character\clientscripts\c_mul_civ_club_female_light2;
#include character\clientscripts\c_mul_civ_club_female_light3;
#include character\clientscripts\c_mul_civ_club_female_light10;
#include character\clientscripts\c_mul_civ_club_male_light1;
#include character\clientscripts\c_mul_civ_club_male_light7;
#include character\clientscripts\c_mul_civ_club_male_light9;
#include character\clientscripts\c_mul_civ_club_male_light11;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_female_light1::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_female_light2::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_club_female_light3::main();
      break;
    case 3:
      character\clientscripts\c_mul_civ_club_female_light10::main();
      break;
    case 4:
      character\clientscripts\c_mul_civ_club_male_light1::main();
      break;
    case 5:
      character\clientscripts\c_mul_civ_club_male_light7::main();
      break;
    case 6:
      character\clientscripts\c_mul_civ_club_male_light9::main();
      break;
    case 7:
      character\clientscripts\c_mul_civ_club_male_light11::main();
      break;
  }

  self._aitype = "Civilian_LA_Random_Light";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_female_light1::precache();
  character\clientscripts\c_mul_civ_club_female_light2::precache();
  character\clientscripts\c_mul_civ_club_female_light3::precache();
  character\clientscripts\c_mul_civ_club_female_light10::precache();
  character\clientscripts\c_mul_civ_club_male_light1::precache();
  character\clientscripts\c_mul_civ_club_male_light7::precache();
  character\clientscripts\c_mul_civ_club_male_light9::precache();
  character\clientscripts\c_mul_civ_club_male_light11::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}