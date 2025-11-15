/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_crosby_pakistan.csc
*************************************************************/

#include character\clientscripts\c_usa_seal6_assault_crosby_wt;

main() {
  character\clientscripts\c_usa_seal6_assault_crosby_wt::main();
  self._aitype = "Hero_Crosby_Pakistan";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal6_assault_crosby_wt::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}