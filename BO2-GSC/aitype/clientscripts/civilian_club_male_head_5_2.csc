/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_head_5_2.csc
***************************************************************************/

#include character\clientscripts\c_mul_civ_club_male_ls_vst_h5;
#include character\clientscripts\c_mul_civ_club_male_ms_h5;
#include character\clientscripts\c_mul_civ_club_male_ms_vst_h5;
#include character\clientscripts\c_mul_civ_club_male_rld_ds_vst_h5;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_male_ls_vst_h5::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_male_ms_h5::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_club_male_ms_vst_h5::main();
      break;
    case 3:
      character\clientscripts\c_mul_civ_club_male_rld_ds_vst_h5::main();
      break;
  }

  self._aitype = "Civilian_Club_Male_Head_5_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_ls_vst_h5::precache();
  character\clientscripts\c_mul_civ_club_male_ms_h5::precache();
  character\clientscripts\c_mul_civ_club_male_ms_vst_h5::precache();
  character\clientscripts\c_mul_civ_club_male_rld_ds_vst_h5::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}