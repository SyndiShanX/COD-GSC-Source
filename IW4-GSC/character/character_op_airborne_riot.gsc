/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_op_airborne_riot.gsc
********************************************************/

main() {
  self setModel("body_riot_op_airborne");
  self attach("head_riot_op_airborne", "", true);
  self.headModel = "head_riot_op_airborne";
  self.voice = "russian";
}

precache() {
  precacheModel("body_riot_op_airborne");
  precacheModel("head_riot_op_airborne");
}