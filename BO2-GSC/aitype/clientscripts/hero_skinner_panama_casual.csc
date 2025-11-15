/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_skinner_panama_casual.csc
*************************************************************************/

#include character\clientscripts\c_usa_milcas_mcknight_cin;

main() {
  character\clientscripts\c_usa_milcas_mcknight_cin::main();
  self._aitype = "Hero_Skinner_Panama_Casual";
}

precache(ai_index) {
  character\clientscripts\c_usa_milcas_mcknight_cin::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}