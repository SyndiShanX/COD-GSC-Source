/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_anderson_la.csc
*****************************************************/

#include character\clientscripts\c_usa_captain_anderson;

main() {
  character\clientscripts\c_usa_captain_anderson::main();
  self._aitype = "Hero_Anderson_LA";
}

precache(ai_index) {
  character\clientscripts\c_usa_captain_anderson::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}