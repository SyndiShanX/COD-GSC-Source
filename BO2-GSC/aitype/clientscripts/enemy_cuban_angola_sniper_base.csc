/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_cuban_angola_sniper_base.csc
*********************************************************************************/

#include character\clientscripts\c_mul_cuban_forces_1;
#include character\clientscripts\c_mul_cuban_forces_2;
#include character\clientscripts\c_mul_cuban_forces_3;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_cuban_forces_1::main();
      break;
    case 1:
      character\clientscripts\c_mul_cuban_forces_2::main();
      break;
    case 2:
      character\clientscripts\c_mul_cuban_forces_3::main();
      break;
  }

  self._aitype = "Enemy_Cuban_Angola_Sniper_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_cuban_forces_1::precache();
  character\clientscripts\c_mul_cuban_forces_2::precache();
  character\clientscripts\c_mul_cuban_forces_3::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}