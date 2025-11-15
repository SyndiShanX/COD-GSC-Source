/***********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_navy_blackout_cinematicrig.csc
***********************************************************************************/

#include character\clientscripts\c_usa_navy_3_cin;

main() {
  character\clientscripts\c_usa_navy_3_cin::main();
  self._aitype = "Ally_Navy_Blackout_CinematicRig";
}

precache(ai_index) {
  character\clientscripts\c_usa_navy_3_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}