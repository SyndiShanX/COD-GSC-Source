/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_salazar_monsoon.csc
*************************************************************/

#include character\clientscripts\c_usa_seal6_assault_salazar_wt;

main() {
  character\clientscripts\c_usa_seal6_assault_salazar_wt::main();
  self._aitype = "Hero_Salazar_Monsoon";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal6_assault_salazar_wt::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}