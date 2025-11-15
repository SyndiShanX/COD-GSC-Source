/***********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pmc_monsoon_sniper_base_w.csc
***********************************************************************************/

#include character\clientscripts\c_mul_pmc_1_wt;

main() {
  character\clientscripts\c_mul_pmc_1_wt::main();
  self._aitype = "Enemy_PMC_Monsoon_Sniper_Base_W";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_1_wt::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}