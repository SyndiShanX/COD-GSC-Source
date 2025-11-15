/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_pdf_lmg_base.csc
*******************************************************/

#include character\clientscripts\c_pan_pdf_heavy_char;
#include character\clientscripts\c_pan_pdf_medium_char;
#include character\clientscripts\c_pan_pdf_light_char;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pan_pdf_heavy_char::main();
      break;
    case 1:
      character\clientscripts\c_pan_pdf_medium_char::main();
      break;
    case 2:
      character\clientscripts\c_pan_pdf_light_char::main();
      break;
  }

  self._aitype = "Ally_PDF_LMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_pan_pdf_heavy_char::precache();
  character\clientscripts\c_pan_pdf_medium_char::precache();
  character\clientscripts\c_pan_pdf_light_char::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}