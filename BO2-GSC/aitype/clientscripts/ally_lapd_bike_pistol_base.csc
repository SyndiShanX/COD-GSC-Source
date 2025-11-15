/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_lapd_bike_pistol_base.csc
*************************************************************************/

#include character\clientscripts\c_usa_lapd_motocop;

main() {
  character\clientscripts\c_usa_lapd_motocop::main();
  self._aitype = "Ally_LAPD_Bike_Pistol_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_lapd_motocop::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}