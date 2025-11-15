/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_ghillie_urban.gsc
********************************************************/

main() {
  self setModel("mp_body_op_sniper_ghillie_urban");
  self attach("head_op_sniper_ghillie_urban", "", true);
  self.headModel = "head_op_sniper_ghillie_urban";
  self setViewmodel("viewhands_ghillie_urban");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_op_sniper_ghillie_urban");
  precacheModel("head_op_sniper_ghillie_urban");
  precacheModel("viewhands_ghillie_urban");
}