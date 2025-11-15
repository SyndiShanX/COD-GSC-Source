/***************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_terrorist_yemen_assault_hug.csc
***************************************************************************************/

#include character\clientscripts\c_mul_cordis2_1;

main() {
  character\clientscripts\c_mul_cordis2_1::main();
  self._aitype = "Enemy_Terrorist_Yemen_Assault_Hug";
}

precache(ai_index) {
  character\clientscripts\c_mul_cordis2_1::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}