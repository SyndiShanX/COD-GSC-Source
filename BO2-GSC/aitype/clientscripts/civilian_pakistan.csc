/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_pakistan.csc
*******************************************************/

#include character\clientscripts\c_pak_civ_male_1;
#include character\clientscripts\c_pak_civ_male_2;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pak_civ_male_1::main();
      break;
    case 1:
      character\clientscripts\c_pak_civ_male_2::main();
      break;
  }

  self._aitype = "Civilian_Pakistan";
}

precache(ai_index) {
  character\clientscripts\c_pak_civ_male_1::precache();
  character\clientscripts\c_pak_civ_male_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}