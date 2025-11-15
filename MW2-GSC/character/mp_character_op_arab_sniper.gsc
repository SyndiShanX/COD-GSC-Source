/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_arab_sniper.gsc
********************************************************/

main() {
  self setModel("mp_body_op_arab_sniper");
  self attach("head_op_arab_sniper", "", true);
  self.headModel = "head_op_arab_sniper";
  self setViewmodel("viewhands_sniper_op_arab");
  self.voice = "arab";
}

precache() {
  precacheModel("mp_body_op_arab_sniper");
  precacheModel("head_op_arab_sniper");
  precacheModel("viewhands_sniper_op_arab");
}