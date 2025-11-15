/*************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_panama_assault_zodiac1.csc
*************************************************************************************/

#include character\clientscripts\c_usa_seal80s_heavy;

main() {
  character\clientscripts\c_usa_seal80s_heavy::main();
  self._aitype = "Ally_SEAL_Panama_Assault_Zodiac1";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal80s_heavy::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}