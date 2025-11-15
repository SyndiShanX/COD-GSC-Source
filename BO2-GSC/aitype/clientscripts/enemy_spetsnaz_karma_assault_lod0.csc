/***************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_spetsnaz_karma_assault_lod0.csc
***************************************************************************************/

#include character\clientscripts\c_mul_pmc_undercover_a;

main() {
  character\clientscripts\c_mul_pmc_undercover_a::main();
  self._aitype = "Enemy_Spetsnaz_Karma_Assault_LOD0";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_undercover_a::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}