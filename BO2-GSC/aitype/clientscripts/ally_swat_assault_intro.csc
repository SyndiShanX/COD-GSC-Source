/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_swat_assault_intro.csc
*******************************************************************/

#include character\clientscripts\c_usa_secserv_swat_tactical;

main() {
  character\clientscripts\c_usa_secserv_swat_tactical::main();
  self._aitype = "Ally_SWAT_Assault_Intro";
}

precache(ai_index) {
  character\clientscripts\c_usa_secserv_swat_tactical::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}