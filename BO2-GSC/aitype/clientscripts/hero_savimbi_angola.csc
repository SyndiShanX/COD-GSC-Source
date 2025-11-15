/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_savimbi_angola.csc
***********************************************************/

#include character\clientscripts\c_afr_savimbi;

main() {
  character\clientscripts\c_afr_savimbi::main();
  self._aitype = "Hero_Savimbi_Angola";
}

precache(ai_index) {
  character\clientscripts\c_afr_savimbi::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}