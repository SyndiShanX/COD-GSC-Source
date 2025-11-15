/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pmc_monsoon_lmg_base.csc
*************************************************************************/

#include character\clientscripts\c_mul_pmc_1_freeze;

main() {
  character\clientscripts\c_mul_pmc_1_freeze::main();
  self._aitype = "Enemy_PMC_Monsoon_LMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_1_freeze::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}