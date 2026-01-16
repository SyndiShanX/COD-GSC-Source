/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_sas_woodland_mac.gsc
*******************************************************/

main() {
  self setmodel("body_sp_sas_woodland_assault_b");
  self attach("head_sp_sas_woodland_mac", "", 1);
  self.headmodel = "head_sp_sas_woodland_mac";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_sas_woodland_assault_b");
  precachemodel("head_sp_sas_woodland_mac");
}