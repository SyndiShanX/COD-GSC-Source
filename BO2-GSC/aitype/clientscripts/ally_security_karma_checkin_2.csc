/*******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_security_karma_checkin_2.csc
*******************************************************************************/

#include character\clientscripts\c_mul_jinan_guard_2;

main() {
  character\clientscripts\c_mul_jinan_guard_2::main();
  self._aitype = "Ally_Security_Karma_Checkin_2";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_guard_2::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}