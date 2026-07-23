/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_ghillie_arctic.gsc
********************************************************/

main() {
  self setModel("mp_body_op_sniper_ghillie_arctic");
  self attach("head_op_sniper_ghillie_arctic", "", true);
  self.headModel = "head_op_sniper_ghillie_arctic";
  self setViewmodel("viewhands_ghillie_arctic");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_op_sniper_ghillie_arctic");
  precacheModel("head_op_sniper_ghillie_arctic");
  precacheModel("viewhands_ghillie_arctic");
}