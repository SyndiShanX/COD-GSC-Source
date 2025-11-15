/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_hudson_nicaragua.csc
***************************************************************/

#include character\clientscripts\c_usa_nicaragua_hudson;

main() {
  character\clientscripts\c_usa_nicaragua_hudson::main();
  self._aitype = "Hero_Hudson_Nicaragua";
}

precache(ai_index) {
  character\clientscripts\c_usa_nicaragua_hudson::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}