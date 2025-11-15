/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_lapd_drone_rigid.csc
***************************************************************/

#include character\clientscripts\c_usa_lapd_rigid_drone1;

main() {
  character\clientscripts\c_usa_lapd_rigid_drone1::main();
  self._aitype = "Ally_LAPD_Drone_Rigid";
}

precache(ai_index) {
  character\clientscripts\c_usa_lapd_rigid_drone1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}