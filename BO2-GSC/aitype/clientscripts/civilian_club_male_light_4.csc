/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_male_light_4.csc
*************************************************************************/

#include character\clientscripts\c_mul_civ_club_male_light12;

main() {
  character\clientscripts\c_mul_civ_club_male_light12::main();
  self._aitype = "Civilian_Club_Male_Light_4";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_male_light12::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}