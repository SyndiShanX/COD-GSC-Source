/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_op_airborne_sniper.gsc
********************************************************/

main() {
  self setModel("body_op_airborne_sniper");
  self attach("head_op_airborne_sniper", "", true);
  self.headModel = "head_op_airborne_sniper";
  self.voice = "russian";
}

precache() {
  precacheModel("body_op_airborne_sniper");
  precacheModel("head_op_airborne_sniper");
}