/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_digbat_assault_tackler.csc
*****************************************************************************/

#include character\clientscripts\c_pan_dingbats_hero;

main() {
  character\clientscripts\c_pan_dingbats_hero::main();
  self._aitype = "Enemy_Digbat_Assault_Tackler";
}

precache(ai_index) {
  character\clientscripts\c_pan_dingbats_hero::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}