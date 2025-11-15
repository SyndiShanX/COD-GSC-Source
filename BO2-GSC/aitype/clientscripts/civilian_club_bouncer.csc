/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_bouncer.csc
***************************************************************/

#include character\clientscripts\c_mul_jinan_bouncer;

main() {
  character\clientscripts\c_mul_jinan_bouncer::main();
  self._aitype = "Civilian_Club_Bouncer";
}

precache(ai_index) {
  character\clientscripts\c_mul_jinan_bouncer::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}