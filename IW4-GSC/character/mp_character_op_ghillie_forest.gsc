/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_ghillie_forest.gsc
********************************************************/

main() {
  self setModel("mp_body_op_sniper_ghillie_forest");
  self attach("head_op_sniper_ghillie_forest", "", true);
  self.headModel = "head_op_sniper_ghillie_forest";
  self setViewmodel("viewhands_ghillie_forest");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_op_sniper_ghillie_forest");
  precacheModel("head_op_sniper_ghillie_forest");
  precacheModel("viewhands_ghillie_forest");
}