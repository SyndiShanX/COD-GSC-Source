/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_mason_panama_captured.csc
*************************************************************************/

#include character\clientscripts\c_usa_captured_mason_dead;

main() {
  character\clientscripts\c_usa_captured_mason_dead::main();
  self._aitype = "Hero_Mason_Panama_Captured";
}

precache(ai_index) {
  character\clientscripts\c_usa_captured_mason_dead::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}