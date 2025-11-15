/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pdf_assault_base.csc
*****************************************************************/

#include character\clientscripts\c_pan_pdf_heavy_panama_char;
#include character\clientscripts\c_pan_pdf_medium_panama_char;
#include character\clientscripts\c_pan_pdf_light_panama_char;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_pan_pdf_heavy_panama_char::main();
      break;
    case 1:
      character\clientscripts\c_pan_pdf_medium_panama_char::main();
      break;
    case 2:
      character\clientscripts\c_pan_pdf_light_panama_char::main();
      break;
  }

  self._aitype = "Enemy_PDF_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_pan_pdf_heavy_panama_char::precache();
  character\clientscripts\c_pan_pdf_medium_panama_char::precache();
  character\clientscripts\c_pan_pdf_light_panama_char::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}