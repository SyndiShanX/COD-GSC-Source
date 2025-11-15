/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_head_3.csc
***********************************************************************/

#include character\clientscripts\c_mul_civ_club_male_jckt_drsh_h3;
#include character\clientscripts\c_mul_civ_club_male_jckt_rld_ts_h3;
#include character\clientscripts\c_mul_civ_club_male_jckt_ts_h3;
#include character\clientscripts\c_mul_civ_club_male_ls_h3;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_club_male_jckt_drsh_h3::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_club_male_jckt_rld_ts_h3::main();
      break;
    case 2:
      character\clientscripts\c_mul_civ_club_male_jckt_ts_h3::main();
      break;
    case 3:
      character\clientscripts\c_mul_civ_club_male_ls_h3::main();
      break;
  }

  self._aitype = "Civilian_Club_Male_Head_3";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_jckt_drsh_h3::precache();
  character\clientscripts\c_mul_civ_club_male_jckt_rld_ts_h3::precache();
  character\clientscripts\c_mul_civ_club_male_jckt_ts_h3::precache();
  character\clientscripts\c_mul_civ_club_male_ls_h3::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}