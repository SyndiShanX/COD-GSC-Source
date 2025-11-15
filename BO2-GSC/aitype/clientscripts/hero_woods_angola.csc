/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_woods_angola.csc
*******************************************************/

#include character\clientscripts\c_usa_angola_woods;

main() {
  character\clientscripts\c_usa_angola_woods::main();
  self._aitype = "Hero_Woods_Angola";
}

precache(ai_index) {
  character\clientscripts\c_usa_angola_woods::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}