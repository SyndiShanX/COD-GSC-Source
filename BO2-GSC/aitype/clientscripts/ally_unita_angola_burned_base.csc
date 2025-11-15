/*******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_unita_angola_burned_base.csc
*******************************************************************************/

#include character\clientscripts\c_afr_unitas_2_burned;

main() {
  character\clientscripts\c_afr_unitas_2_burned::main();
  self._aitype = "Ally_UNITA_Angola_Burned_Base";
}

precache(ai_index) {
  character\clientscripts\c_afr_unitas_2_burned::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}