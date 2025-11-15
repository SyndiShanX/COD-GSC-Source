/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_3.csc
*************************************************************/

#include character\clientscripts\c_mul_civ_club_male_jckt_ts;

main() {
  character\clientscripts\c_mul_civ_club_male_jckt_ts::main();
  self._aitype = "Civilian_Club_Male_3";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_jckt_ts::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}