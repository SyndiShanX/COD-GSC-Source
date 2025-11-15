/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_rts_yemen_male.csc
*******************************************************************/

#include character\clientscripts\c_yem_civilian_male;

main() {
  character\clientscripts\c_yem_civilian_male::main();
  self._aitype = "Civilian_RTS_YEMEN_Male";
}

precache(ai_index) {
  character\clientscripts\c_yem_civilian_male::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}