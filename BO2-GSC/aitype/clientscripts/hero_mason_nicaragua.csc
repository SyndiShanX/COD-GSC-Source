/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_mason_nicaragua.csc
*************************************************************/

#include character\clientscripts\c_usa_nicaragua_mason;

main() {
  character\clientscripts\c_usa_nicaragua_mason::main();
  self._aitype = "Hero_Mason_Nicaragua";
}

precache(ai_index) {
  character\clientscripts\c_usa_nicaragua_mason::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}