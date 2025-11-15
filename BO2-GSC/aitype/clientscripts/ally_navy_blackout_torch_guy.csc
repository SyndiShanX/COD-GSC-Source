/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_navy_blackout_torch_guy.csc
*****************************************************************************/

#include character\clientscripts\c_usa_navy_1_goggles;

main() {
  character\clientscripts\c_usa_navy_1_goggles::main();
  self._aitype = "Ally_Navy_Blackout_Torch_Guy";
}

precache(ai_index) {
  character\clientscripts\c_usa_navy_1_goggles::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}