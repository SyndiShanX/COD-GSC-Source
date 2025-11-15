/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_sco_haiti_lmg_base.csc
*******************************************************************/

#include character\clientscripts\c_chn_pla_assault;

main() {
  character\clientscripts\c_chn_pla_assault::main();
  self._aitype = "Ally_SCO_Haiti_LMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_chn_pla_assault::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}