/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\so_ally_pistol_base_karma.csc
***********************************************************************/

#include character\clientscripts\c_usa_chloe_strikef;

main() {
  character\clientscripts\c_usa_chloe_strikef::main();
  self._aitype = "So_Ally_Pistol_Base_karma";
}

precache(ai_index) {
  character\clientscripts\c_usa_chloe_strikef::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}