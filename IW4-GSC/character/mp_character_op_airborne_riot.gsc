/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_airborne_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_op_airborne");
  self attach("head_riot_op_airborne", "", true);
  self.headModel = "head_riot_op_airborne";
  self setViewmodel("viewhands_russian_airborne");
  self.voice = "seal";
}

precache() {
  precacheModel("mp_body_riot_op_airborne");
  precacheModel("head_riot_op_airborne");
  precacheModel("viewhands_russian_airborne");
}