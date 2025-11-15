/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\so_enemy_bigdog.csc
****************************************************/

#include character\clientscripts\c_t6_claw_mk2_enemy;

main() {
  character\clientscripts\c_t6_claw_mk2_enemy::main();
  self._aitype = "So_Enemy_Bigdog";
}

precache(ai_index) {
  character\clientscripts\c_t6_claw_mk2_enemy::precache();
  usefootsteptable(ai_index, "default_ai");
  scriptcallbackonfootstepevent(ai_index);
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}