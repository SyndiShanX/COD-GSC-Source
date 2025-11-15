/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_club_shadow_dancer.csc
***************************************************************************/

#include character\clientscripts\c_mul_civ_generic_female_sil;

main() {
  character\clientscripts\c_mul_civ_generic_female_sil::main();
  self._aitype = "Civilian_Club_Shadow_Dancer";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_generic_female_sil::precache();
  usefootsteptable(ai_index, "fly_step_civf");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}