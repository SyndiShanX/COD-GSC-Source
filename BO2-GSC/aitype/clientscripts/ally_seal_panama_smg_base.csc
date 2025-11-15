/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_panama_smg_base.csc
***********************************************************************/

#include character\clientscripts\c_usa_seal80s_heavy;
#include character\clientscripts\c_usa_seal80s_medium;
#include character\clientscripts\c_usa_seal80s_light;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_usa_seal80s_heavy::main();
      break;
    case 1:
      character\clientscripts\c_usa_seal80s_medium::main();
      break;
    case 2:
      character\clientscripts\c_usa_seal80s_light::main();
      break;
  }

  self._aitype = "Ally_SEAL_Panama_SMG_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal80s_heavy::precache();
  character\clientscripts\c_usa_seal80s_medium::precache();
  character\clientscripts\c_usa_seal80s_light::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}