/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_sas_urban_sniper.gsc
*******************************************************/

main() {
  self setModel("body_mp_sas_urban_sniper");
  self setViewmodel("viewhands_black_kit");
  self.voice = "british";
}

precache() {
  precacheModel("body_mp_sas_urban_sniper");
  precacheModel("viewhands_black_kit");
}