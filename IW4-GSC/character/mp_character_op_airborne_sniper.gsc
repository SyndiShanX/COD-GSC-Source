/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_airborne_sniper.gsc
*********************************************************/

main() {
  self setModel("mp_body_op_airborne_sniper");
  self attach("head_op_airborne_sniper", "", true);
  self.headModel = "head_op_airborne_sniper";
  self setViewmodel("viewhands_sniper_op_airborne");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_op_airborne_sniper");
  precacheModel("head_op_airborne_sniper");
  precacheModel("viewhands_sniper_op_airborne");
}