/***********************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_isi_pakistan_assault_nobackpack.csc
***********************************************************************************************/

#include character\clientscripts\c_pak_isi_1_char_wet;

main() {
  character\clientscripts\c_pak_isi_1_char_wet::main();
  self._aitype = "Enemy_ISI_Pakistan_Assault_NoBackPack";
}

precache(ai_index) {
  character\clientscripts\c_pak_isi_1_char_wet::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}