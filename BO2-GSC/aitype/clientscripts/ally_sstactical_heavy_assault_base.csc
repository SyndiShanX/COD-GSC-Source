/*****************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_sstactical_heavy_assault_base.csc
*****************************************************************************************/

#include character\clientscripts\c_usa_secserv_heavy;

main() {
  character\clientscripts\c_usa_secserv_heavy::main();
  self._aitype = "Ally_SStactical_Heavy_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_secserv_heavy::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}