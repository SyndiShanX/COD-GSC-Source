/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_op_militia_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_op_militia");
  self attach("head_riot_op_militia", "", true);
  self.headModel = "head_riot_op_militia";
  self setViewmodel("viewhands_militia");
  self.voice = "portuguese";
}

precache() {
  precacheModel("mp_body_riot_op_militia");
  precacheModel("head_riot_op_militia");
  precacheModel("viewhands_militia");
}