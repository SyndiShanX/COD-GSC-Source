/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_jane_panama_silhouette.csc
***************************************************************************/

#include character\clientscripts\c_mul_civ_club_skirt_pants_sil_model;

main() {
  character\clientscripts\c_mul_civ_club_skirt_pants_sil_model::main();
  self._aitype = "Hero_Jane_Panama_Silhouette";
}

precache(ai_index) {
  character\clientscripts\c_mul_civ_club_skirt_pants_sil_model::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}