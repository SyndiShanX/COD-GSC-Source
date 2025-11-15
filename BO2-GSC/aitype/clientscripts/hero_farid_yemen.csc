/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_farid_yemen.csc
*****************************************************/

#include character\clientscripts\c_mul_farid_yemen;

main() {
  character\clientscripts\c_mul_farid_yemen::main();
  self._aitype = "Hero_Farid_Yemen";
}

precache(ai_index) {
  character\clientscripts\c_mul_farid_yemen::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}