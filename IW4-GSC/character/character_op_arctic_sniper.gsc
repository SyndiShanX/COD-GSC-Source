/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_op_arctic_sniper.gsc
********************************************************/

main() {
  self setModel("body_op_arctic_sniper");
  self attach("head_op_arctic_sniper", "", true);
  self.headModel = "head_op_arctic_sniper";
  self.voice = "russian";
}

precache() {
  precacheModel("body_op_arctic_sniper");
  precacheModel("head_op_arctic_sniper");
}