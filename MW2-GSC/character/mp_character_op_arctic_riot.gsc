/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_arctic_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_op_arctic");
  self attach("head_riot_op_arctic", "", true);
  self.headModel = "head_riot_op_arctic";
  self setViewmodel("viewhands_arctic_opforce");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_riot_op_arctic");
  precacheModel("head_riot_op_arctic");
  precacheModel("viewhands_arctic_opforce");
}