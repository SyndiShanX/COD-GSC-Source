/***************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_security_karma_scanner_guard.csc
***************************************************************************************/

#include character\clientscripts\c_mul_jinan_guard_bscatter_off;

main() {
  character\clientscripts\c_mul_jinan_guard_bscatter_off::main();
  self._aitype = "Ally_Security_Karma_Scanner_Guard";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_guard_bscatter_off::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}