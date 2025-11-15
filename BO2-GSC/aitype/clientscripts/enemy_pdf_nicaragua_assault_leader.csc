/*****************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_pdf_nicaragua_assault_leader.csc
*****************************************************************************************/

#include character\clientscripts\c_pan_pdf_intro_leader;

main() {
  character\clientscripts\c_pan_pdf_intro_leader::main();
  self._aitype = "Enemy_PDF_Nicaragua_Assault_Leader";
}

precache(ai_index) {
  character\clientscripts\c_pan_pdf_intro_leader::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}