/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_worker_office.csc
*****************************************************************/

#include character\clientscripts\c_mul_jinan_genworker;

main() {
  character\clientscripts\c_mul_jinan_genworker::main();
  self._aitype = "Civilian_Worker_Office";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_genworker::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}