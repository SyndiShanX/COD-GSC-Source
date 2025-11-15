/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_salazar_pakistan.csc
***************************************************************/

#include character\clientscripts\c_usa_cia_combat_salazar_wt;

main() {
  character\clientscripts\c_usa_cia_combat_salazar_wt::main();
  self._aitype = "Hero_Salazar_Pakistan";
}

precache(ai_index) {
  character\clientscripts\c_usa_cia_combat_salazar_wt::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}