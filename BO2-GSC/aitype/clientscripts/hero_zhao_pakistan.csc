/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_zhao_pakistan.csc
*********************************************************/

#include character\clientscripts\c_chn_oldgeneral_zhao;

main() {
  character\clientscripts\c_chn_oldgeneral_zhao::main();
  self._aitype = "Hero_Zhao_Pakistan";
}

precache(ai_index) {
  character\clientscripts\c_chn_oldgeneral_zhao::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}