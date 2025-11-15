/***********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_security_karma_pistol_base.csc
***********************************************************************************/

#include character\clientscripts\c_mul_jinan_guard;

main() {
  character\clientscripts\c_mul_jinan_guard::main();
  self._aitype = "Ally_Security_Karma_Pistol_Base";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_guard::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}