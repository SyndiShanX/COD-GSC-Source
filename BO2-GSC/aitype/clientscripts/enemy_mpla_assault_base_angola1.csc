/***********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_mpla_assault_base_angola1.csc
***********************************************************************************/

#include character\clientscripts\c_afr_mpla_2;

main() {
  character\clientscripts\c_afr_mpla_2::main();
  self._aitype = "Enemy_MPLA_Assault_Base_Angola1";
}

precache(ai_index) {
  character\clientscripts\c_afr_mpla_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}