/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_udt_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_udt");
  self attach("head_riot_udt", "", true);
  self.headModel = "head_riot_udt";
  self setViewmodel("viewhands_udt");
  self.voice = "seal";
}

precache() {
  precacheModel("mp_body_riot_udt");
  precacheModel("head_riot_udt");
  precacheModel("viewhands_udt");
}