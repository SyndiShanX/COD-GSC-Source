/*******************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pmc_monsoon_shotgun_camo_base.csc
*******************************************************************************************/

#include character\clientscripts\c_mul_pmc_cloak;

main() {
  character\clientscripts\c_mul_pmc_cloak::main();
  self._aitype = "Enemy_PMC_Monsoon_Shotgun_Camo_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_cloak::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}