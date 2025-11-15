/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_isi_pakistan_smg_base.csc
***************************************************************************/

#include character\clientscripts\c_pak_isi_1_char_wet;
#include character\clientscripts\c_pak_isi_2_char_wet;
#include character\clientscripts\c_pak_isi_3_char_wet;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pak_isi_1_char_wet::main();
      break;
    case 1:
      character\clientscripts\c_pak_isi_2_char_wet::main();
      break;
    case 2:
      character\clientscripts\c_pak_isi_3_char_wet::main();
      break;
  }

  self._aitype = "Enemy_ISI_Pakistan_SMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_pak_isi_1_char_wet::precache();
  character\clientscripts\c_pak_isi_2_char_wet::precache();
  character\clientscripts\c_pak_isi_3_char_wet::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}