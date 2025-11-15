/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_bouncer_1.csc
*******************************************************************/

#include character\clientscripts\c_mul_jinan_bouncer_a;

main() {
  character\clientscripts\c_mul_jinan_bouncer_a::main();
  self._aitype = "Civilian_Club_Bouncer_1";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_bouncer_a::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}