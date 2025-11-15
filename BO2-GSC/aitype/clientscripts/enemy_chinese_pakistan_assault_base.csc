/*******************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_chinese_pakistan_assault_base.csc
*******************************************************************************************/

#include character\clientscripts\c_chn_pla_nogib;

main() {
  character\clientscripts\c_chn_pla_nogib::main();
  self._aitype = "Enemy_Chinese_Pakistan_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_chn_pla_nogib::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}