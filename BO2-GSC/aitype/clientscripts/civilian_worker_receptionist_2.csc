/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_worker_receptionist_2.csc
*********************************************************************************/

#include character\clientscripts\c_mul_al_jinan_receptionist2;

main() {
  character\clientscripts\c_mul_al_jinan_receptionist2::main();
  self._aitype = "Civilian_Worker_Receptionist_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_al_jinan_receptionist2::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}