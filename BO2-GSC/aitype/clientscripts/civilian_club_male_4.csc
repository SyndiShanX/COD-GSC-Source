/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_4.csc
*************************************************************/

#include character\clientscripts\c_mul_civ_club_male_ls;
#include character\clientscripts\c_mul_civ_club_male_ls_vst;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_male_ls::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_male_ls_vst::main();
      break;
  }

  self._aitype = "Civilian_Club_Male_4";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_ls::precache();
  character\clientscripts\c_mul_civ_club_male_ls_vst::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}