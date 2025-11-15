/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\so_ally_bigdog.csc
***************************************************/

#include character\clientscripts\c_t6_claw_mk2;

main() {
  character\clientscripts\c_t6_claw_mk2::main();
  self._aitype = "So_Ally_Bigdog";
}

precache(ai_index) {
  character\clientscripts\c_t6_claw_mk2::precache();
  usefootsteptable(ai_index, "default_ai");
  scriptcallbackonfootstepevent(ai_index);
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}