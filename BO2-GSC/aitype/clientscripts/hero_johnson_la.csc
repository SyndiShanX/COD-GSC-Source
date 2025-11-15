/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_johnson_la.csc
****************************************************/

#include character\clientscripts\c_usa_gov_presstaff1;

main() {
  character\clientscripts\c_usa_gov_presstaff1::main();
  self._aitype = "Hero_Johnson_LA";
}

precache(ai_index) {
  character\clientscripts\c_usa_gov_presstaff1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}