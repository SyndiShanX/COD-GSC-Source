/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_terrorist_yemen_smg_base.csc
*********************************************************************************/

#include character\clientscripts\c_mul_cordis3_1;
#include character\clientscripts\c_mul_cordis1_2;
#include character\clientscripts\c_mul_cordis1_3;
#include character\clientscripts\c_mul_cordis1_4;
#include character\clientscripts\c_mul_cordis2_1;
#include character\clientscripts\c_mul_cordis2_2;
#include character\clientscripts\c_mul_cordis2_3;
#include character\clientscripts\c_mul_cordis2_4;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_cordis3_1::main();
      break;
    case 1:
      character\clientscripts\c_mul_cordis1_2::main();
      break;
    case 2:
      character\clientscripts\c_mul_cordis1_3::main();
      break;
    case 3:
      character\clientscripts\c_mul_cordis1_4::main();
      break;
    case 4:
      character\clientscripts\c_mul_cordis2_1::main();
      break;
    case 5:
      character\clientscripts\c_mul_cordis2_2::main();
      break;
    case 6:
      character\clientscripts\c_mul_cordis2_3::main();
      break;
    case 7:
      character\clientscripts\c_mul_cordis2_4::main();
      break;
  }

  self._aitype = "Enemy_Terrorist_Yemen_SMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_cordis3_1::precache();
  character\clientscripts\c_mul_cordis1_2::precache();
  character\clientscripts\c_mul_cordis1_3::precache();
  character\clientscripts\c_mul_cordis1_4::precache();
  character\clientscripts\c_mul_cordis2_1::precache();
  character\clientscripts\c_mul_cordis2_2::precache();
  character\clientscripts\c_mul_cordis2_3::precache();
  character\clientscripts\c_mul_cordis2_4::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}