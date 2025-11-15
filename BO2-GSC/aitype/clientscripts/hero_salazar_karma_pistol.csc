/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_salazar_karma_pistol.csc
***********************************************************************/

#include character\clientscripts\c_usa_unioninsp_salazar_cin;

main() {
  character\clientscripts\c_usa_unioninsp_salazar_cin::main();
  self._aitype = "Hero_Salazar_Karma_Pistol";
}

precache(ai_index) {
  character\clientscripts\c_usa_unioninsp_salazar_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}