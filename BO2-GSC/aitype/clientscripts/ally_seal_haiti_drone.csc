/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_haiti_drone.csc
***************************************************************/

#include character\clientscripts\c_usa_seal6_drone1;

main() {
  character\clientscripts\c_usa_seal6_drone1::main();
  self._aitype = "Ally_SEAL_Haiti_Drone";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal6_drone1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}