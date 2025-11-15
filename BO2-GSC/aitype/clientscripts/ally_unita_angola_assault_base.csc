/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_unita_angola_assault_base.csc
*********************************************************************************/

#include character\clientscripts\c_afr_unitas_1;
#include character\clientscripts\c_afr_unitas_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_afr_unitas_1::main();
      break;
    case 1:
      character\clientscripts\c_afr_unitas_2::main();
      break;
  }

  self._aitype = "Ally_UNITA_Angola_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_afr_unitas_1::precache();
  character\clientscripts\c_afr_unitas_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}