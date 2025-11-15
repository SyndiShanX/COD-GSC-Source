/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_it_manager_karma.csc
***********************************************************************/

#include character\clientscripts\c_mul_jinan_it_highres;

main() {
  character\clientscripts\c_mul_jinan_it_highres::main();
  self._aitype = "Civilian_IT_Manager_Karma";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_it_highres::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}