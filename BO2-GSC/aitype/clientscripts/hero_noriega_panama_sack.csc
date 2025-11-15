/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_noriega_panama_sack.csc
*********************************************************************/

#include character\clientscripts\c_pan_noriega_casual_sack;

main() {
  character\clientscripts\c_pan_noriega_casual_sack::main();
  self._aitype = "Hero_Noriega_Panama_Sack";
}

precache(ai_index) {
  character\clientscripts\c_pan_noriega_casual_sack::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}