/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_seal_haiti_wingsuit.csc
*********************************************************************/

#include character\clientscripts\c_usa_seal6_wingsuit_helm;

main() {
  character\clientscripts\c_usa_seal6_wingsuit_helm::main();
  self._aitype = "Ally_SEAL_Haiti_Wingsuit";
}

precache(ai_index) {
  character\clientscripts\c_usa_seal6_wingsuit_helm::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}