/*********************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_nicaragua_cokeworker_female.csc
*********************************************************************************************/

#include character\clientscripts\c_mul_civ_cworker_female_1;
#include character\clientscripts\c_mul_civ_cworker_female_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_mul_civ_cworker_female_1::main();
      break;
    case 1:
      character\clientscripts\c_mul_civ_cworker_female_2::main();
      break;
  }

  self._aitype = "Civilian_Nicaragua_CokeWorker_Female";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_cworker_female_1::precache();
  character\clientscripts\c_mul_civ_cworker_female_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}