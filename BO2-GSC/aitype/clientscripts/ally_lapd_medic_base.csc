/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_lapd_medic_base.csc
*************************************************************/

#include character\clientscripts\c_usa_lapd_medic;

main() {
  character\clientscripts\c_usa_lapd_medic::main();
  self._aitype = "Ally_LAPD_Medic_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_lapd_medic::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}