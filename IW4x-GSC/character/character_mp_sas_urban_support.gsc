/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_sas_urban_support.gsc
********************************************************/

main() {
  self setModel("body_mp_sas_urban_support");
  self setViewmodel("viewhands_black_kit");
  self.voice = "british";
}

precache() {
  precacheModel("body_mp_sas_urban_support");
  precacheModel("viewhands_black_kit");
}