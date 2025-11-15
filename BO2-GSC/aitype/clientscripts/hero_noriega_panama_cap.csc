/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_noriega_panama_cap.csc
*******************************************************************/

#include character\clientscripts\c_pan_noriega_casual_cap;

main() {
  character\clientscripts\c_pan_noriega_casual_cap::main();
  self._aitype = "Hero_Noriega_Panama_Cap";
}

precache(ai_index) {
  character\clientscripts\c_pan_noriega_casual_cap::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}