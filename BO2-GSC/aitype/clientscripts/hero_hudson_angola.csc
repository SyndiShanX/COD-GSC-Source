/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\hero_hudson_angola.csc
*********************************************************/

#include character\clientscripts\c_usa_angola_hudson;

main() {
  character\clientscripts\c_usa_angola_hudson::main();
  self._aitype = "Hero_Hudson_Angola";
}

precache(ai_index) {
  character\clientscripts\c_usa_angola_hudson::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}