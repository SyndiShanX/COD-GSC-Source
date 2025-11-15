/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_haiti_boobytrap.csc
***********************************************************************/

#include character\clientscripts\c_usa_seal6_booby_trap_body;

main() {
  character\clientscripts\c_usa_seal6_booby_trap_body::main();
  self._aitype = "Ally_SEAL_Haiti_BoobyTrap";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal6_booby_trap_body::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}