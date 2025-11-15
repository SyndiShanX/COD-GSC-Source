/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_swat_assault_intro_la2.csc
***************************************************************************/

#include character\clientscripts\c_usa_secserv_light;

main() {
  character\clientscripts\c_usa_secserv_light::main();
  self._aitype = "Ally_SWAT_Assault_Intro_LA2";
}

precache(ai_index) {
  character\clientscripts\c_usa_secserv_light::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}