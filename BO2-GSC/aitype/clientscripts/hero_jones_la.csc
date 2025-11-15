/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_jones_la.csc
**************************************************/

#include character\clientscripts\c_usa_secserv_jones;

main() {
  character\clientscripts\c_usa_secserv_jones::main();
  self._aitype = "Hero_Jones_LA";
}

precache(ai_index) {
  character\clientscripts\c_usa_secserv_jones::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}