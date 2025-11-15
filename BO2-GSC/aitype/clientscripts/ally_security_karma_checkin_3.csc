/*******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_security_karma_checkin_3.csc
*******************************************************************************/

#include character\clientscripts\c_mul_jinan_guard_3;

main() {
  character\clientscripts\c_mul_jinan_guard_3::main();
  self._aitype = "Ally_Security_Karma_Checkin_3";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_guard_3::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}