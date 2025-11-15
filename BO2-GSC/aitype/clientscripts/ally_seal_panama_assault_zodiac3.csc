/*************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_panama_assault_zodiac3.csc
*************************************************************************************/

#include character\clientscripts\c_usa_seal80s_medium;

main() {
  character\clientscripts\c_usa_seal80s_medium::main();
  self._aitype = "Ally_SEAL_Panama_Assault_Zodiac3";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal80s_medium::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}