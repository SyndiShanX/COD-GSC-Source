/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_harper_haiti.csc
*******************************************************/

#include character\clientscripts\c_usa_cia_combat_harper_haiti_cin;

main() {
  character\clientscripts\c_usa_cia_combat_harper_haiti_cin::main();
  self._aitype = "Hero_Harper_Haiti";
}

precache(ai_index) {
  character\clientscripts\c_usa_cia_combat_harper_haiti_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}