/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_hillary_la.csc
****************************************************/

#include character\clientscripts\c_usa_hillaryclinton_g20_cin;

main() {
  character\clientscripts\c_usa_hillaryclinton_g20_cin::main();
  self._aitype = "Hero_Hillary_LA";
}

precache(ai_index) {
  character\clientscripts\c_usa_hillaryclinton_g20_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}