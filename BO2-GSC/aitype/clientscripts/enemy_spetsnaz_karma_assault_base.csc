/***************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_spetsnaz_karma_assault_base.csc
***************************************************************************************/

#include character\clientscripts\c_mul_pmc_undercover_ol;

main() {
  character\clientscripts\c_mul_pmc_undercover_ol::main();
  self._aitype = "Enemy_Spetsnaz_Karma_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_undercover_ol::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}