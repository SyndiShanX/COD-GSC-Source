/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pmc_haiti_drone.csc
***************************************************************/

#include character\clientscripts\c_mul_pmc_drone_1;

main() {
  character\clientscripts\c_mul_pmc_drone_1::main();
  self._aitype = "Enemy_PMC_Haiti_Drone";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_drone_1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}