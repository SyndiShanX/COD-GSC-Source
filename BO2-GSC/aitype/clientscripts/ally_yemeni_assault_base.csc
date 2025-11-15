/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_yemeni_assault_base.csc
*********************************************************************/

#include character\clientscripts\c_yem_repguard_1;
#include character\clientscripts\c_yem_repguard_2;
#include character\clientscripts\c_yem_repguard_3;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_yem_repguard_1::main();
      break;
    case 1:
      character\clientscripts\c_yem_repguard_2::main();
      break;
    case 2:
      character\clientscripts\c_yem_repguard_3::main();
      break;
  }

  self._aitype = "Ally_Yemeni_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_yem_repguard_1::precache();
  character\clientscripts\c_yem_repguard_2::precache();
  character\clientscripts\c_yem_repguard_3::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}