/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_digbat_smg_base.csc
***************************************************************/

#include character\clientscripts\c_pan_dingbats_1;
#include character\clientscripts\c_pan_dingbats_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pan_dingbats_1::main();
      break;
    case 1:
      character\clientscripts\c_pan_dingbats_2::main();
      break;
  }

  self._aitype = "Enemy_Digbat_SMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_pan_dingbats_1::precache();
  character\clientscripts\c_pan_dingbats_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}