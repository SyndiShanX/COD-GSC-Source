/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_worker_office_1.csc
*********************************************************************/

#include character\clientscripts\c_mul_jinan_genworker_a;

main() {
  character\clientscripts\c_mul_jinan_genworker_a::main();
  self._aitype = "Civilian_Worker_Office_1";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_genworker_a::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}