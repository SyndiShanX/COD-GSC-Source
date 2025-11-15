/***************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_infantry_panama_assault_base.csc
***************************************************************************************/

#include character\clientscripts\c_usa_7thinf_1;

main() {
  character\clientscripts\c_usa_7thinf_1::main();
  self._aitype = "Ally_Infantry_Panama_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_7thinf_1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}