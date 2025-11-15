/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_sstactical_assault_base.csc
*****************************************************************************/

#include character\clientscripts\c_usa_secserv_light;
#include character\clientscripts\c_usa_secserv_medium;
#include character\clientscripts\c_usa_secserv_heavy;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_usa_secserv_light::main();
      break;
    case 1:
      character\clientscripts\c_usa_secserv_medium::main();
      break;
    case 2:
      character\clientscripts\c_usa_secserv_heavy::main();
      break;
  }

  self._aitype = "Ally_SStactical_Assault_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_secserv_light::precache();
  character\clientscripts\c_usa_secserv_medium::precache();
  character\clientscripts\c_usa_secserv_heavy::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}