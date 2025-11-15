/*****************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pdf_nicaragua_assault_intro3.csc
*****************************************************************************************/

#include character\clientscripts\c_pan_pdf_medium;

main() {
  character\clientscripts\c_pan_pdf_medium::main();
  self._aitype = "Enemy_PDF_Nicaragua_Assault_Intro3";
}

precache(ai_index) {
  character\clientscripts\c_pan_pdf_medium::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}