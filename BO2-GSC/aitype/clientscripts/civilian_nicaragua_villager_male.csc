/*************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_nicaragua_villager_male.csc
*************************************************************************************/

#include character\clientscripts\c_pan_civ_male_1;
#include character\clientscripts\c_pan_civ_male_2;
#include character\clientscripts\c_pan_civ_male_3;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pan_civ_male_1::main();
      break;
    case 1:
      character\clientscripts\c_pan_civ_male_2::main();
      break;
    case 2:
      character\clientscripts\c_pan_civ_male_3::main();
      break;
  }

  self._aitype = "Civilian_Nicaragua_Villager_Male";
}

precache(ai_index) {
  character\clientscripts\c_pan_civ_male_1::precache();
  character\clientscripts\c_pan_civ_male_2::precache();
  character\clientscripts\c_pan_civ_male_3::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}