/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_worker_receptionist_1.csc
*********************************************************************************/

#include character\clientscripts\c_mul_al_jinan_receptionist1;

main() {
  character\clientscripts\c_mul_al_jinan_receptionist1::main();
  self._aitype = "Civilian_Worker_Receptionist_1";
}

precache(ai_index) {
  character\clientscripts\c_mul_al_jinan_receptionist1::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}