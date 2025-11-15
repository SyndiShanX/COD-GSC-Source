/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_ghillie_desert.gsc
********************************************************/

main() {
  self setModel("mp_body_op_sniper_ghillie_desert");
  self attach("head_op_sniper_ghillie_desert", "", true);
  self.headModel = "head_op_sniper_ghillie_desert";
  self setViewmodel("viewhands_ghillie_desert");
  self.voice = "arab";
}

precache() {
  precacheModel("mp_body_op_sniper_ghillie_desert");
  precacheModel("head_op_sniper_ghillie_desert");
  precacheModel("viewhands_ghillie_desert");
}