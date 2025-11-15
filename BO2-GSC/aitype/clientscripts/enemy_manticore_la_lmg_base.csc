/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_manticore_la_lmg_base.csc
***************************************************************************/

#include character\clientscripts\c_mul_pmc_1;

main() {
  character\clientscripts\c_mul_pmc_1::main();
  self._aitype = "Enemy_Manticore_LA_LMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}