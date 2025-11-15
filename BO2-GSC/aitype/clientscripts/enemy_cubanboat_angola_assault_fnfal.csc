/*********************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_cubanboat_angola_assault_fnfal.csc
*********************************************************************************************/

#include character\clientscripts\c_afr_mpla_1;
#include character\clientscripts\c_afr_mpla_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_afr_mpla_1::main();
      break;
    case 1:
      character\clientscripts\c_afr_mpla_2::main();
      break;
  }

  self._aitype = "Enemy_CubanBoat_Angola_Assault_fnfal";
}

precache(ai_index) {
  character\clientscripts\c_afr_mpla_1::precache();
  character\clientscripts\c_afr_mpla_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}