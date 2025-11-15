/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_mason_la.csc
**************************************************/

#include character\clientscripts\c_usa_cia_combat_masonjr;

main() {
  character\clientscripts\c_usa_cia_combat_masonjr::main();
  self._aitype = "Hero_Mason_LA";
}

precache(ai_index) {
  character\clientscripts\c_usa_cia_combat_masonjr::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}