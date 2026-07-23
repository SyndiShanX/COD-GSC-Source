/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_seal_udt_sniper.gsc
********************************************************/

main() {
  self setModel("mp_body_seal_udt_sniper");
  self attach("head_allies_seal_udt_sniper", "", true);
  self.headModel = "head_allies_seal_udt_sniper";
  self setViewmodel("viewhands_sniper_udt");
  self.voice = "seal";
}

precache() {
  precacheModel("mp_body_seal_udt_sniper");
  precacheModel("head_allies_seal_udt_sniper");
  precacheModel("viewhands_sniper_udt");
}