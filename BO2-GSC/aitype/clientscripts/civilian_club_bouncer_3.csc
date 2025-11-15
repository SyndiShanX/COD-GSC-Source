/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_bouncer_3.csc
*******************************************************************/

#include character\clientscripts\c_mul_jinan_bouncer_c;

main() {
  character\clientscripts\c_mul_jinan_bouncer_c::main();
  self._aitype = "Civilian_Club_Bouncer_3";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_bouncer_c::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}