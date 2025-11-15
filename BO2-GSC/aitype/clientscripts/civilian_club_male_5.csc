/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_5.csc
*************************************************************/

#include character\clientscripts\c_mul_civ_club_male_ms;
#include character\clientscripts\c_mul_civ_club_male_ms_vst;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_male_ms::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_male_ms_vst::main();
      break;
  }

  self._aitype = "Civilian_Club_Male_5";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_ms::precache();
  character\clientscripts\c_mul_civ_club_male_ms_vst::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}