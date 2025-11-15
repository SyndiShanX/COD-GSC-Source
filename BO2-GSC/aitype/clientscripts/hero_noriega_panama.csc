/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_noriega_panama.csc
***********************************************************/

#include character\clientscripts\c_pan_noriega_casual;

main() {
  character\clientscripts\c_pan_noriega_casual::main();
  self._aitype = "Hero_Noriega_Panama";
}

precache(ai_index) {
  character\clientscripts\c_pan_noriega_casual::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}