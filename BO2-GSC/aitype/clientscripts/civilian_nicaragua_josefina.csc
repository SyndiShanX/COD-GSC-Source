/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\civilian_nicaragua_josefina.csc
***************************************************************************/

#include character\clientscripts\c_mul_josefina_scrd;

main() {
  character\clientscripts\c_mul_josefina_scrd::main();
  self._aitype = "Civilian_Nicaragua_Josefina";
}

precache(ai_index) {
  character\clientscripts\c_mul_josefina_scrd::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}