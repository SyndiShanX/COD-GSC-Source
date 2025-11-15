/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pmc_karma_lmg_base.csc
*********************************************************************/

#include character\clientscripts\c_mul_pmc_1_ol;

main() {
  character\clientscripts\c_mul_pmc_1_ol::main();
  self._aitype = "Enemy_PMC_Karma_LMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_1_ol::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}