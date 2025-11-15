/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_6.csc
*************************************************************/

#include character\clientscripts\c_mul_civ_club_male_rld_ds_vst;
#include character\clientscripts\c_mul_civ_club_male_ts;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_male_rld_ds_vst::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_male_ts::main();
      break;
  }

  self._aitype = "Civilian_Club_Male_6";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_rld_ds_vst::precache();
  character\clientscripts\c_mul_civ_club_male_ts::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}