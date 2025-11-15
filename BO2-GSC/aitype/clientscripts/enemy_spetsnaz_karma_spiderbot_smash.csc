/*********************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_spetsnaz_karma_spiderbot_smash.csc
*********************************************************************************************/

#include character\clientscripts\c_mul_pmc_undercover_a;

main() {
  character\clientscripts\c_mul_pmc_undercover_a::main();
  self._aitype = "Enemy_Spetsnaz_Karma_Spiderbot_Smash";
}

precache(ai_index) {
  character\clientscripts\c_mul_pmc_undercover_a::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}