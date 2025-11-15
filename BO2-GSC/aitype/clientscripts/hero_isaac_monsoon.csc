/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_isaac_monsoon.csc
*********************************************************/

#include character\clientscripts\c_mul_scientist_issac;

main() {
  character\clientscripts\c_mul_scientist_issac::main();
  self._aitype = "Hero_Isaac_Monsoon";
}

precache(ai_index) {
  character\clientscripts\c_mul_scientist_issac::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}