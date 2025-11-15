/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_worker_construction.csc
*****************************************************************************/

#include character\clientscripts\c_mul_jinan_demoworker_bscatter_off;

main() {
  character\clientscripts\c_mul_jinan_demoworker_bscatter_off::main();
  self._aitype = "Civilian_Worker_Construction";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_demoworker_bscatter_off::precache();
  usefootsteptable(ai_index, "fly_step_civm");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}