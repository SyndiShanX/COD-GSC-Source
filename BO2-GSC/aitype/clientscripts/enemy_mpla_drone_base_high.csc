/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_mpla_drone_base_high.csc
*************************************************************************/

#include character\clientscripts\c_afr_mpla_rigid_drone_wgun;

main() {
  character\clientscripts\c_afr_mpla_rigid_drone_wgun::main();
  self._aitype = "Enemy_MPLA_Drone_Base_High";
}

precache(ai_index) {
  character\clientscripts\c_afr_mpla_rigid_drone_wgun::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}