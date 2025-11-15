/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_salazar_blackout.csc
***************************************************************/

#include character\clientscripts\c_usa_cia_combat_salazar;

main() {
  character\clientscripts\c_usa_cia_combat_salazar::main();
  self._aitype = "Hero_Salazar_Blackout";
}

precache(ai_index) {
  character\clientscripts\c_usa_cia_combat_salazar::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}