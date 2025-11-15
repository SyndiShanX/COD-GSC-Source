/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_cartel_lmg_base.csc
***************************************************************/

#include character\clientscripts\c_mul_cartel1_1_char;
#include character\clientscripts\c_mul_cartel1_2_char;
#include character\clientscripts\c_mul_cartel1_3_char;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_cartel1_1_char::main();
      break;
    case 1:
      character\clientscripts\c_mul_cartel1_2_char::main();
      break;
    case 2:
      character\clientscripts\c_mul_cartel1_3_char::main();
      break;
  }

  self._aitype = "Enemy_Cartel_LMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_cartel1_1_char::precache();
  character\clientscripts\c_mul_cartel1_2_char::precache();
  character\clientscripts\c_mul_cartel1_3_char::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}