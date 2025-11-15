/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_briggs_blackout.csc
*************************************************************/

#include character\clientscripts\c_usa_cc_briggs;

main() {
  character\clientscripts\c_usa_cc_briggs::main();
  self._aitype = "Hero_Briggs_Blackout";
}

precache(ai_index) {
  character\clientscripts\c_usa_cc_briggs::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}