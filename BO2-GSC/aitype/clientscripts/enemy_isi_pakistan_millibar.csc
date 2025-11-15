/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_isi_pakistan_millibar.csc
***************************************************************************/

#include character\clientscripts\c_pak_isi_1_char_wet_millibar;
#include character\clientscripts\c_pak_isi_2_char_wet_millibar;
#include character\clientscripts\c_pak_isi_3_char_wet_millibar;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pak_isi_1_char_wet_millibar::main();
      break;
    case 1:
      character\clientscripts\c_pak_isi_2_char_wet_millibar::main();
      break;
    case 2:
      character\clientscripts\c_pak_isi_3_char_wet_millibar::main();
      break;
  }

  self._aitype = "Enemy_ISI_Pakistan_Millibar";
}

precache(ai_index) {
  character\clientscripts\c_pak_isi_1_char_wet_millibar::precache();
  character\clientscripts\c_pak_isi_2_char_wet_millibar::precache();
  character\clientscripts\c_pak_isi_3_char_wet_millibar::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}