/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_yemen_sniper_base.csc
***************************************************************************/

#include character\clientscripts\c_usa_seal6;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_usa_seal6::main();
      break;
    case 1:
      character\clientscripts\c_usa_seal6::main();
      break;
  }

  self._aitype = "Ally_SEAL_Yemen_Sniper_Base";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal6::precache();
  character\clientscripts\c_usa_seal6::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}