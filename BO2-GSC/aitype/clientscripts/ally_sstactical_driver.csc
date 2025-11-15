/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_sstactical_driver.csc
*****************************************************************/

#include character\clientscripts\c_usa_secserv_driver;

main() {
  character\clientscripts\c_usa_secserv_driver::main();
  self._aitype = "Ally_SStactical_Driver";
}

precache(ai_index) {
  character\clientscripts\c_usa_secserv_driver::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}