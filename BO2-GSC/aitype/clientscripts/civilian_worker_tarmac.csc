/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_worker_tarmac.csc
*****************************************************************/

#include character\clientscripts\c_mul_jinan_baghandler;

main() {
  character\clientscripts\c_mul_jinan_baghandler::main();
  self._aitype = "Civilian_Worker_Tarmac";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_baghandler::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}